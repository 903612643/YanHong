//
//  DownloadOperation.h
//  YanHong
//
//  Created by anbaoxing on 16/3/25.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class DownloadOperation;
@protocol DownloadOperationDelegate <NSObject>

- (void)downloadOperation:(DownloadOperation *)operation didFinishedDownload:(UIImage *)image;

@end

@interface DownloadOperation : NSOperation

@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) id<DownloadOperationDelegate> delegate;

@end
