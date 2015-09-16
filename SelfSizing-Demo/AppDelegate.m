//
//  AppDelegate.m
//  SelfSizing-Demo
//
//  Created by luowei on 15/9/6.
//  Copyright (c) 2015年 wodedata. All rights reserved.
//

#import "AppDelegate.h"
#import "MyCollectionViewController.h"
#import "ViewController.h"
#import "MyTableViewController.h"
#import "MyScrollViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];

//    ViewController *viewController = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
//    viewController.title = @"viewController";
//    viewController.view.backgroundColor = [UIColor whiteColor];
//    viewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:10];

    MyScrollViewController *viewController = [MyScrollViewController new];
    viewController.title = @"ScrollView";
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:10];


    MyTableViewController *tableViewController= [MyTableViewController new];
    tableViewController.title = @"TableView";
    tableViewController.view.backgroundColor = [UIColor grayColor];
    tableViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:12];

    MyCollectionViewController *collectionViewController = [MyCollectionViewController new];
    collectionViewController.title = @"CollectionView";
    collectionViewController.view.backgroundColor = [UIColor lightGrayColor];
    collectionViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:11];

    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:viewController];
    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    UINavigationController *navigationController3 = [[UINavigationController alloc] initWithRootViewController:collectionViewController];

    tabBarController.viewControllers = @[navigationController1,navigationController2,navigationController3];

    self.window.rootViewController = tabBarController;

    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
