//
//  MainTabBarController.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "MainTabBarController.h"
#import "LetterTableViewController.h"

@implementation MainTabBarController {
    LetterViewController *lvc;
    LetterTableViewController *ltvc;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    lvc = [[LetterViewController alloc]initWithLetter:0];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:lvc];
    
    ltvc = [[LetterTableViewController alloc]init];
    self.viewControllers = @[nav, ltvc];
}

@end
