//
//  ViewController.m
//  ZPKits
//
//  Created by 赵鹏 on 2017/12/13.
//  Copyright © 2017年 赵鹏. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+SEL.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self performSelector:@selector(add:b:) withArguments:@[@"1234",@"456"]];

    // Do any additional setup after loading the view, typically from a nib.
}


-(NSString *)add:(NSString *)a b:(NSString *)b{
    NSLog(@"%@   %@",a,b);
    return a;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
