//
//  UIImage+GIF.h
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/**
 * get image form URL
 *  @param URL url
 *
 *  @return UIImage
 */
+ (UIImage*)imageWithUrl:(NSString*)URL;

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;

+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  @param imageSize Image Size
 *
 *  @return ImageHeight
 */
+ (CGFloat)imageHeightWithSizeString:(NSString *)imageSize;

@end
