# 与快捷指令 app 联动
[快捷指令（Shortcut）app](https://support.apple.com/zh-cn/guide/shortcuts/apdf22b0444c/ios) 是 Apple 在 iOS 上推出的一款 app。目前，快捷指令 app 在 iOS 中是与 SiriKit 配合使用的，允许用户创建一组自定义操作并运行。

Switshot 在 2.0 版本以后新增 SiriKit 与快捷指令联动的功能，这意味着你可以通过 Switshot 和快捷指令 app 配合：

- **在不启动 Switshot app 的情况下转移媒体**。
- **创建快捷指令自动化**，例如，在连接至 Nintendo Switch 联机网络的同时自动转移媒体。
- **将转移的媒体直接传输至其他 app**，直接分享至社交网络等位置。

::: tip
在配置快捷指令之前，建议先启动 Switshot app 完成首次媒体转移操作。
:::

## 快捷指令操作
### 从连接的主机中转移媒体
此操作运行时，Switshot 会从已连接的 Nintendo Switch 中转移媒体文件至 Switshot app 内。

::: tip
使用包含此操作的快捷指令之前，请确保你已经连接到了你希望转移媒体的 Nintendo Switch。
:::

#### 输出
一组文件（JPG 格式图片或 MP4 格式视频）。

#### 选项
同时存储至照片图库。开启此选项后，Switshot 会在转移媒体的同时，将转移的媒体文件存储至照片图库。

::: tip
Switshot 设置中的「保存副本至照片图库」的开关，与快捷指令中的「同时存储至照片图库」开关互不影响。
:::

## 在快捷指令中使用操作
若希望在快捷指令中使用 Switshot 的操作：

- 确保你的 iPhone 已经安装快捷指令 app 和 Switshot app。快捷指令 app 是 iOS 上的预装 app，但可被删除。若快捷指令 app 被删除，你需要 [前往 App Store](https://apps.apple.com/zh-cn/app/%E5%BF%AB%E6%8D%B7%E6%8C%87%E4%BB%A4/id1462947752?l=zh) 重新将其安装。
- 启动快捷指令 app，点击右上角的「+」号来创建一个新的快捷指令。
- 点击「添加操作」，在弹出的操作列表中，找到 Switshot app，然后点击希望添加的操作。
- 配置添加的操作。
- 如有需要，添加其他配合使用的操作。Switshot 中的操作可以输出一组文件，你可以用其他支持的操作来接收这组文件。
- 点击右上角的配置按钮，为快捷指令设置图标和名称。
- 确认快捷指令配置无误，点击右上角的「X」键退出编辑模式。
- 点击刚才新建的快捷指令，即可手动运行。

更详细的快捷指令配置说明，参见[《在 iPhone 或 iPad 上创建自定快捷指令》](https://support.apple.com/zh-cn/guide/shortcuts/apd84c576f8c/ios)。

## 配合快捷指令的高阶用法
### 一例：自动化
在 iOS 14 及以上版本，快捷指令 app 支持自动化操作，即在感知条件符合时自动运行快捷指令。通过该功能，可以设定在 iPhone 检测到与 Nintendo Switch 连接时，自动运行包含以上操作的快捷指令。

::: tip
Nintendo Switch 本地联机网络的名称通常以 `switch_` 开头，例如 `switch_88402D0100h`。你可以根据这个信息，在自动化中设置对应触发条件。
:::

![](/images/zh-cn/shortcut-automation.png)

你可以在 [这里](https://support.apple.com/zh-cn/guide/shortcuts/apd690170742/ios) 查看更多有关快捷指令自动化的信息。

### 一例：转移媒体的同时，将媒体分享给微信好友
部分快捷指令操作支持输出数据。你可以将对应操作输出的数据传递给其他支持对应媒体输入的操作。在此例中，Switshot 转移出的媒体文件，可以被传递给微信好友。

![](/images/zh-cn/shortcut-wechat-share.png)

## 不受限的快捷指令
不仅仅是以上所列出的例子，Switshot 配合快捷指令的使用基本上不受限制。你可以根据你自己的需求和想象力，创建任何有用、有趣的快捷指令。