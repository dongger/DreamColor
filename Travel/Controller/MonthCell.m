//
//  MonthCell.m
//  Travel
//
//  Created by yang cai on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "MonthCell.h"
#import "DayCell.h"

@interface MonthCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray *titleArray;
@end

@implementation MonthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _titleArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
}

- (void)loadInfo: (NSString *)info {

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayCell" forIndexPath:indexPath];
    
    if (indexPath.row < 7) {
        [cell loadInfo:[NSString stringWithFormat:@"%@",_titleArray[indexPath.row]]];
    } else {
        [cell loadInfo:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    }
    return cell;
}



@end
