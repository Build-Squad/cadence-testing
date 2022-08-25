import HelloWorld from "./contracts/hello_contract.cdc"
import Math from "./contracts/math.cdc"

pub contract TestProxy {

    init() {}

    pub fun hello(): String {
        return HelloWorld.hello()
    }

    pub fun add(_ a: Int, _ b: Int): Int {
        return Math.add(a, b)
    }
}
