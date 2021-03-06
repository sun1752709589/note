### zip
```
zip可能是目前使用得最多的文档压缩格式。

它最大的优点就是在不同的操作系统平台，比如Linux， Windows以及Mac OS上使用。缺点就是支持的压缩率不是很高，而tar.gz和tar.gz2在压缩率方面做得非常好。闲话少说，我们步入正题吧：

我们可以使用下列的命令压缩一个目录：
zip -r archive_name.zip directory_to_compress

下面是如果解压一个zip文档：
unzip archive_name.zip
```
### tar.gz
```
这种格式是我使用得最多的压缩格式。它在压缩时不会占用太多CPU的，而且可以得到一个非常理想的压缩率。
使用下面这种格式去压缩一个目录：
tar -zcvf archive_name.tar.gz directory_to_compress

解压缩：
tar -zxvf archive_name.tar.gz

上面这个解包命令将会将文档解开在当前目录下面。

当然，你也可以用这个命令来捏住解包的路径：
tar -zxvf archive_name.tar.gz -C /tmp/extract_here/
```
### tar.bz2
```
这种压缩格式是我们提到的所有方式中压缩率最好的。当然，这也就意味着，它比前面的方式要占用更多的CPU与时间。

这个就是你如何使用tar.bz2进行压缩:
tar -jcvf archive_name.tar.bz2 directory_to_compress

上面这个解包命令将会将文档解开在当前目录下面。

当然，你也可以用这个命令来捏住解包的路径：
tar -jxvf archive_name.tar.bz2 -C /tmp/extract_here/
```
### tar
```
tar -cvf log.tar log2012.log 仅打包，不压缩！
tar -zcvf log.tar.gz log2012.log 打包后，以 gzip 压缩
tar -jcvf log.tar.bz2 log2012.log 打包后，以 bzip2 压缩
压　缩：tar -jcv -f filename.tar.bz2 要被压缩的文件或目录名称
查　询：tar -jtv -f filename.tar.bz2
解压缩：tar -jxv -f filename.tar.bz2 -C 欲解压缩的目录
```