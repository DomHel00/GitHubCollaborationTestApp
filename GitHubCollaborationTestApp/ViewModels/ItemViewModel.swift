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
        do {
            try fileManager.updateFile(for: Constants.fileURL, items: items)

        } catch  {
            fatalError()
        }
    }
}
