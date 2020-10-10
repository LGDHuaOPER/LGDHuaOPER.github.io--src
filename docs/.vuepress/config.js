const path = require('path');
module.exports = {
  title: '敬昭的博客',
  description: '技术，随笔，作品，关于我',
  base: '/', // 项目根路径
  dest: './dist/', // 打包后的文件夹路径，为了方便，我把 dist 文件夹放到了根目录上
  // head 标签中的额外内容
  head: [
    ['link', { rel: 'icon', href: '/favicon.ico' }] // 这个是标签页 logo
  ],
  // 语言配置
  locales: {
    // 键名是该语言所属的子路径
    // 作为特例，默认语言可以使用 '/' 作为其路径。
    '/': {
      lang: 'zh-CN' // 将会被设置为 <html> 的 lang 属性
    }
  },
  // 主题配置
  themeConfig: {
    // 顶部导航
    logo: '/assets/img/nav.log.jpg',
    nav: [
      { text: '首页', link: '/' },
      {
        text: '技术',
        ariaLabel: 'technology',
        items: [
          { text: 'CSS', link: '/tech/css/' },
          { text: '其他', link: '/tech/other/' }
        ]
      },
      { text: '随笔', link: '/essay/' },
      { text: '作品', link: '/works/' },
      {
        text: '关于',
        items: [
          { text: '关于我', link: '/about/about-me.md' },
          {
            text: '掘金',
            link: 'https://juejin.im/user/5ae00598518825672f198952'
          }
        ]
      }
    ],
    // 搜索框
    search: true,
    searchMaxSuggestions: 10,

    // 侧边栏
    sidebar: {
      // 技术分类-CSS专题
      '/tech/css/': [
        {
          title: '博客首页',
          path: '/',
          collapsable: false
        },
        '',
        {
          title: 'Less-学习笔记', // 必要的
          path: 'Less-学习笔记', // 可选的, 应该是一个绝对路径
          collapsable: true, // 可选的, 默认值是 true,
          sidebarDepth: 1, // 可选的, 默认值是 1
          children: []
        },
        'Sass-学习笔记'
      ],
      // 技术专题-其他技术专题
      '/tech/other/': [
        {
          title: '博客首页',
          path: '/',
          collapsable: false
        },
        '',
        '如何管理多个SSH-Key并可进行连接'
      ],
      // 随笔分类
      '/essay/': [
        {
          title: '博客首页',
          path: '/',
          collapsable: false
        },
        ''
      ],
      // 作品分类
      '/works/': [
        {
          title: '博客首页',
          path: '/',
          collapsable: false
        },
        ''
      ],
      // 关于分类
      '/about/': [
        {
          title: '博客首页',
          path: '/',
          collapsable: false
        },
        {
          title: '关于我', // 必要的
          path: 'about-me', // 可选的, 应该是一个绝对路径
          collapsable: true, // 可选的, 默认值是 true,
          sidebarDepth: 1, // 可选的, 默认值是 1
          children: []
        },
        {
          title: '掘金主页',
          path: 'https://juejin.im/user/5ae00598518825672f198952'
        }
      ],
      // fallback
      '/': [
        {
          title: '博客首页',
          path: '/',
          collapsable: false
        },
        'articles-overview' /* /articles-overview.html */,
        {
          title: '技术',
          children: ['tech/css/', 'tech/other/']
        },
        'essay/',
        'works/',
        {
          title: '关于',
          children: [
            'about/about-me',
            {
              title: '掘金主页',
              path: 'https://juejin.im/user/5ae00598518825672f198952'
            }
          ]
        }
      ]
    },
    sidebarDepth: 2, // 默认 1 提取到 h2，0 为禁用，2 为 h2，h3
    displayAllHeaders: false, // 默认值：false 侧边栏只会显示由当前活动页面的标题组成的链接
    activeHeaderLinks: true, // 默认值：true 滚动时通过 hash 高亮侧边栏标题

    // Git 仓库和编辑链接
    // 假定是 GitHub. 同时也可以是一个完整的 GitLab URL
    repo: 'LGDHuaOPER/LGDHuaOPER.github.io--src', // 你的仓库
    // 自定义仓库链接文字。默认从 `themeConfig.repo` 中自动推断为
    // "GitHub"/"GitLab"/"Bitbucket" 其中之一，或是 "Source"。
    repoLabel: 'GitHub',

    // 以下为可选的编辑链接选项
    // 假如你的文档仓库和项目本身不在一个仓库：
    // docsRepo: 'vuejs/vuepress',
    // 假如文档不是放在仓库的根目录下：
    docsDir: 'docs',
    // 假如文档放在一个特定的分支下：
    docsBranch: 'master',
    // 默认是 false, 设置为 true 来启用
    editLinks: true,
    // 默认为 "Edit this page"
    editLinkText: '帮助我改善此页面！',

    lastUpdated: '上次更新', // string | boolean
    smoothScroll: true,

    markdown: {
      lineNumbers: true
    }
  },
  configureWebpack: {
    resolve: {
      alias: {
        '@static': path.resolve(__dirname, '../static')
      }
    }
  }
};
