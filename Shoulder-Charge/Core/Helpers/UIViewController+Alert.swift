import UIKit

extension UIViewController {
    func showNoInternetAlert() {
        let title = L10n.Network.noInternetTitle
        let message = L10n.Network.noInternetMessage
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let icon = UIImage(systemName: "wifi.exclamationmark") {
            let tintedIcon = icon.withTintColor(.red, renderingMode: .alwaysOriginal)
            
            alert.setValue(tintedIcon, forKey: "image")
        }
        
        let okAction = UIAlertAction(title: L10n.Common.ok, style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
