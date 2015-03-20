//
//  MainTabBarController.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "MainTabBarController.h"
#import "LetterTableViewController.h"
#import "SearchViewController.h"

@implementation MainTabBarController {
    LetterViewController *lvc;
    LetterTableViewController *ltvc;
    SearchViewController *svc;
    
    NSNotificationCenter *nc;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    lvc = [[LetterViewController alloc]initWithLetter:0];
    ltvc = [[LetterTableViewController alloc]init];
    svc = [[SearchViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:lvc];
    self.viewControllers = @[nav, ltvc, svc];
    
    nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(onSearchFound:) name:@"search_found" object:nil];
}

-(void)onSearchFound:(NSNotification *)notification {
    int letterIndex = [(NSNumber *)notification.userInfo[@"letterIndex"] intValue];
    NSLog(@"received %d", letterIndex);
    [lvc setLetterIndex:letterIndex];
    [self setSelectedIndex:0];
}

@end
