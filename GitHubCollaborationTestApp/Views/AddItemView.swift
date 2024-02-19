//
//  AddItemView.swift
//  GitHubCollaborationTestApp
//
//  Created by Dominik Hel on 18.02.2024.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = AddItemViewViewModel()
    var completion: ((ToDoItem)) -> Void
    
    var body: some View {
        Form {
            Section("Set a title") {
                TextField("Set a title", text: $vm.title)
                    .autocorrectionDisabled()
            }
            
            Section("Select a finish date") {
                DatePicker("Finish date", selection: $vm.finishDate, in: Date.now...)
                    .pickerStyle(.inline)
            }
            
            Section("Select priority") {
                Picker("Select priority", selection: $vm.priority) {
                    ForEach(ToDoItemPriority.allCases, id: \.self) { priority in
                        Text(priority.title)
                    }
                }
                .pickerStyle(.segmented)

            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    completion(vm.createNewItem())
                    dismiss()
                }, label: {
                    Text("Add")
                })
                .disabled(!vm.isValid)
            }
        }
        .navigationTitle("Add new item")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddItemView(completion: { _ in })
}
