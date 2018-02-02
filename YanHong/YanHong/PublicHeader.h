//
//  PublicHeader.h
//  YanHong
//
//  Created by Mr.yang on 15/12/26.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h

#define APPKEY @"462c348afa00e405a025c947a49fef97"
#define OPENID @"JH5ac247b7ac1c6f0d70c1656c9cd239db"

#define theWidth  [UIScreen mainScreen].bounds.size.width
#define theHeight  [UIScreen mainScreen].bounds.size.height

#define PublieCorlor [UIColor colorWithRed:234/225.0 green:27/255.0 blue:48/255.0 alpha:1]

#define IS_IPHONE_4_OR_LESS (theHeight< 568.0)
#define IS_IPHONE_5 (theHeight == 568.0)
#define IS_IPHONE_6 (theHeight == 667.0)
#define IS_IPHONE_6P (theHeight == 736.0)

//#define theURL  @"http://192.168.1.17:8080/YanHong/mobile.action?mobile="
//
//#define THE_POSTURL @"http://192.168.1.17:8080/YanHong/mobile.action"

#define theURL  @"http://114.215.142.89:8080/YanHong/mobile.action?mobile="

#define THE_POSTURL  @"http://114.215.142.89:8080/YanHong/mobile.action"

//命令ID(command)	命令内容
//1001，1002	全民经纪人—(经纪人注册+验证验证码)
//1003，1004	手机号码--获取验证码
//1005，1006	全民经纪人—经纪人登录
//1007，1008	全民经纪人—重置密码
//1009，1010	忘记密码--验证验证码
//1011，1012	我的 -- 修改密码
//1013，1014	退出登录--注销
//1015，1016	预约看房—(报名 + 验证验证码) 暂时不用
//1017，1018	获取网页链接地址
//1021，1022	全民经纪人—下载经纪人信息
//1023，1024	全民经纪人—上传推荐客户信息
//1025，1026	全民经纪人—我的客户信息下载
//1027，1028	全民经纪人—我的佣金，佣金信息下载
//1031，1032	我的—我是业主，上传房产绑定信息
//1037，1038	我的—(上传完善资料信息+验证验证码)
//1041，1042	首页—下载界面网页链接地址
//1043，1044	首页—下载楼盘信息
//1045，1046	我的—下载我的消息 + 业主信息
//1047，1048	全民经纪人—我的佣金，上传绑定银行卡号
//1049，1050	好友—上传手机联系人或朋友信息
//1051，1052	好友—下载朋友圈
//1053，1054	好友--朋友圈房源信息发布
//1055，1056	我的消息获取
//1057，1058	好友--房源信息转发
//1059，1060	好友--房源信息列表获取
//1061，1062	好友--房源信息获取
//1063，1064	好友--房源信息图片上传
//1065，1066	好友--房源信息图片下载
//1067，1068	好友--房屋租售订单
//1069，1070	好友--房屋出售--修改订单状态
//1071，1072	生活缴费--话费充值订单生成
//1073，1074	生活缴费--话费充值订单状态修改
//1075，1076	生活缴费--话费充值提交话费充值
//1077，1078	旅行短租--上传出租楼房信息
//1079，1080	我的--下载个人信息

#define COMMAND1022 1022
#define COMMAND1014 1014
#define COMMAND1056 1056
#define COMMAND1046 1046
#define COMMAND1006 1006
#define COMMAND1004 1004
#define COMMAND1002 1002
#define COMMAND1010 1010
#define COMMAND1009 1009
#define COMMAND1038 1038
#define COMMAND1080 1080
#define COMMAND1012 1012
#define COMMAND1058 1058
#define COMMAND1068 1068
#define COMMAND1066 1066
#define COMMAND1062 1062
#define COMMAND1058 1058
#define COMMAND1050 1050
#define COMMAND1052 1052
#define COMMAND1032 1032
#define COMMAND1024 1024
#define COMMAND1078 1078
#define COMMAND1028 1028
#define COMMAND1020 1020
#define COMMAND1042 1042
#define COMMAND1060 1060
#define COMMAND1044 1044
#define COMMAND1082 1082
#define COMMAND1086 1086
#define COMMAND1088 1088
#define COMMAND1090 1090
#define COMMAND1092 1092
#define COMMAND1026 1026
#define COMMAND1100 1100
#define COMMAND1084 1084
#define COMMAND1102 1102
#define COMMAND1016 1016
#define COMMAND1008 1008
#define COMMAND1048 1048
#define COMMAND1064 1064
#define COMMAND1106 1106
#define COMMAND1108 1108
#define COMMAND1110 1110

#define  COMMANDINT [[dic objectForKey:@"command"] intValue]



#endif /* PublicHeader_h */
