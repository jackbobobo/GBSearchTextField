//
//  GBSearchTextFieldView.h
//  GBSerachTextField
//
//  Created by jack on 16/12/28.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBSearchTextFieldView : UIView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *tableDataArray;//table显示数据数组
@property (nonatomic, strong) NSMutableArray *resourceArray;//源数组，用于根据输入内容查询结果
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,copy) void(^didSelectedBlock)(NSString *);

- (instancetype)initWithFrame:(CGRect)frame WithTextField:(UITextField *)textField WithDataArray:(NSMutableArray *)dataArray;
@end
