//
//  CharacterDetailHeaderViewController.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/22/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterDetailHeaderViewController : UIViewController

@property (nonatomic, retain) NSString *headerString;
@property (nonatomic, retain) IBOutlet UILabel *headerLabel;

-(id)initWithHeaderString:(NSString *)headerText;

@end
