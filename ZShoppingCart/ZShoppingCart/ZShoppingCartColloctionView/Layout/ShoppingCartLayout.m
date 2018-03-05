//
//  ShoppingCartLayout.m
//  ZShoppingCart
//
//  Created by AlexZhang on 24/11/2017.
//  Copyright © 2017 Jixin. All rights reserved.
//

#import "ShoppingCartLayout.h"

@implementation ShoppingCartLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.commodityLineSpacing = 5.0f;
    self.recommendLineSpacing = 0;
}

- (CGSize)collectionViewContentSize {
    if ([self.dataSource respondsToSelector:@selector(collectionViewContentSize:)]) {
        return [self.dataSource collectionViewContentSize:self];
    }
    return CGSizeZero;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes= [NSMutableArray array];
    for (NSInteger section = 0; section < [self.collectionView numberOfSections]; section++) {
        NSIndexPath *headerIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        [attributes addObject:[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:headerIndexPath]];
        for (NSInteger row = 0; row < [self.collectionView numberOfItemsInSection:section]; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
        if ([self.dataSource respondsToSelector:@selector(shoppingCartLayout:frameForSupplementaryViewOfKind:atIndexPath:)]) {
            attribute.frame = [self.dataSource shoppingCartLayout:self frameForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
        } else {
            attribute.frame = CGRectZero;
        }
    }
    return attribute;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if ([self.dataSource respondsToSelector:@selector(shoppingCartLayout:frameForItemAtIndexPath:)]) {
        attribute.frame = [self.dataSource shoppingCartLayout:self frameForItemAtIndexPath:indexPath];
    }
    return attribute;
}
@end
