//
//  RecapHeaderViewController.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/20/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNotificationCharacterReroll @"kNotificationCharacterReroll"
#define kNotificationPuzzleChipReroll @"kNotificationPuzzleChipReroll"

typedef enum {
    kSectionCharacters = 0,
    kSectionPuzzleChips = 1,
} headerSection;

@interface RecapHeaderViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton *rerollButton;
@property (nonatomic, retain) IBOutlet UILabel *headerLabel;
@property headerSection header;

-(IBAction)triggerReroll:(id)sender;
-(void)triggerCharacterReroll;
-(void)triggerPuzzleChipReroll;

@end
