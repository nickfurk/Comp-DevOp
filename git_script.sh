#!/bin/bash

mygit-init() {
    cd $1 # enter directory
    echo currently in $1 directory
    echo initializing git init
    git init
    echo complete git init in $1 directory
}

mygit-clone() {
    cd $2 # directory
    echo currently in $2 directory
    echo cloning remote directory from $1
    git clone $1 # remote repo
    echo complete cloning remote directory
}

mygit-commit() {
    # verify that -m is entered
    if [ "$1" != "-m" ]; then
        echo "Error: incorrect syntax. Use mygit-commit -m "commit_message""
        exit 1
    fi

    echo adding to git
    git add .
    echo commiting to git
    git commit -m "$2"
    echo git commit completed
}

mygit-push() {
    echo pushing changes to remote repo
    git push
    echo push to remote repo completed
}

mygit-create-directory() {
    echo creating new directory $1
    mkdir $1 # new directory name
    echo new directory $1 created
}

mygit-delete-file(){
    echo removing $1 file from git repo
    rm $1 # delete file from repo
    echo file $1 removed from git repo
}

mygit-delete-directory(){
    echo removing $1 directory from git repo
    git rm -r $1 # delete directory and its content from repository
    echo removed $1 directory from git repo
}

mygit-list-contents(){
    echo listing all contents:
    ls $1 
}

# checks number of CLI arguments
if [ $# -eq 0 ]; then
    echo No function called
    exit 1
fi

case "$1" in 
    "mygit-init")
        mygit-init $2
        ;;
    "mygit-clone")
        mygit-clone $2 $3
        ;;
    "mygit-commit")
        mygit-commit $2 $3
        ;;
    "mygit-push")
        mygit-push
        ;;
    "mygit-create-directory")
        mygit-create-directory $2
        ;;
    "mygit-delete-file")
        mygit-delete-file $2
        ;;
    "mygit-delete-directory")
        mygit-delete-directory $2
        ;;
    "mygit-list-contents")
        mygit-list-contents $2
        ;;
    *)
        # other cases
        echo Invalid function name: $1
        exit 1
        ;;
esac
