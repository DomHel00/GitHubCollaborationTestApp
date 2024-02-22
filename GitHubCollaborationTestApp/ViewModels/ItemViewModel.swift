import Foundation

class ItemViewModel: ObservableObject {
    @Published var items = [ToDoItem]()
    @Published var searchText = ""
    @Published var selectedSortTitle: SortTitle = .title
    @Published var sortAscending = true

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

    func updateIsComplete(for selectedItem: ToDoItem) {
        guard let selectedItemIndex = items.firstIndex(of: selectedItem) else {
            return
        }
        items[selectedItemIndex].isComplete.toggle()
        saveItemsToFile()
    }

    public func sortItems(by title: SortTitle) {
        selectedSortTitle = title
        switch selectedSortTitle {
        case .title:
            items.sort(by: { sortAscending ? $0.title < $1.title : $0.title > $1.title })
        case .priority:
            items.sort(by: { sortAscending ? $0.priority < $1.priority : $0.priority > $1.priority })
        case .date:
            items.sort(by: { sortAscending ? $0.finishDate < $1.finishDate : $0.finishDate > $1.finishDate })
        case .finish:
            items.sort(by: { sortAscending ? $0.isComplete && !$1.isComplete : !$0.isComplete && $1.isComplete })
        case .incomplete:
            items.sort(by: { sortAscending ? !$0.isComplete && $1.isComplete : $0.isComplete && !$1.isComplete })
        }
    }
}
