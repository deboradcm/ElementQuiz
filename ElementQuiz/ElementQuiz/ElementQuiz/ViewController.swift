//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Aluno01 on 27/04/22.
//  Copyright © 2022 Eldorado. All rights reserved.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}

enum State {
    case question
    case answer
}


class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet var modeSelector: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    
    var mode:Mode = .flashCard
    var state:State = .question
    
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    //atualiza a UI no modo ficha de estudo
    func updateFlashCardUI() {
        let elementName = elementList[currentElementIndex]
        
        //criando uma nova instância para procurar imagens
        let image = UIImage(named: elementName)
        
        imageView.image = image
        
        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "?"
        }
    }
    
    //atualia a aUI no modo teste
    func upadateQuizUI() {
        
    }
    
    //atualiza a UI com base no seu modo e estado
    func updateUI() {
        switch mode {
        case .flashCard:
            updateFlashCardUI()
        case .quiz:
            upadateQuizUI()
        }
        switch state {
        case .question:
            answerLabel.text = ""
        case .answer:
            if answerIsCorrect {
                answerLabel.text = "Correct!"
            } else {
                answerLabel.text = "❌"
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }


    //também atualiza a UI
    @IBAction func showAnswer(_ sender: Any) {
       state = .answer
        updateUI()
    }
    
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1
        if currentElementIndex >= elementList.count {
            currentElementIndex = 0
        }
        state = .question
        updateUI()
    
      //executa após o usuário pressionar a ecla return no teclado
    func textFieldShouldReturn(_textField: UITextField) -> Bool {
            
        //pega o texto do campo de texto
        let textFieldContents = textField.text!
            
        //Determina se o usuário respondeu corretamente e atualiza o estado de teste
            
        if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
                
        } else {
            answerIsCorrect = false
        }
            
        // o plicativo agora deve mostrar a resposta ao usuário
        state = .answer
        updateUI()
        return true
        }
        
    }
    
    @IBAction func switchModes(_ sender: Any) {
        
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flaschCard
        }
    }
    
    
}

