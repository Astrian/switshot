module.exports = {
  themeConfig: {
    logo: '/images/icon.png',
    locales: {
      '/': {
        selectLanguageText: 'English',
        selectLanguageName: 'English (US)',
        sidebar: getSidebar('en-us'),
        navbar: [
          { text: 'Basic Usage', link: '/basic/transfer.md' },
        ]
      },
      '/zh-cn/': {
        selectLanguageText: '简体中文',
        selectLanguageName: '简体中文（中国大陆）',
        sidebar: getSidebar('zh-cn'),
        tip: '提示',
        navbar: [
          { text: '基本用法', link: '/zh-cn/basic/transfer.md' },
        ]
      }
    }
  },
  locales: {
    '/': {
      lang: 'en-US',
      title: 'Switshot Help Center',
      description: 'Get solutions and tips with Switshot app.',
    },
    '/zh-cn/': {
      lang: 'zh-CN',
      title: 'Switshot 帮助中心',
      description: '获取有关 Switshot 的解决方案和技巧。',
    },
  }
}

function getSidebar(lang) {
  let sidebarLanguage = {
    'zh-cn': {
      basic: '基本用法'
    },
    'en-us': {
      basic: 'Basic Usage'
    }
  }

  let langInUrl = ""
  if (lang === 'en-us') langInUrl = ''
  else langInUrl = `/${lang}`
  let res = {}
  res[`${langInUrl}/basic/`] = [
    {
      text: sidebarLanguage[lang].basic,
      children: [
        `${langInUrl}/basic/transfer.md`,
      ]
    }
  ]
  return res
}

