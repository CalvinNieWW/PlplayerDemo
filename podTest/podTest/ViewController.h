//
//  ViewController.h
//  podTest
//
//  Created by Calvin.Nie on 16/8/3.
//  Copyright © 2016年 Calvin.Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <PLPlayerKit/PLPlayerKit.h>
#import <HappyDNS/HappyDNS.h>
@interface ViewController : UIViewController<PLPlayerDelegate>
{
    PLPlayer *m_Player;
    UIButton *player_Btn;
    UIButton *stop_Btn;
    UIButton *m_change;
    BOOL     isPlay;
    UILabel  *m_UrlStr;
    NSString *now_Url;
}
@end

