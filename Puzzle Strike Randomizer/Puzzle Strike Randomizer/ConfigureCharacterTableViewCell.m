//
//  ConfigureCharacterTableViewCell.m
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 11/23/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "ConfigureCharacterTableViewCell.h"

@implementation ConfigureCharacterTableViewCell

@synthesize enabledSwitch;
@synthesize characterCardImage;
@synthesize characterNameLabel;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)configureCellWithChipData:(NSDictionary *)chipData andEnabledFlag:(BOOL)enabled
{
    //set the enabled switch
    self.enabledSwitch.on = enabled;
    
    //grab the card image and set it
    NSString *cardImageName = [chipData objectForKey:@"chipAssetName"];
    [self.characterCardImage setImage:[UIImage imageNamed:cardImageName]];
    
    //grab the character name and use it
    NSString *characterName = [chipData objectForKey:@"characterName"];
    [self.characterNameLabel setText:characterName];
    
    //set the chipID for this cell
    chipID = [[chipData objectForKey:@"chipID"] intValue];
}

-(void)switchTriggered:(id)sender
{
    if([enabledSwitch isOn])
    {
        //post a notification
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCharacterChipEnabled" object:[NSNumber numberWithInt:chipID]];
    }
    else
    {
        //post a notification
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCharacterChipDisabled" object:[NSNumber numberWithInt:chipID]];
    }
}

@end
