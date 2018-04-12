import Foundation

let minBoardDimension = 5
let maxBoardDimension = 15
let maxTileNumber = 6

func generateRandomBoard() -> [[Int]] {
	
	let dimensionX: Int = Int(arc4random_uniform(UInt32(maxBoardDimension - minBoardDimension))) + minBoardDimension + 1
	let dimensionY: Int = Int(arc4random_uniform(UInt32(maxBoardDimension - minBoardDimension))) + minBoardDimension + 1
	var arr = Array(repeating: [Int](), count: dimensionX)
	
	for index in 0..<dimensionX {
		var col = [Int]()
		for _ in 0..<dimensionY {
			col.append(Int(arc4random_uniform(UInt32(maxTileNumber))))
		}
		arr[index] = col
	}
	
	return arr	
}

extension Character {
	func unicodeValue() -> UInt32 {
		let scalar = self.unicodeScalars
		return scalar[scalar.startIndex].value
	}
}

func generateConversionTable() -> [Character] {
	let zeroCode = Character("0").unicodeValue()
	let ACode = Character("A").unicodeValue()
	let aCode = Character("a").unicodeValue()
	let integers = (0...9).map { Character(UnicodeScalar(zeroCode + $0)!) }
	let upperAlphabet = (0..<26).map { Character(UnicodeScalar(ACode + $0)!) }
	let lowerAlphabet = (0..<26).map { Character(UnicodeScalar(aCode + $0)!) }
	let extraCharacters: [Character] = ["$", "!"]
	
	return integers + upperAlphabet + lowerAlphabet + extraCharacters
}

func generateURL(fromBoard board: [[Int]]) -> String {
	let conversionTable = generateConversionTable()
	
	let moves = String(format: "%2X", 0).replacingOccurrences(of: " ", with: "0")
	let dimensions = String(format: "%1X", board.count) + String(format: "%1X", board[0].count)
	
	let rawBoardArray = board.flatMap({ $0 })
	
	var boardString = ""
	for index in stride(from: 0, to: rawBoardArray.count, by: 2) {
		let elementOne = rawBoardArray[index]
		let elementTwo = (index + 1 < rawBoardArray.count) ? rawBoardArray[index + 1] : nil
		
		let code = (elementOne << 3) + (elementTwo ?? 0)
		
		boardString += String(conversionTable[code])
	}
	
	return moves + dimensions + boardString
}


let board = generateRandomBoard()
board.forEach { (arr) in
	arr.forEach { (element) in print(element, terminator: "") }
	print()
}

print("palettegame.io/\(generateURL(fromBoard: board))")