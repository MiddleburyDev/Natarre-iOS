//
//  TNBCurrentUser.m
//  Natarre
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBCurrentUser.h"

@implementation TNBCurrentUser

@synthesize email, token, userID;

+(TNBCurrentUser *)currentUserWithEmail:(NSString *)theEmail userID:(NSNumber *)theUserID token:(NSString *)theToken {
    
    TNBCurrentUser * currentUser = [[TNBCurrentUser alloc] init];
    
    currentUser.email = theEmail;
    currentUser.userID = theUserID;
    currentUser.token = theToken;
    
    return currentUser;
}

@end
