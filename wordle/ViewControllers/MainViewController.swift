//
//  ViewController.swift
//  wordle
//
//  Created by Ueta, Lucas T on 3/20/24.
//

import UIKit

class MainViewController: UIViewController {
    
    var game = Game()
    var deadLetters: [String] = [] {
        didSet { deadLettersLabel.text = "Dead letters: \(deadLetters.joined(separator: " "))" }
    }

    let helpButton = UIButton()
    let settingsButton = UIButton()
    let titleLabel = UILabel()
    let tileTable = UIStackView()
    let deadLettersLabel = UILabel()
    
    var isDarkMode = false {
        didSet {
            view.backgroundColor = !isDarkMode ? .white : .black
            
            let tintColor: UIColor = !isDarkMode ? .darkGray : .white
            helpButton.tintColor = tintColor
            settingsButton.tintColor = tintColor

            let textColor: UIColor = !isDarkMode ? .black : .white
            titleLabel.textColor = textColor
            deadLettersLabel.textColor = textColor
    }}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bodyStack = UIStackView()
        bodyStack.axis = .vertical
        bodyStack.alignment = .center
        view.addSubview(bodyStack)
        bodyStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            bodyStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            bodyStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        
        let headStack = UIStackView()
        headStack.distribution = .equalSpacing
        bodyStack.addArrangedSubview(headStack)
        headStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headStack.leftAnchor.constraint(equalTo: bodyStack.leftAnchor),
            headStack.rightAnchor.constraint(equalTo: bodyStack.rightAnchor)
        ])
        
        helpButton.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        helpButton.addTarget(self, action: #selector(helpSegue), for: .touchUpInside)
        headStack.addArrangedSubview(helpButton)
        if let imageView = helpButton.imageView {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 30),
                imageView.widthAnchor.constraint(equalToConstant: 30)
        ])}
       
        settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsSegue), for: .touchUpInside)
        headStack.addArrangedSubview(settingsButton)
        if let imageView = settingsButton.imageView {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 30),
                imageView.widthAnchor.constraint(equalToConstant: 30)
        ])}
        
        titleLabel.text = "Wordle"
        titleLabel.font = .boldSystemFont(ofSize: 44)
        bodyStack.addArrangedSubview(titleLabel)
        bodyStack.setCustomSpacing(50, after: titleLabel)
        
        let mainContentStack = UIStackView()
        mainContentStack.axis = .vertical
        mainContentStack.alignment = .center
        bodyStack.addArrangedSubview(mainContentStack)
        
        let textField = UITextField()
        textField.placeholder = "Enter your guess"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(handleFieldChange(_:)), for: .editingChanged)
        mainContentStack.addArrangedSubview(textField)
        mainContentStack.setCustomSpacing(24, after: textField)
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 220)
        ])
        
        tileTable.axis = .vertical
        tileTable.spacing = 8
        mainContentStack.addArrangedSubview(tileTable)
        mainContentStack.setCustomSpacing(60, after: tileTable)
        
        for _ in 0..<6 {
            let tileRow = UIStackView()
            tileRow.spacing =  8
            tileTable.addArrangedSubview(tileRow)
            
            for _ in 0..<5 {
                let tile = UILabel()
                tile.backgroundColor = .systemGray
                tile.textColor = .white
                tile.font = .systemFont(ofSize: 48)
                tile.textAlignment = .center
                tileRow.addArrangedSubview(tile)
                tile.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    tile.heightAnchor.constraint(equalToConstant: 64),
                    tile.widthAnchor.constraint(equalToConstant: 64)
        ])}}
        
        deadLettersLabel.text = "Dead letters:"
        mainContentStack.addArrangedSubview(deadLettersLabel)
        
        isDarkMode = isDarkMode || false
        
        game = Game()
        print(game.answer!)
    }
    
    @objc func helpSegue() { present(HelpViewController(), animated: true) }
    
    @objc func settingsSegue() { present(SettingsViewController(), animated: true) }
    
    func updateRow(_ rowIndex: Int, letters: [String], colors: [UIColor]) {
        let row = tileTable.arrangedSubviews[rowIndex] as! UIStackView
        let tiles = row.arrangedSubviews as! [UILabel]
        
        for ((tile, letter), color) in zip(zip(tiles, letters), colors) {
            tile.text = letter
            tile.backgroundColor = color
        }
    }
    
    func addDeadLetters(_ letters: [String]) {
        for letter in letters {
            guard !deadLetters.contains(letter) else { continue }
            deadLetters.append(letter)
    }}
    
    @objc func handleFieldChange(_ sender: UITextField) {
        let guess = sender.text!.uppercased()
        sender.text = guess
        guard !deadLetters.contains(String(guess.suffix(1))) && guess.count <= 5 else {
            sender.text = String(guess.prefix(guess.count - 1))
            return
        }
        updateRow(game.turn, letters: toArray(guess), colors: [.systemGray, .systemGray, .systemGray, .systemGray, .systemGray])
        
        guard guess.count >= 5 && Game.isWord(word: guess) else { return }
        
        sender.text = ""

        let (isCorrect, status, guessDeadLetters) = game.guess(word: guess)
        updateRow(game.turn - 1, letters: toArray(guess), colors: toColors(status: status))
        
        guard isCorrect || game.isGameOver() else {
            addDeadLetters(guessDeadLetters)
            return
        }
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(reset), userInfo: nil, repeats: false)
    }
    
    func toColors(status: [TileStatus]) -> [UIColor] {
        var colors: [UIColor] = []
        
        for state in status {
            switch state {
                case .rightPlace:
                    colors.append(.systemGreen)
                    break
                    
                case .rightLetter:
                    colors.append(.systemYellow)
                    break
                    
                default:
                    colors.append(.systemGray)
        }}
        return colors
    }
    
    @objc func reset() {
        for i in 0..<6 { updateRow(i, letters: ["", "", "", "", "", ""], colors: [.systemGray, .systemGray, .systemGray, .systemGray, .systemGray, .systemGray]) }
        
        deadLetters = []
        game = Game()
    }
}
