//
//  AppDelegate.m
//  PipeCalculator
//
//  Created by Carson Lloyd on 4/14/18.
//  Copyright © 2018 Carson Lloyd. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Initialize Google sign-in.
	[GIDSignIn sharedInstance].clientID = @"347322611122-3j9herohqiepdkkfguo59f42sfaot138.apps.googleusercontent.com";

	return YES;
}

- (BOOL)application:(UIApplication *)app
			openURL:(NSURL *)url
			options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
  			sourceApplication:(NSString *)sourceApplication
		 	annotation:(id)annotation {
				return [[GIDSignIn sharedInstance] handleURL:url
							   sourceApplication:sourceApplication
									  annotation:annotation];
}


@end
