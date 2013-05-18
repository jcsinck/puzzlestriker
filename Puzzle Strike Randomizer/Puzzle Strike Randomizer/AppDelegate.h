//
//  AppDelegate.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/19/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuViewController.h"
#import "RandomizerRecapViewController.h"
#import "EncyclopediaViewController.h"
#import "ConfigureRandomizerViewController.h"
#import "ConfigureViewController.h"
#import "AboutScreenViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic, strong) MainMenuViewController *mainView;
@property (nonatomic, strong) RandomizerRecapViewController *recapView;
@property (nonatomic, strong) EncyclopediaViewController *encyclopediaView;
@property (nonatomic, strong) ConfigureRandomizerViewController *configureView;
@property (nonatomic, strong) ConfigureViewController *configureMainView;
@property (nonatomic, strong) AboutScreenViewController *aboutView;

-(void)displayMainMenuScreen;
-(void)displayRandomizerRecapScreenWithCharacterArray:(NSArray *)chars andNamesArray:(NSArray *)names andPuzzleChipsArray:(NSArray *)puzzles;
-(void)displayEncyclopediaScreenOnView:(UIView *)view;
-(void)displayMainConfigScreen;
-(void)displayConfigurationScreenWithPuzzleChipArray:(NSArray *)puzzleChips andExpansionPuzzleChipArray:(NSArray *)expansionChips andParentView:(UIView *)parent;
-(void)displayConfigurationScreenWithCharacterChipArray:(NSArray *)characterChips andExpansionPuzzleChipArray:(NSArray *)expansionChips andParentView:(UIView *)parent;
-(void)displayAboutScreen;

-(void)animateViewOntoScreen:(UIView *)viewToAnimate;
-(void)animateViewOntoScreen:(UIView *)viewToAnimate onParentView:(UIView *)parent;
-(void)dropViewOffScreen:(UIView *)viewToDrop;

@end
