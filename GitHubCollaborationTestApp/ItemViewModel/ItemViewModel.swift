import Foundation

class ItemViewModel: ObservableObject {
    @Published var items = [ItemModel]()

    init() {
        do {
            let fileManager = ToDoFileManager()
            let dataLoaded: [ItemModel] = try fileManager.loadDataFromFile(file: Constants.FileURL)
            self.items = dataLoaded
        } catch {
            items = []
        }
    }
}
