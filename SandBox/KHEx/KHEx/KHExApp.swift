//
//  KHExApp.swift
//  KHEx
//
//  Created by Park Youngeun on 2021/05/05.
//

import SwiftUI

@main
struct KHExApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MyInfo())
        }
    }
}
