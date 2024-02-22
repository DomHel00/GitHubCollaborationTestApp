//
//  EditItemView.swift
//  GitHubCollaborationTestApp
//
//  Created by Dominik Hel on 20.02.2024.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: EditItemViewViewModel
    private let itemForEditing: ToDoItem
    var completion: ((ToDoItem?) -> Void)
    
    init(itemForEditing: ToDoItem, completion: @escaping ((ToDoItem?) -> Void)) {
        self.itemForEditing = itemForEditing
        _vm = StateObject(wrappedValue: EditItemViewViewModel(with: itemForEditing))
        self.completion = completion
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Edit a title") {
                    TextField("Edit a title", text: $vm.title)
                        .autocorrectionDisabled()
                }
                
                Section("Edit a finish date") {
                    DatePicker("Edit date", selection: $vm.finishDate, in: Date.now...)
                        .pickerStyle(.inline)
                }
                
                Section("Edit priority") {
                    Picker("Edit priority", selection: $vm.priority) {
                        ForEach(ToDoItemPriority.allCases, id: \.self) { priority in
                            Text(priority.title)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        let newItem = vm.createItemForSaveIfNeeded(from: itemForEditing)
                        completion(newItem)
                        dismiss()
                    }, label: {
                        Text("Save")
                    })
                    .disabled(!vm.isValid)
                }
            }
            .navigationTitle("Edit item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    EditItemView(itemForEditing: ToDoItem.mock) { _ in
    }
}

