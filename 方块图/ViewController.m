//
//  ViewController.m
//  方块图
//
//  Created by jcl on 2021/6/4.
//

#import "ViewController.h"
#import "SZBlockView.h"
@interface ViewController ()
@property (nonatomic, strong) SZBlockView *blockView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [pushBtn setTitle:@"按占比方块图" forState:UIControlStateNormal];
    [pushBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    pushBtn.backgroundColor = UIColor.yellowColor;
    pushBtn.frame = CGRectMake(100, 40, 100, 30);
    [self.view addSubview:pushBtn];
    [pushBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)btnAction{
    [self.view addSubview:self.blockView];
    NSMutableArray *data = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",arc4random()%100];
        [data addObject:str];
    }
    self.blockView.data = [data copy];
}

- (SZBlockView *)blockView{
    if (!_blockView) {
        _blockView = [[SZBlockView alloc] initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, 600)];
        _blockView.layer.cornerRadius = 2;
        _blockView.layer.borderWidth = 1;
        _blockView.layer.borderColor = [UIColor redColor].CGColor;
    }
    return _blockView;
}

@end
