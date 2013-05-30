//
//  EncyclopediaDetailViewController.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/22/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "EncyclopediaDetailViewController.h"
#import "CharacterDetailTableViewCell.h"
#import "CharacterDetailHeaderViewController.h"
#import "PuzzleChipDetailTableViewCell.h"
#import "AppDelegate.h"

@implementation EncyclopediaDetailViewController

@synthesize standardCharacters;
@synthesize expansionCharacters;
@synthesize standardPuzzleChips;
@synthesize expansionPuzzleChips;

@synthesize characterContentView;
@synthesize backButton;
@synthesize encyclopediaState;

-(id)initWithStandardChracters:(NSArray *)standardChars andExpansionChars:(NSArray *)expansionChars
{
    self = [super init];
    if(self)
    {
        self.standardCharacters = standardChars;
        self.expansionCharacters = expansionChars;
        self.encyclopediaState = kEncyclopediaStateCharacters;
    }
    
    return self;
}

-(id)initWithStandardPuzzleChips:(NSArray *)standardPuzChips andExpansionPuzzleChips:(NSArray *)expansionPuzChips
{
    self = [super init];
    if(self)
    {
        self.standardPuzzleChips = standardPuzChips;
        self.expansionPuzzleChips = expansionPuzChips;
        self.encyclopediaState = kEncyclopediaStatePuzzleChips;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.characterContentView setDelegate:self];
    [self.characterContentView setDataSource:self];
    
    if(IS_IPHONE_5)
        [self resizeForFourInchRetina];
}

-(void)resizeForFourInchRetina
{
    //increase the height of the view itself
    [self.view setFrame:CGRectMake(self.view.frame.origin.x,
                                   self.view.frame.origin.y,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height + 88)];
    
    //move the back button down
    [self.backButton setFrame:CGRectMake(self.backButton.frame.origin.x,
                                         self.backButton.frame.origin.y + 88,
                                         self.backButton.frame.size.width,
                                         self.backButton.frame.size.height)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)backButtonTapped:(id)sender
{
    [((AppDelegate *)[UIApplication sharedApplication].delegate) dropViewOffScreen:self.view];
}

-(UITableViewCell *)getCharacterCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
    static NSString *characterDetailIdentifier = @"characterDetailIdentifier";
    
    CharacterDetailTableViewCell *cell = (CharacterDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:characterDetailIdentifier];
    if(cell == nil)
    {
        cell = (CharacterDetailTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"CharacterDetailTableViewCell" owner:nil options:nil] objectAtIndex:0];
        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    }
    
    int row = [indexPath row];
    int section = [indexPath section];
    NSDictionary *characterData = nil;
    
    if(section == 0)
    {
        characterData = [self.standardCharacters objectAtIndex:row];
    }
    else if(section == 1)
    {
        characterData = [self.expansionCharacters objectAtIndex:row];
    }
    
    [cell configureCellWithDictionary:characterData];
    
    return cell;
}

-(UITableViewCell *)getPuzzleChipCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
    static NSString *puzzleChipDetailIdentifier = @"puzzleDetailIdentifier";
    
    PuzzleChipDetailTableViewCell *cell = (PuzzleChipDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:puzzleChipDetailIdentifier];
    if(cell == nil)
    {
        cell = (PuzzleChipDetailTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"PuzzleChipDetailTableViewCell" owner:nil options:nil] objectAtIndex:0];
        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    }
    
    int row = [indexPath row];
    int section = [indexPath section];
    NSDictionary *puzzleChipData = nil;
    
    if(section == 0)
    {
        puzzleChipData = [self.standardPuzzleChips objectAtIndex:row];
    }
    else if(section == 1)
    {
        puzzleChipData = [self.expansionPuzzleChips objectAtIndex:row];
    }
    
    [cell configureCellWithPuzzleDataDictionary:puzzleChipData];
    
    return cell;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.encyclopediaState == kEncyclopediaStateCharacters)
    {
        if(section == 0)
        {
            return [self.standardCharacters count];
        }
        else if(section == 1)
        {
            return [self.expansionCharacters count];
        }
        else
        {
            return 0;
        }
    }
    else
    {
        if(section == 0)
        {
            return [self.standardPuzzleChips count];
        }
        else if(section == 1)
        {
            return [self.expansionPuzzleChips count];
        }
        else
        {
            return 0;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.encyclopediaState == kEncyclopediaStateCharacters)
        return 250;
    else
        return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.encyclopediaState == kEncyclopediaStateCharacters)
        return [self getCharacterCellWithTableView:tableView andIndexPath:indexPath];
    else
        return [self getPuzzleChipCellWithTableView:tableView andIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return [[CharacterDetailHeaderViewController alloc] initWithHeaderString:@"Standard"].view;
    else if(section == 1)
        return [[CharacterDetailHeaderViewController alloc] initWithHeaderString:@"Shadows"].view;
    
    return nil;
}

@end
