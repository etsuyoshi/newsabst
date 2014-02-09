//
//  ViewController.m
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/08.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//

#define DispDatabaseLog

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UIImageView *imvBackground;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
//    for (TFHppleElement *element in tutorialsNodes) {
//        // 5
//        Tutorial *tutorial = [[Tutorial alloc] init];
//        [newTutorials addObject:tutorial];
//        
//        // 6
//        tutorial.title = [[element firstChild] content];
//        
//        // 7
//        tutorial.url = [element objectForKey:@"href"];
//    }
    
    
    
//    @"id",
//    @"datetime",
//    @"blog_id",
//    @"title",
//    @"url",
//    @"body_with_tags",
//    @"body",
//    @"hatebu",
//    @"saveddate",
    
    //表示コンポーネントやデータの初期化等
    
    //背景画像の名称
    NSArray *arrStrBackground =
    [NSArray arrayWithObjects:
     @"aman.png",
     @"bird.png",
     @"building.png",
     @"building2.png",
     @"dest.png",
     @"light.png",
     @"street.png",
     @"sunset.png",
     @"wood.png",
     nil];
    
//    NSMutableArray *arrImvBackground;
//    arrImvBackground = [NSMutableArray array];
    @autoreleasepool {
        UIImageView *imvTmp;
        int _width = [[UIScreen mainScreen] bounds].size.width;
        int _height = [[UIScreen mainScreen] bounds].size.height;
        
        //背景オブジェクト
        imvBackground =
        [[UIImageView alloc]
         initWithFrame:
         CGRectMake(0, 0, _width * [arrStrBackground count], _height)];
        
        //個別背景画像
        for(int i = 0;i < [arrStrBackground count];i++){
            imvTmp = [[UIImageView alloc]initWithImage:[UIImage imageNamed:arrStrBackground[i]]];
            imvTmp.frame = CGRectMake(i * _width, 0, _width, _height);
//            [arrImvBackground addObject:imvTmp];
            [imvBackground addSubview:imvTmp];
        }
        
        
    }//autoreleasepool
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.view addSubview:imvBackground];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //背景やコンポーネントの配置
    
    
    UIPanGestureRecognizer *panGesture;
    panGesture = [[UIPanGestureRecognizer alloc]
                  initWithTarget:self
                  action:@selector(onFlickedFrame:)];
    NSLog(@"onflickedframe");
    [imvBackground addGestureRecognizer:panGesture];
    imvBackground.userInteractionEnabled = YES;
    NSLog(@"imvbackground=%@", imvBackground);
    
    
}

-(void)onFlickedFrame:(UIPanGestureRecognizer *)gr{
//    int sensitivity = 3;//移動間隔
    //移動幅
    CGPoint movingPoint = [gr translationInView:imvBackground];
//    if(sensitivity != 0){
//        point = CGPointMake(point.x*(0.5f*sensitivity+1), point.y);
//    }
    //移動後の中心位置
    CGPoint movedPoint = CGPointMake(imvBackground.center.x + movingPoint.x,
                                     imvBackground.center.y);
    
    NSLog(@"onFlickedFrame : %f, %f", movedPoint.x, movedPoint.y);
    
    
    //画像を一枚毎に定位置に表示する(定位置：各画像の中心が画面の中心となるように)
    //フリック幅がある程度の大きさになったら
    if(abs(movingPoint.x) > 100){
        //移動した後の定位置を取得
        //具体的にはfor文を回して、中心点が各「区切り」の範囲内にあるかどうか判定し、中心点が存在する範囲の中心に画像の中心を設置
        int numOfImage = imvBackground.bounds.size.width / [UIScreen mainScreen].bounds.size.width;
        for(int i = 0 ;i < numOfImage;i++){
            
        }
    }else{
        if(movedPoint.x - imvBackground.bounds.size.width + [[UIScreen mainScreen] bounds].size.width/2 <= [[UIScreen mainScreen] bounds].size.width/2 &&
           movedPoint.x - imvBackground.bounds.size.width + [[UIScreen mainScreen] bounds].size.width/2 >= [[UIScreen mainScreen] bounds].size.width/2 - imvBackground.bounds.size.width){
            //中心位置に表示する
            imvBackground.center = movedPoint;
            [gr setTranslation:CGPointZero inView:imvBackground];
            
        }

    }
    
    //通常のフリック
    //基準点(screen center)から左側へimvBackground横幅まで移動可能にする
    
    
    if (gr.state == UIGestureRecognizerStateChanged) {//移動中
        NSLog(@"dragging");
    }
    // 指が離されたとき、ビューを元に位置に戻して、ラベルの文字列を変更する
    else if (gr.state == UIGestureRecognizerStateEnded) {//指を離した時
        NSLog(@"released");
    }
}


-(void)getDataFromDB{
    //databasemanageクラスからデータを取得(引数なしだと最大100記事を取得)
    NSArray *array = [DatabaseManage getValueFromDB];//100個取得
    
    NSString *strId = nil;
    NSString *strBody = nil;
    NSString *strSaved = nil;
    NSString *strDate = nil;
    NSDictionary *_dict = nil;
    for(int i = 0;i < [array count];i++){
        _dict = array[i];
        strId = [_dict objectForKey:@"id"];
        strBody = [_dict objectForKey:@"body"];
        strSaved = [_dict objectForKey:@"saveddate"];
        strDate = [_dict objectForKey:@"datetime"];
#ifdef DispDatabaseLog
        NSLog(@"id=%@",strId);
        
        NSLog(@"id=%@",strBody);
        NSLog(@"id=%@",strSaved);
        NSLog(@"id=%@",strDate);
#endif
    }
}


@end
