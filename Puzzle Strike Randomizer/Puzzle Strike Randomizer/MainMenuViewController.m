//
//  MainMenuViewController.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/20/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "MainMenuViewController.h"
#import "RandomChipSelector.h"
#import "AppDelegate.h"
#import "EncyclopediaViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation MainMenuViewController

@synthesize startRandomizerButton;
@synthesize encyclopediaButton;
@synthesize buttonsView;
@synthesize numberOfPlayers;
@synthesize shadowsCharacterSwitch;
@synthesize shadowsChipsSwitch;
@synthesize shadowsCharacterSwitchContainer;
@synthesize shadowsPuzzleSwitchContainer;
@synthesize configureButton;
@synthesize aboutButton;
@synthesize startImage;

@synthesize playerOneInput, playerTwoInput, playerThreeInput, playerFourInput, playerFiveInput;
@synthesize playerOneLabel, playerTwoLabel, playerThreeLabel, playerFourLabel, playerFiveLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Randomizer";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Randomizer" image:[UIImage imageNamed:@"198-card-spades.png"] tag:10];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reconfigureView) name:kNotificationReconfigureMainMenu object:nil];
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
    
    self.numberOfPlayers = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NUMBER_PLAYERS"] intValue];
    if(self.numberOfPlayers < 2)
        self.numberOfPlayers = 2;
    
    [((UIScrollView *)self.view) setContentSize:CGSizeMake(320, SCROLLVIEW_CONTENT_MAX_Y)];
    [self configureViewForNumPlayers:self.numberOfPlayers];
    [self configureNameLabelsWithExistingNames];
    
    self.startImage.layer.cornerRadius = 30.0;
    self.startImage.layer.masksToBounds = YES;
    
    self.shadowsCharacterSwitch.on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SHADOWS_CHARACTERS"] boolValue];
    self.shadowsChipsSwitch.on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SHADOWS_CHIPS"] boolValue];
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

-(void)randomizerButtonTapped
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:self.numberOfPlayers] forKey:@"NUMBER_PLAYERS"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:self.shadowsCharacterSwitch.on] forKey:@"SHADOWS_CHARACTERS"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:self.shadowsChipsSwitch.on] forKey:@"SHADOWS_CHIPS"];
    
    RandomChipSelector *rcs = [RandomChipSelector new];
    NSArray *characters = [rcs selectCharacterChips:self.numberOfPlayers useShadows:self.shadowsCharacterSwitch.on];
    NSArray *puzzleChips = [rcs selectPuzzleChips:self.numberOfPlayers >= 5 ? 12 : 10 useShadows:self.shadowsChipsSwitch.on];
    NSArray *names = [rcs selectPlayerNames];
    
    NSLog(@"Characters: %@", characters);
    NSLog(@"Puzzle Chips: %@", puzzleChips);
    
    [self resetAndLockScrollView];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate displayRandomizerRecapScreenWithCharacterArray:characters andNamesArray:names andPuzzleChipsArray:puzzleChips];
}

-(void)openEncyclopedia:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:self.numberOfPlayers] forKey:@"NUMBER_PLAYERS"];

    [self resetAndLockScrollView];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    [appDelegate displayEncyclopediaScreen];
}

-(void)openConfiguration:(id)sender
{
    [self resetAndLockScrollView];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate displayMainConfigScreen];
}

-(void)openAbout:(id)sender
{
    [self resetAndLockScrollView];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate displayAboutScreen];
}

-(void)configureViewForNumPlayers:(int)numPlayers
{
    if(numPlayers == 5)
    {
        [self.startRandomizerButton setFrame:CGRectMake(51,
                                                        RANDOMIZER_BUTTON_MAX_Y,
                                                        self.startRandomizerButton.frame.size.width, 
                                                       self.startRandomizerButton.frame.size.height)];
        
        [self.buttonsView setFrame:CGRectMake(93,
                                              BUTTONS_VIEW_MAX_Y, 
                                              self.buttonsView.frame.size.width, 
                                              self.buttonsView.frame.size.height)];
        
        [self.shadowsCharacterSwitchContainer setFrame:CGRectMake(41, 
                                                                  SHADOWS_CHAR_SWITCH_VIEW_MAX_Y, 
                                                                  self.shadowsCharacterSwitchContainer.frame.size.width, 
                                                                  self.shadowsCharacterSwitchContainer.frame.size.height)];
        
        [self.shadowsPuzzleSwitchContainer setFrame:CGRectMake(41, 
                                                               SHADOWS_CHIPS_SWITCH_VIEW_MAX_Y, 
                                                               self.shadowsPuzzleSwitchContainer.frame.size.width, 
                                                               self.shadowsPuzzleSwitchContainer.frame.size.height)];
        
        [self.encyclopediaButton setFrame:CGRectMake(51, 
                                                     ENCYCLOPEDIA_BUTTON_MAX_Y, 
                                                     self.encyclopediaButton.frame.size.width, 
                                                     self.encyclopediaButton.frame.size.height)];
        
        [self.configureButton setFrame:CGRectMake(51, 
                                                  CONFIGURE_BUTTON_MAX_Y, 
                                                  self.configureButton.frame.size.width, 
                                                  self.encyclopediaButton.frame.size.height)];
        
        [self.aboutButton setFrame:CGRectMake(50, 
                                              ABOUT_BUTTON_MAX_Y, 
                                              self.aboutButton.frame.size.width, 
                                              self.aboutButton.frame.size.height)];
        
        [((UIScrollView *)self.view) setContentSize:CGSizeMake(320, SCROLLVIEW_CONTENT_MAX_Y)];
        
        [self.playerThreeLabel setHidden:NO];
        [self.playerFourLabel setHidden:NO];
        [self.playerFiveLabel setHidden:NO];
        
        [self.playerThreeInput setHidden:NO];
        [self.playerFourInput setHidden:NO];
        [self.playerFiveInput setHidden:NO];
    }
    else if(numPlayers == 4)
    {
        [self.startRandomizerButton setFrame:CGRectMake(51, 
                                                        RANDOMIZER_BUTTON_MAX_Y - Y_COORD_GAP,
                                                        self.startRandomizerButton.frame.size.width, 
                                                        self.startRandomizerButton.frame.size.height)];
        
        [self.buttonsView setFrame:CGRectMake(93, 
                                              BUTTONS_VIEW_MAX_Y - Y_COORD_GAP,
                                              self.buttonsView.frame.size.width, 
                                              self.buttonsView.frame.size.height)];
        
        [self.shadowsCharacterSwitchContainer setFrame:CGRectMake(41, 
                                                                  SHADOWS_CHAR_SWITCH_VIEW_MAX_Y - Y_COORD_GAP, 
                                                                  self.shadowsCharacterSwitchContainer.frame.size.width, 
                                                                  self.shadowsCharacterSwitchContainer.frame.size.height)];
        
        [self.shadowsPuzzleSwitchContainer setFrame:CGRectMake(41, 
                                                               SHADOWS_CHIPS_SWITCH_VIEW_MAX_Y - Y_COORD_GAP, 
                                                               self.shadowsPuzzleSwitchContainer.frame.size.width, 
                                                               self.shadowsPuzzleSwitchContainer.frame.size.height)];
        
        [self.encyclopediaButton setFrame:CGRectMake(51, 
                                                     ENCYCLOPEDIA_BUTTON_MAX_Y - Y_COORD_GAP, 
                                                     self.encyclopediaButton.frame.size.width, 
                                                     self.encyclopediaButton.frame.size.height)];
        
        [self.configureButton setFrame:CGRectMake(51, 
                                                  CONFIGURE_BUTTON_MAX_Y - Y_COORD_GAP, 
                                                  self.configureButton.frame.size.width, 
                                                  self.encyclopediaButton.frame.size.height)];
        
        [self.aboutButton setFrame:CGRectMake(51, 
                                              ABOUT_BUTTON_MAX_Y - Y_COORD_GAP, 
                                              self.aboutButton.frame.size.width, 
                                              self.aboutButton.frame.size.height)];
        
        [((UIScrollView *)self.view) setContentSize:CGSizeMake(320, SCROLLVIEW_CONTENT_MAX_Y - Y_COORD_GAP)];
        
        [self.playerThreeLabel setHidden:NO];
        [self.playerFourLabel setHidden:NO];
        [self.playerFiveLabel setHidden:YES];
        
        [self.playerThreeInput setHidden:NO];
        [self.playerFourInput setHidden:NO];
        [self.playerFiveInput setHidden:YES];
    }
    else if(numPlayers == 3)
    {
        [self.startRandomizerButton setFrame:CGRectMake(51, 
                                                        RANDOMIZER_BUTTON_MAX_Y - Y_COORD_GAP * 2,
                                                        self.startRandomizerButton.frame.size.width, 
                                                        self.startRandomizerButton.frame.size.height)];
        
        [self.buttonsView setFrame:CGRectMake(93, 
                                              BUTTONS_VIEW_MAX_Y - Y_COORD_GAP * 2,
                                              self.buttonsView.frame.size.width, 
                                              self.buttonsView.frame.size.height)];
        
        [self.shadowsCharacterSwitchContainer setFrame:CGRectMake(41, 
                                                                  SHADOWS_CHAR_SWITCH_VIEW_MAX_Y - Y_COORD_GAP * 2, 
                                                                  self.shadowsCharacterSwitchContainer.frame.size.width, 
                                                                  self.shadowsCharacterSwitchContainer.frame.size.height)];
        
        [self.shadowsPuzzleSwitchContainer setFrame:CGRectMake(41, 
                                                               SHADOWS_CHIPS_SWITCH_VIEW_MAX_Y - Y_COORD_GAP * 2, 
                                                               self.shadowsPuzzleSwitchContainer.frame.size.width, 
                                                               self.shadowsPuzzleSwitchContainer.frame.size.height)];
        
        [self.encyclopediaButton setFrame:CGRectMake(51, 
                                                     ENCYCLOPEDIA_BUTTON_MAX_Y - Y_COORD_GAP * 2, 
                                                     self.encyclopediaButton.frame.size.width, 
                                                     self.encyclopediaButton.frame.size.height)];
        
        [self.configureButton setFrame:CGRectMake(51, 
                                                  CONFIGURE_BUTTON_MAX_Y - Y_COORD_GAP * 2, 
                                                  self.configureButton.frame.size.width, 
                                                  self.encyclopediaButton.frame.size.height)];
        
        [self.aboutButton setFrame:CGRectMake(51, 
                                              ABOUT_BUTTON_MAX_Y - Y_COORD_GAP * 2, 
                                              self.aboutButton.frame.size.width, 
                                              self.aboutButton.frame.size.height)];
        
        [((UIScrollView *)self.view) setContentSize:CGSizeMake(320, SCROLLVIEW_CONTENT_MAX_Y - Y_COORD_GAP * 2)];
        
        [self.playerThreeLabel setHidden:NO];
        [self.playerFourLabel setHidden:YES];
        [self.playerFiveLabel setHidden:YES];
        
        [self.playerThreeInput setHidden:NO];
        [self.playerFourInput setHidden:YES];
        [self.playerFiveInput setHidden:YES];
    }
    else if(numPlayers == 2)
    {
        [self.startRandomizerButton setFrame:CGRectMake(51, 
                                                        RANDOMIZER_BUTTON_MAX_Y - Y_COORD_GAP * 3,
                                                        self.startRandomizerButton.frame.size.width, 
                                                        self.startRandomizerButton.frame.size.height)];
        
        [self.buttonsView setFrame:CGRectMake(93, 
                                              BUTTONS_VIEW_MAX_Y - Y_COORD_GAP * 3,
                                              self.buttonsView.frame.size.width, 
                                              self.buttonsView.frame.size.height)];
        
        [self.shadowsCharacterSwitchContainer setFrame:CGRectMake(41, 
                                                                  SHADOWS_CHAR_SWITCH_VIEW_MAX_Y - Y_COORD_GAP * 3, 
                                                                  self.shadowsCharacterSwitchContainer.frame.size.width, 
                                                                  self.shadowsCharacterSwitchContainer.frame.size.height)];
        
        [self.shadowsPuzzleSwitchContainer setFrame:CGRectMake(41, 
                                                                  SHADOWS_CHIPS_SWITCH_VIEW_MAX_Y - Y_COORD_GAP * 3, 
                                                                  self.shadowsPuzzleSwitchContainer.frame.size.width, 
                                                                  self.shadowsPuzzleSwitchContainer.frame.size.height)];
        
        [self.encyclopediaButton setFrame:CGRectMake(51, 
                                                     ENCYCLOPEDIA_BUTTON_MAX_Y - Y_COORD_GAP * 3, 
                                                     self.encyclopediaButton.frame.size.width, 
                                                     self.encyclopediaButton.frame.size.height)];
        
        [self.configureButton setFrame:CGRectMake(51, 
                                                  CONFIGURE_BUTTON_MAX_Y - Y_COORD_GAP * 3, 
                                                  self.configureButton.frame.size.width, 
                                                  self.encyclopediaButton.frame.size.height)];
        
        [self.aboutButton setFrame:CGRectMake(51, 
                                              ABOUT_BUTTON_MAX_Y - Y_COORD_GAP * 3, 
                                              self.aboutButton.frame.size.width, 
                                              self.aboutButton.frame.size.height)];
        
        [((UIScrollView *)self.view) setContentSize:CGSizeMake(320, SCROLLVIEW_CONTENT_MAX_Y - Y_COORD_GAP * 3)];
        
        [self.playerThreeLabel setHidden:YES];
        [self.playerFourLabel setHidden:YES];
        [self.playerFiveLabel setHidden:YES];
        
        [self.playerThreeInput setHidden:YES];
        [self.playerFourInput setHidden:YES];
        [self.playerFiveInput setHidden:YES];
    }
    
    [((UIScrollView *)self.view) setScrollEnabled:YES];
}

-(void)configureNameLabelsWithExistingNames
{
    NSMutableArray *existingNames = [[NSUserDefaults standardUserDefaults] objectForKey:@"PLAYER_NAMES"];
    if(existingNames == nil)
    {
        existingNames = [[NSMutableArray alloc] initWithCapacity:5];
        
        [existingNames addObject:@""];
        [existingNames addObject:@""];
        [existingNames addObject:@""];
        [existingNames addObject:@""];
        [existingNames addObject:@""];
        
        [[NSUserDefaults standardUserDefaults] setObject:existingNames forKey:@"PLAYER_NAMES"];
    }
    
    if([[existingNames objectAtIndex:0] isKindOfClass:[NSString class]]
       && [[existingNames objectAtIndex:0] length] > 0)
    {
        [self.playerOneInput setText:[existingNames objectAtIndex:0]];
    }
    if([[existingNames objectAtIndex:1] isKindOfClass:[NSString class]]
       && [[existingNames objectAtIndex:1] length] > 0)
    {
        [self.playerTwoInput setText:[existingNames objectAtIndex:1]];
    }
    if([[existingNames objectAtIndex:2] isKindOfClass:[NSString class]]
       && [[existingNames objectAtIndex:2] length] > 0)
    {
        [self.playerThreeInput setText:[existingNames objectAtIndex:2]];
    }
    if([[existingNames objectAtIndex:3] isKindOfClass:[NSString class]]
       && [[existingNames objectAtIndex:3] length] > 0)
    {
        [self.playerFourInput setText:[existingNames objectAtIndex:3]];
    }
    if([[existingNames objectAtIndex:4] isKindOfClass:[NSString class]]
       && [[existingNames objectAtIndex:4] length] > 0)
    {
        [self.playerFiveInput setText:[existingNames objectAtIndex:4]];
    }
}

-(void)reconfigureView
{
    [self configureViewForNumPlayers:[[[NSUserDefaults standardUserDefaults] objectForKey:@"NUMBER_PLAYERS"] intValue]];
}

-(void)removePlayerButtonTapped:(id)sender
{
    if(self.numberOfPlayers > 2)
        self.numberOfPlayers--;
    
    [self configureViewForNumPlayers:self.numberOfPlayers];
}

-(void)addPlayerButtonTapped:(id)sender
{
    if(self.numberOfPlayers < 5)
        self.numberOfPlayers++;
    
    [self configureViewForNumPlayers:self.numberOfPlayers];
}

-(void)resetAndLockScrollView
{
    [((UIScrollView *)self.view) setContentSize:CGSizeMake(320, 432)];
    [((UIScrollView *)self.view) setContentOffset:CGPointMake(0, 0)];
    [((UIScrollView *)self.view) setScrollEnabled:NO];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{    
    NSMutableArray *existingNames = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"PLAYER_NAMES"]];
    
    int tag = textField.tag;
    NSString *enteredText = textField.text;
    
    if(tag == FIRST_INPUT_TAG)
    {
        [existingNames replaceObjectAtIndex:0 withObject:enteredText];
    }
    else if(tag == SECOND_INPUT_TAG)
    {
        [existingNames replaceObjectAtIndex:1 withObject:enteredText];
    }
    else if(tag == THIRD_INPUT_TAG)
    {
        [existingNames replaceObjectAtIndex:2 withObject:enteredText];
    }
    else if(tag == FOURTH_INPUT_TAG)
    {
        [existingNames replaceObjectAtIndex:3 withObject:enteredText];
    }
    else if(tag == FIFTH_INPUT_TAG)
    {
        [existingNames replaceObjectAtIndex:4 withObject:enteredText];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:existingNames forKey:@"PLAYER_NAMES"];
    
    [textField resignFirstResponder];

    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
