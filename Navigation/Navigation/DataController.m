//
//  DataController.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "DataController.h"
#import "LetterData.h"

static NSArray *LETTERS;
NSString *const test = @"testing string";


@implementation DataController

__attribute__((constructor))
static void initializaStaticVariables() {
    LETTERS = [NSArray arrayWithObjects:
               [LetterData create:@"A" image:@"a.jpg" phrase:@"Apple"],
               [LetterData create:@"B" image:@"b.jpg" phrase:@"Banana"],
               [LetterData create:@"C" image:@"c.jpg" phrase:@"Cocoa"],
               [LetterData create:@"D" image:@"d.jpg" phrase:@"Dewberry"],
               [LetterData create:@"E" image:@"e.jpg" phrase:@"Eggfruit"],
               [LetterData create:@"F" image:@"f.jpg" phrase:@"Fig"],
               [LetterData create:@"G" image:@"g.jpg" phrase:@"Ginseng"],
               [LetterData create:@"H" image:@"h.jpg" phrase:@"Hazelnut"],
               [LetterData create:@"I" image:@"i.jpg" phrase:@"Imbu"],
               [LetterData create:@"J" image:@"j.jpg" phrase:@"Jaboticaba"],
               [LetterData create:@"K" image:@"k.jpg" phrase:@"Kaki"],
               [LetterData create:@"L" image:@"l.jpg" phrase:@"Lime"],
               [LetterData create:@"M" image:@"m.jpg" phrase:@"Macadamia nut"],
               [LetterData create:@"N" image:@"n.jpeg" phrase:@"Nectarine"],
               [LetterData create:@"O" image:@"o.jpg" phrase:@"Orange"],
               [LetterData create:@"P" image:@"p.jpeg" phrase:@"Papaya"],
               [LetterData create:@"Q" image:@"q.jpg" phrase:@"Quince"],
               [LetterData create:@"R" image:@"r.jpeg" phrase:@"Raspberry"],
               [LetterData create:@"S" image:@"s.jpg" phrase:@"Sapote"],
               [LetterData create:@"T" image:@"t.jpg" phrase:@"Tayberry"],
               [LetterData create:@"U" image:@"u.jpg" phrase:@"Ugli fruit"],
               [LetterData create:@"V" image:@"v.jpg" phrase:@"Velvet tamarind"],
               [LetterData create:@"W" image:@"w.jpeg" phrase:@"Watermelon"],
               [LetterData create:@"X" image:@"x.jpeg" phrase:@"Xigua"],
               [LetterData create:@"Y" image:@"y.jpg" phrase:@"Yam bean"],
               [LetterData create:@"Z" image:@"z.jpg" phrase:@"Zulu nut"],
               nil
               ];
}

+ (NSArray *)getLetters {
    return LETTERS;
}

+(LetterData *)getDataAtIndex:(int)idx {
    return LETTERS[idx];
}

@end
