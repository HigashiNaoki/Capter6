//
//  QuestionViewController.swift
//  MyQuiz
//
//  Created by Naoki on 2022/09/10.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {

    var questionData: QuestionData!
    
    @IBOutlet weak var questionNoLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    @IBOutlet weak var correctImageView: UIImageView!
    @IBOutlet weak var incorrectImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初期データの設定処理。前画面での設定済みのquestionDataから値を取り出す
        questionNoLabel.text = "Q." + String(questionData.questionNo)
        questionTextView.text = questionData.question
        answer1Button.setTitle(questionData.answer1, for: UIControl.State.normal)
        answer2Button.setTitle(questionData.answer2, for: UIControl.State.normal)
        answer3Button.setTitle(questionData.answer3, for: UIControl.State.normal)
        answer4Button.setTitle(questionData.answer4, for: UIControl.State.normal)
    }
    
    @IBAction func tapAnswer1Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 1
        goNextQuestionWithAnimation()
    }
    
    @IBAction func tapAnswer2Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 2
        goNextQuestionWithAnimation()
        
    }
    
    @IBAction func tapAnswer3Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 3
        goNextQuestionWithAnimation()
        
    }
    
    @IBAction func tapAnswer4Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 4
        goNextQuestionWithAnimation()
        
    }
    
    //次の問題に正解のアニメーション付きで遷移する
    func goNextQuestionWithAnimation(){
        //正解しているか判定
        if questionData.isCorrect(){
            //正解のアニメーションを再生しながら次の問題へ遷移する
            goNextQuestionWithCorrectAnimation()
        }else{
            //不正解のアニメーションを再生しながら次の問題へ遷移する
            goNextQuestionWithIncorrectAnimation()
        }
    }
    
    //次の問題に正解のアニメーション付きで遷移する
    func goNextQuestionWithCorrectAnimation(){
        //正解音を鳴らす
        AudioServicesPlayAlertSound(1025)
        
        //アニメーション
        UIView.animate(withDuration: 2.0, animations: {
            //アルファ値を1.0に変化させる
            self.correctImageView.alpha = 1.0
        }){(bool) in self.goNextQuestion()}
    }
    //次の問題に不正解のアニメーション付きで遷移する
    func goNextQuestionWithIncorrectAnimation(){
        //正解音を鳴らす
        AudioServicesPlayAlertSound(1006)
        
        //アニメーション
        UIView.animate(withDuration: 2.0, animations: {
            //アルファ値を1.0に変化させる
            self.incorrectImageView.alpha = 1.0
        }){(bool) in self.goNextQuestion()}
    }
 
    
    func goNextQuestion(){
        //問題文の問いだし
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else{
            //問題文がなければ結果画面に遷移する
            //StoryboardのIdentifierに設定した値(result)を指定して
            //ViewControllerを生成する
            if let resultViewCntroller =             storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController{
                //StoryboardのSegueを利用しない明示的な画面遷移処理
                present(resultViewCntroller,animated: true,completion:nil)
            }
            return
        }
        
        //問題文がある場合はt技の問題へ遷移する
        //StoryboardのIdentifierに設定した値(question)を指定して
        //ViewControllerを生成する
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController{
         nextQuestionViewController.questionData = nextQuestion
            //StoryboardのSegueを利用しない明示的な画面遷移処理
            present(nextQuestionViewController,animated: true,completion:nil)
        }
    }
}
