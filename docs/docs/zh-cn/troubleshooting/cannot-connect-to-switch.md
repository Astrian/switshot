# 无法连接至游戏主机

如果遇到 Switshot 持续提示「无法连接至主机」的提示，请根据本文提供的一些简单线索进行排障。

## 确保连接步骤正确

请先根据 [必知必会中的「转移游戏媒体」部分](/zh-cn/basic/transfer.md) 中的提示，检查你的连接步骤是正确的。

::: tip
每次转移过程都需要扫描 Nintendo Switch 提供的二维码进行连接，因为 Nintendo Switch 会在每次连接过程中生成一个新的 Wi-Fi 连接密码。
:::

## 确认 Switshot 有对应权限

如果没有为 Switshot app 开启「本地网络」权限，那么 Switshot 是无法连接至 Nintendo Switch 的。

若要检查对应权限是否开启：

- 启动 Switshot app，在主界面点击右上角的「关于」按钮。
- 在弹出的「关于 Switshot」屏幕中点击「设置」。这会自动跳转至「设置」app 中 Switshot 对应设置。
- 检查「允许 Switshot 访问」部分中的「本地网络」开关是否开启。

::: tip
如果找不到这个权限开关，请先尝试其他排障方案。
:::

## 重试

有时，iOS 的网络路由不会在 iPhone 刚连接至游戏主机时，立即将 Switshot 的连接请求路由至 Nintendo Switch 主机。这种情况出现时，就会导致「无法连接至游戏主机」的提示。这是非常常见的情况。

尝试过几秒后点击提示下方出现的「重试」按钮，确保 iOS 正确处理 Switshot 的请求路由之后进行连接，之后，问题通常会自动解决。

## 关闭移动网络

也有 iOS 完全无法正确处理发往 Nintendo Switch 请求的情况出现。这时候，暂时关闭蜂窝网络可以解决这类问题。

若要关闭移动网络，请尝试以下操作之一：

- [打开控制中心](https://support.apple.com/zh-cn/HT202769)，重按（携带「三维触控」功能的机型）或长按（不携带「三维触控」功能的机型）左上角面板，关闭展开面板中的「蜂窝数据」开关。
- 在「设置」-「蜂窝网络」中，关闭「蜂窝数据」开关。
- 呼叫 Siri，说「关闭蜂窝数据」。
- 配合快捷指令 app 关闭蜂窝数据。[利用快捷指令 app](/zh-cn/basic/shortcut.md)，可以将关闭蜂窝数据的操作与转移媒体的操作关联在同一快捷指令中，如果你持续遇到这个问题，这个方法会很有用。

## 重启 iPhone 或 Nintendo Switch

尝试 [重新启动 iPhone](https://support.apple.com/zh-cn/HT201559) 或 [重新启动 Nintendo Switch](https://www.youtube.com/watch?v=2dACFDmgXDo)，然后重新进行连接操作。