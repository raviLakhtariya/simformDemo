//
//  Extension+UIViewController.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//

import UIKit
extension UIViewController {
    func toast(_ message : String, duration seconds: Double = 3 , backGroundColor : UIColor = UIColor.black ,textColor : UIColor = UIColor.white) {
        let toastView = UILabel()
        toastView.backgroundColor = backGroundColor //UIColor.white//.withAlphaComponent(0.7)
        toastView.textColor =  textColor//UIColor.black
        toastView.textAlignment = .center
        toastView.font = UIFont.preferredFont(forTextStyle: .caption1)
        toastView.layer.cornerRadius = 25
        toastView.layer.masksToBounds = true
        toastView.text = message
        toastView.numberOfLines = 0
        toastView.alpha = 0
        toastView.translatesAutoresizingMaskIntoConstraints = false

        var window : UIWindow?
        if let windowTmp = UIApplication.shared.delegate?.window {
            window = windowTmp
            window?.addSubview(toastView)
        }else if let windowTmp = UIApplication.shared.windows.first{
            window = windowTmp
            window?.addSubview(toastView)
        }else{
            return
        }
        
        let horizontalCenterContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0)
        
        
        let widthContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant:  (toastView.intrinsicContentSize.width + 50))
        
        let verticalContraint: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=200)-[loginView(==50)]-68-|", options: [.alignAllCenterX, .alignAllCenterY], metrics: nil, views: ["loginView": toastView])
        
        NSLayoutConstraint.activate([horizontalCenterContraint, widthContraint])
        NSLayoutConstraint.activate(verticalContraint)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            toastView.alpha = 1
        }, completion: nil)
        
        //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: {
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                toastView.alpha = 0
            }, completion: { finished in
                toastView.removeFromSuperview()
            })
        })
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
        
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIView {
    var topSafeAreaInset: CGFloat {
        let window = UIApplication.shared.keyWindow
        var topPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            topPadding = window?.safeAreaInsets.top ?? 0
        }

        return topPadding
    }
    

    var bottomSafeAreaInset: CGFloat {
        let window = UIApplication.shared.keyWindow
        var bottomPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            bottomPadding = window?.safeAreaInsets.bottom ?? 0
        }

        return bottomPadding
    }
        func dropShadow(scale: Bool = true) {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowOffset = CGSize(width: -1, height: 1)
            layer.shadowRadius = 1
            layer.shouldRasterize = true
            layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
    
}
extension UIButton {

    func alignTextBelow(spacing: CGFloat = 6.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)//UIEdgeInsetsMake(spacing, -imageSize.width, -(imageSize.height), 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)//UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
        }
    }

}
extension UICollectionView {
    func reloadData(_ completion: @escaping () -> Void) {
        reloadData()
        DispatchQueue.main.async { completion() }
    }
}
extension UITextView{
    func setupBorder(){
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
    }
}
extension UITextField{
    func setupBorder(){
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
    }
}
