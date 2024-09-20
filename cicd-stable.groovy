
node('linux')
{
  stage ('Poll') {
                // Poll for local changes
                checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/main']],
                        doGenerateSubmoduleConfigurations: false,
                        extensions: [],
                        userRemoteConfigs: [[url: 'https://github.com/zopencommunity/lessport.git']]])
  }

  stage('Build') {
                build job: 'Port-Pipeline', parameters: [string(name: 'PORT_GITHUB_REPO', value: 'https://github.com/zopencommunity/lessport.git'), string(name: 'PORT_DESCRIPTION', value: 'The less terminal pager program.' ), string(name: 'BUILD_LINE', value: 'STABLE')]
  }
}

