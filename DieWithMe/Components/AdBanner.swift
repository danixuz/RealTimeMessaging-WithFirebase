////
////  AdBanner.swift
////  DieWithMe
////
////  Created by Daniel Spalek on 30/04/2022.
////
//
//import UIKit
//import SwiftUI
//import GoogleMobileAds
//
////Implemeting the banner ad...
//
//struct BannerAd: UIViewRepresentable{
//    
//    var unitID: String
//    
//    func makeCoordinator() -> Coordinator {
//        // For implementing delegates...
//        return Coordinator()
//    }
//
//    func makeUIView(context: Context) -> GADBannerView {
//        
//        let adView = GADBannerView(adSize: GADAdSizeBanner)
//        
//        adView.adUnitID = unitID
//        adView.rootViewController = UIApplication.shared.getRootViewController()
//        adView.delegate = context.coordinator
//        adView.load(GADRequest())
//        
//        return adView
//    }
//    
//    func updateUIView(_ uiView: GADBannerView, context: Context){
//        
//    }
//    
//    class Coordinator: NSObject, GADBannerViewDelegate{
//        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
//          print("bannerViewDidReceiveAd")
//        }
//
//        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
//          print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
//        }
//
//        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
//          print("bannerViewDidRecordImpression")
//        }
//
//        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
//          print("bannerViewWillPresentScreen")
//        }
//
//        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
//          print("bannerViewWillDIsmissScreen")
//        }
//
//        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
//          print("bannerViewDidDismissScreen")
//        }
//    }
//}
//
//// Extending application to get root view...
//extension UIApplication{
//    func getRootViewController() -> UIViewController{
//        
//        guard let screen = self.connectedScenes.first as? UIWindowScene else{
//            return .init()
//        }
//        guard let root = screen.windows.first?.rootViewController else{
//            return .init()
//        }
//        
//        return root
//    }
//}
