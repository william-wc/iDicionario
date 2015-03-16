//
//  LetterData.h
//  Navigation
//
//  Created by William Hong Jun Cho on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LetterData : NSObject

@property NSString *letter;
@property NSString *phrase;
@property NSString *image;

-(id)init:(NSString *)l image:(NSString *)i phrase:(NSString *)p;

+(id)create:(NSString *)l image:(NSString *)i phrase:(NSString *)p;

@end
