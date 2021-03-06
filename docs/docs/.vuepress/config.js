module.exports = {
  themeConfig: {
    logo: '/images/icon.png',
    sidebarDepth: 1,
    locales: {
      '/': {
        selectLanguageText: 'English',
        selectLanguageName: 'English (US)',
        sidebar: getSidebar('en-us'),
        navbar: getNavbar('en-us'),
      },
      '/zh-cn/': {
        selectLanguageText: '简体中文',
        selectLanguageName: '简体中文（中国大陆）',
        sidebar: getSidebar('zh-cn'),
        tip: '提示',
        navbar: getNavbar('zh-cn'),
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
  },
  head: [['link', { rel: 'icon', href: '/images/icon.png' }]],
}

function getSidebar(lang) {
  let sidebarLanguage = {
    'zh-cn': {
      basic: '必知必会',
      troubleshooting: '麻烦射击',
      qna: '常见问题',
    },
    'en-us': {
      basic: 'Must-knows',
      troubleshooting: 'Troubleshooting',
      qna: 'Q&A',
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
        `${langInUrl}/basic/shortcut.md`,
      ]
    }
  ]

  res[`${langInUrl}/troubleshooting/`] = [
    {
      text: sidebarLanguage[lang].troubleshooting,
      children: [
        `${langInUrl}/troubleshooting/cannot-connect-to-switch.md`,
      ]
    }
  ]

  res[`${langInUrl}/qna/`] = [
    {
      text: sidebarLanguage[lang].qna,
      link: `${langInUrl}/qna/`,
    }
  ]

  return res
}

function getNavbar(lang) {
  let navBarLanguage = {
    'zh-cn': {
      basic: '必知必会',
      troubleshooting: '疑难排查',
      qna: '常见问题',
      links: '常用链接',
      links_github: 'GitHub',
      links_appstore: 'App Store',
      links_updates: '更新与资讯',
      links_community: '社群',
    },
    'en-us': {
      basic: 'Must-knows',
      troubleshooting: 'Troubleshooting',
      qna: 'Q&A',
      links: 'Links',
      links_github: 'GitHub',
      links_appstore: 'App Store',
      links_updates: 'Updates & News',
      links_community: 'Community',
    }
  }

  let langInUrl = ""
  if (lang === 'en-us') langInUrl = ''
  else langInUrl = `/${lang}`
  let res = [
    { text: navBarLanguage[lang].basic, link: `${langInUrl}/basic/transfer.md` },
    { text: navBarLanguage[lang].troubleshooting, link: `${langInUrl}/troubleshooting/cannot-connect-to-switch.md` },
    { text: navBarLanguage[lang].qna, link: `${langInUrl}/qna/` },
    { text: navBarLanguage[lang].links, children: [
      { text: navBarLanguage[lang].links_github, link: 'https://github.com/Astrian/switshot'},
      { text: navBarLanguage[lang].links_appstore, link: 'https://apps.apple.com/us/app/switshot-console-media-manage/id1585470023'},
      { text: navBarLanguage[lang].links_updates, link: 'https://updates.switshot.app'},
      { text: navBarLanguage[lang].links_community, link: 'https://discord.gg/zeT2nnGvAA'}
    ] }
  ]
  return res
}