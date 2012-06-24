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
    #warning Incomplete implementation
    // Parse JSON
    
    // Build an array of story objects
    
    // Pass the array to the delegate
}

@end

@implementation TNBStoriesManager (NSURLConnectionDelegate)

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
    NSLog(@"Upload connection received partial response: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", error);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Connection did finish loading.");
    NSData * data = [NSData dataWithData:receivedData];
    [self handleResponse:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
}

-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    
}

@end
