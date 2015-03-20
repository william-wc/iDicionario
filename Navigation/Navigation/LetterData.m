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
        self.letter = l;
        self.phrase = p;
        self.defaultImage = i;
        self.userImage = @"";
    }
    return self;
}

-(NSString *)getImageName {
    return (self.userImage && ![self.userImage isEqualToString:@""])? self.userImage : self.defaultImage;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"letter:%@, phrase:%@, defaultImage:%@, userImage:%@", self.letter, self.phrase, self.defaultImage, self.userImage];
}

+(id)create:(NSString *)l image:(NSString *)i phrase:(NSString *)p {
    return [[LetterData alloc] init:l image:i phrase:p];
}

@end
