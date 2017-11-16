
touch RTL_Routing_Table_bypass/critical_sent.txt
touch RTL_Routing_Table_bypass/critical_received.txt


grep 'From 15' RTL_Routing_Table_bypass/sent.txt > RTL_Routing_Table_bypass/critical_sent.txt
grep 'From 0'  RTL_Routing_Table_bypass/sent.txt >> RTL_Routing_Table_bypass/critical_sent.txt

grep 'From: 15'  RTL_Routing_Table_bypass/received.txt > RTL_Routing_Table_bypass/critical_received.txt
grep 'From: 0'  RTL_Routing_Table_bypass/received.txt >> RTL_Routing_Table_bypass/critical_received.txt

echo "OVERAL SYSTEM QoS:"
echo ""
python calculate_latency.py -S RTL_Routing_Table_bypass/sent.txt -R RTL_Routing_Table_bypass/received.txt
echo "--------------------------------------------"
echo "CRITICAL REGION QoS:"
echo ""
python calculate_latency.py -S RTL_Routing_Table_bypass/critical_sent.txt -R RTL_Routing_Table_bypass/critical_received.txt
