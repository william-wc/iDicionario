//
//  LetterData.h
//  Navigation
//
//  Created by William Hong Jun Cho on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface LetterData : RLMObject

@property (strong, nonatomic) NSString *letter;
@property (strong, nonatomic) NSString *phrase;
@property (strong, nonatomic) NSString *defaultImage;
@property (strong, nonatomic) NSString *userImage;
@property (strong, nonatomic) NSDate *date;

-(id)init:(NSString *)l image:(NSString *)i phrase:(NSString *)p;

-(NSString *)getImageName;

+(id)create:(NSString *)l image:(NSString *)i phrase:(NSString *)p;

@end
