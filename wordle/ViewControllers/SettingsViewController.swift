//
//  SettingsViewController.swift
//  wordle
//
//  Created by Ueta, Lucas T on 3/26/24.
//

import UIKit

class SettingsViewController: UIViewController {
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        let stack = addSideStack(to: view)
        
        let xButton = addXButton(to: stack)
        xButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        stack.setCustomSpacing(40, after: xButton)
        
        let settingStack = UIStackView()
        settingStack.spacing = 10
        stack.addArrangedSubview(settingStack)
        settingStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingStack.widthAnchor.constraint(equalTo: stack.widthAnchor)
        ])
        
        titleLabel.text = "Dark mode"
        settingStack.addArrangedSubview(titleLabel)
        
        let settingSwitch = UISwitch()
        settingSwitch.setOn((presentingViewController as! MainViewController).isDarkMode, animated: false)
        settingSwitch.addTarget(self, action: #selector(switchDarkMode(_:)), for: .valueChanged)
        settingStack.addArrangedSubview(settingSwitch)
        switchDarkMode(settingSwitch)
    }
    
    @objc func switchDarkMode(_ sender: UISwitch) {
        let mainViewController = presentingViewController as! MainViewController
        
        if sender.isOn {
            mainViewController.isDarkMode = true
            view.backgroundColor = .black
            titleLabel.textColor = .white
        }
        else {
            mainViewController.isDarkMode = false
            view.backgroundColor = .white
            titleLabel.textColor = .black
        }
    }
    
    @objc func goBack() { dismiss(animated: true) }
}
