//
//  QuestionData.swift
//  MyQuiz
//
//  Created by Naoki on 2022/09/05.
//

import Foundation

class QuestionData
{
    //問題文
    var question: String
    
    //選択肢
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    
    //正解の番号
    var correctAnswerNumber: Int
    
    //ユーザーが選択した選択肢の番号
    var userChoiceAnswerNumber: Int?
    
    //問題の番号
    var questionNo: Int = 0
    
    //クラスが生成された時の処理
    init(questionSourceDataArray: [String]){
        question = questionSourceDataArray[0]
        answer1 = questionSourceDataArray[1]
        answer2 = questionSourceDataArray[2]
        answer3 = questionSourceDataArray[3]
        answer4 = questionSourceDataArray[4]
        correctAnswerNumber = Int(questionSourceDataArray[5])!
    }
    
    //ユーザーが選択した答えが正解かどうか判定する
    func isCorrect() -> Bool{
        //答えが一致しているかどうか判定する
        if correctAnswerNumber == userChoiceAnswerNumber{
            //正解
            return true
        }
        //不正解
        return false
    }
    
}
