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
#import "SSARefreshControl.h"

@interface FaceExperienceViewController ()<UITableViewDataSource,UITableViewDelegate,SSARefreshControlDelegate>
@property (nonatomic,strong)SSARefreshControl *refreshControl;

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
    int countI;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    countI = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _arrayOfTextView = [NSMutableArray new];
    _arrayOfTitle = [NSMutableArray new];
    _arrayOfYear = [NSMutableArray new];
    _arrayOfName = [NSMutableArray new];
    _arrayOfCount = [NSMutableArray new];
    _arrayOfUp = [NSMutableArray new];
    _arrayOfImages = [NSMutableArray new];
    
    [self addTableView];
    [self addRefresh];
}

- (void)addTableView
{
    CGRect frame = self.view.bounds;
    frame.origin.y = 64;
    _faceTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    
    [self.view addSubview:_faceTableView];

    _faceTableView.dataSource = self;
    _faceTableView.delegate = self;
    [_faceTableView registerClass:[FaceTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark UITableViewDataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _arrayOfTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FaceTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (_arrayOfTextView.count) {
        cell.contentLabel.text = _arrayOfTextView[indexPath.row];
        cell.titleLabel.text = _arrayOfTitle[indexPath.row];
        cell.yearLabel.text = _arrayOfYear[indexPath.row];
        cell.companyLabel.text = _arrayOfName[indexPath.row];
        cell.readCountLabel.text = [_arrayOfCount[indexPath.row] stringValue];
        cell.goodCountLabel.text = [_arrayOfUp[indexPath.row] stringValue];
        cell.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_arrayOfImages[indexPath.row]]]];
        cell.readImageView.image = [UIImage imageNamed:@"read"];
        cell.goodImageView.image = [UIImage imageNamed:@"good"];
                                
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
    NSString *count = [NSString stringWithFormat:@"%d",countI];
    NSString *url = [NSString stringWithFormat:@"http://mobile.haitou.cc/mjfx?type=0&page=%@&auth=ODAS-JgCGzGQCXEYTvjO7vIm79ZyAofFwuT54PcXpyY.&ver=1.0&token",count];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dic = @{@"foo":@"bar"};
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, NSDictionary *dic) {
        NSArray *arrayOfAllContent = [dic objectForKey:@"info"];
        for (NSDictionary *info in arrayOfAllContent) {
            [_arrayOfTextView addObject:[info objectForKey:@"infoLite"]];
            [_arrayOfTitle addObject:[info objectForKey:@"title"]];
            [_arrayOfYear addObject:[info objectForKey:@"year"]];
            [_arrayOfCount addObject:[info objectForKey:@"count"]];
            [_arrayOfUp addObject:[info objectForKey:@"up"]];
            [_arrayOfImages addObject:[info objectForKey:@"image"]];
            
            NSArray *arr = [info objectForKey:@"companys"];
            NSString *name = @"";
            if (arr.count == 0){
                name = @"无";
            }else if (arr.count == 1){
                NSDictionary *dicOfName = [arr firstObject];
                name = [dicOfName objectForKey:@"name"];
            }else{
                NSMutableArray *arrOfNames = [NSMutableArray new];
                for (NSDictionary *dicOfName in arr) {
                    NSString *str = [NSString stringWithFormat:[dicOfName objectForKey:@"name"],@"  "];
                    [arrOfNames addObject:str];
                }
                name = [arrOfNames componentsJoinedByString:@" "];
            }
            [_arrayOfName addObject:name];
        }
        [_faceTableView reloadData];

    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@",error);
    }];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _arrayOfTitle.count-1) {
        countI += 1;
        [self load];
    }
    
}




#pragma mark SSARefreshControl
- (void)addRefresh{
    self.refreshControl = [[SSARefreshControl alloc] initWithScrollView:_faceTableView andRefreshViewLayerType:SSARefreshViewLayerTypeOnScrollView];
    self.refreshControl.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.refreshControl beginRefreshing];
}

- (void)beganRefreshing{
    [self loadDataSource];
}

- (void)loadDataSource{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        [self load];

        dispatch_async(dispatch_get_main_queue(), ^{
            [_faceTableView reloadData];
            [self.refreshControl endRefreshing];
        });
    });
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
