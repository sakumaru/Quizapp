//
//  ResultViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
     var correctAnswer:Int = 0
    
    @IBOutlet var resultTextView:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTextView.numberOfLines = 3
        
                
        if(correctAnswer == 5){
            resultTextView.text = String("全問正解！これで君も未来のバリスタだ！")
            
        }else if(correctAnswer == 4){
            resultTextView.text = String("正解数4問！センスあるね！")
            
        }else if(correctAnswer == 3){
            resultTextView.text = String("正解数3！まあ、、、普通だね")
            
        }else if (correctAnswer == 2){
            resultTextView.text = String("正解数2問　本気出していいんだよ？")
            
        }else if (correctAnswer==1){
            resultTextView.text = String("正解数1問　わざとやってるの？")
            
        }else if (correctAnswer==0){
            resultTextView.text = String("正解数0　貴様にはほとほと愛想が尽きた")
        }
        
        

        }
}