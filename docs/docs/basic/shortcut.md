# Use with Shortcut app

[Shortcuts](https://support.apple.com/zh-cn/guide/shortcuts/apdf22b0444c/ios) is an iOS, iPadOS and macOS app provided by Apple. For now, Shortcuts is run with SiriKit and allow users create shortcuts with a group of customized actions.

After version 2.0, Switshot supports SiriKit and Shortcuts. You can use Shortcut app with Switshot to:

- **Transfer Media without launching Switshot app**。
- **Create shortcut automation**. For example, transfer media automatically when your iPhone connected to network with Nintendo Switch.
- **Submit transfered media to other apps** and share them to your friend, social networks, etc.

::: tip
Launching Switshot app and completing first transfer is recommanded before configuring actions in Shortcuts app.
:::

## Supported actions
### Transfer media from connected console
When action trigged, Switshot will transfer media from connected Nintendo Switch to Switshot app.

::: tip
Make sure your iPhone connected to your Nintendo Switch before using shortcuts with this action.
:::

#### Output
A group of files (which may be photos with JPG format or videos with MP4 format).

#### Options
Also save to Photo Library. When turned this option on, Switshot will save the transferred files to your Photo Library when you transfer media with this action.

::: tip
The “Also save to Photo Library” option in shortcut action is independent with “Save a copy to photo library” option located in Switshot settings.
:::

## Use actions in Shortcuts
If you want to use actions provided by Switshot in a shortcut:

- Make sure that your iPhone installed both Shortcuts app and Switshot app. Shortcuts is a pre-installed app on iPhone, however, it can be deleted. If it is been deleted, you need to re-install it [from App Store](https://apps.apple.com/us/app/shortcuts/id1462947752).
- Launch Shortcuts app, tap “+” button on the right-top corner to create a new shortcut.
- Tap “Add Action”, then find “Switshot” in the app list. Tap the action you want to add to shortcut.
- Configure the action just added.
- Add other actions if needed. Files can be outputed by actions provided by Switshot, so you can use other actions to recive them.
- Set icon, name and other options with the config button in right-top corner.
- Make sure you are done with it, click “X” button on the right-top corner to close the shortcut editor.
- Run the shortcut just created manually with click it in Shortcuts app.

If you want to learn more details, check [*Create a custom shortcut on iPhone or iPad*](https://support.apple.com/guide/shortcuts/create-a-custom-shortcut-apd84c576f8c/ios).

## High-level usage with Shortcuts
### Example: Automation
Shortcuts app support Automation feature. You can use it to set that run shortcuts with actions provided by Switshot when your iPhone connected to your Nintendo Switch.

::: tip
The local network name of Nintendo Switch is usually started with `switch_`, for example `switch_88402D0100h`. You can use this information to set the trigger condition in Shortcuts Automation.
:::

![](/images/en-us/shortcut-automation.png)

You can learn more about Shortcuts Automation [here](https://support.apple.com/guide/shortcuts/apd690170742/ios).

### Example: share transfered media to Instagram
Files-output is supported by some actions. You can pass it to other actions supports input media files. In this case, media files transfered by Switshot actions can be shared to Instagram instantly.

![](/images/en-us/shortcut-instagram-share.png)

### Shortcuts is NOT LIMITTED
You can use Switshot with Shortcuts app with almost-zero-limitation, not only the examples listed above. you can create useful and fun shortcuts with Switshot actions and actions provided by other apps with your demand and imagnation.