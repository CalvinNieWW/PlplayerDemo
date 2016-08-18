//
//  ViewController.m
//  podTest
//
//  Created by Calvin.Nie on 16/8/3.
//  Copyright © 2016年 Calvin.Nie. All rights reserved.
//

#import "ViewController.h"
#define URL_Str1 @"rtmp://live.hkstv.hk.lxdns.com/live/hks"
#define URL_Str2 @"rtmp://v1.one-tv.com/live/mpegts.stream"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initPlayer:URL_Str2];
    m_Player.delegate=self;
    
    
    player_Btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [player_Btn setTitle:@"play" forState:UIControlStateNormal];
    [player_Btn addTarget:self action:@selector(playerPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:player_Btn];
    
    stop_Btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stop_Btn setTitle:@"stop" forState:UIControlStateNormal];
    [stop_Btn addTarget:self action:@selector(stopPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop_Btn];
    
//    m_change=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [m_change setTitle:@"换台" forState:UIControlStateNormal];
//    [m_change addTarget:self action:@selector(changeVideo:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:m_change];

    
    m_UrlStr=[[UILabel alloc]init];
    m_UrlStr.text=URL_Str2;
    m_UrlStr.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:m_UrlStr];
    
    [self.view addSubview:m_Player.playerView];

    
    [self seTAllViewFrame];

}
-(void)initPlayer:(NSString *)str
{
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    
    // 更改需要修改的 option 属性键所对应的值
    [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    [option setOptionValue:@1000 forKey:PLPlayerOptionKeyMaxL1BufferDuration];
    [option setOptionValue:@1000 forKey:PLPlayerOptionKeyMaxL2BufferDuration];
    [option setOptionValue:@(NO) forKey:PLPlayerOptionKeyVideoToolbox];
    [option setOptionValue:@(kPLLogWarning) forKey:PLPlayerOptionKeyLogLevel];
    [option setOptionValue:[QNDnsManager new] forKey:PLPlayerOptionKeyDNSManager];
    
    m_Player=[PLPlayer playerWithURL:[NSURL URLWithString:str] option:option];
}
//-(void)changeVideo:(UIButton *)sender
//{
//    if (sender.selected)
//    {
//        [m_Player stop];
//        [self initPlayer:URL_Str1];
//        [m_Player play];
//    }
//    else
//    {
//        [m_Player stop];
//        [self initPlayer:URL_Str2];
//        [m_Player play];
//    }
//    sender.selected=!sender.selected;
//}
-(void)seTAllViewFrame
{
    m_Player.playerView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-144.);
    player_Btn.frame=CGRectMake(40, [UIScreen mainScreen].bounds.size.height-100, 60, 40);
    stop_Btn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.height-100, 60, 40);
    m_change.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2.-30, [UIScreen mainScreen].bounds.size.height-100, 60, 40);
    m_UrlStr.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-60., [UIScreen mainScreen].bounds.size.width, 60);
    sleep(0.1);
//    [m_Player play];
//    isPlay=YES;
}
-(void)playerPlay
{
    if (isPlay==NO)
    {
        [m_Player play];
        isPlay=YES;
    }
    else
    {
        NSLog(@"正在播放状态");
    }
    
}
-(void)stopPlay
{
    if (isPlay)
    {
        [m_Player stop];
        isPlay=NO;
    }
    else
    {
        NSLog(@"已经在暂停的状态");
    }
    
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (isPlay==NO)
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    else
    {
    if ([[UIDevice currentDevice]orientation]==1||[[UIDevice currentDevice]orientation]==2)
    {
        [self seTAllViewFrame];
    }
    else
    {
        m_Player.playerView.frame=CGRectMake(0, 1, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    
    return UIInterfaceOrientationMaskAll;
    }
}
- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
    // 当发生错误时，会回调这个方法
    NSLog(@"播放发生错误：%@",error);
}
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    // 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
    // 除了 Error 状态，其他状态都会回调这个方法
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
