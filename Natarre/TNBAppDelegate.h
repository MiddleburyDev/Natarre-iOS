//
//  TNBAppDelegate.h
//  Natarre
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNBLoginManager.h"

@interface TNBAppDelegate : UIResponder <UIApplicationDelegate> {
    TNBLoginManager * loginManager;
}

@property (strong, nonatomic) UIWindow *window;

// Application Managers

@property(nonatomic, strong)TNBLoginManager * loginManager;

@end
