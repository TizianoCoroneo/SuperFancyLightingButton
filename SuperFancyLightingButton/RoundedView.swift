//
//  RoundedView.swift
//  Jobbird
//
//  Created by Evgheni on 12/06/2018.
//  Copyright © 2018 DTT Multimedia. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    /// Color of the background of the button when it is enabled.
    @IBInspectable var fillColor: UIColor = .white {
        didSet {
            shapeLayer.fillColor = fillColor.cgColor
        }
    }

    /// Corner radius of the button, using `UIBezierPath` to get a smoother curvature.
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet { setNeedsLayout() }
    }

    /// Color of the border of the button.
    @IBInspectable var borderColor: UIColor = .clear {
        didSet { shapeLayer.strokeColor = borderColor.cgColor }
    }

    /// Width of the border of the button.
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { shapeLayer.lineWidth = borderWidth }
    }

    /// Extra translation of the shadow of the button on the X axis.
    @IBInspectable var shadowOffsetX: CGFloat = 0 {
        didSet { shapeLayer.shadowOffset = shadowOffset }
    }

    /// Extra translation of the shadow of the button on the Y axis.
    @IBInspectable var shadowOffsetY: CGFloat = 5 {
        didSet { shapeLayer.shadowOffset = shadowOffset }
    }

    /// Opacity of the shadow of the button. 0 is transparent, 1 is opaque.
    @IBInspectable var shadowOpacity: Float = 0.15 {
        didSet { shapeLayer.shadowOpacity = shadowOpacity }
    }

    /// Radius of the shadow for the button.
    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet { shapeLayer.shadowRadius = shadowRadius }
    }

    /// Internal utility to construct the shadow offset from the `IBInspectable` properties.
    private var shadowOffset: CGSize {
        return CGSize(width: shadowOffsetX, height: shadowOffsetY) }


    /// Wheter it should round the upper right corner of the view.
    @IBInspectable var roundTopRightCorner: Bool = true {
        didSet { setNeedsLayout() }
    }

    /// Wheter it should round the upper left corner of the view.
    @IBInspectable var roundTopLeftCorner: Bool = true {
        didSet { setNeedsLayout() }
    }

    /// Wheter it should round the bottom right corner of the view.
    @IBInspectable var roundBottomRightCorner: Bool = true {
        didSet { setNeedsLayout() }
    }

    /// Wheter it should round the bottom left corner of the view.
    @IBInspectable var roundBottomLeftCorner: Bool = true {
        didSet { setNeedsLayout() }
    }


    var roundCornerMask: UIRectCorner {
        let mask = UIRectCorner(rawValue: 0)

        let result: Zip2Sequence<[Bool], [UIRectCorner]> = zip(
            [
                roundTopLeftCorner,
                roundTopRightCorner,
                roundBottomLeftCorner,
                roundBottomRightCorner],
            [
                .topLeft,
                .topRight,
                .bottomLeft,
                .bottomRight
            ])

        return result.reduce(into: mask) { (acc, data) in
            if data.0 { acc.formUnion(data.1) }
        }
    }

    var bezierPath: UIBezierPath {
        return UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: roundCornerMask,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
    }

    /// The class of the base layer inside the button's view.
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    /// Internal utility to retrieve the base layer as a shape layer without casting it everytime.
    private var shapeLayer: CAShapeLayer {
        return self.layer as! CAShapeLayer
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        self.shapeLayer.fillColor = self.fillColor.cgColor

        self.shapeLayer.strokeColor = self.borderColor.cgColor
        self.shapeLayer.lineWidth = borderWidth

        self.shapeLayer.shadowOffset = shadowOffset
        self.shapeLayer.shadowOpacity = shadowOpacity
        self.shapeLayer.shadowRadius = shadowRadius

        self.shapeLayer.backgroundColor = UIColor.clear.cgColor
        self.shapeLayer.shadowColor = UIColor.black.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Update the shape of the button and of the shadow.
        let path = bezierPath
        shapeLayer.path = path.cgPath
        shapeLayer.shadowPath = path.cgPath
    }
}

class RoundedStackView: UIStackView {
    /// Color of the background of the button when it is enabled.
    @IBInspectable var fillColor: UIColor = .white {
        didSet {
            shapeLayer.fillColor = fillColor.cgColor
        }
    }

    /// Corner radius of the button, using `UIBezierPath` to get a smoother curvature.
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet { setNeedsLayout() }
    }

    /// Color of the border of the button.
    @IBInspectable var borderColor: UIColor = .clear {
        didSet { shapeLayer.strokeColor = borderColor.cgColor }
    }

    /// Width of the border of the button.
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { shapeLayer.lineWidth = borderWidth }
    }

    /// Extra translation of the shadow of the button on the X axis.
    @IBInspectable var shadowOffsetX: CGFloat = 0 {
        didSet { shapeLayer.shadowOffset = shadowOffset }
    }

    /// Extra translation of the shadow of the button on the Y axis.
    @IBInspectable var shadowOffsetY: CGFloat = 5 {
        didSet { shapeLayer.shadowOffset = shadowOffset }
    }

    /// Opacity of the shadow of the button. 0 is transparent, 1 is opaque.
    @IBInspectable var shadowOpacity: Float = 0.15 {
        didSet { shapeLayer.shadowOpacity = shadowOpacity }
    }

    /// Radius of the shadow for the button.
    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet { shapeLayer.shadowRadius = shadowRadius }
    }

    /// Internal utility to construct the shadow offset from the `IBInspectable` properties.
    private var shadowOffset: CGSize {
        return CGSize(width: shadowOffsetX, height: shadowOffsetY) }

    var bezierPath: UIBezierPath {
        return UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius)
    }

    /// The class of the base layer inside the button's view.
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    /// Internal utility to retrieve the base layer as a shape layer without casting it everytime.
    private var shapeLayer: CAShapeLayer {
        return self.layer as! CAShapeLayer
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    private func setup() {
        self.shapeLayer.fillColor = self.fillColor.cgColor

        self.shapeLayer.strokeColor = self.borderColor.cgColor
        self.shapeLayer.lineWidth = borderWidth

        self.shapeLayer.shadowOffset = shadowOffset
        self.shapeLayer.shadowOpacity = shadowOpacity
        self.shapeLayer.shadowRadius = shadowRadius

        self.shapeLayer.backgroundColor = UIColor.clear.cgColor
        self.shapeLayer.shadowColor = UIColor.black.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Update the shape of the button and of the shadow.
        let path = bezierPath
        shapeLayer.path = path.cgPath
        shapeLayer.shadowPath = path.cgPath
    }
}
