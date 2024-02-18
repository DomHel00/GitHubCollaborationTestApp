import Foundation

final class ToDoFileManager {
    public func loadDateFromFile<T: Codable>(file url: URL) throws -> T {
            guard let data = try? Data(contentsOf: url) else {
                throw JSONFileManagerError.invalidData
            }

            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                throw JSONFileManagerError.decoderError
            }
            return decodedData
        }
}

enum JSONFileManagerError: Error {
    case invalidData
    case decoderError
}
