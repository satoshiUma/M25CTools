//
//  Tools.swift
//  Tools
//
//  Created by satoshi_umaM1 on 2022/6/10.
//

import AudioToolbox
import CommonCrypto
import Foundation
import UIKit

public func dicValueString(_ dic: [String: Any]) -> String? {
    let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
    let str = String(data: data!, encoding: String.Encoding.utf8)
    return str
}

public func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
}

public func Tools_HttpCurrentTimeMD5() -> String {
//    return Tools_MD5_32Small("bjghyyt" + Tools_getCurrentDate())
    return Tools_MD5_32Small("bjmygh" + Tools_dateToString(date: Date())!)
}

public func changeToJson(info: Any) -> String {
    // 首先判断能不能转换
    guard JSONSerialization.isValidJSONObject(info) else {
        MCLog("json转换失败")
        return ""
    }
    // 如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
    let jsonData = try? JSONSerialization.data(withJSONObject: info, options: [])

    if let jsonData = jsonData {
        let str = String(data: jsonData, encoding: String.Encoding.utf8)
        return str ?? ""
    } else {
        return ""
    }
}

public func Tools_HttpCurrentTimeMD51() -> String {
//    return Tools_MD5_32Small("bjghyyt" + Tools_getCurrentDate())
    return Tools_MD5_32Small("yygh" + Tools_dateToString(date: Date())!)
}

/// App版本 Version
/// - Returns: 返回 版本号字符串
public func Tools_AppVersionInfo() -> String {
    let infoDictionary = Bundle.main.infoDictionary
    let app_Version = infoDictionary!["CFBundleShortVersionString"] as! String
    return app_Version
}

/// App名称
/// - Returns: 返回 App名称
public func Tools_AppName() -> String {
    let infoDictionary = Bundle.main.infoDictionary
    let appName = infoDictionary!["CFBundleDisplayName"] as! String
    return appName
}

/// App 版本号(内部标示) Build
/// - Returns: 返回 App名称
public func Tools_AppMinorVersion() -> String {
    let infoDictionary = Bundle.main.infoDictionary
    let minorVersion = infoDictionary!["CFBundleVersion"] as! String
    return minorVersion
}

/// 获取iphone版本号 (14.5)
/// - Returns: 返回 iphone版本号
public func Tools_IphoneSystemVersion() -> String {
    let iosSystemVersion = UIDevice.current.systemVersion as String // ios版本号
    return iosSystemVersion
}

/// 获取iphone UUID
/// - Returns: 返回 iphone版本号
public func Tools_IphoneUUID() -> String {
    let udid = UIDevice.current.identifierForVendor?.uuidString // 设备udid
    return udid!
}

/// 获取iphone 名称 (iOS)
/// - Returns: 返回 iphone 名称
public func Tools_IphoneName() -> String {
    let deviceName = UIDevice.current.systemName as String // 设备名称
    return deviceName
}

/// 获取iphone 型号 (iPhone)
/// - Returns: 返回 iphone型号
public func Tools_IphoneModel() -> String {
    let deviceModel = UIDevice.current.model as String // 设备型号
    return deviceModel
}

/// 获取iphone 区域化型号 (iphone)
/// - Returns: 返回 iphone区域化型号
public func Tools_IphoneLocalizedModel() -> String {
    let localizedModel = UIDevice.current.localizedModel as String // 设备区域化型号
    return localizedModel
}

/// 手机号码隐藏中间4位（中国手机号）
///
/// 中国手机号
/// - Parameter phoneNum: 要隐藏中间号码的手机号
/// - Returns: 返回 带*的手机号
public func Tools_phoneHideMiddle(phoneNum: String) -> String {
    if phoneNum.count == 11 {
        let ofStrIndex = Tools_stringFromToIndexStr(phoneNum, fromIndex: 3, endIndex: 7)
        if ofStrIndex.count == 4 {
            let endStr = Tools_stringReplac(phoneNum, ofStr: ofStrIndex, withStr: "****")
            return endStr
        } else {
            return phoneNum
        }
    } else {
        return phoneNum
    }
}

/// 简化 userDefaults 存储
///
/// 存值
/// - Parameters:
///   - content: 要存的内容
///   - key: 键
public func Tools_userDefaultsSet(content: Any!, key: String!) {
    let userDefault = UserDefaults.standard
    userDefault.set(content, forKey: key)
    userDefault.synchronize()
}

/// 简化 userDefaults 取值
///
/// 取值
/// - Parameters:
///   - key: 键
/// - Returns: 返回 String?
public func Tools_userDefaultsGetString(key: String) -> String? {
    let userDefault = UserDefaults.standard
    let tempStr = userDefault.object(forKey: key)
    return tempStr as? String
}

/// 生成随机颜色
/// - Returns: 返回随机颜色 UIColor
public func Tools_randomColor() -> UIColor {
    return UIColor(red: CGFloat(Double(arc4random_uniform(256)) / 255.0), green: CGFloat(Double(arc4random_uniform(256)) / 255.0), blue: CGFloat(Double(arc4random_uniform(256)) / 255.0), alpha: 1.0)
}

/// 生成 Int型 随机数
/// - Returns: int 随机数
public func Tools_random_Int() -> Int {
    return Int(arc4random())
}

/// 生成 Double型 随机数
/// - Returns: Double 随机数
public func Tools_random_Double() -> Double {
    return drand48()
}

/// 判断是否包含特殊字符
/// - Parameter str: 要判断的字符串
/// - Returns: true：包含特殊字符  |  false：不包含特殊字符
public func Tools_isSpecialChar(_ str: String) -> Bool {
    if Tools_isBlankString(str) { return true }
    let nameCharacters = CharacterSet(charactersIn: "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789").inverted
    let userNameRange = str.rangeOfCharacter(from: nameCharacters)
    if (userNameRange?.isEmpty) != nil { return true }
    return false
}

/// 判断仅输入字母或数字：
/// - Parameter str: 要判断的字符串
/// - Returns:  true：仅为字母或数字  |  false：不仅为字母或数字
public func Tools_isCharOrNum(_ str: String) -> Bool {
    let regex = "[a-zA-Z0-9]*"
    let pred = NSPredicate(format: "SELF MATCHES %@", regex)
    if pred.evaluate(with: str) { return true }
    return false
}

/// 判断是否是（ 汉字 英文字母  .   ·  空格）
/// - Parameter str: 要判断的字符串
/// - Returns:  true：包含  false：不包含
public func isChineseAndEnglishCharacter(_ str: String) -> Bool {
    let regex = "^[\\u4E00-\\u9FEA\\ \\u0041-\\u005A\\ \\u0061-\\u007A\\ \\.\\·]+$"
    let pred_regex = NSPredicate(format: "SELF MATCHES %@", regex)
    if pred_regex.evaluate(with: str) {
        return true
    }
    return false
}

/// 判断是否是有效证件号号
/// - Parameter IDCardStr: 有效证件号Str
/// - Returns: Bool
public func Tools_isIDCard(_ IDCardStr: String) -> Bool {
    var flag: Bool
    if IDCardStr.count <= 0 {
        flag = false
        return flag
    }
    let regex2 = "^(\\d{14}|\\d{17})(\\d|[xX])$"
    let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@", regex2)
    let isIdentityCard = identityCardPredicate.evaluate(with: IDCardStr)
    return isIdentityCard
}

/// 判断字符串为空   判空
/// - Parameter str: 要判断的字符串
/// - Returns: true：为空  |  false：不为空
public func Tools_isBlankString(_ str: String) -> Bool {
    if str.count > 0 { return false }
    if str.isEmpty { return true }
    if str.isKind(of: NSNull.self) { return true }
    if str.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 { return true }
    return false
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////  日期 Date  ////////////////////////////////////////////////////////////////////////////

/// 将 秒 转换成 时 分 秒
public func Tools_dateTimeToString(currentTimeFloat: Float64) -> String {
    let seconds = Int(currentTimeFloat) % 60
    let minutes = (Int(currentTimeFloat) / 60) % 60
    if currentTimeFloat > 3600 {
        let hours = Int(currentTimeFloat) / 3600
        return "\(hours):\(minutes):\(seconds)"
    } else {
        return "\(minutes):\(seconds)"
    }
}

/// 时间戳转 年/月/日  |  时间戳String -> 年/月/日String
///
/// 秒为单位
///  - Parameter timeIntervalString: 时间戳字符串
///  - Returns: 返回年月日
public func Tools_dateTimeIntervalString_yyyy_MM_dd(timeIntervalString: String!) -> String? {
    if Tools_isBlankString(timeIntervalString) {
        print("时间戳为空")
        return ""
    }
    // 格式化时间
    let formatter = DateFormatter()
    formatter.timeZone = NSTimeZone(name: "shanghai") as TimeZone?
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.dateFormat = "yyyy年MM月dd日"
    // 秒值转化为秒
    let date = Date(timeIntervalSince1970: Double(timeIntervalString)!)
//    let date = Date.init(timeIntervalSince1970: Double(timeString)! / 1000.0)
    let dateString = formatter.string(from: date)
    return dateString
}

///    时间戳转 年/月/日  |  时间戳String -> 年/月/日/HH/mm String
///
///    秒为单位
/// - Parameter timeIntervalString: 时间戳字符串
/// - Returns: 返回 年月日 HH:mm
public func Tools_dateTimeIntervalString_yyyy_MM_dd_HH_mm(timeIntervalString: String) -> String? {
    if Tools_isBlankString(timeIntervalString) {
        print("时间戳为空")
        return ""
    }
    // 格式化时间
    let formatter = DateFormatter()
    formatter.timeZone = NSTimeZone(name: "shanghai") as TimeZone?
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
    // 秒值转化为秒
    let date = Date(timeIntervalSince1970: Double(timeIntervalString)!)
//    let date = Date.init(timeIntervalSince1970: Double(timeString)! / 1000.0)
    let dateString = formatter.string(from: date)
    return dateString
}

/// 时间戳转 年/月/日  |  时间戳String -> 年/月/日  String
///
///    秒为单位
/// - Parameter timeIntervalString:  时间戳字符串
/// - Returns: 返回 年月日
public func Tools_dateTimeIntervalString_yyyy_MM_dd(timeIntervalString: String, formatStr: String = "yyyy年MM月dd日") -> String? {
    if Tools_isBlankString(timeIntervalString) {
        print("时间戳为空")
        return ""
    }
    // 格式化时间
    let formatter = DateFormatter()
    formatter.timeZone = NSTimeZone(name: "shanghai") as TimeZone?
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.dateFormat = formatStr
    // 秒值转化为秒
    let date = Date(timeIntervalSince1970: Double(timeIntervalString)!)
//    let date = Date.init(timeIntervalSince1970: Double(timeString)! / 1000.0)
    let dateString = formatter.string(from: date)
    return dateString
}

/// 获取 N天后 日期,默认 5 天后
///
///  (Date , N天后) 转 Date
/// - Parameters:
///   - currentDate: 当前日期
///   - day: N 天后
/// - Returns: 返回 N天后日期
public func Tools_dateNumDaysAfter(currentDate: Date, numDaysLater: NSInteger = 5) -> Date? {
    let oneDay: TimeInterval = 24 * 60 * 60
    let appointDate = currentDate.addingTimeInterval(+(oneDay * Double(numDaysLater)))
    return appointDate
}

/// 获取 N天前 日期,默认 1 天前
///
///  (Date , N天前) 转 Date
/// - Parameters:
///   - currentDate: 当前日期
///   - day: N 天后
/// - Returns: 返回 N天前日期
public func Tools_dateNumDaysBefore(currentDate: Date, numDaysLater: NSInteger = 1) -> Date? {
    let oneDay: TimeInterval = 24 * 60 * 60
    let appointDate = currentDate.addingTimeInterval(-(oneDay * Double(numDaysLater)))
    return appointDate
}

/// 获取 日期对应的星期
/// - Parameter date: 日期
/// - Returns: 返回对应的星期
public func Tools_dateToWeakStr(date: Date) -> String {
    let calendar: Calendar = Calendar(identifier: .gregorian)
    var comps: DateComponents = DateComponents()
    comps = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second], from: date)
//    let array = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
    let array = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
    let str = array[comps.weekday! - 1]
    return str
}

/// 获取当前日期
/// - Returns: 返回 date
public func Tools_getCurrentDate() -> Date {
    let date = Date(timeIntervalSinceNow: 0)
    return date
}

/// 获取当前时间戳字符串 秒
///
/// 秒
/// - Returns: 返回 秒字符串
public func Tools_getCurrentDate() -> String {
    let date = Date(timeIntervalSinceNow: 0)
    let time = date.timeIntervalSince1970
    let stringTimeStamp = String(format: "%.0f", time)
    return stringTimeStamp
}

/// 获取当前时间戳字符串 毫秒
///
/// 毫秒
/// - Returns: 返回 毫秒字符串
public func Tools_getCurrentDate1000() -> String {
    let date = Date(timeIntervalSinceNow: 0)
    let time = date.timeIntervalSince1970 * 1000 // *1000 是精确到毫秒，不乘就是精确到秒
    let stringTimeStamp = String(format: "%.0f", time)
    return stringTimeStamp
}

/// 获取当前时间戳
/// - Returns:  返回 秒 Int
public func Tools_getCurrentDateInt() -> Int {
    let date = Date(timeIntervalSinceNow: 0)
    let time = date.timeIntervalSince1970
    return Int(time)
}

/// 获取当前时间戳
/// - Returns:  返回 秒Double
public func Tools_getCurrentDateDouble() -> Double {
    let date = Date(timeIntervalSinceNow: 0)
    let time = date.timeIntervalSince1970
    return time
}

/// 获取当前时间戳
/// - Returns:  返回 毫秒Double
public func Tools_getCurrentDateDouble1000() -> Double {
    let date = Date(timeIntervalSinceNow: 0)
    let time = date.timeIntervalSince1970 * 1000
    return time
}

/// Date转时间戳
///
/// Date 转 String
/// - Parameter date: NSDate
/// - Returns: 返回 时间戳字符串
public func Tools_dateToString(date: Date) -> String? {
    let timeSp = String(format: "%.0f", date.timeIntervalSince1970)
    return timeSp
}

/// Date转时间戳
///
///  Date 转 Double
/// - Parameter date: NSDate
/// - Returns: 返回 时间戳
public func Tools_dateToDouble(date: Date) -> Int {
    return Int(date.timeIntervalSince1970)
}

/// 字符串转日期 yyyy-MM-dd
///
/// String 转 Date
/// - Parameter dateStr: "2021-5-26"
/// - Returns: 返回NSDate
public func Tools_stringToDate_yyyy_MM_dd(dateStr: String) -> Date? {
    let timeZone = TimeZone(identifier: "UTC")
    let formatter = DateFormatter()
    formatter.timeZone = timeZone
    formatter.locale = Locale(identifier: "zh_CN")
    // 注意的是下面给格式的时候,里面一定要和字符串里面的统一
    // 比如:   dateStr为2017-07-24 17:38:27   那么必须设置成yyyy-MM-dd HH:mm:ss, 如果你设置成yyyy--MM--dd HH:mm:ss, 那么date就是null, 这是需要注意的
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = formatter.date(from: dateStr)
    return date
}

/// Date 转 Date 转零点日期 2021-07-20 15:07:36 -> 2021-07-20 00:00:00
///
/// Date 转 Date 00:00:00
/// - Parameter date: 要转换的日期
/// - Returns: 返回 零点日期
public func Tools_dateToDateZero_yyyy_MM_dd(date: Date) -> Date? {
    let timeZone = TimeZone(identifier: "UTC")
    let formatter = DateFormatter()
    formatter.timeZone = timeZone
    formatter.locale = Locale(identifier: "zh_CN")
    formatter.dateFormat = "yyyy-MM-dd"
    let dateStr = formatter.string(from: date)
    let date = formatter.date(from: dateStr)
    return date
}

/// Date 转 日期Str
///
/// Date 转 String
/// - Parameter date: NSDate
/// - Returns: 返回 日期字符串
public func Tools_dateToDateString(date: Date) -> String? {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "zh_CN")
//    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.dateFormat = "yyyy-MM-dd"
    let date = formatter.string(from: date)
    return date
}

/// 字符串转日期 "yyyy-MM-dd HH:mm:ss"
///
///  String 转 Date
/// - Parameter dateStr: 日期字符串"2021-5-26 17:38:27 "
/// - Parameter format: 转换格式 yyyy-MM-dd HH:mm:ss
/// - Returns: 返回 NSDate
public func Tools_stringToDate_yyyy_MM_dd_Custom(dateStr: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
    let formatter = DateFormatter()
    // 注意的是下面给格式的时候,里面一定要和字符串里面的统一
    // 比如:   dateStr为2017-07-24 17:38:27   那么必须设置成yyyy-MM-dd HH:mm:ss, 如果你设置成yyyy--MM--dd HH:mm:ss, 那么date就是null, 这是需要注意的
    formatter.dateFormat = format
    let date = formatter.date(from: dateStr)
    return date
}

/// 字符串转日期 "yyyy-MM-dd HH:mm:ss"
///
///  String 转 Date
/// - Parameter dateStr: "2021-5-26 17:38:27 "
/// - Returns: 返回 NSDate
public func Tools_stringToDate_yyyy_MM_dd_HH_mm_ss(dateStr: String) -> Date? {
    let formatter = DateFormatter()
    // 注意的是下面给格式的时候,里面一定要和字符串里面的统一
    // 比如:   dateStr为2017-07-24 17:38:27   那么必须设置成yyyy-MM-dd HH:mm:ss, 如果你设置成yyyy--MM--dd HH:mm:ss, 那么date就是null, 这是需要注意的
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = formatter.date(from: dateStr)
    return date
}

/// 判断某个时间是否为今年
/// - Parameter date: 日期 Date
/// - Returns: 返回 Bool
public func Tools_isThisYear(date: Date) -> Bool {
    let calendar = NSCalendar.current
    let dateCmps = calendar.component(.year, from: date)
    let nowCmps = calendar.component(.year, from: Date())
    MCLog(dateCmps)
    MCLog(nowCmps)
    return dateCmps == nowCmps
}

/// 判断某个时间是否为昨天
/// - Parameter date: 日期 Date
/// - Returns: 返回 Bool
public func Tools_isYesterday(date: Date) -> Bool {
    let calendar = NSCalendar.current
    let fmt = DateFormatter()
//    let unit = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day] as Set
    fmt.dateFormat = "yyyy-MM-dd"
    let dataStr = fmt.string(from: date) // 将date yyyy-MM-dd HH:mm:ss 转成 yyyy-MM-dd
    let nowStr = fmt.string(from: Date()) // 将现在的时间 yyyy-MM-dd HH:mm:ss 转成 yyyy-MM-dd
    let dataStrDate = fmt.date(from: dataStr)
    let nowStrDate = fmt.date(from: nowStr)
    let cmps = calendar.dateComponents([.year, .month, .day], from: dataStrDate!, to: nowStrDate!)
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1
}

/// 判断某个时间是否为今天
/// - Parameter date: 日期 Date
/// - Returns: 返回 Bool
public func Tools_isToday(date: Date) -> Bool {
    let fmt = DateFormatter()
    fmt.dateFormat = "yyyy-MM-dd"
    let dataStr = fmt.string(from: date) // 将date yyyy-MM-dd HH:mm:ss 转成 yyyy-MM-dd
    let nowStr = fmt.string(from: Date()) // 将现在的时间 yyyy-MM-dd HH:mm:ss 转成 yyyy-MM-dd
    return dataStr == nowStr
}

/// 16进制的颜色值
///
/// 通过给定的颜色字符串生成指定的颜色
/// - Parameter hexadecimal: 16进制 #333333
/// - Returns: 返回 UIColor
public func Tools_colorWithHexString(_ hexadecimal: NSString) -> UIColor {
    let hexString = hexadecimal.trimmingCharacters(in: .whitespacesAndNewlines)
    let scanner = Scanner(string: hexString)

    if hexString.hasPrefix("#") {
        scanner.scanLocation = 1
    }

    var color: UInt32 = 0
    scanner.scanHexInt32(&color)

    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask

    let red = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue = CGFloat(b) / 255.0

    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}

/// 颜色转图片
///
/// 颜色值转图片
/// - Parameter color: 颜色
/// - Returns: 返回 生成的图片
public func Tools_colorToImage(_ color: UIColor) -> UIImage? {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}

/// 将现有图片改变成理想的大小
/// - Parameters:
///   - image: 原始图片
///   - toSize: 大小
/// - Returns: 新的图片
public func Tools_ImageToNewSizeImage(image: UIImage, toSize: CGSize) -> UIImage? {
    UIGraphicsBeginImageContext(toSize)
    image.draw(in: CGRect(x: 0, y: 0, width: toSize.width, height: toSize.height))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}

public func Tools_colorToImageView(_ color: UIColor, frame: CGRect) -> UIImageView? {
    let iconImage = UIImageView()
    iconImage.frame = frame
    iconImage.image = Tools_colorToImage(color)
    return iconImage
}

/// MD5
///
/// 16位小
/// - Parameter tempStr: 要加密的字符串
/// - Returns: 加密后的字符串
public func Tools_MD5_16Small(_ tempStr: String) -> String {
    guard tempStr.count > 0 else {
        print("无效的字符串")
        return ""
    }
    let cCharArray = tempStr.cString(using: .utf8)
    var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
    CC_MD5(cCharArray, CC_LONG(cCharArray!.count - 1), &uint8Array)
    let tempStr = uint8Array.reduce("") { $0 + String(format: "%02x", $1) }
    return Tools_stringFromToIndexStr(tempStr, fromIndex: 8, endIndex: 24)
}

/// MD5
///
/// 16位大
/// - Parameter tempStr: 要加密的字符串
/// - Returns: 加密后的字符串
public func Tools_MD5_16Big(_ tempStr: String) -> String {
    guard tempStr.count > 0 else {
        print("无效的字符串")
        return ""
    }
    let cCharArray = tempStr.cString(using: .utf8)
    var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
    CC_MD5(cCharArray, CC_LONG(cCharArray!.count - 1), &uint8Array)
    let tempStr = uint8Array.reduce("") { $0 + String(format: "%02X", $1) }
    return Tools_stringFromToIndexStr(tempStr, fromIndex: 8, endIndex: 24)
}

/// MD5
///
/// 32位小
/// - Parameter tempStr: 要加密的字符串
/// - Returns: 加密后的字符串
public func Tools_MD5_32Small(_ tempStr: String) -> String {
    guard tempStr.count > 0 else {
        print("无效的字符串")
        return ""
    }
    let cCharArray = tempStr.cString(using: .utf8)
    var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
    CC_MD5(cCharArray, CC_LONG(cCharArray!.count - 1), &uint8Array)
    return uint8Array.reduce("") { $0 + String(format: "%02x", $1) }
}

/// MD5
///
/// 32位大
/// - Parameter tempStr: 要加密的字符串
/// - Returns: 加密后的字符串
public func Tools_MD5_32Big(_ tempStr: String) -> String {
    guard tempStr.count > 0 else {
        print("无效的字符串")
        return ""
    }
    let cCharArray = tempStr.cString(using: .utf8)
    var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
    CC_MD5(cCharArray, CC_LONG(cCharArray!.count - 1), &uint8Array)
    return uint8Array.reduce("") { $0 + String(format: "%02X", $1) }
}

/// 是否包含子字符串
/// - Parameters:
///   - str: 原始字符串
///   - substrings: 子字符串
/// - Returns: 返回 Bool ， true 包含，false 不包含
public func Tools_stringIsIncludeSubstrings(_ str: String, substrings: String) -> Bool {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return false
    }

    let source = str
    guard source.range(of: substrings) != nil else {
        return false
    }
    return true
}

/// 转成拼音
/// - Parameter str: 要转换的文字
/// - Returns: 转换后的pinyin
public func Tools_stringToPinyin(_ str: String) -> String {
    let stringRef = NSMutableString(string: str) as CFMutableString
    // 转换为带音标的拼音
    CFStringTransform(stringRef, nil, kCFStringTransformToLatin, false)
    // 去掉音标
    CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)
    let pinyin = stringRef as String
    return pinyin
}

/// 截取中间字符串
/// - Parameters:
///   - str: 原始字符串
///   - startStr: 开始字符串
///   - endStr: 结束字符串
/// - Returns: 截取后的字符串
public func Tools_stringBetween(_ str: String, start startStr: String, endStr: String) -> String {
//    let source = "<a href=\"http://weibo.com/\" rel=\"nofollow\">榜姐的iPhone客户端</a>"
//    let startRang = source.range(of:  ">")!
//    let endRang = source.range(of: "</")!
//    print(source[...startRang.lowerBound]) //  <a href="http://weibo.com/" rel="nofollow">
//    print(source[startRang.upperBound...]) //  榜姐的iPhone客户端</a>
//    print(source[startRang.upperBound..<endRang.lowerBound]) // 榜姐的iPhone客户端

    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }

    let source = str
    guard let startRang = source.range(of: startStr) else {
        print("\(#line) - \(#function) ---- startRang不存在")
        return str
    }
    guard let endRang = source.range(of: endStr) else {
        print("\(#line) - \(#function) ---- endRang不存在")
        return str
    }
//    下界lowerBound  等于 上界upperBound
    if startRang.lowerBound == endRang.upperBound {
        print("\(#line) - \(#function) ---- 没有这样的区间：下界lowerBound  等于 上界upperBound")
        return str
    }
    if startRang == endRang {
        print("\(#line) - \(#function) ---- 没有这样的区间：startRang == endRang ")
        return str
    }
    if startRang.upperBound >= endRang.lowerBound {
        print("\(#line) - \(#function) ---- 没有这样的区间：startRang.upperBound >= endRang.lowerBound")
        return str
    }

    return String(source[startRang.upperBound ..< endRang.lowerBound])
}

/// 截取字符串左侧
/// - Parameters:
///   - str: 原始字符串
///   - startStr: 从哪个字符开始截取（包含当前字符）
/// - Returns: 截取后的字符串
public func Tools_stringLeft(_ str: String, startStr: String) -> String {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }
    let source = str
    guard let startRang = source.range(of: startStr) else {
        print("\(#line) - \(#function) ---- startRang不存在")
        return str
    }
    return String(source[..<startRang.lowerBound])
}

/// 截取字符串右侧
/// - Parameters:
///   - str: 原始字符串
///   - startStr: 从哪个字符开始截取（不包含当前字符）
/// - Returns: 截取后的字符串
public func Tools_stringRight(_ str: String, startStr: String) -> String {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }
    let source = str
    guard let startRang = source.range(of: startStr) else {
        print("\(#line) - \(#function) ---- startRang不存在")
        return str
    }
    return String(source[startRang.upperBound...])
}

/// 截取 前几个 字符串
/// - Parameters:
///   - str: 原始字符串
///   - num: 截取数量
/// - Returns: 截取后的字符串
public func Tools_stringBeforeNumStr(_ str: String, num: NSInteger) -> String {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }
    return String(str.prefix(num))
}

/// 截取 后几个 字符串
/// - Parameters:
///   - str: 原始字符串
///   - num: 截取数量
/// - Returns: 截取后的字符串
public func Tools_stringAfterNumStr(_ str: String, num: NSInteger) -> String {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }
    return String(str.suffix(num))
}

/// 通过索引截取字符串 [ from ... end )
///
/// 索引从 0 开始
/// - Parameters:
///   - str: 原始字符串
///   - fromIndex: 开始始索引 包含开始索引
///   - endIndex: 结束索引 不包含结束索引
/// - Returns: 截取后的字符串
public func Tools_stringFromToIndexStr(_ str: String, fromIndex: NSInteger, endIndex: NSInteger) -> String {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }
    if str.count >= endIndex && endIndex >= 0 {
        let indexN = str.index(str.startIndex, offsetBy: fromIndex)
        let indexM = str.index(str.startIndex, offsetBy: endIndex)
        let substr = str[indexN ..< indexM]
        return String(substr)
    } else {
        return str
    }
}

/// 字符串替换 | 过滤 可以多字符替换
/// - Parameters:
///   - str: 原始字符串
///   - ofStr: 要替换的字符串
///   - withStr: 替换成什么字符串
/// - Returns: 替换后的字符串
public func Tools_stringReplac(_ str: String, ofStr: String, withStr: String) -> String {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }
    return String(str.replacingOccurrences(of: ofStr, with: withStr))
}

/// 去掉 首尾 空格
/// - Parameters:
///   - str: 原始字符串
/// - Returns: 过滤后的字符串
public func Tools_stringRemoveStartEndSpace(_ str: String) -> String {
    return String(str.trimmingCharacters(in: .whitespaces))
}

/// 分割字符串
///
/// "" 空字符串
/// - Parameters:
///   - str: 原始字符串
///   - by: 分隔符
///   - clear: 0 不清除""，1清除 ""
/// - Returns: 分割后的字符串
public func Tools_stringCutStr(_ str: String, by: String, _ clear: NSInteger = 0) -> [String] {
    let strArr = str.components(separatedBy: by)
    if clear == 1 {
        var newArr: [String] = []
        for (_, item) in strArr.enumerated() {
            if item != "" {
                newArr.append(item)
            }
        }
        return newArr
    }

    return strArr
}

/// 字符串拼接
///
/// (["1","2","3"] by:"-") 转  "1-2-3"
/// - Parameters:
///   - strArr: 字符串数组
///   - by: 拼接字符
/// - Returns: 拼接后的字符串
public func Tools_stringJoin(_ strArr: [String], by: String) -> String {
    return strArr.joined(separator: by)
}

/// 删除特定by 字符串
/// - Parameters:
///   - str: 原始字符串
///   - removeStr: 要删除的字符串
/// - Returns: 删除后的字符串
public func Tools_stringRemoveStr(_ str: String, removeStr: String) -> String {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }

    guard str.range(of: removeStr) != nil else {
        print("\(#line) - \(#function) ---- removeStr不包含")
        return str
    }

    var oldStr = str
    var newStr: String
    let range = str.range(of: removeStr)!
    oldStr.removeSubrange(range)
    newStr = oldStr
    return newStr
}

/// FromStr 之后插入字符串
/// - Parameters:
///   - str: 原始字符串
///   - FromStr: 从哪里插入
///   - by: 要插入的字符串
/// - Returns: 插入后的字符串
public func Tools_stringInsterAfterStr(_ str: String, FromStr: String, insertStr: String) -> String {
//    let str2 = "2020年新冠状病毒在全世界蔓延"
//    if let range2 = str2.range(of: "病毒") {
//        print(str2[range2]) //输出“病毒”
//        print(str2[range2.lowerBound])//输出"病"
//        print(str2[range2.upperBound])//输出"在"
//    }
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }

    guard str.range(of: FromStr) != nil else {
        print("\(#line) - \(#function) ---- 不包含FromStr字符串")
        return str
    }

    var oldStr = str
    var newStr: String
    let range = str.range(of: FromStr)!
    // 插入一段内容，两个参数：插入的起点和用来插入的内容
    oldStr.insert(contentsOf: insertStr, at: range.upperBound)
    newStr = oldStr
    return newStr
}

/// FromStr 之前插入字符串
/// - Parameters:
///   - str: 原始字符串
///   - FromStr: 从哪里插入
///   - insertStr: 要插入的字符串
/// - Returns: 插入后的字符串
public func Tools_stringInsterBeforeStr(_ str: String, FromStr: String, insertStr: String) -> String {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }

    guard str.range(of: FromStr) != nil else {
        print("\(#line) - \(#function) ---- 不包含FromStr字符串")
        return str
    }

    var oldStr = str
    var newStr: String
    let range = str.range(of: FromStr)!
    oldStr.insert(contentsOf: insertStr, at: range.lowerBound)
    newStr = oldStr
    return newStr
}

/// 只能在 FromStr 之 "前" 插入字符，不能是字符串
/// - Parameters:
///   - str: 原始字符串
///   - FromStr: 从哪个字符插入
///   - insertChar: 要插入的字符
/// - Returns: 插入后的字符串
public func Tools_stringInsterBeforeChar(_ str: String, FromStr: String, insertChar: Character) -> String {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }

    guard str.range(of: FromStr) != nil else {
        print("\(#line) - \(#function) ---- 不包含FromStr字符串")
        return str
    }
    var oldStr = str
    var newStr: String
    let range = str.range(of: FromStr)!
    oldStr.insert(insertChar, at: range.lowerBound)
    newStr = oldStr
    return newStr
}

/// 只能在 FromStr 之 "后" 插入字符，不能是字符串
/// - Parameters:
///   - str: 原始字符串
///   - FromStr: 从哪个字符插入
///   - insertChar: 要插入的字符
/// - Returns: 插入后的字符串
public func Tools_stringInsterAfterChar(_ str: String, FromStr: String, insertChar: Character) -> String {
    if str.count == 0 {
        print("\(#line) - \(#function) ---- str为空")
        return str
    }

    guard str.range(of: FromStr) != nil else {
        print("\(#line) - \(#function) ---- 不包含FromStr字符串")
        return str
    }
    var oldStr = str
    var newStr: String
    let range = str.range(of: FromStr)!
    oldStr.insert(insertChar, at: range.upperBound)
    newStr = oldStr
    return newStr
}

/// 富文本
/// - Parameters:
///   - contentStr: 文字内容
///   - fontSize: 文字大小
///   - lineSpacingSize: 行高
/// - Returns: 返回 富文本
public func Tools_stringAttributedText(contentStr: String, fontSize: CGFloat, lineSpacingSize: CGFloat, color: UIColor = UIColor.black, isModel: Bool = true) -> NSAttributedString {
    let paraStyle = NSMutableParagraphStyle()
    paraStyle.alignment = .justified
    if isModel {
        paraStyle.lineBreakMode = .byTruncatingTail
    }
    paraStyle.lineSpacing = lineSpacingSize
    let attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle: paraStyle, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
    let attrText = NSAttributedString(string: contentStr, attributes: attributes)
    return attrText
}

// public func Tools_stringAttributedTextArr(frame:CGRect,moAllText: String, fontSize: CGFloat, lineSpacingSize: CGFloat, color: UIColor = UIColor.black, isModel: Bool = true)  {
//    if Tools_isBlankString(moAllText) {
//        return
//    }
//    let paraStyle = NSMutableParagraphStyle()
//    paraStyle.alignment = .justified
//    if isModel {
//        paraStyle.lineBreakMode = .byTruncatingTail
//    }
//    paraStyle.lineSpacing = lineSpacingSize
//    let moAttributs = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle: paraStyle, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
//
//    let attributedString = NSMutableAttributedString(string: moAllText, attributes: moAttributs)
//    let ctFrameSetter = CTFramesetterCreateWithAttributedString(attributedString)
//    // 在此处，将8个间距添加到“宽度”以进行计算
//    let containerFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)
//    let path = CGPath(rect: containerFrame, transform: nil)
//    let ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRange(location: 0, length: 0), path, nil)
//    let lines: NSArray = CTFrameGetLines(ctFrame)
//    MCLog("--lineslineslineslineslineslineslineslineslineslineslineslineslineslineslineslineslineslineslineslineslineslines----\(lines)")
//    //第一行的长度小于第二行
//    var preLessLineLength = 0.0
//    for i in 0 ..< 2 {
//        let lineRange = CTLineGetStringRange(lines[i] as! CTLine)
//        preLessLineLength += Double(lineRange.length)
//    }
//    // get the first less lines of string
//    let index = moAllText.index(moAllText.startIndex, offsetBy: String.IndexDistance(preLessLineLength))
//    let preLessLineText = moAllText[...index]
////    return preLessLineText
// }

/// 返回富文本高度
/// - Parameters:
///   - text: 文本
///   - inWidth: 宽度
///   - fontSize: 文字大小
///   - lineSpacingSize: 行高
/// - Returns: 返回 富文本 高度
public func Tools_stringAttributedHeight(text: String, inWidth: CGFloat, fontSize: CGFloat = UIAdapter(14), lineSpacingSize: CGFloat = UIAdapter(2)) -> CGFloat {
    //    byWordWrapping     以单词为单位换行，以单词为单位截断
    //    byCharWrapping      以字符为单位换行，以字符为单位截断
    //    byClipping                 以单词为单位换行。以字符为单位截断
    //    byTruncatingHead    以单词为单位换行。如果是单行，则开始部分有省略号。如果是多行，则中间有省略号，省略号后面有4个字符。
    //    byTruncatingTail        以单词为单位换行。无论是单行还是多行，都是末尾有省略号。
    //    byTruncatingMiddle  以单词为单位换行。无论是单行还是多行，都是中间有省略号，省略号后面只有2个字符。
    let maxSize = CGSize(width: inWidth, height: CGFloat(MAXFLOAT))
    let paraStyle = NSMutableParagraphStyle()
    paraStyle.alignment = .justified
    paraStyle.lineBreakMode = .byWordWrapping
    paraStyle.lineSpacing = lineSpacingSize
    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: paraStyle, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
    let labelSize = NSString(string: text).boundingRect(with: maxSize, options: [.usesFontLeading, .usesLineFragmentOrigin],
                                                        attributes: attributes,
                                                        context: nil).size
    return labelSize.height
}

/// 通过给定“子串”来改变其在“母串”中的颜色及大小
/// - Parameters:
///   - str: 母串
///   - FromToStr: 要改变的子串
///   - FromColor: 要改变的子串（颜色）
///   - ToColor: 未改变的子串（颜色）
///   - FromFont: 要改变的子串（字体大小）
///   - ToFont: 未改变的其他子串（字体大小）
///   - isBold: 是否粗体
///   - isFirstIndent: 首行缩进
/// - Returns: 返回 改变后的富文本
public func Tools_stringFromToAttributedString(_ str: String,
                                               FromToStr: String,
                                               FromColor: UIColor = UIColor.black,
                                               ToColor: UIColor = UIColor.black,
                                               FromFont: CGFloat = UIAdapter(14),
                                               ToFont: CGFloat = UIAdapter(14),
                                               isBold: Bool = false,
                                               isToBold: Bool = false,
                                               isFirstIndent: CGFloat = 0,
                                               islineMode: Bool = true) -> NSMutableAttributedString {
    let paraStyle = NSMutableParagraphStyle()
    paraStyle.alignment = .justified
    paraStyle.lineSpacing = CGFloat(UIAdapter(5.0)) // 行间距
    if islineMode {
        paraStyle.lineBreakMode = .byTruncatingTail
    }
    paraStyle.headIndent = 0.0 // 行首缩进
    let emptylen = FromFont * isFirstIndent // 字体大小号字乘以2 即首行空出两个字符
    paraStyle.firstLineHeadIndent = emptylen // 首行缩进

    let mastring = NSMutableAttributedString(string: str,
                                             attributes: [NSAttributedString.Key.font: isBold ? UIFont.boldSystemFont(ofSize: CGFloat(ToFont)) : UIFont.systemFont(ofSize: CGFloat(ToFont)),
                                                          NSAttributedString.Key.foregroundColor: ToColor,
                                                          NSAttributedString.Key.paragraphStyle: paraStyle])
    if FromToStr.count == 0 {
        return mastring
    }
    let range = str.range(of: FromToStr)
    if range == nil {
        return mastring
    }
    mastring.addAttribute(NSAttributedString.Key.foregroundColor,
                          value: FromColor,
                          range: NSRange(range!, in: str))
    mastring.addAttribute(NSAttributedString.Key.font,
                          value: isToBold ? UIFont.boldSystemFont(ofSize: CGFloat(FromFont)) : UIFont.systemFont(ofSize: CGFloat(FromFont)),
                          range: NSRange(range!, in: str))
    return mastring
}

/// 手机振动,播放声音
/// - Parameter SID: 振动ID
/// - kSystemSoundID_Vibrate ：建立的SystemSoundID对象,标准长震动
/// - 1519： 短振动，普通短震，3D Touch 中 Peek 震动反馈
/// - 1520：普通短震，3D Touch 中 Pop 震动反馈,home 键的振动
/// - 1521：连续三次短震
/// -
/// -
/// - 1108：模拟拍照声音
/// - 1000    新邮件.caf    新邮件.caf    收到的邮件
/// - 11001    邮件发送.caf    邮件发送.caf    已发送邮件
/// - 11002    语音信箱.caf    语音信箱.caf    收到语音邮件
/// - 11003    ReceivedMessage.caf    ReceivedMessage.caf    收到短信
/// - 11004    发送消息文件    发送消息文件    发送短信
/// - 11005    警报.caf    sq_alarm.caf    日历提醒
/// - 11006    low_power.caf    low_power.caf    低电量
/// - 11007    sms-received1.caf    sms-received1.caf    SMSReceived_Alert
/// - 11008    短信接收2.caf    短信接收2.caf    SMSReceived_Alert
/// - 11009    短信接收3.caf    短信接收3.caf    SMSReceived_Alert
/// - 11010    短信接收4.caf    短信接收4.caf    SMSReceived_Alert
/// - 11011    -    -    SMSReceived_Vibrate
/// - 1012    sms-received1.caf    sms-received1.caf    SMSReceived_Alert
/// - 1013    sms-received5.caf    sms-received5.caf    SMSReceived_Alert
/// - 1014    sms-received6.caf    sms-received6.caf    SMSReceived_Alert
/// - 1015    语音信箱.caf    语音信箱.caf    -    自 2.1 起可用
/// - 1016    tweet_sent.caf    tweet_sent.caf    发送短信    自 5.0 起可用
/// - 1020    预期.caf    预期.caf    SMSReceived_Alert
/// - 1021    Bloom.caf    Bloom.caf    SMSReceived_Alert
/// - 1022    卡利普索咖啡馆    卡利普索咖啡馆    SMSReceived_Alert
/// - 1023    Choo_Choo.caf    Choo_Choo.caf    SMSReceived_Alert
/// - 1024    后裔咖啡馆    后裔咖啡馆    SMSReceived_Alert
/// - 1025    Fanfare.caf    Fanfare.caf    SMSReceived_Alert
/// - 1026    梯子咖啡馆    梯子咖啡馆    SMSReceived_Alert
/// - 1027    小步舞曲    小步舞曲    SMSReceived_Alert
/// - 1028    新闻_Flash.caf    新闻_Flash.caf    SMSReceived_Alert
/// - 1029    黑咖啡    黑咖啡    SMSReceived_Alert
/// - 1030    Sherwood_Forest.caf    Sherwood_Forest.caf    SMSReceived_Alert
/// - 1031    拼写咖啡馆    拼写咖啡馆    SMSReceived_Alert
/// - 1032    悬疑咖啡馆    悬疑咖啡馆    SMSReceived_Alert
/// - 1033    电讯网    电讯网    SMSReceived_Alert
/// - 1034    脚尖.caf    脚尖.caf    SMSReceived_Alert
/// - 1035    打字机.caf    打字机.caf    SMSReceived_Alert
/// - 1036    更新.caf    更新.caf    SMSReceived_Alert
/// - 1050    ussd.caf    ussd.caf    USSD警报
/// - 1051    SIMToolkitCallDropped.caf    SIMToolkitCallDropped.caf    SIMToolkitTone
/// - 1052    SIMToolkitGeneralBeep.caf    SIMToolkitGeneralBeep.caf    SIMToolkitTone
/// - 1053    SIMToolkitNegativeACK.caf    SIMToolkitNegativeACK.caf    SIMToolkitTone
/// - 1054    SIMToolkitPositiveACK.caf    SIMToolkitPositiveACK.caf    SIMToolkitTone
/// - 1055    SIMToolkitSMS.caf    SIMToolkitSMS.caf    SIMToolkitTone
/// - 1057    咖啡馆    咖啡馆    PIN 键按下
/// - 1070    ct-busy.caf    ct-busy.caf    音频忙音
/// - 1071    ct-拥塞.caf    ct-拥塞.caf    音频拥塞
/// - 1072    ct-path-ack.caf    ct-path-ack.caf    AudioTonePathAcknowledge
/// - 1073    ct-error.caf    ct-error.caf    音频错误
/// - 1074    ct-call-waiting.caf    ct-call-waiting.caf    音频呼叫等待
/// - 1075    ct-keytone2.caf    ct-keytone2.caf    音调键2
/// - 1100    锁.caf    sq_lock.caf    屏幕锁定
/// - 1101    解锁.caf    sq_lock.caf    屏幕解锁
/// - 1102    -    -    解锁失败
/// - 1103    咖啡馆    sq_tock.caf    按键
/// - 1104    咖啡馆    sq_tock.caf    按键
/// - 1105    咖啡馆    sq_tock.caf    按键
/// - 1106    哔哔哔.caf    sq_beep-beep.caf    连接到电源
/// - 1107    RingerChanged.caf    RingerChanged.caf    振铃开关指示
/// - 1108    photoShutter.caf    photoShutter.caf    相机快门
/// - 1109    奶昔咖啡馆    奶昔咖啡馆    摇晃随机播放
/// - 1110    jbl_begin.caf    jbl_begin.caf    JBL_开始
/// - 1111    jbl_confirm.caf    jbl_confirm.caf    JBL_确认
/// - 1112    jbl_cancel.caf    jbl_cancel.caf    JBL_取消
/// - 1113    begin_record.caf    begin_record.caf    开始录音
/// - 1114    end_record.caf    end_record.caf    结束录音
/// - 1115    jbl_ambiguous.caf    jbl_ambiguous.caf    JBL_歧义
/// - 1116    jbl_no_match.caf    jbl_no_match.caf    JBL_NoMatch
/// - 1117    begin_video_record.caf    begin_video_record.caf    开始录像
/// - 1118    end_video_record.caf    end_video_record.caf    结束视频录制
/// - 1150    vc~invitation-accepted.caf    vc~invitation-accepted.caf    VC邀请已接受
/// - 1151    vc~ringing.caf    vc~ringing.caf    录像机振铃
/// - 1152    vc~end.caf    vc~end.caf    VC结束
/// - 1153    ct-call-waiting.caf    ct-call-waiting.caf    VCCall等待
/// - 1154    vc~ringing.caf    vc~ringing.caf    VCCall升级
/// - 1200    dtmf-0.caf    dtmf-0.caf    按键音
/// - 1201    dtmf-1.caf    dtmf-1.caf    按键音
/// - 1202    dtmf-2.caf    dtmf-2.caf    按键音
/// - 1203    dtmf-3.caf    dtmf-3.caf    按键音
/// - 1204    dtmf-4.caf    dtmf-4.caf    按键音
/// - 1205    dtmf-5.caf    dtmf-5.caf    按键音
/// - 1206    dtmf-6.caf    dtmf-6.caf    按键音
/// - 1207    dtmf-7.caf    dtmf-7.caf    按键音
/// - 1208    dtmf-8.caf    dtmf-8.caf    按键音
/// - 1209    dtmf-9.caf    dtmf-9.caf    按键音
/// - 1210     dtmf-star.caf    dtmf-star.caf    按键音
/// - 1211     dtmf-磅.caf    dtmf-磅.caf    按键音
/// - 1254    long_low_short_high.caf    long_low_short_high.caf    Headset_StartCall
/// - 1255    short_double_high.caf    short_double_high.caf    耳机_重拨
/// - 1256    short_low_high.caf    short_low_high.caf    耳机_接听电话
/// - 1257    short_double_low.caf    short_double_low.caf    Headset_EndCall
/// - 1258    short_double_low.caf    short_double_low.caf    Headset_CallWaitingActions
/// - 1259    middle_9_short_double_low.caf    middle_9_short_double_low.caf    Headset_TransitionEnd
/// - 11300    语音信箱.caf    语音信箱.caf    系统声音预览
/// - 11301    ReceivedMessage.caf    ReceivedMessage.caf    系统声音预览
/// - 11302    新邮件.caf    新邮件.caf    系统声音预览
/// - 11303    邮件发送.caf    邮件发送.caf    系统声音预览
/// - 11304    警报.caf    sq_alarm.caf    系统声音预览
/// - 11305    锁.caf    sq_lock.caf    系统声音预览
/// - 11306    咖啡馆    sq_tock.caf    按键点击预览
/// - 11307    sms-received1.caf    sms-received1.caf    SMSReceived_Selection
/// - 11308    短信接收2.caf    短信接收2.caf    SMSReceived_Selection
/// - 11309    短信接收3.caf    短信接收3.caf    SMSReceived_Selection
/// - 11310    短信接收4.caf    短信接收4.caf    SMSReceived_Selection
/// - 11311    -    -    SMSReceived_Vibrate
/// - 11312    sms-received1.caf    sms-received1.caf    SMSReceived_Selection
/// - 11313    sms-received5.caf    sms-received5.caf    SMSReceived_Selection
/// - 11314    sms-received6.caf    sms-received6.caf    SMSReceived_Selection
/// - 11315    语音信箱.caf    语音信箱.caf    系统声音预览    自 2.1 起可用
/// - 11320    预期.caf    预期.caf    SMSReceived_Selection
/// - 11321    Bloom.caf    Bloom.caf    SMSReceived_Selection
/// - 11322    卡利普索咖啡馆    卡利普索咖啡馆    SMSReceived_Selection
/// - 11323    Choo_Choo.caf    Choo_Choo.caf    SMSReceived_Selection
/// - 11324    后裔咖啡馆    后裔咖啡馆    SMSReceived_Selection
/// - 11325    Fanfare.caf    Fanfare.caf    SMSReceived_Selection
/// - 11326    梯子咖啡馆    梯子咖啡馆    SMSReceived_Selection
/// - 11327    小步舞曲    小步舞曲    SMSReceived_Selection
/// - 11328    新闻_Flash.caf    新闻_Flash.caf    SMSReceived_Selection
/// - 11329    黑咖啡    黑咖啡    SMSReceived_Selection
/// - 11330    Sherwood_Forest.caf    Sherwood_Forest.caf    SMSReceived_Selection
/// - 11331    拼写咖啡馆    拼写咖啡馆    SMSReceived_Selection
/// - 11332    悬疑咖啡馆    悬疑咖啡馆    SMSReceived_Selection
/// - 11333    电讯网    电讯网    SMSReceived_Selection
/// - 11334    脚尖.caf    脚尖.caf    SMSReceived_Selection
/// - 11335    打字机.caf    打字机.caf    SMSReceived_Selection
/// - 11336    更新.caf    更新.caf    SMSReceived_Selection
/// - 11350    -    -    RingerVibeChanged
/// - 11351     -    -    SilentVibeChanged
/// - 14095    -    -    颤动    在 2.2 之前没有此声音的类别。
public func Tools_SystemSoundID(SID: Int32 = Int32(kSystemSoundID_Vibrate)) {
    let soundID = SystemSoundID(SID)
    AudioServicesPlaySystemSound(soundID)
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////    PCH   ////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// MARK: - 获取画iPhone nav和tabbar高度

public let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

public let mc_Is_iphone = (UI_USER_INTERFACE_IDIOM() == .phone)
public let mc_Is_iphoneX = (SCREEN_WIDTH >= 375.0) && SCREEN_HEIGHT >= 812.0 && mc_Is_iphone

/// 底部导航栏 + 底部安全区
public let mcTabBarFullHeight = UIDevice.mcTabBarFullHeight()
/// 顶部导航栏 + 顶部安全区
public let mcNavFullHeight = UIDevice.mcNavFullHeight()
/// 状态栏 + 顶部安全区
public let mcNavBarAndStatusBarHeight = UIDevice.mcNavFullHeight() // (mc_Is_iphoneX ? (44.0 + STATUSBAR_HEIGHT()) : (44.0 + STATUSBAR_HEIGHT()))
/// 底部导航栏 + 底部安全区
public let mcTabBarHeight = UIDevice.mcTabBarFullHeight() // (mc_Is_iphoneX ? (49.0 + INDICATOR_HEIGHT()) : (49.0 + INDICATOR_HEIGHT()))
/// 顶部安全区高度
public let mcNavBarSafeAreaHeight = UIDevice.mcNavBarSafeAreaHeight() // (mc_Is_iphoneX ? CGFloat(44.0) : CGFloat(20.0))
/// 底部导航栏高度
public let mcTabbarSafeAreaHeight = UIDevice.mcTabbarSafeAreaHeight() // (mc_Is_iphoneX ? INDICATOR_HEIGHT() : INDICATOR_HEIGHT())
/// 导航栏高度
public let mcNavBarHeight = UIDevice.mcNavBarHeight() // CGFloat(44.0)
///  Nav 和 Tabbar 总高度
public let mcNavAndTabHeight = mcNavBarAndStatusBarHeight + mcTabBarHeight // (mcNavBarAndStatusBarHeight + mcTabBarHeight)
/// Status 高度
public let mcStatusBarHeight = STATUSBAR_HEIGHT()

// MARK: -  状态栏

public func STATUSBAR_HEIGHT() -> CGFloat {
    if #available(iOS 13.0, *) {
        let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        return (statusBarManager?.statusBarFrame.size.height)!
    } else {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        return statusBarHeight
    }
}

// MARK: -  底部指示条

public func INDICATOR_HEIGHT() -> CGFloat {
    if #available(iOS 11.0, *) {
        let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets
        return safeAreaInsets!.bottom
    } else {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0).bottom
    }
}

// MARK: - 计算 机型比例

/// 根据机型比例返回合理的数值
/// - Parameter Original: 原始值
/// - Returns: 计算后的返回值
public func UIAdapter(_ original: CGFloat) -> CGFloat {
    let scale = 375 / SCREEN_WIDTH // iphone 6
    return round(CGFloat(original) / scale) // 四舍五入
}

let lineSpaceKey = "lineSpaceKey"

public func MCLog<T>(_ message: T, file: String = #file, line: Int = #line) {
    #if DEBUG
        let filepath = (file as NSString).lastPathComponent
//        let fun = #function
        print("---------------------------- 打印开始 ----------------------------\n\(line)行 - \(filepath) - 输出:\n\(message)\n----------------------------- 结束 ------------------------------\n\n\n")
    #endif
}

extension UILabel {
    var isTruncated: Bool {
        guard let labelText = text else { return false }
        guard let font = self.font else { return false }

        let rect = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelTextSize = (labelText as NSString).boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let currentTextLines = Int(ceil(CGFloat(labelTextSize.height) / self.font.lineHeight))
        var setTextLines = Int(floor(CGFloat(bounds.size.height) / self.font.lineHeight))
        if numberOfLines != 0 {
            setTextLines = min(setTextLines, numberOfLines)
        }
//        MCLog("---------------setTextLines-----------\(setTextLines)")
//        MCLog("---------------currentTextLines-----------\(currentTextLines)")
        return currentTextLines > setTextLines
    }

    /// 返回当前的行数
    var isCurrentLines: Int {
        guard let labelText = text else { return -1 }
        guard let font = self.font else { return -1 }

        let rect = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelTextSize = (labelText as NSString).boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let currentTextLines = Int(ceil(CGFloat(labelTextSize.height) / self.font.lineHeight))
        var setTextLines = Int(floor(CGFloat(bounds.size.height) / self.font.lineHeight))
        if numberOfLines != 0 {
            setTextLines = min(setTextLines, numberOfLines)
        }
//        MCLog("---------------setTextLines-----------\(setTextLines)")
//        MCLog("---------------currentTextLines-----------\(currentTextLines)")
        return currentTextLines
    }

    var lineSpace: CGFloat? {
        set {
            objc_setAssociatedObject(self, lineSpaceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, lineSpaceKey) as? CGFloat)
        }
    }

    // label 内容行数  这的size 是label 的宽和高  lineSpace 是行间距
    public func textNumLinesWithHeight(size: CGSize) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.alignment = textAlignment
        if lineSpace == nil {
            lineSpace = 0
        }
        paragraphStyle.lineSpacing = lineSpace!
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let contentSize = text!.boundingRect(with: size, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: attributes as [NSAttributedString.Key: Any], context: nil).size
        let labelNumber = contentSize.height / font.lineHeight
        return labelNumber
    }
}

extension UIDevice {
//    /// 顶部安全区高度 1
//    static public func mcNavBarSafeAreaHeight() -> CGFloat {
//        if #available(iOS 13.0, *) {
//            let scene = UIApplication.shared.connectedScenes.first
//            guard let windowScene = scene as? UIWindowScene else { return 0 }
//            guard let window = windowScene.windows.first else { return 0 }
//            return window.safeAreaInsets.top
//        } else if #available(iOS 11.0, *) {
//            guard let window = UIApplication.shared.windows.first else { return 0 }
//            return window.safeAreaInsets.top
//        }
//        return 0;
//    }

    /// 顶部安全区高度
    public static func mcNavBarSafeAreaHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let statusBarManager = windowScene.statusBarManager else { return 0 }
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }

    /// 底部安全区高度
    public static func mcTabbarSafeAreaHeight() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            return window.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            return window.safeAreaInsets.bottom
        }
        return 0
    }

    /// 顶部导航栏高度
    public static func mcNavBarHeight() -> CGFloat {
        return 44.0
    }

    /// 底部导航栏高度
    public static func mcTabBarHeight() -> CGFloat {
        return 49.0
    }

    /// 状态栏+导航栏的高度
    public static func mcNavFullHeight() -> CGFloat {
        return UIDevice.mcNavBarSafeAreaHeight() + UIDevice.mcNavBarHeight()
    }

    /// 底部导航栏高度（包括安全区）
    public static func mcTabBarFullHeight() -> CGFloat {
        return UIDevice.mcTabBarHeight() + UIDevice.mcTabbarSafeAreaHeight()
    }
}
