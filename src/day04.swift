
import Foundation

struct Card: Hashable {
    var winningNumbers = Set<Int>()
    var ownedNumbers = Set<Int>()
    var matches = 0
    var points: Int {
        1 << (matches - 1)
    }

    init(winningNumbers: Set<Int> = Set<Int>(), ownedNumbers: Set<Int> = Set<Int>(), matches: Int = 0) {
        self.winningNumbers = winningNumbers
        self.ownedNumbers = ownedNumbers
        self.matches = self.winningNumbers.intersection(self.ownedNumbers).count
    }
}

extension Array where Element == String {
    func toCard() -> Card {
        guard let winning = first, let owned = last else { fatalError() }
        let winningNumbers = winning.components(separatedBy: " ").compactMap { Int($0) }
        let ownedNumbers = owned.components(separatedBy: " ").compactMap { Int($0) }
        return Card(winningNumbers: Set(winningNumbers), ownedNumbers: Set(ownedNumbers))
    }
}

extension String {
    func toCardSet() -> Set<Card> {
        var set = Set<Card>()
        let split = components(separatedBy: "\n").compactMap { line in
            var split = line.split(separator: ": ")
            if split.count == 2, let id = split.first, let nums = split.last {
                return (id, nums)
            }
            return nil
        }
        split.forEach { _, num in
            set.insert(num.components(separatedBy: "|").toCard())
        }
        return set
    }
}

struct Day04: Day {
    static var day: Int = 04
    var data: String

    func part1() -> Any {
        return data.toCardSet().map { $0.points }.reduce(0) { $0 + $1 }
    }

    func part2() -> Any {
        return 0
    }
}
