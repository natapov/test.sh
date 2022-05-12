RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;33m'
NC='\033[0m'    

run_test () {
	TEST="$(basename ${1} $INSUF)"
	echo -e -n "${BLUE}TEST $TEST${NC}: "
	$EXE  <$IN/$TEST$INSUF >$MYOUT/$TEST$OUTSUF 2>$MYOUT/$TEST$ERRSUF
	DIFF1=$(diff $MYOUT/$TEST.out $OUT/$TEST.out.exp )
	DIFF2=$(diff $MYOUT/$TEST.err $OUT/$TEST.err.exp )
	if [ "$DIFF1" == "" ] 
	then
		echo -e "${GREEN}PASSED${NC}"
	fi
	if [ "$DIFF1" != "" ] 
	then
		echo -e "${RED}FAILED${NC}"

	fi
	if [ "$DIFF2" == "" ] 
	then
		echo -e "${GREEN}PASSED ERROR CHECK${NC}"
	fi
	if [ "$DIFF2" != "" ] 
	then
		echo -e "${RED}FAILED ERROR CHECK${NC}"
	fi
}
EXE="./smash"
EXE_REF="./smash"
MYOUT="./tests/outputs"
IN="./tests/inputs"
OUT="./tests/expected"

INSUF=".txt"
OUTSUF=".out"
ERRSUF=".err"


for file in $IN/*
do
  run_test "$file" 
done
