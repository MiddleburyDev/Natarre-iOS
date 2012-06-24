//
//  TNBLoginManager.m
//  Natarre
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBLoginManager.h"
#import "TNBAppDelegate.h"

// Helpers
#import "NSStringMods.h"

@interface TNBLoginManager (InternalMethods)

-(NSData *)sendSynchronousPostRequestTo:(NSURL *)outgoingURL withKeyValuePairs:(NSDictionary *)args;

// Login Handling
-(void)saveLoginEmail:(NSString *)email userID:(NSNumber *)userID token:(NSString *)token;
-(void)refreshLogin;

// Response Validation
-(BOOL)validateResponseToken:(NSString *)token forUserID:(NSNumber *)userID;
-(NSDictionary *)validateResponseData:(NSData *)responseData forError:(NSError *__autoreleasing *)error;
-(BOOL)validateJSON:(NSDictionary *)responseDictionary forServerError:(NSError *__autoreleasing *)error;
@end

@implementation TNBLoginManager

@synthesize delegate;
@synthesize currentUser;

-(id)init {
    if (self) {
        
        [self refreshLogin];
        
    }
    return self;
}

+(TNBLoginManager *)defaultManager {
    return (TNBLoginManager *)[(TNBAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager];
}

-(BOOL)userIsLoggedIn {
    return (self.currentUser) ? YES : NO;
}

#pragma mark - Login Handling

-(void)logUserInWithEmail:(NSString *)email password:(NSString *)password {
    NSDictionary * keyValuePairs = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:email, password.MD5, email.uploadHash, nil] 
                                                               forKeys:[NSArray arrayWithObjects:@"email", @"password", @"token", nil]];
    NSData * responseData = [self sendSynchronousPostRequestTo:[NSURL URLWithString:kTNBLoginURL] 
                                             withKeyValuePairs:keyValuePairs];
    
    NSLog(@"TNBLoginManager: Returned Data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    // Check for errors
    NSError * error;
    NSDictionary * responseDictionary = [self validateResponseData:responseData forError:&error];
    // Notify the delegate of an error if one exists
    if (!responseDictionary || error) {
        NSLog(@"TNBLoginManager: Response dictionary could not be parsed.");
    }
    
    BOOL isValidJSON = [self validateJSON:responseDictionary forServerError:&error];
    // Notify the delegate of an error if one exists
    if (!isValidJSON || error) {
        NSLog(@"TNBLoginManager: JSON response is invalid.");
        return;
    }
    
    // Handle the response (if there were no errors)
    // by logging the user in.
    [self saveLoginEmail:email 
                  userID:[responseDictionary objectForKey:@"user_id"] 
                   token:email.uploadHash];
}

-(void)logCurrentUserOut {
    NSLog(@"TNBLoginManager: Logging the current user out.");
    // Set the currentUser to nil
    self.currentUser = nil;
    // Remove necessary values from NSUserDefaults
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kTNBNSUserDefaultsEmailKey];
    [defaults removeObjectForKey:kTNBNSUserDefaultsUserIDKey];
    [defaults removeObjectForKey:kTNBNSUserDefaultsTokenKey];
    
    // Notify the delegate if necessary
    if ([self.delegate respondsToSelector:@selector(userWasLoggedOutSuccessfully)]) {
        [self.delegate userWasLoggedOutSuccessfully];
    }
}

-(void)registerNewUserWithName:(NSString *)name email:(NSString *)email password:(NSString *)password {
    NSLog(@"LoginManager: Attempting to register a user.");
    
    // Send a request to the server
    // Request login response from the server
    NSDictionary * keyValuePairs = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:name, email, password.MD5, email.uploadHash, nil] 
                                                               forKeys:[NSArray arrayWithObjects:@"name", @"email", @"password", @"token", nil]];
    NSData * responseData = [self sendSynchronousPostRequestTo:[NSURL URLWithString:kTNBRegisterURL] 
                                             withKeyValuePairs:keyValuePairs];
    NSLog(@"LoginManager: Returned Data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    
    // Check for errors
    NSError * error;
    NSDictionary * responseDictionary = [self validateResponseData:responseData forError:&error];
    // Notify the delegate of an error if one exists
    if (!responseDictionary || error) {
        if ([self.delegate respondsToSelector:@selector(userAccountCreationDidFailWithError:)]) {
            NSLog(@"LoginManager: Notifying delegate userAccountCreationDidFailWithError: %@.", error.localizedDescription);
            [delegate userAccountCreationDidFailWithError:error];
        }
        return;
    }
    
    BOOL isValidJSON = [self validateJSON:responseDictionary forServerError:&error];
    // Notify the delegate of an error if one exists
    if (!isValidJSON || error) {
        if ([self.delegate respondsToSelector:@selector(userAccountCreationDidFailWithError:)]) {
            [delegate userAccountCreationDidFailWithError:error];
        }
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(userAccountCreatedSuccessfully)]) {
        NSLog(@"LoginManager: Notifying delegate userAccountCreatedSuccessfully.");
        [delegate userAccountCreatedSuccessfully];
    }
    
    // Handle the response data (if there were no errors)
    // by logging the user in.
    [self saveLoginEmail:email 
                  userID:[responseDictionary objectForKey:@"user_id"] 
                   token:email.uploadHash];
}

@end

@implementation TNBLoginManager (InternalMethods)

-(NSData *)sendSynchronousPostRequestTo:(NSURL *)outgoingURL withKeyValuePairs:(NSDictionary *)args {
    
    
    NSLog(@"TNBLoginManager: Will generate POST request to send to %@.", [outgoingURL absoluteURL]);
    
    // Set the params for the request
    NSMutableString * params = [NSMutableString stringWithCapacity:200];
    NSString * key;
    for (key in args) {
        NSLog(@"TNBLoginManager: Appending value: %@ for key: %@ to the params.", [args objectForKey:key], key);
        [params appendString:[NSString stringWithFormat:@"%@=%@&", key, [args objectForKey:key]]];
    }
    
    // Generate the request
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:outgoingURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Keep track of any errors
    NSError * error;
    
    // Send the request
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    // Returns nil if there was an error
    if (error) {
        NSLog(@"TNBLoginManager: !!!Error occurred while sending the post request: %@.", error);
        
        return nil;
    }
    
    // If no error, return the received data
    return responseData;
}

#pragma mark - Internal Login Handling

-(void)saveLoginEmail:(NSString *)email userID:(NSNumber *)userID token:(NSString *)token {
    NSLog(@"TNBLoginManager: Saving login information to make login persistent.");
    // Create the currentUser object and add
    // the appropriate values to NSUserDefaults
    self.currentUser = [TNBCurrentUser currentUserWithEmail:email userID:userID token:token];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.currentUser.email forKey:kTNBNSUserDefaultsEmailKey];
    [defaults setObject:self.currentUser.userID forKey:kTNBNSUserDefaultsUserIDKey];
    [defaults setObject:self.currentUser.token forKey:kTNBNSUserDefaultsTokenKey];
    [defaults synchronize];
    
    NSLog(@"TNBLoginManager: Login of user: %@ was successful.", email);
    if ([self.delegate respondsToSelector:@selector(userWasLoggedInSuccessfully)]) {
        NSLog(@"TNBLoginManager: Notifying delegate: userWasLoggedInSuccessfully");
        [self.delegate userWasLoggedInSuccessfully];
    }
}

-(void)refreshLogin {
    NSLog(@"TNBLoginManager: Refreshing login from NSUserDefaults.");
    // Check for logged in user in NSUserDefaults and
    // create a currentUser object if necessary
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    // Check NSUserDefaults
    if ([defaults objectForKey:kTNBNSUserDefaultsEmailKey]
        &&[defaults objectForKey:kTNBNSUserDefaultsUserIDKey]
        &&[defaults objectForKey:kTNBNSUserDefaultsTokenKey]) {
        NSLog(@"TNBLoginManager: User appears to be logged in. Setting up current user object now");
        self.currentUser = [TNBCurrentUser currentUserWithEmail:[defaults objectForKey:kTNBNSUserDefaultsEmailKey] 
                                                         userID:[defaults objectForKey:kTNBNSUserDefaultsUserIDKey] 
                                                          token:[defaults objectForKey:kTNBNSUserDefaultsTokenKey]];
    } else {
        NSLog(@"TNBLoginManager: User is not currently logged in.");
        [self logCurrentUserOut];
    }
}

#pragma mark - Server Response Validation

-(BOOL)validateResponseToken:(NSString *)token forUserID:(NSNumber *)userID {
    NSLog(@"TNBLoginManager: Validating server response token.");
    if ([token isEqualToString:userID.stringValue.downloadHash]) {
        NSLog(@"LoginManager: Server response token is valid.");
        return YES;
    } 
    NSLog(@"TNBLoginManager: Server response token is invalid.");
    return NO;
}

-(NSDictionary *)validateResponseData:(NSData *)responseData forError:(NSError *__autoreleasing *)error {
    // Check for non-nil response data.
    if (!responseData) {
        NSLog(@"TNBLoginManager: !!!ERROR: Response data is nil - an unknown error occurred.");
        *error = [NSError errorWithDomain:@"STR" 
                                     code:5101
                                 userInfo:[NSDictionary dictionaryWithObject:@"Unknown Error" 
                                                                      forKey:NSLocalizedDescriptionKey]];
        return nil;
    }
    
    // Check for a parse error
    NSError * parseError;
    NSDictionary * responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
    if (parseError) {
        NSLog(@"TNBLoginManager: !!!ERROR: There was an error parsing the JSON data from the server.");
        *error = parseError;
        return nil;
    }
    NSLog(@"TNBLoginManager: Successfully created dictionary from server JSON response.");
    return responseDictionary;
}

-(BOOL)validateJSON:(NSDictionary *)responseDictionary forServerError:(NSError *__autoreleasing *)error {
    NSLog(@"TNBLoginManager: Validating response dictionary.");
    // Check for an error from the server.
    if ([[responseDictionary objectForKey:@"error_present"] boolValue]) {
        NSLog(@"TNBLoginManager: !!!ERROR: Server error detected.");
        *error = [[NSError alloc] init];
        return NO;
    }
    // Crosscheck the server response token
    if (![self validateResponseToken:[responseDictionary objectForKey:@"token"] forUserID:[responseDictionary objectForKey:@"user_id"]]) {
        *error = [NSError errorWithDomain:@"TNB" 
                                     code:5000
                                 userInfo:[NSDictionary dictionaryWithObject:@"Server returned invalid token" 
                                                                      forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    NSLog(@"TNBLoginManager: Dictionary validated and server returned positive, error-free response.");
    return YES;
}

@end