//
//  TNBPullToRefreshTableViewController.h
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNBStoryCell.h"

@interface TNBPullToRefreshTableViewController : UITableViewController {
    UIView * headerView;
    UILabel * headerLabel;
    UIImageView * arrow;
    UIActivityIndicatorView * spinnerOfDeath;
    BOOL isDragging;
    BOOL isRefreshing;
    NSString * pullText;
    NSString * releaseText;
    NSString * refreshingText;
    
    TNBStoryCell * tblCell;
}

@property(nonatomic, strong)IBOutlet TNBStoryCell * tblCell;

@property(nonatomic, strong)UIView * headerView;
@property(nonatomic, strong)UILabel * headerLabel;
@property(nonatomic, strong)UIImageView * arrow;
@property(nonatomic, strong)UIActivityIndicatorView * spinnerOfDeath;
@property(nonatomic, strong)NSString * pullText;
@property(nonatomic, strong)NSString * releaseText;
@property(nonatomic, strong)NSString * refreshingText;

-(void)addPullToRefreshHeader;
-(void)startLoading;
-(void)stopLoading;

// Override this shit and call stopLoading at the end.
-(void)refresh;

@end
