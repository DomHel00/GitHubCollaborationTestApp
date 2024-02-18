import Foundation

final class ToDoFileManager {
    public func loadDataFromFile<T: Codable>(file url: URL) throws -> T {
            guard let data = try? Data(contentsOf: url) else {
                throw JSONFileManagerError.invalidData
            }

            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                throw JSONFileManagerError.decoderError
            }
            return decodedData
        }
    
    
    public func updateFile<T: Codable>(for url: URL, items: T) throws {
        guard let encodedData = try? JSONEncoder().encode(items) else {
            throw JSONFileManagerError.encoderError
        }
        
        do {
            try encodedData.write(to: url)
        } catch {
            throw JSONFileManagerError.writeToFileError
        }
    }
}

enum JSONFileManagerError: Error {
    case invalidData
    case decoderError
    case encoderError
    case writeToFileError
}
