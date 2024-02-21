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
                        Section {
                            Button {
                                model.sortItems(by: .title)
                            } label: {
                                Text(SortTitle.title.rawValue)
                            }
                            Button {
                                model.sortItems(by: .date)
                            } label: {
                                Text(SortTitle.date.rawValue)
                            }
                            Button {
                                model.sortItems(by: .priority)
                            } label: {
                                Text(SortTitle.priority.rawValue)
                            }
                        } header: {
                            Text("Seřadit podle")
                        }

                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
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
