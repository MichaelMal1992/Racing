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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
