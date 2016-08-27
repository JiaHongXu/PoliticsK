//
//  BaseViewController.m
//  PoliticsK
//
//  Created by 307A on 16/8/6.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@property (nonatomic) UIView *statusView;
@property (nonatomic) MBProgressHUD *waitingHud;
@property (nonatomic) UIView *waitingView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _statusView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    _statusView.backgroundColor = PRIMARY_COLOR;
    [self.view addSubview:_statusView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertMsg:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *alertHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        alertHud.mode = MBProgressHUDModeText;
        alertHud.label.text = msg;
        [alertHud hideAnimated:YES afterDelay:1];
    });
}

-(void)showAlertMsgNeedsResponse:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    });
}

- (void)startWaitingIndicator
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        // 更UI
        _waitingHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

    });
    
}

- (void)stopWaitingIndicator
{

    dispatch_async(dispatch_get_main_queue(), ^{
        [_waitingHud hideAnimated:YES];
    });
}


-(void)setNavigationBarBackgroundColor:(UIColor *)color{
    _statusView.backgroundColor = color;
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(BOOL)needUpdateFont{
    return YES;
}

//以下3个方法共同实现   用户点击文本框--》键盘遮挡住了文本框---》view自动上移，使键盘不遮挡文本框
//要将相关的TextFiled的delegate属性关联到当前的viewcontroller上，不然会不起作用
- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    float height = 216;
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSLog(@"return");
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    float keyboardHeight = 216;//默认竖屏，键盘高度216
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 150 - (self.view.frame.size.height - keyboardHeight);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
