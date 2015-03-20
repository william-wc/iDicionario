//
//  DataController.h
//  Navigation
//
//  Created by William Hong Jun Cho on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LetterData.h"
#import <Realm/Realm.h>

@interface DataController : NSObject

+(NSArray *)getLetters;
+(LetterData *)getDataAtIndex:(int)idx;
+(void)updateData:(LetterData *)data;

+(void)logData;

+(void)saveImage:(UIImage *)image name:(NSString *)name;
+(UIImage *)recoverImageByName:(NSString *)name;

+(int)getWordIndex:(NSString *)word;

@end
