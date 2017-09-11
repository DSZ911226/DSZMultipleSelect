//
//  CommonMultipleSelectViewController.h
//  ls
//
//  Created by Alonezzz on 2017/6/25.
//  Copyright © 2017年 浙江智旅信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectModel : NSObject
@property(nonatomic,copy)NSString * _Nullable name;
@property(nonatomic,copy)NSString * _Nullable ID;
@property(nonatomic,assign)BOOL isSelected;
+ (SelectModel *_Nullable)initWithname:(NSString *_Nullable)name ID:(NSString *_Nullable)ID isSelected:(BOOL)isSelected;
@end


/**
 选择的返回的结果集合

 @param result 返回的选择的结果集合
 */
typedef void (^SelectResult)(NSArray * _Nullable result);
@interface DSZMultipleSelectViewController : UIViewController
@property (nonatomic, strong)UITableView * _Nullable tableView;
@property(nonatomic,strong)NSMutableArray * _Nullable dataSource;//存放的模型
@property(nonatomic,strong)NSMutableArray * _Nullable currentSelecteds;//存放的的keys
@property(nonatomic,copy)SelectResult _Nullable result; //返回的结果




/**
 单选

 @param key 唯一的key model的关键字
 @param nameKey 名称所对应的model 的key
 @return 对象
 */
- (instancetype _Nullable)initWithNameKey:( NSString * _Nullable )key nameKey:(NSString * _Nullable)nameKey;

/**
 多选

 @param key  唯一的key model的关键字
 @param nameKey 名称所对应的model 的key
 @param maxSelectedNum 最多选的个数
 @param minSelectedNum 最少允许选的个数
 @return 对象
 */
- (instancetype _Nullable )initWithNameKey:( NSString * _Nullable )key nameKey:(NSString * _Nonnull)nameKey maxSelectedNum:(NSInteger)maxSelectedNum minSelectedNum:(NSInteger)minSelectedNum;

@end


