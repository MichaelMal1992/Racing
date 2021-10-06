//
//  PlayersScoresTableViewCell.swift
//  RacingCarGame
//
//  Created by Admin on 26.07.21.
//

import UIKit

class PlayersScoresTableViewCell: UITableViewCell {

    static let identifier = String(describing: PlayersScoresTableViewCell.self)

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configurationLabel(numberLabel, 30)
        configurationLabel(nameLabel, 30)
        configurationLabel(scoreLabel, 30)
        configurationLabel(dateLabel, 12)
    }

    func configure(with model: PlayerData, _ index: Int) {
        self.numberLabel.text = String(index + 1)
        self.nameLabel.text = model.name
        self.scoreLabel.text = String(model.scores)
        self.dateLabel.text = model.date

        if numberLabel.text == "1" {
            numberLabel.textColor = .systemYellow
            numberLabel.font = UIFont(name: "Verdana", size: 40)
        }
        if numberLabel.text == "2" {
            numberLabel.textColor = .lightGray
            numberLabel.font = UIFont(name: "Verdana", size: 40)
        }
        if numberLabel.text == "3" {
            numberLabel.textColor = .systemOrange
            numberLabel.font = UIFont(name: "Verdana", size: 40)
        }
    }

    private func configurationLabel(_ label: UILabel, _ size: CGFloat) {
        label.font = UIFont(name: "Marker Felt", size: size)
        label.textColor = .black
        label.backgroundColor = .clear
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = .zero
    }
}
