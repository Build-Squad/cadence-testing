pub contract HelloWorld {

    pub let greeting: String

    init(_ greeting: String) {
        self.greeting = greeting
    }

    pub fun hello(): String {
        return self.greeting
    }
}
