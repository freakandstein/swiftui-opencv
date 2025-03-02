//
//  OpenCV.h
//  ImageTemperature
//
//  Created by Satrio Wicaksono on 28/02/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCV : NSObject
    - (UIImage *)setTemperature:(UIImage *)image temperature:(float)value;
@end

NS_ASSUME_NONNULL_END
