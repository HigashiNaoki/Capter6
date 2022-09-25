//
//  QuestionDataManager.swift
//  MyQuiz
//
//  Created by Naoki on 2022/08/22.
//

import Foundation

//クイズデータ全般の管理と成績を管理するクラス
class QuestionDataManager
{
    static let sharedInstance = QuestionDataManager()
    
    //問題を格納する配列
    var questionDataArray = [QuestionData]()
    //現在のモンd内のインデックス
    var nowQuestionIndex: Int = 0
    
    //初期化処理
    private init(){
        //シングルトンであることを保証するためにprivateで宣言しておく
    }
    
    //問題文の読み込み処理
    func loadQuestion(){
        //格納済みの問題文があれば一旦削除しておく
        questionDataArray.removeAll()
        //現在の問題のインデックスを初期化
        nowQuestionIndex = 0
        
        //CSVファイルパスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv")else{
            //csvファイルなし
            print("csvファイルが存在しません")
            return
        }
        
        //csvファイル読み込み
        do{
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            //csvデータを1行ずつ読み込む
            csvStringData.enumerateLines(invoking: {(line,stop) in
                //カンマ区切りで分割
                let questionSourceDataArray = line.components(separatedBy: ",")
                if questionSourceDataArray.count != 6 {
                    //配列サイズが規定のサイズじゃない場合は終了する
                    return
                }
                else{
                 //問題文を格納するオブジェクトを作成
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
                //問題文を追加
                self.questionDataArray.append(questionData)
                //問題番号を設定
                questionData.questionNo = self.questionDataArray.count
                }
            })
        }catch let error{
            print ("csvファイル読み込みエラーが発生しました:\(error)")
            return
        }
    }
    
    //次の問題を取り出す
    func nextQuestion() -> QuestionData?{
        if nowQuestionIndex < questionDataArray.count{
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
    
}
