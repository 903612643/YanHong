//
//  DownloadOperation.m
//  YanHong
//
//  Created by anbaoxing on 16/3/25.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "DownloadOperation.h"

@implementation DownloadOperation

- (void)main {
    
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    if ([_delegate respondsToSelector:@selector(downloadOperation:didFinishedDownload:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate downloadOperation:self didFinishedDownload:image];
        });
    }
}

@end
