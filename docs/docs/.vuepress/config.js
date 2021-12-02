module.exports = {
  themeConfig: {
    logo: '/images/icon.png',
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
  }
}

function getSidebar(lang) {
  let sidebarLanguage = {
    'zh-cn': {
      basic: '必知必会'
    },
    'en-us': {
      basic: 'Must-knows'
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
  return res
}

function getNavbar(lang) {
  let navBarLanguage = {
    'zh-cn': {
      basic: '必知必会',
      qna: '常见问题',
      links: '常用链接',
      links_github: 'GitHub',
      links_appstore: 'App Store',
      links_updates: '更新与资讯'
    },
    'en-us': {
      basic: 'Must-knows',
      qna: 'Q&A',
      links: 'Links',
      links_github: 'GitHub',
      links_appstore: 'App Store',
      links_updates: 'Updates & News'
    }
  }

  let langInUrl = ""
  if (lang === 'en-us') langInUrl = ''
  else langInUrl = `/${lang}`
  let res = [
    { text: navBarLanguage[lang].basic, link: `${langInUrl}/basic/transfer.md` },
    { text: navBarLanguage[lang].qna, link: `${langInUrl}/qna/` },
    { text: navBarLanguage[lang].links, children: [
      { text: navBarLanguage[lang].links_github, link: 'https://github.com/Astrian/switshot'},
      { text: navBarLanguage[lang].links_appstore, link: 'https://apps.apple.com/us/app/switshot-console-media-manage/id1585470023'},
      { text: navBarLanguage[lang].links_updates, link: 'https://updates.switshot.app'}
    ] }
  ]
  return res
}