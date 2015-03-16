//
//  LetterViewController.m
//  Navigation
//
//  Created by William Hong Jun Cho on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetterViewController.h"

static NSArray *LETTERS;

@implementation LetterViewController {
    UIBarButtonItem *next;
    UILabel *txtLetter;
    UILabel *txtPhrase;
    UIImageView *image;
    UIButton *imageButton;
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
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        letterIndex = 0;
    }
    return self;
}

-(void)setLetterIndex:(int)idx {
    letterIndex = idx;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    LetterData *letter = LETTERS[letterIndex];
    
    //set title
    self.title = letter.letter;
    
    //add top bar button
    if(letterIndex < LETTERS.count - 1) {
        next = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
        self.navigationItem.rightBarButtonItem = next;
    }
    
    //add content(s)
    CGPoint center = self.view.center;
    double imgw = 200, imgh = 200;
    
    txtLetter = [[UILabel alloc]initWithFrame:CGRectMake(center.x - imgw/2, 100, imgw, 50)];
    txtLetter.textAlignment = NSTextAlignmentCenter;
    txtLetter.text = letter.letter;
    txtLetter.backgroundColor = [UIColor greenColor];
    [self.view addSubview:txtLetter];
    
    txtPhrase = [[UILabel alloc]initWithFrame:CGRectMake(center.x - imgw/2, txtLetter.frame.origin.y + txtLetter.frame.size.height, imgw, 70)];
    txtPhrase.textAlignment = NSTextAlignmentCenter;
    txtPhrase.lineBreakMode = NSLineBreakByWordWrapping;
    txtPhrase.numberOfLines = 0;
    txtPhrase.text = letter.phrase;
    txtPhrase.backgroundColor = [UIColor grayColor];
    [self.view addSubview:txtPhrase];

    image = [[UIImageView alloc]initWithFrame:CGRectMake(center.x - imgw/2, txtPhrase.frame.origin.y + txtPhrase.frame.size.height, imgw, imgh)];
    image.image = [UIImage imageNamed:letter.image];
    image.userInteractionEnabled = YES;
    [image addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onHoldImage:)]];
    [self.view addSubview:image];
    
    //add tabBar
    tabBar = [[UITabBarController alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [image setTransform:CGAffineTransformMakeScale(0.5, 0.5)];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self animateIntro];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self animateOutro];
}

#pragma mark - Animations
-(void)animateIntro {
    [UIView animateWithDuration:0.3 animations:^{
        [image setTransform:CGAffineTransformMakeScale(1, 1)];
    }];
}

-(void)animateOutro {
    [UIView animateWithDuration:0.3 animations:^{
        [image setTransform:CGAffineTransformMakeScale(0.5, 0.5)];
    }];
}

-(void)animateImageZoomIn {
    CGRect imgRect = image.frame;
    CGRect rect = self.view.frame;
    float z = 1;
    
    if(rect.size.width < rect.size.height) {
        z = rect.size.width / image.frame.size.width;
    } else {
        z = rect.size.height / image.frame.size.height;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
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
-(void)next:(id)sender {
    LetterViewController *nextView = [[LetterViewController alloc]initWithNibName:nil bundle:NULL];
    [nextView setLetterIndex:letterIndex + 1];
    [self.navigationController pushViewController:nextView animated:YES];
}

-(void)onHoldImage:(UITapGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan) {
        [self animateImageZoomIn];
    } else if(sender.state == UIGestureRecognizerStateEnded) {
        [self animateImageZoomOut];
    }
}

@end
