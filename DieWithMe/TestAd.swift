//
//  TestAd.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 30/04/2022.
//

import SwiftUI

struct TestAd: View {
    var body: some View {
        VStack{
            Text("Ad below text")
            SwiftUIBannerAd(adPosition: .bottom, adUnitId: adUnitID)
        }
    }
}

struct TestAd_Previews: PreviewProvider {
    static var previews: some View {
        TestAd()
    }
}
