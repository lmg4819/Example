//
//  EOCSoundPlayer.m
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCSoundPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

void EOCSoundPlayerCompletion(SystemSoundID ssID,void *clientData)
{
    EOCSoundPlayer *player = (__bridge EOCSoundPlayer*)clientData;
    if ([player.delegate respondsToSelector:@selector(soundPlayerDidFinish:)]) {
        [player.delegate soundPlayerDidFinish:player];
    }
}


@implementation EOCSoundPlayer
{
    SystemSoundID _systemSoundID;
}

-(id)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &_systemSoundID);
    }
    return self;
}

-(void)dealloc
{
    AudioServicesDisposeSystemSoundID(_systemSoundID);
}

-(void)playSound
{
    AudioServicesAddSystemSoundCompletion(_systemSoundID, NULL, NULL, EOCSoundPlayerCompletion, (__bridge void*)self);
    AudioServicesPlaySystemSound(_systemSoundID);
}

@end
