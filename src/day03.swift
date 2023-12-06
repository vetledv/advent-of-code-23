
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

extension Array where Element == Character {
    func toInt() -> Int {
        guard let int = Int(String(self)) else { fatalError() }
        return int
    }
}

struct Day03: Day {
    static var day = 03
    var data: String

    func part1() -> Any {
        let (numbers, symbols) = parse(data) { $0 != "." }
        let filtered = numbers.filter { $0.positions.intersection(symbols).isEmpty == false }
        return filtered.reduce(0) { $0 + $1.num.toInt() }
    }

    func part2() -> Any {
        let (numbers, symbols) = parse(data) { $0 == "*" }
        let result = symbols.compactMap { s in
            let neighbours = numbers.filter { $0.positions.contains(s) }
            if neighbours.count == 2, let first = neighbours.first, let last = neighbours.dropFirst().first {
                return first.num.toInt() * last.num.toInt()
            }
            return nil
        }
        return result.reduce(0) { $0 + $1 }
    }
}

extension Day03 {
    func parse(_ input: String, symbol: (Character) -> Bool) -> (Set<NumPos>, Set<Pos>) {
        var numbers = Set<NumPos>()
        var symbols = Set<Pos>()
        var currentNumPos = NumPos()
        input.components(separatedBy: "\n").enumerated().forEach { y, line in
            line.enumerated().forEach { x, char in
                if char.isNumber {
                    currentNumPos.num.append(char)
                    currentNumPos.positions.formUnion(Pos(x, y).neighbours())
                    return
                }
                if currentNumPos.num.isEmpty == false {
                    numbers.insert(currentNumPos)
                    currentNumPos = NumPos()
                }
                if symbol(char) {
                    symbols.insert(Pos(x: x, y: y))
                }
            }
        }
        return (numbers, symbols)
    }
}
