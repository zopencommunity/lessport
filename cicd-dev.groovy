
node('linux')
{
  stage ('Poll') {
               // Poll from upstream:
               checkout([
                       $class: 'GitSCM',
                       branches: [[name: '*/master']],
                       doGenerateSubmoduleConfigurations: false,
                       extensions: [],
                       userRemoteConfigs: [[url: 'https://github.com/gwsw/less.git']]])

                // Poll for local changes
                checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/main']],
                        doGenerateSubmoduleConfigurations: false,
                        extensions: [],
                        userRemoteConfigs: [[url: 'https://github.com/ZOSOpenTools/lessport.git']]])
  }

  stage('Build') {
        build job: 'Port-Pipeline', parameters: [string(name: 'PORT_GITHUB_REPO', value: 'https://github.com/ZOSOpenTools/lessport.git'), string(name: 'PORT_DESCRIPTION', value: 'The less terminal pager program.' ), string(name: 'BUILD_LINE', value: 'DEV')]
  }
}

