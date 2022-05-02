//
//  DieWithMeApp.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 27/04/2022.
//

import SwiftUI
import Firebase
import AppTrackingTransparency
import GoogleMobileAds


@main
struct DieWithMeApp: App {
    @StateObject var viewModel = MessagesManager()
    init(){
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    var body: some Scene {
        WindowGroup {
            MotherView(viewModel: viewModel)
        }
    }
}
