//
//  TNBReaderViewController.h
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNBAppDelegate.h"

#import "TNBStoriesManager.h"

#import "TNBStory.h"


@interface TNBReaderViewController : UIViewController {
    
    IBOutlet UITextView * theTextView;
    
    TNBStory * story;
    
}

@property(nonatomic, strong)IBOutlet UITextView * theTextView;
@property(nonatomic, strong)TNBStory * story;

-(void)loadStory;

-(IBAction)backButtonPressed:(id)sender;
-(IBAction)swipeRightDetected:(id)sender;

-(IBAction)favoriteButtonWasPressed:(id)sender;
-(IBAction)readingListButtonWasPressed:(id)sender;

@end
