#!/bin/env sh

cd /u/wml/jenkinsPipeline/WMLzAppBuild/

git add .

git commit -m 'commit'

#git push origin master 'root:ibmuser@7'
git push "http://root:2t4c6s8#@169.38.108.133:9030/root/wmlzappbuild.git"