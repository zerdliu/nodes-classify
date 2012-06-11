# Nodes-Classify 
是一个对host进行分类的工具。能够对host打tag，并能够根据host查找tag，或者根据tag的组合查找服务器。是为puppet和capistrano在大规模集群上应用写的一个扩展。

## 环境需求

  - ruby 1.9.2
  - rails 3.1.X
  - sqlite or mysql

## 如何安装

	git clone git://github.com/zerdliu/nodes-classify.git
	cd nodes-classify
	bundle install
	rails s -p 8888
	将./client/nodes放入PATH下

## 插入节点
host1, 他属于EXP项目，在上面部署moduleA模块,属于北京IDC(bj)

	在页面上添加Project(EXP)和Tag(moduleA bj). http://127.0.0.1:8888
	nodes insert -n host1 -p EXP --tags=moduleA,bj

## 修改节点
host1现在部署moduleC模块，仍物理属于北京IDC(bj)

	在页面上添加Tag(moduleC).
	nodes change -n host1 --tags=moduleC,bj

## 查询节点
目前在EXP项目中有3台服务器

	主机名	tag列表		运行状态
	host1	moduleA,bj	running
	host2	moduleA,sh	offline
	host3	moduleC,bj	offline

查询所有部署moduleA模块的host

	nodes search -p EXP --tags=moduleA

结果是：

	host1
	host2

查询所有部署moduleA且部署在bj的host

	nodes search -p EXP --tags=moduleA+bj

结果是：

	host1

查询所有在北京和在上海的服务器

	nodes search -p EXP --tags=bj,sh

结果是：

	host1
	host2
	host3

查询所有在北京且状态为running的host

	nodes search -p EXP --tags=bj --status=running


结果是：

	host1

即tag之间采用“,”间隔则为“或”的关系；采用"+"则为"与"的关系。

查询host1的详细信息

	search -n host1


## 删除节点

	nodes delete -n host1


## 注意
多个tag之间的分割只在search时区别"," 和 "+" ，其余情况下多tag之间的分隔符都为","



