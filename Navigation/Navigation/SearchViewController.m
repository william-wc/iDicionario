//
//  SearchViewController.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/20/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "SearchViewController.h"
#import "DataController.h"

@implementation SearchViewController {
    UILabel *lbl;
    UITextField *txtSearch;
    UIButton *btnSearch;
}

-(id)init {
    self = [super init];
    if(self) {
        [self setTitle:@"Search"];
        [self.tabBarItem setImage:[UIImage imageNamed:@"magnifier icon.png"]];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    CGPoint center = self.view.center;
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(center.x - frame.size.width/2, 50, frame.size.width, 30)];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setLineBreakMode:NSLineBreakByWordWrapping];
    [lbl setNumberOfLines:0];
    [lbl setText:@"Search for word in dictionary:"];
    [self.view addSubview:lbl];
    
    txtSearch = [[UITextField alloc]initWithFrame:CGRectMake(center.x - 100, lbl.frame.origin.y + lbl.frame.size.height, 200, 70)];
    [txtSearch setTextAlignment:NSTextAlignmentCenter];
    [txtSearch setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:txtSearch];
    
    btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(center.x - 50, txtSearch.frame.origin.y + txtSearch.frame.size.height, 100, 70)];
    [btnSearch setTitle:@"Search" forState:UIControlStateNormal];
    [btnSearch setBackgroundColor:[UIColor brownColor]];
    [btnSearch addTarget:self action:@selector(onBtnFind:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSearch];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [lbl setText:@"Search for word in dictionary:"];
    [txtSearch setText:@""];
}

-(void)shakeTextField {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.1];
    [animation setRepeatCount:2];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(txtSearch.center.x - 20, txtSearch.center.y)]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(txtSearch.center.x + 20, txtSearch.center.y)]];
    [txtSearch.layer addAnimation:animation forKey:@"position"];
}

-(void)onBtnFind:(id)sender {
    int letterIndex = [DataController getWordIndex:txtSearch.text];
    if(letterIndex != -1) {
        NSLog(@"sending %d", letterIndex);
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"search_found" object:self userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:letterIndex] forKey:@"letterIndex"]];
    } else {
        [lbl setText:@"Word not found"];
        [self shakeTextField];
    }
}

@end
