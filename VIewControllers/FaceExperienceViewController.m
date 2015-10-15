//
//  FaceExperienceViewController.m
//  haitou
//
//  Created by apple on 15/10/12.
//  Copyright © 2015年 divein. All rights reserved.
//

#import "FaceExperienceViewController.h"
#import "FaceTableViewCell.h"

@interface FaceExperienceViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FaceExperienceViewController
{
    NSMutableArray *_arrayOfTextView;
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
    UITableView *faceTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:faceTableView];

    faceTableView.dataSource = self;
    faceTableView.delegate = self;
    [faceTableView registerClass:[FaceTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark UITableViewDataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
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
    NSURL *url = [NSURL URLWithString:@"http://mobile.haitou.cc/mjfx?type=0&page=1&auth=ODAS-JgCGzGQCXEYTvjO7vIm79ZyAofFwuT54PcXpyY.&ver=1.0&token=a1e194829c"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dic objectForKey:@"info"];
        
        for (NSDictionary *dic1 in array) {
            NSString *str = [dic1 objectForKey:@"infoLite"];
            [_arrayOfTextView addObject:str];
        }
    }];
    
    [task resume];
    
    
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
