#!/bin/bash

# 文档统一在MyFileBed仓库中管理，此脚本用于Commit MyFileBed仓库，并将MyFileBed仓库中的文档同步到HelloBlog与HalloBlog两个仓库中，自动提交并发布

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH

LANG=C

MyFileBedPath=/root/GithubProjects/MyFileBed/
HelloBlogPath=/root/GithubProjects/HelloBlog/
HalloBlogPath=/root/GithubProjects/HalloBlog/

set -e  # 脚本一旦报错，立刻跳出脚本，而不是继续向下执行

# 先commit到MyFileBed仓库
echo -e "\033[32m准备Commit MyFileBed仓库\033[0m"
cd ${MyFileBedPath}
git add --all
git commit -a -m $(TZ=UTC-8 date +"%Y%m%d-%H%M%S")
git push

# 操作HelloBlog仓库，HelloBlog是使用Jekyll发布的，所以只需要同步文件并commit即可
echo -e "\n"
echo -e "\033[32m准备同步HelloBlog\033[0m"
echo -e "\033[32mgit pull HelloBlog\033[0m"
cd ${HelloBlogPath}
git pull

echo -e "\033[32mSync HelloBlog\033[0m"
cd "${HelloBlogPath}_posts/" && rm -rf "${HelloBlogPath}_posts/"*
cd ${HelloBlogPath}
cp -r "${MyFileBedPath}BlogBed/"* "${HelloBlogPath}_posts/"

for i in {3..1}; do echo $i; sleep 1s; done
LANG=en_US.UTF-8
bundle exec jekyll build  # 本地执行一次构建，目的是拿到sitemap，脚本执行自动提交给搜索引擎
LANG=C

for i in {3..1}; do echo $i; sleep 1s; done
echo -e "\033[32mgit push HelloBlog\033[0m"
git add --all
git commit -a -m $(TZ=UTC-8 date +"%Y%m%d-%H%M%S")
git push

# 操作HalloBolg仓库，HalloBlog是使用Hexo发布的，所以同步文件并commit后，还需要发布一下
echo -e "\n"
echo -e "\033[32m准备同步HalloBlog\033[0m"
echo -e "\033[32mgit pull HalloBlog\033[0m"
cd ${HalloBlogPath}
git pull

echo -e "\033[32mSync HalloBlog\033[0m"
cd "${HalloBlogPath}source/_posts/" && rm -rf "${HalloBlogPath}source/_posts/"*
cd ${HalloBlogPath}
cp -r "${MyFileBedPath}BlogBed/"* "${HalloBlogPath}source/_posts/"

for i in {3..1}; do echo $i; sleep 1s; done
echo -e "\033[32mgit push HalloBlog\033[0m"
git add --all
git commit -a -m $(TZ=UTC-8 date +"%Y%m%d-%H%M%S")
git push
echo -e "\033[32mDepoly HalloBlog\033[0m"
hexo clean && hexo deploy

# 提交sitemap给baidu
echo -e "\n"
echo -e "\033[32m准备commit sitemap to baidu\033[0m"
python3 /root/GithubProjects/MyScripts/Python/commit_sitemap_baidu.py 

# 提交sitemap给google由github action来完成
# google从国内访问，网络不是很好，交给github去操作，效果会好很多

# done
set +e
echo -e "\n"
echo -e "\033[32mDONE!\033[0m"