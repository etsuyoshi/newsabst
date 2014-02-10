//
//  BackgroundView.m
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/10.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//
#define FRAMESIZE [UIScreen mainScreen].bounds.size.width

#import "BackgroundView.h"

@implementation BackgroundView

CGPoint pntStartDrag;//drag開始点
int noStatus;//表示されている画面ID(左から0,1,...,[arrStrBackground count])
int numOfImage;//画像の枚数

NSDictionary *dictBackground;

ArticleTable *leftTable;
ArticleTable *rightTable;

- (id)init{
    
    dictBackground =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"aman.png", [NSNumber numberWithInteger:TableTypeSports],
     @"bird.png", [NSNumber numberWithInteger:TableTypeTechnology],
     @"building.png", [NSNumber numberWithInteger:TableTypeArts ],
//     @"building2.png",
//     @"desk.png",
//     @"light.png",
//     @"street.png",
//     @"sunset.png",
//     @"wood.png",
     nil];
    
//    NSArray *arrStrBackground =
//    [NSArray arrayWithObjects:
//     @"aman.png",
//     @"bird.png",
//     @"building.png",
//     @"building2.png",
//     @"desk.png",
//     @"light.png",
//     @"street.png",
//     @"sunset.png",
//     @"wood.png",
//     nil];
    NSArray *arrStrBackground = [dictBackground allValues];
    
    
    int _width = [[UIScreen mainScreen] bounds].size.width;
    int _height = [[UIScreen mainScreen] bounds].size.height;
    
    //背景オブジェクト
    self =
    [super initWithFrame:
     CGRectMake(0, 0, _width * [arrStrBackground count], _height)];
//    numOfImage = self.bounds.size.width / [UIScreen mainScreen].bounds.size.width;
    numOfImage = (int)[arrStrBackground count];
    
    if (self) {
        // Initialization code
        @autoreleasepool {
            //ジェスチャー追加
            UIPanGestureRecognizer *panGesture;
            panGesture = [[UIPanGestureRecognizer alloc]
                          initWithTarget:self
                          action:@selector(onFlickedFrame:)];
            NSLog(@"onflickedframe");
            [self addGestureRecognizer:panGesture];
            self.userInteractionEnabled = YES;
            
            
            //個別画像
            UIImageView *imvTmp;
//
            //個別背景画像
            for(int i = 0;i < [arrStrBackground count];i++){
                imvTmp = [[UIImageView alloc]initWithImage:[UIImage imageNamed:arrStrBackground[i]]];
                imvTmp.frame = CGRectMake(i * _width, 0, _width, _height);
                //            [arrImvBackground addObject:imvTmp];
                [self addSubview:imvTmp];
            }
            
            
        }//autoreleasepool
    }
    return self;
}

//現在のnoStatusから両脇のテーブルを表示する
//(initとonflickedFrameメソッドにより)現在のnoStatusにおけるテーブルは既に見ている状態とする
-(void)allocSideTable{
    @autoreleasepool {
        int widthTable = FRAMESIZE*.9f;
        int heightTable = [UIScreen mainScreen].bounds.size.height;
        if(noStatus == [dictBackground count]-1){
            //右端にいるとき
            leftTable =
            [[ArticleTable alloc]
        initWithFrame:CGRectMake(-widthTable, 0,
                                 widthTable,
                                 heightTable)];
            rightTable = nil;
        }else if(noStatus == 0){
            //左端にいるとき
            leftTable = nil;
            rightTable =
            [[ArticleTable alloc]
             initWithFrame:CGRectMake(FRAMESIZE, 0,
                                      widthTable,
                                      heightTable)]
        }else if(noStatus < [dictBackground count] &&
                 noStatus > 0){
            //左端、右端以外(かつ適当範囲内)であるとき
            
        }else{
            NSLog(@"error");
        }
    }
}

//常に定位置にいるように設定
-(void)onFlickedFrame:(UIPanGestureRecognizer *)gr{
    
    
    
    //移動幅:コンマ数秒間隔でサンプリングされた際の移動幅(タッチしてからの移動幅ではない)
    CGPoint movingPoint = [gr translationInView:self];
    //移動後の中心位置
    CGPoint movedPoint = CGPointMake(self.center.x + movingPoint.x,
                                     self.center.y);
    
    self.center = movedPoint;
    [gr setTranslation:CGPointZero inView:self];
    
    
    
    if (gr.state == UIGestureRecognizerStateBegan) {
        
        //ドラッグ開始点の設定
        pntStartDrag = CGPointMake(self.center.x,
                                   self.center.y);
        //現在位置の判定
        int xOfRightImageCenter = self.frame.origin.x + self.bounds.size.width - FRAMESIZE/2;//一番右の画像の中心位置
        for(int i = 0;i < numOfImage;i++){
            if(xOfRightImageCenter >= i * FRAMESIZE &&
               xOfRightImageCenter < (i + 1) * FRAMESIZE){
                //左の画像(の中心)が見えている状態を０、右隣の画像(中心)が画面上に見えている場合は１、。。。
                noStatus = numOfImage - i - 1;
            }
        }
    }else if (gr.state == UIGestureRecognizerStateChanged) {//移動中
    }
    // 指が離されたとき、ビューを元に位置に戻して、ラベルの文字列を変更する
    else if (gr.state == UIGestureRecognizerStateEnded) {//指を離した時
        
        
        if(pntStartDrag.x - self.center.x > 100){//左にドラッグ
            if(noStatus < numOfImage-1)
                noStatus++;
        }else if(pntStartDrag.x - self.center.x < -100){
            if(noStatus > 0)
                noStatus--;
        }else{
            //do nothing
        }
        NSLog(@"to status = %d", noStatus);
        [UIView
         animateWithDuration:0.25f
         delay:0.0f
         options:UIViewAnimationOptionCurveEaseIn
         animations:^{
             
             self.frame =
             CGRectMake(FRAMESIZE * -noStatus, 0, self.bounds.size.width,
                        self.bounds.size.height);
             NSLog(@"animated to x=%f", FRAMESIZE * - noStatus);
         }
         completion:^(BOOL finished){
             
         }];
    }
}


@end
