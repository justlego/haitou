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
    NSMutableArray *_arrayOfTitle;
    NSMutableArray *_arrayOfYear;
    NSMutableArray *_arrayOfName;
    NSMutableArray *_arrayOfCount;
    NSMutableArray *_arrayOfUp;
    NSMutableArray *_arrayOfImages;
    
    UITableView *_faceTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _arrayOfTextView = [NSMutableArray new];
    _arrayOfTitle = [NSMutableArray new];
    _arrayOfYear = [NSMutableArray new];
    _arrayOfName = [NSMutableArray new];
    _arrayOfCount = [NSMutableArray new];
    _arrayOfUp = [NSMutableArray new];
    _arrayOfImages = [NSMutableArray new];
    
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
    FaceTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (_arrayOfTextView.count) {
        cell.textView.text = _arrayOfTextView[indexPath.row];
        cell.titleLabel.text = _arrayOfTitle[indexPath.row];
        cell.yearLabel.text = _arrayOfYear[indexPath.row];
        cell.companyLabel.text = _arrayOfName[indexPath.row];
        cell.readCountLabel.text = [_arrayOfCount[indexPath.row] stringValue];
        cell.goodCountLabel.text = [_arrayOfUp[indexPath.row] stringValue];
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
            [_arrayOfTextView addObject:[dic1 objectForKey:@"infoLite"]];
            [_arrayOfTitle addObject:[dic1 objectForKey:@"title"]];
            [_arrayOfYear addObject:[dic1 objectForKey:@"year"]];
            [_arrayOfCount addObject:[dic1 objectForKey:@"count"]];
            [_arrayOfUp addObject:[dic1 objectForKey:@"up"]];
            [_arrayOfImages addObject:[dic1 objectForKey:@"image"]];
            
            
            NSArray *arr = [dic1 objectForKey:@"companys"];
            NSDictionary *dic2= [arr lastObject];
            NSString *str = [dic2 objectForKey:@"name"];
            if (str) {
                [_arrayOfName addObject:str];
            }else{
                str = @"无";
                [_arrayOfName addObject:str];
            }
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
