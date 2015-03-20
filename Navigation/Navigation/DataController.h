//
//  DataController.h
//  Navigation
//
//  Created by William Hong Jun Cho on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LetterData.h"

@interface DataController : NSObject

+(NSArray *)getLetters;
+(LetterData *)getDataAtIndex:(int)idx;

@end
