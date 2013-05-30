//
//  ConfigureRandomizerViewController.m
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 11/4/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "ConfigureRandomizerViewController.h"
#import "CharacterDetailHeaderViewController.h"
#import "AppDelegate.h"

@implementation ConfigureRandomizerViewController

@synthesize configureTable;
@synthesize backButton;
@synthesize rsm;

-(id)initWithStandardPuzzleChipArray:(NSArray *)standard andExpansionPuzzleChipArray:(NSArray *)expansion
{
    self = [super initWithNibName:@"ConfigureRandomizerViewController" bundle:nil];
    if (self) {
        // Custom initialization
        rsm = [[RandomizerSettingsManager alloc] init];
        standardPuzzleChips = standard;
        expansionPuzzleChips = expansion;
        configMode = kConfigurationModePuzzleChips;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configurationRowEnabled:) name:kNotificationChipEnabled object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configurationRowDisabled:) name:kNotificationChipDisabled object:nil];
    
    return self;
}

-(id)initWithStandardCharacterChipArray:(NSArray *)standard andExpansionCharacterChipArray:(NSArray *)expansion
{
    self = [super initWithNibName:@"ConfigureRandomizerViewController" bundle:nil];
    if (self) {
        // Custom initialization
        rsm = [[RandomizerSettingsManager alloc] init];
        standardCharacterChips = standard;
        expansionCharacterChips = expansion;
        configMode = kConfigurationModeCharacterChips;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configurationCharacterRowEnabled:) name:kNotificationCharacterChipEnabled object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configurationCharacterRowDisabled:) name:kNotificationCharacterChipDisabled object:nil];
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        rsm = [[RandomizerSettingsManager alloc] init];
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
    
    [self.configureTable setDataSource:self];
    [self.configureTable setDelegate:self];
    
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

-(void)returnToMainMenu:(id)sender
{
    [rsm saveRandomizerConfiguration];
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate) dropViewOffScreen:self.view];
}

-(ConfigureTableViewCell *)createConfigureCellWithTableView:(UITableView *)tableView andChipData:(NSDictionary *)chipData
{
    static NSString *cellIdentifier = @"configureCellID";
    
    ConfigureTableViewCell *cell = (ConfigureTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = (ConfigureTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"ConfigureTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    BOOL isEnabled = ![rsm isChipDisabledWithID:[[chipData objectForKey:@"chipID"] intValue]];
    [cell configureCellWithChipData:chipData andEnabledFlag:isEnabled];
    
    return cell;
}

-(ConfigureCharacterTableViewCell *)createConfigureCharacterCellWithTableView:(UITableView *)tableView andChipData:(NSDictionary *)chipData
{
    static NSString *characterCellIdentifier = @"configureCharacterCellID";
    
    ConfigureCharacterTableViewCell *cell = (ConfigureCharacterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:characterCellIdentifier];
    if(cell == nil)
    {
        cell = (ConfigureCharacterTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"ConfigureCharacterTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    BOOL isEnabled = ![rsm isCharacterChipDisabledWithID:[[chipData objectForKey:@"chipID"] intValue]];
    [cell configureCellWithChipData:chipData andEnabledFlag:isEnabled];
    
    return cell;
}

-(void)configurationRowEnabled:(NSNotification *)notif
{
    int chipID = [notif.object intValue];
    
    [rsm enableChipWithID:chipID];
}

-(void)configurationRowDisabled:(NSNotification *)notif
{
    int chipID = [notif.object intValue];
    
    [rsm disableChipWithID:chipID];
}

-(void)configurationCharacterRowEnabled:(NSNotification *)notif
{
    int chipID = [notif.object intValue];
    
    [rsm enableCharacterChipWithID:chipID];
}

-(void)configurationCharacterRowDisabled:(NSNotification *)notif
{
    int chipID = [notif.object intValue];
    
    [rsm disableCharacterChipWithID:chipID];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(configMode == kConfigurationModePuzzleChips)
    {
        if(section == 0)
            return [standardPuzzleChips count];
        else
            return [expansionPuzzleChips count];
    }
    else
    {
        if(section == 0)
            return [standardCharacterChips count];
        else
            return [expansionCharacterChips count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = [indexPath section];
    int row = [indexPath row];
    NSDictionary *chipData = nil;
    
    if(configMode == kConfigurationModePuzzleChips)
    {
        if(section == 0)
        {
            chipData = [standardPuzzleChips objectAtIndex:row];
        }
        else if(section == 1)
        {
            chipData = [expansionPuzzleChips objectAtIndex:row];
        }
        
        return [self createConfigureCellWithTableView:tableView andChipData:chipData];
    }
    else
    {
        if(section == 0)
        {
            chipData = [standardCharacterChips objectAtIndex:row];
        }
        else if(section == 1)
        {
            chipData = [expansionCharacterChips objectAtIndex:row];
        }
        
        return [self createConfigureCharacterCellWithTableView:tableView andChipData:chipData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(configMode == kConfigurationModePuzzleChips)
        return 60;
    else
        return 100;
}

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
