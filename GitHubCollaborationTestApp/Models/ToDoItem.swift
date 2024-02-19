import Foundation

enum ToDoItemPriority: Codable, CaseIterable {
    case low, normal, high
    
    var title: String {
        switch self {
        case .low: return "Low"
        case .normal: return "Normal"
        case .high: return "High"
        }
    }
}

struct ToDoItem: Codable {
    var title: String
    let creationDate: Date
    var finishDate: Date
    var isComplete: Bool
    var priority: ToDoItemPriority
    
    init(title: String, finishDate: Date, priority: ToDoItemPriority) {
        self.title = title
        self.creationDate = .now
        self.finishDate = finishDate
        self.isComplete = false
        self.priority = priority
    }
}
