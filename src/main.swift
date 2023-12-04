
import Foundation

func loadData(_ dd: Int) throws -> String {
    let day = String(format: "%02d", dd)
    let file = "day\(day)"
    let url = Bundle.module.url(
        forResource: file,
        withExtension: "txt",
        subdirectory: "data"
    )
    guard let url = url else { fatalError() }
    return try String(contentsOf: url)
}

Day03().printAnswers()
