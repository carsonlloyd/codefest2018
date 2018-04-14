//
//  ViewController.h
//  PipeCalculator
//
//  Created by Carson Lloyd on 4/14/18.
//  Copyright © 2018 Carson Lloyd. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleSignIn;
#import <GTLRSheets.h>

@interface ViewController : UIViewController <GIDSignInDelegate, GIDSignInUIDelegate>

@property (nonatomic, strong) IBOutlet GIDSignInButton *signInButton;
@property (nonatomic, strong) UITextView *output;
@property (nonatomic, strong) GTLRSheetsService *service;


@end
