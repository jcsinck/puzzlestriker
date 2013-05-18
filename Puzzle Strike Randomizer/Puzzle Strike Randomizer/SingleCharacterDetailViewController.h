//
//  SingleCharacterDetailViewController.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/22/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleCharacterDetailViewController : UIViewController

@property (nonatomic, retain) NSDictionary *characterDataDictionary;
@property (nonatomic, retain) IBOutlet UIImageView *characterCard;
@property (nonatomic, retain) IBOutlet UIImageView *characterChipOne;
@property (nonatomic, retain) IBOutlet UIImageView *characterChipTwo;
@property (nonatomic, retain) IBOutlet UIImageView *characterChipThree;

-(id)initWithCharacterData:(NSDictionary *)characterData;

-(IBAction)backButtonTapped:(id)sender;

@end
