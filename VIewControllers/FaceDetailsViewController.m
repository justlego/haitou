//
//  FaceDetailsViewController.m
//  haitou
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 divein. All rights reserved.
//

#import "FaceDetailsViewController.h"
#import "FirstSectionCell.h"
#import "SecondSectionCell.h"

#import "AFNetworking.h"

@interface FaceDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FaceDetailsViewController{
    UITableView *_detailsTableView;
    
    NSString *_positionName;
    NSString *_companyName;
    NSString *_yearNumber;
    NSString *_goodCount;
    NSString *_imgView;
    NSString *_readCount;
    NSString *_titleStr;
    NSString *_contentStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    

    [self load];


}

- (void)addTableView{
    _detailsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _detailsTableView.delegate = self;
    _detailsTableView.dataSource = self;
    [_detailsTableView registerClass:[FirstSectionCell class] forCellReuseIdentifier:@"firstCell"];
    [_detailsTableView registerClass:[SecondSectionCell class] forCellReuseIdentifier:@"secondCell"];
    
    [self.view addSubview:_detailsTableView];
}


#pragma mark UITableViewDataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 5;
    }else{
        return 0;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
//        FirstSectionCell *firstCell = [_detailsTableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
//        firstCell.contentLabel.text = _contentStr;
//        firstCell.contentLabel.numberOfLines = 0;
//        return firstCell;
        
        UITableViewCell *firstCell = [_detailsTableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        firstCell.textLabel.text = _contentStr;
        firstCell.textLabel.numberOfLines = 0;
        return firstCell;
    }else{
        SecondSectionCell *secondCell = [_detailsTableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
        return secondCell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark first section
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:self.view.bounds];
        headView.backgroundColor = [UIColor whiteColor];
        CGSize size = headView.bounds.size;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRect){10,10,size.width-20,20}];
        titleLabel.text = _titleStr;
        [headView addSubview:titleLabel];
        
        UILabel *readLabel = [[UILabel alloc] initWithFrame:(CGRect){10,30,20,20}];
        readLabel.text = @"阅读";
        readLabel.textAlignment = NSTextAlignmentCenter;
        readLabel.font = [UIFont systemFontOfSize:10];
        readLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [headView addSubview:readLabel];

        UILabel *readCountLabel = [[UILabel alloc] initWithFrame:(CGRect){30,30,20,20}];
        readCountLabel.text = _readCount;
        readCountLabel.font = [UIFont systemFontOfSize:10];
        readCountLabel.textAlignment = NSTextAlignmentCenter;
        readCountLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [headView addSubview:readCountLabel];
        
        UILabel *goodLabel = [[UILabel alloc] initWithFrame:(CGRect){50,30,20,20}];
        goodLabel.text = @"赞";
        goodLabel.textAlignment = NSTextAlignmentCenter;
        goodLabel.font = [UIFont systemFontOfSize:10];
        goodLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [headView addSubview:goodLabel];
        
        UILabel *goodCountLabel = [[UILabel alloc] initWithFrame:(CGRect){70,30,20,20}];
        goodCountLabel.text = _goodCount;
        goodCountLabel.font = [UIFont systemFontOfSize:10];
        goodCountLabel.textAlignment = NSTextAlignmentCenter;
        goodCountLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [headView addSubview:goodCountLabel];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:(CGRect){10,50,size.width-20,150}];
        imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgView]]];
        [headView addSubview:imgView];
        
        UILabel *yearLabel = [[UILabel alloc] initWithFrame:(CGRect){10,200,30,20}];
        yearLabel.text = @"年份 :";
        yearLabel.font = [UIFont systemFontOfSize:10];
        yearLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [headView addSubview:yearLabel];
        
        UILabel *yearNumber = [[UILabel alloc] initWithFrame:(CGRect){40,200,size.width-50,20}];
        yearNumber.text = _yearNumber;
        yearNumber.font = [UIFont systemFontOfSize:10];
        yearNumber.textColor = [UIColor blueColor];
        [headView addSubview:yearNumber];
        
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:(CGRect){10,220,30,20}];
        companyLabel.text = @"公司 :";
        companyLabel.font = [UIFont systemFontOfSize:10];
        companyLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [headView addSubview:companyLabel];
        
        UILabel *companyName = [[UILabel alloc] initWithFrame:(CGRect){40,220,size.width-50,20}];
        companyName.text = _companyName;
        companyName.font = [UIFont systemFontOfSize:10];
        companyName.textColor = [UIColor blueColor];
        [headView addSubview:companyName];
        
        UILabel *positionLabel = [[UILabel alloc] initWithFrame:(CGRect){10,240,30,20}];
        positionLabel.text = @"职位 :";
        positionLabel.font = [UIFont systemFontOfSize:10];
        positionLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [headView addSubview:positionLabel];
        
        UILabel *positionName = [[UILabel alloc] initWithFrame:(CGRect){40,240,size.width-50,20}];
        positionName.text = _positionName;
        positionName.font = [UIFont systemFontOfSize:10];
        positionName.textColor = [UIColor blueColor];
        [headView addSubview:positionName];
        
        return headView;
    }else{
        return nil;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *footView = [[UIView alloc] initWithFrame:self.view.bounds];
        footView.backgroundColor = [UIColor whiteColor];
        CGSize size = footView.bounds.size;
        
        UIButton *goodButton = [UIButton buttonWithType:UIButtonTypeSystem];
        goodButton.frame = (CGRect){size.width/2-50,10,40,20};
        goodButton.backgroundColor = [UIColor orangeColor];
        [goodButton addTarget:self action:@selector(didGoodButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:goodButton];
        
        UIButton *badButton = [UIButton buttonWithType:UIButtonTypeSystem];
        badButton.frame = (CGRect){size.width/2+10,10,40,20};
        badButton.backgroundColor = [UIColor grayColor];
        [badButton addTarget:self action:@selector(didBadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:badButton];
        
        return footView;
    }else{
        return nil;
    }
}

- (void)didGoodButtonClicked{
    
}

- (void)didBadButtonClicked{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGRect rect = [_contentStr boundingRectWithSize:self.view.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
        return rect.size.height;
    }else{
        return 40;
    }
 }


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 260;
    }else{
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }else{
        return 0;
    }
}


#pragma mark 网络请求
- (void)load{
    NSString *url = [NSString stringWithFormat:@"http://mobile.haitou.cc/mjfx/%@?auth=ODAS-JgCGzGQCXEYTvjO7vIm79ZyAofFwuT54PcXpyY.&ver=1.0&token=ade431b0ff",_stringOfID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dictionary = @{@"foo":@"bar"};
    [manager GET:url parameters:dictionary success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * dic) {
        NSLog(@"dic:%@",dic);
        NSDictionary *dicOfData = [dic objectForKey:@"info"];
        _titleStr = [dicOfData objectForKey:@"title"];
        _readCount = [[dicOfData objectForKey:@"count"] stringValue];
        _goodCount = [[dicOfData objectForKey:@"up"] stringValue];
        _yearNumber = [dicOfData objectForKey:@"year"];
        _imgView = [dicOfData objectForKey:@"image"];
        _contentStr = [dicOfData objectForKey:@"encodeInfo"];
        
        NSArray *arr = [dicOfData objectForKey:@"companys"];
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
        _companyName = name;
        
        NSArray *arrOfPosition = [dicOfData objectForKey:@"workCategorys"];
        NSString *nameOfPosition = @"";
        if (arrOfPosition.count == 0){
            nameOfPosition = @"无";
        }else if (arrOfPosition.count == 1){
            NSDictionary *dicOfName = [arr firstObject];
            nameOfPosition = [dicOfName objectForKey:@"name"];
        }else{
            NSMutableArray *arrOfNames = [NSMutableArray new];
            for (NSDictionary *dicOfName in arrOfPosition) {
                NSString *str = [NSString stringWithFormat:[dicOfName objectForKey:@"name"],@"  "];
                [arrOfNames addObject:str];
            }
            nameOfPosition = [arrOfNames componentsJoinedByString:@" "];
        }
        _positionName = nameOfPosition;

        [_detailsTableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"err:%@",error);
    }];
    [self addTableView];

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
