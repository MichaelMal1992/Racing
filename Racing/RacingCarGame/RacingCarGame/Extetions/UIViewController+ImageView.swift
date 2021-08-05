//
//  UIViewController+View.swift
//  RacingCarGame
//
//  Created by Admin on 17.06.21.
//

import UIKit

extension UIViewController {

    func configurationImageView(_ imageView: UIImageView, _ picture: UIImage, _ frame: CGRect, _ subview: UIView?) {
        imageView.image = picture
        imageView.frame = frame
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        (subview ?? view).addSubview(imageView)
    }
}
