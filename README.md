在macbook上同步rime相关数据
当前个人在windows、安卓、macbook、ios上使用rime输入法，但是同步问题是个大难题，后来找到了一个折衷的办法，macbook和ios用icloud同步，macbook上用onedrive和windows等保持同步，出现一个问题就是如何同步macbook在icloud以及onedrive上的userdb同步问题
此脚本的作用
1. 把icloud的ios的userdb文件拷贝到onedrive中的ios文件夹
2. 执行rime输入法的同步功能
3. 把onedrive中的macbook的userdb拷贝到icloud中的macbook文件夹

完整的一套同步流程应该就是这样的
1. 在ios的仓输入法执行同步操作，等下macbook上的ios的userdb文件下载完成
2. 通过命令./执行脚本
3. 在ios上查看macbook的userdb文件是否同步，同步完成后，再次运行仓输入法的同步按钮
4. 完成！
