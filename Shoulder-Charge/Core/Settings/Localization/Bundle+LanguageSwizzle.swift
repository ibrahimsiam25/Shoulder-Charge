
import Foundation
import ObjectiveC

private var _activeLanguagePath: String?
private var languagePathKey: UInt8 = 0

final class LanguageSwizzledBundle: Bundle {
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        let storedPath = objc_getAssociatedObject(self, &languagePathKey) as? String
        if let path = storedPath, let langBundle = Bundle(path: path) {
            return langBundle.localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}


extension Bundle {

    static func setLanguage(_ language: String?) {
        if object_getClass(Bundle.main) !== LanguageSwizzledBundle.self {
            object_setClass(Bundle.main, LanguageSwizzledBundle.self)
        }

        guard let language else {
            objc_setAssociatedObject(
                Bundle.main, &languagePathKey,
                nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            return
        }

        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        objc_setAssociatedObject(
            Bundle.main, &languagePathKey,
            path, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
}
