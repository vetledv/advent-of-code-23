
import Foundation

struct NumPos: Hashable {
    var num = [Character]()
    var positions = Set<Pos>()
}

struct Pos: Hashable {
    var x: Int
    var y: Int
}

extension Pos {
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func neighbours() -> Set<Pos> {
        var set = Set<Pos>()
        set.insert(Pos(x - 1, y + 1))
        set.insert(Pos(x - 1, y - 1))
        set.insert(Pos(x - 1, y))
        set.insert(Pos(x + 1, y + 1))
        set.insert(Pos(x + 1, y - 1))
        set.insert(Pos(x + 1, y))
        set.insert(Pos(x, y - 1))
        set.insert(Pos(x, y + 1))
        return set
    }
}

func parse(_ input: [String]) -> (Set<NumPos>, Set<Pos>) {
    var numbers = Set<NumPos>()
    var symbols = Set<Pos>()
    var currentNumPos = NumPos()

    input.enumerated().forEach { y, el in
        el.enumerated().forEach { x, char in
            if char.isNumber {
                currentNumPos.num.append(char)
                currentNumPos.positions.formUnion(Pos(x, y).neighbours())
                return
            }
            if currentNumPos.num.isEmpty == false {
                numbers.insert(currentNumPos)
                currentNumPos = NumPos()
            }
            if char != "." {
                symbols.insert(Pos(x: x, y: y))
            }
        }
    }
    return (numbers, symbols)
}

func part1(_ input: [String]) -> Int {
    let (numbers, symbols) = parse(input)
    let filtered = numbers.filter { n in
        n.positions.intersection(symbols).isEmpty == false
    }
    return filtered.reduce(0) { res, num in
        guard let int = Int(String(num.num)) else { fatalError("Num? \(num)") }
        return res + int
    }
}

struct Day03 {
    init() {
        guard let inputString = try? loadData(03) else { fatalError() }
        self.input = inputString.components(separatedBy: "\n")
        self.partOneSum = part1(input)
    }

    var input: [String]
    var partOneSum: Int

    func printAnswers() {
        print("day03")
        print("1: \(partOneSum)")
    }
}
