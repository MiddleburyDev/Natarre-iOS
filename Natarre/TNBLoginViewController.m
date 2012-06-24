//
//  TNBLoginViewController.m
//  Natarre
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBLoginViewController.h"

@interface TNBLoginViewController ()

@end

@interface TNBLoginViewController (TNBLoginManagerDelegate) <TNBLoginManagerDelegate>
-(void)userWasLoggedInSuccessfully;
-(void)loginDidFailWithError:(NSError *)error;
@end

@interface TNBLoginViewController (InternalMethods)
-(void)loginUser:(NSString *)email withPassword:(NSString *)password;
@end

@implementation TNBLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Respond to LoginManageDelegate methods
    [[(TNBAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager] setDelegate:self];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button Handling

-(IBAction)sumbitButtonWasPressed:(id)sender {
    NSLog(@"TNBLoginViewController: Submit button was pressed.");
    [[(TNBAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager] logUserInWithEmail:emailField.text 
                                                                                             password:passwordField.text];
}

@end

@implementation TNBLoginViewController (LoginManagerDelegate)

-(void)userWasLoggedInSuccessfully {
    NSLog(@"TNBLoginViewController: The login was successful!");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loginDidFailWithError:(NSError *)error {
    NSLog(@"TNBLoginViewController: !!!ERROR: Sign-In failed.");
}

@end
