//
//  RandomCharacterSelector.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/19/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "RandomChipSelector.h"
#import "RandomizerSettingsManager.h"

static NSArray *characterSourceArray = nil;
static NSArray *shadowsCharacterSourceArray = nil;
static NSArray *puzzleChipSourceArray = nil;
static NSArray *shadowsPuzzleChipSourceArray = nil;

static BOOL useShadowsCharacterChip = YES;
static BOOL useShadowsPuzzleChip = YES;

@implementation RandomChipSelector

-(id)init
{
    self = [super init];
    if(self)
    {
        //if we have yet to read out the source, then do it now in the init
        if(!characterSourceArray)
        {
            NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"CharacterChips.plist"];
            characterSourceArray = [[[NSDictionary dictionaryWithContentsOfFile:filePath] objectForKey:@"defaultHead"] objectForKey:@"characterChips"];
            NSLog(@"%@", characterSourceArray);
        }
        
        if(!shadowsCharacterSourceArray)
        {
            NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"CharacterChips.plist"];
            shadowsCharacterSourceArray = [[[NSDictionary dictionaryWithContentsOfFile:filePath] objectForKey:@"defaultHead"] objectForKey:@"shadowsCharacterChips"];
            NSLog(@"%@", shadowsCharacterSourceArray);
        }
        
        //if we have yet to read out the puzzle source, do it!
        if(!puzzleChipSourceArray)
        {
            NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"PuzzleChips.plist"];
            puzzleChipSourceArray = [[[NSDictionary dictionaryWithContentsOfFile:filePath] objectForKey:@"defaultHead"] objectForKey:@"puzzleChips"];
            NSLog(@"%@", puzzleChipSourceArray);
        }
        
        if(!shadowsPuzzleChipSourceArray)
        {
            NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"PuzzleChips.plist"];
            shadowsPuzzleChipSourceArray = [[[NSDictionary dictionaryWithContentsOfFile:filePath] objectForKey:@"defaultHead"] objectForKey:@"shadowsPuzzleChips"];
            NSLog(@"%@", shadowsPuzzleChipSourceArray);
        }
    }
    
    return self;
}

-(NSArray *)getAllStandardCharacterChips
{
    return [characterSourceArray copy];
}

-(NSArray *)getAllExpansionCharacterChips
{
    return [shadowsCharacterSourceArray copy];
}

-(NSArray *)getAllStandardPuzzleChips
{
    return [puzzleChipSourceArray copy];
}

-(NSArray *)getAllExpansionPuzzleChips
{
    return [shadowsPuzzleChipSourceArray copy];
}

-(NSDictionary *)selectRandomChipFromArray:(NSMutableArray *)targetArray
{
    int randInt = arc4random_uniform([targetArray count]);
    return [targetArray objectAtIndex:randInt];
}

-(NSArray *)selectCharacterChips:(int)numPlayers
{
    return [self selectCharacterChips:numPlayers useShadows:useShadowsCharacterChip];
}

-(NSArray *)selectCharacterChips:(int)numPlayers useShadows:(BOOL)useShadows
{
    //st the default
    useShadowsCharacterChip = useShadows;
    
    //make a copy of the source dictionary that we can modify
    NSMutableArray *sourceCopy = [NSMutableArray arrayWithArray:characterSourceArray];
    if(useShadows)
        [sourceCopy addObjectsFromArray:shadowsCharacterSourceArray];
    
    //make a character array (return array)
    NSMutableArray *returnCharacterArray = [[NSMutableArray alloc] initWithCapacity:numPlayers];
    
    //remove the disabled chips
    [self removeDisabledChipsWithSourceArray:sourceCopy isPuzzleSet:NO];
        
    //for each player, roll a random number, grab the entry at that index, add it to the character array, then remove it from the source copy
    BOOL warningDisplayed = NO;
    for(int i = 0; i < numPlayers; i++)
    {
        if([sourceCopy count])
        {
            NSDictionary *characterData = [self selectRandomChipFromArray:sourceCopy];
            [returnCharacterArray addObject:characterData];
            [sourceCopy removeObject:characterData];
        }
        else
        {
            if(!warningDisplayed)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Few Characters!" message:@"There are too few characters enabled for a game of this player size. Enable more characters!" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
                [alert show];
                warningDisplayed = YES;
            }
        }
    }
    
    //return the result
    return returnCharacterArray;
}

-(NSArray *)selectPuzzleChips:(int)numPuzzleChips
{
    return [self selectPuzzleChips:numPuzzleChips useShadows:useShadowsPuzzleChip];
}

-(NSArray *)selectPuzzleChips:(int)numPuzzleChips useShadows:(BOOL)useShadows
{
    //set the default
    useShadowsPuzzleChip = useShadows;
    
    //make a copy of the source array that we can modify
    NSMutableArray *sourceCopy = [NSMutableArray arrayWithArray:puzzleChipSourceArray];
    if(useShadows)
        [sourceCopy addObjectsFromArray:shadowsPuzzleChipSourceArray];
    
    //make a character array (return array)
    NSMutableArray *returnPuzzleChipArray = [[NSMutableArray alloc] initWithCapacity:numPuzzleChips];
    
    //remove the disabled chips from the source
    [self removeDisabledChipsWithSourceArray:sourceCopy isPuzzleSet:YES];
    
    //for each player, roll a random number, grab the entry at that index, add it to the character array, then remove it from the source copy
    BOOL warningDisplayed = NO;
    for(int i = 0; i < numPuzzleChips; i++)
    {
        if([sourceCopy count])
        {
            NSDictionary *characterData = [self selectRandomChipFromArray:sourceCopy];
            [returnPuzzleChipArray addObject:characterData];
            [sourceCopy removeObject:characterData];
        }
        else
        {
            if(!warningDisplayed)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Few Chips!" message:@"There are too few puzzle chips enabled for a full game. Only the enabled chips have been included." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
                [alert show];
                warningDisplayed = YES;
            }
        }
    }
    
    //return the result
    return returnPuzzleChipArray;
}

-(NSArray *)selectPlayerNames
{
    //make a copy of the source array that we can modify
    NSArray *playerNames = [[NSUserDefaults standardUserDefaults] objectForKey:@"PLAYER_NAMES"];
    NSMutableArray *sourceCopy = [[NSMutableArray alloc] init];
    
    int numChars = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NUMBER_PLAYERS"] intValue];
    
    for(int i = 0; i < numChars; i++)
    {
        [sourceCopy addObject:[playerNames objectAtIndex:i]];
    }
        
    //make a names array (return array)
    NSMutableArray *returnNamesArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    for(int i = 0; i < numChars; i++)
    {
        int randInt = arc4random_uniform([sourceCopy count]);
        NSString *str = [sourceCopy objectAtIndex:randInt];
        if([str length] > 0)
            [returnNamesArray addObject:str];
        else
            [returnNamesArray addObject:[NSString stringWithFormat:@"Player %d", randInt + 1]];
        
        int removalIndex = [sourceCopy indexOfObject:str];
        [sourceCopy removeObjectAtIndex:removalIndex];
    }
    
    //return the result
    return returnNamesArray;
}

-(void)removeDisabledChipsWithSourceArray:(NSMutableArray *)source isPuzzleSet:(BOOL)puzzleSet
{
    //grab the ids of all of the disabled character chips
    NSArray *disabledChips = nil;
    if(puzzleSet)
        disabledChips = [[[RandomizerSettingsManager alloc] init] getAllDisabledCharacterChips];
    else
        disabledChips = [[[RandomizerSettingsManager alloc] init] getAllDisabledPuzzleChips];
    
    //for each entry in the disabled chips, remove that entry from the source array
    NSMutableArray *indicesToRemove = [[NSMutableArray alloc] init];
    
    int sourceTotal = [source count];
    for(NSNumber *chipID in disabledChips)
    {
        int realID = [chipID intValue];
     
        //this logic is a bit tricky...
        if(realID <= sourceTotal)
        {
            //add the index to the list of indices that we will mess with later on
            [indicesToRemove addObject:[NSNumber numberWithInt:realID - 1]];
        }
    }
    
    //sort the array of indices
    NSArray *sortedIndices = [indicesToRemove sortedArrayUsingSelector:@selector(compare:)];
    
    //remove the values at the given indices from the source array
    for(int i = [sortedIndices count] - 1; i >= 0; i--)
    {
        int indexInteger = [[sortedIndices objectAtIndex:i] intValue];
        [source removeObjectAtIndex:indexInteger];
    }
}

@end
