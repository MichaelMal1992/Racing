//
//  FileManager+URL.swift
//  RacingCarGame
//
//  Created by Admin on 17.06.21.
//

import UIKit

extension FileManager {
    func deleteFile(_ nameFileURL: URL) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: nameFileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
