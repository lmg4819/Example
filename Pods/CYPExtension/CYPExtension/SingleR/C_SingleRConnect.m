//
//  C_SingleRConnect.m
//  CarEasyBuy
//
//  Created by majinglong on 17/3/29.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import "C_SingleRConnect.h"
#import "SRHubConnection.h"
#import "SRHubProxy.h"


@interface C_SingleRConnect ()


@property (strong, nonatomic, readwrite) SRHubConnection *hubconnection;
@property (strong, nonatomic, readwrite) SRHubProxy *hub;

@end

@implementation C_SingleRConnect


- (void)connectSocketWithUrl:(NSString *)url hubProxy:(NSString *)hubProxy
{

    if ([url isKindOfClass:[NSNull class]] || !url || (![url hasPrefix:@"http://"]&&![url hasPrefix:@"https://"])) {
        if ([_delegate respondsToSelector:@selector(singleRUrlError:)]) {
            [_delegate singleRUrlError:url];
        }
        return;
    }
    self.url = url;
    __block typeof(self) blockSelf = self;
    
    if (_hubconnection && _hubconnection.state != disconnected) {
        return;
    }
    
    _hubconnection = [SRHubConnection connectionWithURL:_url];
    _hub = [_hubconnection createHubProxy:hubProxy];
    _hubconnection.started = ^{
        if ([blockSelf.delegate respondsToSelector:@selector(singleRStartConnect)]) {
            [blockSelf.delegate singleRStartConnect];
        }
    };
    
    _hubconnection.received = ^(NSDictionary * data){
        if ([blockSelf.delegate respondsToSelector:@selector(singleRConnectReceiveData:dataType:)]) {
            NSString * dataType_M = data[@"M"];
            id dataModel = data[@"A"];
            [blockSelf.delegate singleRConnectReceiveData:dataModel dataType:dataType_M];
        }
    };
    
    _hubconnection.closed = ^{
        if ([blockSelf.delegate respondsToSelector:@selector(singleRConnectClose)]) {
            [blockSelf.delegate singleRConnectClose];
        }
    };
    _hubconnection.error = ^(NSError *error){
        [blockSelf closeConnect];
        if ([blockSelf.delegate respondsToSelector:@selector(singleRConnectError:)]) {
            [blockSelf.delegate singleRConnectError:error.description];
        }
    };
    
    _hubconnection.stateChanged = ^(connectionState state) {
        
    };
    
    _hubconnection.connectionSlow = ^{
        
    };
    
    [_hubconnection start];

}

-(NSString*)getConnectionId{
    return self.hubconnection.connectionId;
}

- (void)closeConnect {
    [self.hubconnection stop];
}

@end
