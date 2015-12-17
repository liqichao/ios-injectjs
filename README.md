# ios-injectjs
##说在前面
本项目实现的是向ios的webview中注入js。基于ios8以上的wkwebview，使用swift语言实现

##初始化
请在本地起一个服务用来提供注入的js文件（用服务的形式实现注入是为了方便加载更新后的js文件，比如和gulp打包一起用），项目中默认的js文件服务地址为 http://localhost:8888/example.js
一共有两处，一处用于初始化，一处用于更新加载。期待未来有好心人把这一处改成系统变量。
默认加载的网页是http://m.jd.com，请修改成自己想要注入js的网页的地址

##如果想要使用js动态更新，而不是重新打包ios项目的话
请在js执行中加入webkit.messageHandlers.callbackHandler.postMessage('reloadjs');然后用Safari调试工具刷新两次即可

##听说safari的Webview调试工具与这个项目一起使用更配哦

##视频教程
http://v.youku.com/v_show/id_XMTM3MzIzOTMwNA==.html?firsttime=0
密码请联系作者，微信lqchao007
