//
//  BIAppDelegate.m
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "BIAppDelegate.h"
#import "BIFormViewController.h"

@implementation BIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
        NSNumber *string = @(STRING);
        NSNumber *email = @(EMAIL);
        NSNumber *date = @(DATE);
        NSNumber *option = @(OPTION);
        NSNumber *weight = @(NUMBER);
        NSNumber *image = @(IMAGE);
    
        NSDictionary *info = @{
            // Section 01
            NSLocalizedString(@"Personal Information", nil): @[
                // field name, default value, field type
                @[NSLocalizedString(@"Name", nil), @"", string],
                @[NSLocalizedString(@"Email", nil), @"", email],
                @[NSLocalizedString(@"Hometown", nil), @"", string],
                @[NSLocalizedString(@"Weight", nil), @"", weight],
                @[NSLocalizedString(@"Birthday", nil), @"", date],
                @[NSLocalizedString(@"MarioIcon", nil), @"teste", image, @"mario.png"],
                @[
                    NSLocalizedString(@"Gender", nil),
                    @"",
                    option,
                    @[
                        NSLocalizedString(@"Male", nil),
                        NSLocalizedString(@"Female", nil),
                    ]
                ]
            ],
            // Section 02
            NSLocalizedString(@"Interests", nil): @[
                // field name, default value, field type
                @[NSLocalizedString(@"Field 01", nil), @"Value 01", string],
                @[NSLocalizedString(@"Field 02", nil), @"Value 02", string]
            ]
        };
    
    BIFormViewController *form = [[BIFormViewController alloc] initWithInfo:info];
    
    self.window.rootViewController = form;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
