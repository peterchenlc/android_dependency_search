usage() {
    echo "Usage: sh $0 <keyword>"
    exit 1
}

[[ $# -eq 1 ]] || {
    usage
}

keyword=$1
echo "start searching..."

start=$(date +%s)
grep -rn $keyword .

time=$(($(date +%s) - $start))
if [[ $time -gt 60 ]]; then
	echo "It takes $(($time / 60)) minutes $(($time % 60)) seconds to search."
else
	echo "It takes $time seconds to search."
fi