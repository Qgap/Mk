//
//  AppUtils.h
//  CNMedicalForDoctor
//
//  Created by Rworld on 14-11-10.
//  Copyright (c) 2014年 Rworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//这是我写的宏

//后端有时候给个NSNull

//这个能把空字符串自动转成一个@“”

//你知道，字典放一个nil
#define null(string) (isEmptyStr(string)?@"":string)
#define nullStr(string,defaultString) (isEmptyStr(string) ? defaultString : string)

#define isNull(string) ([AppUtils isEmptyString:string])

#define isEmptyStr(string) ([AppUtils isEmptyString:string])
#define isNotEmptyStr(string) (![AppUtils isEmptyString:string])

@interface AppUtils : NSObject

#pragma mark  -  网络

+ (BOOL)isExistenceNetwork;//基于第三方Reachability

+ (BOOL)isEnableWIFI;//基于第三方Reachability

+ (BOOL)isEnable3G;//基于第三方Reachability

//+ (NetworkStatus)networkStatus;//基于第三方Reachability

#pragma mark  -  字符串
+ (BOOL)isEmptyString:(NSString *)string;//检查字符串(ps:不作为方法添加到NSString的类别里是因为字符串为nil时无法调用方法)

+ (NSString*)base64Encode:(NSData *)data;//64位编码

+ (NSString *)getCurrentLocalVersion;// 获取当前应用版本号

#pragma mark  -  数组
+ (NSString *)getPageWithArray:(NSArray *)array size:(NSInteger)size;
NSInteger page(NSInteger size,NSArray *array);

#pragma mark  -  时间
+ (NSString *)getCurrentWeekStartAndEndTime;//获取本周起止时间

+ (NSString *)getDateStringFrom:(NSDate *)date WithFormatter:(NSString *)formatter;//获取自定义格式的时间

+ (NSString *)getTimeStringFromTimeInterval:(CGFloat)timeInterval type:(NSInteger)type;//24小时内的毫秒数格式化为时间

+ (NSString *)timeSignWithSecond:(NSInteger)second;// 把秒数转化为以度、分、秒（°、′、″）表示的字符串


#pragma mark  -  音频
+ (NSString *)convertVoiceToMp3WithURL:(NSString *)path;//音频文件转换成.mp3格式




#pragma mark  -  图片
+ (void)saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

+ (UIImage *)loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;


#pragma mark  -  视图
+ (void)addLab:(UILabel *)lab toView:(UIView *)superView withArray:(NSArray *)array;


#pragma mark  -  其他
+ (UIViewController *)getCurrentVC;

@end
