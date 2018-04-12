import Foundation

let _ = readLine()
let highScores: [(Int, Int)] = {
    var scores = readLine()!.split(separator: " ").map{(0, Int($0)!)}
    for i in 0..<scores.count {
        if (i == 0) { scores[i].0 = 1 }
        else if (scores[i].1 < scores[i-1].1) {
            scores[i].0 = scores[i-1].0 + 1
        } else {
            scores[i].0 = scores[i-1].0
        }
    }
    return scores
}()
let _ = readLine()
let alice = readLine()!.split(separator: " ").map{Int($0)!}

var i = highScores.count - 1
var j = 0
while (i >= 0 && j < alice.count) {
    let aScore = alice[j]
    let currentPlace = highScores[i].0
    let currentScore = highScores[i].1
    
    if (aScore < currentScore) {
        print(currentPlace+1)
        j += 1
    } else if (currentPlace == 1) {
        print(1)
        j += 1
    } else { i -= 1 }
}
