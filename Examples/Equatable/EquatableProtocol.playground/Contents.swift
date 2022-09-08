import UIKit

class Address: Equatable {
    let number: String
    let street: String
    let province: String

    init(_ number: String, _ street: String, _ province: String) {
        self.number = number
        self.street = street
        self.province = province
    }
    
    static func == (lhs: Address, rhs: Address) -> Bool {
        return lhs.number == rhs.number && lhs.street == rhs.street && lhs.province == rhs.province
    }
}

let addresses = [Address("123", "Sathon Road", "Bangkok"),
                 Address("456", "Sukhumvit Road", "Bangkok"),
                 Address("789", "Ratchada Road", "Bangkok")]

let invoiceAddress = Address("789", "Ratchada Road", "Bangkok")

func titleMessageFromInvoiceAddress(address: Address) -> String {
    switch address {
    case addresses[0]:
        return "Invoice address is equal to address number 1, address number: \(address.number)"
    case addresses[1]:
        return "Invoice address is equal to address number 2, address number: \(address.number)"
    case addresses[2]:
        return "Invoice address is equal to address number 3, address number: \(address.number)"
    default:
        return "Invoice addres is not equal to any adress"
    }
}
print(titleMessageFromInvoiceAddress(address: invoiceAddress))
//Invoice address is equal to address number 3, address number: 789

// Or we can do it easier by using the function below
func titleMessageFromInvoiceAddress() -> String {
    guard let indexOfAddress = addresses.firstIndex(of: invoiceAddress) else { return "Invoice addres is not equal to any adress" }

    let address = addresses[indexOfAddress]
    return "Invoice address is equal to address number \(indexOfAddress), address number: \(address.number)"
}
print(titleMessageFromInvoiceAddress(address: invoiceAddress))
//Invoice address is equal to address number 3, address number: 789
