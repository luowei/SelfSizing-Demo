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
//- (CGSize)sizeThatFits:(CGSize)size {
//    CGRect textFrame = [_textLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, _textLabel.frame.size.height)
//                                                         options:NSStringDrawingUsesLineFragmentOrigin
//                                                      attributes:@{NSFontAttributeName : _textLabel.font}
//                                                         context:nil];
//    _textLabel.frame = textFrame;
//
//    return textFrame.size;
//}


//方法二:重写 preferredLayoutAttributesFittingAttributes (iOS9下会出现，死循环调用)
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];

    if (_textLabel){
        CGRect textFrame = [_textLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, _textLabel.frame.size.height)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName : _textLabel.font}
                                                         context:nil];
        attributes.frame = _textLabel.frame = textFrame;
    }
    return attributes;
}


@end
