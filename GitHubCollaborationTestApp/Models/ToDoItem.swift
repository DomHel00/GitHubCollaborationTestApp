import Foundation

struct ToDoItem: Codable {
    var title: String
    let creationDate: Date
    var finishDate: Date
    var isComplete: Bool
    
    init(title: String, finishDate: Date) {
        self.title = title
        self.creationDate = .now
        self.finishDate = finishDate
        self.isComplete = false
    }
}
