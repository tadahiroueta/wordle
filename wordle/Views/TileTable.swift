//
//  TileTable.swift
//  wordle
//
//  Created by Ueta, Lucas T on 3/22/24.
//

import UIKit

class TileTable: UIStackView {
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        axis = .vertical
        spacing = 5
        
        for _ in 0..<5 {
            let row = UIStackView()
            row.spacing = 5
            addArrangedSubview(row)
            
            for _ in 0..<5 { row.addArrangedSubview(Tile())}
        }
    }

    init
//    func flipTile(to letter: String, in color: UIColor) {
//        setTitle(letter, for: .normal)
//        setTitleColor(.white, for: .normal)
//        titleLabel?.font = .boldSystemFont(ofSize: 48)
//        backgroundColor = color
//    }
}
