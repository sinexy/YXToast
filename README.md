# YXToast

一个简洁的 toast 提示控件

* 提示框自动消失
`class func showToast(_ message: String)`
* 提供一个时间，到时自动消失
`class func showToast(_ message: String, duration: TimeInterval) `
* 展示一个指示器，不会自动消失    
`class func showIndicate()`
* 带文本的指示器，不会自动消失
`class func showIndicate(_ message: String?)`
* 关闭指示器
`class func hideToast()` 
**有对应的实例方法**

由两部分组成：
* YXToast
* YXIndicateView


