//
//  SZItemView.m
//  方块图
//
//  Created by jcl on 2021/6/4.
//

#import "SZItemView.h"

@interface SZItemView ()
@property (nonatomic, strong) UILabel *valueLabel;
@end

@implementation SZItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:self.frame];
    valueLabel.adjustsFontSizeToFitWidth = YES;
    self.valueLabel = valueLabel;
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.textColor = UIColor.whiteColor;
    [self addSubview:valueLabel];
}



- (void)setValue:(int)value{
    _value = value;
    self.valueLabel.text = [NSString stringWithFormat:@"%d",value];
    self.backgroundColor = UIColor.orangeColor;
}
- (void)layoutSubviews{
    self.valueLabel.frame = self.bounds;
    self.valueLabel.adjustsFontSizeToFitWidth = YES;
}
@end
