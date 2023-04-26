# Cadence Testing Framework

## Requirements

Make sure that you have installed the minimum required version of `flow-cli`:

```bash
flow version

Version: v1.0.1
Commit: 6a954b22d83b1caaf20bd27b02062dde92516eb1
```

To install the latest version, run:

```bash
sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
```

## Running Tests

To run tests, go to the `sample_1` directory and use the `flow test` command:

```bash
cd sample_1

flow test --cover tests/*.cdc
```

The latest command, will run all the test cases under the `tests` directory.

The output will look something like this:

```bash
Test results: "tests/intergration_test_advanced.cdc"
- PASS: testDeployingContractWithImports
Test results: "tests/intergration_test_simple.cdc"
- PASS: testSimpleScript
- PASS: testSimpleTransaction
- PASS: testInvokingContractFunction
Test results: "tests/unit_tests.cdc"
- FAIL: testAssertionFailure
		Execution failed:
			error: assertion failed: manually failed the test case
			  --> 7465737400000000000000000000000000000000000000000000000000000000:15:4
			
- PASS: testImportingContract
- PASS: testReadingFile
Coverage: 41.9% of statements
```

To get more information regarding code coverage, view the contents of the `coverage.json` auto-generated file.
