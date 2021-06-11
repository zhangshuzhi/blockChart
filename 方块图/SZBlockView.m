//
//  SZBlockView.m
//  方块图
//
//  Created by jcl on 2021/6/4.
//

#import "SZBlockView.h"
#import "SZItemView.h"

@implementation SZBlockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

-(void)setData:(NSArray *)data
{
    _data = data;
    [self removeAll];
    for (NSString* value in data) {
        [self addSubNode:[value intValue]];
    }
    [self recalcLayout];
}

-(void)addSubNode:(int)value
{
    SZItemView* item = [SZItemView new];
    item.value = value;
    [self addSubview:item];
}

-(void)removeAll
{
    //移除所有子视图
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(bool)isVertical:(double)w Height:(double) h
{
    return w / h > 1.618;
}

-(void)recalcLayout
{
    if (self.subviews.count < 1) return;
    [self recalcSquarifiedLayout:0 Finish:self.subviews.count - 1 Area:self.bounds];
}

-(void)recalcSliceLayout:(NSUInteger)nStart Finish:(NSUInteger)nFinish Area:(CGRect)rect IsVertical:(bool) bIsVertical
{
    NSAssert(nStart < self.subviews.count, @"nStart >= self.subviews.count");
    NSAssert(nFinish < self.subviews.count, @"nFinish >= self.subviews.count");

    if (nStart == nFinish)
    {
        [self.subviews[nStart] setFrame:rect];
        return;
    }

    double dblTotal = [self getChildrenTotal:nStart Finish:nFinish];

    double x = rect.origin.x;
    double y = rect.origin.y;

    if (bIsVertical)
    {
        for (NSUInteger i = nStart; i <= nFinish; i++)
        {
            SZItemView* item = self.subviews[i];
            double cx = rect.size.width * item.value / dblTotal;
            CGRect rectSubNode = item.frame;
            rectSubNode = rect;
            rectSubNode.origin.x = x;
            if (i == nFinish) {
                rectSubNode.size.width = cx;
            }else{
                rectSubNode.size.width = cx-1;
            }
            
            item.frame = rectSubNode;
            
            x += cx;
        }
    } else
    {
        for (NSUInteger i = nStart; i <= nFinish; i++)
        {
            SZItemView* item = self.subviews[i];
            double cy = rect.size.height * item.value / dblTotal;
            CGRect rectSubNode = item.frame;
            rectSubNode = rect;
            rectSubNode.origin.y = y;
            if (i==nFinish) {
                rectSubNode.size.height = cy;
            }else{
                rectSubNode.size.height = cy-1;
            }
            
            item.frame = rectSubNode;
            y += cy;
        }
    }
}

-(void)recalcSquarifiedLayout:(NSUInteger)nStart Finish:(NSUInteger)nFinish Area:(CGRect) rect
{
    NSAssert(nStart < self.subviews.count, @"nStart >= self.subviews.count");
    NSAssert(nFinish < self.subviews.count, @"nFinish >= self.subviews.count");

    if (nStart + 2 > nFinish)
    {
        return [self recalcSliceLayout:nStart Finish:nFinish Area:rect IsVertical:[self isVertical:rect.size.width Height:rect.size.height]];
    }

    double total = [self getChildrenTotal:nStart Finish:nFinish],total_left = 0.;
    for (NSUInteger i = nStart; i <= nFinish; i++)
    {
        SZItemView* item = self.subviews[i];
        double pre_dt = total_left - total / 2;
        total_left += item.value;
        double dt = total_left - total / 2;

        if (dt > 0)
        {
            if (dt + pre_dt > 0)
            {
                total_left -= item.value;
                i--;
            }
            if ([self isVertical:rect.size.width Height:rect.size.height])
            {
                CGRect rectLeft = rect;
                rectLeft.size.width = rect.size.width * total_left / total - 1;
                [self recalcSquarifiedLayout:nStart Finish:i Area:rectLeft];

                CGRect rectRight = rect;
                rectRight.origin.x = rectLeft.origin.x + rectLeft.size.width + 1;
                rectRight.size.width = rect.size.width - rectLeft.size.width - 1;
                [self recalcSquarifiedLayout:i + 1 Finish:nFinish Area:rectRight];
            } else
            {
                CGRect rectTop = rect;
                rectTop.size.height = rect.size.height * total_left / total - 1;
                [self recalcSquarifiedLayout:nStart Finish:i Area:rectTop];

                CGRect rectBottom = rect;
                rectBottom.origin.y = rectTop.origin.y + rectTop.size.height + 1;
                rectBottom.size.height = rect.size.height - rectTop.size.height - 1;
                [self recalcSquarifiedLayout:i + 1 Finish:nFinish Area:rectBottom];
            }
            return;
        }
    }

//    NSAssert(false, @"unreachable");
}



-(double)getChildrenTotal:(NSUInteger)nStart Finish:(NSUInteger) nFinish
{
    double dblTotal = 0.;

    for (NSUInteger i = nStart; i <= nFinish; i++)
    {
        SZItemView* item = self.subviews[i];
        dblTotal += item.value;
    }

    return dblTotal;
}

@end
