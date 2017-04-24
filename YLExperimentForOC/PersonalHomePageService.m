////
////  PersonalHomePageService.m
////  Baike
////
////  Created by Sheng,Yilin on 17/4/18.
////  Copyright © 2017年 Baidu.com. All rights reserved.
////
//
//#import "PersonalHomePageService.h"
//#import "PersonalVideoModel.h"
//
//static const NSTimeInterval kTimeoutInterval = 10.f;
//
//@implementation PersonalHomePageService
//
//// ** Load PersonalVideoList for the collectionView
//- (void)loadPersonalVideoListWithUserKey:(NSString *)uk PageNum:(NSInteger)pageIndex Complete:(HttpEngineCompleteBlock)complete {
//    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary: [[ReportHelper sharedHelper] reportDictionary]];
//    [mDic addEntriesFromDictionary: @{ @"pn": @(pageIndex).stringValue }];
//    [mDic addEntriesFromDictionary: @{ @"uk": uk }];
//    HttpEngineConfig *httpConfig = [HttpEngineConfig fastBuildWithPath:@"wikiapp/user/getuserhomepage" httpPost:nil];
//    httpConfig.timeoutInterval = kTimeoutInterval;
//    [httpConfig setMethod:Http_Post_Method];
//    [[HttpEngine buildWithConfig:httpConfig] executPostData:mDic success:^(NSURLSessionTask *sessionTask, NSDictionary *responseData, NSError *error) {
//        Http_ResponseResult result = Http_ResponseResult_Success;
//        BOOL hasMore = NO;
//        Log("%@",responseData)
//        if (complete) {
//            NSError *error;
//            PersonalVideoListModel *model = [[PersonalVideoListModel alloc] initWithDictionary:responseData error:&error];
//            NSDictionary *datas;
//            if (model != nil ) {
//                datas = @{kHttpResponseSuccessKey: @(YES), kHttpResponseValuesKey: model, kHttpResponseHasMoreKey: @(0)};
//            }
//            // if success then call the block function
//            if (complete) {
//                complete(result, hasMore, datas, error);
//            }
//        }
//    } failure:^(NSURLSessionTask *sessionTask, NSDictionary *responseData, NSError *error) {
//        if (complete) {
//            complete(Http_ResponseResult_Failed, NO, nil, error);
//        }
//    } progress:nil];
//    
//}
//
//@end
