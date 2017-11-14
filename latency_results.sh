
touch Scenario_1_Non_Minimal_Routing_bypass/critical_sent.txt
touch Scenario_1_Non_Minimal_Routing_bypass/critical_received.txt


grep 'From 15' Scenario_1_Non_Minimal_Routing_bypass/sent.txt > Scenario_1_Non_Minimal_Routing_bypass/critical_sent.txt
grep 'From 0'  Scenario_1_Non_Minimal_Routing_bypass/sent.txt >> Scenario_1_Non_Minimal_Routing_bypass/critical_sent.txt

grep 'From: 15'  Scenario_1_Non_Minimal_Routing_bypass/received.txt > Scenario_1_Non_Minimal_Routing_bypass/critical_received.txt
grep 'From: 0'  Scenario_1_Non_Minimal_Routing_bypass/received.txt >> Scenario_1_Non_Minimal_Routing_bypass/critical_received.txt

echo "OVERAL SYSTEM QoS:"
echo ""
python calculate_latency.py -S Scenario_1_Non_Minimal_Routing_bypass/sent.txt -R Scenario_1_Non_Minimal_Routing_bypass/received.txt
echo "--------------------------------------------"
echo "CRITICAL REGION QoS:"
echo ""
python calculate_latency.py -S Scenario_1_Non_Minimal_Routing_bypass/critical_sent.txt -R Scenario_1_Non_Minimal_Routing_bypass/critical_received.txt
