//
//  ConfigureTableViewCell.h
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 11/5/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigureTableViewCell : UITableViewCell {
    int chipID;
}

@property (nonatomic, retain) IBOutlet UILabel *chipName;
@property (nonatomic, retain) IBOutlet UISwitch *enabledSwitch;

-(void)configureCellWithChipData:(NSDictionary *)chipData andEnabledFlag:(BOOL)enabled;
-(IBAction)switchTriggered:(id)sender;

@end
