//
// Created by luowei on 15/9/16.
// Copyright (c) 2015 wodedata. All rights reserved.
//

#import "MyScrollViewController.h"
#import "PureLayout.h"

@interface MyScrollViewController () {

}

@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) UIView *contentView;

@property(strong, nonatomic) NSLayoutConstraint *contentWidthConstraint;
@property(assign, nonatomic) int pageBeforeRotation;
@property(assign, nonatomic) int totalPages;

@end

@implementation MyScrollViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.view.frame,0,40)];
//    self.scrollView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:self.scrollView];
//
//    self.contentView = [[UIView alloc] initWithFrame:CGRectInset(self.scrollView.frame,100,200)];
//    self.contentView.backgroundColor = [UIColor greenColor];
//    [self.scrollView addSubview:self.contentView];
//
//    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.width + 500);

    int pages = arc4random() % 10 + 10;

    self.scrollView = [UIScrollView newAutoLayoutView];
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];

    [self.scrollView autoPinToTopLayoutGuideOfViewController:self withInset:0];
    [self.scrollView autoPinToBottomLayoutGuideOfViewController:self withInset:0];
    [self.scrollView autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.scrollView autoPinEdgeToSuperviewMargin:ALEdgeRight];

    self.contentView = [UIView newAutoLayoutView];
    [self.view addSubview:self.contentView];

    [self.contentView autoPinEdgeToSuperviewMargin:ALEdgeTop];
    [self.contentView autoPinEdgeToSuperviewMargin:ALEdgeBottom];
//    [self.contentView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    self.contentWidthConstraint = [self.contentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView withMultiplier:pages];

    [self setupPages:pages];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    int page = (int) roundf(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    page = MIN(MAX(page, 0), self.totalPages);
    self.pageBeforeRotation = page;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * self.pageBeforeRotation, 0.0);
}


- (void)setupPages:(int)pages {
    self.totalPages = pages;

    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.alpha = 0.0;
    }                completion:^(BOOL finished) {

        NSArray *subviews = self.contentView.subviews;
        for (UIView *view in subviews) {
            [view removeFromSuperview];
        }
        [self.contentWidthConstraint autoRemove];
        self.contentWidthConstraint = [self.contentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView withMultiplier:pages];

        UILabel *prevLabel = nil;
        for (int i = 0; i < pages; ++i) {
            UILabel *pageLabel = [[UILabel alloc] initWithFrame:self.scrollView.bounds];
            pageLabel.text = [NSString stringWithFormat:@"Page %d of %d", i + 1, pages];
            pageLabel.font = [UIFont fontWithName:@"Georgia-Italic" size:18.0];
            pageLabel.textAlignment = NSTextAlignmentCenter;

            [self.contentView addSubview:pageLabel];

            [pageLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView];
            [pageLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [pageLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];

            if (!prevLabel) {
                // Align to contentView
                [pageLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
            } else {
                // Align to prev label
                [pageLabel autoConstrainAttribute:ALAttributeLeading toAttribute:ALAttributeTrailing ofView:prevLabel];
            }

            if (i == pages - 1) {
                // Last page
                [pageLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
            }

            prevLabel = pageLabel;
        }

        self.scrollView.contentOffset = CGPointZero;

        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];

        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.alpha = 1.0;
        }];
    }];
}

@end