//
//  RandomizerRecapViewController.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/20/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterChipTableViewCell.h"
#import "PuzzleChipTableViewCell.h"
#import "RecapHeaderViewController.h"

#define kNotificationReconfigureMainMenu @"kNotificationReconfigureMainMenu"

@interface RandomizerRecapViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *characters;
@property (nonatomic, retain) NSArray *puzzleChips;
@property (nonatomic, retain) NSArray *names;

@property (nonatomic, retain) IBOutlet UITableView *recapContentView;
@property (nonatomic, retain) RecapHeaderViewController *characterHeader;
@property (nonatomic, retain) RecapHeaderViewController *puzzleChipHeader;

-(id)initWithCharactersArray:(NSArray *)chars andNamesArray:(NSArray *)names andPuzzleChipsArray:(NSArray *)puzzles;
-(IBAction)returnToMainMenu:(id)sender;

//creating cells
-(CharacterChipTableViewCell *)createCharacterCellWithTableView:(UITableView *)tableView andCharacterInfoDictionary:(NSDictionary *)characterInfo andName:(NSString *)name;
-(PuzzleChipTableViewCell *)createPuzzleChipCellWithTableView:(UITableView *)tableView andPuzzleChipInfoDictionary:(NSDictionary *)puzzleInfo;

//button handlers
-(void)rerollCharacterChips;
-(void)rerollPuzzleChips;

@end
