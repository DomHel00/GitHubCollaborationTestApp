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
                DatePicker("Select a finish date", selection: $vm.finishDate, in: Date.now...)
                    .pickerStyle(.inline)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    let newItem = ToDoItem(title: vm.title, creationDate: .now, finishDate: vm.finishDate, isComplete: false)
                    completion(newItem)
                    dismiss()
                }, label: {
                    Text("Add")
                })
            }
        }
        .navigationTitle("Add new item")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
#Preview {
    AddItemView()
}
*/
