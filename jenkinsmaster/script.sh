apt-get update && apt-get upgrade
apt-get update
apt-get install -y openjdk-8-jdk
echo "JAVA_HOME=$(which java)" | sudo tee -a /etc/environment
source /etc/environment
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
apt-get update
apt-get install -y jenkins
systemctl start jenkins
