//
//  UIViewController+Codable.swift
//  RacingCarGame
//
//  Created by Admin on 20.06.21.
//

import UIKit

extension UIViewController {

    func encodingData(_ player: [PlayerData]) -> Data {
        guard let data = try? JSONEncoder().encode(player) else {
            return Data()
        }
            return data
    }

    func decodingData(_ data: Data) -> [PlayerData] {
        guard let players = try? JSONDecoder().decode([PlayerData].self, from: data) else {
            return []
        }
            return players
    }

    func setDataValue(_ data: Data) {
        UserDefaults.standard.setValue(data, forKey: "Player_Data")
    }

    func getDataValue() -> Data {
        guard let data = UserDefaults.standard.value(forKey: "Player_Data") as? Data else {
            return Data()
        }
        return data
    }

    func setLastNameValue() {
        UserDefaults.standard.setValue(PlayersManager.shared.currentPlayer.name, forKey: "Current_Player")
    }

    func getLastNameValue() -> String {
        let lastName = UserDefaults.standard.value(forKey: "Current_Player") as? String ?? ""
        return lastName
    }

}
