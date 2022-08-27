//
//  core_data_with_swiftUIApp.swift
//  core-data-with-swiftUI
//
//  Created by Tuğrul Özpehlivan on 26.08.2022.
//

import SwiftUI

@main
struct core_data_with_swiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView(manager: CoreDataManager())
                
        }
    }
}
