import Foundation

class ItemViewModel: ObservableObject {
    @Published var items = [ToDoItem]()
    @Published var searchText = ""
    @Published var selectedSortTitle: SortTitle = .name
    @Published var sortAscending = true
    @Published var itemForEditing: ToDoItem? = nil

    private let fileManager = ToDoFileManager()

    var filteredItems: [ToDoItem] {
        if searchText.isEmpty || searchText == "" {
            return items
        }
        else {
            return items.filter { $0.title.localizedCaseInsensitiveContains(searchText)}
        }
    }

    init() {
        do {
            let dataLoaded: [ToDoItem] = try fileManager.loadDataFromFile(file: Constants.fileURL)
            self.items = dataLoaded
        } catch {
            items = []
        }
    }

    public func updateFile(with newItem: ToDoItem) {
        items.append(newItem)
        saveItemsToFile()
    }

    private func saveItemsToFile() {
        do {
            try fileManager.updateFile(for: Constants.fileURL, items: items)
        } catch {
            fatalError()
        }
    }

    public func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let itemToDelete = items[index]
            if let indexToDelete = items.firstIndex(where: { $0.title == itemToDelete.title}) {
                items.remove(at: indexToDelete)
                saveItemsToFile()
            }
        }
    }

    public func updateIsComplete(for selectedItem: ToDoItem) {
        guard let selectedItemIndex = items.firstIndex(of: selectedItem) else {
            return
        }
        items[selectedItemIndex].isComplete.toggle()

        // Move completed items to the end of the array
        if selectedItem.isComplete {
            let completedItem = items.remove(at: selectedItemIndex)
            items.append(completedItem)
        }

        saveItemsToFile()

        // Re-sort items
        sortItems(by: selectedSortTitle)
    }

    public func sortItems(by title: SortTitle) {
        selectedSortTitle = title
        switch selectedSortTitle {
        case .name:
            items.sort(by: { sortAscending ? ($0.title < $1.title) : ($0.title > $1.title) })
        case .priority:
            items.sort(by: { sortAscending ? ($0.priority < $1.priority) : ($0.priority > $1.priority) })
        case .date:
            items.sort(by: { sortAscending ? ($0.finishDate < $1.finishDate) : ($0.finishDate > $1.finishDate) })
        }

        // Move completed items to the end of the array
            items.sort { (item1, item2) -> Bool in
                if item1.isComplete && !item2.isComplete {
                    return false
                } else if !item1.isComplete && item2.isComplete {
                    return true
                } else {
                    return false
                }
            }
    }

        public func updateItemsWithEditItem(oldItem: ToDoItem, editedItem: ToDoItem) {
            guard let index = items.firstIndex(of: oldItem) else {
                return
            }
            items[index] = editedItem
            saveItemsToFile()
        }
}
