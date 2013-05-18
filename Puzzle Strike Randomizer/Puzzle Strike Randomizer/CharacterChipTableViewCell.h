//
//  CharacterChipTableViewCell.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/20/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleCharacterDetailViewController.h"

@interface CharacterChipTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *chipImage;
@property (nonatomic, retain) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, retain) SingleCharacterDetailViewController *characterDetailView;
@property (nonatomic, retain) NSDictionary *characterDataDictionary;

-(void)configureCharacterCellWithDataDictionary:(NSDictionary *)data andName:(NSString *)playerName;

-(IBAction)seeAbilityChipsTapped:(id)sender;

@end
