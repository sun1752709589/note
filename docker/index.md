### docker移除镜像容器及磁盘空间
```
需要理解Docker镜像与容器。当然，这里是从文件系统的角度理解。

Docker镜像是只读文件。强调一下，它是只读的，因此我们实际上无法删除镜像中的文件。当你进行删除操作时，只不过做一个标记，使得容器看不到这个文件而已。所以这个文件依然存在于镜像中，且会占用磁盘空间。

Docker容器是基于镜像的读写层，它是可读可写的。读写某个文件的时候，是从镜像中将那个文件复制到容器的读写层，然后对复制的文件进行读写，而原文件依然在镜像中。而且，这个容器的读写层也是占用磁盘空间的。

所以，我们只能通过删除镜像和容器的方式释放磁盘空间。

删除镜像

sudo docker rmi <Image Name>

删除容器

sudo docker rm <Container Name>

删除所有镜像

sudo docker rmi -a

删除所有容器

sudo docker rm -a

另外，容器的数据卷(volume)也是占用磁盘空间，可以通过以下命令删除失效的volume:

sudo docker volume rm $(docker volume ls -qf dangling=true)

当然，最暴力的方式是删除Docker存储镜像，容器与数据卷的目录(/var/lib/docker)

谨慎使用！！！:

sudo service docker stop
sudo rm -rf /var/lib/docker
sudo service docker start
```