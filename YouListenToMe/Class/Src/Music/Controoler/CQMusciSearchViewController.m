//
//  CQMusciSearchViewController.m
//  YouListenToMe
//
//  Created by 程倩 on 15/11/26.
//  Copyright (c) 2015年 CQ. All rights reserved.
//音乐搜索频道

#import "CQMusciSearchViewController.h"
#import "SystemInfo.h"
#import "CQYouListenToMeUtils.h"
#import "XiaMiUtils.h"
#import "Musicdetail.h"
#import "CQMusicSrarchChannelView.h"
#import "MJRefresh.h"

#define DaoDaoNavHeight    ((IOS7_OR_LATER) ? 64 : 44)


@interface CQMusciSearchViewController ()<UITextFieldDelegate,XiaMiUtilsdelegate,CQMusicSrarchChannelViewdelegate>
{
    UIButton            *_searchBtn;          //搜索图标
    UITextField         *_searchField;     // 搜索框
    CQMusicSrarchChannelView  *_channelTableView;



}
@property (nonatomic, strong) XiaMiUtils                *xiamiutils;



@end

@implementation CQMusciSearchViewController
#pragma mark -生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CQBackGroundColor;
    
    // 添加顶部的topview控件
    [self creatDetail];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_searchField becomeFirstResponder];
    // 注册通知
    [self addKeyboardNotification];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeKeyboardNotification];
    
}

#pragma mark -添加头部搜索区域控件
- (void)creatDetail{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, DaoDaoNavHeight)];
    topView.backgroundColor = CQBackGroundColor;
    [self.view addSubview:topView];
    
    _searchBtn = [CQYouListenToMeUtils creatCustomButton:CGRectMake(18, DaoDaoStatusBarHeight+4, 30, 34) :@"" :15 :[UIColor colorWithHexString:@"#353d44"]];
    [_searchBtn setImage:[UIImage imageNamed:@"my_music_icon_search_mix"] forState:UIControlStateNormal];
    _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    _searchBtn.backgroundColor = [UIColor whiteColor];
    [topView addSubview:_searchBtn];
    
    _searchField = [CQYouListenToMeUtils creatCustomTextfield:CGRectMake(85 - 38, DaoDaoStatusBarHeight+4, kScreenWidth-120 - 20 - 5 + 38, 34) :14];
    _searchField.placeholder = @"输入歌名,歌手名,专辑名";
    _searchField.backgroundColor = [UIColor whiteColor];
    _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchField.delegate = self;
    [_searchField addTarget:self action:@selector(searchTextChange:) forControlEvents:UIControlEventEditingChanged];
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, topView.height-0.5,kScreenWidth , 0.5)];
    view.backgroundColor = [UIColor colorWithHexString:@"#dcdcdc"];
    [topView addSubview:_searchField];
    [topView addSubview:view];
    
    
    
    UIButton *cancelBtn = [CQYouListenToMeUtils creatCustomButton:CGRectMake(kScreenWidth-14*4, DaoDaoStatusBarHeight+4, 14*4, 36) :@"取消" :15 :[UIColor colorWithHexString:@"#353d44"]];
    cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [cancelBtn addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelBtn];
    
    //添加点击手势，点击空白处收回键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardDismiss)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark  搜索文本框的EditingChanged事件
- (void)searchTextChange:(UITextField *)textFiled{
    if (textFiled.text.length == 0)
    {
        [_channelTableView removeFromSuperview];
        _channelTableView = nil;
        return;
    }

    // 在这里请求虾米SDK
    NSString *str = textFiled.text;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:str forKey:@"key"];
    [self.xiamiutils requestWithMethod:@"search.songs" params:dict];
}
#pragma mark  虾米音乐搜索回调
- (void)getMusicSerchResult:(NSArray *)array ismore:(BOOL)more
{
    
    if(array.count == 0)
    {
        return;
    }else{
        [self showChannelTableView];

        
        NSMutableArray *mutablearray = [NSMutableArray array];
        for(int i=0;i<array.count;i++)
        {
            NSDictionary *dict = [array safeObjectAtIndex:i];
            Musicdetail *dto= [Musicdetail parser:dict];
            [mutablearray addObject:dto];
            
        }
        //设置搜索关键词
        _channelTableView.keyWord = _searchField.text;
        
        _channelTableView.isHaveMore = more;
        
        _channelTableView.dataArray = mutablearray;
        if(!more)
        {
            _channelTableView.tableView.footer.hidden = YES;
        }
        
    }
}


#pragma mark  如果存在搜索内容
- (void)showChannelTableView{
    //搜索内容存在
    if (_channelTableView == nil){
        _channelTableView = [[CQMusicSrarchChannelView alloc] initWithFrame:CGRectMake(0, DaoDaoNavHeight, kScreenWidth, kScreenHeight - 64)];
        _channelTableView.parentNavController = self.navigationController;
        _channelTableView.Musicdelegate = self;
       
        [self.view addSubview:_channelTableView];
    }
    

}



#pragma mark - 点击取消返回
- (void)backForePage{
    [self keyBoardDismiss];
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

#pragma mark - 点击空白部分收回键盘
- (void)keyBoardDismiss{
    [_searchField resignFirstResponder];
}
#pragma mark -注册键盘通知
-(void)addKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark -移除键盘通知
- (void)removeKeyboardNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -  键盘弹出动画
- (void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    
  
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
}

#pragma mark 键盘收回动画
- (void)keyboardWillHide:(NSNotification *)notification{
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    NSDictionary *userInfo = [notification userInfo];
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
}
#pragma mark - XiaMiUtils懒加载
-(XiaMiUtils *)xiamiutils
{
    if(!_xiamiutils)
    {
        _xiamiutils =[[XiaMiUtils alloc]init];
        _xiamiutils.delegate = self;
    }
    return _xiamiutils;
}

-(void)getChoiceOfMusic:(Musicdetail *)musicdto
{
    if([self.delegate respondsToSelector:@selector(getChoiceOfMusic:)])
    {
        [self.delegate getChoiceOfMusic:musicdto];
        
    }
    [self backForePage];
}
-(void)resignToFirstResponder
{
    [_searchField resignFirstResponder];
}
@end
