//
//  ConfigureCharacterTableViewCell.h
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 11/23/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigureCharacterTableViewCell : UITableViewCell {
    int chipID;
}

@property (nonatomic, retain) IBOutlet UILabel *characterNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *characterCardImage;
@property (nonatomic, retain) IBOutlet UISwitch *enabledSwitch;

-(void)configureCellWithChipData:(NSDictionary *)chipData andEnabledFlag:(BOOL)enabled;
-(IBAction)switchTriggered:(id)sender;

@end
