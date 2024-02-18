import Foundation

class ItemViewModel: ObservableObject {
    @Published var items = [ToDoItem]()
    private let fileManager = ToDoFileManager()

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
