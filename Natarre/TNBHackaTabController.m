//
//  TNBHackaTabController.m
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBHackaTabController.h"

@implementation TNBHackaTabController

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
    
    // Set the bar images
    navBarBackground.image = [UIImage imageNamed:@"navBarBackground"];
    tabBarBackground.image = [UIImage imageNamed:@"tabBarBackground"];
	
    // Load the views
    thisWeekNavController = [self.storyboard instantiateViewControllerWithIdentifier:@"thisWeekNavController"];
    topStoriesNavController = [self.storyboard instantiateViewControllerWithIdentifier:@"topStoriesNavController"];
    allStoriesNavController = [self.storyboard instantiateViewControllerWithIdentifier:@"allStoriesNavController"];
    readingListNavController = [self.storyboard instantiateViewControllerWithIdentifier:@"readingListNavController"];
    myFavoritesNavController = [self.storyboard instantiateViewControllerWithIdentifier:@"myFavoritesNavController"];
    
    thisWeekNavController.navigationBar.hidden = YES;
    topStoriesNavController.navigationBar.hidden = YES;
    allStoriesNavController.navigationBar.hidden = YES;
    readingListNavController.navigationBar.hidden = YES;
    myFavoritesNavController.navigationBar.hidden = YES;
    
    // Set up the view frames
    CGRect subViewFrame = CGRectMake(0, 0, subView.frame.size.width, subView.frame.size.height);
    thisWeekNavController.view.frame = subViewFrame;
    topStoriesNavController.view.frame = subViewFrame;
    allStoriesNavController.view.frame = subViewFrame;
    readingListNavController.view.frame = subViewFrame;
    myFavoritesNavController.view.frame = subViewFrame;
    
    // Add the children
    [self addChildViewController:thisWeekNavController];
    [self addChildViewController:topStoriesNavController];
    [self addChildViewController:allStoriesNavController];
    [self addChildViewController:readingListNavController];
    [self addChildViewController:myFavoritesNavController];
    
    // Add the child views to the containing subview
    [subView addSubview:topStoriesNavController.view];
    [subView addSubview:allStoriesNavController.view];
    [subView addSubview:readingListNavController.view];
    [subView addSubview:myFavoritesNavController.view];
    [subView addSubview:thisWeekNavController.view];
    
    currentNavController = thisWeekNavController;
    currentDepressedButton = thisWeekButton;
}

-(void)viewWillLayoutSubviews {
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [self shouldDisplayBackButton];
}

-(void)viewWillAppear:(BOOL)animated {
    [self shouldDisplayPrefsButton];
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

-(IBAction)thisWeekButtonWasPressed:(id)sender {
    if (currentNavController == thisWeekNavController) return;
    [self transitionFromViewController:currentNavController 
                      toViewController:thisWeekNavController 
                              duration:0.0 
                               options:UIViewAnimationTransitionNone 
                            animations:NULL 
                            completion:nil];
    thisWeekButton.selected = YES;
    currentDepressedButton.selected = NO;
    currentDepressedButton = thisWeekButton;
    currentNavController = thisWeekNavController;
}
-(IBAction)topStoriesButtonWasPressed:(id)sender {
    if (currentNavController == topStoriesNavController) return;
    [self transitionFromViewController:currentNavController 
                      toViewController:topStoriesNavController 
                              duration:0.0 
                               options:UIViewAnimationTransitionNone 
                            animations:NULL 
                            completion:nil];
    topStoriesButton.selected = YES;
    currentDepressedButton.selected = NO;
    currentDepressedButton = topStoriesButton;
    currentNavController = topStoriesNavController;
}
-(IBAction)allStoriesButtonWasPressed:(id)sender {
    if (currentNavController == allStoriesNavController) return;
    [self transitionFromViewController:currentNavController 
                      toViewController:allStoriesNavController 
                              duration:0.0 
                               options:UIViewAnimationTransitionNone 
                            animations:NULL 
                            completion:nil];
    allStoriesButton.selected = YES;
    currentDepressedButton.selected = NO;
    currentDepressedButton = allStoriesButton;
    currentNavController = allStoriesNavController;
}
-(IBAction)readingListButtonWasPressed:(id)sender {
    if (currentNavController == readingListNavController) return;
    [self transitionFromViewController:currentNavController 
                      toViewController:readingListNavController 
                              duration:0.0 
                               options:UIViewAnimationTransitionNone 
                            animations:NULL 
                            completion:nil];
    readingListButton.selected = YES;
    currentDepressedButton.selected = NO;
    currentDepressedButton = readingListButton;
    currentNavController = readingListNavController;
}
-(IBAction)myFavoritesButtonWasPressed:(id)sender {
    if (currentNavController == myFavoritesNavController) return;
    [self transitionFromViewController:currentNavController 
                      toViewController:myFavoritesNavController 
                              duration:0.0 
                               options:UIViewAnimationTransitionNone 
                            animations:NULL 
                            completion:nil];
    myFavoritesButton.selected = YES;
    currentDepressedButton.selected = NO;
    currentDepressedButton = myFavoritesButton;
    currentNavController = myFavoritesNavController;
}

-(void)shouldDisplayBackButton {
    NSLog(@"****Should display back.");
    backButton.hidden = NO;
    prefsButton.hidden = YES;
}

-(void)shouldDisplayPrefsButton {
     NSLog(@"****Should display prefs.");
    backButton.hidden = YES;
    prefsButton.hidden = NO;
}

-(IBAction)backButtonWasPressed:(id)sender {
    if (currentNavController.childViewControllers.count <= 2) {
        [self shouldDisplayPrefsButton];
    }
    [currentNavController popViewControllerAnimated:YES];
}
@end
