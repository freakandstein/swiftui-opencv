//
//  OpenCV.mm
//  ImageTemperature
//
//  Created by Satrio Wicaksono on 28/02/25.
//
#import <opencv2/opencv.hpp>
#import <UIKit/UIKit.h>
#import "OpenCV.h"

using namespace cv;

@implementation OpenCV

// MARK: - Convert UIImage to cv::Mat
cv::Mat UIImageToMat(UIImage *image) {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    const unsigned char* buffer = (const unsigned char*)[imageData bytes];
    std::vector<uchar> vecBuffer(buffer, buffer + imageData.length);
    return imdecode(vecBuffer, IMREAD_COLOR); // Using IMREAD_COLOR to keep image is BGR
}

// MARK: - Convert cv::Mat to UIImage
UIImage *MatToUIImage(cv::Mat mat) {
    NSData *data = [NSData dataWithBytes:mat.data length:mat.total() * mat.elemSize()];
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageRef cgImage = CGImageCreate(mat.cols, mat.rows, 8, 8 * mat.channels(), mat.step[0], colorSpace, kCGImageAlphaNone | kCGBitmapByteOrderDefault, provider, NULL, false, kCGRenderingIntentDefault);
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(provider);
    
    return image;
}

// MARK: - Adjust Temperature
- (UIImage *)setTemperature:(UIImage *)image temperature:(float)value {
    cv::Mat mat = UIImageToMat(image);
    
    std::vector<cv::Mat> channels;
    split(mat, channels);
    
    // Adjust color by increasing/decreasing channel
    channels[2] = channels[2] - value;
    channels[0] = channels[0] + value;
    
    merge(channels, mat);
    
    return MatToUIImage(mat);
}
@end
