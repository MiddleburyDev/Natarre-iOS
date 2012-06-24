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
    
    // Load the child view controllers
    UITabBarController * albumNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainNavigationController"];
    albumNavigationController.tabBar.backgroundImage = [UIImage imageNamed:@"tab_bar"];
    
    // Set up the child view controller
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = 0;
    albumNavigationController.view.frame = newFrame;
    [self addChildViewController:albumNavigationController];
    [self.view addSubview:albumNavigationController.view];
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
        UINavigationController * loginNavController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNavController"];
        loginNavController.navigationBar.hidden = YES;
        [self presentViewController:loginNavController animated:NO completion:nil];
    }
}

@end
