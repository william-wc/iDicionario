//
//  LetterViewController.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetterViewController.h"

static NSArray *LETTERS;
static AVSpeechSynthesizer *spchSynthesizer;
static LetterViewController *prev, *next, *current;

@implementation LetterViewController {
    UIBarButtonItem *btnNext;
    UIBarButtonItem *btnPrev;
    UILabel *txtPhrase;
    UIImageView *image;
    UIButton *btnRead;
    UITabBarController *tabBar;
    
    int letterIndex;
}

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
    
    txtPhrase = [[UILabel alloc]initWithFrame:CGRectMake(center.x - imgw/2, 100, imgw, 70)];
    txtPhrase.textAlignment = NSTextAlignmentCenter;
    txtPhrase.lineBreakMode = NSLineBreakByWordWrapping;
    txtPhrase.numberOfLines = 0;
    txtPhrase.backgroundColor = [UIColor grayColor];
    [self.view addSubview:txtPhrase];
    
    btnRead = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnRead setFrame:CGRectMake(center.x - imgw/2, txtPhrase.frame.origin.y + txtPhrase.frame.size.height, imgw, 70)];
    [btnRead setTitle:@"Read" forState:UIControlStateNormal];
    [btnRead addTarget:self action:@selector(onBtnRead:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRead];
    
    image = [[UIImageView alloc]initWithFrame:CGRectMake(center.x - imgw/2, btnRead.frame.origin.y + btnRead.frame.size.height, imgw, imgh)];
    image.userInteractionEnabled = YES;
    [image addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onHoldImage:)]];
    [self.view addSubview:image];
    
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
    
    self.title = letter.letter;
    txtPhrase.text = letter.phrase;
    //todo do not use cached images
    image.image = [UIImage imageNamed:letter.image];
}

#pragma mark - Animations
-(void)animateImageZoomIn {
    CGRect imgRect = image.frame;
    CGRect rect = self.view.frame;
    float z = 1;
    
    if(rect.size.width < rect.size.height) {
        z = rect.size.width / image.frame.size.width;
    } else {
        z = rect.size.height / image.frame.size.height;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [image setTransform:CGAffineTransformMakeTranslation(-imgRect.origin.x + rect.size.width/2 - imgRect.size.width * z / 2,
                                                             -imgRect.origin.y + rect.size.height/2 - imgRect.size.height * z / 2)];
        [image setTransform:CGAffineTransformMakeScale(z, z)];
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
//    [self.navigationController pushViewController:current animated:YES];
//    [self.navigationController setViewControllers:@[prev,current] animated:NO];
    
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
    //[self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController setViewControllers:@[prev,current] animated:NO];
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    }];
    [self.navigationController setViewControllers:@[current] animated:NO];
}

-(void)onBtnRead:(id)sender {
    if(spchSynthesizer.isSpeaking)
        return;
    LetterData *data = LETTERS[letterIndex];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:data.phrase];
    [spchSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [spchSynthesizer speakUtterance:utterance];
}

-(void)onHoldImage:(UITapGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan) {
        [self animateImageZoomIn];
    } else if(sender.state == UIGestureRecognizerStateEnded) {
        [self animateImageZoomOut];
    }
}


@end
