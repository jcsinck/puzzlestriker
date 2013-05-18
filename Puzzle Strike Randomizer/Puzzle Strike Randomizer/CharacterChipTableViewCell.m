//
//  CharacterChipTableViewCell.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/20/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "CharacterChipTableViewCell.h"
#import "AppDelegate.h"

@implementation CharacterChipTableViewCell

@synthesize chipImage;
@synthesize playerNameLabel;
@synthesize characterDetailView;
@synthesize characterDataDictionary;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)configureCharacterCellWithDataDictionary:(NSDictionary *)data andName:(NSString *)playerName
{
    NSString *characterCardName = [data objectForKey:@"chipAssetName"];
    [self.chipImage setImage:[UIImage imageNamed:characterCardName]];
    
    [self.playerNameLabel setText:playerName];
    
    self.characterDataDictionary = data;
}

-(void)seeAbilityChipsTapped:(id)sender
{
    self.characterDetailView = [[SingleCharacterDetailViewController alloc] initWithCharacterData:self.characterDataDictionary];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) animateViewOntoScreen:self.characterDetailView.view];
}

@end
