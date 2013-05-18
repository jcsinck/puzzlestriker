//
//  AppDelegate.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/19/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = tabBarController_;
@synthesize mainView;
@synthesize recapView;
@synthesize encyclopediaView;
@synthesize configureView;
@synthesize configureMainView;
@synthesize aboutView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.mainView = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    self.encyclopediaView = [[EncyclopediaViewController alloc] init];
    self.configureMainView = [[ConfigureViewController alloc] init];
    self.aboutView = [[AboutScreenViewController alloc] init];

//    self.window.rootViewController = self.mainView;
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:
                                             self.mainView,
                                             self.encyclopediaView,
                                             self.configureMainView,
                                             self.aboutView,
                                             nil];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(void)displayMainMenuScreen
{
    
}

-(void)displayRandomizerRecapScreenWithCharacterArray:(NSArray *)chars andNamesArray:(NSArray *)names andPuzzleChipsArray:(NSArray *)puzzles
{
    self.recapView = [[RandomizerRecapViewController alloc] initWithCharactersArray:chars andNamesArray:names andPuzzleChipsArray:puzzles];
    [self animateViewOntoScreen:self.recapView.view];
//    [self.mainView.view addSubview:self.recapView.view];
}

-(void)displayEncyclopediaScreenOnView:(UIView *)view
{
    self.encyclopediaView = [[EncyclopediaViewController alloc] init];
    [self animateViewOntoScreen:self.encyclopediaView.view onParentView:view];
//    [self.mainView.view addSubview:self.encyclopediaView.view];
}

-(void)displayMainConfigScreen
{
    self.configureMainView = [[ConfigureViewController alloc] init];
    [self animateViewOntoScreen:self.configureMainView.view];
//    [self.mainView.view addSubview:self.configureMainView.view];
}

-(void)displayConfigurationScreenWithPuzzleChipArray:(NSArray *)puzzleChips andExpansionPuzzleChipArray:(NSArray *)expansionChips andParentView:(UIView *)parent
{
    self.configureView = [[ConfigureRandomizerViewController alloc] initWithStandardPuzzleChipArray:puzzleChips andExpansionPuzzleChipArray:expansionChips];
    [self animateViewOntoScreen:self.configureView.view onParentView:parent];
}

-(void)displayConfigurationScreenWithCharacterChipArray:(NSArray *)characterChips andExpansionPuzzleChipArray:(NSArray *)expansionChips andParentView:(UIView *)parent
{
    self.configureView = [[ConfigureRandomizerViewController alloc] initWithStandardCharacterChipArray:characterChips andExpansionCharacterChipArray:expansionChips];
    [self animateViewOntoScreen:self.configureView.view onParentView:parent];
}

-(void)displayAboutScreen
{
    self.aboutView = [[AboutScreenViewController alloc] init];
    [self animateViewOntoScreen:self.aboutView.view];
//    [self.mainView.view addSubview:self.aboutView.view];
}

-(void)animateViewOntoScreen:(UIView *)viewToAnimate
{
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    [viewToAnimate setFrame:CGRectMake(0, screenHeight, viewToAnimate.frame.size.width, viewToAnimate.frame.size.height)];
    [self.mainView.view addSubview:viewToAnimate];
    
    [UIView beginAnimations:@"addNewView" context:nil];
    [UIView setAnimationDuration:0.4f];
    [viewToAnimate setFrame:CGRectMake(0, 0, viewToAnimate.frame.size.width, viewToAnimate.frame.size.height)];
    [UIView commitAnimations];
}

-(void)animateViewOntoScreen:(UIView *)viewToAnimate onParentView:(UIView *)parent
{
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    [viewToAnimate setFrame:CGRectMake(0, screenHeight, viewToAnimate.frame.size.width, viewToAnimate.frame.size.height)];
    [parent addSubview:viewToAnimate];
    
    [UIView beginAnimations:@"addNewView" context:nil];
    [UIView setAnimationDuration:0.4f];
    [viewToAnimate setFrame:CGRectMake(0, 0, viewToAnimate.frame.size.width, viewToAnimate.frame.size.height)];
    [UIView commitAnimations];
}

-(void)dropViewOffScreen:(UIView *)viewToDrop
{
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    [UIView beginAnimations:@"dropView" context:nil];
    [UIView setAnimationDuration:0.4f];
    [viewToDrop setFrame:CGRectMake(0, screenHeight, viewToDrop.frame.size.width, viewToDrop.frame.size.height)];
    [UIView setAnimationDelegate:viewToDrop];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    [UIView commitAnimations];
}

@end
