//
//  SingleCharacterDetailViewController.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/22/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "SingleCharacterDetailViewController.h"
#import "AppDelegate.h"

@implementation SingleCharacterDetailViewController

@synthesize characterDataDictionary;
@synthesize characterCard;
@synthesize characterChipOne;
@synthesize characterChipTwo;
@synthesize characterChipThree;

-(id)initWithCharacterData:(NSDictionary *)characterData
{
    self = [super init];
    if(self)
    {
        self.characterDataDictionary = characterData;
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
    
    [((UIScrollView *)self.view) setContentSize:CGSizeMake(320, 1000)];
    
    NSString *chipAssetName = [characterDataDictionary objectForKey:@"chipAssetName"];
    [self.characterCard setImage:[UIImage imageNamed:chipAssetName]];
    
    NSString *characterChipOneAsset = [characterDataDictionary objectForKey:@"characterChipOneAsset"];
    NSString *characterChipTwoAsset = [characterDataDictionary objectForKey:@"characterChipTwoAsset"];
    NSString *characterChipThreeAsset = [characterDataDictionary objectForKey:@"characterChipThreeAsset"];
    
    [self.characterChipOne setImage:[UIImage imageNamed:characterChipOneAsset]];
    [self.characterChipTwo setImage:[UIImage imageNamed:characterChipTwoAsset]];
    [self.characterChipThree setImage:[UIImage imageNamed:characterChipThreeAsset]];
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
