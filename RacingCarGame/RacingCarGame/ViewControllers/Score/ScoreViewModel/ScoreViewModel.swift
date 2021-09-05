//
//  ScoreViewModel.swift
//  RacingCarGame
//
//  Created by Admin on 5.09.21.
//

import Foundation
import RxSwift
import RxCocoa

class ScoreViewModel {

    var dataSource = BehaviorSubject<[PlayerData]>(value:
                                                    Players
                                                    .shared
                                                    .all
                                                    .sorted(by: { $0.scores > $1.scores }))
}
