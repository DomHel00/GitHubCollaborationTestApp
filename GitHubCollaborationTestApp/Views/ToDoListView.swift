import SwiftUI

struct ToDoListView: View {
    @StateObject var model = ItemViewModel()
    @State private var itemIsComplete = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !model.items.isEmpty {
                    List {
                        ForEach(model.filteredItems, id: \.id) { item in
                            RowItemView(item: item) {
                                model.updateIsComplete(for: item)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button("Edit") {
                                    model.itemForEditing = item
                                }
                                .tint(.gray)
                            }
                        }
                        .onDelete(perform: model.deleteItem)
                    }
                    .listStyle(.plain)
                } else {
                    VStack(spacing: 50) {
                        Image(systemName: "note.text.badge.plus")
                            .resizable()
                            .frame(width: 120, height: 100)
                            .opacity(0.3)
                        Text("You don't have anything here yet")
                            .font(.largeTitle).opacity(0.3)
                    }
                }
            }
            .sheet(item: $model.itemForEditing, content: { itemForEditing in
                EditItemView(itemForEditing: itemForEditing) { editedItem in
                    if let editedItem = editedItem {
                        model.updateItemsWithEditItem(oldItem: itemForEditing, editedItem: editedItem)
                    }
                }
            })
            .searchable(text: $model.searchText, prompt: "Search item")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddItemView { newItem in
                            model.updateFile(with: newItem)
                        }
                    } label: {
                        Label("Add new item", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        contentMenuSortTitle
                        contentMenuSortOrder
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            .onChange(of: model.items, { _, _ in
                model.sortItems(by: model.selectedSortTitle)
            })
            .onChange(of: model.selectedSortTitle, { _, newValue in
                UserDefaultSettings.shared.setSelectedSortTitle(newValue: newValue)
                model.sortItems(by: newValue)
            })
            .onChange(of: model.sortAscending, { _, newValue in
                UserDefaultSettings.shared.setSortAscending(newValue: newValue)
                model.sortItems(by: model.selectedSortTitle)
            })
            .navigationTitle("ToDo Items")
        }
    }
}

extension ToDoListView {
    private var contentMenuSortTitle: some View {
        Section {
            Button {
                model.selectedSortTitle = .name
            } label: {
                if  SortTitle.name == model.selectedSortTitle {
                    Label(SortTitle.name.rawValue, systemImage: "checkmark")
                }
                else {
                    Text(SortTitle.name.rawValue)
                }
            }
            
            Button {
                model.selectedSortTitle = .date
            } label: {
                if  SortTitle.date == model.selectedSortTitle {
                    Label(SortTitle.date.rawValue, systemImage: "checkmark")
                }
                else {
                    Text(SortTitle.date.rawValue)
                }
            }
            
            Button {
                model.selectedSortTitle = .priority
            } label: {
                if  SortTitle.priority == model.selectedSortTitle {
                    Label(SortTitle.priority.rawValue, systemImage: "checkmark")
                }
                else {
                    Text(SortTitle.priority.rawValue)
                }
            }
            
            Button {
                model.selectedSortTitle = .completed
            } label: {
                if  SortTitle.completed == model.selectedSortTitle {
                    Label(SortTitle.completed.rawValue, systemImage: "checkmark")
                }
                else {
                    Text(SortTitle.completed.rawValue)
                }
            }
            
            Button {
                model.selectedSortTitle = .uncompleted
            } label: {
                if  SortTitle.uncompleted == model.selectedSortTitle {
                    Label(SortTitle.uncompleted.rawValue, systemImage: "checkmark")
                }
                else {
                    Text(SortTitle.uncompleted.rawValue)
                }
            }
        } header: {
            Text("Sort by:")
        }
    }
    
    private var contentMenuSortOrder: some View {
        Section {
            // Ascending button
            Button {
                model.sortAscending = true
            } label: {
                if model.sortAscending {
                    Label(SortOrder.ascending.rawValue, systemImage: "checkmark")
                }
                else {
                    Text(SortOrder.ascending.rawValue)
                }
            }
            
            // Descending button
            Button {
                model.sortAscending = false
            } label: {
                if !model.sortAscending {
                    Label(SortOrder.descending.rawValue, systemImage: "checkmark")
                }
                else {
                    Text(SortOrder.descending.rawValue)
                }
            }
        } header: {
            Text("Sort by order:")
        }
    }
}

#Preview {
    NavigationStack {
        ToDoListView()
    }
}
