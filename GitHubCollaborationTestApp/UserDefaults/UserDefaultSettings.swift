//
//  UserDefaultSettings.swift
//  GitHubCollaborationTestApp
//
//  Created by Dominik Hel on 24.03.2024.
//

import Foundation

final class UserDefaultSettings {
    static let shared = UserDefaultSettings()
    
    private init() {}
    
    private let standard = UserDefaults.standard
    
    public func getSelectedSortTitle() -> SortTitle {
        switch standard.integer(forKey: "selectedSortTitle") {
        case 0:
            return .name
        case 1:
            return .priority
        case 2:
            return .date
        case 3:
            return .completed
        case 4:
            return .uncompleted
        default:
            return .name
        }
    }
    
    public func setSelectedSortTitle(newValue: SortTitle) {
        let sortValueIndex: Int
        
        switch newValue {
        case .name:
            sortValueIndex = 0
        case .priority:
            sortValueIndex = 1
        case .date:
            sortValueIndex = 2
        case .completed:
            sortValueIndex = 3
        case .uncompleted:
            sortValueIndex = 4
        }
        
        standard.setValue(sortValueIndex, forKey: "selectedSortTitle")
    }
    
    public func getSortAscending() -> Bool {
        return standard.bool(forKey: "sortAscending")
    }
    
    public func setSortAscending(newValue: Bool) {
        standard.setValue(newValue, forKey: "sortAscending")
    }
}
