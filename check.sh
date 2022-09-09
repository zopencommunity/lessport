#
# check.sh: this script runs build.sh in a variety of ways to
# validate that build.sh works
#
# There is no framework used here, because it is testing the framework
# so just use 'sh'
#
# This check should be run before checking in updates to build.sh

if [ "$1x" = "-hx" ]; then
	echo "Syntax: $0 [tc]*" >&2
	echo "  where tc is a test case number to run" >&2
	echo "  default is to run all tests if no specific tests specified" >&2
	exit 4
fi

#
# Put space at start and end so that search works properly
#
if [ $# -gt 0 ]; then
	TS=" $* "
else
	TS=" 1 2 3 4 5 "
fi

#set -x

# Test #1 - validate that basic build works
if [[ ${TS} =~ " 1 " ]]; then
	echo "Test 1"
	rm -rf zotsample-1.0 ${HOME}/zot/prod/zotsample-1.0

	if ! build.sh ; then 
		echo "Basic build of sample failed" >&2
		exit 4
	fi
fi

# Test #2 - validate that basic build works (verbose)
if [[ ${TS} =~ " 2 " ]]; then
	echo "Test 2"
	rm -rf zotsample-1.0 ${HOME}/zot/prod/zotsample-1.0

	if ! build.sh -v ; then 
		echo "Basic build of sample failed" >&2
		exit 4
	fi
fi

# Test #3 - provide an alternate location to install into
if [[ ${TS} =~ " 3 " ]]; then
	echo "Test 3"
	rm -rf zotsample-1.0 ${HOME}/zot/prod/zotsample-1.0

	if ( export PORT_INSTALL_DIR="/tmp/zotsample" && ! build.sh ) ; then
		echo "Build and install into /tmp/zotsample failed" >&2
	fi

	if ( cd /tmp/zotsample && . ./.env && ! zotsample ) ; then
		echo "Unable to run zotsample from /tmp" >&2
	else
		rm -rf /tmp/zotsample
	fi
fi

# Test #4 - change environment variables to ensure they 'flow' properly
if [[ ${TS} =~ " 4 " ]]; then
	echo "Test 4"

	export CC=c89
	export CXX=cxx
	export LD=cxx
	export CFLAGS='-O2 -Wc,lp64'
	export CXXFLAGS='-O2 -+ -Wc,lp64'
	export LDFLAGS='-Wl,lp64'

	rm -rf zotsample-1.0 ${HOME}/zot/prod/zotsample-1.0
	if ! build.sh -v ; then 
		echo "Changed flags build of sample failed" >&2
		exit 4
	fi
fi

