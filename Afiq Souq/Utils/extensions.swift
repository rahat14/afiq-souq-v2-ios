//
//  extensions.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/6/21.
//

import Foundation
import SwiftUI
import RealmSwift

let cyanColor = UIColor(red: 0.13, green: 0.83, blue: 0.76, alpha: 1.00)
let  bottomColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
let lightGreen = UIColor(red: 0.39, green: 0.80, blue: 0.51, alpha: 1.00)
let darkBlue = UIColor(red: 0.05, green: 0.08, blue: 0.24, alpha: 1.00)
let backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
let lightCyan = UIColor(red: 0.84, green: 0.97, blue: 0.96, alpha: 1.00)
let topDeals = 325
let new_arrivals = -10
let WALLET_PAYMET_METHOD : Int  = 100
let NULL_METHOD  : Int  = 0
let CART_PAYMENT_METHOD  : Int  = 2000

let STORE_PASS  = "5FA907E4DA48684914"
let STORE_ID = "afiqsouqlive"

let TEST_STORE_PASS  = "metac5c8299fbcbb15@ssl"
let TEST_STORE_ID = "metac5c8299fbcbb15"



let PLACEHOLDER_IMG_LINK = "https://media.fdmckosovo.org/2020/07/placeholder.png"
let bdtSign  = "৳"
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


func getCartCount() -> String {
    
    var cartList : [CartDbMOdel] = []
    do{
        let realm = try Realm()
        
        
        let ingredientResults = realm.objects(CartDbMOdel.self)
        
        
        cartList =  ingredientResults.map(CartDbMOdel.init)
        
        //      setData(cartList)
        
        
        
    }
    
    catch let error {
        // Handle error
        print(error.localizedDescription)
        
    }
    
    return String(cartList.count)
}

// MARK: Load User Details from info.list

func loadUser() -> CustomerDetailsResponse? {
    let defaults = UserDefaults.standard
    if let savedPerson = defaults.object(forKey: "user") as? Data {
        let decoder = JSONDecoder()
        if let loadedPerson = try? decoder.decode(CustomerDetailsResponse.self, from: savedPerson) {
            
            return loadedPerson
        }else {
            
            return nil
        }
    }
    else {
        return nil
    }
    
    
    
}
func isFirstTimeOpening() -> Bool {
    let defaults = UserDefaults.standard
    
    if(defaults.integer(forKey: "hasRun") == 0) {
        defaults.set(1, forKey: "hasRun")
        return true
    }
    return false
    
}

func isUserLoggedin() -> Bool {
    var isLogin = false
    let user = loadUser()
    if(user == nil){
        
        isLogin = false
        
    }else {
        isLogin = true
    }
    
    return isLogin
}

func getRandomReason() -> String {
    
    let data : [String] = ["Unfortunately There is No Description Found In Server." ,
                           "There Is No Details For This Product." ,
                           "Soon The Details will be uploaded in the server",
                           "No Description For This Product" ]
    
    // let randomInt = Int.random(in: 0..<4)
    
    return "There Is No Details Available For This Product."
    
}


func ConvertHTml(htmlString : String) -> NSAttributedString {
    
    let data = htmlString.data(using: .utf8)!
    
    let attributedString = try? NSAttributedString(
        data: data,
        options: [.documentType: NSAttributedString.DocumentType.html],
        documentAttributes: nil)
    
    
    
    return attributedString!
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    
    func removeHTMLTag() -> String {
        
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
    }
    
    func getCartCount() -> String {
        var  cartList: [CartDbMOdel] = []
        do{
            let realm = try Realm()
            
            
            let ingredientResults = realm.objects(CartDbMOdel.self)
            
            
            cartList =  ingredientResults.map(CartDbMOdel.init)
            
            //      setData(cartList)
            
            
            
        }
        
        catch let error {
            // Handle error
            print(error.localizedDescription)
            
        }
        
        return String(cartList.count)
    }
    
}

func savePayment(pay : paymnetMODEL) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(pay) {
        let defaults = UserDefaults.standard
        print(pay.total)
        print("is paid  -> ")
        print(pay.isPaid)
        defaults.set(encoded, forKey: "payment")
    }
}

func currentTimeInMilliSeconds()-> String
{
    let currentDate = Date()
    let since1970 = currentDate.timeIntervalSince1970
    
    let timeStr : String  = String(Int(since1970 * 1000))
    return  timeStr
}

func loadPayment() -> paymnetMODEL? {
    let defaults = UserDefaults.standard
    if let savedPerson = defaults.object(forKey: "payment") as? Data {
        let decoder = JSONDecoder()
        if let loadedPerson = try? decoder.decode(paymnetMODEL.self, from: savedPerson) {
            
            return loadedPerson
        }else {
            
            return nil
        }
    }
    else {
        return nil
    }
    
    
    
}

let countries = ["AF":"93",
                 "AL":"355", "DZ":"213", "AS":"1", "AD":"376", "AO":"244", "AI":"1", "AG":"1", "AR":"54", "AM":"374", "AW":"297", "AU":"61", "AT":"43", "AZ":"994", "BS":"1", "BH":"973", "BD":"880", "BB":"1", "BY":"375", "BE":"32", "BZ":"501", "BJ":"229", "BM":"1", "BT":"975", "BA":"387", "BW":"267", "BR":"55", "IO":"246", "BG":"359", "BF":"226", "BI":"257", "KH":"855", "CM":"237", "CA":"1", "CV":"238", "KY":"345", "CF":"236", "TD":"235", "CL":"56", "CN":"86", "CX":"61", "CO":"57", "KM":"269", "CG":"242", "CK":"682", "CR":"506", "HR":"385", "CU":"53", "CY":"537", "CZ":"420", "DK":"45", "DJ":"253", "DM":"1", "DO":"1", "EC":"593", "EG":"20", "SV":"503", "GQ":"240", "ER":"291", "EE":"372", "ET":"251", "FO":"298", "FJ":"679", "FI":"358", "FR":"33", "GF":"594", "PF":"689", "GA":"241", "GM":"220", "GE":"995", "DE":"49",
                 "GH":"233", "GI":"350", "GR":"30", "GL":"299", "GD":"1", "GP":"590", "GU":"1", "GT":"502", "GN":"224", "GW":"245", "GY":"595", "HT":"509", "HN":"504", "HU":"36", "IS":"354", "IN":"91", "ID":"62", "IQ":"964", "IE":"353", "IL":"972", "IT":"39", "JM":"1", "JP":"81", "JO":"962", "KZ":"77", "KE":"254", "KI":"686", "KW":"965", "KG":"996", "LV":"371", "LB":"961", "LS":"266", "LR":"231", "LI":"423", "LT":"370", "LU":"352", "MG":"261", "MW":"265", "MY":"60", "MV":"960", "ML":"223", "MT":"356", "MH":"692", "MQ":"596", "MR":"222", "MU":"230", "YT":"262", "MX":"52", "MC":"377", "MN":"976", "ME":"382", "MS":"1", "MA":"212", "MM":"95", "NA":"264", "NR":"674", "NP":"977", "NL":"31", "AN":"599", "NC":"687", "NZ":"64", "NI":"505", "NE":"227", "NG":"234", "NU":"683", "NF":"672", "MP":"1", "NO":"47", "OM":"968", "PK":"92", "PW":"680", "PA":"507",
                 "PG":"675", "PY":"595", "PE":"51", "PH":"63", "PL":"48", "PT":"351", "PR":"1", "QA":"974", "RO":"40", "RW":"250", "WS":"685", "SM":"378", "SA":"966", "SN":"221", "RS":"381", "SC":"248", "SL":"232", "SG":"65", "SK":"421", "SI":"386", "SB":"677", "ZA":"27", "GS":"500", "ES":"34", "LK":"94", "SD":"249", "SR":"597", "SZ":"268", "SE":"46", "CH":"41", "TJ":"992", "TH":"66", "TG":"228", "TK":"690", "TO":"676", "TT":"1", "TN":"216", "TR":"90", "TM":"993", "TC":"1", "TV":"688", "UG":"256", "UA":"380", "AE":"971", "GB":"44", "US":"1", "UY":"598", "UZ":"998", "VU":"678", "WF":"681", "YE":"967", "ZM":"260", "ZW":"263", "BO":"591", "BN":"673", "CC":"61", "CD":"243", "CI":"225", "FK":"500", "GG":"44", "VA":"379", "HK":"852", "IR":"98", "IM":"44", "JE":"44", "KP":"850", "KR":"82", "LA":"856", "LY":"218", "MO":"853", "MK":"389", "FM":"691",
                 "MD":"373", "MZ":"258", "PS":"970", "PN":"872", "RE":"262", "RU":"7", "BL":"590", "SH":"290", "KN":"1", "LC":"1", "MF":"590", "PM":"508", "VC":"1", "ST":"239", "SO":"252", "SJ":"47", "SY":"963", "TW":"886", "TZ":"255", "TL":"670", "VE":"58", "VN":"84", "VG":"284", "VI":"340"]
