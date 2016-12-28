//
//  GBSearchTextFieldView.m
//  GBSerachTextField
//
//  Created by jack on 16/12/28.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "GBSearchTextFieldView.h"

#define HEIGHT_CELL 50  //定义table每行高度

@implementation GBSearchTextFieldView


- (instancetype)initWithFrame:(CGRect)frame WithTextField:(UITextField *)textField WithDataArray:(NSMutableArray *)dataArray{
    
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        _resourceArray = dataArray;
        _tableDataArray = [NSMutableArray array];
        _textField = textField;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return self;
    
}

-(void)textFileSearch:(NSString *)text{
    [_tableDataArray removeAllObjects];
    
    //匹配以输入内容text开头的数据
    for (NSString *str in _resourceArray) {
        if([str hasPrefix:text]){
            [_tableDataArray addObject:str];
        }
    }
    
    [_tableView reloadData];
    
    //匹配数据为空时，隐藏TableView
    if(_tableDataArray.count == 0){
        [_tableView setHidden:YES];
    }else{
        [_tableView setHidden:NO];
    }
}

#pragma mark -UITextField Delegate
- (void)textFieldDidChange:(UITextField *)textField{
    [self textFileSearch:textField.text];
}

//当用户全部清空的时候的时候 会调用
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    [_tableDataArray removeAllObjects];
    [_tableView reloadData];
    [_tableView setHidden:YES];
    self.didSelectedBlock(@"");
    return YES;
}

//已经开始编辑的时候 会触发这个方法
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.hidden = NO;
    [self createTableViewWithTextField];
    [self textFileSearch:textField.text];
}

//结束编辑的时候调用
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [_tableView removeFromSuperview];
    self.hidden = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}

#pragma mark -创建UITableView
- (void)createTableViewWithTextField{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    if (![self isTableView]) {
        [self addSubview:_tableView];
    }
}

- (BOOL)isTableView{
    for (UIView *vc in self.subviews) {
        if ([vc isEqual:_tableView]) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

#pragma mark -UITableView Delegate, Datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_CELL;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_tableDataArray.count > 0){
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = [UIColor grayColor].CGColor;
        _tableView.layer.cornerRadius = 10;
        //动态更新table位置
        CGFloat h = _tableDataArray.count * HEIGHT_CELL;
        if(h > self.bounds.size.height){
            h = self.bounds.size.height;
        }
        _tableView.frame = CGRectMake(self.bounds.origin.x,
                                      self.bounds.origin.y+self.bounds.size.height-h,
                                      self.bounds.size.width,
                                      h);
    }
    return _tableDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"textFieldLoginCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = _tableDataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _textField.text = _tableDataArray[indexPath.row];
    self.didSelectedBlock(_tableDataArray[indexPath.row]);//选择时回调
    [_textField resignFirstResponder];
}

@end
