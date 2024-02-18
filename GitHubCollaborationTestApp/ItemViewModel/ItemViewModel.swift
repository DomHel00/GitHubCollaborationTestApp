import Foundation

class ItemViewModel: ObservableObject {
    @Published var items = [ItemModel]()
    private let fileManager = ToDoFileManager()

    init() {
        do {
            let dataLoaded: [ItemModel] = try fileManager.loadDataFromFile(file: Constants.FileURL)
            self.items = dataLoaded
        } catch {
            items = []
        }
    }
    
    public func updateFile(with newItem: ItemModel) {
        items.append(newItem)
        do {
            try fileManager.updateFile(for: Constants.FileURL, items: items)

        } catch  {
            fatalError()
        }
    }
}
