//
//  EOCRetainCount.m
//  Example0
//
//  Created by lmg on 2018/10/18.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCRetainCount.h"

@implementation EOCRetainCount

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSString *string = [NSString stringWithFormat:@"%@",@"some string"];
        NSLog(@"string====%lu",(unsigned long)[string retainCount]);
        //18446744073709551615 = 2^64-1
        
        
        
        NSNumber *numberI = @1;
        NSLog(@"numberI====%lu",(unsigned long)[numberI retainCount]);
        //9223372036854775807 = 2^63-1
        
        
        
        NSNumber *numberF = @(3.14f);
        NSLog(@"numberD====%lu",(unsigned long)[numberF retainCount]);
        //1
        /*
         前两者皆为单例对象，所以其保留计数都很大，如果字符串是个编译器常量,那么系统就会将该字符串设计为单例对象，编译器会把NSString所代表的数据存放在应用程序的二进制文件中，这样的话，程序运行时就可以直接使用了，而无需再创建NSString对象。NSNumber也类似，它使用了一种叫做”标签指针“的概念来标注特定类型的数值，这种做法不使用NSNumber对象，而是把与数值有关的全部消息都放在指针值里面。运行期系统会在消息派发时检测到这种标签指针，并对它执行相关操作，使其看起来和真正的NSNumber一样，这种优化只在某些场合才会使用。单例对象的保留计数绝不会变。这种对象的保留及释放操作都是空操作。
         */
        
        
    }
    return self;
}


@end
