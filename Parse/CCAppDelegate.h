//
//  CCAppDelegate.h
//  Parse
//
//  Created by Eliot Arntz on 8/13/13.
//  Copyright (c) 2013 Eliot Arntz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCViewController;

@interface CCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CCViewController *viewController;

@end
