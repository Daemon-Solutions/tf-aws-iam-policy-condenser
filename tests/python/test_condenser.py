#!/usr/bin/env python3
import json
import os
import os.path
import pytest
import subprocess
import base64


def test_condenser():
    condenser_script_path = os.path.normpath(
        os.path.join(
            os.path.dirname(os.path.realpath(__file__)), "..", "..", "policy_condenser.py"
        )
    )

    # Note the test input JSON has a deliberately small policy size limit
    # to ensure that the policy has to be split several times for testing
    # purposes.
    with open("./test_input.json", "rb") as test_input_json:
        condenser_proc = subprocess.run(
            [condenser_script_path], stdin=test_input_json, capture_output=True
        )

    # check the process exited cleanly
    assert condenser_proc.returncode == 0

    condenser_output = json.loads(condenser_proc.stdout)

    assert "b64_policies" in condenser_output

    assert "policy_count" in condenser_output
    assert type(condenser_output["policy_count"]) == str
    assert condenser_output["policy_count"] == "3"

    b64_policy_list = condenser_output["b64_policies"].split(",")

    assert len(b64_policy_list) == 3

    for b64_policy in b64_policy_list:
        policy = json.loads(base64.b64decode(b64_policy))
        assert type(policy) == dict
