//
//  LetterTableViewController.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetterTableViewController.h"
#import "LetterTableViewCell.h"
#import "LetterData.h"
#import "DataController.h"

static NSString *CELL_IDENTIFIER = @"myCustomCell";

@implementation LetterTableViewController {
    NSArray *LETTERS;
}

-(id)init {
    self = [super init];
    if(self) {
        self.title = @"Alphabet";
        self.tabBarItem.image = [UIImage imageNamed:@"bullet list.png"];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    LETTERS = [DataController getLetters];
    
    [self.tableView registerClass:[LetterTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGRect screen = [[UIScreen mainScreen] bounds];
    [self.view setFrame:CGRectMake(0, 20, screen.size.width, screen.size.height - 70)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return LETTERS.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LetterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    LetterData *data = LETTERS[indexPath.row];
    [cell.txtTitle setText:[NSString stringWithFormat:@"%@ - %@", data.letter, data.phrase]];
    
    return cell;
}

@end
