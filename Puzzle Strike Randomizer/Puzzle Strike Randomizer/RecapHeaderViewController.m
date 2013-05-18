//
//  RecapHeaderViewController.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/20/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "RecapHeaderViewController.h"

@implementation RecapHeaderViewController

@synthesize rerollButton;
@synthesize header;
@synthesize headerLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    [self.rerollButton addTarget:self action:@selector(triggerReroll:) forControlEvents:UIControlEventTouchUpInside];
    
    if(self.header == kSectionCharacters)
    {
        [self.headerLabel setText:@"Character Chips"];
    }
    else if(self.header == kSectionPuzzleChips)
    {
        [self.headerLabel setText:@"Puzzle Chips"];
    }
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

-(void)triggerReroll:(id)sender
{
    if(self.header == kSectionCharacters)
    {
        [self triggerCharacterReroll];
    }
    else if(self.header == kSectionPuzzleChips)
    {
        [self triggerPuzzleChipReroll];
    }
}

-(void)triggerCharacterReroll
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCharacterReroll object:nil];
}

-(void)triggerPuzzleChipReroll
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPuzzleChipReroll object:nil];
}

@end
