//
//  ResultViewController.swift
//  MyQuiz
//
//  Created by Naoki on 2022/08/21.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var correctPercentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //問題数を取得する
        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        
        //正解数を取得する
        var correctCount: Int = 0
        for questionData in QuestionDataManager.sharedInstance.questionDataArray{
            if questionData.isCorrect(){
                correctCount += 1
            }
        }
        
        //正解率を計算する
        let correctPercent: Float = (Float(correctCount)/Float(questionCount)) * 100
        
        //正解数を小数点第一位まで計算して画面に反映する
        correctPercentLabel.text = String(format: "%.1f",correctPercent) + "%"
    }
}
