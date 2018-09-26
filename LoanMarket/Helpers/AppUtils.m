//
//  AppUtils.m
//  CNMedicalForDoctor
//
//  Created by Rworld on 14-11-10.
//  Copyright (c) 2014年 Rworld. All rights reserved.
//

#import "AppUtils.h"
#import "CommonCrypto/CommonDigest.h"

//获取联系人
#import <AddressBook/AddressBook.h>

//音频
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
//#import "lame.h"


@implementation AppUtils



#pragma mark  -  网络
/*
+ (BOOL)isExistenceNetwork {
    BOOL isExistenceNetwork = FALSE;
    Reachability *r =[Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=FALSE;
            
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=TRUE;
            
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=TRUE;
            
            break;
    }
    
    return isExistenceNetwork;
}

+ (BOOL)isEnableWIFI
{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}


+ (BOOL)isEnable3G
{
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

+ (NetworkStatus)networkStatus
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    return [r currentReachabilityStatus];
}
*/

#pragma mark  -  字符串
+ (BOOL)isEmptyString:(NSString *)string {
    if ([string isKindOfClass:[NSString class]] || [string isKindOfClass:[NSNull class]]) {
        return (string == nil) || [string isEqual:[NSNull null]] || (string.length == 0) ;
    }
    else {
        return YES;
    }
}

+ (NSString*)base64Encode:(NSData *)data {
    static char base64EncodingTable[64] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };
    int length = (int)[data length];
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    return result;
}

+ (NSString *)getCurrentLocalVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    return appVersion;
}

#pragma mark  -  数组
+ (NSString *)getPageWithArray:(NSArray *)array size:(NSInteger)size {
    if (array && array.count) {
        if (size > 0) {
            NSInteger a = array.count % size > 0 ? 1 : 0;// 还有余数要加1，否则加0
            return [NSString stringWithFormat:@"%lu",array.count / size + a + 1];
        }
        else {
            return @"1";
        }
    }
    else {// 没有的情况默认要取第一页
        return @"1";
    }
}

NSInteger page(NSInteger size,NSArray *array) {
    
    if (array && array.count) {
        if (size > 0) {
            NSInteger a = array.count % size > 0 ? 1 : 0;// 还有余数要加1，否则加0
            return array.count / size + a + 1;
        }
        else {
            return 1;
        }
    }
    else {// 没有的情况默认要取第一页
        return 1;
    }
}


#pragma mark  -  时间
+ (NSString *)getCurrentWeekStartAndEndTime {
    unsigned units=NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSCalendar *mycal=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now=[NSDate date];
    NSDateComponents *comp =[mycal components:units fromDate:now];
    NSInteger month=[comp month];
    NSInteger year =[comp year];
    NSInteger day=[comp day];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *dateComps = [gregorian components:NSWeekdayCalendarUnit fromDate:now];
    int daycount = (int)[dateComps weekday] - 2;
    NSDate *weekdaybegin=[now dateByAddingTimeInterval:-daycount*60*60*24];
    NSDate *weekdayend  =[now  dateByAddingTimeInterval:(6-daycount)*60*60*24];
    NSDateFormatter *df1=[[NSDateFormatter alloc]init];
    NSLocale *mylocal=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    [df1 setLocale:mylocal];
    [df1 setDateFormat:@"YYYY-MM-d"];
    now=weekdaybegin;
    comp=[mycal components:units fromDate:now];
    month=[comp month];
    year =[comp year];
    day=[comp day];
    NSString *date1=[[NSString alloc]initWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];//所要求的周一的日期
    now=weekdayend;
    comp=[mycal components:units fromDate:now];
    month=[comp month];
    year =[comp year];
    day=[comp day];
    NSString *date2=[[NSString alloc]initWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];//所要求的周日的日期
    NSString *returnString = [NSString stringWithFormat:@"%@%@",date1,date2];
    [returnString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return returnString;
}

+ (NSString *)getDateStringFrom:(NSDate *)date WithFormatter:(NSString *)formatter {
    /*
     yyyy-MM-dd HH:mm:ss zzz
     */
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setDateFormat:formatter];
    NSString *time = [timeFormatter stringFromDate:date];
    return time;
}

+ (NSString *)getTimeStringFromTimeInterval:(CGFloat)timeInterval type:(NSInteger)type {
    /*
     *type
     *1  HH:mm:ss zzzz
     *2  HH:mm:ss
     *3  HH:mm
     *4  HH
     */
        //毫秒数
        unsigned int msec_total = timeInterval;
        if (msec_total > 0) {//86400000为一整天的秒数 msec_total <= 86400000 &&
            //秒数和余毫秒数
            unsigned int sec_total = msec_total / 1000;
            unsigned int msec = msec_total % 1000; /* What we want */
            
            //分钟数和余秒数
            unsigned int min_total = sec_total / 60;
            unsigned int sec = sec_total % 60;
            
            //小时数和余分钟数为:
            unsigned int hour_total = min_total / 60;
            unsigned int min = min_total % 60;
            
            //余小时数为：
            unsigned int hour = hour_total;
            
            //避免nil传进string导致赋值失败
            if (!hour) {
                hour = 0;
            }
            if (!min) {
                min = 0;
            }
            if (!sec) {
                sec = 0;
            }
            if (!msec) {
                msec = 0;
            }
            
            NSString *string = [NSString string];
            switch (type) {
                case 1:
                    string = [NSString stringWithFormat:@"%@:%@:%@ %@",
                              [NSString stringWithFormat:@"%@%d",(hour < 10?@"0":@""),hour],
                              [NSString stringWithFormat:@"%@%d",(min < 10?@"0":@""),min],
                              [NSString stringWithFormat:@"%@%d",(sec < 10?@"0":@""),sec],
                              [NSString stringWithFormat:@"%d",msec]];
                    break;
                case 2:
                    string = [NSString stringWithFormat:@"%@:%@:%@",
                              [NSString stringWithFormat:@"%@%d",(hour < 10?@"0":@""),hour],
                              [NSString stringWithFormat:@"%@%d",(min < 10?@"0":@""),min],
                              [NSString stringWithFormat:@"%@%d",(sec < 10?@"0":@""),sec]];
                    break;
                case 3:
                    string = [NSString stringWithFormat:@"%@:%@",
                              [NSString stringWithFormat:@"%@%d",(hour < 10?@"0":@""),hour],
                              [NSString stringWithFormat:@"%@%d",(min < 10?@"0":@""),min]];
                    break;
                case 4:
                    string = [NSString stringWithFormat:@"%@",
                              [NSString stringWithFormat:@"%@%d",(hour < 10?@"0":@""),hour]];
                    break;
                    
                default:
                    break;
            }
            
            return string;
        }
        else {
            return @"";
        }
}

+ (NSString *)timeSignWithSecond:(NSInteger)second {
    if (second > 0) {
        NSString *hour_total = @"";
        if (second/3600 > 0) {
            hour_total = [NSString stringWithFormat:@"%ld′",second/3600];
            second = second % 3600;
        }
        
        NSString *minut_total = @"";
        if (second/60 > 0)
            minut_total = [NSString stringWithFormat:@"%ld′",second/60];
        
        NSString *seconde_total = @"";
        if (second%60 > 0)
            seconde_total = [NSString stringWithFormat:@"%ld″",second%60];
        
        return [NSString stringWithFormat:@"%@%@%@",hour_total,minut_total,seconde_total];
    }
    else {
        return @"";
    }
}

/*
#pragma mark  -  音频
+ (NSString *)convertVoiceToMp3WithURL:(NSString *)path {
    NSString *mp3FileName = @"Mp3File";
    mp3FileName = [mp3FileName stringByAppendingString:@".mp3"];
    NSString *mp3FilePath = [[NSHomeDirectory() stringByAppendingFormat:@"/Documents/"] stringByAppendingPathComponent:mp3FileName];
    @try {
        int read, write;
        
        FILE *pcm = fopen([path cStringUsingEncoding:1], "rb");  //source
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, (unsigned long)2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"ConvertToMp3___%@",[exception description]);
    }
    @finally {
        return mp3FilePath;
    }
}*/

#pragma mark  -  图片
+ (void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"文件后缀不认识");
    }
}

+ (UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    return result;
}

#pragma mark  -  视图
+ (void)addLab:(UILabel *)lab toView:(UIView *)superView withArray:(NSArray *)array {
    __block CGFloat edgeY = 2;
    __block CGFloat edgeX = 5;
    __block CGFloat height = 8;
    __block CGFloat gapY = 5;
    __block CGFloat gapX = 5;
    __block CGFloat x = 0;
    __block CGFloat remainX = superView.bounds.size.width;
    __block CGFloat labHeight = 15;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSString *str = (NSString *)obj;

        CGSize str_size = [str sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(superView.bounds.size.width, CGFLOAT_MAX)];
        if (remainX <= str_size.width + gapX * 2) {
            x = 0;
            remainX = superView.bounds.size.width;
            height = height + labHeight + gapY + edgeY * 2;
        }
        // 背景                                                                                                                                                                    
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x, height, str_size.width + edgeX * 2, labHeight + edgeY * 2)];
        view.backgroundColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00];
        view.layer.cornerRadius = 5;
        [superView addSubview:view];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(x, height, str_size.width + edgeX * 2, labHeight + edgeY * 2)];
        lab.text = str;
        lab.layer.cornerRadius = 10;
        lab.userInteractionEnabled = YES;
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:12];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor clearColor];
        [superView addSubview:lab];
        x = x + lab.bounds.size.width + edgeX * 2;
        x = x + gapX;
        remainX = remainX - 16 - lab.bounds.size.width - gapX;
        
        if (array.count - 1 == idx) {
            superView.frame = CGRectMake(superView.frame.origin.x, superView.frame.origin.y, superView.frame.size.width, height + lab.bounds.size.height + 8);
            [superView sizeToFit];
        }
    }];
}

#pragma mark  -  其他

+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
