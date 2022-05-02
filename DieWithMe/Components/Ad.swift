//
//  Ad.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 30/04/2022.
//

import SwiftUI
import GoogleMobileAds
import UIKit
//
//final private class BannerVC: UIViewControllerRepresentable {
//
//    func makeUIViewController(context: Context) -> some UIViewController {
//        let viewWidth = frame.size.width
//        let view = GADBannerView(adSize: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth))
//    }
//}

class BannerAdVC: UIViewController{
    let adUnitId: String

    //initialize variable
    init(addUnitId: String){
        self.adUnitId = addUnitId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    var bannerView: GADBannerView = GADBannerView() //create the bannerview

    override func viewDidLoad() {
        bannerView.adUnitID = adUnitId
        bannerView.rootViewController = self

        //add BannerView to the view controller
        view.addSubview(bannerView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loadBannerAd()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.bannerView.isHidden = true //So banner doesn't disappear in the middle of the animation
        } completion: { _ in
            self.bannerView.isHidden = false
            self.loadBannerAd()
        }
    }

    func loadBannerAd(){
        let frame = view.frame.inset(by: view.safeAreaInsets)
        let viewWidth = frame.size.width

        //Updates the BannerView size relative to the current safe area of device (this creates the adaptive banner)
        bannerView.adSize = GADCurrentOrientationInlineAdaptiveBannerAdSizeWithWidth(viewWidth)

        bannerView.load(GADRequest())
    }
}


//MARK: to use the UIViewController in SwiftUI we need to create a UIViewControllerRepresentable:

final class BannerAd: UIViewControllerRepresentable{
    let adUnitId: String

    init(adUnitId: String){
        self.adUnitId = adUnitId
    }


    func makeUIViewController(context: Context) -> BannerAdVC {
        return BannerAdVC(addUnitId: adUnitId)
    }

    func updateUIViewController(_ uiViewController: BannerAdVC, context: Context) {

    }
}


//MARK: Now for the SwiftUI view to manage the position and frame of the ad:

struct SwiftUIBannerAd: View {
    @State var height: CGFloat = 0 //height of the ad
    @State var width: CGFloat = 0 //width of the ad
    @State var adPosition: AdPosition
    let adUnitId: String

    init(adPosition: AdPosition, adUnitId: String){
        self.adPosition = adPosition
        self.adUnitId = adUnitId
    }

    enum AdPosition{
        case top
        case bottom
    }

    public var body: some View{
        
            //MARK: Ad itself
            BannerAd(adUnitId: adUnitId)
//                .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                .onAppear {
                    //call this .onAppear because we need to load the initial frame size.
                    // .onReceive() will not be called on initial load
//                    setFrame()
                }
//                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
//                    setFrame()
//                    //changes the frame of the ad whenever the device is rotated. this is what created the adaptive ad.
//                }
    } //end of body

//    func setFrame(){
//
//        //Get the frame of the safe area:
//        let frame = UIScreen.main.bounds
//
//        //use the frame to determine the size of the ad
//        let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(frame.width)
//        let adSize2 = GADAdSizeBanner
//
//        //set the ad's frame
//        self.width = adSize.size.width
//        self.height = adSize2.size.height
//
//    }


}


