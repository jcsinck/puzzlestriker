//
//  RandomizerRecapViewController.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/20/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "RandomizerRecapViewController.h"
#import "RandomChipSelector.h"
#import "AppDelegate.h"

@implementation RandomizerRecapViewController

@synthesize characters;
@synthesize puzzleChips;
@synthesize names;
@synthesize recapContentView;
@synthesize backButton;
@synthesize characterHeader;
@synthesize puzzleChipHeader;

-(id)initWithCharactersArray:(NSArray *)chars andNamesArray:(NSArray *)name andPuzzleChipsArray:(NSArray *)puzzles
{
    self = [super initWithNibName:@"RandomizerRecapViewController" bundle:nil];
    if(self)
    {
        self.characters = chars;
        self.puzzleChips = puzzles;
        self.names = name;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rerollCharacterChips) name:kNotificationCharacterReroll object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rerollPuzzleChips) name:kNotificationPuzzleChipReroll object:nil];
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    [self.recapContentView setDataSource:self];
    [self.recapContentView setDelegate:self];
    
    if(IS_IPHONE_5)
        [self resizeForFourInchRetina];
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

-(void)returnToMainMenu:(id)sender
{
    [((AppDelegate *)[UIApplication sharedApplication].delegate) dropViewOffScreen:self.view];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReconfigureMainMenu object:nil];
}

-(CharacterChipTableViewCell *)createCharacterCellWithTableView:(UITableView *)tableView andCharacterInfoDictionary:(NSDictionary *)characterInfo andName:(NSString *)name
{
    static NSString *characterCellIdentifier = @"characterCellIdentifier";
    
    CharacterChipTableViewCell *cell = (CharacterChipTableViewCell *)[tableView dequeueReusableCellWithIdentifier:characterCellIdentifier];
    if(cell == nil)
    {
        cell = (CharacterChipTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"CharacterChipTableViewCell" owner:nil options:nil] objectAtIndex:0];
        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    }
    
    [cell configureCharacterCellWithDataDictionary:characterInfo andName:name];
    return cell;
}

-(PuzzleChipTableViewCell *)createPuzzleChipCellWithTableView:(UITableView *)tableView andPuzzleChipInfoDictionary:(NSDictionary *)puzzleInfo
{
    static NSString *puzzleChipCellIdentifier = @"puzzleChipIdentifier";
    
    PuzzleChipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:puzzleChipCellIdentifier];
    if(cell == nil)
    {
        cell = (PuzzleChipTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"PuzzleChipTableViewCell" owner:nil options:nil] objectAtIndex:0];
        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    }
    
    [cell configurePuzzleChipCellWithDataDictionary:puzzleInfo];
    return cell;
}

#pragma mark - Button Handlers
-(void)rerollCharacterChips
{
    RandomChipSelector *rcs = [RandomChipSelector new];
    int numChars = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NUMBER_PLAYERS"] intValue];
    self.characters = [rcs selectCharacterChips:numChars];
    
    [self.recapContentView reloadData];
}

-(void)rerollPuzzleChips
{
    RandomChipSelector *rcs = [RandomChipSelector new];
    int numChars = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NUMBER_PLAYERS"] intValue];
    self.puzzleChips = [rcs selectPuzzleChips:numChars >= 5 ? 12 : 10];
    
    [self.recapContentView reloadData];
}

#pragma mark - View resizing
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

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return [self.characters count];
    }
    else if(section == 1)
    {
        return [self.puzzleChips count];
    }
    else
    {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = [indexPath section];
    if(section == 0)
        return 220;
    else if(section == 1)
        return 150;
    else
        return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    int section = [indexPath section];
    
    if(section == 0)
    {
        NSDictionary *dataDictionary = [self.characters objectAtIndex:row];
        NSString *player = [self.names objectAtIndex:row];
        return [self createCharacterCellWithTableView:tableView andCharacterInfoDictionary:dataDictionary andName:player];
    }
    else if(section == 1)
    {
        NSDictionary *dataDictionary = [self.puzzleChips objectAtIndex:row];
        return [self createPuzzleChipCellWithTableView:tableView andPuzzleChipInfoDictionary:dataDictionary];
    }
    else
    {
        return nil;
    }
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{    
    if(section == 0)
    {
        self.characterHeader = [RecapHeaderViewController new];
        self.characterHeader.header = kSectionCharacters;
        return self.characterHeader.view;
    }
    else if(section == 1)
    {
        self.puzzleChipHeader = [RecapHeaderViewController new];
        self.puzzleChipHeader.header = kSectionPuzzleChips;
        return self.puzzleChipHeader.view;
    }
    
    return nil;
}

@end
