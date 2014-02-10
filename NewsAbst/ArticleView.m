//
//  ArticleTile.m
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/08.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//

#import "ArticleView.h"

@implementation ArticleView
@synthesize text = _text;
//@synthesize imv = _imv;


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        [self initializer];
    }
    
    return self;
}

-(void)initializer{
    @autoreleasepool {
        //透過したいViewの背景色を透明に
        self.backgroundColor = [UIColor clearColor];
        
        //ダミーToolBarを作成し、Viewの再背面に挿入
        UIToolbar *dummyToolBar = [[UIToolbar alloc] initWithFrame:self.bounds];
        dummyToolBar.barStyle = UIBarStyleBlack;
        [self insertSubview:dummyToolBar atIndex:0];
    }
}

@end
