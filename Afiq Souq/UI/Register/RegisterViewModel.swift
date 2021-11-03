//
//  RegisterViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/27/21.
//
import Foundation
import Combine
class  RegisterViewModel: ObservableObject {
    @Published var test : String = " "
    @Published var prompt : String = ""
    @Published var isExpanded :Bool = false
    @Published var fname : String = ""
    @Published var sname : String = ""
    @Published var district : String = ""
    @Published var delivery_address : String = ""
    @Published var isChecked : Bool = false
    @Published var password : String = ""
    @Published var mail : String = ""
    @Published var phone : String = " "
    @Published var triggerNextPage : Bool = false

    @Published var UserFinalModel : RegRespSend!
    
    
    init(){
        self.phone = "+" + getCountryCode() + "  "
    }
    
    func CheckTheData(){
        
        
        if(fname.isEmpty || sname.isEmpty || password.isEmpty || mail.isEmpty || phone.isEmpty || district.isEmpty
            || delivery_address.isEmpty || !isChecked){
            
            prompt = "Fill The From Properly."
            
        }else {
            prompt = ""
            CreateTheUser()
        }
    }
    
    
    func getCountryCode() -> String {
        
        
//        let countryLocale = NSLocale.current
//            let countryCode = countryLocale.regionCode
//            let country = (countryLocale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode)
//            print(countryCode, country)
        
        
        
        let regCode = Locale.current.regionCode ?? ""
        
        return countries[regCode] ?? ""
    }
    
    func isdeliverAddressEmpty() -> Bool {
        if(delivery_address.isEmpty){
            return true
        }else {
            return false
        }
        
    }
    func changeTheStatrIsChecked() {
        if(isChecked){
            
            isChecked = false
        }else {
            isChecked = true
        }
        
    }
    func CreateTheUser() {
        
        let  billinModel = Inge(phone: phone, city: district, country: "Bangladesh", address1: delivery_address, lastName: sname, company: district, postcode: "34000", email: mail, address2: delivery_address ,  state: district, firstName: fname)
        
        let userModel = RegRespSend.init( shipping: billinModel ,
                                          billing : billinModel, role: "", lastName: sname, email: mail, dateModified: "", username: mail, firstName: fname, password: password)
        
    
        UserFinalModel = userModel
        
        triggerNextPage = true
        
        
//        print(" test ________>>>>" + UserFinalModel.firstName)
        
    }
}
