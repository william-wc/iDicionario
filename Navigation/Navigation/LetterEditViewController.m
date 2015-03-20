//
//  LetterEditViewController.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/20/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetterEditViewController.h"

@implementation LetterEditViewController {
    UITextField *txtPhrase;
    UIButton *btnCancel;
    UIButton *btnConfirm;
    
    UIAlertView *alert;
    
    int letterIndex;
}

+ (id)getInstance {
    static LetterEditViewController *instance = nil;
    @synchronized(self) {
        if (instance == nil)
            instance = [[self alloc] init];
    }
    return instance;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    CGPoint center = self.view.center;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    alert = [[UIAlertView alloc] initWithTitle:@"Invalid Text" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    txtPhrase = [[UITextField alloc]initWithFrame:CGRectMake(center.x - frame.size.width/2, center.y, frame.size.width, 70)];
    [txtPhrase setTextAlignment:NSTextAlignmentCenter];
    [txtPhrase setFont:[UIFont systemFontOfSize:30]];
    [txtPhrase setText:@"text"];
    [txtPhrase setBackgroundColor:[UIColor grayColor]];
    [txtPhrase setDelegate:self];
    [self.view addSubview:txtPhrase];
    
    btnCancel = [[UIButton alloc]initWithFrame:CGRectMake(center.x - 100, frame.size.height - 170, 80, 70)];
    [btnCancel addTarget:self action:@selector(onBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnCancel setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btnCancel];
    
    CGRect relative = btnCancel.frame;

    btnConfirm = [[UIButton alloc]initWithFrame:CGRectMake(center.x + 20, relative.origin.y, relative.size.width, relative.size.height)];
    [btnConfirm addTarget:self action:@selector(onBtnConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [btnConfirm setTitle:@"Confirm" forState:UIControlStateNormal];
    [btnConfirm setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btnConfirm];
    
    [self setLetterIndex:letterIndex];
}

-(void)setLetterIndex:(int)idx {
    letterIndex = idx;
    LetterData *data = [DataController getDataAtIndex:letterIndex];
    
    txtPhrase.text = data.phrase;
}

#pragma mark - Events
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //backspace
    if(string.length == 0)
        return YES;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9a-zA-Z ]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger matches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    return (matches > 0);
}

-(void)onBtnConfirm:(UITapGestureRecognizer *)sender {
    NSString *text = [txtPhrase.text lowercaseString];
    LetterData *data = [DataController getDataAtIndex:letterIndex];
    
    if(!text || text.length <= 2) {
        [alert setMessage:@"Must be at least 3 characters long"];
        [alert show];
    } else if(![text hasPrefix:[data.letter lowercaseString]]) {
        [alert setMessage:[NSString stringWithFormat:@"Must begin with the letter %@", data.letter]];
        [alert show];
    } else {
        data.phrase = [text capitalizedString];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)onBtnCancel:(UITapGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
