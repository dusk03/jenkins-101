FROM jenkins/jenkins:lts-jdk17

USER root

# Install required packages
RUN apt-get update && apt-get install -y lsb-release python3-pip curl gnupg2

# Add Docker repository
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

USER jenkins

# Install plugins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28 build-timeout:1.37 json-path-api:2.9.0-148.v22a_7ffe323ce"