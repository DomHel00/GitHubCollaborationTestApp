import Foundation
import SwiftUI

enum SortTitle: String, CaseIterable {
    case title = "Název"
    case priority = "Priorita"
    case date = "Datum"
}

enum SortOrder: String, CaseIterable {
    case ascending = "Vzestupně"
    case descending = "Sestupně"
}

enum ToDoItemPriority: Codable, CaseIterable, Comparable {
    case none, low, normal, high

    var title: String {
        switch self {
        case .none: return "None"
        case .low: return "Low"
        case .normal: return "Normal"
        case .high: return "High"
        }
    }
    
    var color: Color {
        switch self {
        case .none: return .green
        case .low: return .yellow
        case .normal: return .orange
        case .high: return .red
        }
    }
}

struct ToDoItem: Codable, Identifiable {
    var id = UUID()
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

extension ToDoItem: Equatable {
    static func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.creationDate == rhs.creationDate && lhs.finishDate == rhs.finishDate && lhs.isComplete == rhs.isComplete && lhs.priority == rhs.priority && lhs.symbol == rhs.symbol
      }
}
