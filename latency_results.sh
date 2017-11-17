
touch RTL_baseline/critical_sent.txt
touch RTL_baseline/critical_received.txt


grep 'From 15' RTL_baseline/sent.txt > RTL_baseline/critical_sent.txt
grep 'From 0'  RTL_baseline/sent.txt >> RTL_baseline/critical_sent.txt

grep 'From: 15'  RTL_baseline/received.txt > RTL_baseline/critical_received.txt
grep 'From: 0'  RTL_baseline/received.txt >> RTL_baseline/critical_received.txt

echo "OVERALL SYSTEM QoS:"
echo ""
python calculate_latency.py -S RTL_baseline/sent.txt -R RTL_baseline/received.txt
echo "--------------------------------------------"
echo "CRITICAL REGION QoS:"
echo ""
python calculate_latency.py -S RTL_baseline/critical_sent.txt -R RTL_baseline/critical_received.txt
