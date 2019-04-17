//
//  sumintc_ex1.m
//  Example0
//
//  Created by 罗孟歌 on 2018/11/12.
//  Copyright © 2018 lmg. All rights reserved.
//
#import <Foundation/Foundation.h>

int main(int argc,char *argv[]){
    int i,k;
    NSNumber *sum = nil;
    for (k=0; k<10000; k++) {
        sum = @0;
        for (i=0; i<=1000; i++) {
            sum = @([sum intValue] + i);
        }
    }
    NSLog(@"%@",sum);
    return 0;
}
