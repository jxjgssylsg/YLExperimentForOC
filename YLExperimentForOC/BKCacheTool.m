//
//  CacheTool.m
//  YLExperimentForOC
//
//  Created by syl on 16/4/26.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "BKCacheTool.h"

@interface BKCacheTool ()
@property (nonatomic, strong) NSFileManager* fileManager;
@end

@implementation BKCacheTool

-(NSFileManager *)fileManager
{
  if (_fileManager == nil) {
    self.fileManager = [[NSFileManager alloc] init];
  }
  return _fileManager;
}



+ (id)sharedManager
{
  static BKCacheTool *tool = nil;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    tool = [[self alloc] init];
  });
  return tool;
}

- (NSString *)dirpath
{
  NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
  NSString *path = [cachesPath stringByAppendingPathComponent:@"RNBudejie"];
  path = [path stringByAppendingPathComponent:@"mp3"];
  return path;
}

/** 清除缓存 */
- (NSString *)deleteCach
{
  NSString *path = [self dirpath];
  
  NSString *msg;
  if ([self.fileManager fileExistsAtPath:path]) {
    if ([self.fileManager removeItemAtPath:path error:nil]) {
      msg = @"清除缓存成功";
    } else
      msg = @"清除缓存失败";
  } else
    msg = @"缓存不存在";
  
 // test the path
  NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"model.data"];
    
  return msg;
}

/** 得到缓存大小 */
- (NSString *)getCachSize
{
  //总大小
  unsigned long long size = 0;
  
  //获得缓存文件夹路径
  NSString *dirpath = [self dirpath];
  
  //文件管理者
  self.fileManager = [NSFileManager defaultManager];
  
  //获得文件夹的大小
  //获得该路径下的所有文件名字
  NSArray *subpaths = [self.fileManager subpathsAtPath:dirpath];
  
  //累计所有文件大小
  for (NSString *subpath in subpaths) {
    //全路径
    NSString *fulSubpath = [dirpath stringByAppendingPathComponent:subpath];
    //累加文件大小 fileSize字典属性，表示字典大小
    size += [self.fileManager attributesOfItemAtPath:fulSubpath error:nil].fileSize;
  }
  
  
  NSString *sizeStr;
  if (size > 1024 * 1024) {
    size /= 1024 * 1024;
    sizeStr = [NSString stringWithFormat:@"%lluMB",size];
    return sizeStr;
  }else if (size > 1024){
    size /= 1024;
    sizeStr = [NSString stringWithFormat:@"%lluKB",size];
    return sizeStr;
  }else if (size > 0){
    sizeStr = [NSString stringWithFormat:@"%lluB",size];
    return sizeStr;
  }else
    sizeStr = @"0KB";
  return sizeStr;
}

@end
