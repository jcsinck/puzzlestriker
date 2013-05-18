//
//  ConfigureViewController.m
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 11/23/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "ConfigureViewController.h"
#import "AppDelegate.h"
#import "RandomChipSelector.h"

@implementation ConfigureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Configure";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Configure" image:[UIImage imageNamed:@"157-wrench.png"] tag:40];
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

#pragma mark - button handlers
-(void)openCharacterConfig:(id)sender
{
    RandomChipSelector *rcs = [RandomChipSelector new];
    NSArray *standardChips = [rcs getAllStandardCharacterChips];
    NSArray *expansionChips = [rcs getAllExpansionCharacterChips];

    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate displayConfigurationScreenWithCharacterChipArray:standardChips andExpansionPuzzleChipArray:expansionChips andParentView:self.view];
}

-(void)openPuzzleChipConfig:(id)sender
{
    RandomChipSelector *rcs = [RandomChipSelector new];
    NSArray *standardChips = [rcs getAllStandardPuzzleChips];
    NSArray *expansionChips = [rcs getAllExpansionPuzzleChips];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate displayConfigurationScreenWithPuzzleChipArray:standardChips andExpansionPuzzleChipArray:expansionChips andParentView:self.view];
}

-(void)closeWindow:(id)sender
{
    [((AppDelegate *)[UIApplication sharedApplication].delegate) dropViewOffScreen:self.view];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationReconfigureMainMenu" object:nil];
}

@end
