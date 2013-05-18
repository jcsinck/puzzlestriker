//
//  SinglePuzzleChipDetailViewController.h
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/23/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePuzzleChipDetailViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView *chipImage;
@property (nonatomic, retain) NSDictionary *puzzleDataDictionary;
@property (nonatomic, retain) IBOutlet UITextView *faqView;

-(id)initWithPuzzleChipData:(NSDictionary *)chipData;

-(IBAction)backButtonTapped:(id)sender;

@end
