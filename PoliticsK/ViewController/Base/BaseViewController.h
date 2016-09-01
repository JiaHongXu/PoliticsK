//
//  BaseViewController.h
//  PoliticsK
//
//  Created by 307A on 16/8/6.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITextViewDelegate>
//显示提示信息
-(void)showAlertMsg:(NSString *)msg;//注意，对于present上去的view，在disMiss的时候不能使用，否则会崩溃
-(void)showAlertMsgNeedsResponse:(NSString *)msg;

- (void)setCurrentType:(int)type;

//显示等待动画框
- (void)startWaitingIndicator;
//停止等待动画框
- (void)stopWaitingIndicator;
//设置statusBar的背景颜色
-(void)setNavigationBarBackgroundColor:(UIColor *)color;
//tableview隐藏行线
-(void)setExtraCellLineHidden: (UITableView *)tableView;
//需要更新字号UI的时候调用
-(BOOL)needUpdateFont;
@end
