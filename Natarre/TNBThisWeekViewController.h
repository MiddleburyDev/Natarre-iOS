//
//  TNBThisWeekViewController.h
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBPullToRefreshTableViewController.h"
#import "TNBAppDelegate.h"

#import "TNBReaderViewController.h"

// Supporting Files
#import "TNBStoriesManager.h"
#import "TNBStoryCell.h"

@interface TNBThisWeekViewController : TNBPullToRefreshTableViewController {
    NSArray * storyList;
}

-(void)refresh;

-(TNBStoryCell *)configureCell:(TNBStoryCell *)cell withArrayIndex:(NSInteger)index;

@end
