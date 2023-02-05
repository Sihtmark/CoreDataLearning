//
//  CoreDataLearningApp.swift
//  CoreDataLearning
//
//  Created by Sergei Poluboiarinov on 05.02.2023.
//

import SwiftUI

@main
struct CoreDataLearningApp: App {
    @StateObject private var coreDataManager = CoreDataManager()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
    }
}
