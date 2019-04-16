//
//  ViewController.h
//  Example0
//
//  Created by lmg on 2018/9/10.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/*
 视图渲染
 1.CoreAnimation提交回话，包括自己和字视图的layout状态等。
 2.RenderServer解析提交的子树状态，生成绘制指令。
 3.GPU执行绘制指令。
 4.显示渲染后的数据。
 
 
 */


@end
/*
 客户端架构要考虑的事情
 
 
 调用网路API：
 1.如何安全的调用网路API
 2.尽可能保证用户在各种网络环境下都能有良好的体验
 
 页面展示
 1.页面如何组织，才能尽可能降低业务方代码的耦合度
 2.尽可能降低业务方开发界面的复杂度，提高他们的效率
 
 数据的本地持久化
 1.当数据有在本地存取的需求的时候，如何能够保证数据在本地的合理安排
 2.如何尽可能的减小性能损耗
 
 动态部署方案
 1.ios应用有审核周期，如何能够通过不发版本的方式展示新的内容给用户
 2.如何修复紧急bug
 
 */
/*
 架构设计的方法
 第一步:搞清楚要解决哪些问题，并找到解决这些问题的充要条件
 第二步:问题分类，分模块
 第三步:搞清楚各问题之间的依赖关系，建立好模块交流规范并设计模块
 第四步:推演预测一下未来可能的走向，必要时添加新的模块，记录更多的基础数据以备未来之需
 第五步:先解决依赖关系中最基础的问题，实现基础模块，然后再用基础模块堆叠出整个架构
 第六步:打点，跑单元测试，跑性能测试，根据数据去优化对应的地方
 
 遵循的原则：
 1.自顶向下设计（1，2，3，4）
 2.自底向上实现（5）
 3.先测量，后优化（6）
 
 */

/*
 架构对代码要求
 1.代码整齐，分类明确，没有common，没有core
 2.不用文档，或很少文档，就能让业务方入手
 3.思路和方法要统一，尽量不要多元
 4.没有横向依赖，不到万不得已不要跨层访问
 5.对业务方该有限制的地方要限制，改灵活的地方要给业务方创造灵活实现的条件
 6.易测试，易拓展
 7.保持一定量的超前性
 8.接口少，接口参数少
 9.高性能
 */


/*
架构分层：
 三层：展现层，业务层，数据层
 四层：展现层，业务层，网络层，本地数据层
 
 
 适配器模式，单利模式，观察者模式，委托模式，策略模式，工厂模式，MVC设计模式
 */


typedef NS_ENUM(NSUInteger,UserSex) {
    UserSexMan,
    UserSexWoman
};

@interface UserModel : NSObject
@property(nonatomic,weak) NSString *name;
@property(nonatomic,assign) NSUInteger age;
@property(nonatomic,assign) UserSex  sex;

- (instancetype)initModelWithUserName:(NSString *)name WithAge:(NSUInteger)age NS_DESIGNATED_INITIALIZER;
+ (instancetype)userModelWithUserName:(NSString *)name WithAge:(NSUInteger)age;

+ (void)logIn;
@end
