//
//  TNBReaderViewController.m
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBReaderViewController.h"

@interface TNBReaderViewController ()

@end

@implementation TNBReaderViewController

@synthesize story;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

#pragma mark - Other Shtuff

-(void)loadStory:(TNBStory *)theStory {
    self.story = story;
}

#pragma mark - Button Handling

-(IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)swipeRightDetected:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
