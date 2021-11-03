//
//  ProfieViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/19/21.
//

import Foundation
class  ProfileViewModel: ObservableObject {

    @Published var fname : String = ""
    @Published var sname : String = ""
    @Published var district : String = ""
    @Published var delivery_address : String = ""
    @Published var mail : String = ""
    @Published var phone : String = ""
    
    init() {
        setData()
    }
    
    
    func setData(){
        
        let user : CustomerDetailsResponse? = loadUser()
        
        fname = user?.firstName ?? ""
        sname = user?.lastName ?? ""
        district = user?.billing.state ??  ""
        delivery_address = user?.billing.address1 ?? ""
        mail = user?.email ?? ""
        phone = user?.billing.phone ?? ""
        
        
    }
    func isdeliverAddressEmpty() -> Bool {
       
        return false
    }
    
}
