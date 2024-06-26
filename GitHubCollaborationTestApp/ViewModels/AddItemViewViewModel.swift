//
//  AddItemViewViewModel.swift
//  GitHubCollaborationTestApp
//
//  Created by Dominik Hel on 18.02.2024.
//

import Foundation

final class AddItemViewViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var finishDate: Date = .now
    @Published var priority: ToDoItemPriority = .normal
    
    var isValid: Bool {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmed.isEmpty || trimmed == "" {
            return false
        }
        return true
    }
    
    public func createNewItem() -> ToDoItem {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let newItem = ToDoItem(title: trimmedTitle, finishDate: finishDate, priority: priority)
        return newItem
    }
}
