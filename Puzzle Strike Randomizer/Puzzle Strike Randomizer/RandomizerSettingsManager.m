//
//  RandomizerSettingsManager.m
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 11/7/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "RandomizerSettingsManager.h"

@implementation RandomizerSettingsManager

-(id)init
{
    self = [super init];
    if(self)
    {
        //read out the data whenever we init
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:CONFIG_FILE_NAME];
        NSDictionary *dictionaryFile = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
        settingsArray = [[dictionaryFile objectForKey:CONFIG_KEY] mutableCopy];
        characterSettingsArray = [[dictionaryFile objectForKey:CHAR_CONFIG_KEY] mutableCopy];
        
        //if we read something out and it doesn't exist, then hold onto it
        if(settingsArray == nil)
        {
            settingsArray = [[NSMutableArray alloc] init];
        }
        if(characterSettingsArray == nil)
        {
            characterSettingsArray = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

-(void)enableChipWithID:(int)chipID
{
    [settingsArray removeObject:[NSNumber numberWithInt:chipID]];
}

-(void)disableChipWithID:(int)chipID
{
    [settingsArray addObject:[NSNumber numberWithInt:chipID]];
}

-(void)enableCharacterChipWithID:(int)chipID
{
    [characterSettingsArray removeObject:[NSNumber numberWithInt:chipID]];
}

-(void)disableCharacterChipWithID:(int)chipID
{
    [characterSettingsArray addObject:[NSNumber numberWithInt:chipID]];
}

-(BOOL)isChipDisabledWithID:(int)chipID
{
    return [settingsArray containsObject:[NSNumber numberWithInt:chipID]];
}

-(BOOL)isCharacterChipDisabledWithID:(int)chipID
{
    return [characterSettingsArray containsObject:[NSNumber numberWithInt:chipID]];
}

-(NSArray *)getAllDisabledCharacterChips
{
    return settingsArray;
}

-(NSArray *)getAllDisabledPuzzleChips
{
    return characterSettingsArray;
}

-(void)saveRandomizerConfiguration
{
    NSDictionary *saveDictionary = [NSDictionary dictionaryWithObjectsAndKeys:settingsArray, CONFIG_KEY, characterSettingsArray, CHAR_CONFIG_KEY, nil];
    
    //get the path we are saving to
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:CONFIG_FILE_NAME];
    
    //save it!
    [saveDictionary writeToFile:filePath atomically:YES];
}

@end
