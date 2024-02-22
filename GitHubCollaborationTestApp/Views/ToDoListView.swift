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
            .navigationTitle("ToDo Items")
        }
    }
}

extension ToDoListView {
    private var contentMenuSortTitle: some View {
        Section {
            Button {
                model.sortItems(by: .name)
            } label: {
                HStack {
                    Text(SortTitle.name.rawValue)
                    Image(systemName: SortTitle.name == model.selectedSortTitle ? "checkmark" : "")
                }
            }
            Button {
                model.sortItems(by: .date)
            } label: {
                HStack {
                    Text(SortTitle.date.rawValue)
                    Image(systemName: SortTitle.date == model.selectedSortTitle ? "checkmark" : "")
                }
            }
            Button {
                model.sortItems(by: .priority)
            } label: {
                HStack {
                    Text(SortTitle.priority.rawValue)
                    Image(systemName: SortTitle.priority == model.selectedSortTitle ? "checkmark" : "")
                }
            }

            Button {
                model.sortItems(by: .completed)
            } label: {
                HStack {
                    Text(SortTitle.completed.rawValue)
                    Image(systemName: SortTitle.completed == model.selectedSortTitle ? "checkmark" : "")
                }
            }

            Button {
                model.sortItems(by: .uncompleted)
            } label: {
                HStack {
                    Text(SortTitle.uncompleted.rawValue)
                    Image(systemName: SortTitle.uncompleted == model.selectedSortTitle ? "checkmark" : "")
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
                model.sortItems(by: model.selectedSortTitle)
            } label: {
                HStack {
                    Text(SortOrder.ascending.rawValue)
                    Image(systemName: model.sortAscending ? "checkmark" : "")
                }
            }

            // Descending button
            Button {
                model.sortAscending = false
                model.sortItems(by: model.selectedSortTitle)
            } label: {
                HStack {
                    Text(SortOrder.descending.rawValue)
                    Image(systemName: model.sortAscending ? "" : "checkmark" )
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
