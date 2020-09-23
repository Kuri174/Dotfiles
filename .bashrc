alias ssh='ssh -X -c aes256-cbc s1260174@sshgate.u-aizu.ac.jp'
alias g++='g++ -std=c++17 -I . -D_DEBUG -fsanitize=address -fsanitize=undefined'
alias a='./a.out'
alias git-ls='git ls-files | sed -e "/^[^\/]*$/d" -e "s/\/[^\/]*$//g" | sort | uniq'

# show branch
PS1='\n\[\033[36m\]\t \w $(parse_git_branch)\n$ \[\033[0m\]'
if [ -z "$PS1" ]; then
   return
fi

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

# contest-file-compile <- koreiru?
function mk () {
    FILE="$1.cpp"
    if [ ! -e $FILE ]; then
        echo "$FILE not exists."
    else
        g++ -o A $FILE
    fi
}

# online-judge-tools
function ojd () {
    DIR="test"
    if [ -d $DIR ]; then
        rm -r $DIR
    fi
    oj d $1;
}

# coner-case-search
function check {
    g++ -o make_testcase make_testcase.cpp
    g++ -o test test.cpp
    g++ -o guchoku guchoku.cpp
    while true; do
        ./make_testcase
        ans1=$(./test < in)
        ans2=$(./guchoku < in)
        if [ "$ans1" != "$ans2" ]; then
            echo $(cat in)
            echo $ans1" (test)"
            echo $ans2" (guchoku)"
            break
        fi
    done
}

