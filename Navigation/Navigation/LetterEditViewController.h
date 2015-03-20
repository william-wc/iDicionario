//
//  LetterEditViewController.h
//  Navigation
//
//  Created by William Hong Jun Cho on 3/20/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LetterData.h"
#import "DataController.h"

@interface LetterEditViewController : UIViewController<UITextFieldDelegate>

+(id)getInstance;

-(void)setLetterIndex:(int)idx;

@end
