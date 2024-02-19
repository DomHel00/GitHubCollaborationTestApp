import Foundation
import SwiftUI

enum ToDoItemPriority: Codable, CaseIterable {
    case none, low, normal, high

    var title: String {
        switch self {
        case .none: return "None"
        case .low: return "Low"
        case .normal: return "Normal"
        case .high: return "High"
        }
    }

    var symbol: String? {
        switch self {
        case .none: return nil
        case .low: return "!"
        case .normal: return "!!"
        case .high: return "!!!"
        }
    }
}

struct ToDoItem: Codable {
    var title: String
    let creationDate: Date
    var finishDate: Date
    var isComplete: Bool
    var priority: ToDoItemPriority
    var symbol: Image {
        if isComplete {
            return Image(systemName: "checkmark.circle")
        } else {
            return Image(systemName: "circle")
        }
    }

    init(title: String, finishDate: Date, priority: ToDoItemPriority) {
        self.title = title
        self.creationDate = .now
        self.finishDate = finishDate
        self.isComplete = false
        self.priority = priority
    }
}

extension ToDoItem {
    static let mock: ToDoItem = ToDoItem(
        title: "First item",
        finishDate: Date.now,
        priority: ToDoItemPriority.normal)
}
