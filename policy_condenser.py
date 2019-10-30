#!/usr/bin/env python3
import argparse
import base64
import json
import pdb
import sys

from collections import deque


def get_input_statement_list(input_query):
    """
    Takes the Terraform query as input
    Returns a list of all the statements from the input policies.
    """
    input_statements = []
    for input_policy in json.loads(input_query["input_policies"]):
        for input_policy_statement in json.loads(input_policy)["Statement"]:
            input_statements.append(input_policy_statement)
    return input_statements


def create_new_policy(policy_version):
    """
    Takes a IAM policy version string as input e.g. "2012-10-17".
    Returns a new AWS IAM policy dict of the specified version.
    """
    new_policy = {"Version": policy_version, "Statement": []}

    return new_policy


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--debug",
        "-d",
        help="Debug mode, reads specified file as input as it would normally with stdin input.",
    )
    parser.add_argument(
        "--log", "-l", help="Logs input JSON to the specified file"
    )

    args = parser.parse_args()

    if args.log:
        query = json.load(sys.stdin)
        with open(args.log, "w") as terraformQuery:
            json.dump(query, terraformQuery)
    elif args.debug:
        with open(args.debug, "rb") as terraformQuery:
            query = json.load(terraformQuery)
    else:
        query = json.load(sys.stdin)

    # Create a list of policies with as many statements in each policy
    # as the policy length limit will allow. This is a naive implementation;
    # it's just going in sequence rather than performing bin packing logic.
    policies = []
    policy_length_limit = int(query["policy_length_limit"])
    statements = deque(get_input_statement_list(query))

    while statements:
        # Create a new policy and add it to the list.
        policies.append(create_new_policy(query["policy_version"]))

        # Add as many statements to this policy as possible,
        # or until there are no more statements left.
        while statements:
            # Move a statement out of the queue and into the policy.
            policies[-1]["Statement"].append(statements.popleft())

            # Check if the policy has become too big
            # now that it includes this statement.
            if len(json.dumps(policies[-1])) >= policy_length_limit:
                # Check if this is the only statement in the policy.
                # If that is the case then the statement itself is too big.
                if len(policies[-1]["Statement"]) == 1:
                    raise ValueError(
                        "Statement exceeds policy length limit (Length: {Length} + Policy boilerplate, Limit: {Limit})): {Policy}".format(
                            Length=len(json.dumps(policies[-1])),
                            Limit=policy_length_limit,
                            Policy=json.dumps(policies[-1]["Statement"][0]),
                        )
                    )

                # Move the statement back out of the policy
                # and onto the queue for the next policy.
                statements.appendleft(policies[-1]["Statement"].pop())

                # Break here so a new policy can be created.
                break

    # Output the list of policies to Terraform (base64 encoded because
    # terraform can't handle anything but strings being returned from external
    # datasources)
    output = {"b64_policies": ""}

    for policy in policies:
        if output["b64_policies"] == "":
            output["b64_policies"] += "{}".format(
                base64.b64encode(json.dumps(policy).encode()).decode()
            )
        else:
            output["b64_policies"] += ",{}".format(
                base64.b64encode(json.dumps(policy).encode()).decode()
            )

    json.dump(output, sys.stdout, indent=2)
    sys.stdout.write("\n")
