//
//  ViewController.m
//  GBSerachTextField
//
//  Created by jack on 16/12/28.
//  Copyright © 2016年 jack. All rights reserved.
//


/**
 * 本实例演示一个登陆页面
 * 通过NSUserDefault获取和保存用户名，密码信息
 * 用户名输入时，匹配已经保存的用户名，选择用户名时显示对应的密码
 * 引入第三方Masonry,MBProgressHUD,可以去掉
 */
#import "ViewController.h"

#import "Masonry.h"
#import "MBProgressHUD.h"
#import "GBSearchTextFieldView.h"

@interface ViewController ()
@property(strong,nonatomic) UIImageView *avatarImageView; //头像
@property(strong,nonatomic) UITextField *usernameTextField;//用户名输入框
@property(strong,nonatomic) UITextField *pwdTextField;//密码输入框
@property(strong,nonatomic) UIButton *loginButton;//登陆按钮

@property(strong,nonatomic) NSMutableArray *defaultUserArray;//用户名保存数组
@property(strong,nonatomic) NSMutableArray *defaultPwdArray;//密码保存数组，和用户名保存数组一一对应的
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initInfo];
    
    [self initLayouts];
    
    [self loadInfo];
}


-(void)initInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.defaultUserArray = [[defaults arrayForKey:@"login_username_array"] copy];;
    self.defaultPwdArray =  [[defaults arrayForKey:@"login_pwd_array"] copy];
    if(self.defaultUserArray  == nil){
        self.defaultUserArray = [NSMutableArray array];
    }
    if(self.defaultPwdArray == nil){
        self.defaultPwdArray = [NSMutableArray array];
    }
    
    //添加演示数据，实际使用中应删除
    //用户名／密码: 11ios/123,11android/456,10java/789
    //可以输入，“1”，“11”等查看效果，原谅我页面样式做得不好看
    [self.defaultUserArray addObject:@"11ios"];
    [self.defaultUserArray addObject:@"11android"];
    [self.defaultUserArray addObject:@"10java"];
    
    [self.defaultPwdArray addObject:@"123"];
    [self.defaultPwdArray addObject:@"456"];
    [self.defaultPwdArray addObject:@"789"];
}

- (void)loadInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"login_username"];
    NSString *pwd = [defaults objectForKey:@"login_pwd"];
   
    [self.usernameTextField setText:userName];
    [self.pwdTextField setText:pwd];
}

- (void)initLayouts {
    UIImageView *imageView = [UIImageView new];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 50;
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor blueColor].CGColor;
    [imageView setImage:[UIImage imageNamed:@"default-portrait"]];
    [self.view addSubview:imageView];
    self.avatarImageView = imageView;
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).with.offset(80);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    
    UITextField *usernameTextField = [UITextField new];
    usernameTextField.placeholder = @"请输入用户名";
    usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:usernameTextField];
    self.usernameTextField = usernameTextField;
    self.usernameTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(30);
        make.height.mas_equalTo(@40);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    
    //使用masonry的实质还是调用了ios7以后的autolayout，如果要更新frame，需要调用layoutIfNeeded函数进行布局，然后所约束的控件才会按照约束条件，生成当前布局相应的frame和bounds。
    //参考：http://www.jianshu.com/p/ad9c075a7547
    [self.view layoutIfNeeded];
    
    GBSearchTextFieldView *GBSearchTF = [[GBSearchTextFieldView alloc] initWithFrame:CGRectMake(self.usernameTextField.frame.origin.x+20, self.usernameTextField.frame.origin.y-150-10, self.usernameTextField.frame.size.width-40, 150) WithTextField:self.usernameTextField WithDataArray:self.defaultUserArray];
    
    [self.view addSubview:GBSearchTF];
    
    GBSearchTF.didSelectedBlock = ^(NSString *select){
        int index = -1;
        for(int i=0;i<self.defaultUserArray.count;i++){
            if([[self.defaultUserArray objectAtIndex:i] isEqualToString:select]){
                index = i;
                break;
            }
        }
        if(index >= 0){
            self.pwdTextField.text = [self.defaultPwdArray objectAtIndex:index];
        }else{
            self.pwdTextField.text = @"";
        }
        
    };
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.top.equalTo(self.usernameTextField.mas_bottom).with.offset(5);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    
    UITextField *pwdTextField = [UITextField new];
    pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwdTextField.placeholder = @"请输入密码(6-20位)";
    pwdTextField.secureTextEntry = YES;
    [self.view addSubview:pwdTextField];
    self.pwdTextField = pwdTextField;
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@40);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.top.equalTo(self.pwdTextField.mas_bottom).with.offset(5);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    
    UIButton *loginButton = [UIButton new];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 5;
    loginButton.backgroundColor = [UIColor blueColor];
    [loginButton setUserInteractionEnabled:YES];
    [loginButton addTarget:self action:@selector(clickLoginEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    self.loginButton = loginButton;
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2).with.offset(10);
        make.height.mas_equalTo(@50);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)clickLoginEvent{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    hud.dimBackground = YES;
    hud.minSize = CGSizeMake(120, 120);
    hud.userInteractionEnabled = YES;
    [window addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
   
    NSString *userName = self.usernameTextField.text;
    NSString *pwd = self.pwdTextField.text;
    if(userName == nil || userName.length == 0){
        hud.labelText = @"帐号不能为空";
        hud.mode = MBProgressHUDModeText;
        [hud show:YES];
        [hud hide:YES afterDelay:0.5];
    }else if(pwd == nil || pwd.length == 0){
        hud.labelText = @"密码不能为空";
        hud.mode = MBProgressHUDModeText;
        [hud show:YES];
        [hud hide:YES afterDelay:0.5];
    }else{
        hud.labelText = @"登录中...";
        [hud show:YES];
        
        //在这里进行登陆操作
        //登录成功后执行下面操作：把用户名密码用NSUserDefault保存
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userName forKey:@"login_username"];
        [defaults setObject:pwd forKey:@"login_pwd"];
        [defaults setObject:@YES forKey:@"login_auto"];
        
        if(![self.defaultUserArray containsObject:userName]){
            [self.defaultUserArray addObject:userName];
            [self.defaultPwdArray addObject:pwd];
            [defaults setObject:self.defaultUserArray forKey:@"login_username_array"];
            [defaults setObject:self.defaultPwdArray forKey:@"login_pwd_array"];
        }
        
        [defaults synchronize];
        
        [hud hide:YES afterDelay:0.5];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
