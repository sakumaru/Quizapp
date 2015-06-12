//
//  QuizViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    //出題数
    var questionNumber:Int = 5
    
    //現在の問題数
    var sum:Int = 0
    
    //正解数
    var correctAnswer:Int = 0
    
    //乱数
    var random:Int = 0
    
    //クイズを格納する配列
    var quizArray = [NSMutableArray]()
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons: Array<UIButton>!
    
    //正誤判定の画像（マルバツ）
    @IBOutlet var AnswerMark: UIImageView!
    var AnswerTrue:UIImage!  = UIImage(named: "true.png")
    var AnswerFalse:UIImage! = UIImage(named: "false.png")
    //var AnsAnimeArray = [NSArray]()
    var AnsTrueAnimeArray : Array<UIImage> = []
    var AnsFalseAnimeArray : Array<UIImage> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnsTrueAnimeArray.append(AnswerTrue)
        AnsFalseAnimeArray.append(AnswerFalse)
        AnswerMark.image = nil
        
        //------------------------ここから下にクイズを書く------------------------//
        quizArray.append(["問題文1 以下のドリンクの中でホイップがのっていないものはどれ？","キャラメルラテ","カフェラテ","チョコラテ",2])
        quizArray.append(["問題文2 以下の選択肢の中でホットだと作れないサイズはどれ？","ショート","エノルメ","グランデ",2])
        quizArray.append(["問題文3　タリーズコーヒーでのOne more!の値段はいくらか？","100円","150円","200円",2])
        quizArray.append(["問題文4　以下の選択肢の中でイタリア語で「元気よく」の意味にあたるものはどれか","コン　アモーレ","コン　スプリトゥオ","コン　ブリオ",2])
        quizArray.append(["問題文5 タリーズコーヒーの店員が決して言わないものはどれか","少々お持ちください","いらっしゃいませ","またお持ちしております",2])
        quizArray.append(["問題文6 無料でトッピングできるものはどれか","エスプレッソショット追加","キャラメルソース追加","豆乳に変更",2])

        //------------------------ここから下にクイズを書く------------------------//
        choiceQuiz()
    }
    
    func choiceQuiz() {
        //クイズの問題文をシャッフルしてTextViewにセット
        //乱数の代入
        if quizArray.count==0 {
            random = 0
        }else{
        random = Int(arc4random_uniform(UInt32(quizArray.count)))
        }
        quizTextView.text = quizArray[random][0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        for var i = 0; i < choiceButtons.count; i++ {
            choiceButtons[i].setTitle(quizArray[random][i+1] as? String, forState: .Normal)
            
            //どのボタンが押されたか判別するためのtagをセット
            choiceButtons[i].tag = i + 1;
        }
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        sum++
        
        AnswerMark.animationRepeatCount = 10; //n回
        AnswerMark.animationDuration = 5; //0.8秒に設定
        if quizArray[random][4] as! Int == sender.tag {
            //正解数を増やす
            correctAnswer++
            println("-> 正解")
            AnswerMark.animationImages = AnsTrueAnimeArray
        }else{
            println("-> 不正解")
            AnswerMark.animationImages = AnsFalseAnimeArray
        }
        
        // アニメーションを開始
        AnswerMark.startAnimating()
        let delay = 0.6 * Double(NSEC_PER_SEC) //delay秒間、正誤マークの表示を終了
        let animatime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(animatime, dispatch_get_main_queue()) { //マーク表示終了後の処理
            self.AnswerMark.stopAnimating() //表示終了
            self.AnswerMark.image = nil
        
        //解いた問題数の合計が予め設定していた問題数に達したら
            if self.sum == self.questionNumber {
                self.performSegueToResult()//結果画面へ
            }
                self.quizArray.removeAtIndex(self.random)  //添字[random]の問題を排除
                self.choiceQuiz() //次の問題を選出


            }
        }
        
        
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }

     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultView") {
            
            var ResultView : ResultViewController = segue.destinationViewController as! ResultViewController

            ResultView.correctAnswer = self.correctAnswer
        }
    }
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
