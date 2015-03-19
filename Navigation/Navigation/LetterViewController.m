//
//  LetterViewController.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetterViewController.h"

static AVSpeechSynthesizer *spchSynthesizer;
static LetterViewController *prev, *next, *current;

@implementation LetterViewController {
    UIBarButtonItem *btnNext;
    UIBarButtonItem *btnPrev;
    UILabel *txtPhrase;
    UIImageView *image;
    UITabBarController *tabBar;
    UIToolbar *toolbar;
    
    NSArray *LETTERS;
    
    int letterIndex;
}

__attribute__((constructor))
static void initializaStaticVariables() {
    spchSynthesizer = [[AVSpeechSynthesizer alloc]init];
    current = [[LetterViewController alloc] initWithLetter:0];
    prev    = [[LetterViewController alloc] initWithLetter:0];
    next    = [[LetterViewController alloc] initWithLetter:0];
}

-(id)init {
    return [self initWithLetter:0];
}

-(id)initWithLetter:(int)idx {
    self = [super init];
    if(self) {
        letterIndex = idx;
        LETTERS = DataController.getLetters;
        self.title = @"Letter";
        self.tabBarItem.image = [UIImage imageNamed:@"book icon.png"];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //add top bar buttons
    btnPrev = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(onPrev:)];
    self.navigationItem.leftBarButtonItem = btnPrev;
    btnNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(onNext:)];
    self.navigationItem.rightBarButtonItem = btnNext;
    
    //add content(s)
    CGPoint center = self.view.center;
    double imgw = 200, imgh = 200;
    
    txtPhrase = [[UILabel alloc]initWithFrame:CGRectMake(center.x - imgw/2, 80, imgw, 70)];
    txtPhrase.textAlignment = NSTextAlignmentCenter;
    txtPhrase.lineBreakMode = NSLineBreakByWordWrapping;
    txtPhrase.numberOfLines = 0;
    //txtPhrase.backgroundColor = [UIColor grayColor];
    [txtPhrase setUserInteractionEnabled:YES];
    [txtPhrase addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapPhrase:)]];
    [self.view addSubview:txtPhrase];
    
    image = [[UIImageView alloc]initWithFrame:CGRectMake(center.x - imgw/2, txtPhrase.frame.origin.y + txtPhrase.frame.size.height + 50, imgw, imgh)];
    image.userInteractionEnabled = YES;
    [image addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onHoldImage:)]];
    [self.view addSubview:image];
    
    toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 40 - 50, self.view.frame.size.width, 40)];
    
    NSArray *items = @[
                       [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
        [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"edit icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onTapEdit:)],
                       [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
        [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"edit image icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onTapEdit:)],
                       [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
    ];
    toolbar.items = items;
    toolbar.backgroundColor = [UIColor grayColor];
    [self.view addSubview:toolbar];
    
    [self setLetterIndex:letterIndex];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [image setTransform:CGAffineTransformMakeScale(0.5, 0.5)];
    [txtPhrase setAlpha:0];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [image setTransform:CGAffineTransformMakeScale(1, 1)];
    
        [txtPhrase setAlpha:1];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:txtPhrase cache:NO];
    } completion:^(BOOL finished){
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        [image setTransform:CGAffineTransformMakeScale(0.5, 0.5)];
        [txtPhrase setAlpha:0];
    }];
}

-(void)setLetterIndex:(int)idx {
    letterIndex = idx;
    LetterData *letter = LETTERS[idx];
    
    txtPhrase.text = [NSString stringWithFormat:@"%@\n%@", letter.letter, letter.phrase];
    //todo do not use cached images
    image.image = [UIImage imageNamed:letter.image];
}

#pragma mark - Animations
-(void)animateImageZoomIn {
    [UIView animateWithDuration:0.3 animations:^{
        [image setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
    }];
}

-(void)animateImageZoomOut {
    [UIView animateWithDuration:0.5 animations:^{
        [image setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    }];
}

#pragma mark - Gestures / Events
-(void)onNext:(id)sender {
    [prev setLetterIndex:letterIndex];
    [next setLetterIndex:(letterIndex < LETTERS.count - 1)? letterIndex + 1 : 0];
    LetterViewController *t = current;
    current = next;
    next = t;
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    }];
    [self.navigationController setViewControllers:@[current] animated:NO];
}

-(void)onPrev:(id)sender {
    [prev setLetterIndex:(letterIndex > 0)? letterIndex - 1 : (int)LETTERS.count - 1];
    [next setLetterIndex:letterIndex];
    LetterViewController *t = current;
    current = prev;
    prev = t;
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    }];
    [self.navigationController setViewControllers:@[current] animated:NO];
}

-(void)onTapPhrase:(id)sender {
    if(spchSynthesizer.isSpeaking)
        return;
    LetterData *data = LETTERS[letterIndex];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:data.phrase];
    [utterance setRate:0.05];
    [spchSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [spchSynthesizer speakUtterance:utterance];
}

-(void)onHoldImage:(UITapGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan) {
        [self animateImageZoomIn];
    } else if(sender.state == UIGestureRecognizerStateEnded) {
        [self animateImageZoomOut];
    }
    CGPoint center = [sender locationInView:self.view];
    image.center = center;
}

-(void)onTapEdit:(UITapGestureRecognizer *)sender {
    NSLog(@"tap");
}

@end
