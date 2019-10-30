# http://clarkgrubb.com/makefile-style-guide

MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.DELETE_ON_ERROR:
.SUFFIXES:


.PHONY: help
help:
	@echo "Available make targets:"
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

.PHONY: README.md
README.md: ## Updates README.md using terraform-docs
	@echo "Removing everything from the Inputs section onwards"
	printf '%s\n' "`awk '/## Inputs/{exit}1' README.md`" > README.tmp
	@echo "Adding terraform-docs generated Inputs and Outputs to the end of README.md"
	printf '\n%s\n' "`terraform-docs md .`" >> README.tmp
	mv README.tmp README.md

.PHONY: tests
tests: ## Runs tests against the policy-condenser.py part of the module
	@if ! python -c "import pytest" &>/dev/null; then echo "The tests require pytest. Please install pytest and re run."; exit 1; fi
	@if ! python -c "import python_terraform" &>/dev/null; then echo "The tests require python-terraform. Please install python-terraform and re run."; exit 1; fi
	@cd tests/python && pytest -v