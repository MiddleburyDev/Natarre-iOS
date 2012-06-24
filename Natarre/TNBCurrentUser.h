//
//  TNBCurrentUser.h
//  Natarre
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNBCurrentUser : NSObject {
    NSString * email;
    NSString * token;
    NSNumber * userID;
}

@property(nonatomic, strong)NSString * email;
@property(nonatomic, strong)NSString * token;
@property(nonatomic, strong)NSNumber * userID;

+(TNBCurrentUser *)currentUserWithEmail:(NSString *)theEmail userID:(NSNumber *)theUserID token:(NSString *)theToken;

@end
