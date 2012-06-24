//
//  TNBRegisterViewController.m
//  Natarre
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBRegisterViewController.h"

@interface TNBRegisterViewController ()

@end

@interface TNBRegisterViewController (TNBLoginManagerDelegate) <TNBLoginManagerDelegate>

-(void)userWasLoggedInSuccessfully;
-(void)loginDidFailWithError:(NSError *)error;

// Registration shit
-(void)userAccountCreatedSuccessfully;
-(void)userAccountCreationDidFailWithError:(NSError *)error;

@end

@implementation TNBRegisterViewController

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

-(IBAction)submitButtonWasPressed:(id)sender {
    [[TNBLoginManager defaultManager] registerNewUserWithName:[nameField text]
                                                        email:[emailField text] 
                                                     password:[passwordField text]];
}

@end

@implementation TNBRegisterViewController (TNBLoginManagerDelegate)

-(void)userWasLoggedInSuccessfully {
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
}
-(void)loginDidFailWithError:(NSError *)error {
    NSLog(@"TNBRegisterViewControler: Login did fail: %@", error);
}

// Registration shit
-(void)userAccountCreatedSuccessfully {
    NSLog(@"TNBRegisterViewCotnorller: Registration Successful.");
}
-(void)userAccountCreationDidFailWithError:(NSError *)error {
    NSLog(@"TNBRegisterViewCtontrolelr: !!!ERROR: Registration error:");
}

@end
