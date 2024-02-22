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
                model.sortItems(by: .title)
            } label: {
                HStack {
                    Text(SortTitle.title.rawValue)
                    Image(systemName: SortTitle.title == model.selectedSortTitle ? "checkmark" : "")
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
                model.sortItems(by: .finish)
            } label: {
                HStack {
                    Text(SortTitle.finish.rawValue)
                    Image(systemName: SortTitle.finish == model.selectedSortTitle ? "checkmark" : "")
                }
            }

            Button {
                model.sortItems(by: .incomplete)
            } label: {
                HStack {
                    Text(SortTitle.incomplete.rawValue)
                    Image(systemName: SortTitle.incomplete == model.selectedSortTitle ? "checkmark" : "")
                }
            }
        } header: {
            Text("Seřadit podle")
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
        }
    }
}

#Preview {
    NavigationStack {
        ToDoListView()
    }
}
