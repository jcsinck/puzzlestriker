//
//  EncyclopediaDetailViewController.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/22/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kEncyclopediaStateCharacters = 0,
    kEncyclopediaStatePuzzleChips,
} EncyclopediaState;

@interface EncyclopediaDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *standardCharacters;
@property (nonatomic, retain) NSArray *expansionCharacters;

@property (nonatomic, retain) NSArray *standardPuzzleChips;
@property (nonatomic, retain) NSArray *expansionPuzzleChips;

@property (nonatomic, retain) IBOutlet UITableView *characterContentView;
@property (nonatomic, retain) IBOutlet UIButton *backButton;

@property EncyclopediaState encyclopediaState;

-(id)initWithStandardChracters:(NSArray *)standardChars andExpansionChars:(NSArray *)expansionChars;
-(id)initWithStandardPuzzleChips:(NSArray *)standardPuzChips andExpansionPuzzleChips:(NSArray *)expansionPuzChips;

-(UITableViewCell *)getCharacterCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)getPuzzleChipCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

-(IBAction)backButtonTapped:(id)sender;

@end
