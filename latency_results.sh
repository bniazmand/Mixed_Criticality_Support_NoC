
touch Separate_NoC_Regions_Minimal/critical_sent.txt
touch Separate_NoC_Regions_Minimal/critical_received.txt


grep 'From 15' Separate_NoC_Regions_Minimal/sent.txt > Separate_NoC_Regions_Minimal/critical_sent.txt
grep 'From 0'  Separate_NoC_Regions_Minimal/sent.txt >> Separate_NoC_Regions_Minimal/critical_sent.txt

grep 'From: 15'  Separate_NoC_Regions_Minimal/received.txt > Separate_NoC_Regions_Minimal/critical_received.txt
grep 'From: 0'  Separate_NoC_Regions_Minimal/received.txt >> Separate_NoC_Regions_Minimal/critical_received.txt

echo "OVERALL SYSTEM QoS:"
echo ""
python calculate_latency.py -S Separate_NoC_Regions_Minimal/sent.txt -R Separate_NoC_Regions_Minimal/received.txt
echo "--------------------------------------------"
echo "CRITICAL REGION QoS:"
echo ""
python calculate_latency.py -S Separate_NoC_Regions_Minimal/critical_sent.txt -R Separate_NoC_Regions_Minimal/critical_received.txt
