//
//  PuzzleChipDetailTableViewCell.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/23/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "PuzzleChipDetailTableViewCell.h"
#import "AppDelegate.h"

@implementation PuzzleChipDetailTableViewCell

@synthesize chipName;
@synthesize chipImage;
@synthesize puzzleChipDetailView;
@synthesize puzzleChipData;

-(id)initWithPuzzleChipData:(NSDictionary *)puzChipData
{
    self = [super init];
    if(self)
    {
        self.puzzleChipData = puzChipData;
    }
    
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)configureCellWithPuzzleDataDictionary:(NSDictionary *)puzzleData
{
    NSString *chipAssetName = [puzzleData objectForKey:@"chipAssetName"];
    NSString *chipNameString = [puzzleData objectForKey:@"chipName"];
    
    [self.chipName setText:chipNameString];;
    [self.chipImage setImage:[UIImage imageNamed:chipAssetName]];
    
    self.puzzleChipData = puzzleData;
}

-(void)detailsButtonTapped:(id)sender
{
    self.puzzleChipDetailView = [[SinglePuzzleChipDetailViewController alloc] initWithPuzzleChipData:self.puzzleChipData];
    UIView *parentView = self.superview.superview;
    [((AppDelegate *)[UIApplication sharedApplication].delegate) animateViewOntoScreen:self.puzzleChipDetailView.view onParentView:parentView];
}

@end
