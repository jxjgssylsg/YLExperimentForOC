//
//  YLLocationTool.m
//  TestLocation
//
//  Created by mingdffe on 16/5/27.
//  Copyright © 2016年 Winann. All rights reserved.
//

#import "YLLocationTool.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface YLLocationTool ()<CLLocationManagerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *latitude;

@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
@implementation YLLocationTool
- (instancetype)init
{
    self = [super init];
    // Do any additional setup after loading the view, typically from a nib.
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    [_locationManager startUpdatingLocation];
    return self;
}

- (void)locationJudge {
    
   
    int status =[CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
            double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
            if(version >= 8.0f){
                [_locationManager requestAlwaysAuthorization];//添加这句
            }
    } else if (status!= kCLAuthorizationStatusAuthorizedAlways && status!= kCLAuthorizationStatusAuthorizedWhenInUse) {
        //创建弹出窗口
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"boxfish" message:@"我们需要定位噢 " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"定位设置", nil];
        [alert show]; //显示窗口
    } else {
        // 开始定位
        [_locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    //将经度显示到label上
    _longitude= [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    //将纬度现实到label上
    _latitude = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error) {
         if (array.count > 0) {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //将获得的所有信息显示到label上
             NSLog(@"详细信息 %@",placemark.name);
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             NSLog(@"city = %@", city);
             
         } else if (error == nil && [array count] == 0) {
             NSLog(@"No results were returned.");
             
         } else if (error != nil) {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //当点击了第二个按钮（OK）
    if (buttonIndex==1) {
        if(![CLLocationManager locationServicesEnabled]) {
            NSLog(@"aaaaaaaaaa");
            NSURL * url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        } else {
            //这里似乎有些问题,当是ios7.0的时候不存在单独设置的界面,故会崩溃
            NSLog(@"bbbbbbbbbb");
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}
@end
