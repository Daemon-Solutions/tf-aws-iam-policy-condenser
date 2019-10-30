#!/usr/bin/env python3
import os
import os.path
import pytest
import subprocess

test_dir = os.path.normpath(
    os.path.join(os.path.realpath(__file__), "..", "..", "terraform")
)


def test_terraform():

    terraform_init_proc = subprocess.run(
        ["terraform", "init", "-no-color"], cwd=test_dir, capture_output=True
    )
    assert terraform_init_proc.returncode == 0

    terraform_plan_proc = subprocess.run(
        ["terraform", "plan", "-refresh", "-no-color", "-detailed-exitcode"],
        cwd=test_dir,
        capture_output=True,
    )
    assert terraform_plan_proc.returncode == 0 or terraform_plan_proc.returncode == 2
    assert terraform_plan_proc.stdout == b""

    # terraform_apply_proc = subprocess.run(
    #     ["terraform", "apply", "-no-color", "-auto-apply", "."],
    #     cwd=test_dir,
    #     capture_output=False,
    # )
    # assert terraform_apply_proc.returncode == 0

    # terraform_destroy_plan_proc = subprocess.run(
    #     ["terraform", "plan", "-no-color", "-detailed-exitcode", "-destroy"],
    #     cwd=test_dir,
    #     capture_output=True,
    # )
    # assert terraform_destroy_plan_proc.returncode == 2

    # terraform_apply_proc = subprocess.run(
    #     ["terraform", "apply", "-no-color", "-auto-apply", "."],
    #     cwd=test_dir,
    #     capture_output=True,
    # )
    # assert terraform_destroy_plan_proc.returncode == 0


if __name__ == "__main__":
    print(test_dir)
