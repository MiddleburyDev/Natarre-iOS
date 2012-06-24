//
//  TNBReaderViewController.h
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNBAppDelegate.h"

#import "TNBStory.h"


@interface TNBReaderViewController : UIViewController {
    IBOutlet UITextView * textView;
    
    TNBStory * story;
    
}

@property(nonatomic, strong)TNBStory * story;

-(void)loadStory:(TNBStory *)theStory;

-(IBAction)backButtonPressed:(id)sender;
-(IBAction)swipeRightDetected:(id)sender;

@end
