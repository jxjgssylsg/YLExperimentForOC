//
//  ProvisioningCodeSigning.h
//  YLExperimentForOC
//
//  Created by Sheng,Yilin on 16/11/22.
//  Copyright © 2016年 yilin. All rights reserved.
//

#ifndef ProvisioningCodeSigning_h
#define ProvisioningCodeSigning_h
/*
 公钥：加密、派生、验证
 私钥：解密、派生、签名、解开
 
 http://blog.csdn.net/phunxm/article/details/42685597
 
 iOS Provisioning Profile(Certificate)与Code Signing详解
 
 关于开发证书配置（Certificates & Identifiers & Provisioning Profiles），相信做 iOS 开发的同学没少被折腾。对于一个 iOS 开发小白、半吊子（比如像我自己）抑或老兵，或多或少会有或曾有过以下不详、疑问、疑惑甚至困惑：
 
 什么是 App ID？Explicit/Wildcard App ID有何区别？什么是App Group ID？
 什么是证书（Certificate）？如何申请？有啥用？
 什么是 Key Pair（公钥/私钥）？有啥用？与证书有何关联？
 什么是签名（Signature）？如何签名（CodeSign）？怎样校验（Verify）？
 什么是（Team）Provisioning Profiles？有啥用？
 Xcode 如何配置才能使用 iOS 真机进行开发调试？
 多台机器如何共享开发者账号或证书？
 遇到证书配置问题怎么办？
 Xcode 7 免证书调试真机调试
 
 本文将围绕相关概念及背景做个系统的梳理串烧，于条分缕析中对证书体系进行抽丝剥茧，逐步揭开签名机制的神秘面纱。图穷匕首见，水落而石出，包教不包会，不会请再来。
 从 Xcode 7 开始支持普通 Apple 账号进行免证书真机调试，详情参考最新官方文档《Launching Your App on Devices》，或参考本文最后一节简介。
 
 写在前面
 1.假设你使用过 Apple 设备（iMac/iPad/iPhone）且注册过 Apple ID（Apple Account），详情参考《创建和开始使用 Apple ID》。
 2.假设你或你所在的开发组已加入苹果开发者计划（Enroll in iOS Developer Program to become a member），即已注册开发者账号（Apple Developer Account）。
 只有拥有开发者账号，才可以申请开发/发布证书及相关配置授权文件，进而在 iOS 真机上开发调试 Apps 或发布到 App Store。
 开发者账号分为 Individual 和 Company/Organization 两种类型。如无特别交代，下文基于 $99/Year 的普通个人开发者（Individual）账号展开。
 3.若要真机调试实践，你必须至少拥有一台装有 Mac OS X/Xcode 的 Mac 开发机（iMac or MacBook），其上自带原生的 Keychain Access
 
 App ID（bundle identifier）
 在苹果官方的开发者计划（Apple Developer Member Center）层面，App ID 即 Product ID，用于标识一个或者一组 App。
 在 Mac/iOS 开发语境中，bundle（捆绑） 是指一个内部结构按照标准规则组织的特殊目录。在 Mac OS 应用程序目录下的某个 *.app 上可右键显示包内容（Contents），其本质上就是可执行二进制文件（MacOS/）及其资源（Resources/）的打包组合。因此，在 Xcode 中配置的 Bundle Identifier 必须和 App ID 是一致的（Explicit）或匹配的（Wildcard）。
 App ID 字符串通常以反域名（reverse-domain-name）格式的 Company Identifier（Company ID）作为前缀（Prefix/Seed），一般不超过 255 个 ASCII 字符。
 App ID 全名会被追加 Application Identifier Prefix（一般为 TeamID.），分为两类：
 Explicit App ID：唯一的 App ID，用于唯一标识一个应用程序。例如“com.apple.garageband”这个 App ID，用于标识 Bundle Identifier 为“com.apple.garageband”的 App。
 Wildcard App ID：含有通配符的 App ID，用于标识一组应用程序。例如“*”（实际上是 Application Identifier Prefix）表示所有应用程序；而“com.apple.*”可以表示 Bundle Identifier 以“com.apple.”开头（苹果公司）的所有应用程序。
 用户可在 Developer Member Center 网站上注册（Register）或删除（Delete）已注册的 App IDs。
 App ID 被配置到【XcodeTarget|Info|Bundle Identifier】下；对于 Wildcard App ID，只要 bundle identifier 包含其作为 Prefix/Seed 即可。。
 
 二.设备（Device）
 Device 就是运行 iOS 系统用于开发调试 App 的设备。每台 Apple 设备使用 UDID (Unique Device Identifier）来唯一标识。
 iOS 设备连接 Mac 后，可通过 iTunes->Summary 或者 Xcode->Window->Devices 查看其UDID。
 Apple Member Center 网站个人账号下的 Devices 中包含了注册过的所有可用于开发和测试的设备，普通个人开发账号每年累计最多只能注册100个设备。
 Apps signed by you or your team run only on designated development devices.
 Apps run only on the test devices you specify.
 用户可在网站上注册或启用/禁用（Enable/Disable）已注册的Device。
 本文的 Devices 是指连接到 Xcode 被授权用于开发测试的iOS设备（iPhone/iPad）。
 
 # 开发证书（Certificates） #
 
 数字证书就是互联网通讯中标志通讯各方身份信息的一串数字，提供了一种在 Internet 上验证通信实体身份的方式，其作用类似于司机的驾驶执照或日常生活中的身份证。它是由一个由权威机构——CA机构，又称为证书授权中心（Certificate Authority）发行的，人们可以在网上用它来识别对方的身份。
 数字证书是一个经证书授权中心数字签名的包含公开密钥拥有者信息以及公开密钥的文件。最简单的证书包含一个公开密钥、名称以及证书授权中心的数字签名。
 数字证书还有一个重要的特征就是时效性：只在特定的时间段内有效。
 
 数字证书中的公开密钥（公钥）相当于公章。 // 公钥相当于公章
 
 
 某一认证领域内的根证书是 CA 认证中心给自己颁发的证书，是信任链的起始点。安装根证书意味着对这个 CA 认证中心的信任。
 
 在天朝子民的一生中，户籍证明可理解为等效的根证书：有了户籍证明，才能办理身份证；有了上流的身份证，才能办理下游居住证、结婚证、计划生育证、驾驶执照等认证。
 
 
 # 3.iOS（开发）证书 #
 普通个人开发账号最多可注册 iOS Development/Distribution 证书各2个，用户可在网站上删除（Revoke）已注册的 Certificate。
 
 注. 下文主要针对 iOS App 开发调试过程中的开发证书（Certificate for Development）。
 
 # 4.iOS（开发）证书的根证书 #
 
 那么，iOS 开发证书是谁颁发的呢？或者说我们是从哪个 CA 申请到用于 Xcode 开发调试 App 的证书呢？
 iOS 以及 Mac OS X 系统（在安装 Xcode 时）将自动安装 AppleWWDRCA.cer 这个中间证书（Intermediate Certificates），它实际上就是 iOS（开发）证书的证书，即根证书（Apple Root Certificate）。
 AppleWWDRCA（Apple Root CA）类似注册管理户籍的公安机关户政管理机构，AppleWWDRCA.cer 之于 iOS（开发）证书则好比户籍证之于身份证。
 
 # 申请证书（CSR：Certificate Signing Request） #
 可以在缺少证书时通过 Xcode Fix Issue 自动请求证书，但是这会掩盖其中的具体流程细节。这里通过 Keychain 证书助理从证书颁发机构请求证书：填写开发账号邮件和常用名称，勾选【存储到磁盘】。
 
 公钥：加密、派生、验证
 私钥：解密、派生、签名、解开
 
 Keychain Access|Keys 中将新增一对非对称密钥对 Public/Private Key Pair（This signing identity consists of a public-private key pair that Apple issues）。同时，keychain 将生成一个包含 #开发者身份信息# 和 #公钥# 的CSR（Certificate Signing Request）文件——CertificateSigningRequest.certSigningRequest。
 
 私钥 private key 始终保存在 Mac OS 的 Keychain Access 中，用于签名（CodeSign）本机对外发布的 App；公钥 public key 一般随证书（随 Provisioning Profile，随App）散布出去，对 App 签名 [私钥签名] 进行校验认证。用户必须妥善保存本地 Keychain 中的 private key，以防伪冒。
 
 在 Apple 开发网站上传包含公钥的 CSR 文件作为换取证书的凭证（Upload CSR file to generate your certificate），有点类似为 github 账号添加 SSH 公钥到服务器上进行授权。
 
 Apple 证书颁发机构 WWDRCA (Apple Worldwide Developer Relations Certification Authority) 将使用其 private key 对 CSR 中的 public key 和一些身份信息进行加密签名生成数字证书（ios_development.cer）并记录在案（Apple Member Center）。 注.  WWDRCA 用他的“私钥”签名，生成 #数字证书# ！还记得数字证书吗！
 
 从 Apple Member Center 网站下载证书到 Mac 上双击即可安装（当然也可在 Xcode 中添加开发账号自动同步证书和[生成]配置文件）。证书安装成功后，在 KeychainAccess|Keys 中展开创建 CSR 时生成的 Key Pair 中的私钥前面的箭头，可以查看到包含其对应公钥的证书（Your requested certificate will be the public half of the key pair.）；在 Keychain Access|Certificates 中展开安装的证书（ios_development.cer）前面的箭头，可以看到其对应的私钥。（注. 私钥应该是证书里面的所包含的公钥对应的，即是当时 CSR 中所包含的公钥）！
 
 # 四.供应配置文件（Provisioning Profiles） #
 1.Provisioning Profile 的概念
 Provisioning Profile 文件包含了上述的所有内容：证书、App ID 和 设备 ID。
 
 Provisioning Profile 决定 Xcode 用哪个证书（公钥）/私钥组合（Key Pair/Signing Identity）来签署应用程序（Signing Product），并将在应用程序打包时嵌入到 .ipa 包里。安装应用程序时，Provisioning Profile 文件被拷贝到 iOS 设备中，运行该 iOS App 的设备通过它来认证安装的程序。
 如果要打包到真机上运行一个 APP，一般要经历以下三步：
	首先，需要指明它的 App ID，并且验证 Bundle ID 是否与其一致；
	其次，需要证书对应的私钥来进行签名，用于标识这个 APP 是合法、安全、完整的；
	然后，如果是真机调试，需要确认这台设备是否授权运行该 APP。
 
 Provisioning Profile 把这些信息全部打包在一起，方便我们在调试和发布程序打包时使用。这样，只要在不同的情况下选择不同的 Provisioning Profile 文件就可以了。
 
 Xcode 将全部供应配置文件（包括用户手动下载安装的和 Xcode 自动创建的 Team Provisioning Profile）放在目录 ~/Library/MobileDevice/Provisioning Profiles 下
 
 # 2.Provisioning Profile的构成 #
 以下为典型供应配置文件 *.mobileprovision 的构成简析：
 （1）Name：该 mobileprovision 的文件名。
 （2）UUID：该 mobileprovision 文件的真实文件名。
 （3）TeamName：Apple ID 账号名。
 （4）TeamIdentifier：Team Identity。
 （5）AppIDName：explicit/wildcard App ID name（ApplicationIdentifierPrefix）。
 （6）ApplicationIdentifierPrefix：完整App ID的前缀（TeamIdentifier.*）。
 （7）DeveloperCertificates：包含了可以为使用该配置文件应用签名的所有证书<data><array>。
 
 # 五.开发组供应配置文件（Team Provisioning Profiles）#
 # 五.开发组供应配置文件（Team Provisioning Profiles）#
 每个 Apple 开发者账号都对应一个唯一的 Team ID，Xcode3.2.3 预发布版本中加入了 Team Provisioning Profile 这项新功能。
 
 Team Provisioning Profile 包含一个为 Xcode iOS Wildcard App ID(*) 生成的 iOS Team Provisioning Profile:*（匹配所有应用程序），账户里所有的 Development Certificates 和 Devices 都可以使用它在这个 team 注册的所有设备上调试应用程序（不管bundle identifier是什么）。同时，它还会为开发者自己创建的 Wildcard/Explicit App IDs 创建对应的 iOS Team Provisioning Profile。

 # 六.App Group （ID）#
 扩展和其 Containing App 各自拥有自己的沙盒，虽然扩展以插件形式内嵌在 Containing App 中，但是它们是独立的二进制包，不可以互访彼此的沙盒。为了实现 Containing App 与扩展的数据共享，苹果在 iOS 8 中引入了一个新的概念——App Group，它主要用于同一 Group 下的 APP 实现数据共享，具体来说是通过创建使用以 App Group ID 标识的共享资源区——App Group Container 来实现的。
 App Group ID 同 App ID 一样，一般不超过 255个ASCII 字符。用户可在网站上编辑 Explicit App IDs，将其纳入 App Group（Assignment）；也可删除（Delete）已注册的App Group （ID）。
 
 2.App Group 的配置
 Containing App 与 Extension 的 Explicit App ID 必须 Assign 到同一 App Group 下才能实现数据共享，并且 Containing App 与 Extension 的 App ID 命名必须符合规范：
 置于同一App Group 下的 App IDs 必须是唯一的（Explicit，not Wildcard）
 Extension App ID 以 Containing App ID 为前缀（Prefix/Seed）
 
 七.证书与签名（Certificate& Signature）
 
 Xcode 中配置的 Code Signing Identity（entitlements、certificate）必须与 Provisioning Profile 匹配，并且配置的 Certificate 必须在本机 Keychain Access 中存在对应 Public／Private Key Pair，否则编译会报错。
 Xcode 所在的 Mac 设备（系统）使用 CA 证书（WWDRCA.cer）来判断 Code Signing Identity 中 Certificate 的合法性：
 若用 WWDRCA 公钥能成功解密出证书并得到公钥（Public Key）和内容摘要（Signature），证明此证书确乃 AppleWWDRCA 颁布，即证书来源可信；
 再对证书本身使用哈希算法计算摘要，若与上一步得到的摘要一致，则证明此证书未被篡改过，即证书完整。
 
 # 2.Code Signing #
 每个证书（其实是公钥）对应 Key Pair 中的私钥会被用来对内容（executable code，resources such as images and nib files aren’t signed）进行数字签名（CodeSign）——使用哈希算法生成内容摘要（digest）。
 Xcode 使用指定证书配套的私钥进行签名时需要授权，选择【始终允许】后，以后使用该私钥进行签名便不会再弹出授权确认窗口
 
 # 3.Verify Code Signature with Certificate #
 上面已经提到，#公钥# 被包含在数字证书里，数字证书又被包含在描述文件(Provisioning File)中，描述文件在应用被安装的时候会被拷贝到 iOS 设备中。
 第一步，App 在 Mac／iOS 真机上启动时，需要对配置的 bundle ID、entitlements 和 certificate 与 Provisioning Profile 进行匹配校验：
 
 第二步，iOS/Mac 真机上的 ios_development.cer 被 AppleWWDRCA.cer 中的 public key 解密校验合法后，获取每个开发证书中可信任的公钥对 App 的可靠性和完整性进行校验。
 
	若用证书公钥能成功验证出 App（executable bundle）的内容摘要（_CodeSignature），证明此 App 确乃认证开发者发布，即来源可信；
	再对 App（executable bundle）本身使用哈希算法计算摘要，若与上一步得到的摘要一致，则证明此 App 未被篡改过，即内容完整。
 
 # 八.在多台机器上共享开发账户/证书 #
 # 1.Xcode 导出开发者账号(*.developerprofile) 或 PKCS12 文件(*.p12) #
 进入 Xcode Preferences|Accounts：
 选中 Apple IDs 列表中对应 Account 的 Email，点击+-之后的 # 设置|Export Accounts #，可导出包含 account/code signing identity/provisioning profiles 信息的 *.developerprofile（Exporting a Developer Profile）文件供其他机器上的 Xcode 开发使用（Import 该 Account）。 // 这是导出 developerprofile
 
 选中右下列表中某行 Account Name 条目|ViewDetails，可以查看 Signing Identities 和 Provisioning Profiles。
 选中欲导出的 Signing Identity 条目，点击栏底+之后的 # 设置|Export #，必须输入密码，并需授权 export key "privateKey" from keychain，将导出 Certificates.p12。    // 这是导出 p12
 
 # 2.Keychain Access 导出 PKCS12 文件(*.p12) #
 在 Keychain Access|Certificates 中选中欲导出的 certificate 或其下 private key，右键 Export 或者通过菜单 File|Export Items 导出 Certificates.p12——PKCS12 file holds the private key and certificate。
 其他 Mac 机器上双击 Certificates.p12（如有密码需输入密码）即可安装该共享证书。有了共享证书之后，在开发者网站上将欲调试的 iOS 设备注册到该开发者账号名下，并下载对应证书授权了 iOS 调试设备的 Provisioning Profile 文件，方可在 iOS 真机设备上开发调试。   // 这是导出 p12
 
 # 九.证书配置常见错误 #
 1.no such provisioning profile was found
 Xcode Target|BuildSettings|Code Signing|当前配置的指定 UDID 的 provisioning profile 在本地不存在，此时需要更改Provisioning Profile。必要时手动去网站下载或重新生成Provisioning Profile或直接在Xcode中Fix issue予以解决（可能自动生成iOS Team ProvisioningProfile）
 
 2.No identities from profile
 
 3.Code Signing Entitlements file do not match profile
 
 4.The app ID cannot be registered to your development team
 
 5.The 'In-App Purchase' feature is only available to users enrolled in Apple Developer Program
 
 
 # 十. Xcode7+ 免证书真机调试 #
 所谓“免证书”真机调试，并不是真的不需要证书，Xcode真机调试原有的证书配置体系仍在——All iOS, tvOS, and watchOS appsmust be code signed and provisioned to launch on a device. 所以，上文啰嗦几千字还是有点用的。
 自 Xcode7 开始，原来基于付费开发者账号及自助生成证书及配置文件的繁琐过程被苹果简化，Xcode 将针对任何普通账号自动为联调真机生成所需相关的证书及配置文件。当你打算向 App Store 提交发布应用，才需要付费。
 
 第一步：进入 Xcode Preferences|Accounts，添加自己的 Apple ID 账号。
 第二步：Build Settings|Code Signing 下的 Provisioning Profile 选择 Automatic，Code Signing Identity 选择 Automatic 下的iOS Developer。
 第三步：General 配置 Bundle identifier，Team 下拉选择苹果 Member Center 自动为你的账号生成的 Personal Team ID。
 自己的账号在调试公司或其他第三方 APP 代码时，若填写 Bundle identifier 为他人账号注册的 APP ID（例如苹果相机应用 com.apple.camera），会报错：
 
 Her skill：此时，可以在他人原有 App ID 基础上添加后缀（例如com.apple.camera.extension），配置成应用的衍生插件（相当于置于同一 App Group 下）就可以快乐的玩耍了
 
 */

#endif /* ProvisioningCodeSigning_h */
