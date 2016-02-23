//
// Created by luowei on 15/9/6.
// Copyright (c) 2015 wodedata. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "SelfSizingCell.h"


@interface MyCollectionViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout/*UICollectionViewDelegate*/>

@property(strong, nonatomic) UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *strings;

@end

@implementation MyCollectionViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _strings = [@"The UICollectionViewFlowLayout class is a concrete layout object that organizes items into a grid with optional header and footer views for each section. The items in the collection view flow from one row or column (depending on the scrolling direction) to the next, with each row comprising as many cells as will fit. Cells can be the same sizes or different sizes." componentsSeparatedByString:@" "];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.estimatedItemSize = CGSizeMake(20, 20);

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectInset(self.view.frame, 0, 0)
                                         collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    [_collectionView registerClass:[SelfSizingCell class] forCellWithReuseIdentifier:@"Cell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ------- UICollectionViewDataSource Implementation -------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _strings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelfSizingCell *cell = (SelfSizingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
//    cell.textLabel.backgroundColor = [UIColor greenColor];
    cell.textLabel.text = _strings[(NSUInteger) indexPath.item];
    return cell;
}

#pragma mark ------- UICollectionViewDelegateFlowLayout Implementation -------

////定义每个UICollectionView cell的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
////    return CGSizeMake(fDeviceWidth, fDeviceHeight);
//    return CGSizeMake(self.collectionView.frame.size.width/4, self.collectionView.frame.size.height/8);
//}

@end