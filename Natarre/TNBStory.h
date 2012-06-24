//
//  TNBStory.h
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNBStory : NSObject {
    NSInteger storyID;
    NSInteger authorID;
    NSString * authorName;
    NSDate * dateCreated;
    NSString * title;
    NSString * content;
    NSString * audioURL;
}

@property(nonatomic)NSInteger storyID;
@property(nonatomic)NSInteger authorID;
@property(nonatomic, strong)NSString * authorName;
@property(nonatomic, strong)NSDate * dateCreated;
@property(nonatomic, strong)NSString * title;
@property(nonatomic, strong)NSString * content;
@property(nonatomic, strong)NSString * audioURL;

@end
