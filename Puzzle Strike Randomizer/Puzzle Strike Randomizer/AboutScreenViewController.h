//
//  AboutScreenViewController.h
//  Puzzle Strike Randomizer
//
//  Created by Jeff Sinckler on 1/21/13.
//  Copyright (c) 2013 Playforge LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutScreenViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextView *aboutText;

-(IBAction)closeWindow:(id)sender;

@end
