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
    
    //storyList = [NSArray
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
    storiesManager.delegate = self;
    
    TNBCurrentUser * user = [[TNBLoginManager defaultManager] currentUser];
    
    NSArray * objects = [NSArray arrayWithObjects:user.email, user.token, [storiesManager thisWeeksPrompt], nil];
    NSArray * keys = [NSArray arrayWithObjects:@"email", @"token", @"prompt_ID", nil];
    
    NSDictionary * keypairs = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [storiesManager generateRequestWithKeyPairs:keypairs sendToURL:[NSURL URLWithString:kTNBStoriesForPromptURL]];
    [storiesManager sendGeneratedRequest];
    
    // KEEP ---------------------------------
    [self stopLoading];
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
    NSLog(@"number of cells to show: %d", storyList.count);
    return storyList.count;
}

-(TNBStoryCell *)configureCell:(TNBStoryCell *)cell withArrayIndex:(NSInteger)index {
    
    NSLog(@"Configuring Cell!");

    TNBStory * story = [storyList objectAtIndex:index];
    
    cell.titleLabel.text = story.text;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TNBStoryCell *cell = (TNBStoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TNBStoryCell" owner:self options:nil];
        cell = self.tblCell;
    }
    NSLog(@"Calling to Configure the cell.");
    // Configure the cell...

    return [self configureCell:cell withArrayIndex:[indexPath indexAtPosition:1]];
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
    NSLog(@"Reloading Data: %@", stories);
    storyList = stories;
    [self.tableView reloadData];
}

@end
