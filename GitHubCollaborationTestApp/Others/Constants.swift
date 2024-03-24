//
//  Constants.swift
//  GitHubCollaborationTestApp
//
//  Created by Dominik Hel on 16.02.2024.
//

import Foundation

struct Constants {
    static var fileURL: URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return path.appendingPathComponent("todos.json")
    }
}
