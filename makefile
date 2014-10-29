# --- configuration parameters -------------------
PUPPET:=puppet
ROOT_DIRECTORY=.
MODULE_DIRECTORY=${ROOT_DIRECTORY}/puppet/modules
modules:=${notdir ${wildcard ${MODULE_DIRECTORY}/*}}

# --- testing -------------------
.PHONY: test smoke_tests
test: smoke_tests

smoke_tests: ${foreach module, $(modules), test_module_$(module)}

test_module_%: ${wildcard ${MODULE_DIRECTORY}/%/tests/*.pp}
	@echo Testing module $*
	@tests="${wildcard ${MODULE_DIRECTORY}/$*/tests/*.pp}"; if [ -n "$${tests}" ]; then for test in $${tests}; do ${PUPPET} apply --modulepath=${MODULE_DIRECTORY} --noop $${test}; done; fi;
