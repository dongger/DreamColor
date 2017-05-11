//
//  CityCollectionCell.m
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CityCollectionCell.h"
#import "CityMarkCell.h"
#import "City.h"

@interface CityCollectionCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray *cities;
@end

@implementation CityCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)loadCities: (NSArray *)cities {
    _cities = cities;
    [_collectionView reloadData];
}

+ (CGFloat)heightOfCitiesCount: (NSInteger)count {
    NSInteger row = count/3 + (count%3==0?0:1);
    return row*44;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cities.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CityMarkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CityMarkCell" forIndexPath:indexPath];
    City *city = _cities[indexPath.row];
    cell.name.text = city.Name;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    City *city = _cities[indexPath.row];
    [city cacheToHistory];
    self.citiesVC.selectBlock(city);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat margin = 25;
    return CGSizeMake((width - margin*3 - 15)/3, 44);
}
@end
