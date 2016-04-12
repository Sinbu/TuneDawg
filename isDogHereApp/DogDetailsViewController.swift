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
import Appboy_iOS_SDK

class DogDetailsViewController: UIViewController {
    @IBOutlet weak var dogDetailImage: UIImageView!
    @IBOutlet weak var dogDetailNav: UINavigationItem!
    @IBOutlet var dogNotificationSwitch: UISwitch!
    
    
    let banner: TuneBanner = TuneBanner()
    let interstitial = TuneInterstitial()
    var dogDetail: Dog!
    var dogSubscriptions: Array<String>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogDetailNav.title = dogDetail.dogName
        
        let imageLayer = dogDetailImage.layer;
        imageLayer.cornerRadius = (dogDetailImage.frame.height)/2
        imageLayer.masksToBounds = true
        
        dogDetailImage.image = dogDetail.image
        
        // IAM setting dog subscriptions
        // TODO: Move this to an option on NSUserDefaults
        
        let dogSubscriptionsOptional: String? = Tune.getCustomProfileString("DogSubscription")
        if let dogSubscriptionStringList = dogSubscriptionsOptional {
            // Parse comma seperated string into array
            dogSubscriptions = dogSubscriptionStringList.characters.split{$0 == ","}.map(String.init)
            print("Dog Subscription list: \(dogSubscriptions)")
        } else {
            print("Dog Subscription not set")
            dogSubscriptions = [String]()
        }
        
        if (dogSubscriptions.contains(String(dogDetail.dogID))) {
            print("Subscribed to this dog")
            dogNotificationSwitch.setOn(true, animated: false)
        } else {
            print("Not subscribed to this dog")
            dogNotificationSwitch.setOn(false, animated: false)
        }
 
        
    }
    @IBAction func notificationSwitchAction(sender: UISwitch) {
        
        if (sender.on) {
            print("Notifications turned on for: \(dogDetail.dogName)")
            dogSubscriptions.append(String(dogDetail.dogID))
            Appboy.sharedInstance()!.user.setCustomAttributeWithKey("Dog-\(dogDetail.dogID)", andStringValue: String(dogDetail.dogName))
            
            
        } else {
            print("Notifications off for: \(dogDetail.dogName)")
            dogSubscriptions = dogSubscriptions.filter {$0 != String(dogDetail.dogID)}
            Appboy.sharedInstance()!.user.unsetCustomAttributeWithKey("Dog-\(String(dogDetail.dogID))")
        }
        let stringDogSubscriptions = dogSubscriptions.joinWithSeparator(",")
        
        Tune.setCustomProfileStringValue(stringDogSubscriptions, forVariable: "DogSubscription")
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