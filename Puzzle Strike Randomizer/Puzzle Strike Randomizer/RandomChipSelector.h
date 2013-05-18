//
//  RandomCharacterSelector.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/19/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RandomChipSelector : NSObject

-(NSArray *)getAllStandardCharacterChips;
-(NSArray *)getAllExpansionCharacterChips;

-(NSArray *)getAllStandardPuzzleChips;
-(NSArray *)getAllExpansionPuzzleChips;

-(NSDictionary *)selectRandomChipFromArray:(NSArray *)targetArray;

-(NSArray *)selectCharacterChips:(int)numPlayers;
-(NSArray *)selectCharacterChips:(int)numPlayers useShadows:(BOOL)useShadows;

-(NSArray *)selectPuzzleChips:(int)numPuzzleChips;
-(NSArray *)selectPuzzleChips:(int)numPuzzleChips useShadows:(BOOL)useShadows;

-(NSArray *)selectPlayerNames;

-(void)removeDisabledChipsWithSourceArray:(NSMutableArray *)source isPuzzleSet:(BOOL)puzzleSet;

@end
