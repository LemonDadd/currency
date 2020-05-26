//
//  AppDelegate.m
//  currency
//
//  Created by 关云秀 on 2020/5/26.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    BaseTabBarViewController *tabBarController = [[BaseTabBarViewController alloc]init];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
