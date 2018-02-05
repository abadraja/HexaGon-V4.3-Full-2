//
//  MainMenuClass_ViewController.swift
//  HexaGon
//
//  Created by Alen Badrajan on 4/7/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit
import AVFoundation
import Social
import GoogleMobileAds
import StoreKit

var audioPL = [AVAudioPlayer]()
var ListPlay = [Int]()
var listVolum = [Float]()
let SongsName = ["guitar1_test4","guitar2","music_box","violin1","drum_beats","violin_hotel",
                 "rain","river","rustling_leaves","thunder1","wind","forest",
                 "adventure8","circus8","cool8","happy8","introduction8","life8",
                 "airplane","cars","highway","sailing","submarine","train",
                 "black_noise","ablue_noise","brown_noise","grey_noise","pink_noise","white_noise",
                 "cicada","owl","survicalcamp","wales","wings","wolf",
                 "piano1","piano2","piano3","piano4","piano5","piano6",
                 "choir1","choir2","choir3","choir4","choir5","hallelujah",
                 "keyboard1","keyboard2","keyboard3","mouse_scrolling","mouse1","mouse2",
                 "industrial1","industrial2","industrial3","industrial4","industrial6","industrial",
                 "french","german","romania","spanish","tribal1","tribal3",
                 "floute","koto-loop","medieval","saxophone","saxophone1","saxophone3"]
let imagini = ["guitar1_test4.png","guitar2.png","music_box.png","violin1.png","drum_beats.png","violin_hotel.png",
               "rain.png","river.png","rustling_leaves.png","thunder1.png","wind.png","forest.png",
               "adventure8.png","circus8.png","cool8.png","happy8.png","introduction8.png","life8.png",
               "airplane.png","cars.png","highway.png","sailing.png","submarine.png","train.png",
               "black_noise.png","ablue_noise.png","brown_noise2.png","grey_noise.png","pink_noise.png","white_noise.png",
               "cicada.png","owl.png","survicalcamp.png","wales.png","wings.png","wolf.png",
               "piano1.png","piano2.png","piano3.png","piano4.png","piano5.png","piano6.png",
               "choir1.png","choir2.png","choir3.png","choir4.png","choir5.png","hallelujah.png",
               "keyboard1.png","keyboard2.png","keyboard3.png","mouse_scrolling.png","mouse1.png","mouse2.png",
               "industrial.png","industrial1.png","industrial2.png","industrial3.png","industrial4.png","industrial6.png",
               "french.png","german.png","romania.png","spanish.png","tribal1.png","tribal3.png",
               "floute.png","koto_loop.png","medieval.png","saxophone.png","saxophone1.png","saxophone3.png"]
var block = [1,1,1,1,1,0,1,1,1,1,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
             1,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]

extension UINavigationController {
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override open var supportedInterfaceOrientations:
        UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}

class MainMenuClass_ViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var varButton_1: UIButton!
    @IBOutlet weak var varButton_2: UIButton!
    @IBOutlet weak var varButton_3: UIButton!
    @IBOutlet weak var varButton_4: UIButton!
    @IBOutlet weak var varButton_5: UIButton!
    @IBOutlet weak var varButton_6: UIButton!
    @IBOutlet weak var varButton_center: UIButton!
    
    var varButtonsArray = [UIButton]()
    
    @IBOutlet weak var varSupportButton: UIButton!
    @IBOutlet weak var varShareButton: UIButton!
    @IBOutlet weak var varTableButton: UIButton!
    @IBOutlet weak var varLikeButton: UIButton!
    @IBOutlet weak var varXButton: UIButton!
    @IBOutlet weak var varUpgradeButton: UIButton!
    
    
    @IBOutlet weak var Fav_labbel: UILabel!
    @IBOutlet weak var rate_labbel: UILabel!
    @IBOutlet weak var share_labbel: UILabel!
    @IBOutlet weak var supp_labbel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var Upgrade = false
    var NrPage : Int = 0
    var Button_ID : Int = 0
    var Song_ID : Int = 0
    var On_Page : Bool = false
    var ButtonsAreHidden : Bool = false
    var categorySelected : Int = 0
    
    var menuOn = false
    
    let categoryName = ["Instrumental","Nature","8 bit","Transport",
                        "Noise","Animals","Piano","Choir",
                        "Computer","Industrial","Countries","Mixed"]

    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
    
    func norminette_prasti()
    {
        for k in 0...SongsName.count-1
        {
            
            var Sound1aP = AVAudioPlayer()
            let ps1 = NSURL(fileURLWithPath: Bundle.main.path(forResource: SongsName[k], ofType: "mp3")!)
            Sound1aP = try! AVAudioPlayer(contentsOf: ps1 as URL)
            Sound1aP.numberOfLoops = -1
            audioPL.append(Sound1aP)
            audioPL[k].prepareToPlay()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        varButtonsArray = [varButton_1, varButton_2, varButton_3,
                           varButton_4, varButton_5, varButton_6]
        
        if UserDefaults.standard.object(forKey: "saveUpgrade") != nil {
            Upgrade = UserDefaults.standard.object(forKey: "saveUpgrade") as! Bool
        }
        if UserDefaults.standard.object(forKey: "saveblock") != nil {
            block = UserDefaults.standard.array(forKey: "saveblock") as! [Int]
        }
        if Upgrade == true {
            varUpgradeButton.isUserInteractionEnabled = false
            varUpgradeButton.alpha = 0
            bannerView.isUserInteractionEnabled = false
            bannerView.alpha = 0
        }
        
        //monetizarea
        self.bannerView.adUnitID = "ca-app-pub-7410066166100881/8660873056"
        self.bannerView.rootViewController = self
        self.bannerView.delegate = self;
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        bannerView.load(request)
        //monetizarea end
        
        
        
        if audioPL.isEmpty{
            norminette_prasti()
        }
        
        if (On_Page == false)
        {
            self.pageControl.alpha = 1;
            self.categoryLabel.alpha = 0;
        }
        else
        {
            self.categoryLabel.alpha = 1;
            self.pageControl.alpha = 0;
        }
        
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.4326250255, blue: 0.14315328, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.5556249619, green: 0.5556384325, blue: 0.5556312203, alpha: 1)
        
        for i in 0...5
        {
            varButtonsArray[i].setImage(nil, for: .normal)
            varButtonsArray[i].isUserInteractionEnabled = true
        }
        
        
        self.navigationController?.isNavigationBarHidden = true;
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        //Swipe part END
    }
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                swipe_toRight()                                     // animate pages
            case UISwipeGestureRecognizerDirection.down:
                swipe_toDown()
            case UISwipeGestureRecognizerDirection.left:
                swipe_toLeft()
            case UISwipeGestureRecognizerDirection.up:
                swipe_toUp()
            default:
                break
            }
        }
    }
    
    func swipe_toDown()
    {
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varXButton.center.y = self.view.frame.height + 21;
            self.varSupportButton.center.y = self.view.frame.height + 21;
            self.varLikeButton.center.y = self.view.frame.height + 21;
            self.varTableButton.center.y = self.view.frame.height + 21;
            self.varShareButton.center.y = self.view.frame.height + 21;
            
            self.Fav_labbel.center.y = self.view.frame.height + 24;
            self.rate_labbel.center.y = self.view.frame.height + 24;
            self.share_labbel.center.y = self.view.frame.height + 24;
            self.supp_labbel.center.y = self.view.frame.height + 24;
            
            
            self.Fav_labbel.alpha = 0;
            self.rate_labbel.alpha = 0;
            self.share_labbel.alpha = 0;
            self.supp_labbel.alpha = 0;
            
            self.varXButton.alpha = 0
            self.varSupportButton.alpha = 0
            self.varLikeButton.alpha = 0
            self.varTableButton.alpha = 0
            self.varShareButton.alpha = 0
            
        })
        ButtonsAreHidden = true;
    }
    
    func swipe_toUp()
    {
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varXButton.center.y = self.view.frame.height -         47.3
            self.varSupportButton.center.y = self.view.frame.height -   47.3
            self.varLikeButton.center.y = self.view.frame.height -      47.3
            self.varTableButton.center.y = self.view.frame.height -     47.5
            self.varShareButton.center.y = self.view.frame.height -     47.3
            
            self.varXButton.alpha = 1
            self.varSupportButton.alpha = 1
            self.varLikeButton.alpha = 1
            self.varTableButton.alpha = 1
            self.varShareButton.alpha = 1
            
            if (self.view.frame.width == 414.0 && self.view.frame.height == 736.0)
            {
                self.Fav_labbel.center.y = self.view.frame.height -     24.8;
                self.rate_labbel.center.y = self.view.frame.height -    24.8;
                self.share_labbel.center.y = self.view.frame.height -   24.8;
                self.supp_labbel.center.y = self.view.frame.height -    24.8;
            }
            else
            {
                self.Fav_labbel.center.y = self.view.frame.height -     26.3;
                self.rate_labbel.center.y = self.view.frame.height -    26.3;
                self.share_labbel.center.y = self.view.frame.height -   26.3;
                self.supp_labbel.center.y = self.view.frame.height -    26.3;
            }
            self.Fav_labbel.alpha = 1;
            self.rate_labbel.alpha = 1;
            self.share_labbel.alpha = 1;
            self.supp_labbel.alpha = 1;
        })
        ButtonsAreHidden = false;
    }
    
    func checkButtonsAreHiddenFunc()
    {
        if (ButtonsAreHidden == true)
        {
            self.varXButton.center.y = self.view.frame.height +             21;
            self.varSupportButton.center.y = self.view.frame.height +       21;
            self.varLikeButton.center.y = self.view.frame.height +          21;
            self.varTableButton.center.y = self.view.frame.height +         21;
            self.varShareButton.center.y = self.view.frame.height +         21;
            
            self.Fav_labbel.center.y = self.view.frame.height +             24;
            self.rate_labbel.center.y = self.view.frame.height +            24;
            self.share_labbel.center.y = self.view.frame.height +           24;
            self.supp_labbel.center.y = self.view.frame.height +            24;
            
            
            self.Fav_labbel.alpha = 0;
            self.rate_labbel.alpha = 0;
            self.share_labbel.alpha = 0;
            self.supp_labbel.alpha = 0;
            
            self.varXButton.alpha = 0
            self.varSupportButton.alpha = 0
            self.varLikeButton.alpha = 0
            self.varTableButton.alpha = 0
            self.varShareButton.alpha = 0
        }
        else
        {
            self.varXButton.center.y = self.view.frame.height -             47.3
            self.varSupportButton.center.y = self.view.frame.height -       47.3
            self.varLikeButton.center.y = self.view.frame.height -          47.3
            self.varTableButton.center.y = self.view.frame.height -         47.5
            self.varShareButton.center.y = self.view.frame.height -         47.3
            
            self.varXButton.alpha = 1
            self.varSupportButton.alpha = 1
            self.varLikeButton.alpha = 1
            self.varTableButton.alpha = 1
            self.varShareButton.alpha = 1
            
            if (self.view.frame.width == 414.0 && self.view.frame.height == 736.0)
            {
                self.Fav_labbel.center.y = self.view.frame.height -         23.7;
                self.rate_labbel.center.y = self.view.frame.height -        23.7;
                self.share_labbel.center.y = self.view.frame.height -       23.7;
                self.supp_labbel.center.y = self.view.frame.height -        23.7;
            }
            else
            {
                self.Fav_labbel.center.y = self.view.frame.height -         26.3;
                self.rate_labbel.center.y = self.view.frame.height -        26.3;
                self.share_labbel.center.y = self.view.frame.height -       26.3;
                self.supp_labbel.center.y = self.view.frame.height -        26.3;
            }
            self.Fav_labbel.alpha = 1;
            self.rate_labbel.alpha = 1;
            self.share_labbel.alpha = 1;
            self.supp_labbel.alpha = 1;
        }
    }
    
    let categoryImageIndex = [4,11,14,20,29,31,
                              36,47,50,54,64,69]
    
    func swipe_toLeft()
    {
        if (self.NrPage < 1 && self.On_Page == false)
        {
            checkButtonsAreHiddenFunc()
            self.pageControl.currentPage += 1
            NrPage += 1;
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.checkButtonsAreHiddenFunc()
                let grow = CGAffineTransform(scaleX: 0.1, y: 0.1)
                let angle = CGFloat(180)
                let rotate = CGAffineTransform(rotationAngle: angle)
                for i in 0...5
                {
                    self.varButtonsArray[i].transform = grow.concatenating(rotate)
                }
                self.varButton_center.transform = grow.concatenating(rotate)
                
            }) { (a) in
                self.checkButtonsAreHiddenFunc()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[self.categoryImageIndex[i + 6]]), for: UIControlState.normal)
                }
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions(rawValue: 0), animations:
                {
                    self.checkButtonsAreHiddenFunc()
                    let grow = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    let angle2 = CGFloat(0)
                    let rotate2 = CGAffineTransform(rotationAngle: angle2)
                    for i in 0...5
                    {
                        self.varButtonsArray[i].transform = grow.concatenating(rotate2)
                    }
                    self.varButton_center.transform = grow.concatenating(rotate2)
            })
            checkButtonsAreHiddenFunc()
        }
    }
    
    func swipe_toRight()
    {
        
        if (self.NrPage > 0 && self.On_Page == false)
        {
            checkButtonsAreHiddenFunc()
            
            NrPage -= 1;
            self.pageControl.currentPage -= 1
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.checkButtonsAreHiddenFunc()
                let grow = CGAffineTransform(scaleX: 0.1, y: 0.1)
                let angle = CGFloat(180)
                let rotate = CGAffineTransform(rotationAngle: angle)
                for i in 0...5
                {
                    self.varButtonsArray[i].transform = grow.concatenating(rotate)
                }
                self.varButton_center.transform = grow.concatenating(rotate)
                
            }) { (a) in
                self.checkButtonsAreHiddenFunc()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[self.categoryImageIndex[i]]), for: UIControlState.normal)
                }
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.checkButtonsAreHiddenFunc()
                let grow = CGAffineTransform(scaleX: 1.0, y: 1.0)
                let angle2 = CGFloat(0)
                let rotate2 = CGAffineTransform(rotationAngle: angle2)
                for i in 0...5
                {
                    self.varButtonsArray[i].transform = grow.concatenating(rotate2)
                }
                self.varButton_center.transform = grow.concatenating(rotate2)
            })
            checkButtonsAreHiddenFunc()
        }
    }
    
    func chooseDevice()
    {
        if (self.view.frame.width == 320.0 && self.view.frame.height == 568.0)
        {
            self.varButtonsArray[0].center.x = 160
            self.varButtonsArray[0].center.y = 186
            self.varButtonsArray[1].center.x = 241
            self.varButtonsArray[1].center.y = 235
            self.varButtonsArray[2].center.x = 241
            self.varButtonsArray[2].center.y = 333
            self.varButtonsArray[3].center.x = 160
            self.varButtonsArray[3].center.y = 382
            self.varButtonsArray[4].center.x = 80
            self.varButtonsArray[4].center.y = 333
            self.varButtonsArray[5].center.x = 80
            self.varButtonsArray[5].center.y = 235
            self.varButton_center.alpha = 1
        }
        if (self.view.frame.width == 375.0 && self.view.frame.height == 667.0)
        {
            self.varButtonsArray[0].center.x = 187.5
            self.varButtonsArray[0].center.y = 235.5
            self.varButtonsArray[1].center.x = 268.5
            self.varButtonsArray[1].center.y = 284.5
            self.varButtonsArray[2].center.x = 268.5
            self.varButtonsArray[2].center.y = 382.5
            self.varButtonsArray[3].center.x = 187.5
            self.varButtonsArray[3].center.y = 431.5
            self.varButtonsArray[4].center.x = 107.5
            self.varButtonsArray[4].center.y = 382.5
            self.varButtonsArray[5].center.x = 107.5
            self.varButtonsArray[5].center.y = 284.5
            self.varButton_center.alpha = 1
        }
        if (self.view.frame.width == 414.0 && self.view.frame.height == 736.0)
        {
            self.varButtonsArray[0].center.x = 207.0
            self.varButtonsArray[0].center.y = 270.0
            self.varButtonsArray[1].center.x = 288.0
            self.varButtonsArray[1].center.y = 319.0
            self.varButtonsArray[2].center.x = 288.0
            self.varButtonsArray[2].center.y = 417.0
            self.varButtonsArray[3].center.x = 207.0
            self.varButtonsArray[3].center.y = 466.0
            self.varButtonsArray[4].center.x = 127.0
            self.varButtonsArray[4].center.y = 417.0
            self.varButtonsArray[5].center.x = 127.0
            self.varButtonsArray[5].center.y = 319.0
            self.varButton_center.alpha = 1
        }
        
    }
    
    
    func animateButt1()
    {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[0].center.y = self.varButton_center.center.y
        })
        UIView.animate(withDuration: 0.1, animations: {
            self.varButton_center.alpha = 0;
        })
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[1].center.x = self.view.frame.width + 100;
            self.varButtonsArray[1].center.y = -50;
            self.varButtonsArray[2].center.x = self.view.frame.width + 100;
            self.varButtonsArray[2].center.y = self.view.frame.height + 50;
            self.varButtonsArray[3].center.y = self.view.frame.height + 100;
            self.varButtonsArray[4].center.x = -100;
            self.varButtonsArray[4].center.y = self.view.frame.height - 50;
            self.varButtonsArray[5].center.x = -100;
            self.varButtonsArray[5].center.y = -50;
            
        })
        UIView.animate(withDuration: 0.001, delay: 1, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.centerAllButtonsAnimation();
        }) { (a) in
            if self.NrPage == 0
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i]), for: UIControlState.normal)
                }
            }
            else
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 36]), for: UIControlState.normal)
                }
            }
        }
        UIView.animate(withDuration: 0.001, delay: 0.001, options: UIViewAnimationOptions(rawValue: 0), animations: {
            for i in 0...5
            {
                self.varButtonsArray[i].alpha = 1;
            }
        })
        UIView.animate(withDuration: 0.4, delay: 1.0 , usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.chooseDevice()
        })
    }
    
    
    
    func animateButt2()
    {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[1].center.y = self.varButton_center.center.y;
            self.varButtonsArray[1].center.x = self.varButton_center.center.x;
        })
        UIView.animate(withDuration: 0.1, animations: {
            self.varButton_center.alpha = 0;
        })
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[0].center.y = -100;
            self.varButtonsArray[2].center.x = self.view.frame.width + 100;
            self.varButtonsArray[2].center.y = self.view.frame.height + 50;
            self.varButtonsArray[3].center.y = self.view.frame.height + 100;
            self.varButtonsArray[4].center.x = -100;
            self.varButtonsArray[4].center.y = self.view.frame.height - 5
            self.varButtonsArray[5].center.x = -100;
            self.varButtonsArray[5].center.y = -50;
            
        })
        UIView.animate(withDuration: 0.001, delay: 1, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.centerAllButtonsAnimation();
        }) { (a) in
            if self.NrPage == 0
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 6]), for: UIControlState.normal)
                }
            }
            else
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 42]), for: UIControlState.normal)
                }
            }
            
        }
        UIView.animate(withDuration: 0.001, delay: 0.001, options: UIViewAnimationOptions(rawValue: 0), animations: {
            for i in 0...5
            {
                   self.varButtonsArray[i].alpha = 1;
            }
        })
        UIView.animate(withDuration: 0.4, delay: 1.0 , usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.chooseDevice()
        })
    }
    
    func animateButt3()
    {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[2].center.y = self.varButton_center.center.y;
            self.varButtonsArray[2].center.x = self.varButton_center.center.x;
        })
        
        UIView.animate(withDuration: 0.1, animations: {
            self.varButton_center.alpha = 0;
        })
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[0].center.y = -100;
            self.varButtonsArray[1].center.x = self.view.frame.width + 100;
            self.varButtonsArray[1].center.y = -50;
            self.varButtonsArray[3].center.y = self.view.frame.height + 100;
            self.varButtonsArray[4].center.x = -100;
            self.varButtonsArray[4].center.y = self.view.frame.height - 5
            self.varButtonsArray[5].center.x = -100;
            self.varButtonsArray[5].center.y = -50;
        })
        
        //=========================== TEST Part : ==================
        UIView.animate(withDuration: 0.001, delay: 1, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.centerAllButtonsAnimation();
        }) { (a) in
            if self.NrPage == 0
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 12]), for: UIControlState.normal)
                }
            }
            else
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 48]), for: UIControlState.normal)
                }
            }
        }
        UIView.animate(withDuration: 0.001, delay: 0.001, options: UIViewAnimationOptions(rawValue: 0), animations: {
            for i in 0...5
            {
                self.varButtonsArray[i].alpha = 1;
            }
        })
        UIView.animate(withDuration: 0.4, delay: 1.0 , usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.chooseDevice()
        })
    }
    
    func animateButt4()
    {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[3].center.y = self.varButton_center.center.y;
            self.varButtonsArray[3].center.x = self.varButton_center.center.x;
        })
        
        UIView.animate(withDuration: 0.1, animations: {
            self.varButton_center.alpha = 0;
        })
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[0].center.y = -100;
            self.varButtonsArray[1].center.x = self.view.frame.width + 100;
            self.varButtonsArray[1].center.y = -50;
            self.varButtonsArray[2].center.x = self.view.frame.width + 100;
            self.varButtonsArray[2].center.y = self.view.frame.height + 50;
            self.varButtonsArray[4].center.x = -100;
            self.varButtonsArray[4].center.y = self.view.frame.height - 5
            self.varButtonsArray[5].center.x = -100;
            self.varButtonsArray[5].center.y = -50;
        })
        
        //=========================== TEST Part : ==================
        UIView.animate(withDuration: 0.001, delay: 1, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.centerAllButtonsAnimation();
        })
        { (a) in
            if self.NrPage == 0
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 18]), for: UIControlState.normal)
                }
            }
            else
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 54]), for: UIControlState.normal)
                }
            }
        }
        UIView.animate(withDuration: 0.001, delay: 0.001, options: UIViewAnimationOptions(rawValue: 0), animations: {
            for i in 0...5
            {
                self.varButtonsArray[i].alpha = 1;
            }
        })
        UIView.animate(withDuration: 0.4, delay: 1.0 , usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.chooseDevice()
        })
    }
    
    func animateButt5()
    {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[4].center.y = self.varButton_center.center.y;
            self.varButtonsArray[4].center.x = self.varButton_center.center.x;
        })
        
        UIView.animate(withDuration: 0.1, animations: {
            self.varButton_center.alpha = 0;
        })
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[0].center.y = -100;
            self.varButtonsArray[1].center.x = self.view.frame.width + 100;
            self.varButtonsArray[1].center.y = -50;
            self.varButtonsArray[2].center.x = self.view.frame.width + 100;
            self.varButtonsArray[2].center.y = self.view.frame.height + 50;
            self.varButtonsArray[3].center.y = self.view.frame.height + 100;
            self.varButtonsArray[5].center.x = -100;
            self.varButtonsArray[5].center.y = -50;
        })
        
        //=========================== TEST Part : ==================
        UIView.animate(withDuration: 0.001, delay: 1, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.centerAllButtonsAnimation();
        }) { (a) in
            if self.NrPage == 0
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 24]), for: UIControlState.normal)
                }
            }
            else
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 60]), for: UIControlState.normal)
                }
            }
        }
        //=================== END TEST Part =========================
        
        
        UIView.animate(withDuration: 0.001, delay: 0.001, options: UIViewAnimationOptions(rawValue: 0), animations: {
            for i in 0...5
            {
                self.varButtonsArray[i].alpha = 1;
            }
        })
        
        UIView.animate(withDuration: 0.4, delay: 1.0 , usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.chooseDevice()
        })
    }
    
    func animateButt6()
    {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[5].center.y = self.varButton_center.center.y;
            self.varButtonsArray[5].center.x = self.varButton_center.center.x;
        })
        
        UIView.animate(withDuration: 0.1, animations: {
            self.varButton_center.alpha = 0;
        })
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.varButtonsArray[0].center.y = -100;
            self.varButtonsArray[1].center.x = self.view.frame.width + 100;
            self.varButtonsArray[1].center.y = -50;
            self.varButtonsArray[2].center.x = self.view.frame.width + 100;
            self.varButtonsArray[2].center.y = self.view.frame.height + 50;
            self.varButtonsArray[3].center.y = self.view.frame.height + 100;
            self.varButtonsArray[4].center.x = -100;
            self.varButtonsArray[4].center.y = self.view.frame.height - 5
            
        })
        
        //=========================== TEST Part : ==================
        UIView.animate(withDuration: 0.001, delay: 1, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.centerAllButtonsAnimation();
        }) { (a) in
            if self.NrPage == 0
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 30]), for: UIControlState.normal)
                }
            }
            else
            {
                self.Activare_imagine()
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[i + 66]), for: UIControlState.normal)
                }
            }
        }
        //=================== END TEST Part =========================
        
        
        UIView.animate(withDuration: 0.001, delay: 0.001, options: UIViewAnimationOptions(rawValue: 0), animations: {
            for i in 0...5
            {
                self.varButtonsArray[i].alpha = 1;
            }
        })
        
        UIView.animate(withDuration: 0.4, delay: 1.0 , usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.chooseDevice();
        })
    }
    
    func centerAllButtonsAnimation()
    {
        self.varButtonsArray[0].alpha = 1;
        self.varButtonsArray[0].center.x = self.varButton_center.center.x
        self.varButtonsArray[0].center.y = self.varButton_center.center.y
        
        self.varButtonsArray[1].alpha = 1;
        self.varButtonsArray[1].center.x = self.varButton_center.center.x
        self.varButtonsArray[1].center.y = self.varButton_center.center.y
        
        self.varButtonsArray[2].alpha = 1;
        self.varButtonsArray[2].center.x = self.varButton_center.center.x
        self.varButtonsArray[2].center.y = self.varButton_center.center.y
        
        self.varButtonsArray[3].alpha = 1;
        self.varButtonsArray[3].center.x = self.varButton_center.center.x
        self.varButtonsArray[3].center.y = self.varButton_center.center.y
        
        self.varButtonsArray[4].alpha = 1;
        self.varButtonsArray[4].center.x = self.varButton_center.center.x
        self.varButtonsArray[4].center.y = self.varButton_center.center.y;
        
        self.varButtonsArray[5].alpha = 1;
        self.varButtonsArray[5].center.x = self.varButton_center.center.x
        self.varButtonsArray[5].center.y = self.varButton_center.center.y
    }
    
    func animateButtcent()
    {
        UIView.animate(withDuration: 0.4, delay: 0,usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            
            self.centerAllButtonsAnimation();
        }) { (a) in
            if self.NrPage == 0
            {
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[self.categoryImageIndex[i]]), for: UIControlState.normal)
                }
            }
            else
            {
                for i in 0...5
                {
                    self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[self.categoryImageIndex[i + 6]]), for: UIControlState.normal)
                }
            }
        }
        UIView.animate(withDuration: 0.001, delay: 0.001, options: UIViewAnimationOptions(rawValue: 0), animations: {
            for i in 0...5
            {
                self.varButtonsArray[i].alpha = 1;
            }
        })
        UIView.animate(withDuration: 0.2, delay: 1.0 , usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.chooseDevice()
        })
    }
    
    @IBAction func sendeButton(_ sender: UIButton) {
        Button_ID = sender.tag
        if (On_Page == false)
        {
            On_Page = true;
            switch NrPage
            {
            case 0:
                categorySelected = 1+sender.tag-1;
                
            case 1:
                categorySelected = 7+sender.tag-1;
            default:
                print("something went wrong")
            }
            
            categoryLabel.text = categoryName[categorySelected - 1]
            
            UIView.animate(withDuration: 0.55, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {
                let grow = CGAffineTransform(scaleX: 1.3, y: 1.3)
                let angle = CGFloat(0)
                let rotate = CGAffineTransform(rotationAngle: angle)
                self.categoryLabel.transform = grow.concatenating(rotate)
                self.categoryLabel.alpha = 1;
            })
            
            UIView.animate(withDuration: 0.55, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {
                let grow = CGAffineTransform(scaleX: 0.2, y: 0.2)
                let angle = CGFloat(0)
                let rotate = CGAffineTransform(rotationAngle: angle)
                self.pageControl.transform = grow.concatenating(rotate)
                self.pageControl.alpha = 0;
            })
            for i in 0...5
            {
                self.varButtonsArray[i].setBackgroundImage(UIImage(named:imagini[self.categoryImageIndex[i + 6]]), for: UIControlState.normal)
            }
            switch sender.tag{
            case 1:
                if self.NrPage == 0
                {
                    self.varButtonsArray[0].setBackgroundImage(UIImage(named:imagini[4]), for: UIControlState.normal)
                }
                else
                {
                    self.varButtonsArray[0].setBackgroundImage(UIImage(named:imagini[36]), for: UIControlState.normal)
                }
                
                animateButt1()
            case 2:
                if self.NrPage == 0
                {
                    self.varButtonsArray[1].setBackgroundImage(UIImage(named:imagini[11]), for: UIControlState.normal)
                }
                else
                {
                    self.varButtonsArray[1].setBackgroundImage(UIImage(named:imagini[47]), for: UIControlState.normal)
                }
                
                animateButt2()
            case 3:
                if self.NrPage == 0
                {
                    self.varButtonsArray[2].setBackgroundImage(UIImage(named:imagini[14]), for: UIControlState.normal)
                }
                else
                {
                    self.varButtonsArray[2].setBackgroundImage(UIImage(named:imagini[50]), for: UIControlState.normal)
                }
                animateButt3()
            case 4:
                if self.NrPage == 0
                {
                    self.varButtonsArray[3].setBackgroundImage(UIImage(named:imagini[20]), for: UIControlState.normal)
                }
                else
                {
                    self.varButtonsArray[3].setBackgroundImage(UIImage(named:imagini[54]), for: UIControlState.normal)
                }
                animateButt4()
            case 5:
                if self.NrPage == 0
                {
                    self.varButtonsArray[4].setBackgroundImage(UIImage(named:imagini[29]), for: UIControlState.normal)
                }
                else
                {
                    self.varButtonsArray[4].setBackgroundImage(UIImage(named:imagini[64]), for: UIControlState.normal)
                }
                
                animateButt5()
            case 6:
                if self.NrPage == 0
                {
                    self.varButtonsArray[5].setBackgroundImage(UIImage(named:imagini[31]), for: UIControlState.normal)
                }
                else
                {
                    self.varButtonsArray[5].setBackgroundImage(UIImage(named:imagini[69]), for: UIControlState.normal)
                }
                animateButt6()
            default:
                break
            }
            
        }
        else
        {
            switch categorySelected {
            case 1:
                audioPlay(i: 0+sender.tag-1, sender)
            case 2:
                audioPlay(i: 6+sender.tag-1, sender)
            case 3:
                audioPlay(i: 12+sender.tag-1, sender)
            case 4:
                audioPlay(i: 18+sender.tag-1, sender)
            case 5:
                audioPlay(i: 24+sender.tag-1, sender)
            case 6:
                audioPlay(i: 30+sender.tag-1, sender)
            case 7:
                audioPlay(i: 36+sender.tag-1, sender)
            case 8:
                audioPlay(i: 42+sender.tag-1, sender)
            case 9:
                audioPlay(i: 48+sender.tag-1, sender)
            case 10:
                audioPlay(i: 54+sender.tag-1, sender)
            case 11:
                audioPlay(i: 60+sender.tag-1, sender)
            case 12:
                audioPlay(i: 66+sender.tag-1, sender)
            default:
                print("keeeek")
            }
        }
    }
    /////////
    
    func Activare_imagine() {
        if On_Page == true{
            for cauta in categorySelected * 6 - 6...categorySelected * 6 - 1{
                if block[cauta] == 0{
                    let set_block = cauta - ((cauta / 6) * 6)
                    switch set_block {
                    case 0, 6:
                        varButtonsArray[0].setImage(#imageLiteral(resourceName: "Block2"), for: .normal)
                    case 1, 7:
                        varButtonsArray[1].setImage(#imageLiteral(resourceName: "Block2"), for: .normal)
                    case 2, 8:
                        varButtonsArray[2].setImage(#imageLiteral(resourceName: "Block2"), for: .normal)
                    case 3, 9:
                        varButtonsArray[3].setImage(#imageLiteral(resourceName: "Block2"), for: .normal)
                    case 4, 10:
                        varButtonsArray[4].setImage(#imageLiteral(resourceName: "Block2"), for: .normal)
                    case 5, 11:
                        varButtonsArray[5].setImage(#imageLiteral(resourceName: "Block2"), for: .normal)
                    default:
                        print("Ciburec")
                        break
                    }
                }
                if audioPL[cauta].isPlaying{
                    let set_imagi = cauta - ((cauta / 6) * 6)
                    switch set_imagi {
                    case 0:
                        varButtonsArray[0].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 1:
                        varButtonsArray[1].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 2:
                        varButtonsArray[2].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 3:
                        varButtonsArray[3].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 4:
                        varButtonsArray[4].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 5:
                        varButtonsArray[5].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 6:
                        varButtonsArray[0].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 7:
                        varButtonsArray[1].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 8:
                        varButtonsArray[2].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 9:
                        varButtonsArray[3].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 10:
                        varButtonsArray[4].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    case 11:
                        varButtonsArray[5].setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                    default:
                        print("Ciburec")
                    }
                }
            }
        }
    }
    
    
    
    func audioPlay(i : Int, _ sender: UIButton)
    {
        if block[i] == 1{
            if audioPL[i].isPlaying == true
            {
                audioPL[i].pause()
                audioPL[i].currentTime = 0
                sender.setImage(nil, for: .normal)
                if ListPlay.count > 0{
                    for x in 0...ListPlay.count-1
                    {
                        if ListPlay[x] == i
                        {
                            ListPlay.remove(at: x)
                            listVolum.remove(at: x)
                            break
                        }
                    }
                }
            }
            else
            {
                sender.setImage(#imageLiteral(resourceName: "1_selected_sound_stroke"), for: .normal)
                audioPL[i].play()
                audioPL[i].volume = 0.5
                ListPlay.append(i)
                listVolum.append(audioPL[i].volume)
            }
        }
        else{
            createAlert(title: "Is locked", message: "In order to access the sound, please upgrade")
        }
    }
    
    func createAlert(title:String, message:String){
        let alert2 = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert2.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert2, animated: true, completion:  nil);
    }
    
    @IBAction func Button_centere(_ sender: UIButton) {
        Button_ID = -1
        On_Page = false
        self.pageControl.alpha = 1;
        
        UIView.animate(withDuration: 0.55, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            let grow = CGAffineTransform(scaleX: 0.2, y: 0.2)
            let angle = CGFloat(0)
            let rotate = CGAffineTransform(rotationAngle: angle)
            self.categoryLabel.transform = grow.concatenating(rotate)
            self.categoryLabel.alpha = 0;
        })
        
        UIView.animate(withDuration: 0.55, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            let grow = CGAffineTransform(scaleX: 1.3, y: 1.3)
            let angle = CGFloat(0)
            let rotate = CGAffineTransform(rotationAngle: angle)
            self.pageControl.transform = grow.concatenating(rotate)
            self.pageControl.alpha = 1;
        })
        
        if On_Page == false{
            for i in 0...5
            {
                varButtonsArray[i].setImage(nil, for: .normal)
                varButtonsArray[i].isUserInteractionEnabled = true
            }
        }
        // Animation Part
        animateButtcent();
    }
    
    @IBAction func Sharing_button(_ sender: UIButton) {
        let alert = UIAlertController(title: "Share", message: "HexaGon", preferredStyle: .actionSheet)
        let actionFacebook = UIAlertAction(title: "Share on Facebook", style: .default) { (action) in
            
            let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
            vc?.add(#imageLiteral(resourceName: "ShareImage"))
            //        vc.add(URL(string: "http://www.example.com/"))
            vc?.setInitialText("Try out my new composition!")
            self.present(vc!, animated: true, completion: nil)
            
        }
        
        let actionTwitter = UIAlertAction(title: "Share on Twitter", style: .default) { (action) in
            
            let vc = SLComposeViewController(forServiceType:SLServiceTypeTwitter)
            vc?.add(#imageLiteral(resourceName: "ShareImage"))
            //     vc.add(URL(string: "http://www.example.com/"))
            vc?.setInitialText("Try out my new composition!")
            self.present(vc!, animated: true, completion: nil)
            
        }
        
        let action_cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(actionFacebook)
        alert.addAction(actionTwitter)
        alert.addAction(action_cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func Show_alert(service: String){
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func rateUsButton(_ sender: UIButton)
    {
        let alert3 = UIAlertController(title: "Soon", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert3.addAction(action)
        self.present(alert3, animated: true, completion:  nil);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "delegate" {
            let tttt: AddNewSong_Class = segue.destination as! AddNewSong_Class
            tttt.Clasa_main = self
        }
        if segue.identifier == "delegate2" {
            let tttt: Favorit_ViewController = segue.destination as! Favorit_ViewController
            tttt.Clasa_main = self
        }
    }
    
    func Upgrade_complet(){
        Upgrade = true
        for x in 0...block.count-1{
            block[x] = 1
        }
        UserDefaults.standard.set(block, forKey: "saveblock")
        UserDefaults.standard.set(self.Upgrade, forKey: "saveUpgrade")
        varUpgradeButton.isHidden = true
        bannerView.isHidden = true
        Activare_imagine()
    }
    
    func class_upgrade(){

        BannerReviewClass.sharedInstance().is(on: "com.fitnesslabs.RMusic.Upgrade", doF: {
            self.Upgrade_complet()
        }) { 
            BannerReviewClass.sharedInstance().getOn("com.fitnesslabs.RMusic.Upgrade", andDo: {
                self.Upgrade_complet()
            }, elseDoS: {
                BannerReviewClass.sharedInstance().is(on: "com.fitnesslabs.RMusic.Upgrade", doF: {
                    self.Upgrade_complet()
                }) {
                    print("haha")
                }
            }, in: self.view)
        }
    }
    
    @IBAction func Upgrade(_ sender: UIButton) {
        let alert = UIAlertController(title: "Upgrade", message: nil, preferredStyle: .actionSheet)
        let butupgrade = UIAlertAction(title: "Upgrade", style: .default) { (UIAlertAction) in
            self.class_upgrade()
        }
        let butrestor = UIAlertAction(title: "Restore", style: .destructive) { (UIAlertAction) in
            BannerReviewClass.sharedInstance().reset(self.view, comp: { (Bool) in
                self.class_upgrade()
            })
        }
        let butcancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(butupgrade)
        alert.addAction(butrestor)
        alert.addAction(butcancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func suport_mail(_ sender: UIButton) {
        BannerReviewClass.sharedInstance().support(self, andEmail: "badrajan.alen@gmail.com")
    }
}

