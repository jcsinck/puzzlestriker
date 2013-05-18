//
//  EncyclopediaViewController.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/22/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncyclopediaDetailViewController.h"

@interface EncyclopediaViewController : UIViewController

@property (nonatomic, retain) EncyclopediaDetailViewController *encyclopediaDetail;

-(IBAction)returnToMainMenu:(id)sender;

-(IBAction)charactersButtonTapped:(id)sender;
-(IBAction)puzzleChipsButtonTapped:(id)sender;

@end
