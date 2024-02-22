//
//  EditItemViewViewModel.swift
//  GitHubCollaborationTestApp
//
//  Created by Dominik Hel on 22.02.2024.
//

import Foundation

final class EditItemViewViewModel: ObservableObject {
    @Published var title: String
    @Published var finishDate: Date
    @Published var priority: ToDoItemPriority
    
    init(with item: ToDoItem) {
        _title = Published(initialValue: item.title)
        _finishDate = Published(initialValue: item.finishDate)
        _priority = Published(initialValue: item.priority)
    }
    
    var isValid: Bool {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmed.isEmpty || trimmed == "" {
            return false
        }
        return true
    }
    
    public func createItemForSaveIfNeeded(from editedItem: ToDoItem) -> ToDoItem? {
        var copyItem = editedItem
        copyItem.title = title
        copyItem.finishDate = finishDate
        copyItem.priority = priority
        
        if copyItem == editedItem {
            return nil
        } else {
            return copyItem
        }
    }
}
