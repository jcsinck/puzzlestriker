//
//  RandomizerSettingsManager.h
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 11/7/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CONFIG_FILE_NAME @"config.plist"
#define CONFIG_KEY @"settingsArray"
#define CHAR_CONFIG_KEY @"characterSettingsArray"

@interface RandomizerSettingsManager : NSObject {
    NSMutableArray *settingsArray;
    
    NSMutableArray *characterSettingsArray;
}

//enabling/disabling chips
-(void)enableChipWithID:(int)chipID;
-(void)disableChipWithID:(int)chipID;
-(void)enableCharacterChipWithID:(int)chipID;
-(void)disableCharacterChipWithID:(int)chipID;

//status of chips
-(BOOL)isChipDisabledWithID:(int)chipID;
-(BOOL)isCharacterChipDisabledWithID:(int)chipID;

-(NSArray *)getAllDisabledCharacterChips;
-(NSArray *)getAllDisabledPuzzleChips;

//saving data
-(void)saveRandomizerConfiguration;

@end
