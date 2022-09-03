//
//  Extensions.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

//MARK: - UITableView
public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}

//MARK: - UICollectionView
public extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
}

//MARK: - Arrays
public extension Collection where Indices.Iterator.Element == Index {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript (safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

//MARK: - UIApplication
public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter({
                $0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}

//MARK: - UIViewController
extension UIViewController {
    
    /// Adds shadows bottom of navigation bar.
    func applyShadowInNavigation() {
        self.navigationController?.navigationBar.layer.shadowPath = UIBezierPath(rect: self.navigationController?.navigationBar.bounds ?? .zero).cgPath
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.50)
            .cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
    }

    /// Method apply color on the status and navBar. **The Status Bar text color sets white according to the choose.** In addition, the tint color will sets white.
    func applyColorStatusBar(color: UIColor, whiteTextColor: Bool) {
     
        if #available(iOS 13.0, *) {
            let style: UIUserInterfaceStyle = whiteTextColor ? .dark : .light
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = color
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.overrideUserInterfaceStyle = style
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.titleTextAttributes = [.font : UIFont.systemFont(ofSize: 16, weight: .semibold)]
        } else {
            guard let navBar = navigationController?.navigationBar else { return }
            navBar.barStyle = whiteTextColor ? .black : .default
            navBar.barTintColor = color
        }
    }
    
    /// Adds title for back button of navigation.
    func addTitleForBackButton(title: String) {
        let backButton = UIBarButtonItem()
        backButton.title = title
        backButton.tintColor = .black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}
