import Foundation

class ItemViewModel: ObservableObject {
    @Published var items = [ToDoItem]()
    @Published var searchText = ""
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

    func updateIsComplete(for selectedItem: ToDoItem, to isComplete: Bool) {
        if let index = items.firstIndex(where: { $0.id == selectedItem.id }) {
            items[index].isComplete = isComplete
            saveItemsToFile()
        }
    }
}
