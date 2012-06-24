//
//  NSString+downloadHash.m
//  Toast
//
//  Created by Thomas Beatty on 6/12/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "NSString+downloadHash.h"

@implementation NSString (downloadHash)

-(NSString *)downloadHash {
    NSString * concatonatedString = [self stringByAppendingString:kTNBDownloadSalt];
    
    return [concatonatedString MD5];
}

@end
