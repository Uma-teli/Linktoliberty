#!/bin/env sh

MODEL_VERSION=$(python /u/wml/jenkinsPipeline/WMLzAppBuild/scripts/json_extract.py model_version)

/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/extract.sh $MODEL_VERSION /u/wml/jenkinsPipeline/WMLzAppBuild /var/jenkins/workspaces/WMLzCobolPipeline

/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/changeScoringEnd.sh /u/wml/jenkinsPipeline/WMLzAppBuild /var/jenkins/workspaces/WMLzCobolPipeline

/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/gitCommit.sh /u/wml/jenkinsPipeline/WMLzAppBuild
