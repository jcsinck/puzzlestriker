//
//  PuzzleChipDetailTableViewCell.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/23/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinglePuzzleChipDetailViewController.h"

@interface PuzzleChipDetailTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *chipName;
@property (nonatomic, retain) IBOutlet UIImageView *chipImage;
@property (nonatomic, retain) SinglePuzzleChipDetailViewController *puzzleChipDetailView;
@property (nonatomic, retain) NSDictionary *puzzleChipData;

-(id)initWithPuzzleChipData:(NSDictionary *)puzChipData;

-(void)configureCellWithPuzzleDataDictionary:(NSDictionary *)puzzleData;

-(IBAction)detailsButtonTapped:(id)sender;

@end
