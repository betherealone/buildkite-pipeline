SHELL := /bin/bash
$(VERBOSE).SILENT:

ACCOUNT_PATH ?= not_set

.PHONY: plan
plan:
	echo "ACCOUNT_PATH $(ACCOUNT_PATH)"
	bash $(ACCOUNT_PATH)/main.sh

.PHONY: apply
apply:
	echo "ACCOUNT_PATH $(ACCOUNT_PATH)"
	bash $(ACCOUNT_PATH)/main.sh