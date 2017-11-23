
touch RTL_LBDR_20bit/critical_sent.txt
touch RTL_LBDR_20bit/critical_received.txt


grep 'From 15' RTL_LBDR_20bit/sent.txt > RTL_LBDR_20bit/critical_sent.txt
grep 'From 0'  RTL_LBDR_20bit/sent.txt >> RTL_LBDR_20bit/critical_sent.txt

grep 'From: 15'  RTL_LBDR_20bit/received.txt > RTL_LBDR_20bit/critical_received.txt
grep 'From: 0'  RTL_LBDR_20bit/received.txt >> RTL_LBDR_20bit/critical_received.txt

echo "OVERAL SYSTEM QoS:"
echo ""
python calculate_latency.py -S RTL_LBDR_20bit/sent.txt -R RTL_LBDR_20bit/received.txt
echo "--------------------------------------------"
echo "CRITICAL REGION QoS:"
echo ""
python calculate_latency.py -S RTL_LBDR_20bit/critical_sent.txt -R RTL_LBDR_20bit/critical_received.txt
