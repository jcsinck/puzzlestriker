//
//  AboutScreenViewController.m
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 1/21/13.
//  Copyright (c) 2013 Playforge LLC. All rights reserved.
//

#import "AboutScreenViewController.h"
#import "AppDelegate.h"

@implementation AboutScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"About";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"About" image:[UIImage imageNamed:@"123-id-card.png"] tag:30];
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

-(void)closeWindow:(id)sender
{
    [((AppDelegate *)[UIApplication sharedApplication].delegate) dropViewOffScreen:self.view];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationReconfigureMainMenu" object:nil];
}

@end
