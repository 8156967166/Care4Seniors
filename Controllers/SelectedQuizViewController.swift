//
//  SelectedQuizViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 19/02/24.
//

import UIKit

class Quiz {
    let id: String
    var question: String
    let options: [String]
    let correctAnswer: Int
    var selectedAnswer: Int?
    var iSelectOptn: Int
//    var counter = 10
    init(strId: String, strQuestion: String, strOption: [String], setCorrect: Int, isSelectOptn: Int) {
        self.id = strId
        self.question = strQuestion
        self.options = strOption
        self.correctAnswer = setCorrect
        self.iSelectOptn = isSelectOptn
//        self.selectedAnswer = -1
    }
}

class SelectedQuizViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var labelSecondOption: UILabel!
    @IBOutlet weak var viewCorner: UIView!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelFirstOption: UILabel!
    @IBOutlet weak var labelThirdOption: UILabel!
    @IBOutlet weak var labelAttendQuestion: UILabel!
    @IBOutlet weak var imgThirdOptn: UIImageView!
    @IBOutlet weak var imgSecondOptn: UIImageView!
    @IBOutlet weak var imgFirstOptn: UIImageView!
    @IBOutlet weak var lblAnswerCheck: UILabel!
    @IBOutlet weak var bttnThirdOptn: UIButton!
    @IBOutlet weak var bttnSecondOptn: UIButton!
    @IBOutlet weak var bttnFirstOptn: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    //MARK: - Variables
    
    var currentQuestionIndex: Int = 0
    var selectedAnswer: Int?
    var quizArray = [Quiz]()
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblAnswerCheck.text = ""
        setQuizModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewCorner.roundCorners(corners: [.topLeft], radius: 50.0)
    }
    
    //MARK: - Functions
    
    func setQuizModel() {
        let quiz1 = Quiz(strId: "1", strQuestion: "What is the highest mountain in the world?", strOption: ["Mount K2", "Mount Lhotse", "Mount Everest"], setCorrect: 2, isSelectOptn: 0)
        let quiz2 = Quiz(strId: "2", strQuestion: " In which year did World War II end?", strOption: ["1935", "1945", "1994"], setCorrect: 1, isSelectOptn: 0)
//        quizArray.append(Quiz(question: , options: , correctAnser: ))
        let quiz3 = Quiz(strId: "3", strQuestion: "How many months of the year have exactly 31 days?", strOption: ["6", "7", "10"], setCorrect: 1, isSelectOptn: 0)
        let quiz4 = Quiz(strId: "4", strQuestion: " In which century was the year 1275?", strOption: ["12th century", "13th century", "14th century"], setCorrect: 1, isSelectOptn: 0)
        let quiz5 = Quiz(strId: "5", strQuestion: "What is the largest country in the world by area?", strOption: ["The United States of America", "India", "Russia"], setCorrect: 2, isSelectOptn: 0)
        let quiz6 = Quiz(strId: "6", strQuestion: "How many valves are there in the heart?", strOption: ["3","4", "6"], setCorrect: 1, isSelectOptn: 0)
        let quiz7 = Quiz(strId: "7", strQuestion: "What do we call a baby rabbit?", strOption: ["A cub", "A kit", "A Calf"], setCorrect: 1, isSelectOptn: 0)
        let quiz8 = Quiz(strId: "8", strQuestion: "What is the speed of light?", strOption: ["186,000 miles per second", "186,000 miles per minute", "186,000 miles per hour"], setCorrect: 0, isSelectOptn: 0)
        let quiz9 = Quiz(strId: "9", strQuestion: "Which substance has the chemical formula H2O?", strOption: ["Salt", "water", "Ammonia"], setCorrect: 1, isSelectOptn: 0)
        let quest10 = Quiz(strId: "10", strQuestion: "How many letters are there in the modern English alphabet?", strOption: ["26", "20", "24"], setCorrect: 0, isSelectOptn: 0)
        
        quizArray = [quiz1,quiz2,quiz3, quiz4, quiz5, quiz6, quiz7, quiz8, quiz9, quest10]
        setQuestionAnswers()
    }
    
    func setQuestionAnswers() {
        let model = quizArray[self.currentQuestionIndex]
        labelQuestion.text = model.question
        labelFirstOption.text = model.options[0]
        labelSecondOption.text = model.options[1]
        labelThirdOption.text = model.options[2]
        labelAttendQuestion.text = "Question \(self.currentQuestionIndex+1)"
    }
    
    func setDissableImg() {
        imgFirstOptn.image = UIImage(systemName: "circle")
        imgFirstOptn.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        imgSecondOptn.image = UIImage(systemName: "circle")
        imgSecondOptn.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        imgThirdOptn.image = UIImage(systemName: "circle")
        imgThirdOptn.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    func setButtonDissable() {
        bttnFirstOptn.isEnabled = false
        bttnSecondOptn.isEnabled = false
        bttnThirdOptn.isEnabled = false
    }
    
    func setbuttonEnable() {
        bttnFirstOptn.isEnabled = true
        bttnSecondOptn.isEnabled = true
        bttnThirdOptn.isEnabled = true
    }
    
    func setFirstButtons() {
        let model = quizArray[self.currentQuestionIndex]
        if model.selectedAnswer == 1 {
            setDissableImg()
            imgFirstOptn.image = UIImage(systemName: "record.circle")
            imgFirstOptn.tintColor = #colorLiteral(red: 0.4196078431, green: 0.4039215686, blue: 0.8470588235, alpha: 1)
            if model.correctAnswer == 0 {
                lblAnswerCheck.text = "Correct Answer"
                lblAnswerCheck.textColor = .green
            }
            else {
                lblAnswerCheck.text = "Wrong Answer"
                lblAnswerCheck.textColor = .red
            }
        }
        setButtonDissable()
    }
    
    func setSecondButtons() {
        let model = quizArray[self.currentQuestionIndex]
        if model.selectedAnswer == 2 {
            setDissableImg()
            imgSecondOptn.image = UIImage(systemName: "record.circle")
            imgSecondOptn.tintColor = #colorLiteral(red: 0.4196078431, green: 0.4039215686, blue: 0.8470588235, alpha: 1)
        if model.correctAnswer == 1 {
            lblAnswerCheck.text = "Correct Answer"
            lblAnswerCheck.textColor = .green
         }
         else {
             lblAnswerCheck.text = "Wrong Answer"
             lblAnswerCheck.textColor = .red
         }
        }
        setButtonDissable()
    }
    
    func setThirdButtons() {
        let model = quizArray[self.currentQuestionIndex]
        if model.selectedAnswer == 3 {
            setDissableImg()
            imgThirdOptn.image = UIImage(systemName: "record.circle")
            imgThirdOptn.tintColor = #colorLiteral(red: 0.4196078431, green: 0.4039215686, blue: 0.8470588235, alpha: 1)
        if model.correctAnswer == 2 {
            lblAnswerCheck.text = "Correct Answer"
            lblAnswerCheck.textColor = .green
         }
         else {
             lblAnswerCheck.text = "Wrong Answer"
             lblAnswerCheck.textColor = .red
         }
        }
        setButtonDissable()
    }
    

    //MARK: - ButtonAction
    
    @IBAction func buttonActionOptions(_ sender: UIButton) {
        let model = quizArray[self.currentQuestionIndex]
        model.selectedAnswer = 1
        if sender.tag == 1 {
            model.iSelectOptn = 1
            setDissableImg()
            imgFirstOptn.image = UIImage(systemName: "record.circle")
            imgFirstOptn.tintColor = #colorLiteral(red: 0.4196078431, green: 0.4039215686, blue: 0.8470588235, alpha: 1)
            if model.correctAnswer == 0 {
                lblAnswerCheck.text = "Correct Answer"
                lblAnswerCheck.textColor = .green
            }
            else {
                lblAnswerCheck.text = "Wrong Answer"
                lblAnswerCheck.textColor = .red
            }
            setButtonDissable()
        }
        else if sender.tag == 2 {
            model.iSelectOptn = 1
            model.selectedAnswer = 2
            setDissableImg()
            imgSecondOptn.image = UIImage(systemName: "record.circle")
            imgSecondOptn.tintColor = #colorLiteral(red: 0.4196078431, green: 0.4039215686, blue: 0.8470588235, alpha: 1)
           if model.correctAnswer == 1 {
               lblAnswerCheck.text = "Correct Answer"
               lblAnswerCheck.textColor = .green
            }
            else {
                lblAnswerCheck.text = "Wrong Answer"
                lblAnswerCheck.textColor = .red
            }
            setButtonDissable()
        }
        else if sender.tag == 3 {
            model.iSelectOptn = 1
            model.selectedAnswer = 3
            setDissableImg()
            imgThirdOptn.image = UIImage(systemName: "record.circle")
            imgThirdOptn.tintColor = #colorLiteral(red: 0.4196078431, green: 0.4039215686, blue: 0.8470588235, alpha: 1)
           if model.correctAnswer == 2 {
               lblAnswerCheck.text = "Correct Answer"
               lblAnswerCheck.textColor = .green
            }
            else {
                lblAnswerCheck.text = "Wrong Answer"
                lblAnswerCheck.textColor = .red
            }
            setButtonDissable()
        }
    }
    
    
    @IBAction func buttonActionPrevious(_ sender: UIButton) {
        buttonNext.isEnabled = true
        if currentQuestionIndex == 0 {
            sender.isEnabled = false
        }else {
            sender.isEnabled = true
            currentQuestionIndex -= 1
            setQuestionAnswers()
            setButtonDissable()
            setFirstButtons()
            setSecondButtons()
            setThirdButtons()
        }
    }
    
    @IBAction func buttonActionNext(_ sender: UIButton) {
        
        btnPrevious.isEnabled = true
        if currentQuestionIndex == 9 {
            sender.isEnabled = false
        }else {
            sender.isEnabled = true
            currentQuestionIndex += 1
            lblAnswerCheck.text = ""
            setQuestionAnswers()
            setFirstButtons()
            setSecondButtons()
            setThirdButtons()
            setDissableImg()
            setbuttonEnable()
        }
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
