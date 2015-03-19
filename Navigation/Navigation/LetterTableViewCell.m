//
//  LetterTableViewCell.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetterTableViewCell.h"

@implementation LetterTableViewCell

-(id)init {
    self = [super init];
    if(self) {
        [self instantiateLabel];
    }
    return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self instantiateLabel];
    }
    return self;
}

-(void)instantiateLabel {
    self.txtTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 200, 50)];
    [self.txtTitle setTextAlignment:NSTextAlignmentLeft];
    [self.txtTitle setText:@"Letter"];
    [self.txtTitle setTextColor:[UIColor blackColor]];
    [self addSubview:self.txtTitle];
}

@end
