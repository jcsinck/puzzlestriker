//
//  CharacterDetailTableViewCell.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/22/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleCharacterDetailViewController.h"

@interface CharacterDetailTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *characterNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *characterCardImage;
@property (nonatomic, retain) SingleCharacterDetailViewController *characterDetailView;
@property (nonatomic, retain) IBOutlet UIButton *detailsButton;
@property (nonatomic, retain) NSDictionary *characterDataDictionary;

-(void)configureCellWithDictionary:(NSDictionary *)characterData;

-(IBAction)detailsButtonTapped;

@end
