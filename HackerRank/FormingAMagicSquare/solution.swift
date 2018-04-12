import Foundation

var grid: [[Int]] = {
    let row1 = readLine()!.split(separator: " ").map{Int($0)!}
    let row2 = readLine()!.split(separator: " ").map{Int($0)!}
    let row3 = readLine()!.split(separator: " ").map{Int($0)!}
    return [row1, row2, row3]
}()

let ps =   [[[8, 1, 6], [3, 5, 7], [4, 9, 2]],
            [[6, 1, 8], [7, 5, 3], [2, 9, 4]],
            [[4, 9, 2], [3, 5, 7], [8, 1, 6]],
            [[2, 9, 4], [7, 5, 3], [6, 1, 8]], 
            [[8, 3, 4], [1, 5, 9], [6, 7, 2]],
            [[4, 3, 8], [9, 5, 1], [2, 7, 6]], 
            [[6, 7, 2], [1, 5, 9], [8, 3, 4]], 
            [[2, 7, 6], [9, 5, 1], [4, 3, 8]]]
            
var best = 0
var lowestCost = Int.max
for (index, square) in ps.enumerated() {
    var thisCost = 0
    for row in 0..<3 {
        for col in 0..<3 {
            thisCost += abs(grid[row][col] - square[row][col])
        }
    }
    if (thisCost < lowestCost) {
        best = index
        lowestCost = thisCost
    }
}

print(lowestCost)
