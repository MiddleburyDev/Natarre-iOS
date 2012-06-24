//
//  NSString+uploadHash.h
//  Toast
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "Constants.h"

#import <Foundation/Foundation.h>
#import "NSString+MD5.h"

@interface NSString (uploadHash)

-(NSString *)uploadHash;

@end
