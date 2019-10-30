#!/usr/bin/env python3
import json
import os
import os.path
import pytest
import subprocess

test_dir = os.path.normpath(
    os.path.join(os.path.realpath(__file__), "..", "..", "terraform")
)


def test_terraform():
    # Check Terraform version
    terraform_version_proc = subprocess.run(
        ["terraform", "version", "-no-color"], cwd=test_dir, capture_output=True
    )

    assert str(terraform_version_proc.stdout).find('0.11.14') != -1

    # Run Terraform init
    terraform_init_proc = subprocess.run(
        ["terraform", "init", "-no-color"], cwd=test_dir, capture_output=True
    )
    assert terraform_init_proc.returncode == 0

    # Run Terraform plan and confirm there are expected changes
    terraform_plan_proc = subprocess.run(
        ["terraform", "plan", "-no-color", "-detailed-exitcode", "-out", "test.tfplan"],
        cwd=test_dir,
        capture_output=False,
    )
    assert terraform_plan_proc.returncode == 2

    # Apply the changes to create the policies in the AWS account
    terraform_apply_proc = subprocess.run(
        ["terraform", "apply", "test.tfplan"],
        cwd=test_dir,
        capture_output=False,
    )
    assert terraform_apply_proc.returncode == 0

    # Read the Terraform state file
    with open(os.path.join(test_dir, "terraform.tfstate")) as state_file:
        tfstate = json.load(state_file)

    # Check it created the correct number of policies
    for module in tfstate['modules']:
        if module["path"] == ["root"]:
            assert len(module['outputs']['policies']["value"]) == 2

    # Destroy to clean up the policies
    terraform_destroy_proc = subprocess.run(
        ["terraform", "destroy", "-no-color", "-auto-approve", "."],
        cwd=test_dir,
        capture_output=True,
    )
    assert terraform_destroy_proc.returncode == 0


if __name__ == "__main__":
    print(test_dir)
