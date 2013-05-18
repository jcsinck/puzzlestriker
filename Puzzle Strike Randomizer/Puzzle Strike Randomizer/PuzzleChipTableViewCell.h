//
//  PuzzleChipTableViewCell.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/20/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinglePuzzleChipDetailViewController.h"

@interface PuzzleChipTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *chipImage;
@property (nonatomic, retain) SinglePuzzleChipDetailViewController *singleChipDetailView;
@property (nonatomic, retain) NSDictionary *puzzleChipData;

-(void)configurePuzzleChipCellWithDataDictionary:(NSDictionary *)data;
-(IBAction)detailsButtonTapped:(id)sender;

@end
