# pipeline-y.tst: yash-specific test of pipeline

test_Oe -e 2 'no command before |'
| echo foo
__IN__
syntax error: a command is missing before `|'
__ERR__
#`

test_Oe -e 2 'no command after |'
echo foo |
__IN__
syntax error: a command is missing at the end of input
__ERR__
#`

test_Oe -e 2 '| followed by !'
echo foo | ! cat
__IN__
syntax error: `!' cannot be used as a command name
__ERR__
#`

test_Oe -e 2 '! followed by !'
! ! echo ok
__IN__
syntax error: `!' cannot be used as a command name
__ERR__
#`

test_Oe -e 2 '| followed by |'
echo foo | | cat
__IN__
syntax error: a command is missing before `|'
__ERR__
#`

# vim: set ft=sh ts=8 sts=4 sw=4 noet:
