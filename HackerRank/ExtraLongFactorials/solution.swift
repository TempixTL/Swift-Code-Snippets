import Foundation

func factorial(_ num: NSDecimalNumber, _ nextMultiplier: NSDecimalNumber) -> NSDecimalNumber {
    if nextMultiplier == NSDecimalNumber.zero { return num }
    else {
        return factorial(num.multiplying(by: nextMultiplier), nextMultiplier.subtracting(NSDecimalNumber.one))
    }
}

var input = NSDecimalNumber(string: readLine()!)
print(factorial(input, input.subtracting(NSDecimalNumber.one)))
