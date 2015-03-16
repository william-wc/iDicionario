//
//  LetterData.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetterData.h"

@implementation LetterData

-(id)init:(NSString *)l image:(NSString *)i phrase:(NSString *)p {
    self = [super init];
    if(self) {
        _letter = l;
        _phrase = p;
        _image = i;
    }
    return self;
}

+(id)create:(NSString *)l image:(NSString *)i phrase:(NSString *)p {
    return [[LetterData alloc] init:l image:i phrase:p];
}

@end
