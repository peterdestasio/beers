//
//  HeaderView.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import UIKit

@IBDesignable
final class HeaderView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
