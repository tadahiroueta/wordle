//
//  Tile.swift
//  wordle
//
//  Created by Ueta, Lucas T on 3/22/24.
//

import UIKit

class Tile: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = .gray
    }
        
    func flipTile(to letter: String, in color: UIColor) {
        setTitle(letter, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 48)
        backgroundColor = color
    }
}
