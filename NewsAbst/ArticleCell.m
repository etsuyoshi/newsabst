//
//  ArticleTile.m
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/08.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//

#import "ArticleCell.h"

@implementation ArticleCell
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
        //デフォルト値：インスタンス化した後も設定可能
        self.translucentAlpha = 0.8f;
        self.translucentStyle = UIBarStyleDefault;
        self.translucentTintColor = [UIColor yellowColor];
        self.backgroundColor = [UIColor clearColor];
        
        
    }
}



@end
