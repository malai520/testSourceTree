//
//  BaseRequestOperator.m
//  wook
//
//  Created by guojiang on 11/8/14.
//  Copyright (c) 2014年 guojiang. All rights reserved.
//

#import "BaseRequestOperator.h"
#import "AFHTTPRequestOperation.h"

@interface BaseRequestOperator ()

@property (nonatomic, copy) requestCompletionSuccessHandler successHandler;
@property (nonatomic, copy) requestCompletionFailureHandler failureHandler;
@property (nonatomic, copy) requestCompletionHandler completionHandler;

@end

@implementation BaseRequestOperator


#pragma mark -  请求

-(void)requestGetWithURL:(NSString *)url
                  params:(NSDictionary *)params
                 success:(requestCompletionSuccessHandler)success
                 failure:(requestCompletionFailureHandler)failure
{
    [self requestWithMethod:@"GET" URL:url params:params success:success failure:failure];
}

-(void)requestPostWithURL:(NSString *)url
                   params:(NSDictionary *)params
                  success:(requestCompletionSuccessHandler)success
                  failure:(requestCompletionFailureHandler)failure
{
    [self requestWithMethod:@"POST" URL:url params:params success:success failure:failure];
}

-(void)requestWithMethod:(NSString *)method
                     URL:(NSString *)url
                  params:(NSDictionary *)params
                 success:(requestCompletionSuccessHandler)success
                 failure:(requestCompletionFailureHandler)failure
{
    
    self.successHandler = success;
    self.failureHandler = failure;
    
    
    [self cancelAllRequest];
    
    self.afRequest = [self getRequestWithMethod:method url:url params:params success:success failure:failure];
    
    [self.afRequest start];
}

-(void)uploadImageWithURL:(NSString *)url
                   params:(NSDictionary *)params
                 fileData:(NSData *)fileData
                  fileKey:(NSString *)fileKey
                  success:(requestCompletionSuccessHandler)success
                  failure:(requestCompletionFailureHandler)failure
{
    [self uploadImageWithURL:url params:params fileData:fileData fileKey:fileKey progress:nil success:success failure:failure];
}

-(void)uploadImageWithURL:(NSString *)url
                   params:(NSDictionary *)params
                 fileData:(NSData *)fileData
                  fileKey:(NSString *)fileKey
                 progress:(uploadProgress)progress
                  success:(requestCompletionSuccessHandler)success
                  failure:(requestCompletionFailureHandler)failure
{
    self.successHandler = success;
    self.failureHandler = failure;
    
    [self cancelAllRequest];
    
    void(^bodyWithBlock)(id<AFMultipartFormData> formData)= ^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileData:fileData
                                    name:fileKey
                                fileName:@""
                                mimeType:@"image/png"];
    };

    AFHTTPRequestSerializer <AFURLRequestSerialization> * requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST"
                                            URLString:[[NSURL URLWithString:url] absoluteString]
                                           parameters:params
                            constructingBodyWithBlock:bodyWithBlock
                                                error:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableSet *set = [[NSMutableSet alloc] initWithSet:operation.responseSerializer.acceptableContentTypes];
    [set addObject:@"application/x-javascript"];
    operation.responseSerializer.acceptableContentTypes = set;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(YES, responseObject);
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
    
    if (progress) {
        [operation setUploadProgressBlock:progress];
    }
    
    self.afRequest = operation;
    
    [self.afRequest start];
}

#pragma mark - 返回队列请求对象(主要用于多任务请求)

-(RequestManager *)getOperationGetWithUrl:(NSString *)url
                                   params:(NSDictionary *)params
                                  success:(requestCompletionSuccessHandler)success
                                  failure:(requestCompletionFailureHandler)failure
{
    AFHTTPRequestOperation *operation = [self getRequestWithGETByURL:url
                                                               params:params
                                                              success:success
                                                              failure:failure];
    RequestManager *request = [[RequestManager alloc] init];
    request.operation = operation;
    
    return request;
}

-(RequestManager *)getOperationPostWithUrl:(NSString *)url
                                    params:(NSDictionary *)params
                                   success:(requestCompletionSuccessHandler)success
                                   failure:(requestCompletionFailureHandler)failure
{
    AFHTTPRequestOperation *operation = [self getRequestWithGETByURL:url
                                                              params:params
                                                             success:success
                                                             failure:failure];
    RequestManager *request = [[RequestManager alloc] init];
    request.operation = operation;
    
    return request;
}

-(AFHTTPRequestOperation *)getRequestWithGETByURL:(NSString *)url
                                           params:(NSDictionary *)params
                                          success:(requestCompletionSuccessHandler)success
                                          failure:(requestCompletionFailureHandler)failure
{
    return [self getRequestWithMethod:@"GET" url:url params:params success:success failure:failure];
}

-(AFHTTPRequestOperation *)getRequestWithPOSTByURL:(NSString *)url
                                            params:(NSDictionary *)params
                                           success:(requestCompletionSuccessHandler)success
                                           failure:(requestCompletionFailureHandler)failure
{
    return [self getRequestWithMethod:@"POST" url:url params:params success:success failure:failure];
}


-(AFHTTPRequestOperation *)getRequestWithMethod:(NSString *)method
                                            url:(NSString *)url
                                         params:(NSDictionary *)params
                                        success:(requestCompletionSuccessHandler)success
                                        failure:(requestCompletionFailureHandler)failure
{
    
    AFHTTPRequestSerializer <AFURLRequestSerialization> * requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:method
                                                              URLString:[[NSURL URLWithString:url] absoluteString]
                                                             parameters:params
                                                                  error:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableSet *set = [[NSMutableSet alloc] initWithSet:operation.responseSerializer.acceptableContentTypes];
    [set addObject:@"application/json"];
    [set addObject:@"text/json"];
    [set addObject:@"text/javascript"];
    [set addObject:@"text/html"];
    [set addObject:@"text/css"];
    operation.responseSerializer.acceptableContentTypes = set;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //此处做返回判断YES、NO
         //if([[responseObject objectForKey:@"code"] isEqualToString:@"200"])
         success(YES, responseObject);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
    
    return operation;
}

#pragma mark - HTTP 队列请求

-(void)requestGroupWithManagers:(NSArray *)managers
                     completion:(requestCompletionHandler)completion
{
    NSMutableArray *operations = [NSMutableArray array];
    for (RequestManager *manager in managers) {
        [operations addObject:manager.operation];
    }
    
    self.completionHandler = completion;
    NSArray *operationsArr = [AFURLConnectionOperation batchOfRequestOperations:operations
                                                               progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
                                                               } completionBlock:^(NSArray *operations) {
                                                                   self.completionHandler();
                                                               }];
    [[NSOperationQueue mainQueue] addOperations:operationsArr waitUntilFinished:NO];
}


- (void)cancelAllRequest
{
    if (_afRequest)
    {
        [_afRequest cancel];
        _afRequest = nil;
    }else{}
}


-(void)dealloc
{
    [self cancelAllRequest];
}

@end
