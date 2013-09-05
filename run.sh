if [ -z "$WERCKER_JITSU_DEPLOY_USERNAME"  ]
then
    if [ ! -z "$NODEJITSU_USERNAME" ]
    then
        export WERCKER_JITSU_DEPLOY_USERNAME="$NODEJITSU_USERNAME"
    else
        fail "Missing or empty option username."
    fi
fi

if [ -z "$WERCKER_JITSU_DEPLOY_PASSWORD"  ]
then
    if [ ! -z "$NODEJITSU_PASSWORD" ]
    then
        export WERCKER_JITSU_DEPLOY_PASSWORD="$NODEJITSU_PASSWORD"
    else
        fail "Missing or empty option password."
    fi
fi

if ! type jitsu &> /dev/null ; then
    info "jitsu not installed, trying to install it through npm"

    if ! type npm &> /dev/null ; then
        fail "npm not found, make sure you have npm or jitsu installed"
    else
        info "npm is available"
        debug "npm version: $(npm --version)"

        info "installing jitsu"
        sudo npm install -g --silent jitsu
    fi
else
    info "jitsu is available"
    debug "npm version: $(jitsu --version)"
fi

# TODO - Catch error output
jitsu config set username $WERCKER_JITSU_DEPLOY_USERNAME

# TODO - Catch error output
jitsu config set password $WERCKER_JITSU_DEPLOY_PASSWORD

# TODO - Catch error output
jitsu deploy --confirm
