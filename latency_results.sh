
touch Mixed_Criticality_Scenario_1_Minimal_Routing/critical_sent.txt
touch Mixed_Criticality_Scenario_1_Minimal_Routing/critical_received.txt


grep 'From 15' Mixed_Criticality_Scenario_1_Minimal_Routing/sent.txt > Mixed_Criticality_Scenario_1_Minimal_Routing/critical_sent.txt
grep 'From 0'  Mixed_Criticality_Scenario_1_Minimal_Routing/sent.txt >> Mixed_Criticality_Scenario_1_Minimal_Routing/critical_sent.txt

grep 'From: 15'  Mixed_Criticality_Scenario_1_Minimal_Routing/received.txt > Mixed_Criticality_Scenario_1_Minimal_Routing/critical_received.txt
grep 'From: 0'  Mixed_Criticality_Scenario_1_Minimal_Routing/received.txt >> Mixed_Criticality_Scenario_1_Minimal_Routing/critical_received.txt

echo "OVERAL SYSTEM QoS:"
echo ""
python calculate_latency.py -S Mixed_Criticality_Scenario_1_Minimal_Routing/sent.txt -R Mixed_Criticality_Scenario_1_Minimal_Routing/received.txt
echo "--------------------------------------------"
echo "CRITICAL REGION QoS:"
echo ""
python calculate_latency.py -S Mixed_Criticality_Scenario_1_Minimal_Routing/critical_sent.txt -R Mixed_Criticality_Scenario_1_Minimal_Routing/critical_received.txt
