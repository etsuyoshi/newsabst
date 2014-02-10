//
//  ArticleTable.m
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/10.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//

#import "ArticleTable.h"

@implementation ArticleTable

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        [self initializer];
    }
    
    return self;
}

-(void)initializer{
    
    //prohibit to let component allocated upon this be transparancy
//    self.alpha = 0.0f;
    
    //test:backcolor
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
//    self.backgroundColor = [UIColor clearColor];
    
    
    ArticleCell *articleCell = [[ArticleCell alloc]initWithFrame:
                                CGRectMake(10, 10, 300, 100)];
    articleCell.translucentTintColor = [UIColor colorWithRed:0.8f green:0 blue:0 alpha:0.4f];
    [self addSubview:articleCell];
}

@end
