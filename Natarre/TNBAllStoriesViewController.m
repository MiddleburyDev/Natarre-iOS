//
//  TNBAllStoriesViewController.m
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBAllStoriesViewController.h"

@interface TNBAllStoriesViewController (TNBStoriesManagerDelegate) <TNBStoriesManagerDelegate>


-(void)successfullyDownloadedStories:(NSArray *)stories;

@end

@interface TNBAllStoriesViewController (InternalMethods)
-(TNBStoryCell *)configureCell:(TNBStoryCell *)cell;
@end

@implementation TNBAllStoriesViewController

@synthesize storyList, promptID;

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
	// Do any additional setup after loading the view.
    [self refresh];
}

-(void)viewDidAppear:(BOOL)animated {
    [self refresh];
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
    
    NSArray * objects = [NSArray arrayWithObjects:user.email, user.token, self.promptID, nil];
    NSArray * keys = [NSArray arrayWithObjects:@"email", @"token", @"prompt_ID", nil];
    
    NSDictionary * keypairs = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [storiesManager generateRequestWithKeyPairs:keypairs sendToURL:[NSURL URLWithString:kTNBStoriesForPromptURL]];
    [storiesManager sendGeneratedRequest];
    
    // ** !!! ** KEEP DO NOT DELETE ** !!! ** //
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
    // Return the number of rows in the section.
    NSLog(@"number of cells to show: %d", storyList.count);
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
    
    TNBReaderViewController * readerVC = (TNBReaderViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"readerViewController"];
    
    
    
    readerVC.story = [self.storyList objectAtIndex:[indexPath indexAtPosition:1]];
    
    [readerVC loadStory];
    [(TNBHackaTabController *)self.navigationController.parentViewController shouldDisplayBackButton];
    [self.navigationController pushViewController:readerVC animated:YES];
}

-(TNBStoryCell *)configureCell:(TNBStoryCell *)cell withArrayIndex:(NSInteger)index {
    
    NSLog(@"Configuring Cell!");
    
    TNBStory * story = [self.storyList objectAtIndex:index];
    
    cell.titleLabel.text = story.title;
    cell.authorLabel.text = story.authorName;
    
    if (story.audioURL != nil) {
        cell.paintSplatImageView.image = [UIImage imageNamed:@"greenDot"];
    } else {
        cell.paintSplatImageView.image = [UIImage imageNamed:@"purpleDot"];
    }
    
    return cell;
}

-(IBAction)swipe:(id)sender {
    [(TNBHackaTabController *)self.navigationController.parentViewController shouldDisplayPrefsButton];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

@implementation TNBAllStoriesViewController (TNBStoriesManagerDelegate)

-(void)successfullyDownloadedStories:(NSArray *)stories {
    NSLog(@"Reloading Data: %@", stories);
    self.storyList = stories;
    [self.tableView reloadData];
}

@end