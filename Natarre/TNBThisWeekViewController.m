//
//  TNBThisWeekViewController.m
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBThisWeekViewController.h"

@interface TNBThisWeekViewController (TNBStoriesManagerDelegate) <TNBStoriesManagerDelegate>

-(void)successfullyDownloadedStories:(NSArray *)stories;

@end

@interface TNBThisWeekViewController (InternalMethods)
-(TNBStoryCell *)configureCell:(TNBStoryCell *)cell;
@end

@implementation TNBThisWeekViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecycle

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

-(void)refresh {
    NSLog(@"Refresh was called.");
    TNBStoriesManager * storiesManager = [[TNBStoriesManager alloc] init];
    
    TNBCurrentUser * user = [[TNBLoginManager defaultManager] currentUser];
    
    NSArray * objects = [NSArray arrayWithObjects:user.userID, user.token, nil];
    NSArray * keys = [NSArray arrayWithObjects:@"user_id", @"token", nil];
    
    NSDictionary * keypairs = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [storiesManager generateRequestWithKeyPairs:keypairs sendToURL:[NSURL URLWithString:kTNBThisWeekPromptURL]];
    [storiesManager sendGeneratedRequest];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete implementation
    // Return the number of rows in the section.
    return storyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TNBStoryCell *cell = (TNBStoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TNBStoryCell" owner:self options:nil];
        cell = self.tblCell;
    }
    NSLog(@"Configuring the cell.");
    // Configure the cell...
    cell.titleLabel.text = @"The title";
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end

@implementation TNBThisWeekViewController (TNBStoriesManagerDelegate)

-(void)successfullyDownloadedStories:(NSArray *)stories {
    storyList = stories;
    [self.tableView reloadData];
}

@end
