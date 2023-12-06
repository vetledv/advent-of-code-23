
import Foundation

protocol Day {
    static var day: Int { get }

    func part1() async throws -> Any
    func part2() async throws -> Any

    var data: String { get set }

    init(data: String)
}

extension Day {
    init() {
        self.init(data: Self.loadData(Self.day))
    }

    static func loadData(_ dd: Int) -> String {
        let day = String(format: "%02d", dd)
        let file = "day\(day)"
        let url = Bundle.module.url(
            forResource: file,
            withExtension: "txt",
            subdirectory: "data"
        )
        guard let url = url, let data = try? String(contentsOf: url) else { fatalError() }
        return data
    }
}

print(Day04().part1())
