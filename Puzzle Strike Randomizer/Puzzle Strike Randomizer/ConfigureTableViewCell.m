//
//  ConfigureTableViewCell.m
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 11/5/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "ConfigureTableViewCell.h"

@implementation ConfigureTableViewCell

@synthesize chipName;
@synthesize enabledSwitch;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)configureCellWithChipData:(NSDictionary *)chipData andEnabledFlag:(BOOL)enabled
{
    NSString *chipTitle = [chipData objectForKey:@"chipName"];
    [self.chipName setText:chipTitle];
    
    chipID = [[chipData objectForKey:@"chipID"] intValue];
    
    self.enabledSwitch.on = enabled;
}

-(void)switchTriggered:(id)sender
{
    if([enabledSwitch isOn])
    {
        //post a notification
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationChipEnabled" object:[NSNumber numberWithInt:chipID]];
    }
    else
    {
        //post a notification
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationChipDisabled" object:[NSNumber numberWithInt:chipID]];
    }
}

@end
