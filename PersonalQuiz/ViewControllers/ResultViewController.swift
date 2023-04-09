//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 06.04.2023.
//

import UIKit

final class ResultViewController: UIViewController {

    @IBOutlet var youLabel: UILabel!
    @IBOutlet var yourDescriptionLabel: UILabel!
    
    
    var answersChosen: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        let chosenAnimal = numberOfResponses(answersChosen)
        youLabel.text = "Вы - \(chosenAnimal.rawValue)"
        yourDescriptionLabel.text = chosenAnimal.definition
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    deinit {
        print("\(type(of: self)) has been deallocated")
    }
}

// MARK: - Finding the maximum number of repetitions
private extension ResultViewController {
        func numberOfResponses(_ answers: [Answer]) -> Animal {
            var numberOfResponses: [Animal: Int] = [:]
            var max = 1
            var resultAnimal: Animal = .dog
    
            for answer in answers {
                let animal = answer.animal
    
                if !numberOfResponses.keys.contains(animal) {
                    numberOfResponses[animal] = 1
                    continue
                } else {
                    numberOfResponses[animal]! += 1
                }
                
                /*
                 Вопрос: тут лучше использовать извлечение опционала через guard
                 или же с принудительным извлечение работать (т.к. если второе условие
                 проходит, то точно есть значение с таким ключом), исходя из того,
                 что в двух местах дальше юзается опциональное значение?
                */
                
                if numberOfResponses[animal]! > max {
                    max = numberOfResponses[animal]!
                    resultAnimal = animal
                }
            }
            return resultAnimal
        }
}
