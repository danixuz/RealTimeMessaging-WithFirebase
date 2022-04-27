//
//  DieWithMeApp.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 27/04/2022.
//

import SwiftUI
import Firebase

@main
struct DieWithMeApp: App {
    
    init(){
        FirebaseApp.configure()
        let coloredNavAppearance = UINavigationBarAppearance()
                coloredNavAppearance.configureWithTransparentBackground()
                coloredNavAppearance.backgroundColor = .clear
                coloredNavAppearance.backgroundEffect = nil
                coloredNavAppearance.backgroundImage = UIImage()
                coloredNavAppearance.shadowImage = UIImage()
                coloredNavAppearance.shadowColor = .clear
                coloredNavAppearance.titleTextAttributes = [
                    .foregroundColor: UIColor.black
                ]
                coloredNavAppearance.largeTitleTextAttributes = [
                    .foregroundColor: UIColor.black
                ]
                
                UINavigationBar.appearance().standardAppearance = coloredNavAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
                UINavigationBar.appearance().compactAppearance = coloredNavAppearance

    }
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MessagesManager())
        }
    }
}
