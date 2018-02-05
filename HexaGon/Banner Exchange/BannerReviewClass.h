//
//  BannerReviewClass.h
//  Locker
//
//  Created by Mihail on 10.11.14.
//  Copyright (c) 2014 Mihail. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"
#import "AFNetworking.h"
#import <MessageUI/MessageUI.h>
#import "MKStoreKit.h"
#import <StoreKit/StoreKit.h>
#import "LoadingView.h"

#define isIpad ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)

@interface BannerReviewClass : NSObject <MFMailComposeViewControllerDelegate, SKStoreProductViewControllerDelegate>


@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) UIViewController *controller2;

+ (BannerReviewClass *)sharedInstance;

- (BOOL)connected;
- (void)showSimple:(NSString *)message andTitle:(NSString *)title;
- (void)support:(id)controller andEmail:(NSString *)email;

//-----
- (void)isOn:(NSString *)string doF:(void (^)())block1 elseDoS:(void(^)())block2;
- (void)getOn:(NSString *)string andDo:(void (^)())block1 elseDoS:(void (^)())block2 inView:(UIView *)view;
- (void)reset:(UIView *)view comp:(void(^)(BOOL))comp;
- (NSString *)md5String:(NSString *)string;

//-----
- (void)openAppInAppStore:(NSString *)itunesID inController:(UIViewController *)controller;

@end
