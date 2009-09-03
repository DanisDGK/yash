tmp="${TESTTMP}/alias.tmp"

alias -g A=a B=b C=c singlequote=\' -- ---=-
echo C B A -A- -B- -C- \A "B" 'C' ---
alias --global \C \singlequote C='| cat'
echo pipe alias C

alias -p >"$tmp"
\unalias -a
. "$tmp"
alias --prefix | diff - "$tmp" && echo restored

unalias --all
alias # prints nothing
alias c='cat'
alias -g P=')|c'
echo complex alias | (c|(c P)|c

unalias -a
alias -g a='a a '
echo a a a
alias foobar=' FOO=BAR ' e='env'
alias -g G=' |grep'
foobar e G '^FOO='

unalias -a
alias cc=' ( c ) ' c='cat'
echo ok | cc | cc |
cc |\
cc
alias i=if if=fi
i true; then echo if; fi
alias i='if true; then echo if; fi'
i
alias f=false ff='FOO=BAR f' fff='>/dev/null ff'
! f
echo $?
! ff
echo $?
! fff
echo $?
alias -g v=V
FOO=BAR echo v
FOO=BAR echo 3>/dev/null v

unalias -a
alias -g N='>/dev/null'
alias -p \N
echo null N  # prints nothing
N echo null  # prints nothing
(echo null) N  # prints nothing
{ echo null; } N  # prints nothing
if :; then echo null; fi N  # prints nothing
if if :; then :; fi then if :; then echo null; fi fi N  # prints nothing
if if :; then :; fi then if :; then echo null; fi N fi  # prints nothing
if if echo null; then :; fi N then if :; then :; fi fi  # prints nothing

unalias -a
alias test=:
func() { echo "$(test ok)"; }
alias test=echo
func

command -V alias unalias

rm -f "$tmp"
