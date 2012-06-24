//
//  NSString+uploadHash.m
//  Toast
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "NSString+uploadHash.h"

@implementation NSString (uploadHash)

-(NSString *)uploadHash {
    NSString * concatonatedString = [self stringByAppendingString:kTNBUploadSalt];
    
    return [concatonatedString MD5];
}

@end
