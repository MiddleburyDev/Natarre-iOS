//
//  TNBAllPromptsViewController.h
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBPullToRefreshTableViewController.h"
#import "TNBAppDelegate.h"

#import "TNBAllStoriesViewController.h"

// Supporting Files
#import "TNBStoriesManager.h"
#import "TNBStoryCell.h"

@interface TNBAllPromptsViewController : TNBPullToRefreshTableViewController {
    NSArray * allPrompts;
}

@property(nonatomic, strong)NSArray * allPrompts;

-(void)refresh;

-(TNBStoryCell *)configureCell:(TNBStoryCell *)cell withArrayIndex:(NSInteger)index;

@end
