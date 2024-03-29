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

@synthesize story, theTextView;

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

-(void)viewWillUnload {
    //TNBStoriesManager * storyManager = [[TNBStoriesManager alloc] init];
    
    //[storyManager sendFavoriteRequestForStory:self.story.storyID];
}

-(void)viewWillAppear:(BOOL)animated {
    self.theTextView.text = self.story.content;
    
    // Resize to fit the content
    CGRect frame = theTextView.frame;
    frame.size.height = theTextView.contentSize.height;
    theTextView.frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Other Shtuff

-(void)loadStory {
    
}

#pragma mark - Button Handling

-(IBAction)backButtonPressed:(id)sender {
    [(TNBHackaTabController *)self.navigationController.parentViewController shouldDisplayPrefsButton];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)swipeRightDetected:(id)sender {
    [(TNBHackaTabController *)self.navigationController.parentViewController shouldDisplayPrefsButton];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)favoriteButtonWasPressed:(id)sender {
    // Toggle the button state
    if (((UIButton *)sender).selected == YES) {
        ((UIButton *)sender).selected = NO;
    } else {
    ((UIButton *)sender).selected = YES;
    }
}

-(IBAction)readingListButtonWasPressed:(id)sender {
    // Toggle the button state
    if (((UIButton *)sender).selected == YES) {
        ((UIButton *)sender).selected = NO;
    } else {
        ((UIButton *)sender).selected = YES;
    }
}

@end
