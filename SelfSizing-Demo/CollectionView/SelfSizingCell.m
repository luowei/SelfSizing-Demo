//
//  SelfSizingCell.m
//  SelfSizing-CollectionView
//
//  Created by luowei on 15/9/6.
//  Copyright (c) 2015年 wodedata. All rights reserved.
//

#import "SelfSizingCell.h"

@implementation SelfSizingCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
    }

    return self;
}

////方法一:重写sizeThatFits
//// (注意:在iOS9下如果同时重写 collectionView:layout:sizeForItemAtIndexPath 和以下这个方法,会出现死循环调用)
//- (CGSize)sizeThatFits:(CGSize)size {
//    CGRect textFrame = [_textLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, _textLabel.frame.size.height)
//                                                         options:NSStringDrawingUsesLineFragmentOrigin
//                                                      attributes:@{NSFontAttributeName : _textLabel.font}
//                                                         context:nil];
//    _textLabel.frame = textFrame;
//
//    return textFrame.size;
//}


//方法二:重写 preferredLayoutAttributesFittingAttributes
// (注意:在iOS9下如果同时重写 collectionView:layout:sizeForItemAtIndexPath 和以下这个方法,会出现死循环调用)
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];

    if (_textLabel && _textLabel.font){
        NSString *text = _textLabel.text;
//        CGRect textFrame = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, _textLabel.frame.size.height)
//                                                         options:NSStringDrawingUsesLineFragmentOrigin
//                                                      attributes:@{NSFontAttributeName : _textLabel.font}
//                                                         context:nil];

        CGRect textFrame;
        NSDictionary *attrs = @{NSFontAttributeName: _textLabel.font};

        textFrame.size = [text sizeWithAttributes:attrs];

        attributes.frame = _textLabel.frame = textFrame;
    }
    return attributes;
}


@end
