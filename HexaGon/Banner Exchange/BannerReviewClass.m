//
//  BannerReviewClass.m
//  Locker
//
//  Created by Mihail on 10.11.14.
//  Copyright (c) 2014 Mihail. All rights reserved.
//

#import "BannerReviewClass.h"
#import <CommonCrypto/CommonDigest.h>

#define NC [NSNotificationCenter defaultCenter]


@implementation BannerReviewClass

+ (BannerReviewClass *)sharedInstance
{
    static BannerReviewClass* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BannerReviewClass alloc] init];
        [[MKStoreKit sharedKit] startProductRequest];
    });
    return sharedInstance;
}


- (BOOL)connected{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return (networkStatus != NotReachable);
}

#pragma mark - SUPPORT
- (void)support:(id)controller andEmail:(NSString *)email{
    self.controller2 = controller;
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    if (mailController != nil){
        NSString *device = @"";
        if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && [UIScreen mainScreen].scale == 2.0) {
            device = (isIpad) ? @"ipad_retina" : @"iphone_retina";
        }else{
            device = (isIpad) ? @"ipad" : @"iphone";
        }
        mailController.mailComposeDelegate = self;
        [mailController setToRecipients:@[email]];
        [mailController setSubject:[NSString stringWithFormat:@"From %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]]];
        NSString *text = [NSString stringWithFormat:@"Device: %@\nBundle: %@\nApplication version: %@\nSystem version: %@", device, [[NSBundle mainBundle] bundleIdentifier], [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] systemVersion]];
        [mailController setMessageBody:text isHTML:false];
        [controller presentViewController:mailController animated:true completion:nil];
    }
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self.controller2 dismissViewControllerAnimated:true completion:nil];
    self.controller2 = nil;
}
- (NSString *)md5String:(NSString *)string{
    const char *cstr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

- (void)isOn:(NSString *)string doF:(void (^)())block1 elseDoS:(void(^)())block2{
    if ([[MKStoreKit sharedKit] isProductPurchased:string]){
        if (block1 != nil){
            block1();
        }
    }else{
        if (block2 != nil){
            block2();
        }
    }
}

- (void)getOn:(NSString *)string andDo:(void (^)())block1 elseDoS:(void (^)())block2 inView:(UIView *)view{
    [LoadingView startLoadIn:view];
    if ([self connected]) {
        [NC addObserverForName:kMKStoreKitProductPurchasedNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        [NC removeObserver:kMKStoreKitProductPurchasedNotification];
                        if ([note object] == string){
                            if (block1 != nil){
                                block1();
                            }
                            [LoadingView removeLoading];
                        }else{
                            if (block2 != nil){
                                block2();
                            }
                            [LoadingView removeLoading];
                        }
                    }];
        [NC addObserverForName:kMKStoreKitProductPurchaseFailedNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        [NC removeObserver:kMKStoreKitProductPurchaseFailedNotification];
                        if (block2 != nil){
                            block2();
                        }
                        [LoadingView removeLoading];
                    }];
        [NC addObserverForName:kMKStoreKitProductPurchaseDeferredNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        [NC removeObserver:kMKStoreKitProductPurchaseDeferredNotification];
                        if (block2 != nil){
                            block2();
                        }
                        [LoadingView removeLoading];
                    }];
        [[MKStoreKit sharedKit] initiatePaymentRequestForProductWithIdentifier:string];
    } else {
        [LoadingView removeLoading];
    }}
//- (void)showSimpleMessage:(NSString *)message andTitle:(NSString *)title{
- (void)showSimple:(NSString *)message andTitle:(NSString *)title{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    [alert addAction:cancelAction];
    UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [currentVc presentViewController:alert animated:true completion:nil];
}
- (void)reset:(UIView *)view comp:(void(^)(BOOL))comp{
    if (view != nil){
        [LoadingView startLoadIn:view];
    }
    
    if ([self connected]) {
        [NC addObserverForName:kMKStoreKitRestoringPurchasesFailedNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        [NC removeObserver:kMKStoreKitRestoringPurchasesFailedNotification];
                        [self showSimple:@"Not restored purchases!" andTitle:@"Error"];
                        [LoadingView removeLoading];
                        if (comp != nil){
                            comp(false);
                        }
                    }];
        [NC addObserverForName:kMKStoreKitRestoredPurchasesNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        [NC removeObserver:kMKStoreKitRestoredPurchasesNotification];
                        [self showSimple:@"Successfully restored!" andTitle:@"Restored!"];
                        [LoadingView removeLoading];
                        if (comp != nil){
                            comp(true);
                        }
                    }];
        [[MKStoreKit sharedKit] restorePurchases];
    } else {
        [LoadingView removeLoading];
        if (comp != nil){
            comp(false);
        }
    }
}

#pragma mark - StopKit

- (void)openAppInAppStore:(NSString *)itunesID inController:(UIViewController *)controller{
    self.controller2 = controller;
    [LoadingView startLoadIn:controller.view];
    if ([[BannerReviewClass sharedInstance] connected]){
        NSString *itunesLink = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", itunesID];
        NSData *jsonData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:itunesLink]];
        if (jsonData != nil){
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
            if ([data[@"resultCount"] integerValue] != 0){
                SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
                [storeProductViewController setDelegate:self];
                [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : itunesID}
                                                      completionBlock:^(BOOL result, NSError *error) {
                                                          if (error) {
                                                              NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
                                                          }else{
                                                              [self.controller2 presentViewController:storeProductViewController animated:true completion:nil];
                                                          }
                                                          [LoadingView removeLoading];
                                                      }];
            }else{
                [LoadingView removeLoading];
            }
        }else{
            [LoadingView removeLoading];
        }
    }else{
        [LoadingView removeLoading];
    }
}
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self.controller2 dismissViewControllerAnimated:true completion:nil];
    self.controller2 = nil;
}


@end
