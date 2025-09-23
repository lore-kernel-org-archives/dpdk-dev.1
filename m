Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1036CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 10:38:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7258640685;
	Tue, 23 Sep 2025 12:38:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id ADF754021F
 for <dev@dpdk.org>; Tue, 23 Sep 2025 12:38:07 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0836A267F;
 Tue, 23 Sep 2025 03:37:59 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.70.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EC6E3F694;
 Tue, 23 Sep 2025 03:38:06 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH v1 2/2] dts: adjust all tests to use the new API calls
Date: Tue, 23 Sep 2025 11:37:58 +0100
Message-Id: <20250923103758.3192015-3-paul.szczepanek@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923103758.3192015-1-paul.szczepanek@arm.com>
References: <20250923103758.3192015-1-paul.szczepanek@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Former calls to TestSuite methods now call API methods.

Depends-on: series-36111 ("Split DTS framework and public API")

Signed-off-by: Paul Szczepanek <paul.szczepanek@arm.com>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/tests/TestSuite_blocklist.py              |  5 +-
 dts/tests/TestSuite_checksum_offload.py       | 14 ++--
 dts/tests/TestSuite_dual_vlan.py              | 26 +++----
 dts/tests/TestSuite_dynamic_config.py         |  8 ++-
 dts/tests/TestSuite_dynamic_queue_conf.py     | 13 ++--
 dts/tests/TestSuite_hello_world.py            |  3 +-
 dts/tests/TestSuite_l2fwd.py                  | 11 ++-
 dts/tests/TestSuite_mac_filter.py             | 16 +++--
 dts/tests/TestSuite_mtu.py                    | 10 +--
 dts/tests/TestSuite_packet_capture.py         | 22 +++---
 dts/tests/TestSuite_pmd_buffer_scatter.py     | 10 +--
 dts/tests/TestSuite_port_control.py           | 14 ++--
 ...stSuite_port_restart_config_persistency.py |  3 +-
 dts/tests/TestSuite_port_stats.py             | 12 ++--
 dts/tests/TestSuite_promisc_support.py        | 20 ++++--
 dts/tests/TestSuite_queue_start_stop.py       |  6 +-
 dts/tests/TestSuite_rte_flow.py               | 70 ++++++++++---------
 dts/tests/TestSuite_smoke_tests.py            |  7 +-
 dts/tests/TestSuite_softnic.py                | 11 ++-
 dts/tests/TestSuite_uni_pkt.py                |  6 +-
 dts/tests/TestSuite_vlan.py                   | 20 +++---
 21 files changed, 178 insertions(+), 129 deletions(-)

diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index 6d3dba6756..ba37f39ab3 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -10,6 +10,7 @@
     LinkTopology,
     requires_link_topology,
 )
+from api.test import verify
 from api.testpmd import TestPmd
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.port import Port
@@ -27,10 +28,10 @@ def _verify_blocklisted_ports(self, ports_to_block: list[Port]) -> None:

             # sanity check
             allowed_len = len(allowlisted_ports - blocklisted_ports)
-            self.verify(allowed_len > 0, "At least one port should have been allowed")
+            verify(allowed_len > 0, "At least one port should have been allowed")

             blocked = not allowlisted_ports & blocklisted_ports
-            self.verify(blocked, "At least one port was not blocklisted")
+            verify(blocked, "At least one port was not blocklisted")

     @func_test
     def no_blocklisted(self) -> None:
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index 70ae9c124c..8e1ec0f142 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -25,6 +25,8 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.packet import send_packet_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import ChecksumOffloadOptions, PacketOffloadFlag
@@ -61,11 +63,11 @@ def _send_packets_and_verify(
                 by the traffic generator.
         """
         for i in range(0, len(packet_list)):
-            received_packets = self.send_packet_and_capture(packet=packet_list[i])
+            received_packets = send_packet_and_capture(packet=packet_list[i])
             received = any(
                 packet.haslayer(Raw) and load in packet.load for packet in received_packets
             )
-            self.verify(
+            verify(
                 received == should_receive,
                 f"Packet was {'dropped' if should_receive else 'received'}",
             )
@@ -85,19 +87,19 @@ def _send_packet_and_verify_checksum(
             id: The destination port that matches the sent packet in verbose output.
         """
         testpmd.start()
-        self.send_packet_and_capture(packet=packet)
+        send_packet_and_capture(packet=packet)
         verbose_output = testpmd.extract_verbose_output(testpmd.stop())
         is_IP = is_L4 = None
         for testpmd_packet in verbose_output:
             if testpmd_packet.l4_dport == id:
                 is_IP = PacketOffloadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD in testpmd_packet.ol_flags
                 is_L4 = PacketOffloadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD in testpmd_packet.ol_flags
-        self.verify(
+        verify(
             is_IP is not None and is_L4 is not None,
             "Test packet was dropped when it should have been received.",
         )
-        self.verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
-        self.verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")
+        verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
+        verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")

     def _setup_hw_offload(self, testpmd: TestPmd) -> None:
         """Sets IP, UDP, and TCP layers to hardware offload.
diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_vlan.py
index a40297ecaa..860eae7424 100644
--- a/dts/tests/TestSuite_dual_vlan.py
+++ b/dts/tests/TestSuite_dual_vlan.py
@@ -18,6 +18,8 @@
 from scapy.layers.l2 import Dot1Q, Ether
 from scapy.packet import Packet, Raw

+from api.packet import send_packet_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
@@ -111,7 +113,7 @@ def _verify_vlan_functions(self, send_packet: Packet, options: TestCaseOptions)
             send_packet: Packet to send for testing.
             options: Flag which defines the currents configured settings in testpmd.
         """
-        recv = self.send_packet_and_capture(send_packet)
+        recv = send_packet_and_capture(send_packet)
         recv = list(filter(self._is_relevant_packet, recv))
         expected_layers: list[Packet] = []

@@ -119,13 +121,13 @@ def _verify_vlan_functions(self, send_packet: Packet, options: TestCaseOptions)
             expected_layers.append(Dot1Q(vlan=self.outer_vlan_tag))
         expected_layers.append(Dot1Q(vlan=self.inner_vlan_tag))

-        self.verify(
+        verify(
             len(recv) > 0,
             f"Expected to receive packet with the payload {expected_layers} but got nothing.",
         )

         for pkt in recv:
-            self.verify(
+            verify(
                 self._pkt_payload_contains_layers(pkt, *expected_layers),
                 f"Received packet ({pkt.summary()}) did not match the expected sequence of layers "
                 f"{expected_layers} with options {options}.",
@@ -175,11 +177,11 @@ def insert_second_vlan(self) -> None:
         with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.tx_vlan_set(port=self.tx_port, enable=True, vlan=self.vlan_insert_tag)
             testpmd.start()
-            recv = self.send_packet_and_capture(
+            recv = send_packet_and_capture(
                 Ether() / Dot1Q(vlan=self.outer_vlan_tag) / Raw(b"X" * 20)
             )
-            self.verify(len(recv) > 0, "Did not receive any packets when testing VLAN insertion.")
-            self.verify(
+            verify(len(recv) > 0, "Did not receive any packets when testing VLAN insertion.")
+            verify(
                 any(
                     self._is_relevant_packet(p)
                     and self._pkt_payload_contains_layers(
@@ -211,9 +213,9 @@ def all_vlan_functions(self) -> None:
         )
         with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.start()
-            recv = self.send_packet_and_capture(send_pkt)
-            self.verify(len(recv) > 0, "Unmodified packet was not received.")
-            self.verify(
+            recv = send_packet_and_capture(send_pkt)
+            verify(len(recv) > 0, "Unmodified packet was not received.")
+            verify(
                 any(
                     self._is_relevant_packet(p)
                     and self._pkt_payload_contains_layers(
@@ -252,9 +254,9 @@ def maintains_priority(self) -> None:
         )
         with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.start()
-            recv = self.send_packet_and_capture(pkt)
-            self.verify(len(recv) > 0, "Did not receive any packets when testing VLAN priority.")
-            self.verify(
+            recv = send_packet_and_capture(pkt)
+            verify(len(recv) > 0, "Did not receive any packets when testing VLAN priority.")
+            verify(
                 any(
                     self._is_relevant_packet(p)
                     and self._pkt_payload_contains_layers(
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 5cc96f2633..7204ec4f73 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -25,6 +25,8 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.packet import send_packet_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
@@ -62,11 +64,11 @@ def _send_packet_and_verify(self, should_receive: bool, mac_address: str) -> Non
             mac_address: Destination MAC address to generate in packet.
         """
         packet = Ether(dst=mac_address) / IP() / Raw(load="xxxxx")
-        received = self.send_packet_and_capture(packet)
+        received = send_packet_and_capture(packet)
         contains_packet = any(
             packet.haslayer(Raw) and b"xxxxx" in packet.load for packet in received
         )
-        self.verify(
+        verify(
             should_receive == contains_packet,
             f"Packet was {'dropped' if should_receive else 'received'}",
         )
@@ -100,7 +102,7 @@ def default_mode(self) -> None:
         """
         with TestPmd() as testpmd:
             is_promisc = testpmd.show_port_info(0).is_promiscuous_mode_enabled
-            self.verify(is_promisc, "Promiscuous mode was not enabled by default.")
+            verify(is_promisc, "Promiscuous mode was not enabled by default.")
             testpmd.start()
             mac = testpmd.show_port_info(0).mac_address
             # send a packet with Rx port mac address
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index bc7f981424..3ddfa31152 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -35,6 +35,8 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.packet import send_packets
+from api.test import fail, verify
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
 from framework.exception import InteractiveCommandExecutionError
@@ -109,7 +111,7 @@ def _wrap(self: "TestDynamicQueueConf", is_rx_testing: bool) -> None:
             self._send_packets_with_different_addresses(self.number_of_packets_to_send)
             forwarding_stats = testpmd.stop()
             for queue_id in queues_to_config:
-                self.verify(
+                verify(
                     self._port_queue_in_stats(port_id, is_rx_testing, queue_id, forwarding_stats),
                     f"Modified queue {queue_id} on port {port_id} failed to receive traffic after"
                     "being started again.",
@@ -172,7 +174,7 @@ def _send_packets_with_different_addresses(self, number_of_packets: int) -> None
             / Raw()
             for i in range(number_of_packets)
         ]
-        self.send_packets(packets_to_send)
+        send_packets(packets_to_send)

     def _port_queue_in_stats(
         self, port_id: int, is_rx_queue: bool, queue_id: int, stats: str
@@ -226,8 +228,7 @@ def _modify_ring_size(
             # The testpmd method verifies that the modification worked, so we catch that error
             # and just re-raise it as a test case failure
             except InteractiveCommandExecutionError:
-                self.verify(
-                    False,
+                fail(
                     f"Failed to update the ring size of queue {queue_id} on port "
                     f"{port_id} at runtime",
                 )
@@ -264,12 +265,12 @@ def _stop_queues(
         # it means there could be another reason for the packets not transmitting and,
         # therefore, a false positive result.
         for unchanged_q_id in unchanged_queues:
-            self.verify(
+            verify(
                 self._port_queue_in_stats(port_id, is_rx_testing, unchanged_q_id, forwarding_stats),
                 f"Queue {unchanged_q_id} failed to receive traffic.",
             )
         for stopped_q_id in queues_to_modify:
-            self.verify(
+            verify(
                 not self._port_queue_in_stats(
                     port_id, is_rx_testing, stopped_q_id, forwarding_stats
                 ),
diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hello_world.py
index 3560e9ec0b..bf1a93c782 100644
--- a/dts/tests/TestSuite_hello_world.py
+++ b/dts/tests/TestSuite_hello_world.py
@@ -8,6 +8,7 @@
 are properly configured.
 """

+from api.test import log
 from api.testpmd import TestPmd
 from framework.test_suite import BaseConfig, TestSuite, func_test

@@ -36,4 +37,4 @@ def hello_world(self) -> None:
         """
         with TestPmd() as testpmd:
             testpmd.start()
-        self.log(self.config.msg)
+        log(self.config.msg)
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index bc1b5162c3..596b892730 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -13,6 +13,11 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.packet import (
+    get_expected_packets,
+    match_all_packets,
+    send_packets_and_capture,
+)
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from framework.context import filter_cores
@@ -66,8 +71,8 @@ def l2fwd_integrity(self) -> None:
                 shell.set_ports_queues(queues_num)
                 shell.start()

-                received_packets = self.send_packets_and_capture(self.packets)
-                expected_packets = self.get_expected_packets(self.packets)
-                self.match_all_packets(expected_packets, received_packets)
+                received_packets = send_packets_and_capture(self.packets)
+                expected_packets = get_expected_packets(self.packets)
+                match_all_packets(expected_packets, received_packets)

                 shell.stop()
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index 6a51f9df4e..a7e24b37d5 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -23,6 +23,8 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.packet import send_packet_and_capture
+from api.test import fail, verify
 from api.testpmd import TestPmd
 from framework.exception import InteractiveCommandExecutionError
 from framework.test_suite import TestSuite, func_test
@@ -73,16 +75,16 @@ def _send_packet_and_verify(
         packet.dst = mac_address
         received_packets = [
             packets
-            for packets in self.send_packet_and_capture(packet)
+            for packets in send_packet_and_capture(packet)
             if hasattr(packets, "load") and "X" * 22 in str(packets.load)
         ]
         if should_receive:
-            self.verify(
+            verify(
                 len(received_packets) == 1,
                 "Packet sent by test case should be forwarded and received.",
             )
         else:
-            self.verify(
+            verify(
                 len(received_packets) == 0,
                 "Packet sent by test case should not be forwarded and received.",
             )
@@ -160,12 +162,12 @@ def invalid_address(self) -> None:
             mac_address = self.topology.sut_port_ingress.mac_address
             try:
                 testpmd.set_mac_addr(0, "00:00:00:00:00:00", add=True)
-                self.verify(False, "Invalid mac address added.")
+                fail("Invalid mac address added.")
             except InteractiveCommandExecutionError:
                 pass
             try:
                 testpmd.set_mac_addr(0, mac_address, add=False)
-                self.verify(False, "Default mac address removed.")
+                fail("Default mac address removed.")
             except InteractiveCommandExecutionError:
                 pass
             # Should be no errors adding this twice
@@ -174,7 +176,7 @@ def invalid_address(self) -> None:
             # Double check to see if default mac address can be removed
             try:
                 testpmd.set_mac_addr(0, mac_address, add=False)
-                self.verify(False, "Default mac address removed.")
+                fail("Default mac address removed.")
             except InteractiveCommandExecutionError:
                 pass

@@ -190,7 +192,7 @@ def invalid_address(self) -> None:
                 testpmd.set_mac_addr(0, "E" + mac_address[1:], add=True)
                 # We add an extra address to compensate for mac address pool inconsistencies.
                 testpmd.set_mac_addr(0, "F" + mac_address[1:], add=True)
-                self.verify(False, "Mac address limit exceeded.")
+                fail("Mac address limit exceeded.")
             except InteractiveCommandExecutionError:
                 pass

diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index 8a14c791f7..8355495d33 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -21,6 +21,8 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.packet import send_packet_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from framework.test_suite import TestSuite, func_test

@@ -74,7 +76,7 @@ def _send_packet_and_verify(self, pkt_size: int, should_receive: bool) -> None:
         padding = pkt_size - IP_HEADER_LEN
         # Insert '    ' as placeholder 'CRC' error correction.
         packet = Ether() / Raw(load="    ") / IP(len=pkt_size) / Raw(load="X" * padding)
-        received_packets = self.send_packet_and_capture(packet)
+        received_packets = send_packet_and_capture(packet)
         found = any(
             ("X" * padding) in str(packets.load)
             for packets in received_packets
@@ -82,9 +84,9 @@ def _send_packet_and_verify(self, pkt_size: int, should_receive: bool) -> None:
         )

         if should_receive:
-            self.verify(found, "Did not receive packet.")
+            verify(found, "Did not receive packet.")
         else:
-            self.verify(not found, "Received packet.")
+            verify(not found, "Received packet.")

     def _assess_mtu_boundary(self, testpmd_shell: TestPmd, mtu: int) -> None:
         """Sets the new MTU and verifies packets at the set boundary.
@@ -118,7 +120,7 @@ def _assess_mtu_boundary(self, testpmd_shell: TestPmd, mtu: int) -> None:
         self._send_packet_and_verify(pkt_size=equal_frame_size, should_receive=True)

         current_mtu = testpmd_shell.show_port_info(0).mtu
-        self.verify(current_mtu is not None, "Error grabbing testpmd MTU value.")
+        verify(current_mtu is not None, "Error grabbing testpmd MTU value.")
         if current_mtu and (
             current_mtu >= STANDARD_MTU + VENDOR_AGNOSTIC_PADDING and mtu == STANDARD_MTU
         ):
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index dcd947043a..4bd15e2401 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -30,6 +30,12 @@
     LinkTopology,
     requires_link_topology,
 )
+from api.packet import (
+    get_expected_packets,
+    match_all_packets,
+    send_packets_and_capture,
+)
+from api.test import verify
 from api.testpmd import TestPmd
 from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
@@ -139,7 +145,7 @@ def _send_and_dump(
                 )
             )

-        received_packets = self.send_packets_and_capture(
+        received_packets = send_packets_and_capture(
             self.packets, PacketFilteringConfig(no_lldp=False)
         )

@@ -166,18 +172,18 @@ def dumpcap(self) -> None:
             testpmd.start()
             received_packets = self._send_and_dump()

-            expected_packets = self.get_expected_packets(self.packets, sent_from_tg=True)
+            expected_packets = get_expected_packets(self.packets, sent_from_tg=True)
             with self.rx_pcap.open() as fd:
                 rx_pcap_packets = list(rdpcap(fd))
-                self.verify(
-                    self.match_all_packets(expected_packets, rx_pcap_packets, verify=False),
+                verify(
+                    match_all_packets(expected_packets, rx_pcap_packets, verify=False),
                     "Rx packets from dumpcap weren't the same as the expected packets.",
                 )

             with self.tx_pcap.open() as fd:
                 tx_pcap_packets = list(rdpcap(fd))
-                self.verify(
-                    self.match_all_packets(tx_pcap_packets, received_packets, verify=False),
+                verify(
+                    match_all_packets(tx_pcap_packets, received_packets, verify=False),
                     "Tx packets from dumpcap weren't the same as the packets received by Scapy.",
                 )

@@ -198,14 +204,14 @@ def dumpcap_filter(self) -> None:
             self._send_and_dump("tcp", rx_only=True)
             filtered_packets = [
                 raw(p)
-                for p in self.get_expected_packets(self.packets, sent_from_tg=True)
+                for p in get_expected_packets(self.packets, sent_from_tg=True)
                 if not p.haslayer(TCP)
             ]

             with self.rx_pcap.open() as fd:
                 rx_pcap_packets = [raw(p) for p in rdpcap(fd)]
                 for filtered_packet in filtered_packets:
-                    self.verify(
+                    verify(
                         filtered_packet not in rx_pcap_packets,
                         "Found a packet in the pcap that was meant to be filtered out.",
                     )
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
index 06d2e5f7e5..b49fba4cfc 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
@@ -26,6 +26,8 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.packet import send_packet_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
@@ -87,14 +89,14 @@ def _scatter_pktgen_send_packet(self, pkt_size: int) -> list[Packet]:
         # pack the payload
         for X_in_hex in payload:
             packet.load += struct.pack("=B", int("%s%s" % (X_in_hex[0], X_in_hex[1]), 16))
-        received_packets = self.send_packet_and_capture(packet)
+        received_packets = send_packet_and_capture(packet)
         # filter down the list to packets that have the appropriate structure
         received_packets = [p for p in received_packets if Ether in p and IP in p and Raw in p]

-        self.verify(len(received_packets) > 0, "Did not receive any packets.")
+        verify(len(received_packets) > 0, "Did not receive any packets.")

         layer2 = received_packets[0].getlayer(2)
-        self.verify(layer2 is not None, "The received packet is invalid.")
+        verify(layer2 is not None, "The received packet is invalid.")
         assert layer2 is not None

         return received_packets
@@ -126,7 +128,7 @@ def _pmd_scatter(self, mb_size: int, enable_offload: bool = False) -> None:
             for offset in [-1, 0, 1, 4, 5]:
                 recv_packets = self._scatter_pktgen_send_packet(mb_size + offset)
                 self._logger.debug(f"Relevant captured packets: \n{recv_packets}")
-                self.verify(
+                verify(
                     any(" ".join(["58"] * 8) in hexstr(pkt, onlyhex=1) for pkt in recv_packets),
                     "Payload of scattered packet did not match expected payload with offset "
                     f"{offset}.",
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index df11df4d39..d9cc5ff4c9 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -18,6 +18,8 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.packet import send_packets_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
@@ -40,8 +42,8 @@ def _send_packets_and_verify(self) -> None:
         send_p = Ether() / Raw(payload.encode("utf-8"))
         recv_pakts: list[Packet] = []
         for _ in range(int(num_pakts / 25)):
-            recv_pakts += self.send_packets_and_capture([send_p] * 25)
-        recv_pakts += self.send_packets_and_capture([send_p] * (num_pakts % 25))
+            recv_pakts += send_packets_and_capture([send_p] * 25)
+        recv_pakts += send_packets_and_capture([send_p] * (num_pakts % 25))
         recv_pakts = [
             p
             for p in recv_pakts
@@ -51,7 +53,7 @@ def _send_packets_and_verify(self) -> None:
                 hasattr(p, "load") and p.load.decode("utf-8").replace("\x00", "") == payload
             )
         ]
-        self.verify(
+        verify(
             len(recv_pakts) == num_pakts,
             f"Received {len(recv_pakts)} packets when {num_pakts} were expected.",
         )
@@ -89,7 +91,7 @@ def stop_ports(self) -> None:
         """
         with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.stop_all_ports()
-            self.verify(
+            verify(
                 all(not p.is_link_up for p in testpmd.show_port_info_all()),
                 "Failed to stop all ports.",
             )
@@ -108,6 +110,4 @@ def close_ports(self) -> None:
         """
         with TestPmd() as testpmd:
             testpmd.close_all_ports()
-            self.verify(
-                len(testpmd.show_port_info_all()) == 0, "Failed to close all ports in testpmd."
-            )
+            verify(len(testpmd.show_port_info_all()) == 0, "Failed to close all ports in testpmd.")
diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts/tests/TestSuite_port_restart_config_persistency.py
index 7666c9ea7a..4ea22b6d70 100644
--- a/dts/tests/TestSuite_port_restart_config_persistency.py
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py
@@ -13,6 +13,7 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.types import TestPmdPortFlowCtrl
 from framework.test_suite import TestSuite, func_test
@@ -49,7 +50,7 @@ def _restart_port_and_verify(self, id: int, testpmd: TestPmd, changed_value: str
         if flow_info_after:
             all_info_after.update(asdict(flow_info_after))

-        self.verify(
+        verify(
             all_info_before == all_info_after,
             f"Port configuration for {changed_value} was not retained through port restart.",
         )
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_stats.py
index d0b3b33563..3dc045f847 100644
--- a/dts/tests/TestSuite_port_stats.py
+++ b/dts/tests/TestSuite_port_stats.py
@@ -23,6 +23,8 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.packet import send_packet_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
@@ -142,7 +144,7 @@ def stats_updates(self) -> None:
             testpmd.set_verbose(3)
             testpmd.start()
             testpmd.clear_port_stats_all()
-            self.send_packet_and_capture(self._send_pkt)
+            send_packet_and_capture(self._send_pkt)
             port_stats_all, forwarding_info = testpmd.show_port_stats_all()
             verbose_information = TestPmd.extract_verbose_output(forwarding_info)

@@ -155,21 +157,21 @@ def stats_updates(self) -> None:
         recv_relevant_bytes = port_stats_all[self.recv_port].rx_bytes - rx_irr_bytes
         sent_relevant_bytes = port_stats_all[self.send_port].tx_bytes - tx_irr_bytes

-        self.verify(
+        verify(
             recv_relevant_packets == 1,
             f"Port {self.recv_port} received {recv_relevant_packets} packets but expected to only "
             "receive 1.",
         )
-        self.verify(
+        verify(
             recv_relevant_bytes == self.total_packet_len,
             f"Number of bytes received by port {self.recv_port} did not match the amount sent.",
         )
-        self.verify(
+        verify(
             sent_relevant_packets == 1,
             f"Number was packets sent by port {self.send_port} was not equal to the number "
             f"received by port {self.recv_port}.",
         )
-        self.verify(
+        verify(
             sent_relevant_bytes == self.total_packet_len,
             f"Number of bytes sent by port {self.send_port} did not match the number of bytes "
             f"received by port {self.recv_port}.",
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_promisc_support.py
index 089db4a3ec..a0c65dc662 100644
--- a/dts/tests/TestSuite_promisc_support.py
+++ b/dts/tests/TestSuite_promisc_support.py
@@ -15,6 +15,12 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.packet import (
+    get_expected_packets,
+    match_all_packets,
+    send_packets_and_capture,
+)
+from api.test import verify
 from api.testpmd import TestPmd
 from framework.test_suite import TestSuite, func_test

@@ -48,9 +54,9 @@ def promisc_packets(self) -> None:
                 testpmd.set_promisc(port=port_id, enable=True, verify=True)
             testpmd.start()

-            received_packets = self.send_packets_and_capture(packet)
-            expected_packets = self.get_expected_packets(packet, sent_from_tg=True)
-            self.match_all_packets(expected_packets, received_packets)
+            received_packets = send_packets_and_capture(packet)
+            expected_packets = get_expected_packets(packet, sent_from_tg=True)
+            match_all_packets(expected_packets, received_packets)

             testpmd.stop()

@@ -58,9 +64,9 @@ def promisc_packets(self) -> None:
                 testpmd.set_promisc(port=port_id, enable=False, verify=True)
             testpmd.start()

-            received_packets = self.send_packets_and_capture(packet)
-            expected_packets = self.get_expected_packets(packet, sent_from_tg=True)
-            self.verify(
-                not self.match_all_packets(expected_packets, received_packets, verify=False),
+            received_packets = send_packets_and_capture(packet)
+            expected_packets = get_expected_packets(packet, sent_from_tg=True)
+            verify(
+                not match_all_packets(expected_packets, received_packets, verify=False),
                 "Invalid packet wasn't filtered out.",
             )
diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuite_queue_start_stop.py
index e0dd39fd96..e9048d4245 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_start_stop.py
@@ -22,6 +22,8 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.packet import send_packet_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
@@ -49,11 +51,11 @@ def _send_packet_and_verify(self, should_receive: bool = True) -> None:
             should_receive: Indicate whether the packet should be received.
         """
         packet = Ether() / IP() / Raw(load="xxxxx")
-        received = self.send_packet_and_capture(packet)
+        received = send_packet_and_capture(packet)
         contains_packet = any(
             packet.haslayer(Raw) and b"xxxxx" in packet.load for packet in received
         )
-        self.verify(
+        verify(
             should_receive == contains_packet,
             f"Packet was {'dropped' if should_receive else 'received'}",
         )
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 79b16973eb..207cbce2d3 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -23,6 +23,8 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.packet import send_packet_and_capture
+from api.test import fail, log, verify, verify_else_skip
 from api.testpmd import TestPmd
 from api.testpmd.types import FlowRule
 from framework.exception import InteractiveCommandExecutionError
@@ -91,13 +93,13 @@ def zip_lists(
         with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
             for flow, packet, expected_packet in zip_lists(flows, packets, expected_packets):
                 is_valid = testpmd.flow_validate(flow_rule=flow, port_id=port_id)
-                self.verify_else_skip(is_valid, "flow rule failed validation.")
+                verify_else_skip(is_valid, "flow rule failed validation.")

                 try:
                     flow_id = testpmd.flow_create(flow_rule=flow, port_id=port_id)
                 except InteractiveCommandExecutionError:
-                    self.log("Flow rule validation passed, but flow creation failed.")
-                    self.verify(False, "Failed flow creation")
+                    log("Flow rule validation passed, but flow creation failed.")
+                    fail("Failed flow creation")

                 if verification_method == self._send_packet_and_verify:
                     verification_method(packet=packet, *args, **kwargs)
@@ -119,11 +121,11 @@ def _send_packet_and_verify(self, packet: Packet, should_receive: bool = True) -
             packet: Scapy packet to send and verify.
             should_receive: Indicate whether the packet should be received.
         """
-        received = self.send_packet_and_capture(packet)
+        received = send_packet_and_capture(packet)
         contains_packet = any(
             packet.haslayer(Raw) and b"xxxxx" in packet.load for packet in received
         )
-        self.verify(
+        verify(
             should_receive == contains_packet,
             f"Packet was {'dropped' if should_receive else 'received'}",
         )
@@ -140,13 +142,13 @@ def _send_packet_and_verify_queue(
         """
         testpmd.set_verbose(level=8)
         testpmd.start()
-        self.send_packet_and_capture(packet=packet)
+        send_packet_and_capture(packet=packet)
         verbose_output = testpmd.extract_verbose_output(testpmd.stop())
         received = False
         for testpmd_packet in verbose_output:
             if testpmd_packet.queue_id == test_queue:
                 received = True
-        self.verify(received, f"Expected packet was not received on queue {test_queue}")
+        verify(received, f"Expected packet was not received on queue {test_queue}")

     def _send_packet_and_verify_modification(self, packet: Packet, expected_packet: Packet) -> None:
         """Send packet and verify the expected modifications are present upon reception.
@@ -155,15 +157,15 @@ def _send_packet_and_verify_modification(self, packet: Packet, expected_packet:
             packet: Scapy packet to send to the SUT.
             expected_packet: Scapy packet that should match the received packet.
         """
-        received = self.send_packet_and_capture(packet)
+        received = send_packet_and_capture(packet)

         # verify reception
-        self.verify(received != [], "Packet was never received.")
+        verify(received != [], "Packet was never received.")

-        self.log(f"SENT PACKET:     {packet.summary()}")
-        self.log(f"EXPECTED PACKET: {expected_packet.summary()}")
+        log(f"SENT PACKET:     {packet.summary()}")
+        log(f"EXPECTED PACKET: {expected_packet.summary()}")
         for packet in received:
-            self.log(f"RECEIVED PACKET: {packet.summary()}")
+            log(f"RECEIVED PACKET: {packet.summary()}")

         expected_ip_dst = expected_packet[IP].dst if IP in expected_packet else None
         received_ip_dst = received[IP].dst if IP in received else None
@@ -173,13 +175,13 @@ def _send_packet_and_verify_modification(self, packet: Packet, expected_packet:

         # verify modification
         if expected_ip_dst is not None:
-            self.verify(
+            verify(
                 received_ip_dst == expected_ip_dst,
                 f"IPv4 dst mismatch: expected {expected_ip_dst}, got {received_ip_dst}",
             )

         if expected_mac_dst is not None:
-            self.verify(
+            verify(
                 received_mac_dst == expected_mac_dst,
                 f"MAC dst mismatch: expected {expected_mac_dst}, got {received_mac_dst}",
             )
@@ -202,23 +204,23 @@ def _send_packet_and_verify_jump(
         testpmd.set_verbose(level=8)
         for flow in flow_rules:
             is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
-            self.verify_else_skip(is_valid, "flow rule failed validation.")
+            verify_else_skip(is_valid, "flow rule failed validation.")

             try:
                 testpmd.flow_create(flow_rule=flow, port_id=0)
             except InteractiveCommandExecutionError:
-                self.log("Flow validation passed, but flow creation failed.")
-                self.verify(False, "Failed flow creation")
+                log("Flow validation passed, but flow creation failed.")
+                fail("Failed flow creation")

         for packet, test_queue in zip(packets, test_queues):
             testpmd.start()
-            self.send_packet_and_capture(packet=packet)
+            send_packet_and_capture(packet=packet)
             verbose_output = testpmd.extract_verbose_output(testpmd.stop())
             received = False
             for testpmd_packet in verbose_output:
                 if testpmd_packet.queue_id == test_queue:
                     received = True
-            self.verify(received, f"Expected packet was not received on queue {test_queue}")
+            verify(received, f"Expected packet was not received on queue {test_queue}")

     @func_test
     def queue_action_ETH(self) -> None:
@@ -439,8 +441,8 @@ def drop_action_ETH(self) -> None:
         packet = Ether() / IP() / Raw(load="xxxxx")
         with TestPmd() as testpmd:
             testpmd.start()
-            received = self.send_packet_and_capture(packet)
-            self.verify(received != [], "Test packet was never received.")
+            received = send_packet_and_capture(packet)
+            verify(received != [], "Test packet was never received.")
         self._runner(
             verification_method=self._send_packet_and_verify,
             flows=flow_list,
@@ -494,8 +496,8 @@ def drop_action_IP(self) -> None:
         packet = Ether() / IP() / Raw(load="xxxxx")
         with TestPmd() as testpmd:
             testpmd.start()
-            received = self.send_packet_and_capture(packet)
-            self.verify(received != [], "Test packet was never received.")
+            received = send_packet_and_capture(packet)
+            verify(received != [], "Test packet was never received.")
         self._runner(
             verification_method=self._send_packet_and_verify,
             flows=flow_list,
@@ -545,8 +547,8 @@ def drop_action_L4(self) -> None:
         packet = Ether() / IP() / Raw(load="xxxxx")
         with TestPmd() as testpmd:
             testpmd.start()
-            received = self.send_packet_and_capture(packet)
-            self.verify(received != [], "Test packet was never received.")
+            received = send_packet_and_capture(packet)
+            verify(received != [], "Test packet was never received.")
         self._runner(
             verification_method=self._send_packet_and_verify,
             flows=flow_list,
@@ -584,8 +586,8 @@ def drop_action_VLAN(self) -> None:
         packet = Ether() / IP() / Raw(load="xxxxx")
         with TestPmd() as testpmd:
             testpmd.start()
-            received = self.send_packet_and_capture(packet)
-            self.verify(received != [], "Test packet was never received.")
+            received = send_packet_and_capture(packet)
+            verify(received != [], "Test packet was never received.")
         self._runner(
             verification_method=self._send_packet_and_verify,
             flows=flow_list,
@@ -674,8 +676,8 @@ def egress_rules(self) -> None:
         packet = Ether() / IP() / Raw(load="xxxxx")
         with TestPmd() as testpmd:
             testpmd.start()
-            received = self.send_packet_and_capture(packet)
-            self.verify(received != [], "Test packet was never received.")
+            received = send_packet_and_capture(packet)
+            verify(received != [], "Test packet was never received.")
         self._runner(
             verification_method=self._send_packet_and_verify,
             flows=flow_list,
@@ -779,17 +781,17 @@ def priority_attribute(self) -> None:
             testpmd.set_verbose(level=8)
             for flow, expected_queue in zip(flow_list, expected_queue_list):
                 is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
-                self.verify_else_skip(is_valid, "flow rule failed validation.")
+                verify_else_skip(is_valid, "flow rule failed validation.")
                 try:
                     testpmd.flow_create(flow_rule=flow, port_id=0)
                 except InteractiveCommandExecutionError:
-                    self.log("Flow rule validation passed, but flow creation failed.")
-                    self.verify(False, "Failed flow creation")
+                    log("Flow rule validation passed, but flow creation failed.")
+                    fail("Failed flow creation")
                 testpmd.start()
-                self.send_packet_and_capture(test_packet)
+                send_packet_and_capture(test_packet)
                 verbose_output = testpmd.extract_verbose_output(testpmd.stop())
                 received = False
                 for testpmd_packet in verbose_output:
                     if testpmd_packet.queue_id == expected_queue:
                         received = True
-                self.verify(received, f"Packet was not received on queue {expected_queue}")
+                verify(received, f"Packet was not received on queue {expected_queue}")
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 4211f5d97d..271ad4301c 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -18,6 +18,7 @@
     LinkTopology,
     requires_link_topology,
 )
+from api.test import verify
 from api.testpmd import TestPmd
 from framework.config.node import PortConfig
 from framework.settings import SETTINGS
@@ -119,7 +120,7 @@ def devices_listed_in_testpmd(self) -> None:
         with TestPmd() as testpmd:
             dev_list = [str(x) for x in testpmd.get_devices()]
         for nic in self.nics_in_node:
-            self.verify(
+            verify(
                 nic.pci in dev_list,
                 f"Device {nic.pci} was not listed in testpmd's available devices, "
                 "please check your configuration",
@@ -156,13 +157,13 @@ def device_bound_to_driver(self) -> None:
                 rf"{nic.pci}.*drv=(\S+) [^\\n]*",
                 all_nics_in_dpdk_devbind,
             )
-            self.verify(
+            verify(
                 devbind_info_for_nic is not None,
                 f"Failed to find configured device ({nic.pci}) using dpdk-devbind.py",
             )
             # We know this isn't None, but mypy doesn't
             assert devbind_info_for_nic is not None
-            self.verify(
+            verify(
                 devbind_info_for_nic.group(1) == nic.os_driver_for_dpdk,
                 f"Driver for device {nic.pci} does not match driver listed in "
                 f"configuration (bound to {devbind_info_for_nic.group(1)})",
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index 44cd066998..fa91f7ee2f 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -13,6 +13,11 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.packet import (
+    get_expected_packets,
+    match_all_packets,
+    send_packets_and_capture,
+)
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
 from framework.test_suite import TestSuite, func_test
@@ -96,9 +101,9 @@ def softnic(self) -> None:
             port_topology=None,
         ) as shell:
             shell.start()
-            received_packets = self.send_packets_and_capture(self.packets)
+            received_packets = send_packets_and_capture(self.packets)
             # packets are being forwarded without addresses being amended so
             # we get the address as it would be expected to come from TG
-            expected_packets = self.get_expected_packets(self.packets, sent_from_tg=True)
+            expected_packets = get_expected_packets(self.packets, sent_from_tg=True)

-            self.match_all_packets(expected_packets, received_packets)
+            match_all_packets(expected_packets, received_packets)
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index d258f95d24..97d61cd03a 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -25,6 +25,8 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.packet import send_packet_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
@@ -55,10 +57,10 @@ def _send_packet_and_verify_flags(
         self, expected_flag: RtePTypes, packet: Packet, testpmd: TestPmd
     ) -> None:
         """Sends a packet to the DUT and verifies the verbose ptype flags."""
-        self.send_packet_and_capture(packet=packet)
+        send_packet_and_capture(packet=packet)
         verbose_output = testpmd.extract_verbose_output(testpmd.stop())
         valid = self._check_for_matching_packet(output=verbose_output, flags=expected_flag)
-        self.verify(valid, f"Packet type flag did not match the expected flag: {expected_flag}.")
+        verify(valid, f"Packet type flag did not match the expected flag: {expected_flag}.")

     def _setup_session(
         self, testpmd: TestPmd, expected_flags: list[RtePTypes], packet_list=list[Packet]
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index 6c1b181c74..0ef63562b6 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -21,6 +21,8 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.packet import send_packet_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
@@ -55,30 +57,30 @@ def _send_vlan_packet_and_verify(self, should_receive: bool, strip: bool, vlan_i
             vlan_id: Expected VLAN ID.
         """
         packet = Ether() / Dot1Q(vlan=vlan_id) / Raw(load="xxxxx")
-        received_packets = self.send_packet_and_capture(packet)
+        received_packets = send_packet_and_capture(packet)
         test_packet = None
         for packet in received_packets:
             if hasattr(packet, "load") and b"xxxxx" in packet.load:
                 test_packet = packet
                 break
         if should_receive:
-            self.verify(
+            verify(
                 test_packet is not None,
                 "Packet was dropped when it should have been received",
             )
             if test_packet is not None:
                 if strip:
-                    self.verify(
+                    verify(
                         not test_packet.haslayer(Dot1Q),
                         "VLAN tag was not stripped successfully",
                     )
                 else:
-                    self.verify(
+                    verify(
                         test_packet.vlan == vlan_id,
                         "The received tag did not match the expected tag",
                     )
         else:
-            self.verify(
+            verify(
                 test_packet is None,
                 "Packet was received when it should have been dropped",
             )
@@ -90,22 +92,22 @@ def _send_packet_and_verify_insertion(self, expected_id: int) -> None:
             expected_id: The VLAN id that is being inserted through tx_offload configuration.
         """
         packet = Ether() / Raw(load="xxxxx")
-        received_packets = self.send_packet_and_capture(packet)
+        received_packets = send_packet_and_capture(packet)
         test_packet = None
         for packet in received_packets:
             if hasattr(packet, "load") and b"xxxxx" in packet.load:
                 test_packet = packet
                 break
-        self.verify(
+        verify(
             test_packet is not None,
             "Packet was dropped when it should have been received",
         )
         if test_packet is not None:
-            self.verify(
+            verify(
                 test_packet.haslayer(Dot1Q) == 1,
                 "The received packet did not have a VLAN tag",
             )
-            self.verify(
+            verify(
                 test_packet.vlan == expected_id,
                 "The received tag did not match the expected tag",
             )
--
2.39.5

