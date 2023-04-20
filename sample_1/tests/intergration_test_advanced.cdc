import Test

pub var blockchain = Test.newEmulatorBlockchain()

pub var testAccounts: [Test.Account] = []

// `setup` function runs before all tests.
//
pub fun setup() {
    log("setting up the tests...")

    // Create accounts in the blockchain.
    var count = 0
    while count < 5 {
        let acct = blockchain.createAccount()
        testAccounts.append(acct)
        count = count + 1
    }

    let addresses: {String: Address} = {}
    let addressRef  = &addresses as &{String: Address}

    // Deploy 'HelloWorld'
    deployContract(
        "../contracts/hello_contract.cdc",
        "HelloWorld",
        testAccounts[0],
        ["Hello, World!"],
    )

    // Deploy 'Math'
    deployContract(
        "../contracts/math.cdc",
        "Math",
        testAccounts[1],
        [],
    )

    // Set configurations with import address mapping.
    blockchain.useConfiguration(Test.Configuration({
        "./contracts/hello_contract.cdc": testAccounts[0].address,
        "./contracts/math.cdc": testAccounts[1].address
    }))
}

// [Test case] Deploy a contract that has imports.
//
pub fun testDeployingContractWithImports() {

    let helloWorldProxy = Test.readFile("../contracts/proxy_contract.cdc")

    let err = blockchain.deployContract(
        name: "TestProxy",
        code: helloWorldProxy,
        account: testAccounts[0],
        arguments: [],
    )

    if let err = err {
        panic(err.message)
    }
}

// `tearDown` function runs after all tests.
//
pub fun tearDown() {
    log("finishing up the tests...")
}


pub fun deployContract(
    _ filePath: String,
    _ name: String,
    _ account: Test.Account,
    _ args: [AnyStruct]
) {

    let contractCode = Test.readFile(filePath)

    var err = blockchain.deployContract(
        name: name,
        code: contractCode,
        account: account,
        arguments: args,
    )

    if let err = err {
        panic(err.message)
    }
}
