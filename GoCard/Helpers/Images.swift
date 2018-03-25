// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum Asset: String {
  case aboutIcon = "About Icon"
  case addIcon = "Add Icon"
  case amazoneIcon = "Amazone Icon"
  case anneMilner = "Anne Milner"
  case anthonyNainggolan = "Anthony Nainggolan"
  case applePayButton = "Apple Pay Button"
  case applePayIcon = "Apple Pay Icon"
  case arrowCheckmarkIcon = "Arrow Checkmark Icon"
  case backIcon = "Back Icon"
  case bankTransferIcon = "Bank Transfer Icon"
  case bitmap = "Bitmap"
  case cameraIcon = "Camera Icon"
  case cameraSmallIcon = "Camera Small Icon"
  case ch = "CH"
  case chatIcon = "Chat Icon"
  case checkIcon = "Check Icon"
  case closeIconBlack = "Close Icon Black"
  case closeIconGray = "Close Icon Gray"
  case closeIconWhite = "Close Icon White"
  case cn = "CN"
  case coffeeCupIcon = "Coffee Cup Icon"
  case contactIcon = "Contact Icon"
  case creditCardIcon = "Credit Card Icon"
  case creditCard01 = "CreditCard01"
  case creditCard02 = "CreditCard02"
  case creditCard03 = "CreditCard03"
  case creditCard04 = "CreditCard04"
  case disneylandHongkong = "Disneyland Hongkong"
  case dropIconWhite = "Drop Icon White"
  case dropdownIcon = "Dropdown Icon"
  case dropdownRoundBlackIcon = "Dropdown Round Black Icon"
  case dropdownRoundIcon = "Dropdown Round Icon"
  case editIcon = "Edit Icon"
  case eu = "EU"
  case facebookMessengerIcon = "Facebook Messenger Icon"
  case facebookIcon = "Facebook_Icon"
  case feedbackIcon = "Feedback Icon"
  case filterIcon = "Filter Icon"
  case gb = "GB"
  case goCardLogo = "GoCard Logo"
  case googleIcon = "Google Icon"
  case graphTable = "Graph Table"
  case hk = "HK"
  case iMessageIcon = "iMessage Icon"
  case kh = "KH"
  case lineIcon = "Line Icon"
  case locationIcon = "Location Icon"
  case loginBackground = "Login Background"
  case logoutIcon = "Logout Icon"
  case maps = "Maps"
  case minusIcon = "Minus Icon"
  case minus = "Minus"
  case moreIcon = "More Icon"
  case optionIconActive = "Option Icon Active"
  case optionIcon = "Option Icon"
  case oval1 = "Oval 1"
  case oval2 = "Oval 2"
  case oval3 = "Oval 3"
  case oval4 = "Oval 4"
  case personFlat = "person-flat"
  case plusIcon = "Plus Icon"
  case plus = "Plus"
  case qrCodeIconActive = "QRCode Icon Active"
  case qrCodeIcon = "QRCode Icon"
  case reloadIcon = "Reload Icon"
  case resetIcon = "Reset Icon"
  case rocketIcon = "Rocket Icon"
  case roundedCameraIcon = "Rounded Camera Icon"
  case saleTagIcon = "Sale Tag Icon"
  case savingIconActive = "Saving Icon Active"
  case savingIcon = "Saving Icon"
  case searchIcon = "Search Icon"
  case sendMoneyIcon = "Send Money Icon"
  case shakeIconActive = "Shake Icon Active"
  case shakeIcon = "Shake Icon"
  case shakingImage = "Shaking Image"
  case shoppingCartIcon = "Shopping Cart Icon"
  case starbucksIcon = "Starbucks Icon"
  case storeIcon = "Store Icon"
  case switchOffIcon = "Switch Off Icon"
  case switchOn = "Switch On"
  case tabbarShadow = "Tabbar Shadow"
  case tokenIconActive = "Token Icon Active"
  case tokenIcon = "Token Icon"
  case transactionIconActive = "Transaction Icon Active"
  case transactionIcon = "Transaction Icon"
  case transferIconActive = "Transfer Icon Active"
  case transferIcon = "Transfer Icon"
  case tshirtIcon = "Tshirt Icon"
  case uploadIcon = "Upload Icon"
  case us = "US"
  case userPlaceholderIcon = "User Placeholder Icon"
  case virtualCardIconActive = "Virtual Card Icon Active"
  case virtualCardIcon = "Virtual Card Icon"
  case visaIcon = "Visa Icon"
  case walletIconActive = "Wallet Icon Active"
  case walletIcon = "Wallet Icon"
  case whatsAppIcon = "WhatsApp Icon"

  var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS) || os(watchOS)
    let image = Image(named: rawValue, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: rawValue)
    #endif
    guard let result = image else { fatalError("Unable to load image \(rawValue).") }
    return result
  }
}
// swiftlint:enable type_body_length

extension Image {
  convenience init!(asset: Asset) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.rawValue, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: asset.rawValue)
    #endif
  }
}

private final class BundleToken {}
