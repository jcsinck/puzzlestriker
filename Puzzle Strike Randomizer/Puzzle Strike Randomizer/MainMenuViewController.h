//
//  MainMenuViewController.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/20/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Y_COORD_GAP 62
#define RANDOMIZER_BUTTON_MAX_Y 750
#define BUTTONS_VIEW_MAX_Y 580
#define SCROLLVIEW_CONTENT_MAX_Y 990 - (Y_COORD_GAP * 3)
#define SHADOWS_CHAR_SWITCH_VIEW_MAX_Y 626
#define SHADOWS_CHIPS_SWITCH_VIEW_MAX_Y 688
#define ENCYCLOPEDIA_BUTTON_MAX_Y 812
#define CONFIGURE_BUTTON_MAX_Y 874
#define ABOUT_BUTTON_MAX_Y 936

#define FIRST_INPUT_TAG 10
#define SECOND_INPUT_TAG 20
#define THIRD_INPUT_TAG 30
#define FOURTH_INPUT_TAG 40
#define FIFTH_INPUT_TAG 50

@interface MainMenuViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIButton *startRandomizerButton;
@property (nonatomic, retain) IBOutlet UIButton *encyclopediaButton;
@property (nonatomic, retain) IBOutlet UIView *buttonsView;
@property (nonatomic, retain) IBOutlet UISwitch *shadowsCharacterSwitch;
@property (nonatomic, retain) IBOutlet UISwitch *shadowsChipsSwitch;
@property (nonatomic, retain) IBOutlet UIView *shadowsCharacterSwitchContainer;
@property (nonatomic, retain) IBOutlet UIView *shadowsPuzzleSwitchContainer;
@property (nonatomic, retain) IBOutlet UIButton *configureButton;
@property (nonatomic, retain) IBOutlet UIButton *aboutButton;
@property (nonatomic, retain) IBOutlet UIImageView *startImage;
@property int numberOfPlayers;

@property (nonatomic, retain) IBOutlet UILabel *playerOneLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerTwoLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerThreeLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerFourLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerFiveLabel;

@property (nonatomic, retain) IBOutlet UITextField *playerOneInput;
@property (nonatomic, retain) IBOutlet UITextField *playerTwoInput;
@property (nonatomic, retain) IBOutlet UITextField *playerThreeInput;
@property (nonatomic, retain) IBOutlet UITextField *playerFourInput;
@property (nonatomic, retain) IBOutlet UITextField *playerFiveInput;

-(IBAction)randomizerButtonTapped;
-(IBAction)openEncyclopedia:(id)sender;
-(IBAction)openConfiguration:(id)sender;
-(IBAction)openAbout:(id)sender;

-(void)configureViewForNumPlayers:(int)numPlayers;
-(void)configureNameLabelsWithExistingNames;
-(void)reconfigureView;

-(IBAction)removePlayerButtonTapped:(id)sender;
-(IBAction)addPlayerButtonTapped:(id)sender;

-(void)resetAndLockScrollView;
@end
