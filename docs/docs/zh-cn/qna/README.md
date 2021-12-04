# 常见问题

## Switshot 2.0 有哪些值得一试的新功能？
除了全新的界面和媒体管理机制，[快捷指令联动功能](/zh-cn/basic/shortcut.md) 是 Switshot 2.0 的重点新功能。当然，之后会有更多有关游戏媒体管理功能的优化，敬请期待！

## 转移时有什么要求？
- 保证两台设备距离足够近。
- 两台设备都没有启用飞行模式。
- iPhone 上已正确配置有关 Switshot 的权限（[详情](/zh-cn/troubleshooting/cannot-connect-to-switch.html#确认-switshot-有对应权限)）。
- Nintendo Switch 可以处于掌机模式、桌面模式或电视模式。

## 转移过程中，有什么需要特别注意的事情？
- 蓝牙音频功能会被禁用，连接的蓝牙耳机也会被断开连接。
- 游戏网络联机功能会被禁用，正在联网的游戏会被中断连线。

## 我以前转移的媒体去哪了？
从 Switshot 2.0 开始，Switshot 加入快捷指令功能以及全新的媒体管理功能。在 Switshot 1.x 版本转移的媒体依然存在，但不能在 Switshot 2.0 中直接进行管理。

考虑该变动的影响，Switshot 2.0 依然保留 iOS 文件 app 联动功能。你可以在文件 app 中点击「我的 iPhone」，找到 Switshot 文件夹，你原来转移的媒体都会存储在这里。

在之后的版本中，Switshot 将会彻底移除文件 app 联动功能。因此，即使未来可能会推出「迁移旧媒体」功能，依然建议你在 Switshot 2.0 中妥善处理你的旧有媒体文件。

## 为什么我转移的媒体没有在文件 app 中显示？
Switshot 2.0 新增快捷指令功能，并全新设计媒体管理模式，旧有的媒体文件夹不再符合新版本的需求，因此 Switshot 2.0 不再支持在文件 app 中查看新转移的媒体；文件 app 联动功能也将会在未来被移除。

请放心，之后会推出针对游戏媒体管理的更多实用功能。

## 每次转移媒体的上限是多少？这个上限会扩充吗？
你可以在每次转移中转移最多 10 张截屏或 1 段录制，也无法同时转移截屏和录制。这个限制不是 Switshot 的人为限定，因为是任天堂为 Nintendo Switch 设置的限制。

<small>任天堂求求你了快放开限制吧，这真心不够用……</small>

## 在快捷指令中转移的媒体，会保存至 Switshot 吗？
会。你随时可以从 Switshot 中查看以往转移的所有媒体，包括从快捷指令中转移的。

## 我发现每次连接 Wi-Fi 名称不变，可以跳过扫码步骤吗？
不可以。虽然 Nintendo Switch 会在每次连接过程中使用以 `switch_` 开头（例如 `switch_88402D0100h`）的同一本地联机网络名称，但每次连接时会生成新的连接密码。另外，当你的 iPhone 连接至其他 Wi-Fi 网络时，启动 Nintendo Switch 的「发送至智能手机」功能并不会让 iPhone 自动连接至 Nintendo Switch 的本地联机网络。

即便如此，你依然可以通过这个规律，来 [创建快捷指令自动化](/zh-cn/basic/shortcut.html#%E4%B8%80%E4%BE%8B-%E8%87%AA%E5%8A%A8%E5%8C%96)，让 iPhone 在扫码并连接至 Nintendo Switch 时自动完成媒体转移操作。

## iOS 提示 Switshot 希望查找并连接至本地网络上的设备，是怎么回事？
这与 Nintendo Switch 的「发送至智能手机」以及 Switshot 的工作原理有关。当启动 Nintendo Switch「发送至智能手机」功能，Nintendo Switch 会开启一个 Wi-Fi 网络热点和一个 Web 服务器。Switshot 本质上是访问该内部网络中的服务器上的媒体资源进行转移。

因此，Switshot 需要使用 iOS「本地网络」权限，寻找并连接至 Nintendo Switch 的本地联机网络，以便获取媒体资源进行转移。

请放心，Switshot 不会在这个过程中进行用户画像、收集数据等侵犯隐私的操作。有关隐私相关的更多信息，参见隐私政策。

## M1 Mac 可以使用 Switshot 吗？
暂时不行。Nintendo Switch 禁用电脑连接至其本地联机网络。但未来 Switshot 可能会增加 macOS 版本，敬请期待。
