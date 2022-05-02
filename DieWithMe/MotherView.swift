//
//  MotherView.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 01/05/2022.
//

import SwiftUI
import UIKit

struct MotherView: View {
    @StateObject var viewModel: MessagesManager
    let batteryPercentage = { (test: Bool) -> Int in
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryFloat = UIDevice.current.batteryLevel
        var currentPercentage = 100 * batteryFloat
        if currentPercentage == -100{
            currentPercentage = 10
        }
        if test{
            currentPercentage = 5
        }
        return Int(currentPercentage)
    }
    
    var body: some View {
        if (batteryPercentage(viewModel.percentageTest) <= 5){
            if (UserDefaults.standard.string(forKey: "displayName") == nil){
                // New user
                MakeName(viewModel: viewModel)
            }else{
                ContentView(viewModel: viewModel)
            }
        }else{
            BlockerView(viewModel: viewModel)
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewModel: MessagesManager())
    }
}
