//
//  FindFlightAppApp.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import SwiftUI

@main
struct FindFlightAppApp: App {

    let launcher = Launcher()

    var body: some Scene {
        WindowGroup {
            launcher.launchScreen
        }
    }
}
