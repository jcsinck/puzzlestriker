//
//  SinglePuzzleChipDetailViewController.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/23/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "SinglePuzzleChipDetailViewController.h"
#import "AppDelegate.h"

@implementation SinglePuzzleChipDetailViewController

@synthesize chipImage;
@synthesize puzzleDataDictionary;
@synthesize faqView;

-(id)initWithPuzzleChipData:(NSDictionary *)chipData
{
    self = [super init];
    if(self)
    {
        self.puzzleDataDictionary = chipData;
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
    
    NSString *chipAssetName = [self.puzzleDataDictionary objectForKey:@"chipAssetName"];
    NSString *faqString = [self.puzzleDataDictionary objectForKey:@"FAQ"];
    [self.chipImage setImage:[UIImage imageNamed:chipAssetName]];
    [self.faqView setEditable:NO];
    [self.faqView setText:faqString];
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

-(void)backButtonTapped:(id)sender
{
    [((AppDelegate *)[UIApplication sharedApplication].delegate) dropViewOffScreen:self.view];
}

@end
