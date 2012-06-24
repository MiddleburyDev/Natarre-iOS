//
//  TNBLoginManager.h
//  Natarre
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TNBCurrentUser.h"

@protocol TNBLoginManagerDelegate

@optional
// Login shit
-(void)userWasLoggedInSuccessfully;
-(void)loginDidFailWithError:(NSError *)error;
-(void)userWasLoggedOutSuccessfully;

// Registration shit
-(void)userAccountCreatedSuccessfully;
-(void)userAccountCreationDidFailWithError:(NSError *)error;

@end

@interface TNBLoginManager : NSObject {
    id delegate;
    TNBCurrentUser * currentUser;
}

@property(nonatomic, strong) id delegate;
@property(nonatomic, strong) TNBCurrentUser * currentUser;

+(TNBLoginManager *)defaultManager;

-(BOOL)userIsLoggedIn;

-(void)logUserInWithEmail:(NSString *)email password:(NSString *)password;
-(void)logCurrentUserOut;
-(void)registerNewUserWithName:(NSString *)name email:(NSString *)email password:(NSString *)password;

@end
