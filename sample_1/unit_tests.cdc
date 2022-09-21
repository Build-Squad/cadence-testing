import Test
import HelloWorld from "./contracts/hello_contract.cdc"

pub var testAccounts: [Test.Account] = []

// `setup` function runs before all tests.
//
pub fun setup() {
    log("setting up the tests...")
}

// [Test case] Check test failures.
//
pub fun testAssertionFailure() {
    assert(false, message: "manually failed the test case")
}

// [Test case] Import a contract from a local file.
//
pub fun testImportingContract() {
    let greeting = "Hello, World!"
    let helloWorld = HelloWorld(greeting)

    assert(helloWorld.hello() == greeting)
}

// [Test case] Read a program source-code from a file.
//
pub fun testReadingFile() {
    let content = Test.readFile("./contracts/hello_contract.cdc")
    let prefix = content.slice(from: 0, upTo: 25)
    let expectedPrefix = "pub contract HelloWorld {"

    assert(
        prefix == expectedPrefix,
        message:
            "expected '"
            .concat(expectedPrefix)
            .concat("', but found '")
            .concat(prefix)
            .concat("'")
    )
}

// `tearDown` function runs after all tests.
//
pub fun tearDown() {
    log("finishing up the tests...")
}
