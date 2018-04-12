import Foundation

let _ = readLine()
let socks = NSCountedSet(array: readLine()!.split(separator: " ").map{Int($0)!})
print(socks.reduce(0, {$0 + socks.count(for: $1)/2}))
