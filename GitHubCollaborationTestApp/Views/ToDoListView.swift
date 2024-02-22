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
                        Text("Nic tu ještě nemáš")
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
            }
            .navigationTitle("ToDo Items")
        }
    }
}

#Preview {
    NavigationStack {
        ToDoListView()
    }
}
