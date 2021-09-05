//
//  ScoreViewModel.swift
//  RacingCarGame
//
//  Created by Admin on 5.09.21.
//

import Foundation
import RxSwift
import RxCocoa

class ScoreViewModel: ScoreViewModelProtocol {

    var dataSource = BehaviorSubject<[ItemModel]> (value: [])
}
