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

        self.translucentAlpha = 0.8f;
        self.translucentStyle = UIBarStyleDefault;
        self.translucentTintColor = [UIColor yellowColor];
        self.backgroundColor = [UIColor clearColor];
        
        
    }
}

@end
