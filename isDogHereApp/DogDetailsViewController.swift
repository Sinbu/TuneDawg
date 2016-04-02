//
//  DogDetailsViewController.swift
//  isDogHereApp
//
//  Created by Sina Yeganeh on 01/12/2015.
//  Copyright © 2015 Sina Yeganeh. All rights reserved.
//

import Foundation
import UIKit
import Tune

class DogDetailsViewController: UIViewController {
    @IBOutlet weak var dogDetailImage: UIImageView!
    @IBOutlet weak var dogDetailNav: UINavigationItem!
    
    var banner: TuneBanner = TuneBanner()
    var interstitial = TuneInterstitial()
    var shouldShowAd: Bool = true
    
    var dogDetail: Dog!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogDetailNav.title = dogDetail.dogName
        
        let imageLayer = dogDetailImage.layer;
        imageLayer.cornerRadius = (dogDetailImage.frame.height)/2
        imageLayer.masksToBounds = true
        
        dogDetailImage.image = dogDetail.image
        
        // self.showInterstitialAd()
        
    }
    
//    override func viewDidLayoutSubviews() {
//        self.layoutAnimated(true)
//    }
//
//    func layoutAnimated(animated: Bool) -> Void {
//        let sizeForBanner = banner.sizeThatFits(self.view.bounds.size)
//        var bannerFrame = banner.frame
//        
//        if (banner.ready) {
//            bannerFrame.origin.y = self.view.frame.size.height - sizeForBanner.height
//            bannerFrame.size.height = sizeForBanner.height
//            bannerFrame.size.width = sizeForBanner.width
//        } else {
//            bannerFrame.origin.y = UIScreen.mainScreen().bounds.size.height;
//        }
//        
//        self.view.setNeedsLayout()
//        
//        UIView.animateWithDuration(animated ? 0.25 : 0.0, animations: { () in
//            self.banner.frame = bannerFrame
//        })
//    }
    
    // MARK - TuneAdDelegate Methods
    
//    func tuneAdDidFetchAdForView(adView: TuneAdView!, placement: String!) {
//        self.layoutAnimated(true)
//    }
//    
//    func tuneAdDidFailWithError(error: NSError!, forView adView: TuneAdView!) {
//        self.layoutAnimated(true)
//    }
//    
//    func showInterstitialAd () {
//        interstitial.showForPlacement("LunaDetailsInterstitial", viewController: self)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}