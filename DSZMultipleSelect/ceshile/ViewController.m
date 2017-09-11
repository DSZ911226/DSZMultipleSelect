//
//  ViewController.m
//  ceshile
//
//  Created by zhilvmac on 2017/9/8.
//  Copyright © 2017年 zjwist. All rights reserved.
//

#import "ViewController.h"
#import "CeshiView.h"
#import "DSZMultipleSelectViewController.h"
#import "BaseModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
   
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnAction:(id)sender {
    

    
//     CommonMultipleSelectViewController *VC = [[CommonMultipleSelectViewController alloc] initWithNameKey:@"keyd" nameKey:@"named"];
    DSZMultipleSelectViewController *VC = [[DSZMultipleSelectViewController alloc] initWithNameKey:@"keyd" nameKey:@"named" maxSelectedNum:5 minSelectedNum:1];
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0; i < 100; i++) {
        BaseModel *model =  [BaseModel new];
        model.named = [NSString stringWithFormat:@"name:%u",i];
        model.keyd = [NSString stringWithFormat:@"key:%u",i];
        [arr addObject:model];
    }
    [VC.currentSelecteds addObjectsFromArray:@[@"key:1",@"key:3"]];
    VC.dataSource = arr;
    VC.result = ^(NSArray *result) {
        NSLog(@"%@",result);
    };
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
