//
//  EncyclopediaViewController.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/22/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "EncyclopediaViewController.h"
#import "RandomChipSelector.h"
#import "AppDelegate.h"

@implementation EncyclopediaViewController

@synthesize encyclopediaDetail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Encyclopedia";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Encyclopedia" image:[UIImage imageNamed:@"96-book.png"] tag:20];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)returnToMainMenu:(id)sender
{
    [((AppDelegate *)[UIApplication sharedApplication].delegate) dropViewOffScreen:self.view];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationReconfigureMainMenu" object:nil];
}

-(void)charactersButtonTapped:(id)sender
{
    RandomChipSelector *rcs = [[RandomChipSelector alloc] init];
    self.encyclopediaDetail = [[EncyclopediaDetailViewController alloc] initWithStandardChracters:[rcs getAllStandardCharacterChips] andExpansionChars:[rcs getAllExpansionCharacterChips]];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) animateViewOntoScreen:self.encyclopediaDetail.view onParentView:self.view];
}

-(void)puzzleChipsButtonTapped:(id)sender
{
    RandomChipSelector *rcs = [[RandomChipSelector alloc] init];
    self.encyclopediaDetail = [[EncyclopediaDetailViewController alloc] initWithStandardPuzzleChips:[rcs getAllStandardPuzzleChips] andExpansionPuzzleChips:[rcs getAllExpansionPuzzleChips]];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) animateViewOntoScreen:self.encyclopediaDetail.view onParentView:self.view];
}

@end
