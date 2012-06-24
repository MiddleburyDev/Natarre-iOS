//
//  TNBViewController.m
//  ;
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBRootViewController.h"

@interface TNBRootViewController ()

@end

@implementation TNBRootViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"TNBRootViewController: Root View Controller loaded successfully.");
}

-(void)viewDidAppear:(BOOL)animated {
    [self verifyLogin];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Login Handling

-(void)verifyLogin {
    if (![[TNBLoginManager defaultManager] userIsLoggedIn]) {
        NSLog(@"TNBRootViewController: Presenting login view controller.");
        TNBLoginViewController * loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self presentViewController:loginViewController animated:NO completion:nil];
    }
}

@end
