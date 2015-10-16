//
//  FaceExperienceViewController.m
//  haitou
//
//  Created by apple on 15/10/12.
//  Copyright © 2015年 divein. All rights reserved.
//

#import "FaceExperienceViewController.h"
#import "FaceTableViewCell.h"
#import "AFNetworking.h"

@interface FaceExperienceViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FaceExperienceViewController
{
    NSMutableArray *_arrayOfTextView;
    FaceTableViewCell *cell;
    UITableView *_faceTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _arrayOfTextView = [NSMutableArray new];
    
    [self load];
    [self addTableView];
}

- (void)addTableView
{
    _faceTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_faceTableView];

    _faceTableView.dataSource = self;
    _faceTableView.delegate = self;
    [_faceTableView registerClass:[FaceTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark UITableViewDataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (_arrayOfTextView.count) {
        cell.textView.text = _arrayOfTextView[indexPath.row];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)load
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dic = @{@"foo":@"bar"};
    [manager POST:@"http://mobile.haitou.cc/mjfx?type=0&page=1&auth=ODAS-JgCGzGQCXEYTvjO7vIm79ZyAofFwuT54PcXpyY.&ver=1.0&token=a1e194829c" parameters:dic success:^(AFHTTPRequestOperation *operation, NSDictionary *dic) {
        
        NSLog(@"JSON:%@",dic);
        
        NSArray *arrayOfAllContent = [dic objectForKey:@"info"];
        NSLog(@"array:%@",arrayOfAllContent);
        
        for (NSDictionary *dic1 in arrayOfAllContent) {
            NSString *str = [dic1 objectForKey:@"infoLite"];
            
            [_arrayOfTextView addObject:str];
        }
        [_faceTableView reloadData];

    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@",error);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
