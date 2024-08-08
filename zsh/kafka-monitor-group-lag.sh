config=$1
group=$2
topicExpr=""
if [ -z "$3" ]; then
    echo "monitoring all topics"
else
    topicExpr=$3
    echo "monitoring topics that match $topicExpr"
fi

while true
do
    date
    ~/dev/tools/kafka/bin/kafka-consumer-groups.sh --command-config ${config} --bootstrap-server $(cat ${config} | grep bootstrap | sed 's/bootstrap.server=//') --describe --group ${group} | grep "$topicExpr" | grep -v "dlq" | awk '{ sum += $6} END { print sum }'
    echo 
    sleep 10
done