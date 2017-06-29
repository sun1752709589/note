引用自:https://segmentfault.com/a/1190000000461077
### 删除但未释放磁盘的文件查找
```
曾经在生产上遇到过一个df 和 du出现的结果不一致的问题，为了排查到底是哪个进程占用了文件句柄，导致空间未释放，首先在linux上面，一切皆文件，这个问题可以使用lsof这个BT的命令来处理（这个哈还可以来查询文件句柄泄露问题，应用程序的进程未关闭文件句柄）
1.文件句柄以及空间释放问题

    注：在生产环境常见的问题就是，有维护人员或者开发同事使用tail命令实时查看日志。然后另外的人使用rm命令删除，这有就好导致磁盘空间不会真正的释放，因为你要删除的文件，还有进程在使用，文件句柄没有释放，即tail

模拟场景1：

你创建一个文件testfile

touch testfile

然后使用tail命令一直查看

tail testfile

这个时候另外一个同事使用rm命令来删除了该文件

rm testfile

正式使用lsof命令排查

如果你知道文件名，那就可以直接使用如下命令

lsof |grep  testfile

但是如果你不知道是哪个文件，或者是很多文件都有这样的情况，那你需要使用如下命令

lsof |grep deleted 注：这个deleted表示该已经删除了的文件，但是文件句柄未释放,这个命令会把所有的未释放文件句柄的进程列出来

注：有些系统你没有配置环境变量的话，直接lsof是会报错没有该命令，你可以直接/usr/bin/lsof 或者是/usr/sbin/lsof，根据你的系统环境自己查看

然后上面命令出来的结果会出来如下结果

root 123 12244 0 14:47 pts/1 01:02:03  tail testfile

然后你可以使用kill 命令来释放文件句柄从而释放空间

kill 123

```
### 文件恢复问题
```
在说明问题之前，先介绍下一些文件的基本概念：

    文件实际上是一个指向inode的链接, inode链接包含了文件的所有属性, 比如权限和所有者, 数据块地址(文件存储在磁盘的这些数据块中). 当你删除(rm)一个文件, 实际删除了指向inode的链接, 并没有删除inode的内容. 进程可能还在使用. 只有当inode的所有链接完全移去, 然后这些数据块将可以写入新的数据.
    proc文件系统可以协助我们恢复数据. 每一个系统上的进程在/proc都有一个目录和自己的名字， 里面包含了一个fd(文件描述符)子目录(进程需要打开文件的所有链接). 如果从文件系统中删除一个文件, 此处还有一个inode的引用:

/proc/进程号/fd/文件描述符

    你需要知道打开文件的进程号(pid)和文件描述符(fd). 这些都可以通过lsof工具方便获得, lsof的意思是”list open files, 列出(进程)打开的文件”. 然后你将可以从/proc拷贝出需要恢复的数据.

1.创建一个测试文件并且备份下，方面后续验证

touch testfile
cp testfile testfile.backup.2014

2.查看文件的相关信息

stat testfile

File: 'testfile'
Size: 343545 Blocks: 241 IO Block: 4096 regular file
Device: fd00h/64768d Inode: 361579 Links: 1
Access: (0664/-rw-rw-r–) Uid: ( 505/ zhaoke) Gid: ( 505/ zhaoke)
Access: 2014-11-09 15:00:38.000000000 +0800
Modify: 2014-11-09 15:00:34.000000000 +0800
Change: 2014-04-09 15:00:34.000000000 +0800

没问题, 继续下面工作:
3.删除文件

rm testfile

4.查看文件

ls -l testfile
ls: testfile: No such file or directory

stat testfile
stat: cannot stat 'testfile': No such file or directory

testfile文件删除了，但不要终止仍在使用文件的进程， 因为一旦终止, 文件将很难恢复.
现在我们开始找回数据之旅，先使用lsof命令查看下

lsof | grep testfile
tail 5317 root 4r REG 253,0 343545  361579  /root/testfile (deleted)

    第一个纵行是进程的名称(命令名), 第二纵行是进程号(PID), 第四纵行是文件描述符

    现在你知道5317进程仍有打开文件, 文件描述符是4. 那我们开始从/proc里面拷贝出数据.

    你可能会考虑使用cp -a, 但实际上没有作用, 你将拷贝的是一个指向被删除文件的符号链接:

ls -l /proc/5317/fd/4
lr-x—— 1 root root 64  09 15:00 /proc/5317/fd/4 -> /root/testfile (deleted)

使用cp -a命令测试恢复

 cp -a /proc/5317/fd/4 testfile.backup

使用ls命令来查看


ls -l testfile.backup
lrwxrwxrwx 1 root root 29  09 15:02 testfile.backup -> /roor/testfile (deleted)

通过上面的命令我们发现，使用cp -a命令，其恢复的是一个指向被删除文件的符号链接

使用file命令分别查看文件和文件描述符

    1.查看文件

file testfile.backup
testfile.backup: broken symbolic link to '/root/testfile (deleted)'

    2.查看文件描述符

file /proc/5317/fd/4

/proc/5317/fd/4: broken symbolic link to '/root/myfile (deleted)'

根据上面的file结果，可以使用cp拷贝出文件描述符数据到一个文件中，如下:

cp /proc/5317/fd/4 testfile.new

使用上面的命令恢复后，我们需要最终确认一下文件是否恢复，以及文件内容是否正确:

 ls -l testfile.new

然后把新旧的两个文件对比

diff testfile.new myfile.backup

```