//
//  SpinnerView.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 4.09.2022.
//

import UIKit

@IBDesignable

class Spinner: UIView {
    
    enum SpinnerStyle : Int{
        case none = 0
        case light = 1
        case dark = 2
    }
    
    var theme : SpinnerStyle = .none
    
    @IBInspectable var hidesWhenStopped : Bool = false
    
    @IBInspectable var outerCircleFillColor : UIColor = UIColor.clear
    @IBInspectable var outerCircleStrokeColor : UIColor = UIColor.clear
    @IBInspectable var outerLineWidth : CGFloat = 5.0
    @IBInspectable var outerEndStroke : CGFloat = 0.5
    @IBInspectable var outerAnimationDuration : CGFloat = 2.0
    
    @IBInspectable var enableInnerLayer : Bool = true
    
    @IBInspectable var innerCircleFillColor : UIColor  = UIColor.clear
    @IBInspectable var innerCircleStrokeColor : UIColor = UIColor.gray
    @IBInspectable var innerLineWidth : CGFloat = 5.0
    @IBInspectable var innerEndStroke : CGFloat = 0.5
    @IBInspectable var innerAnimationDuration : CGFloat = 1.6
    
    @IBInspectable var labelText : String  = ""
    @IBInspectable var labelFont : String  = "Helvetica"
    @IBInspectable var labelTextColor : UIColor  = UIColor.black
    
    @IBInspectable var labelFontSize : CGFloat = 13.0
    
    var currentInnerRotation : CGFloat = 0
    var currentOuterRotation : CGFloat = 0
    
    var innerView : UIView = UIView()
    var outerView : UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    func commonInit(){
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        
        switch theme{
        case .dark:
            outerCircleStrokeColor = UIColor.gray
            innerCircleStrokeColor = UIColor.gray
            labelTextColor = UIColor.gray
        case .light:
            outerCircleStrokeColor = UIColor ( red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1.0 )
            innerCircleStrokeColor = UIColor ( red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1.0 )
            labelTextColor = UIColor ( red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1.0 )
        case .none:
            break
        }
        
        self.addSubview(outerView)
        outerView.frame = CGRect(x: 0 , y: 0, width: rect.size.width, height: rect.size.height)
        outerView.center = self.convert(self.center, from: self.superview!)
        
        let outerLayer = CAShapeLayer()
        outerLayer.path = UIBezierPath(ovalIn: outerView.bounds).cgPath
        outerLayer.lineWidth = outerLineWidth
        outerLayer.strokeStart = 0.0
        outerLayer.strokeEnd = outerEndStroke
        outerLayer.lineCap = CAShapeLayerLineCap.round
        outerLayer.fillColor = outerCircleFillColor.cgColor
        outerLayer.strokeColor = outerCircleStrokeColor.cgColor
        outerView.layer.addSublayer(outerLayer)
        
        if enableInnerLayer{
            
            self.addSubview(innerView)
            innerView.frame = CGRect(x: 0, y: 0, width: rect.size.width - 20, height: rect.size.height - 20)
            innerView.center =  self.convert(self.center, from: self.superview!)
            let innerLayer = CAShapeLayer()
            innerLayer.path = UIBezierPath(ovalIn: innerView.bounds).cgPath
            innerLayer.lineWidth = innerLineWidth
            innerLayer.strokeStart = 0
            innerLayer.strokeEnd = innerEndStroke
            innerLayer.lineCap = CAShapeLayerLineCap.round
            innerLayer.fillColor = innerCircleFillColor.cgColor
            innerLayer.strokeColor = innerCircleStrokeColor.cgColor
            
            innerView.layer.addSublayer(innerLayer)
        }
        
        let label = UILabel()
        
        label.text = labelText
        label.textColor = labelTextColor
        label.font = UIFont(name: labelFont, size: labelFontSize)
        
        self.addSubview(label)
        if enableInnerLayer{
            label.frame.size.width = innerView.frame.size.width/1.20
            label.frame.size.height = innerView.frame.size.height
        } else {
            label.frame.size.width = outerView.frame.size.width/1.2
            label.frame.size.height = outerView.frame.size.height
        }
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.center = self.convert(self.center, from: self.superview!)
        
        self.startAnimating()
    }
    
    func animateInnerRing(){
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0 * CGFloat(Double.pi/180)
        rotationAnimation.toValue = 360 * CGFloat(Double.pi/180)
        rotationAnimation.duration = Double(innerAnimationDuration)
        rotationAnimation.repeatCount = HUGE
        self.innerView.layer.add(rotationAnimation, forKey: "rotateInner")
    }
    func animateOuterRing(){
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 360 * CGFloat(Double.pi/180)
        rotationAnimation.toValue = 0 * CGFloat(Double.pi/180)
        rotationAnimation.duration = Double(outerAnimationDuration)
        rotationAnimation.repeatCount = HUGE
        self.outerView.layer.add(rotationAnimation, forKey: "rotateOuter")
    }
    
    func startAnimating(){
        
        self.isHidden = false
        
        self.animateOuterRing()
        self.animateInnerRing()
    }
    
    func stopAnimating(){
        if hidesWhenStopped{
            self.isHidden = true
        }
        self.outerView.layer.removeAllAnimations()
        self.innerView.layer.removeAllAnimations()
        
    }
}
