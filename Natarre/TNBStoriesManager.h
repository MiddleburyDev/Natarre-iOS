//
//  TNBStoriesManager.h
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TNBStory.h"

@protocol TNBStoriesManagerDelegate

@optional

-(void)successfullyDownloadedStories:(NSArray *)stories;

@end

@interface TNBStoriesManager : NSObject {
    id delegate;
    NSURLConnection * currentConnection;
    NSURLRequest * currentRequest;
    NSMutableData * receivedData;
}

@property(nonatomic, strong)id delegate;

-(void)generateRequestWithKeyPairs:(NSDictionary *)keyPairs sendToURL:(NSURL *)apiURL;
-(void)sendGeneratedRequest;

@end
