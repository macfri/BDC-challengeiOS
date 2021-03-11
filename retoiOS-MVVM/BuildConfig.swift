import Foundation


struct BuildConfig {

    static func ApiKey() -> String { return "3ce7c621d2350bf13d2f250741a370eb" }
    
    static func ServerName() -> String { return "https://api.themoviedb.org/3/" }
    
    static func waitRequestToken() -> Int { return 60 } // seconds

}
