//
//  Blocker.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 01/05/2022.
//

import SwiftUI

struct BlockerView: View {
    @StateObject var viewModel: MessagesManager
    var body: some View {
        VStack(spacing: 50){
            Text("ניתן להשתמש באפליקציה רק כשטעינת הסוללה מתחת ל-5%")
                .font(.title2)
                .multilineTextAlignment(.center)
                .flipsForRightToLeftLayoutDirection(true)
            Button {
                viewModel.updateView()
            } label: {
                Text("רענן")
            }
            Button {
                viewModel.percentageTest.toggle()
                viewModel.updateView()
            } label: {
                Text("דיבאג")
            }
            Button {
                UserDefaults.standard.set(nil, forKey: "displayName")
            } label: {
                Text("אתחול שם משתמש")
            }
            
            SwiftUIBannerAd(adPosition: .top, adUnitId: adUnitID)
                .frame(height: 60)
            
        }
        .preferredColorScheme(.dark)
    }
}

struct Blocker_Previews: PreviewProvider {
    static var previews: some View {
        BlockerView(viewModel: MessagesManager())
    }
}
