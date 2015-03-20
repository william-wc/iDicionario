//
//  LetterEditViewController.m//  Navigation
//
//  Created by William Hong Jun Cho on 3/20/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "EditViewController.h"
#import <Realm/Realm.h>

@implementation EditViewController {
    UITextField *txtPhrase;
    UIImageView *image;
    UIDatePicker *datePicker;
    UIButton *btnCancel;
    UIButton *btnConfirm;
    
    UIAlertView *alert;
    
    UIImagePickerController *imagePicker;
    
    int letterIndex;
}

+ (id)getInstance {
    static EditViewController *instance = nil;
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
    
    txtPhrase = [[UITextField alloc]initWithFrame:CGRectMake(center.x - frame.size.width/2, 50, frame.size.width, 70)];
    [txtPhrase setTextAlignment:NSTextAlignmentCenter];
    [txtPhrase setFont:[UIFont systemFontOfSize:30]];
    [txtPhrase setText:@"text"];
    //[txtPhrase setBackgroundColor:[UIColor grayColor]];
    [txtPhrase setDelegate:self];
    [self.view addSubview:txtPhrase];
    
    CGRect relative = txtPhrase.frame;
    
    image = [[UIImageView alloc] initWithFrame:CGRectMake(center.x - 80, relative.origin.y + relative.size.height, 160, 160)];
    //[image setBackgroundColor:[UIColor grayColor]];
    [image setUserInteractionEnabled:YES];
    [image addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapImage:)]];
    [image.layer setCornerRadius:image.frame.size.width/2];
    [image.layer setMasksToBounds:YES];
    [self.view addSubview:image];
    
    relative = image.frame;
    
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(center.x - frame.size.width/2, relative.origin.y + relative.size.height - 20, frame.size.width, 80)];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.view addSubview:datePicker];
    
    relative = datePicker.frame;
    
    btnCancel = [[UIButton alloc]initWithFrame:CGRectMake(center.x - 140, frame.size.height - 100, 80, 40)];
    [btnCancel addTarget:self action:@selector(onBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnCancel setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btnCancel];
    
    relative = btnCancel.frame;

    btnConfirm = [[UIButton alloc]initWithFrame:CGRectMake(center.x + 60, relative.origin.y, relative.size.width, relative.size.height)];
    [btnConfirm addTarget:self action:@selector(onBtnConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [btnConfirm setTitle:@"Confirm" forState:UIControlStateNormal];
    [btnConfirm setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btnConfirm];
    
    imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    [imagePicker setDelegate:self];
    
    [self setLetterIndex:letterIndex];
}

-(void)setLetterIndex:(int)idx {
    letterIndex = idx;
    LetterData *data = [DataController getDataAtIndex:letterIndex];
    
    txtPhrase.text = data.phrase;
    
    [datePicker setDate:data.date];
    
    UIImage *img = [DataController recoverImageByName:data.userImage];
    if(!img)
        img = [UIImage imageNamed:data.defaultImage];
    image.image = img;
}

#pragma mark - Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    LetterData *data = [DataController getDataAtIndex:letterIndex];
    NSString *userImageName = [NSString stringWithFormat:@"user_%@", data.letter];
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    [DataController saveImage:img name:userImageName];
    image.image = img;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [txtPhrase resignFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //backspace
    if(string.length == 0)
        return YES;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9a-zA-Z ]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger matches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    return (matches > 0);
}

-(void)onTapImage:(id)sender {
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)onBtnConfirm:(UITapGestureRecognizer *)sender {
    [txtPhrase resignFirstResponder];
    
    NSString *text = [txtPhrase.text lowercaseString];
    LetterData *data = [DataController getDataAtIndex:letterIndex];
    
    if(!text || text.length <= 2) {
        [alert setMessage:@"Must be at least 3 characters long"];
        [alert show];
    } else if(![text hasPrefix:[data.letter lowercaseString]]) {
        [alert setMessage:[NSString stringWithFormat:@"Must begin with the letter %@", data.letter]];
        [alert show];
    } else {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [data setPhrase:[text capitalizedString]];
        [data setUserImage:[NSString stringWithFormat:@"user_%@", data.letter]];
        [data setDate:datePicker.date];
        [realm commitWriteTransaction];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)onBtnCancel:(UITapGestureRecognizer *)sender {
    [txtPhrase resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
