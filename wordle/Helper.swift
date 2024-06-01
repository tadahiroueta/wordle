//
//  Helper.swift
//  wordle
//
//  Created by Ueta, Lucas T on 3/26/24.
//

import UIKit

func addSideStack(to view: UIView) -> UIStackView {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 15
    stack.alignment = .trailing
    view.addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
    ])
    return stack
}

func addXButton(to stack: UIStackView) -> UIButton {
    let xButton = UIButton()
    xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
    xButton.tintColor = .gray
    stack.addArrangedSubview(xButton)
    xButton.translatesAutoresizingMaskIntoConstraints = false
    if let imageView = xButton.imageView {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 20)
    ])}
    return xButton
}

func toArray(_ string: String) -> [String] {
    var array: [String] = []
    for i in 1...5 {
        let prefix = string.prefix(i)
        array.append(String(prefix.suffix(1)))
    }
    return array
}

