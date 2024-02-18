import Foundation

struct ItemModel: Codable {
    let title: String
    let creationDate: Date
    let finishDate: Date
    var isComplete: Bool
}
