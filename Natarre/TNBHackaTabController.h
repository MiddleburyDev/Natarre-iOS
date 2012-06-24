//
//  TNBHackaTabController.h
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNBHackaTabController : UIViewController {
    
    // Children.
    UINavigationController * thisWeekNavController;
    UINavigationController * topStoriesNavController;
    UINavigationController * allStoriesNavController;
    UINavigationController * readingListNavController;
    UINavigationController * myFavoritesNavController;
    
    // Keep track of currently selected shit
    UINavigationController * currentNavController;
    UIButton * currentDepressedButton;
    
    // Button outlets
    IBOutlet UIButton * thisWeekButton;
    IBOutlet UIButton * topStoriesButton;
    IBOutlet UIButton * allStoriesButton;
    IBOutlet UIButton * readingListButton;
    IBOutlet UIButton * myFavoritesButton;
    
    // Image Outlets
    IBOutlet UIImageView * navBarBackground;
    IBOutlet UIImageView * tabBarBackground;
    
    // Subview to contain the little fuckers.
    IBOutlet UIView * subView;
}

-(IBAction)thisWeekButtonWasPressed:(id)sender;
-(IBAction)topStoriesButtonWasPressed:(id)sender;
-(IBAction)allStoriesButtonWasPressed:(id)sender;
-(IBAction)readingListButtonWasPressed:(id)sender;
-(IBAction)myFavoritesButtonWasPressed:(id)sender;

@end
