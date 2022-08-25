import Test
import HelloWorld from "./contracts/hello_contract.cdc"

pub var blockchain = Test.newEmulatorBlockchain()

pub var testAccounts: [Test.Account] = []

// `setup` function runs before all tests.
//
pub fun setup() {
    log("setting up the tests...")

    // Create accounts in the blockchain.

    let acct1 = blockchain.createAccount()
    testAccounts.append(acct1)

    let acct2 = blockchain.createAccount()
    testAccounts.append(acct2)

    // Deploy a sample contract to the blockchain.
    deploySampleContract(blockchain)

}

// [Test case] Run a simple script against the blockchain.
//
pub fun testSimpleScript() {
    var result = blockchain.executeScript("pub fun main(): Int {  return 2 + 3 }", [])

    assert(result.status == Test.ResultStatus.succeeded)
    assert((result.returnValue! as! Int) == 5)
}

// [Test case] Run a simple transaction against the blockchain.
//
pub fun testSimpleTransaction() {
    var signer = blockchain.createAccount()

    let tx = Test.Transaction(
        code: "transaction { execute{ assert(true) } }",
        authorizers: [],
        signers: [signer],
        arguments: [],
    )

    let result = blockchain.executeTransaction(tx)
    assert(result.status == Test.ResultStatus.succeeded)
}

// [Test case] Import a contract and invoke its function.
//
pub fun testInvokingContractFunction() {
    // Import the previously deployed contarct.
    // Note: refer 'intergration_test_advanced.cdc' sample on how to use configurations
    // for import resolving, without manually doind string concat.

    var script = "import Foo from "
        .concat(testAccounts[0].address.toString())
        .concat("\npub fun main(): String {  return Foo.sayHello() }")

    let result = blockchain.executeScript(script, [])

    if result.status != Test.ResultStatus.succeeded {
        panic(result.error!.message)
    }

    let returnedStr = result.returnValue! as! String

    assert(
        returnedStr == "hello from Foo",
        message: "found: ".concat(returnedStr)
    )
}

// `tearDown` function runs after all tests.
//
pub fun tearDown() {
    log("finishing up the tests...")
}

// Utility function to deploy a sample contract.
//
pub fun deploySampleContract(_ blockchain: Test.Blockchain) {
    let contractCode = "pub contract Foo{ init(){}  pub fun sayHello(): String { return \"hello from Foo\"} }"
    let err = blockchain.deployContract(
        name: "Foo",
        code: contractCode,
        account: testAccounts[0],
        arguments: [],
    )

    if err != nil {
        panic(err!.message)
    }
}
