//
//  UploadImageAPI.m
//  Example0
//
//  Created by lmg on 2018/9/29.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "UploadImageAPI.h"
#import <AFNetworking/AFURLRequestSerialization.h>

@implementation UploadImageAPI
{
    UIImage *_image;
}

-(id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

-(NSString *)requestUrl
{
    return @"/iphone/image/upload";
}

-(id)jsonValidator
{
    return @{
             @"imageId":[NSString class]
             };
}

-(AFConstructingBlock)constructingBodyBlock
{
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
        NSString *name = @"image";
        NSString *formKey = @"image";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

-(NSString *)responseImageId
{
    NSDictionary *dict = self.responseJSONObject;
    return dict[@"imageId"];
}

@end
