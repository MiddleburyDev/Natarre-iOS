//
//  TNBPullToRefreshTableViewController.m
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBPullToRefreshTableViewController.h"

#define REFRESH_HEADER_HEIGHT 52.0
#define degreesToRadians(x) (M_PI * x / 180.0)

@interface TNBPullToRefreshTableViewController (InternalMethods)
    -(void)setupStrings;
@end

@implementation TNBPullToRefreshTableViewController

@synthesize headerView, headerLabel, arrow, spinnerOfDeath, pullText, releaseText, refreshingText;

#pragma mark - Init Methods

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setupStrings];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        [self setupStrings];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil) {
        [self setupStrings];
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPullToRefreshHeader];
}

- (void)addPullToRefreshHeader {
    // Set up the header (a big view)
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    self.headerView.backgroundColor = [UIColor clearColor];
    
    // Set up the label to go in the header
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
        self.headerLabel.backgroundColor = [UIColor clearColor];
        self.headerLabel.font = [UIFont boldSystemFontOfSize:12.0];
        self.headerLabel.textAlignment = UITextAlignmentCenter;
    
    // Set up the arrow to go in the header
    self.arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    self.arrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);
    
    // Set up the death spinner to go in the header
    self.spinnerOfDeath = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinnerOfDeath.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    self.spinnerOfDeath.hidesWhenStopped = YES;
    
    // Add all of the subviews to the header
    [self.headerView addSubview:self.headerLabel];
    [self.headerView addSubview:self.arrow];
    [self.headerView addSubview:self.spinnerOfDeath];
    [self.tableView addSubview:self.headerView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isRefreshing) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isRefreshing) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self.tableView.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self.tableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
                // User is scrolling above the header
                self.headerLabel.text = self.releaseText;
                CGAffineTransform rotate = CGAffineTransformMakeRotation(degreesToRadians(180));
                [self.arrow setTransform:rotate];
            } else { 
                // User is scrolling somewhere within the header
                self.headerLabel.text = self.pullText;
                CGAffineTransform rotate = CGAffineTransformMakeRotation(degreesToRadians(0));
                [self.arrow setTransform:rotate];
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isRefreshing) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isRefreshing = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        self.headerLabel.text = self.refreshingText;
        self.arrow.hidden = YES;
        [self.spinnerOfDeath startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
    isRefreshing = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsZero;
        CGAffineTransform rotate = CGAffineTransformMakeRotation( 1.0 / 180.0 * 3.14 );
        [self.arrow setTransform:rotate];
    } 
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete {
    // Reset the header
    self.headerLabel.text = self.pullText;
    self.arrow.hidden = NO;
    [self.spinnerOfDeath stopAnimating];
}

- (void)refresh {
    // Stub
    NSLog(@"Override Refresh in your TNBPullToRefreshTableViewController and be sure to call stopLoading afterwards.");
    [self stopLoading];
}
@end

@implementation TNBPullToRefreshTableViewController (InternalMethods)

-(void)setupStrings {
    self.pullText = [[NSString alloc] initWithString:@"Pull to refresh..."];
    self.releaseText = [[NSString alloc] initWithString:@"Release to refresh..."];
   self.refreshingText = [[NSString alloc] initWithString:@"Refreshing..."];
}

@end
