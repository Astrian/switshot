module.exports = {
  themeConfig: {
    logo: '/images/icon.png',
    locales: {
      '/': {
        selectLanguageName: 'English (US)',
        sidebar: getSidebar('en-us'),
      },
      '/zh-cn/': {
        selectLanguageName: '简体中文（中国大陆）',
        sidebar: getSidebar('zh-cn'),
        tip: '提示'
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

