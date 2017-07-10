# sx-mobile

## Build Setup
> 使用[yarn](https://yarnpkg.com/zh-Hans/)

``` bash
# install dependencies
$ yarn

# serve with hot reload at localhost:8080
yarn run dev

# build for production with minification
yarn run build

```

## 项目结构
```
├── commons             // 系统公共方法，组件
├── constants           // redux相关常量、系统其他常量
├── frame               // 页面框架
├── mock                // mock数据，截获ajax请求，便于前端单独调试
│   └── mockdata        // 模拟数据 mockjs
├── pages               // 业务页面，业务开发主要关系目录
│   ├── error           // 一些error页面，404 403 401 等等
│   ├── Demo            // 组件Demo列表
│   ├── DemoPages       // 所有Demo组件
│   └── Home            // 首页
├── redux               // redux 相关
│   ├── actions         // redux action定义
│   ├── reducers        // redux reducers定义目录
│   └── actionTypes.js  // actions 和 reducers使用的types常量
├── App.jsx             // 项目入口文件
└── global.less         // 全局样式定义

```

## 页面写法
> 项目依赖 [sx-ui](https://github.com/sxfed/sx-ui)

### 路由
> 页面导出 PAGE_ROUTE 常量即可，常量的值对应菜单的path

```
export const PAGE_ROUTE = '/example/users';
```

### redux
> 页面导出 `LayoutComponent` `mapStateToProps这两个变量`，系统会自动将当前组件与redux进行连接

```
export class LayoutComponent{...}

export function mapStateToProps(state) {
    return {
        ...state.frame,
    };
}
```

如果页面想使用简化的redux（只数据共享，操作不共享），请定义INIT_STATE常量
```
// 初始化数据
export const INIT_STATE = {
    scope: 'actionsSetState', // 定义命名空间
    sync: true, // 是否与localStorage进行同步
    a: {
        b: {
            c: ['ccc'],
            c2: 'c2',
        },
        b1: [],
        b2: 'b2',
    },
    d: 'd',
    e: 'e',
};

// 注入数据
export function mapStateToProps(state) {
    return {
        ...state.pageState.actionsSetState,
    };
}

// 取值
const {a, d, e} = this.props;

// 赋值
this.props.actions.setState({a: 'new value'});
```
