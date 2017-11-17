
touch Synthesis_Results/critical_sent.txt
touch Synthesis_Results/critical_received.txt


grep 'From 15' Synthesis_Results/sent.txt > Synthesis_Results/critical_sent.txt
grep 'From 0'  Synthesis_Results/sent.txt >> Synthesis_Results/critical_sent.txt

grep 'From: 15'  Synthesis_Results/received.txt > Synthesis_Results/critical_received.txt
grep 'From: 0'  Synthesis_Results/received.txt >> Synthesis_Results/critical_received.txt

echo "OVERALL SYSTEM QoS:"
echo ""
python calculate_latency.py -S Synthesis_Results/sent.txt -R Synthesis_Results/received.txt
echo "--------------------------------------------"
echo "CRITICAL REGION QoS:"
echo ""
python calculate_latency.py -S Synthesis_Results/critical_sent.txt -R Synthesis_Results/critical_received.txt
