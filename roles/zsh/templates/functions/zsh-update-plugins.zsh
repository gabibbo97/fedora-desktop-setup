zsh-update-plugins() {
    # Check if directory exists
    [ -d "${ZSH_CUSTOM}/plugins" ] || return
    # Update plugins
    for plugDir in ${ZSH_CUSTOM}/plugins/*; do
        # Skip if not directory
        [ -d "$plugDir" ] || continue
        # Update
        (
            cd "$plugDir"
            if [ -d .git ]; then
                echo "Updating plugin $(basename $PWD)"
                git pull
            fi
        )
    done
}