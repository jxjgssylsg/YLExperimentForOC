//
//  PersonalVideoModel.h
//  Baike
//
//  Created by Sheng,Yilin on 17/4/18.
//  Copyright © 2017年 Baidu.com. All rights reserved.
//
/*
#import "BaseModel.h"
#import "BaikeModel.h"

// 个人主页 - 视频列表模型 YL Personal HomePage
@protocol PersonalVideoModel;
@protocol PersonalVideoListModel;
@protocol PersonalUserInfo;

@interface PersonalVideoModel : BaseModel

@property (nonatomic, assign) NSInteger secondId;
@property (nonatomic, copy) NSString *mediaId;
@property (nonatomic, assign) NSInteger playNum;
@property (nonatomic, copy) NSString *coverPic;
@property (nonatomic, copy) NSString *coverPicUrl;
@property (nonatomic, copy) NSString *secondTitle;
@property (nonatomic, assign) NSInteger playTime;
@property (nonatomic, copy) NSString *playUrl;


 "secondId":97205,
 "mediaId":"mda-gjmug20std7r3ga7",
 "playNum":7700874,
 "coverPic":"5fdf8db1cb134954fd0279875e4e9258d1094a31",
 "coverPicUrl":"http://e.hiphotos.baidu.com/baike/eWH%3D400%2C300/sign=732005588fd6277ffb784f351c082f1c/5fdf8db1cb134954fd0279875e4e9258d1094a31.jpg",
 "secondTitle":"蓝瘦香菇，我控几不住我记几啊！",
 "playTime":164,
 "playUrl":"http://gcjgdrdrzymhp9e2xpz.exp.bcevod.com/mda-gjmug20std7r3ga7/mda-gjmug20std7r3ga7.m3u8"
 

@end

@interface PersonalUserInfo : BaseModel

@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *portraitUrl;
@property (nonatomic, copy) NSString *uk;
@property (nonatomic, assign) NSInteger onlineSecondNum;

@end

@interface PersonalVideoListModel : BaikeModel

@property (nonatomic, copy) NSArray <PersonalVideoModel> *datas;
@property (nonatomic, strong) PersonalUserInfo *userinfo;


@end


 {
 "errno":200,
 "errmsg":"",
 "baseTime":1492409233,
 "data":{
 "userinfo":{
 "uname":"huwennk",
 "portraitUrl":"http://himg.bdimg.com/sys/portrait/item/c837687577656e6e6b080c.jpg",
 "uk":"ttt",
 "onlineSecondNum":3
 },
 "list":[
 {
 "secondId":97205,
 "mediaId":"mda-gjmug20std7r3ga7",
 "playNum":7700874,
 "coverPic":"5fdf8db1cb134954fd0279875e4e9258d1094a31",
 "coverPicUrl":"http://e.hiphotos.baidu.com/baike/eWH%3D400%2C300/sign=732005588fd6277ffb784f351c082f1c/5fdf8db1cb134954fd0279875e4e9258d1094a31.jpg",
 "secondTitle":"蓝瘦香菇，我控几不住我记几啊！",
 "playTime":164,
 "playUrl":"http://gcjgdrdrzymhp9e2xpz.exp.bcevod.com/mda-gjmug20std7r3ga7/mda-gjmug20std7r3ga7.m3u8"
 }
 ],
 "pn":0,
 "hasMore":false
 }
 }

*/
