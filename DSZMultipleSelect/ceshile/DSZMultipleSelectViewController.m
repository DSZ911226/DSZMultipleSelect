//
//  CommonMultipleSelectViewController.m
//  ls
//
//  Created by Alonezzz on 2017/6/25.
//  Copyright © 2017年 浙江智旅信息有限公司. All rights reserved.
//

#import "DSZMultipleSelectViewController.h"

#define CellHeight 44
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

#pragma mark model

@implementation SelectModel
+ (SelectModel *)initWithname:(NSString *)name ID:(NSString *)ID isSelected:(BOOL)isSelected {
    SelectModel *selectM = [SelectModel new];
    selectM.name = name;
    selectM.ID = ID;
    selectM.isSelected = isSelected;
    return selectM;
}
@end


#pragma Mark Cell;
@interface SelectCell : UITableViewCell

/**
 名称
 */
@property (nonatomic,strong)UILabel *name;

/**
 选择的按钮
 */
@property (nonatomic,strong)UIButton *btn;
@end

@implementation SelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //名称
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, KWidth - 68, CellHeight)];
        self.name.font = [UIFont systemFontOfSize:14];
        self.name.textColor = [UIColor blackColor];
        [self addSubview:self.name];
 
    //选择按钮
        self.btn = [[UIButton alloc] initWithFrame:CGRectMake(KWidth - 50, 0, 50, CellHeight)];
        self.btn.userInteractionEnabled = NO;
        [self.btn setImage:[UIImage imageNamed:@"icon_checked"] forState:(UIControlStateSelected)];
        [self addSubview:self.btn];
  
    }
    return self;
}

@end


#pragma mark controller

@interface DSZMultipleSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSString *key;//判断是否相等的key
@property(nonatomic,copy)NSString *namekey;//名称的key
@property(nonatomic,assign)BOOL isMutipleSelect;//是否可以多选 yes是 no 不是


@property(nonatomic,assign)NSInteger maxSelectedNum;//最多要选的数量 默认为100
@property(nonatomic,assign)NSInteger minSelectedNum;//最少要选的数量 默认为0

@end

@implementation DSZMultipleSelectViewController


- (instancetype)initWithNameKey:(NSString *)key nameKey:(NSString *)nameKey{
    if (self = [super init]) {
        self.key = key;
        self.namekey = nameKey;
    }
    return self;
}

- (instancetype _Nullable )initWithNameKey:( NSString * _Nullable )key nameKey:(NSString * _Nonnull)nameKey maxSelectedNum:(NSInteger)maxSelectedNum minSelectedNum:(NSInteger)minSelectedNum {
    if (self = [super init]) {
        self.key = key;
        self.namekey = nameKey;
        self.isMutipleSelect = YES;
        self.minSelectedNum = minSelectedNum;
        self.maxSelectedNum = maxSelectedNum;
        
    }
    return self;
}

//懒加载
- (NSMutableArray *)currentSelecteds {
    if (!_currentSelecteds) {
        _currentSelecteds = [NSMutableArray array];
    }
    return _currentSelecteds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    [self loadData];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}


//加载tableview
- (void)loadTableView {
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
}
- (void)loadData{
    [self.tableView registerClass:[SelectCell class] forCellReuseIdentifier:@"SelectCell"];
    self.tableView.frame = CGRectMake(0, 0, KWidth, KHeight);
    if (self.isMutipleSelect) {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarBtnAction)];
    }
}

//多选的保存
- (void)rightBarBtnAction {
    if (self.result) {
        NSMutableArray *results = [NSMutableArray array];
        for (SelectModel *model in self.dataSource) {
            if ([self.currentSelecteds containsObject:[model valueForKey:self.key]]) {
                [results addObject:model];
            }
        }
        self.result(results);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count>0?1:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCell" forIndexPath:indexPath];
    SelectModel *model =self.dataSource[indexPath.row];
    cell.name.text = [model valueForKey:self.namekey];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.btn.selected = [self.currentSelecteds containsObject:[model valueForKey:self.key]];
       
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectModel *model =self.dataSource[indexPath.row];
    if (self.isMutipleSelect) {
        if ([self.currentSelecteds containsObject:[model valueForKey:self.key]]) {
            if (self.currentSelecteds.count > self.minSelectedNum) {
                [self.currentSelecteds removeObject:[model valueForKey:self.key]];
            }
            
            
        }else{
            if (self.currentSelecteds.count < self.maxSelectedNum) {
            
            [self.currentSelecteds addObject:[model valueForKey:self.key]];
        }
        }
        [self.tableView reloadData];
    }else{
        
        [self.currentSelecteds removeAllObjects];
        [self.currentSelecteds addObject:[model valueForKey:self.key]];
        if (self.result) {
            self.result(@[model]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end


