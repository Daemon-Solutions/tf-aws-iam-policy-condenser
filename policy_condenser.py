#!/usr/bin/env python3
import argparse
import base64
import json
import sys
import pdb

def get_input_statement_list(input_query):
    """
    Takes the Terraform query as input
    Returns a list of all the statements from the input policies.
    """
    input_statements = []
    for input_policy in json.loads(input_query['input_policies']):
        for input_policy_statement in json.loads(input_policy)['Statement']:
            input_statements.append(input_policy_statement)
    return input_statements


def create_new_policy(policy_version):
    """
    Takes a IAM policy version string as input e.g. "2012-10-17".
    Returns a new AWS IAM policy dict of the specified version.
    """
    new_policy = {
        'Version': policy_version,
        'Statement': []
    }

    return new_policy


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--debug',
        '-d',
        help="Debug mode, reads log generated as log as input.",
        action='store_true'
    )
    parser.add_argument(
        '--log',
        '-l',
        help="Log input to terraformQuery.json",
        action='store_true'
    )
    args = parser.parse_args()


    if args.log:
        query = json.load(sys.stdin)
        with open('terraformQuery.json', 'w') as terraformQuery:
            json.dump(query, terraformQuery)
    elif args.debug:
        with open('terraformQuery.json', 'rb') as terraformQuery:
            query = json.load(terraformQuery)
    else:
        query = json.load(sys.stdin)

    policies = []
    statements = get_input_statement_list(query)

    policy = create_new_policy(query['policy_version'])
    policy_length_limit = int(query['policy_length_limit'])

    # try to create as few policies as possible from the input policies
    # without breaking the policy character limit.
    for statement in statements:
        policy['Statement'].append(statement)
        if len(json.dumps(policy)) >= policy_length_limit:
            policy['Statement'].pop(-1)
            policies.append(json.dumps(policy))
            policy = create_new_policy(query['policy_version'])
            policy['Statement'].append(statement)

    policies.append(json.dumps(policy))

    # Output the list of policies to Terraform (base64 encoded because
    # terraform can't handle anything but strings being returned from external
    # datasources)
    output = {
        'policies': ""
    }

    for policy in policies:
        if output['policies'] == "":
            output['policies'] += "{}".format(base64.b64encode(policy.encode()).decode())
        else:
            output['policies'] += ",{}".format(base64.b64encode(policy.encode()).decode())

    json.dump(output, sys.stdout, indent=2)
    sys.stdout.write('\n')
