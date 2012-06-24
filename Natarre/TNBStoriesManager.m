//
//  TNBStoriesManager.m
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBStoriesManager.h"

@interface TNBStoriesManager (NSURLConnectionDelegate) <NSURLConnectionDelegate>

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
-(void)connectionDidFinishLoading:(NSURLConnection *)connection;
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;

@end

@interface TNBStoriesManager (InternalMethods)

-(void)handleResponse:(NSData *)data;

@end

@implementation TNBStoriesManager

@synthesize delegate;

-(NSInteger)thisWeeksPrompt {
    NSLog(@"TNBStoriesManager: Will generate POST request");
    
    TNBCurrentUser * user = [[TNBLoginManager defaultManager] currentUser];
    
    NSDictionary * args = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:user.email, user.token, nil] forKeys:[NSArray arrayWithObjects:@"email", @"token", nil]];
    
    // Set the params for the request
    NSMutableString * params = [NSMutableString stringWithCapacity:200];
    NSString * key;
    for (key in args) {
        NSLog(@"TNBStoriesManager: Appending value: %@ for key: %@ to the params.", [args objectForKey:key], key);
        [params appendString:[NSString stringWithFormat:@"%@=%@&", key, [args objectForKey:key]]];
    }
    
    // Generate the request
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kTNBThisWeekPromptURL]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Keep track of any errors
    NSError * error;
    
    // Send the request
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSLog(@"Response: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    
    if (!responseData) return 0;
    
    NSError * theError;
    NSDictionary * responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&theError];
    
    // Returns nil if there was an error
    if (error) {
        NSLog(@"TNBStoriesManager: !!!Error occurred while sending the post request: %@.", error);
        
        return 0;
    }
    return (NSInteger)[responseDictionary objectForKey:@"id"];
}

-(void)generateRequestWithKeyPairs:(NSDictionary *)keyPairs sendToURL:(NSURL *)apiURL {
    NSLog(@"TNBStoriesManager: Will generate POST request to send to %@.", [apiURL absoluteURL]);
    
    // Set the params for the request
    NSMutableString * params = [NSMutableString stringWithCapacity:200];
    NSString * key;
    for (key in keyPairs) {
        NSLog(@"TNBStoriesManager: Appending value: %@ for key: %@ to the params.", [keyPairs objectForKey:key], key);
        [params appendString:[NSString stringWithFormat:@"%@=%@&", key, [keyPairs objectForKey:key]]];
    }
    
    // Generate the request
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:apiURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    currentRequest = request;
}

-(void)sendGeneratedRequest {
    currentConnection = [[NSURLConnection alloc] initWithRequest:currentRequest delegate:self];
    currentRequest = nil;
    
    // Get ready to receive data
    receivedData = [[NSMutableData data] init];
    
    // Fire up the connection
    if (currentConnection) {
        [currentConnection start];
    } else {
        NSLog(@"There was an error firing up the connection.");
    }
    
}

@end

@implementation TNBStoriesManager (InternalMethods)

-(void)handleResponse:(NSData *)data {
    // Parse JSON
    NSError * error;
    NSArray * storyDics = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"Error parsing JSON data: %@", error);
        return;
    }
    
    // Build an array of story objects
    NSMutableArray * objects = [[NSMutableArray alloc] initWithCapacity:storyDics.count];
    for (id dic in storyDics) {
        NSLog(@"Parsing dictionary into story");
        TNBStory * story = [[TNBStory alloc] init];
        story.storyID = (NSInteger)[(NSDictionary *)dic objectForKey:@"story_ID"];
        story.authorID = (NSInteger)[dic objectForKey:@"author_ID"];
        story.authorName = [dic objectForKey:@"author_name"];
        story.title = [dic objectForKey:@"title"];
        story.dateCreated = [NSDate dateWithTimeIntervalSince1970:(int)[dic objectForKey:@"date_created"]];
        story.content = [dic objectForKey:@"content"];
        story.audioURL = ([dic objectForKey:@"audio_file_url"] == [NSNull null]) ? nil : [dic objectForKey:@"audio_file_url"];
        [objects addObject:story];
    }
    
    // Pass the array to the delegate
    [self.delegate successfullyDownloadedStories:objects];
}

@end

@implementation TNBStoriesManager (NSURLConnectionDelegate)

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
    //NSLog(@"Upload connection received partial response: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", error);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSData * data = [NSData dataWithData:receivedData];
    NSLog(@"Upload connection loaded response: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    [self handleResponse:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
}

-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    
}

@end
