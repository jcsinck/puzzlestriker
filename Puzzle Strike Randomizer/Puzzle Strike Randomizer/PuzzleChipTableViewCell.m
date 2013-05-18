//
//  PuzzleChipTableViewCell.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/20/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "PuzzleChipTableViewCell.h"
#import "AppDelegate.h"

@implementation PuzzleChipTableViewCell

@synthesize chipImage;
@synthesize singleChipDetailView;
@synthesize puzzleChipData;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)configurePuzzleChipCellWithDataDictionary:(NSDictionary *)data
{
    NSString *puzzleChipName = [data objectForKey:@"chipAssetName"];
    [self.chipImage setImage:[UIImage imageNamed:puzzleChipName]];
    
    self.puzzleChipData = data;
}

-(void)detailsButtonTapped:(id)sender
{
    self.singleChipDetailView = [[SinglePuzzleChipDetailViewController alloc] initWithPuzzleChipData:self.puzzleChipData];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) animateViewOntoScreen:self.singleChipDetailView.view];
}

@end
