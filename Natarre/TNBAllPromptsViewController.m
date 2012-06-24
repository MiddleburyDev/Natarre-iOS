//
//  TNBAllPromptsViewController.m
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import "TNBAllPromptsViewController.h"

@interface TNBAllPromptsViewController ()

@end

// fackit
//@interface TNBAllPromptsViewController (TNBStoriesManagerDelegate) <TNBStoriesManagerDelegate>
//
//-(void)successfullyDownloadedPrompts:(NSArray *)prompts;
//
//@end

@implementation TNBAllPromptsViewController

@synthesize allPrompts;

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
    
    NSArray * thePrompts = [storiesManager getAllPrompts];
    
    if (thePrompts) {
        self.allPrompts = thePrompts;
        [self.tableView reloadData];
    } else {
        NSLog(@"There was an error loading the prompts");
    }
    
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
    NSLog(@"number of cells to show: %d", allPrompts.count);
    return self.allPrompts.count;
}

-(TNBStoryCell *)configureCell:(TNBStoryCell *)cell withArrayIndex:(NSInteger)index {
    
    NSLog(@"Configuring Cell!");
    
    TNBStory * story = [self.allPrompts objectAtIndex:index];
    
    cell.titleLabel.text = story.title;
    cell.authorLabel.text = @"";
    
    cell.paintSplatImageView.image = nil;
    
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
    
    TNBAllStoriesViewController * readerVC = (TNBAllStoriesViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"allStoriesController"];
    
    
    readerVC.promptID = [[self.allPrompts objectAtIndex:[indexPath indexAtPosition:1]] storyID];
        [(TNBHackaTabController *)self.navigationController.parentViewController shouldDisplayBackButton];
    [self.navigationController pushViewController:readerVC animated:YES];
}

@end
