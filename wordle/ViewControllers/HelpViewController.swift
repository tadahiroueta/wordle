//
//  HelpViewController.swift
//  wordle
//
//  Created by Ueta, Lucas T on 3/22/24.
//

import UIKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isDarkMode = (presentingViewController as! MainViewController).isDarkMode
        
        view.backgroundColor = !isDarkMode ? .white : .black
        
        let stack = addSideStack(to: view)
        
        let xButton = addXButton(to: stack)
        xButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
                
        for text in [
            "Guess the WORDLE in six tries.",
            "Each guess must be a valid five-letter word. Hit the enter button to submit.",
            "After each guess, the color of the tiles will change to show how close your guess was to the word.",
            "GREEN means the leetter is in the word and in the correct spot.",
            "YELLOW means the letter is in the word but in the wrong spot.",
            "GREY means the letter is not in the word in any spot."
        ] { addLabel(text, to: stack, textColor: !isDarkMode ? .black : .white) }
    }
    
    func addLabel(_ text: String, to stack: UIStackView, textColor: UIColor) {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = textColor
        stack.addArrangedSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: stack.widthAnchor)
    ])}
    
    @objc func goBack() { dismiss(animated: true) }
}
