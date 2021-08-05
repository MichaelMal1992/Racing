//
//  URL+key.swift
//  RacingCarGame
//
//  Created by Admin on 17.06.21.
//

import UIKit

extension FileManager {
    func removeFile(at URL: URL) throws {
//        self.removeFile(at: URL)
    }
    
}
private func deleteFile(_ nameFile: URL) {
    do {
        try FileManager.default.removeItem(at: nameFile)
    } catch {
        print(error.localizedDescription)
    }
}
class Asas: FileManager {
    override func removeItem(at URL: URL) throws {
        <#code#>
    }
}

enum Ased: URL {
    case asa = FileManager.defoults.appendingPathComponent("playersString")
}
