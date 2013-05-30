//
//  ConfigureRandomizerViewController.h
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 11/4/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigureTableViewCell.h"
#import "ConfigureCharacterTableViewCell.h"
#import "RandomizerSettingsManager.h"

#define kNotificationChipEnabled @"kNotificationChipEnabled"
#define kNotificationChipDisabled @"kNotificationChipDisabled"

#define kNotificationCharacterChipEnabled @"kNotificationCharacterChipEnabled"
#define kNotificationCharacterChipDisabled @"kNotificationCharacterChipDisabled"

typedef enum {
    kConfigurationModePuzzleChips = 0,
    kConfigurationModeCharacterChips,
} ConfigurationMode;

@interface ConfigureRandomizerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *standardPuzzleChips;
    NSArray *expansionPuzzleChips;
    
    NSArray *standardCharacterChips;
    NSArray *expansionCharacterChips;
    
    ConfigurationMode configMode;
}

@property (nonatomic, retain) IBOutlet UITableView *configureTable;
@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) RandomizerSettingsManager *rsm;

-(id)initWithStandardPuzzleChipArray:(NSArray *)standard andExpansionPuzzleChipArray:(NSArray *)expansion;
-(id)initWithStandardCharacterChipArray:(NSArray *)standard andExpansionCharacterChipArray:(NSArray *)expansion;

-(IBAction)returnToMainMenu:(id)sender;

-(ConfigureTableViewCell *)createConfigureCellWithTableView:(UITableView *)tableView andChipData:(NSDictionary *)chipData;
-(ConfigureCharacterTableViewCell *)createConfigureCharacterCellWithTableView:(UITableView *)tableView andChipData:(NSDictionary *)chipData;

-(void)configurationRowDisabled:(NSNotification *)notif;
-(void)configurationRowEnabled:(NSNotification *)notif;

-(void)configurationCharacterRowDisabled:(NSNotification *)notif;
-(void)configurationCharacterRowEnabled:(NSNotification *)notif;

@end
