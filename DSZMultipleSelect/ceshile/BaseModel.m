//
//  BaseModel.m
//  ceshile
//
//  Created by zhilvmac on 2017/9/11.
//  Copyright © 2017年 zjwist. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (instancetype)init{
    if (self = [super init]) {
        self.named = [NSString stringWithFormat:@"named:%u",arc4random()%500];
        self.keyd = [NSString stringWithFormat:@"key:%u",arc4random()%500];
        
        
        
    }
    return self;
}



@end
