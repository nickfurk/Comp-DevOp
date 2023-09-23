#!/bin/bash

mygit-init() {
    echo ===========================================
    echo mygit-init command called

    # if number of arguments does 'not equal' to 1
    if [ $# -ne 1 ]
    then
        echo Error: improper usage, try mygit-init "<directory>"
        exit 1
    fi

    directory=$1

    # if the directory does not exists
    if [ ! -d "$directory" ]
    then
        echo Error: directory does not exists: $directory
        exit 1
    fi

    cd $directory || exit 1 # enter directory or fail
    echo Currently in $directory directory
    echo Initializing git init
    git init || {
        echo "Error: failed to initialize git repository"
        exit 1
    }
    echo COMPLETE git init in $directory directory
}


mygit-clone() {
    echo ===========================================
    echo mygit-clone command called

    # if number of arguments does 'not equal' to 2
    if [ $# -ne 2 ]
    then
        echo ERROR: improper usage, try mygit-clone "<remote_url> <local_directory>"
        exit 1
    fi

    remote_url=$1
    local_directory=$2

    # checks if the directory already exists
    if [ -d "$local_directory" ]
    then  
        echo ERROR: directory already exists: $local_directory
        exit 1
    fi

    echo cloning remote directory from $remote_url
    git clone $remote_url $local_directory || {
        echo Error: Failed to clone remote repository
        exit 1
    } 
    echo COMPLETE cloning remote directory to local directory
}

mygit-commit() {
    echo ===========================================
    echo mygit-commit command called

    # check if there are less than 2 arguments
    if [ $# -lt 2 ]
    then
        echo ERROR: improper usage, try mygit-commit -m "<commit_message>"
        exit 1
    fi

    # verify that -m is entered for the first argument
    if [ "$1" != "-m" ]; then
        echo ERROR: improper usage, try mygit-commit -m "<commit_message>"
        exit 1
    fi

    commit_message="$2"

    echo adding to git
    git add .
    # git add . || {
    #     echo ERROR: Failed to add files to git
    #     exit 1
    # }
    echo commiting to git
    git commit -m "$commit_message" || {
        echo ERROR: failed to commit changes
        exit 1
    }
    echo COMPLETE git commit
}

mygit-push() {
    echo ===========================================
    echo mygit-push command called

    # check if there is 0 arguments
    if [ $# -ne 0 ]
    then
        echo ERROR: improper usage, try mygit-push
        exit 1
    fi

    echo pushing changes to remote repo
    git push || {
        echo ERROR: failed to push changes to remote repository
        exit 1
    }
    echo COMPLETE push to remote repo
}

mygit-create-directory() {
    echo ===========================================
    echo mygit-create-directory command called

    # check if there is 1 argument
    if [ $# -ne 1 ]
    then 
        echo ERROR: improper usage, try mygit-create-directory "<directory_name>"
        exit 1
    fi

    directory_name=$1

    # check if the directory exists
    if [ -d "$directory_name" ]
    then
        echo ERROR: directory already exists $directory_name
        exit 1
    fi

    echo creating new directory $directory_name
    mkdir $directory_name || {
        echo ERROR: failed to create directory
        exit 1
    }
    echo COMPLETE created new directory $directory_name
}

mygit-delete-file(){
    echo ===========================================
    echo mygit-delete-file command called

    # check if there is 1 argument
    if [ $# -ne 1 ]
    then 
        echo ERROR: improper usage, try mygit-delete-file "<file_name>"
        exit 1
    fi

    file_name=$1

    # check if file does not exists
    if [ ! -f "$file_name" ]
    then
        echo ERROR: $file_name does not exists
        exit 1
    fi

    echo removing $file_name file from git repo
    rm $file_name || {
        echo ERROR: Failed to remove file from git repo
        exit 1
    }
    echo COMPLETE removing file $file_name from git repo
}

mygit-delete-directory(){
    echo ===========================================
    echo mygit-delete-directory command called

    # check if there is 1 argument
    if [ $# -ne 1 ]
    then
        echo ERROR: improper usage, try mygit-delete-directory "<directory_name>"
        exit 1
    fi 

    directory_name=$1

    # check if directory exists
    if [ ! -d "$directory_name" ]
    then 
        echo ERROR: directory does not exists
        exit 1
    fi

    echo removing $directory_name directory from git repo
    rm -r $directory_name || {
        echo ERROR: failed to remove directory and its contents from git repo
        exit 1
    }
    echo COMPLETE removal of $directory_name directory from git repo
}

mygit-list-contents(){
    echo ===========================================
    echo mygit-list-contents command called

    if [ $# -ne 1 ]
    then
        echo ERROR: improper usage, try mygit-list-contents "<directory>"
        exit 1
    fi

    directory=$1

    echo listing all contents:
    ls $directory || {
        echo ERROR: failed to list directory contents
        exit 1
    }
    echo COMPLETE listing directory contents
}

menu(){
    echo ================= MENU =================
    echo List of available commands: 
    echo
    echo mygit-init "<directory>"
    echo description: initializes a new git repo in the specified directory
    echo 
    echo mygit-clone "<remote_url> <local_directory>"
    echo description: clone an existing git repo from a remote URL to a local directory
    echo
    echo mygit-commit "-m <commit_message>"
    echo description: add and commit changes to the local git repo
    echo
    echo mygit-push
    echo description: push committed changes to remote git repo
    echo
    echo mygit-create-directory "<directory_name>"
    echo description: creates a new directory within the git repo
    echo
    echo mygit-delete-file "<file_name>"
    echo description: deletes a file from the git repo
    echo
    echo mygit-delete-directory "<directory_name>"
    echo description: deletes a directory and its content from the git repo
    echo
    echo mygit-list-contents "<directory>"
    echo description: lists the contents of a directory within the git repo
    echo ========================================
}


# checks number of CLI arguments
if [ $# -eq 0 ]; then
    echo No function called
    exit 1
fi

case "$1" in 
    "menu")
        menu
        ;;
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
