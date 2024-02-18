//
//  AddItemViewViewModel.swift
//  GitHubCollaborationTestApp
//
//  Created by Dominik Hel on 18.02.2024.
//

import Foundation

final class AddItemViewViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var finishDate: Date = .now
}
