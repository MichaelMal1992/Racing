//
//  RealmManager.swift
//  RacingCarGame
//
//  Created by Admin on 23.08.21.
//

import Foundation
import RealmSwift

class RealmManager {

    static let shared = RealmManager()

    private let realm: Realm?

    private init() {
        do {
            self.realm = try Realm()
        } catch {
            print(error.localizedDescription)
            fatalError()
        }
    }

    func add(_ object: PlayerData) {
        do {
            try realm?.write {
                realm?.add(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    var allPlayers: [PlayerData] {
        if let player = realm?.objects(PlayerData.self) {
            return Array(player)
        }
        return []
    }

    func write(_ completion: () -> Void) {
        do {
            try realm?.write {
                completion()
           }
        } catch {
            print(error.localizedDescription)
        }
    }

    var currentPlayer: PlayerData? {
        let currentName = UserDefaults.getCurrentName()
        return realm?.objects(PlayerData.self).first(where: { $0.name == currentName })
    }

    func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
