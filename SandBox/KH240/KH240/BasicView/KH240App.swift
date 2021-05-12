//
//  KH240App.swift
//  KH240
//
//  Created by Park Youngeun on 2021/05/08.
//

import SwiftUI

@main
struct KH240App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MyInfo())
        }
    }
}
