Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8B4CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 19:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2E8C4066C;
	Wed, 10 Sep 2025 21:43:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 59BF940653
 for <dev@dpdk.org>; Wed, 10 Sep 2025 21:43:12 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E90016F8;
 Wed, 10 Sep 2025 12:43:03 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.66.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B04843F694;
 Wed, 10 Sep 2025 12:43:10 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: Thomas Wilks <thomas.wilks@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH v1 1/1] dts: update testsuite docs
Date: Wed, 10 Sep 2025 20:42:59 +0100
Message-Id: <20250910194259.1027220-2-paul.szczepanek@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910194259.1027220-1-paul.szczepanek@arm.com>
References: <20250910194259.1027220-1-paul.szczepanek@arm.com>
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

From: Thomas Wilks <thomas.wilks@arm.com>

Updated and corrected test case doc strings inside of test suites.

Changed helper functions inside of testsuites into private functions
and removed doc strings where redundant.

Depends-on: series-36111 ("Split DTS framework and public API")

Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
Signed-off-by: Paul Szczepanek <paul.szczepanek@arm.com>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/tests/TestSuite_blocklist.py              |  23 +-
 dts/tests/TestSuite_checksum_offload.py       | 126 +++++------
 dts/tests/TestSuite_dual_vlan.py              |  85 +++-----
 dts/tests/TestSuite_dynamic_config.py         |  67 +++---
 dts/tests/TestSuite_dynamic_queue_conf.py     |  74 +++++--
 dts/tests/TestSuite_hello_world.py            |   5 +-
 dts/tests/TestSuite_l2fwd.py                  |  10 +-
 dts/tests/TestSuite_mac_filter.py             |  48 +++--
 dts/tests/TestSuite_mtu.py                    |  98 ++++-----
 dts/tests/TestSuite_packet_capture.py         |  10 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |  30 ++-
 dts/tests/TestSuite_port_control.py           |  30 +--
 ...stSuite_port_restart_config_persistency.py |  26 +--
 dts/tests/TestSuite_port_stats.py             |  16 +-
 dts/tests/TestSuite_promisc_support.py        |  16 +-
 dts/tests/TestSuite_queue_start_stop.py       |  62 +++---
 dts/tests/TestSuite_rte_flow.py               | 200 +++++++++---------
 dts/tests/TestSuite_smoke_tests.py            |  29 ++-
 dts/tests/TestSuite_softnic.py                |  11 +-
 dts/tests/TestSuite_uni_pkt.py                |  96 ++++-----
 dts/tests/TestSuite_vlan.py                   |  58 +++--
 21 files changed, 619 insertions(+), 501 deletions(-)

diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index 2cff6e2805..6d3dba6756 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -19,7 +19,7 @@
 class TestBlocklist(TestSuite):
     """DPDK device blocklisting test suite."""

-    def verify_blocklisted_ports(self, ports_to_block: list[Port]) -> None:
+    def _verify_blocklisted_ports(self, ports_to_block: list[Port]) -> None:
         """Runs testpmd with the given ports blocklisted and verifies the ports."""
         with TestPmd(allowed_ports=[], blocked_ports=ports_to_block) as testpmd:
             allowlisted_ports = {port.device_name for port in testpmd.show_port_info_all()}
@@ -37,30 +37,33 @@ def no_blocklisted(self) -> None:
         """Run testpmd with no blocklisted device.

         Steps:
-            Run testpmd without specifying allowed or blocked ports.
+            * Run testpmd without specifying allowed or blocked ports.
+
         Verify:
-            That no ports were blocked.
+            * No ports were blocked.
         """
-        self.verify_blocklisted_ports([])
+        self._verify_blocklisted_ports([])

     @func_test
     def one_port_blocklisted(self) -> None:
         """Run testpmd with one blocklisted port.

         Steps:
-            Run testpmd with one only one blocklisted port and allowing all the other ones.
+            * Run testpmd with only one blocklisted port and allowing all the other ones.
+
         Verify:
-            That the port was successfully blocklisted.
+            * Port was successfully blocklisted.
         """
-        self.verify_blocklisted_ports(self.topology.sut_ports[:1])
+        self._verify_blocklisted_ports(self.topology.sut_ports[:1])

     @func_test
     def all_but_one_port_blocklisted(self) -> None:
         """Run testpmd with all but one blocklisted port.

         Steps:
-            Run testpmd with only one allowed port, blocking all the other ones.
+            * Run testpmd with only one allowed port, blocking all the other ones.
+
         Verify:
-            That all specified ports were successfully blocklisted.
+            * All specified ports were successfully blocklisted.
         """
-        self.verify_blocklisted_ports(self.topology.sut_ports[:-1])
+        self._verify_blocklisted_ports(self.topology.sut_ports[:-1])
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index 7b9c510f0e..70ae9c124c 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -49,7 +49,7 @@ class TestChecksumOffload(TestSuite):

     """

-    def send_packets_and_verify(
+    def _send_packets_and_verify(
         self, packet_list: List[Packet], load: bytes, should_receive: bool
     ) -> None:
         """Iterates through a list of packets and verifies they are received.
@@ -70,7 +70,7 @@ def send_packets_and_verify(
                 f"Packet was {'dropped' if should_receive else 'received'}",
             )

-    def send_packet_and_verify_checksum(
+    def _send_packet_and_verify_checksum(
         self, packet: Packet, good_L4: bool, good_IP: bool, testpmd: TestPmd, id: int
     ) -> None:
         """Send packet and verify verbose output matches expected output.
@@ -99,7 +99,7 @@ def send_packet_and_verify_checksum(
         self.verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
         self.verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")

-    def setup_hw_offload(self, testpmd: TestPmd) -> None:
+    def _setup_hw_offload(self, testpmd: TestPmd) -> None:
         """Sets IP, UDP, and TCP layers to hardware offload.

         Args:
@@ -117,14 +117,14 @@ def insert_checksums(self) -> None:
         """Enable checksum offload insertion and verify packet reception.

         Steps:
-            Create a list of packets to send.
-            Launch testpmd with the necessary configuration.
-            Enable checksum hardware offload.
-            Send list of packets.
+            * Create a list of packets to send.
+            * Launch testpmd with the necessary configuration.
+            * Enable checksum hardware offload.
+            * Send list of packets.

         Verify:
-            Verify packets are received.
-            Verify packet checksums match the expected flags.
+            * Packets are received.
+            * Packet checksums match the expected flags.
         """
         dport_id = 50000
         payload = b"xxxxx"
@@ -137,11 +137,13 @@ def insert_checksums(self) -> None:
         with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
-            self.setup_hw_offload(testpmd=testpmd)
+            self._setup_hw_offload(testpmd=testpmd)
             testpmd.start()
-            self.send_packets_and_verify(packet_list=packet_list, load=payload, should_receive=True)
+            self._send_packets_and_verify(
+                packet_list=packet_list, load=payload, should_receive=True
+            )
             for i in range(0, len(packet_list)):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
                 )

@@ -150,13 +152,13 @@ def no_insert_checksums(self) -> None:
         """Disable checksum offload insertion and verify packet reception.

         Steps:
-            Create a list of packets to send.
-            Launch testpmd with the necessary configuration.
-            Send list of packets.
+            * Create a list of packets to send.
+            * Launch testpmd with the necessary configuration.
+            * Send list of packets.

         Verify:
-            Verify packets are received.
-            Verify packet checksums match the expected flags.
+            * Packets are received.
+            * Packet checksums match the expected flags.
         """
         dport_id = 50000
         payload = b"xxxxx"
@@ -170,9 +172,11 @@ def no_insert_checksums(self) -> None:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
             testpmd.start()
-            self.send_packets_and_verify(packet_list=packet_list, load=payload, should_receive=True)
+            self._send_packets_and_verify(
+                packet_list=packet_list, load=payload, should_receive=True
+            )
             for i in range(0, len(packet_list)):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
                 )

@@ -181,13 +185,13 @@ def l4_rx_checksum(self) -> None:
         """Tests L4 Rx checksum in a variety of scenarios.

         Steps:
-            Create a list of packets to send with UDP/TCP fields.
-            Launch testpmd with the necessary configuration.
-            Enable checksum hardware offload.
-            Send list of packets.
+            * Create a list of packets to send with UDP/TCP fields.
+            * Launch testpmd with the necessary configuration.
+            * Enable checksum hardware offload.
+            * Send list of packets.

         Verify:
-            Verify packet checksums match the expected flags.
+            * Packet checksums match the expected flags.
         """
         dport_id = 50000
         packet_list = [
@@ -199,13 +203,13 @@ def l4_rx_checksum(self) -> None:
         with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
-            self.setup_hw_offload(testpmd=testpmd)
+            self._setup_hw_offload(testpmd=testpmd)
             for i in range(0, 2):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
                 )
             for i in range(2, 4):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )

@@ -214,13 +218,13 @@ def l3_rx_checksum(self) -> None:
         """Tests L3 Rx checksum hardware offload.

         Steps:
-            Create a list of packets to send with IP fields.
-            Launch testpmd with the necessary configuration.
-            Enable checksum hardware offload.
-            Send list of packets.
+            * Create a list of packets to send with IP fields.
+            * Launch testpmd with the necessary configuration.
+            * Enable checksum hardware offload.
+            * Send list of packets.

         Verify:
-            Verify packet checksums match the expected flags.
+            * Packet checksums match the expected flags.
         """
         dport_id = 50000
         packet_list = [
@@ -232,13 +236,13 @@ def l3_rx_checksum(self) -> None:
         with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
-            self.setup_hw_offload(testpmd=testpmd)
+            self._setup_hw_offload(testpmd=testpmd)
             for i in range(0, 2):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
                 )
             for i in range(2, 4):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i], good_L4=True, good_IP=False, testpmd=testpmd, id=dport_id
                 )

@@ -247,13 +251,13 @@ def validate_rx_checksum(self) -> None:
         """Verify verbose output of Rx packets matches expected behavior.

         Steps:
-            Create a list of packets to send.
-            Launch testpmd with the necessary configuration.
-            Enable checksum hardware offload.
-            Send list of packets.
+            * Create a list of packets to send.
+            * Launch testpmd with the necessary configuration.
+            * Enable checksum hardware offload.
+            * Send list of packets.

         Verify:
-            Verify packet checksums match the expected flags.
+            * Packet checksums match the expected flags.
         """
         dport_id = 50000
         packet_list = [
@@ -269,13 +273,13 @@ def validate_rx_checksum(self) -> None:
         with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
-            self.setup_hw_offload(testpmd=testpmd)
+            self._setup_hw_offload(testpmd=testpmd)
             for i in range(0, 4):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
                 )
             for i in range(4, 6):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i],
                     good_L4=False,
                     good_IP=False,
@@ -283,7 +287,7 @@ def validate_rx_checksum(self) -> None:
                     id=dport_id,
                 )
             for i in range(6, 8):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )

@@ -293,13 +297,13 @@ def vlan_checksum(self) -> None:
         """Test VLAN Rx checksum hardware offload and verify packet reception.

         Steps:
-            Create a list of packets to send with VLAN fields.
-            Launch testpmd with the necessary configuration.
-            Enable checksum hardware offload.
-            Send list of packets.
+            * Create a list of packets to send with VLAN fields.
+            * Launch testpmd with the necessary configuration.
+            * Enable checksum hardware offload.
+            * Send list of packets.

         Verify:
-            Verify packet checksums match the expected flags.
+            * Packet checksums match the expected flags.
         """
         dport_id = 50000
         payload = b"xxxxx"
@@ -328,11 +332,13 @@ def vlan_checksum(self) -> None:
         with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
-            self.setup_hw_offload(testpmd=testpmd)
+            self._setup_hw_offload(testpmd=testpmd)
             testpmd.start()
-            self.send_packets_and_verify(packet_list=packet_list, load=payload, should_receive=True)
+            self._send_packets_and_verify(
+                packet_list=packet_list, load=payload, should_receive=True
+            )
             for i in range(0, 2):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i],
                     good_L4=False,
                     good_IP=False,
@@ -340,7 +346,7 @@ def vlan_checksum(self) -> None:
                     id=dport_id,
                 )
             for i in range(2, 4):
-                self.send_packet_and_verify_checksum(
+                self._send_packet_and_verify_checksum(
                     packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )

@@ -350,13 +356,13 @@ def validate_sctp_checksum(self) -> None:
         """Test SCTP Rx checksum hardware offload and verify packet reception.

         Steps:
-            Create a list of packets to send with SCTP fields.
-            Launch testpmd with the necessary configuration.
-            Enable checksum hardware offload.
-            Send list of packets.
+            * Create a list of packets to send with SCTP fields.
+            * Launch testpmd with the necessary configuration.
+            * Enable checksum hardware offload.
+            * Send list of packets.

         Verify:
-            Verify packet checksums match the expected flags.
+            * Packet checksums match the expected flags.
         """
         dport_id = 50000
         packet_list = [
@@ -368,9 +374,9 @@ def validate_sctp_checksum(self) -> None:
             testpmd.set_verbose(level=1)
             testpmd.csum_set_hw(layers=ChecksumOffloadOptions.sctp)
             testpmd.start()
-            self.send_packet_and_verify_checksum(
+            self._send_packet_and_verify_checksum(
                 packet=packet_list[0], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
             )
-            self.send_packet_and_verify_checksum(
+            self._send_packet_and_verify_checksum(
                 packet=packet_list[1], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
             )
diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_vlan.py
index 41334b60c4..a40297ecaa 100644
--- a/dts/tests/TestSuite_dual_vlan.py
+++ b/dts/tests/TestSuite_dual_vlan.py
@@ -60,7 +60,7 @@ class TestCaseOptions(Flag):
     #:
     tx_port: ClassVar[int] = 1

-    def is_relevant_packet(self, pkt: Packet) -> bool:
+    def _is_relevant_packet(self, pkt: Packet) -> bool:
         """Check if a packet was sent by functions in this suite.

         All functions in this test suite send packets with a payload that is packed with 20 "X"
@@ -75,7 +75,7 @@ def is_relevant_packet(self, pkt: Packet) -> bool:
         """
         return hasattr(pkt, "load") and "X" * 20 in str(pkt.load)

-    def pkt_payload_contains_layers(self, pkt: Packet, *expected_layers: Packet) -> bool:
+    def _pkt_payload_contains_layers(self, pkt: Packet, *expected_layers: Packet) -> bool:
         """Verify that the payload of the packet matches `expected_layers`.

         The layers in the payload of `pkt` must match the type and the user-defined fields of the
@@ -102,39 +102,17 @@ def pkt_payload_contains_layers(self, pkt: Packet, *expected_layers: Packet) ->
             current_pkt_layer = current_pkt_layer.payload
         return ret

-    def verify_vlan_functions(self, send_packet: Packet, options: TestCaseOptions) -> None:
+    def _verify_vlan_functions(self, send_packet: Packet, options: TestCaseOptions) -> None:
         """Send packet and verify the received packet has the expected structure.

-        Expected structure is defined by `options` according to the following table:
-        +----------------------------------------------+-----------------------+
-        |                  Configure setting           |       Result          |
-        +=======+=======+========+============+========+=======+=======+=======+
-        | Outer | Inner |  VLAN  |   VLAN     | VLAN   | Pass/ | Outer | Inner |
-        | vlan  | vlan  |  strip |   filter   | insert | Drop  | vlan  | vlan  |
-        +-------+-------+--------+------------+--------+-------+-------+-------+
-        |  0x1  |  0x2  |   no   |     no     |   no   | pass  |  0x1  |  0x2  |
-        +-------+-------+--------+------------+--------+-------+-------+-------+
-        |  0x1  |  0x2  |  yes   |     no     |   no   | pass  |  no   |  0x2  |
-        +-------+-------+--------+------------+--------+-------+-------+-------+
-        |  0x1  |  0x2  |   no   |  yes,0x1   |   no   | pass  |  0x1  |  0x2  |
-        +-------+-------+--------+------------+--------+-------+-------+-------+
-        |  0x1  |  0x2  |   no   |  yes,0x2   |   no   | pass  |  0x1  |  0x2  |
-        +-------+-------+--------+------------+--------+-------+-------+-------+
-        |  0x1  |  0x2  |   no   | yes,0x1,0x2|   no   | pass  |  0x1  |  0x2  |
-        +-------+-------+--------+------------+--------+-------+-------+-------+
-        |  0x1  |  0x2  |  yes   |  yes,0x1   |   no   | pass  |  no   |  0x2  |
-        +-------+-------+--------+------------+--------+-------+-------+-------+
-        |  0x1  |  0x2  |  yes   |  yes,0x2   |   no   | pass  |  no   |  0x2  |
-        +-------+-------+--------+------------+--------+-------+-------+-------+
-        |  0x1  |  0x2  |  yes   | yes,0x1,0x2|   no   | pass  |  no   |  0x2  |
-        +-------+-------+--------+------------+--------+-------+-------+-------+
+        If VLAN_STRIP is in `options`, the outer VLAN tag should be stripped from the packet.

         Args:
             send_packet: Packet to send for testing.
             options: Flag which defines the currents configured settings in testpmd.
         """
         recv = self.send_packet_and_capture(send_packet)
-        recv = list(filter(self.is_relevant_packet, recv))
+        recv = list(filter(self._is_relevant_packet, recv))
         expected_layers: list[Packet] = []

         if self.TestCaseOptions.VLAN_STRIP not in options:
@@ -148,12 +126,12 @@ def verify_vlan_functions(self, send_packet: Packet, options: TestCaseOptions) -

         for pkt in recv:
             self.verify(
-                self.pkt_payload_contains_layers(pkt, *expected_layers),
+                self._pkt_payload_contains_layers(pkt, *expected_layers),
                 f"Received packet ({pkt.summary()}) did not match the expected sequence of layers "
                 f"{expected_layers} with options {options}.",
             )

-    def configure_testpmd(self, shell: TestPmd, options: TestCaseOptions, add: bool) -> None:
+    def _configure_testpmd(self, shell: TestPmd, options: TestCaseOptions, add: bool) -> None:
         """Configure VLAN functions in testpmd based on `options`.

         Args:
@@ -186,12 +164,13 @@ def insert_second_vlan(self) -> None:
         """Test that a packet with a single VLAN can have an additional one inserted into it.

         Steps:
-            Set VLAN tag on the tx port.
-            Create a packet with a VLAN tag.
-            Send and receive the packet.
+            * Set VLAN tag on the tx port.
+            * Create a packet with a VLAN tag.
+            * Send and receive the packet.
+
         Verify:
-            Packets are received.
-            Packet contains two VLAN tags.
+            * Packets are received.
+            * Packet contains two VLAN tags.
         """
         with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.tx_vlan_set(port=self.tx_port, enable=True, vlan=self.vlan_insert_tag)
@@ -202,8 +181,8 @@ def insert_second_vlan(self) -> None:
             self.verify(len(recv) > 0, "Did not receive any packets when testing VLAN insertion.")
             self.verify(
                 any(
-                    self.is_relevant_packet(p)
-                    and self.pkt_payload_contains_layers(
+                    self._is_relevant_packet(p)
+                    and self._pkt_payload_contains_layers(
                         p, Dot1Q(vlan=self.vlan_insert_tag), Dot1Q(vlan=self.outer_vlan_tag)
                     )
                     for p in recv
@@ -216,12 +195,13 @@ def all_vlan_functions(self) -> None:
         """Test that all combinations of :class:`TestCaseOptions` behave as expected.

         Steps:
-            Send packets with VLAN functions disabled.
-            Send packets with a set of combinations of VLAN functions enabled.
-            Disable VLAN function to allow for a clean environment for the next test.
+            * Send packets with VLAN functions disabled.
+            * Send packets with a set of combinations of VLAN functions enabled.
+            * Disable VLAN function to allow for a clean environment for the next test.
+
         Verify:
-            Packet with two VLANs is unchanged without the VLAN modification functions enabled.
-            VLAN functions work as expected.
+            * Packet with two VLANs is unchanged without the VLAN modification functions enabled.
+            * VLAN functions work as expected.
         """
         send_pkt = (
             Ether()
@@ -235,8 +215,8 @@ def all_vlan_functions(self) -> None:
             self.verify(len(recv) > 0, "Unmodified packet was not received.")
             self.verify(
                 any(
-                    self.is_relevant_packet(p)
-                    and self.pkt_payload_contains_layers(
+                    self._is_relevant_packet(p)
+                    and self._pkt_payload_contains_layers(
                         p, Dot1Q(vlan=self.outer_vlan_tag), Dot1Q(vlan=self.inner_vlan_tag)
                     )
                     for p in recv
@@ -246,22 +226,23 @@ def all_vlan_functions(self) -> None:
             testpmd.stop()
             for i in range(2 ** len(self.TestCaseOptions)):
                 options = self.TestCaseOptions(i)
-                self.configure_testpmd(testpmd, options, True)
+                self._configure_testpmd(testpmd, options, True)
                 testpmd.start()
-                self.verify_vlan_functions(send_pkt, options)
+                self._verify_vlan_functions(send_pkt, options)
                 testpmd.stop()
-                self.configure_testpmd(testpmd, options, False)
+                self._configure_testpmd(testpmd, options, False)

     @func_test
     def maintains_priority(self) -> None:
         """Test that priorities of multiple VLAN tags are preserved by the PMD.

         Steps:
-            Create packets with VLAN tags with priorities.
-            Send and receive packets.
+            * Create packets with VLAN tags with priorities.
+            * Send and receive packets.
+
         Verify:
-            Packets are received.
-            Priorities are unchanged.
+            * Packets are received.
+            * Priorities are unchanged.
         """
         pkt = (
             Ether()
@@ -275,8 +256,8 @@ def maintains_priority(self) -> None:
             self.verify(len(recv) > 0, "Did not receive any packets when testing VLAN priority.")
             self.verify(
                 any(
-                    self.is_relevant_packet(p)
-                    and self.pkt_payload_contains_layers(
+                    self._is_relevant_packet(p)
+                    and self._pkt_payload_contains_layers(
                         p,
                         Dot1Q(vlan=self.outer_vlan_tag, prio=1),
                         Dot1Q(vlan=self.inner_vlan_tag, prio=2),
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 0d7087c674..5cc96f2633 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -51,7 +51,7 @@ class TestDynamicConfig(TestSuite):
        that multicast packets are received and forwarded.
     """

-    def send_packet_and_verify(self, should_receive: bool, mac_address: str) -> None:
+    def _send_packet_and_verify(self, should_receive: bool, mac_address: str) -> None:
         """Generate, send and verify packets.

         Generate a packet and send to the DUT, verify that packet is forwarded from DUT to
@@ -71,7 +71,7 @@ def send_packet_and_verify(self, should_receive: bool, mac_address: str) -> None
             f"Packet was {'dropped' if should_receive else 'received'}",
         )

-    def disable_promisc_setup(self, testpmd: TestPmd, port_id: int) -> TestPmd:
+    def _disable_promisc_setup(self, testpmd: TestPmd, port_id: int) -> TestPmd:
         """Sets up testpmd shell config for cases where promisc mode is disabled.

         Args:
@@ -90,9 +90,13 @@ def disable_promisc_setup(self, testpmd: TestPmd, port_id: int) -> TestPmd:
     def default_mode(self) -> None:
         """Tests default configuration.

-        Creates a testpmd shell, verifies that promiscuous mode is enabled by default,
-        and sends two packets; one matching source MAC address and one unknown.
-        Verifies that both are received.
+        Steps:
+            * Start testpmd.
+            * Sends two packets, one matching source MAC address and one unknown.
+
+        Verify:
+            * Promiscuous mode is enabled by default.
+            * Both packets are received.
         """
         with TestPmd() as testpmd:
             is_promisc = testpmd.show_port_info(0).is_promiscuous_mode_enabled
@@ -100,50 +104,63 @@ def default_mode(self) -> None:
             testpmd.start()
             mac = testpmd.show_port_info(0).mac_address
             # send a packet with Rx port mac address
-            self.send_packet_and_verify(should_receive=True, mac_address=str(mac))
+            self._send_packet_and_verify(should_receive=True, mac_address=str(mac))
             # send a packet with mismatched mac address
-            self.send_packet_and_verify(should_receive=True, mac_address="00:00:00:00:00:01")
+            self._send_packet_and_verify(should_receive=True, mac_address="00:00:00:00:00:01")

     @func_test
     def disable_promisc(self) -> None:
         """Tests disabled promiscuous mode configuration.

-        Creates an interactive testpmd shell, disables promiscuous mode,
-        and sends two packets; one matching source MAC address and one unknown.
-        Verifies that only the matching address packet is received.
+        Steps:
+            * Start testpmd.
+            * Disables promiscuous mode.
+            * Sends two packets, one matching source MAC address and one unknown.
+
+        Verify:
+            * Only the matching address packet are received.
         """
         with TestPmd() as testpmd:
-            testpmd = self.disable_promisc_setup(testpmd=testpmd, port_id=0)
+            testpmd = self._disable_promisc_setup(testpmd=testpmd, port_id=0)
             mac = testpmd.show_port_info(0).mac_address
-            self.send_packet_and_verify(should_receive=True, mac_address=str(mac))
-            self.send_packet_and_verify(should_receive=False, mac_address="00:00:00:00:00:01")
+            self._send_packet_and_verify(should_receive=True, mac_address=str(mac))
+            self._send_packet_and_verify(should_receive=False, mac_address="00:00:00:00:00:01")

     @func_test
     def disable_promisc_broadcast(self) -> None:
         """Tests broadcast reception with disabled promisc mode config.

-        Creates an interactive testpmd shell, disables promiscuous mode,
-        and sends two packets; one matching source MAC address and one broadcast.
-        Verifies that both packets are received.
+        Steps:
+            * Start testpmd.
+            * Disable promiscuous mode.
+            * Send two packets, one matching source MAC address and one broadcast.
+
+        Verify:
+            * Both packets are received.
+
         """
         with TestPmd() as testpmd:
-            testpmd = self.disable_promisc_setup(testpmd=testpmd, port_id=0)
+            testpmd = self._disable_promisc_setup(testpmd=testpmd, port_id=0)
             mac = testpmd.show_port_info(0).mac_address
-            self.send_packet_and_verify(should_receive=True, mac_address=str(mac))
-            self.send_packet_and_verify(should_receive=True, mac_address="ff:ff:ff:ff:ff:ff")
+            self._send_packet_and_verify(should_receive=True, mac_address=str(mac))
+            self._send_packet_and_verify(should_receive=True, mac_address="ff:ff:ff:ff:ff:ff")

     @func_test
     def disable_promisc_multicast(self) -> None:
         """Tests allmulticast mode with disabled promisc config.

-        Creates an interactive testpmd shell, disables promiscuous mode,
-        and sends two packets; one matching source MAC address and one multicast.
-        Verifies that the multicast packet is only received once allmulticast mode is enabled.
+        Steps:
+            * Start testpmd.
+            * Disable promiscuous mode.
+            * Send two packets, one matching source MAC address and one multicast.
+
+        Verify:
+            * Multicast packets are only received when receiving multicast frames is enabled.
         """
         with TestPmd() as testpmd:
-            testpmd = self.disable_promisc_setup(testpmd=testpmd, port_id=0)
+            testpmd = self._disable_promisc_setup(testpmd=testpmd, port_id=0)
             testpmd.set_multicast_all(on=False)
             # 01:00:5E:00:00:01 is the first of the multicast MAC range of addresses
-            self.send_packet_and_verify(should_receive=False, mac_address="01:00:5E:00:00:01")
+            self._send_packet_and_verify(should_receive=False, mac_address="01:00:5E:00:00:01")
             testpmd.set_multicast_all(on=True)
-            self.send_packet_and_verify(should_receive=True, mac_address="01:00:05E:00:00:01")
+            self._send_packet_and_verify(should_receive=True, mac_address="01:00:05E:00:00:01")
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index 7803e43203..bc7f981424 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -66,7 +66,7 @@ def setup_and_teardown_test(
         queues and validates they can still handle traffic.
     """

-    def wrap(self: "TestDynamicQueueConf", is_rx_testing: bool) -> None:
+    def _wrap(self: "TestDynamicQueueConf", is_rx_testing: bool) -> None:
         """Setup environment, run test function, then cleanup.

         Start a testpmd shell and stop ports for testing, then call the decorated function that
@@ -106,16 +106,16 @@ def wrap(self: "TestDynamicQueueConf", is_rx_testing: bool) -> None:
                 testpmd.start_port_queue(port_id, queue_id, is_rx_testing)

             testpmd.start()
-            self.send_packets_with_different_addresses(self.number_of_packets_to_send)
+            self._send_packets_with_different_addresses(self.number_of_packets_to_send)
             forwarding_stats = testpmd.stop()
             for queue_id in queues_to_config:
                 self.verify(
-                    self.port_queue_in_stats(port_id, is_rx_testing, queue_id, forwarding_stats),
+                    self._port_queue_in_stats(port_id, is_rx_testing, queue_id, forwarding_stats),
                     f"Modified queue {queue_id} on port {port_id} failed to receive traffic after"
                     "being started again.",
                 )

-    return wrap
+    return _wrap


 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
@@ -154,7 +154,7 @@ class TestDynamicQueueConf(TestSuite):
     #: therefore 1024 will be more than enough.
     number_of_packets_to_send: ClassVar[int] = 1024

-    def send_packets_with_different_addresses(self, number_of_packets: int) -> None:
+    def _send_packets_with_different_addresses(self, number_of_packets: int) -> None:
         """Send a set number of packets each with different dst addresses.

         Different destination addresses are required to ensure that each queue is used. If every
@@ -174,7 +174,7 @@ def send_packets_with_different_addresses(self, number_of_packets: int) -> None:
         ]
         self.send_packets(packets_to_send)

-    def port_queue_in_stats(
+    def _port_queue_in_stats(
         self, port_id: int, is_rx_queue: bool, queue_id: int, stats: str
     ) -> bool:
         """Verify if stats for a queue are in the provided output.
@@ -193,7 +193,7 @@ def port_queue_in_stats(
         return f"{type_of_queue} Port= {port_id}/Queue={queue_id:2d}" in stats

     @setup_and_teardown_test
-    def modify_ring_size(
+    def _modify_ring_size(
         self,
         port_id: int,
         queues_to_modify: MutableSet[int],
@@ -233,7 +233,7 @@ def modify_ring_size(
                 )

     @setup_and_teardown_test
-    def stop_queues(
+    def _stop_queues(
         self,
         port_id: int,
         queues_to_modify: MutableSet[int],
@@ -255,7 +255,7 @@ def stop_queues(
                 queues will be modified.
         """
         testpmd.start()
-        self.send_packets_with_different_addresses(self.number_of_packets_to_send)
+        self._send_packets_with_different_addresses(self.number_of_packets_to_send)
         forwarding_stats = testpmd.stop()

         # Checking that all unmodified queues handled some packets is important because this
@@ -265,12 +265,12 @@ def stop_queues(
         # therefore, a false positive result.
         for unchanged_q_id in unchanged_queues:
             self.verify(
-                self.port_queue_in_stats(port_id, is_rx_testing, unchanged_q_id, forwarding_stats),
+                self._port_queue_in_stats(port_id, is_rx_testing, unchanged_q_id, forwarding_stats),
                 f"Queue {unchanged_q_id} failed to receive traffic.",
             )
         for stopped_q_id in queues_to_modify:
             self.verify(
-                not self.port_queue_in_stats(
+                not self._port_queue_in_stats(
                     port_id, is_rx_testing, stopped_q_id, forwarding_stats
                 ),
                 f"Queue {stopped_q_id} should be stopped but still received traffic.",
@@ -279,23 +279,59 @@ def stop_queues(
     @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
     def rx_queue_stop(self) -> None:
-        """Run method for stopping queues with flag for Rx testing set to :data:`True`."""
-        self.stop_queues(True)
+        """Test Rx stopping queues when flag is set to :data:`True`.
+
+        Steps:
+            * Start testpmd.
+            * Set forward mode.
+            * Send packets with different addresses and capture.
+
+        Verify
+            * Stopped queues don't handle traffic and doesn't block traffic on other queues.
+        """
+        self._stop_queues(True)

     @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
     def rx_queue_configuration(self) -> None:
-        """Run method for configuring queues with flag for Rx testing set to :data:`True`."""
-        self.modify_ring_size(True)
+        """Test Rx queue configuration when testing is set to :data:`True`.
+
+        Steps:
+            * Start testpmd.
+            * Set forward mode.
+            * Send packets with different addresses and capture.
+
+        Verify
+            * Ring size of port queues can be configured at runtime.
+        """
+        self._modify_ring_size(True)

     @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
     def tx_queue_stop(self) -> None:
-        """Run method for stopping queues with flag for Rx testing set to :data:`False`."""
-        self.stop_queues(False)
+        """Test Rx stopping queues when flag is set to :data:`False`.
+
+        Steps:
+            * Start testpmd.
+            * Set forward mode.
+            * Send packets with different addresses and capture.
+
+        Verify
+            * Stopped queues don't handle traffic and doesn't block traffic on other queues.
+        """
+        self._stop_queues(False)

     @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
     def tx_queue_configuration(self) -> None:
-        """Run method for configuring queues with flag for Rx testing set to :data:`False`."""
-        self.modify_ring_size(False)
+        """Test Rx queue configuration when testing is set to :data:`False`.
+
+        Steps:
+            * Start testpmd.
+            * Set forward mode.
+            * Send packets with different addresses and capture.
+
+        Verify
+            * Ring size of port queues can be configured at runtime.
+        """
+        self._modify_ring_size(False)
diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hello_world.py
index b473b47d9e..3560e9ec0b 100644
--- a/dts/tests/TestSuite_hello_world.py
+++ b/dts/tests/TestSuite_hello_world.py
@@ -29,9 +29,10 @@ def hello_world(self) -> None:
         """EAL confidence test.

         Steps:
-            Start testpmd session and check status.
+            * Start testpmd session and check status.
+
         Verify:
-            The testpmd session throws no errors.
+            * Testpmd session throws no errors.
         """
         with TestPmd() as testpmd:
             testpmd.start()
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 9d56c7d5c9..bc1b5162c3 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -44,10 +44,12 @@ def set_up_suite(self) -> None:
     def l2fwd_integrity(self) -> None:
         """Test the L2 forwarding integrity.

-        Test:
-            Configure a testpmd shell with a different numbers of queues (1, 2, 4 and 8) per run.
-            Start up L2 forwarding, send random packets from the TG and verify they were all
-            received back.
+        Steps:
+            * Configure testpmd with a different numbers of queues (1, 2, 4 and 8) per run.
+            * Start up L2 forwarding, send random packets from the TG.
+
+        Verify:
+            * All packets are received.
         """
         queues = [1, 2, 4, 8]

diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index 20351c957e..6a51f9df4e 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -45,7 +45,7 @@ class TestMacFilter(TestSuite):
     test case passes.
     """

-    def send_packet_and_verify(
+    def _send_packet_and_verify(
         self,
         mac_address: str,
         should_receive: bool = True,
@@ -96,14 +96,20 @@ def add_remove_mac_addresses(self) -> None:
         added to the PMD. Packets should either be received or not received depending on
         the properties applied to the PMD at any given time.

-        Test:
-            * Start TestPMD without promiscuous mode.
+        Steps:
+            * Start testpmd without promiscuous mode.
             * Send a packet with the port's default mac address. (Should receive)
             * Send a packet with fake mac address. (Should not receive)
             * Add fake mac address to the PMD's address pool.
             * Send a packet with the fake mac address to the PMD. (Should receive)
             * Remove the fake mac address from the PMD's address pool.
             * Send a packet with the fake mac address to the PMD. (Should not receive)
+
+        Verify:
+            * Packet with the port's default mac address is received.
+            * Packet with a fake mac address is not received.
+            * Packet with a fake mac address is received when being sent to the PMD.
+            * Packet with a fake mac address is not received when being sent to the PMD.
         """
         with TestPmd() as testpmd:
             testpmd.set_promisc(0, enable=False)
@@ -111,16 +117,16 @@ def add_remove_mac_addresses(self) -> None:
             mac_address = self.topology.sut_port_ingress.mac_address

             # Send a packet with NIC default mac address
-            self.send_packet_and_verify(mac_address=mac_address, should_receive=True)
+            self._send_packet_and_verify(mac_address=mac_address, should_receive=True)
             # Send a packet with different mac address
             fake_address = "00:00:00:00:00:01"
-            self.send_packet_and_verify(mac_address=fake_address, should_receive=False)
+            self._send_packet_and_verify(mac_address=fake_address, should_receive=False)

             # Add mac address to pool and rerun tests
             testpmd.set_mac_addr(0, mac_address=fake_address, add=True)
-            self.send_packet_and_verify(mac_address=fake_address, should_receive=True)
+            self._send_packet_and_verify(mac_address=fake_address, should_receive=True)
             testpmd.set_mac_addr(0, mac_address=fake_address, add=False)
-            self.send_packet_and_verify(mac_address=fake_address, should_receive=False)
+            self._send_packet_and_verify(mac_address=fake_address, should_receive=False)

     @func_test
     def invalid_address(self) -> None:
@@ -130,8 +136,8 @@ def invalid_address(self) -> None:
         and address pooling. Devices should not be able to use invalid mac addresses, remove their
         built-in hardware address, or exceed their address pools.

-        Test:
-            * Start TestPMD.
+        Steps:
+            * Start testpmd.
             * Attempt to add an invalid mac address. (Should fail)
             * Attempt to remove the device's hardware address with no additional addresses in the
               address pool. (Should fail)
@@ -140,6 +146,14 @@ def invalid_address(self) -> None:
               pool. (Should fail)
             * Determine the device's mac address pool size, and fill the pool with fake addresses.
             * Attempt to add another fake mac address, overloading the address pool. (Should fail)
+
+        Verify:
+            * It is not possible to add a invalid mac address.
+            * It is not possible to remove the default mac address when there are no other
+              addresses in the pool.
+            * It is not possible to remove the default mac address when there are other
+              addresses in the pool.
+            * It is not possible to add another mac address.
         """
         with TestPmd() as testpmd:
             testpmd.start()
@@ -188,12 +202,16 @@ def multicast_filter(self) -> None:
         Ensure that multicast filtering performs as intended when a given device is bound
         to the PMD.

-        Test:
-            * Start TestPMD without promiscuous mode.
+        Steps:
+            * Start testpmd without promiscuous mode.
             * Add a fake multicast address to the PMD's multicast address pool.
-            * Send a packet with the fake multicast address to the PMD. (Should receive)
+            * Send a packet with the fake multicast address to the PMD.
             * Remove the fake multicast address from the PMDs multicast address filter.
-            * Send a packet with the fake multicast address to the PMD. (Should not receive)
+            * Send a packet with the fake multicast address to the PMD.
+
+        Verify:
+            * Packet sent with a fake multicast address is received.
+            * Packet sent with a fake multicast address is not received.
         """
         with TestPmd() as testpmd:
             testpmd.start()
@@ -201,8 +219,8 @@ def multicast_filter(self) -> None:
             multicast_address = "01:00:5E:00:00:00"

             testpmd.set_multicast_mac_addr(0, multi_addr=multicast_address, add=True)
-            self.send_packet_and_verify(multicast_address, should_receive=True)
+            self._send_packet_and_verify(multicast_address, should_receive=True)

             # Remove multicast filter and verify the packet was not received.
             testpmd.set_multicast_mac_addr(0, multicast_address, add=False)
-            self.send_packet_and_verify(multicast_address, should_receive=False)
+            self._send_packet_and_verify(multicast_address, should_receive=False)
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index 7faecabb7c..8a14c791f7 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -42,7 +42,7 @@ class TestMtu(TestSuite):
     size in a DPDK application.

     Verify the behavior of both runtime MTU and pre-runtime MTU adjustments within DPDK
-    applications. (TestPMD's CLI and runtime MTU adjustment options leverage different logical
+    applications. (Testpmd's CLI and runtime MTU adjustment options leverage different logical
     in components within ethdev to set a value).

     Test cases will verify that any frame greater than an assigned MTU are dropped and packets
@@ -58,7 +58,7 @@ def set_up_suite(self) -> None:
         self.topology.tg_port_egress.configure_mtu(JUMBO_MTU + 200)
         self.topology.tg_port_ingress.configure_mtu(JUMBO_MTU + 200)

-    def send_packet_and_verify(self, pkt_size: int, should_receive: bool) -> None:
+    def _send_packet_and_verify(self, pkt_size: int, should_receive: bool) -> None:
         """Generate, send a packet, and assess its behavior based on a given packet size.

         Generates a packet based on a specified size and sends it to the SUT. The desired packet's
@@ -86,7 +86,7 @@ def send_packet_and_verify(self, pkt_size: int, should_receive: bool) -> None:
         else:
             self.verify(not found, "Received packet.")

-    def assess_mtu_boundary(self, testpmd_shell: TestPmd, mtu: int) -> None:
+    def _assess_mtu_boundary(self, testpmd_shell: TestPmd, mtu: int) -> None:
         """Sets the new MTU and verifies packets at the set boundary.

         Ensure that packets smaller than or equal to a set MTU will be received and packets larger
@@ -114,92 +114,88 @@ def assess_mtu_boundary(self, testpmd_shell: TestPmd, mtu: int) -> None:
         equal_frame_size: int = mtu
         larger_frame_size: int = mtu + VENDOR_AGNOSTIC_PADDING

-        self.send_packet_and_verify(pkt_size=smaller_frame_size, should_receive=True)
-        self.send_packet_and_verify(pkt_size=equal_frame_size, should_receive=True)
+        self._send_packet_and_verify(pkt_size=smaller_frame_size, should_receive=True)
+        self._send_packet_and_verify(pkt_size=equal_frame_size, should_receive=True)

         current_mtu = testpmd_shell.show_port_info(0).mtu
         self.verify(current_mtu is not None, "Error grabbing testpmd MTU value.")
         if current_mtu and (
             current_mtu >= STANDARD_MTU + VENDOR_AGNOSTIC_PADDING and mtu == STANDARD_MTU
         ):
-            self.send_packet_and_verify(pkt_size=larger_frame_size, should_receive=True)
+            self._send_packet_and_verify(pkt_size=larger_frame_size, should_receive=True)
         else:
-            self.send_packet_and_verify(pkt_size=larger_frame_size, should_receive=False)
+            self._send_packet_and_verify(pkt_size=larger_frame_size, should_receive=False)

     @func_test
     def runtime_mtu_updating_and_forwarding(self) -> None:
         """Verify runtime MTU adjustments and assess packet forwarding behavior.

-        Test:
-            * Start TestPMD in a paired topology.
+        Steps:
+            * Start testpmd in a paired topology.
             * Set port MTU to 1500.
             * Send packets of 1491, 1500 and 1509 bytes.
                 * Verify the first two packets are forwarded and the last is dropped.
-
             * Set port MTU to 2400.
             * Send packets of 1491, 1500 and 1509 bytes.
                 * Verify all three packets are forwarded.
             * Send packets of 2391, 2400 and 2409 bytes.
                 * Verify the first two packets are forwarded and the last is dropped.
-
             * Set port MTU to 4800.
             * Send packets of 1491, 1500 and 1509 bytes.
                 * Verify all three packets are forwarded.
             * Send packets of 4791, 4800 and 4809 bytes.
                 * Verify the first two packets are forwarded and the last is dropped.
-
             * Set port MTU to 9000.
             * Send packets of 1491, 1500 and 1509 bytes.
                 * Verify all three packets are forwarded.
             * Send packets of 8991, 9000 and 9009 bytes.
                 * Verify the first two packets are forwarded and the last is dropped.
+
         Verify:
-            * Verifies the successful forwarding of packets via a search for an inserted payload.
+            * Successful forwarding of packets via a search for an inserted payload.
               If the payload is found, the packet was transmitted successfully. Otherwise, the
               packet is considered dropped.
-
-            * Verify that standard MTU packets forward, in addition to packets within the limits of
+            * Standard MTU packets forward, in addition to packets within the limits of
               an MTU size set during runtime.
         """
         with TestPmd(tx_offloads=0x8000, mbuf_size=[JUMBO_MTU + 200]) as testpmd:
             testpmd.set_port_mtu_all(1500, verify=True)
             testpmd.start()
-            self.assess_mtu_boundary(testpmd, 1500)
+            self._assess_mtu_boundary(testpmd, 1500)
             testpmd.stop()

             testpmd.set_port_mtu_all(2400, verify=True)
             testpmd.start()
-            self.assess_mtu_boundary(testpmd, 1500)
-            self.assess_mtu_boundary(testpmd, 2400)
+            self._assess_mtu_boundary(testpmd, 1500)
+            self._assess_mtu_boundary(testpmd, 2400)
             testpmd.stop()

             testpmd.set_port_mtu_all(4800, verify=True)
             testpmd.start()
-            self.assess_mtu_boundary(testpmd, 1500)
-            self.assess_mtu_boundary(testpmd, 4800)
+            self._assess_mtu_boundary(testpmd, 1500)
+            self._assess_mtu_boundary(testpmd, 4800)
             testpmd.stop()

             testpmd.set_port_mtu_all(9000, verify=True)
             testpmd.start()
-            self.assess_mtu_boundary(testpmd, 1500)
-            self.assess_mtu_boundary(testpmd, 9000)
+            self._assess_mtu_boundary(testpmd, 1500)
+            self._assess_mtu_boundary(testpmd, 9000)
             testpmd.stop()

     @func_test
     def cli_mtu_forwarding_for_std_packets(self) -> None:
         """Assesses packet forwarding of standard MTU packets after pre-runtime MTU adjustments.

-        Test:
-            * Start TestPMD with MTU size of 1518 bytes, set pre-runtime.
+        Steps:
+            * Start testpmd with MTU size of 1518 bytes, set pre-runtime.
             * Send packets of size 1491, 1500 and 1509 bytes.
-            * Verify the first two packets are forwarded and the last is dropped.
+
         Verify:
-            * Verifies the successful forwarding of packets via a search for an inserted payload.
+            * First two packets are forwarded and the last is dropped.
+            * Successful forwarding of packets via a search for an inserted payload.
               If the payload is found, the packet was transmitted successfully. Otherwise, the
               packet is considered dropped.
-
-            * Verify the first two packets are forwarded and the last is dropped after pre-runtime
-              MTU modification.
+            * All packets are forwarded and the last is dropped after pre-runtime MTU modification.
         """
         with TestPmd(
             tx_offloads=0x8000,
@@ -209,9 +205,11 @@ def cli_mtu_forwarding_for_std_packets(self) -> None:
         ) as testpmd:
             testpmd.start()

-            self.send_packet_and_verify(STANDARD_MTU - VENDOR_AGNOSTIC_PADDING, should_receive=True)
-            self.send_packet_and_verify(STANDARD_MTU, should_receive=True)
-            self.send_packet_and_verify(
+            self._send_packet_and_verify(
+                STANDARD_MTU - VENDOR_AGNOSTIC_PADDING, should_receive=True
+            )
+            self._send_packet_and_verify(STANDARD_MTU, should_receive=True)
+            self._send_packet_and_verify(
                 STANDARD_MTU + VENDOR_AGNOSTIC_PADDING, should_receive=False
             )

@@ -219,15 +217,15 @@ def cli_mtu_forwarding_for_std_packets(self) -> None:
     def cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:
         """Assess packet forwarding of packets within the bounds of a pre-runtime MTU adjustment.

-        Test:
-            * Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
+        Steps:
+            * Start testpmd with MTU size of 9018 bytes, set pre-runtime.
             * Send packets of size 8991, 9000 and 1509 bytes.
+
         Verify:
-            * Verifies the successful forwarding of packets via a search for an inserted payload.
+            * Successful forwarding of packets via a search for an inserted payload.
               If the payload is found, the packet was transmitted successfully. Otherwise, the
               packet is considered dropped.
-
-            * Verify that all packets are forwarded after pre-runtime MTU modification.
+            * All packets are forwarded after pre-runtime MTU modification.
         """
         with TestPmd(
             tx_offloads=0x8000,
@@ -237,24 +235,26 @@ def cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:
         ) as testpmd:
             testpmd.start()

-            self.send_packet_and_verify(JUMBO_MTU - VENDOR_AGNOSTIC_PADDING, should_receive=True)
-            self.send_packet_and_verify(JUMBO_MTU, should_receive=True)
-            self.send_packet_and_verify(STANDARD_MTU + VENDOR_AGNOSTIC_PADDING, should_receive=True)
+            self._send_packet_and_verify(JUMBO_MTU - VENDOR_AGNOSTIC_PADDING, should_receive=True)
+            self._send_packet_and_verify(JUMBO_MTU, should_receive=True)
+            self._send_packet_and_verify(
+                STANDARD_MTU + VENDOR_AGNOSTIC_PADDING, should_receive=True
+            )

     @func_test
     def cli_mtu_std_packets_for_jumbo_mtu(self) -> None:
         """Assess boundary of jumbo MTU value set pre-runtime.

-        Test:
-            * Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
+        Steps:
+            * Start testpmd with MTU size of 9018 bytes, set pre-runtime.
             * Send a packets of size 8991, 9000 and 9009 bytes.
-            * Verify the first two packets are forwarded and the last is dropped.
+
         Verify:
-            * Verifies the successful forwarding of packets via a search for an inserted payload.
+            * First two packets are forwarded and the last is dropped.
+            * Successful forwarding of packets via a search for an inserted payload.
               If the payload is found, the packet was transmitted successfully. Otherwise, the
               packet is considered dropped.
-
-            * Verify the first two packets are forwarded and the last is dropped after pre-runtime
+            * Packets are forwarded and the last is dropped after pre-runtime
               MTU modification.
         """
         with TestPmd(
@@ -265,9 +265,9 @@ def cli_mtu_std_packets_for_jumbo_mtu(self) -> None:
         ) as testpmd:
             testpmd.start()

-            self.send_packet_and_verify(JUMBO_MTU - VENDOR_AGNOSTIC_PADDING, should_receive=True)
-            self.send_packet_and_verify(JUMBO_MTU, should_receive=True)
-            self.send_packet_and_verify(JUMBO_MTU + VENDOR_AGNOSTIC_PADDING, should_receive=False)
+            self._send_packet_and_verify(JUMBO_MTU - VENDOR_AGNOSTIC_PADDING, should_receive=True)
+            self._send_packet_and_verify(JUMBO_MTU, should_receive=True)
+            self._send_packet_and_verify(JUMBO_MTU + VENDOR_AGNOSTIC_PADDING, should_receive=False)

     def tear_down_suite(self) -> None:
         """Tear down the test suite.
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index 436a7e0bef..57b64c618a 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -154,13 +154,13 @@ def dumpcap(self) -> None:
         """Test dumpcap on Rx and Tx interfaces.

         Steps:
-            * Start up testpmd shell.
+            * Start testpmd.
             * Start up dpdk-dumpcap with the default values.
             * Send packets.

         Verify:
-            * The expected packets are the same as the Rx packets.
-            * The Tx packets are the same as the packets received from Scapy.
+            * Expected packets are the same as the Rx packets.
+            * Tx packets are the same as the packets received from Scapy.
         """
         with TestPmd() as testpmd:
             testpmd.start()
@@ -186,12 +186,12 @@ def dumpcap_filter(self) -> None:
         """Test the dumpcap filtering feature.

         Steps:
-            * Start up testpmd shell.
+            * Start testpmd.
             * Start up dpdk-dumpcap listening for TCP packets on the Rx interface.
             * Send packets.

         Verify:
-            * The dumped packets did not contain any of the packets meant for filtering.
+            * Dumped packets did not contain any of the packets meant for filtering.
         """
         with TestPmd() as testpmd:
             testpmd.start()
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
index 1e382fad5d..06d2e5f7e5 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
@@ -65,7 +65,7 @@ def set_up_suite(self) -> None:
         self.topology.tg_port_egress.configure_mtu(9000)
         self.topology.tg_port_ingress.configure_mtu(9000)

-    def scatter_pktgen_send_packet(self, pkt_size: int) -> list[Packet]:
+    def _scatter_pktgen_send_packet(self, pkt_size: int) -> list[Packet]:
         """Generate and send a packet to the SUT then capture what is forwarded back.

         Generate an IP packet of a specific length and send it to the SUT,
@@ -99,7 +99,7 @@ def scatter_pktgen_send_packet(self, pkt_size: int) -> list[Packet]:

         return received_packets

-    def pmd_scatter(self, mb_size: int, enable_offload: bool = False) -> None:
+    def _pmd_scatter(self, mb_size: int, enable_offload: bool = False) -> None:
         """Testpmd support of receiving and sending scattered multi-segment packets.

         Support for scattered packets is shown by sending 5 packets of differing length
@@ -124,7 +124,7 @@ def pmd_scatter(self, mb_size: int, enable_offload: bool = False) -> None:
             testpmd.start()

             for offset in [-1, 0, 1, 4, 5]:
-                recv_packets = self.scatter_pktgen_send_packet(mb_size + offset)
+                recv_packets = self._scatter_pktgen_send_packet(mb_size + offset)
                 self._logger.debug(f"Relevant captured packets: \n{recv_packets}")
                 self.verify(
                     any(" ".join(["58"] * 8) in hexstr(pkt, onlyhex=1) for pkt in recv_packets),
@@ -135,14 +135,30 @@ def pmd_scatter(self, mb_size: int, enable_offload: bool = False) -> None:
     @requires_nic_capability(NicCapability.SCATTERED_RX_ENABLED)
     @func_test
     def scatter_mbuf_2048(self) -> None:
-        """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048."""
-        self.pmd_scatter(mb_size=2048)
+        """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048.
+
+        Steps:
+            * Start testpmd.
+            * Send and capture packets with a `mb_size` of 2048.
+
+        Verify:
+            * Payload of the scattered packets match the expected payload offset.
+        """
+        self._pmd_scatter(mb_size=2048)

     @requires_nic_capability(NicCapability.RX_OFFLOAD_SCATTER)
     @func_test
     def scatter_mbuf_2048_with_offload(self) -> None:
-        """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload."""
-        self.pmd_scatter(mb_size=2048, enable_offload=True)
+        """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload.
+
+        Steps:
+            * Start testpmd with offload true.
+            * Send and capture packets with a `mb_size` of 2048 and rx_scatter offload enabled.
+
+        Verify:
+            * Payload of the scattered packets match the expected payload offset.
+        """
+        self._pmd_scatter(mb_size=2048, enable_offload=True)

     def tear_down_suite(self) -> None:
         """Tear down the test suite.
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index f8eebda49c..df11df4d39 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -28,7 +28,7 @@
 class TestPortControl(TestSuite):
     """DPDK Port Control Testing Suite."""

-    def send_packets_and_verify(self) -> None:
+    def _send_packets_and_verify(self) -> None:
         """Send 100 packets and verify that all packets were forwarded back.

         Packets sent are identical and are all ethernet frames with a payload of 30 "X" characters.
@@ -61,31 +61,31 @@ def start_ports(self) -> None:
         """Start all ports and send a small number of packets.

         Steps:
-            Start all ports
-            Start forwarding in MAC mode
-            Send 100 generic packets to the SUT
+            * Start all ports
+            * Start forwarding in MAC mode
+            * Send 100 generic packets to be captured by the SUT

         Verify:
-            Check that all the packets sent are sniffed on the TG receive port.
+            * Packets sent are sniffed on the TG receive port.
         """
         with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.start_all_ports()
             testpmd.start()
-            self.send_packets_and_verify()
+            self._send_packets_and_verify()

     @func_test
     def stop_ports(self) -> None:
         """Stop all ports, then start all ports, amd then send a small number of packets.

         Steps:
-            Stop all ports
-            Start all ports
-            Start forwarding in MAC mode
-            Send 100 generic packets to the SUT
+            * Stop all ports
+            * Start all ports
+            * Start forwarding in MAC mode
+            * Send 100 generic packets to be captured by the SUT

         Verify:
-            Check that stopping the testpmd ports brings down their links
-            Check that all the packets sent are sniffed on the TG receive port.
+            * Stopping the testpmd ports brings down their links
+            * Packets sent are sniffed on the TG receive port.
         """
         with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.stop_all_ports()
@@ -94,17 +94,17 @@ def stop_ports(self) -> None:
                 "Failed to stop all ports.",
             )
             testpmd.start()
-            self.send_packets_and_verify()
+            self._send_packets_and_verify()

     @func_test
     def close_ports(self) -> None:
         """Close all the ports via testpmd.

         Steps:
-            Close all the testpmd ports
+            * Close all the testpmd ports

         Verify:
-            Check that testpmd no longer reports having any ports
+            * Testpmd no longer reports having any ports
         """
         with TestPmd() as testpmd:
             testpmd.close_all_ports()
diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts/tests/TestSuite_port_restart_config_persistency.py
index 93f9f56e19..7666c9ea7a 100644
--- a/dts/tests/TestSuite_port_restart_config_persistency.py
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py
@@ -25,7 +25,7 @@
 class TestPortRestartConfigPersistency(TestSuite):
     """Port config persistency test suite."""

-    def restart_port_and_verify(self, id: int, testpmd: TestPmd, changed_value: str) -> None:
+    def _restart_port_and_verify(self, id: int, testpmd: TestPmd, changed_value: str) -> None:
         """Fetch port config, restart and verify persistency."""
         testpmd.start_all_ports()
         testpmd.wait_link_status_up(port_id=id, timeout=10)
@@ -60,29 +60,30 @@ def port_configuration_persistence(self) -> None:
         """Port restart configuration persistency test.

         Steps:
-            For each port set the port MTU, VLAN filter, mac address, and promiscuous mode.
+            * For each port set the port MTU, VLAN filter, mac address, and promiscuous mode.
+            * Save port config and restart port.

         Verify:
-            The configuration persists after the port is restarted.
+            * The configuration persists after the port is restarted.
         """
         with TestPmd(disable_device_start=True) as testpmd:
             for port_id, _ in enumerate(self.topology.sut_ports):
                 testpmd.set_port_mtu(port_id=port_id, mtu=STANDARD_MTU, verify=True)
-                self.restart_port_and_verify(port_id, testpmd, "MTU")
+                self._restart_port_and_verify(port_id, testpmd, "MTU")

                 testpmd.set_port_mtu(port_id=port_id, mtu=ALTERNATIVE_MTU, verify=True)
-                self.restart_port_and_verify(port_id, testpmd, "MTU")
+                self._restart_port_and_verify(port_id, testpmd, "MTU")

                 testpmd.set_vlan_filter(port=port_id, enable=True, verify=True)
-                self.restart_port_and_verify(port_id, testpmd, "VLAN filter")
+                self._restart_port_and_verify(port_id, testpmd, "VLAN filter")

                 testpmd.set_mac_address(
                     port=port_id, mac_address=ALTERNATIVE_MAC_ADDRESS, verify=True
                 )
-                self.restart_port_and_verify(port_id, testpmd, "MAC address")
+                self._restart_port_and_verify(port_id, testpmd, "MAC address")

                 testpmd.set_promisc(port=port_id, enable=True, verify=True)
-                self.restart_port_and_verify(port_id, testpmd, "promiscuous mode")
+                self._restart_port_and_verify(port_id, testpmd, "promiscuous mode")

     @requires_nic_capability(NicCapability.FLOW_CTRL)
     @func_test
@@ -90,16 +91,17 @@ def flow_ctrl_port_configuration_persistence(self) -> None:
         """Flow control port configuration persistency test.

         Steps:
-            For each port enable flow control for RX and TX individually.
+            * For each port enable flow control for RX and TX individually.
+
         Verify:
-            The configuration persists after the port is restarted.
+            * The configuration persists after the port is restarted.
         """
         with TestPmd(disable_device_start=True) as testpmd:
             for port_id, _ in enumerate(self.topology.sut_ports):
                 flow_ctrl = TestPmdPortFlowCtrl(rx=True)
                 testpmd.set_flow_control(port=port_id, flow_ctrl=flow_ctrl)
-                self.restart_port_and_verify(port_id, testpmd, "flow_ctrl")
+                self._restart_port_and_verify(port_id, testpmd, "flow_ctrl")

                 flow_ctrl = TestPmdPortFlowCtrl(tx=True)
                 testpmd.set_flow_control(port=port_id, flow_ctrl=flow_ctrl)
-                self.restart_port_and_verify(port_id, testpmd, "flow_ctrl")
+                self._restart_port_and_verify(port_id, testpmd, "flow_ctrl")
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_stats.py
index fecb49b9a3..d0b3b33563 100644
--- a/dts/tests/TestSuite_port_stats.py
+++ b/dts/tests/TestSuite_port_stats.py
@@ -56,7 +56,7 @@ class TestPortStats(TestSuite):
     total_packet_len: ClassVar[int] = 100

     @property
-    def send_pkt(self) -> Packet:
+    def _send_pkt(self) -> Packet:
         """Packet to send during testing."""
         return (
             Ether()
@@ -64,7 +64,7 @@ def send_pkt(self) -> Packet:
             / Raw(b"X" * (self.total_packet_len - self.ip_header_len - self.ether_header_len))
         )

-    def extract_noise_information(
+    def _extract_noise_information(
         self, verbose_out: list[TestPmdVerbosePacket]
     ) -> Tuple[int, int, int, int]:
         """Extract information about packets that were not sent by the framework in `verbose_out`.
@@ -131,23 +131,23 @@ def stats_updates(self) -> None:
         testpmd command `show port info all`.

         Steps:
-            Start testpmd in MAC forwarding mode and set verbose mode to 3 (Rx and Tx).
-            Start packet forwarding and then clear all port statistics.
-            Send a packet, then stop packet forwarding and collect the port stats.
+            * Start testpmd in MAC forwarding mode and set verbose mode to 3 (Rx and Tx).
+            * Start packet forwarding and then clear all port statistics.
+            * Send a packet, then stop packet forwarding and collect the port stats.

         Verify:
-            Parse verbose info from stopping packet forwarding and verify values in port stats.
+            * Port stats showing number of packets received match what we sent.
         """
         with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.set_verbose(3)
             testpmd.start()
             testpmd.clear_port_stats_all()
-            self.send_packet_and_capture(self.send_pkt)
+            self.send_packet_and_capture(self._send_pkt)
             port_stats_all, forwarding_info = testpmd.show_port_stats_all()
             verbose_information = TestPmd.extract_verbose_output(forwarding_info)

         # Gather information from irrelevant packets sent/ received on the same port.
-        rx_irr_bytes, rx_irr_pakts, tx_irr_bytes, tx_irr_pakts = self.extract_noise_information(
+        rx_irr_bytes, rx_irr_pakts, tx_irr_bytes, tx_irr_pakts = self._extract_noise_information(
             verbose_information
         )
         recv_relevant_packets = port_stats_all[self.recv_port].rx_packets - rx_irr_pakts
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_promisc_support.py
index 4a745a1772..089db4a3ec 100644
--- a/dts/tests/TestSuite_promisc_support.py
+++ b/dts/tests/TestSuite_promisc_support.py
@@ -31,15 +31,15 @@ def promisc_packets(self) -> None:
         """Verify that promiscuous mode works.

         Steps:
-            Create a packet with a different mac address to the destination.
-            Enable promiscuous mode.
-            Send and receive packet.
-            Disable promiscuous mode.
-            Send and receive packet.
-        Verify:
-            Packet sent with the wrong address is received in promiscuous mode and filtered out
-            otherwise.
+            * Create a packet with a different mac address to the destination.
+            * Enable promiscuous mode.
+            * Send and receive packet.
+            * Disable promiscuous mode.
+            * Send and receive packet.

+        Verify:
+            * Packet sent with the wrong address is received in promiscuous mode and filtered out
+              otherwise.
         """
         packet = [Ether(dst=self.ALTERNATIVE_MAC_ADDRESS) / IP() / Raw(load=b"\x00" * 64)]

diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuite_queue_start_stop.py
index b71ed685fa..e0dd39fd96 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_start_stop.py
@@ -42,7 +42,7 @@ class TestQueueStartStop(TestSuite):
     behavior in both the Rx and Tx queue.
     """

-    def send_packet_and_verify(self, should_receive: bool = True) -> None:
+    def _send_packet_and_verify(self, should_receive: bool = True) -> None:
         """Generate a packet, send to the DUT, and verify it is forwarded back.

         Args:
@@ -63,55 +63,58 @@ def rx_queue_start_stop(self) -> None:
         """Rx queue start stop test.

         Steps:
-            Launch testpmd, stop Rx queue 0 on port 0.
-            Stop testpmd, start Rx queue 0 on port 0, start testpmd.
+            * Launch testpmd, stop Rx queue 0 on port 0.
+            * Stop testpmd, start Rx queue 0 on port 0, start testpmd.
+
         Verify:
-            Send a packet on port 0 after Rx queue is stopped, ensure it is not received.
-            Send a packet on port 0 after Rx queue is started, ensure it is received.
+            * Send a packet on port 0 after Rx queue is stopped and the packet is not received.
+            * Send a packet on port 0 after Rx queue is started and the packet is received.
         """
         with TestPmd() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
             testpmd.stop_port_queue(0, 0, True)
             testpmd.start()
-            self.send_packet_and_verify(should_receive=False)
+            self._send_packet_and_verify(should_receive=False)
             testpmd.stop()
             testpmd.start_port_queue(0, 0, True)
             testpmd.start()
-            self.send_packet_and_verify(should_receive=True)
+            self._send_packet_and_verify(should_receive=True)

     @func_test
     def tx_queue_start_stop(self) -> None:
         """Tx queue start stop test.

         Steps:
-            Launch testpmd, stop Tx queue 0 on port 0.
-            Stop testpmd, start Tx queue 0 on port 0, start testpmd.
+            * Launch testpmd, stop Tx queue 0 on port 0.
+            * Stop testpmd, start Tx queue 0 on port 0, start testpmd.
+
         Verify:
-            Send a packet on port 0 after Tx queue is stopped, ensure it is not received.
-            Send a packet on port 0 after Tx queue is started, ensure it is received.
+            * Send a packet on port 0 after Tx queue is stopped and the packet is not received.
+            * Send a packet on port 0 after Tx queue is started and the packet is received.
         """
         with TestPmd() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
             testpmd.stop_port_queue(1, 0, False)
             testpmd.start()
-            self.send_packet_and_verify(should_receive=False)
+            self._send_packet_and_verify(should_receive=False)
             testpmd.stop()
             testpmd.start_port_queue(1, 0, False)
             testpmd.start()
-            self.send_packet_and_verify(should_receive=True)
+            self._send_packet_and_verify(should_receive=True)

     @func_test
     def rx_queue_deferred_start(self) -> None:
         """Rx queue deferred start stop test.

         Steps:
-            Stop all ports, enable deferred start mode on port 0 Rx queue 0, start all ports.
-            Launch testpmd, send a packet.
-            Stop testpmd, start port 0 Rx queue 0.
-            Start testpmd, send a packet.
+            * Stop all ports, enable deferred start mode on port 0 Rx queue 0, start all ports.
+            * Launch testpmd, send a packet.
+            * Stop testpmd, start port 0 Rx queue 0.
+            * Start testpmd, send a packet.
+
         Verify:
-            Send a packet on port 0 after deferred start is set, ensure it is not received.
-            Send a packet on port 0 after Rx queue 0 is started, ensure it is received.
+            * Send a packet on port 0 after deferred start is set and the packet is not received.
+            * Send a packet on port 0 after Rx queue 0 is started and the packet is received.
         """
         with TestPmd() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
@@ -119,24 +122,25 @@ def rx_queue_deferred_start(self) -> None:
             testpmd.set_queue_deferred_start(0, 0, True, True)
             testpmd.start_all_ports()
             testpmd.start()
-            self.send_packet_and_verify(should_receive=False)
+            self._send_packet_and_verify(should_receive=False)
             testpmd.stop()
             testpmd.start_port_queue(0, 0, True)
             testpmd.start()
-            self.send_packet_and_verify(should_receive=True)
+            self._send_packet_and_verify(should_receive=True)

     @func_test
     def tx_queue_deferred_start(self) -> None:
         """Tx queue start stop test.

         Steps:
-            Stop all ports, enable deferred start mode on port 1 Tx queue 0, start all ports.
-            Launch testpmd, send a packet.
-            Stop testpmd, start port 1 Tx queue 0.
-            Start testpmd, send a packet.
+            * Stop all ports, enable deferred start mode on port 1 Tx queue 0, start all ports.
+            * Launch testpmd, send a packet.
+            * Stop testpmd, start port 1 Tx queue 0.
+            * Start testpmd, send a packet.
+
         Verify:
-            Send a packet on port 1 after deferred start is set, ensure it is not received.
-            Send a packet on port 1 after Tx queue 0 is started, ensure it is received.
+            * Send a packet on port 1 after deferred start is set and the packet is not received.
+            * Send a packet on port 1 after Tx queue 0 is started and the packet is received.
         """
         with TestPmd() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
@@ -144,8 +148,8 @@ def tx_queue_deferred_start(self) -> None:
             testpmd.set_queue_deferred_start(1, 0, False, True)
             testpmd.start_all_ports()
             testpmd.start()
-            self.send_packet_and_verify(should_receive=False)
+            self._send_packet_and_verify(should_receive=False)
             testpmd.stop()
             testpmd.start_port_queue(1, 0, False)
             testpmd.start()
-            self.send_packet_and_verify(should_receive=True)
+            self._send_packet_and_verify(should_receive=True)
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 9a92254a49..79b16973eb 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -49,7 +49,7 @@ class TestRteFlow(TestSuite):

     """

-    def runner(
+    def _runner(
         self,
         verification_method: Callable[..., Any],
         flows: list[FlowRule],
@@ -99,20 +99,20 @@ def zip_lists(
                     self.log("Flow rule validation passed, but flow creation failed.")
                     self.verify(False, "Failed flow creation")

-                if verification_method == self.send_packet_and_verify:
+                if verification_method == self._send_packet_and_verify:
                     verification_method(packet=packet, *args, **kwargs)

-                elif verification_method == self.send_packet_and_verify_queue:
+                elif verification_method == self._send_packet_and_verify_queue:
                     verification_method(
                         packet=packet, test_queue=kwargs["test_queue"], testpmd=testpmd
                     )

-                elif verification_method == self.send_packet_and_verify_modification:
+                elif verification_method == self._send_packet_and_verify_modification:
                     verification_method(packet=packet, expected_packet=expected_packet)

                 testpmd.flow_delete(flow_id, port_id=port_id)

-    def send_packet_and_verify(self, packet: Packet, should_receive: bool = True) -> None:
+    def _send_packet_and_verify(self, packet: Packet, should_receive: bool = True) -> None:
         """Generate a packet, send to the DUT, and verify it is forwarded back.

         Args:
@@ -128,7 +128,7 @@ def send_packet_and_verify(self, packet: Packet, should_receive: bool = True) ->
             f"Packet was {'dropped' if should_receive else 'received'}",
         )

-    def send_packet_and_verify_queue(
+    def _send_packet_and_verify_queue(
         self, packet: Packet, test_queue: int, testpmd: TestPmd
     ) -> None:
         """Send packet and verify queue stats show packet was received.
@@ -148,7 +148,7 @@ def send_packet_and_verify_queue(
                 received = True
         self.verify(received, f"Expected packet was not received on queue {test_queue}")

-    def send_packet_and_verify_modification(self, packet: Packet, expected_packet: Packet) -> None:
+    def _send_packet_and_verify_modification(self, packet: Packet, expected_packet: Packet) -> None:
         """Send packet and verify the expected modifications are present upon reception.

         Args:
@@ -184,7 +184,7 @@ def send_packet_and_verify_modification(self, packet: Packet, expected_packet: P
                 f"MAC dst mismatch: expected {expected_mac_dst}, got {received_mac_dst}",
             )

-    def send_packet_and_verify_jump(
+    def _send_packet_and_verify_jump(
         self,
         packets: list[Packet],
         flow_rules: list[FlowRule],
@@ -225,14 +225,14 @@ def queue_action_ETH(self) -> None:
         """Validate flow rules with queue actions and ethernet patterns.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Check that each packet is received on the appropriate queue.
+            * Each packet is received on the appropriate queue.
         """
         packet_list = [
             Ether(src="02:00:00:00:00:00"),
@@ -254,8 +254,8 @@ def queue_action_ETH(self) -> None:
                 direction="ingress", pattern=["eth type is 0x0800"], actions=["queue index 2"]
             ),
         ]
-        self.runner(
-            verification_method=self.send_packet_and_verify_queue,
+        self._runner(
+            verification_method=self._send_packet_and_verify_queue,
             flows=flow_list,
             packets=packet_list,
             port_id=0,
@@ -267,14 +267,14 @@ def queue_action_IP(self) -> None:
         """Validate flow rules with queue actions and IPv4/IPv6 patterns.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Check that each packet is received on the appropriate queue.
+            * Each packet is received on the appropriate queue.
         """
         packet_list = [
             Ether() / IP(src="192.168.1.1"),
@@ -312,8 +312,8 @@ def queue_action_IP(self) -> None:
                 direction="ingress", pattern=["eth / ipv6 proto is 17"], actions=["queue index 2"]
             ),
         ]
-        self.runner(
-            verification_method=self.send_packet_and_verify_queue,
+        self._runner(
+            verification_method=self._send_packet_and_verify_queue,
             flows=flow_list,
             packets=packet_list,
             port_id=0,
@@ -326,14 +326,14 @@ def queue_action_L4(self) -> None:
         """Validate flow rules with queue actions and TCP/UDP patterns.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Check that each packet is received on the appropriate queue.
+            * Each packet is received on the appropriate queue.
         """
         packet_list = [
             Ether() / IP() / TCP(sport=1234),
@@ -369,8 +369,8 @@ def queue_action_L4(self) -> None:
                 actions=["queue index 2"],
             ),
         ]
-        self.runner(
-            verification_method=self.send_packet_and_verify_queue,
+        self._runner(
+            verification_method=self._send_packet_and_verify_queue,
             flows=flow_list,
             packets=packet_list,
             port_id=0,
@@ -382,22 +382,22 @@ def queue_action_VLAN(self) -> None:
         """Validate flow rules with queue actions and VLAN patterns.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Check that each packet is received on the appropriate queue.
+            * Each packet is received on the appropriate queue.
         """
         packet_list = [Ether() / Dot1Q(vlan=100), Ether() / Dot1Q(type=0x0800)]
         flow_list = [
             FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["queue index 2"]),
             FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["queue index 2"]),
         ]
-        self.runner(
-            verification_method=self.send_packet_and_verify_queue,
+        self._runner(
+            verification_method=self._send_packet_and_verify_queue,
             flows=flow_list,
             packets=packet_list,
             port_id=0,
@@ -409,14 +409,14 @@ def drop_action_ETH(self) -> None:
         """Validate flow rules with drop actions and ethernet patterns.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Check that each packet is dropped.
+            * Packet is dropped.

         One packet will be sent as a confidence check, to ensure packets are being
         received under normal circumstances.
@@ -441,8 +441,8 @@ def drop_action_ETH(self) -> None:
             testpmd.start()
             received = self.send_packet_and_capture(packet)
             self.verify(received != [], "Test packet was never received.")
-        self.runner(
-            verification_method=self.send_packet_and_verify,
+        self._runner(
+            verification_method=self._send_packet_and_verify,
             flows=flow_list,
             packets=packet_list,
             port_id=0,
@@ -454,14 +454,14 @@ def drop_action_IP(self) -> None:
         """Validate flow rules with drop actions and ethernet patterns.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Check that each packet is dropped.
+            * Packet is dropped.

         One packet will be sent as a confidence check, to ensure packets are being
         received under normal circumstances.
@@ -496,8 +496,8 @@ def drop_action_IP(self) -> None:
             testpmd.start()
             received = self.send_packet_and_capture(packet)
             self.verify(received != [], "Test packet was never received.")
-        self.runner(
-            verification_method=self.send_packet_and_verify,
+        self._runner(
+            verification_method=self._send_packet_and_verify,
             flows=flow_list,
             packets=packet_list,
             port_id=0,
@@ -509,14 +509,14 @@ def drop_action_L4(self) -> None:
         """Validate flow rules with drop actions and ethernet patterns.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Check that each packet is dropped.
+            * Packet is dropped.

         One packet will be sent as a confidence check, to ensure packets are being
         received under normal circumstances.
@@ -547,8 +547,8 @@ def drop_action_L4(self) -> None:
             testpmd.start()
             received = self.send_packet_and_capture(packet)
             self.verify(received != [], "Test packet was never received.")
-        self.runner(
-            verification_method=self.send_packet_and_verify,
+        self._runner(
+            verification_method=self._send_packet_and_verify,
             flows=flow_list,
             packets=packet_list,
             port_id=0,
@@ -560,14 +560,14 @@ def drop_action_VLAN(self) -> None:
         """Validate flow rules with drop actions and ethernet patterns.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Check that each packet is dropped.
+            * Packet is dropped.

         One packet will be sent as a confidence check, to ensure packets are being
         received under normal circumstances.
@@ -586,8 +586,8 @@ def drop_action_VLAN(self) -> None:
             testpmd.start()
             received = self.send_packet_and_capture(packet)
             self.verify(received != [], "Test packet was never received.")
-        self.runner(
-            verification_method=self.send_packet_and_verify,
+        self._runner(
+            verification_method=self._send_packet_and_verify,
             flows=flow_list,
             packets=packet_list,
             port_id=0,
@@ -599,14 +599,14 @@ def modify_actions(self) -> None:
         """Validate flow rules with actions that modify that packet during transmission.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Verify packet is received with the new attributes.
+            * Verify packet is received with the new attributes.
         """
         packet_list = [Ether() / IP(src="192.68.1.1"), Ether(src="02:00:00:00:00:00")]
         flow_list = [
@@ -631,8 +631,8 @@ def modify_actions(self) -> None:
             ),
         ]
         expected_packet_list = [Ether() / IP(dst="192.68.1.1"), Ether(dst="02:00:00:00:00:00")]
-        self.runner(
-            verification_method=self.send_packet_and_verify_modification,
+        self._runner(
+            verification_method=self._send_packet_and_verify_modification,
             flows=flow_list,
             packets=packet_list,
             port_id=0,
@@ -644,14 +644,14 @@ def egress_rules(self) -> None:
         """Validate flow rules with egress directions.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Check that each packet is dropped.
+            * Packet is dropped.

         One packet will be sent as a confidence check, to ensure packets are being
         received under normal circumstances.
@@ -676,8 +676,8 @@ def egress_rules(self) -> None:
             testpmd.start()
             received = self.send_packet_and_capture(packet)
             self.verify(received != [], "Test packet was never received.")
-        self.runner(
-            verification_method=self.send_packet_and_verify,
+        self._runner(
+            verification_method=self._send_packet_and_verify,
             flows=flow_list,
             packets=packet_list,
             port_id=1,
@@ -689,13 +689,13 @@ def jump_action(self) -> None:
         """Validate flow rules with different group levels and jump actions.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Create each flow rule in testpmd.
-            Send each packet in the list, check Rx queue ID.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd with the necessary configuration.
+            * Create each flow rule in testpmd.
+            * Send each packet in the list, check Rx queue ID.

         Verify:
-            Check that each packet is received on the appropriate Rx queue.
+            * Check that each packet is received on the appropriate Rx queue.
         """
         packet_list = [Ether() / IP(), Ether() / IP() / TCP(), Ether() / IP() / UDP()]
         flow_list = [
@@ -732,7 +732,7 @@ def jump_action(self) -> None:
         ]
         expected_queue_list = [1, 2, 3]
         with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
-            self.send_packet_and_verify_jump(
+            self._send_packet_and_verify_jump(
                 packets=packet_list,
                 flow_rules=flow_list,
                 test_queues=expected_queue_list,
@@ -744,14 +744,14 @@ def priority_attribute(self) -> None:
         """Validate flow rules with queue actions and ethernet patterns.

         Steps:
-            Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd.
-            Create first flow rule in flow list.
-            Send first packet in packet list, capture verbose output.
-            Delete flow rule, repeat for all flows/packets.
+            * Create a list of packets to test, with a corresponding flow list.
+            * Launch testpmd.
+            * Create first flow rule in flow list.
+            * Send first packet in packet list, capture verbose output.
+            * Delete flow rule, repeat for all flows/packets.

         Verify:
-            Check that each packet is received on the appropriate queue.
+            * Each packet is received on the appropriate queue.
         """
         test_packet = Ether() / IP() / Raw()
         flow_list = [
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 6427f878b3..4211f5d97d 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -59,8 +59,11 @@ def unit_tests(self) -> None:
         Test that all unit test from the ``fast-tests`` suite pass.
         The suite is a subset with only the most basic tests.

-        Test:
-            Run the ``fast-tests`` unit test suite through meson.
+        Steps:
+            * Run the ``fast-tests`` unit test suite through meson.
+
+        Verify:
+            * That driver unit tests are executed through meson.
         """
         self.sut_node.main_session.send_command(
             f"meson test -C {self.dpdk_build_dir_path} --suite fast-tests -t 120",
@@ -77,8 +80,11 @@ def driver_tests(self) -> None:
         The suite is a subset with driver tests. This suite may be run with virtual devices
         configured in the test run configuration.

-        Test:
-            Run the ``driver-tests`` unit test suite through meson.
+        Steps:
+            * Run the ``driver-tests`` unit test suite through meson.
+
+        Verify:
+            * Driver unit tests are executed successfully.
         """
         vdev_args = ""
         for dev in self._ctx.dpdk.get_virtual_devices():
@@ -104,8 +110,11 @@ def devices_listed_in_testpmd(self) -> None:

         Test that the devices configured in the test run configuration are found in testpmd.

-        Test:
-            List all devices found in testpmd and verify the configured devices are among them.
+        Steps:
+            * List all devices found in testpmd.
+
+        Verify:
+            * The configured devices are among them.
         """
         with TestPmd() as testpmd:
             dev_list = [str(x) for x in testpmd.get_devices()]
@@ -123,9 +132,11 @@ def device_bound_to_driver(self) -> None:
         Test that the devices configured in the test run configuration are bound to
         the proper driver. This test case runs on Linux only.

-        Test:
-            List all devices with the ``dpdk-devbind.py`` script and verify that
-            the configured devices are bound to the proper driver.
+        Steps:
+            * List all devices with the ``dpdk-devbind.py`` script.
+
+        Verify:
+            * The configured devices are bound to the proper driver.
         """
         if not isinstance(self._ctx.sut_node.main_session, LinuxSession):
             return
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index 13d8121961..224d2103cb 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -82,14 +82,13 @@ def softnic(self) -> None:
         """Softnic test.

         Steps:
-            Start Testpmd with a softnic vdev using the provided config files.
-            Testpmd forwarding is disabled, instead configure softnic to forward packets
-            from port 0 to port 1 of the physical device.
-            Send generated packets from the TG.
+            * Start Testpmd with a softnic vdev using the provided config files.
+            * Testpmd forwarding is disabled, instead configure softnic to forward packets
+            * from port 0 to port 1 of the physical device.
+            * Send generated packets from the TG.

         Verify:
-            The packets that are received are the same as the packets sent.
-
+            * The packets that are received are the same as the packets sent.
         """
         with TestPmd(
             vdevs=[VirtualDevice(f"net_softnic0,firmware={self.cli_file},cpu_id=1,conn_port=8086")],
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index a624731b9f..d258f95d24 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -41,7 +41,7 @@ class TestUniPkt(TestSuite):

     """

-    def check_for_matching_packet(
+    def _check_for_matching_packet(
         self, output: list[TestPmdVerbosePacket], flags: RtePTypes
     ) -> bool:
         """Returns :data:`True` if the packet in verbose output contains all specified flags."""
@@ -51,23 +51,23 @@ def check_for_matching_packet(
                     return False
         return True

-    def send_packet_and_verify_flags(
+    def _send_packet_and_verify_flags(
         self, expected_flag: RtePTypes, packet: Packet, testpmd: TestPmd
     ) -> None:
         """Sends a packet to the DUT and verifies the verbose ptype flags."""
         self.send_packet_and_capture(packet=packet)
         verbose_output = testpmd.extract_verbose_output(testpmd.stop())
-        valid = self.check_for_matching_packet(output=verbose_output, flags=expected_flag)
+        valid = self._check_for_matching_packet(output=verbose_output, flags=expected_flag)
         self.verify(valid, f"Packet type flag did not match the expected flag: {expected_flag}.")

-    def setup_session(
+    def _setup_session(
         self, testpmd: TestPmd, expected_flags: list[RtePTypes], packet_list=list[Packet]
     ) -> None:
         """Sets the forwarding and verbose mode of each test case interactive shell session."""
         testpmd.set_forward_mode(SimpleForwardingModes.rxonly)
         testpmd.set_verbose(level=1)
         for i in range(0, len(packet_list)):
-            self.send_packet_and_verify_flags(
+            self._send_packet_and_verify_flags(
                 expected_flag=expected_flags[i], packet=packet_list[i], testpmd=testpmd
             )

@@ -76,32 +76,32 @@ def l2_packet_detect(self) -> None:
         """Ensure the correct flags are shown in verbose output when sending L2 packets.

         Steps:
-            Create a list of packets to test, with a corresponding flag list to check against.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            * Create a list of packets to test, with a corresponding flag list to check against.
+            * Launch testpmd with the necessary configuration.
+            * Send each packet in the list, capture testpmd verbose output.

         Verify:
-            Check that each packet has a destination MAC address matching the set ID.
-            Check the packet type fields in verbose output, verify the flags match.
+            * Each packet has a destination MAC address matching the set ID.
+            * Packet type flags match in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [Ether(type=0x88F7) / UDP(dport=dport_id) / Raw(), Ether() / ARP() / Raw()]
         flag_list = [RtePTypes.L2_ETHER_TIMESYNC, RtePTypes.L2_ETHER_ARP]
         with TestPmd() as testpmd:
-            self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
+            self._setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @func_test
     def l3_l4_packet_detect(self) -> None:
         """Ensure correct flags are shown in the verbose output when sending IP/L4 packets.

         Steps:
-            Create a list of packets to test, with a corresponding flag list to check against.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            * Create a list of packets to test, with a corresponding flag list to check against.
+            * Launch testpmd with the necessary configuration.
+            * Send each packet in the list, capture testpmd verbose output.

         Verify:
-            Check that each packet has a destination MAC address matching the set ID.
-            Check the packet type fields in verbose output, verify the flags match.
+            * Each packet has a destination MAC address matching the set ID.
+            * Packet type flags match in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -121,20 +121,20 @@ def l3_l4_packet_detect(self) -> None:
             RtePTypes.L4_FRAG | RtePTypes.L3_IPV4_EXT_UNKNOWN | RtePTypes.L2_ETHER,
         ]
         with TestPmd() as testpmd:
-            self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
+            self._setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @func_test
     def ipv6_l4_packet_detect(self) -> None:
         """Ensure correct flags are shown in the verbose output when sending IPv6/L4 packets.

         Steps:
-            Create a list of packets to test, with a corresponding flag list to check against.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            * Create a list of packets to test, with a corresponding flag list to check against.
+            * Launch testpmd with the necessary configuration.
+            * Send each packet in the list, capture testpmd verbose output.

         Verify:
-            Check that each packet has a destination MAC address matching the set ID.
-            Check the packet type fields in verbose output, verify the flags match.
+            * Each packet has a destination MAC address matching the set ID.
+            * Packet type flags match in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -150,20 +150,20 @@ def ipv6_l4_packet_detect(self) -> None:
             RtePTypes.L3_IPV6_EXT_UNKNOWN,
         ]
         with TestPmd() as testpmd:
-            self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
+            self._setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @func_test
     def l3_tunnel_packet_detect(self) -> None:
         """Ensure correct flags are shown in the verbose output when sending IPv6/L4 packets.

         Steps:
-            Create a list of packets to test, with a corresponding flag list to check against.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            * Create a list of packets to test, with a corresponding flag list to check against.
+            * Launch testpmd with the necessary configuration.
+            * Send each packet in the list, capture testpmd verbose output.

         Verify:
-            Check that each packet has a destination MAC address matching the set ID.
-            Check the packet type fields in verbose output, verify the flags match.
+            * Each packet has a destination MAC address matching the set ID.
+            * Packet type flags match in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -185,20 +185,20 @@ def l3_tunnel_packet_detect(self) -> None:
             RtePTypes.TUNNEL_IP | RtePTypes.INNER_L3_IPV6_EXT_UNKNOWN | RtePTypes.INNER_L4_FRAG,
         ]
         with TestPmd() as testpmd:
-            self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
+            self._setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @func_test
     def gre_tunnel_packet_detect(self) -> None:
         """Ensure the correct flags are shown in the verbose output when sending GRE packets.

         Steps:
-            Create a list of packets to test, with a corresponding flag list to check against.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            * Create a list of packets to test, with a corresponding flag list to check against.
+            * Launch testpmd with the necessary configuration.
+            * Send each packet in the list, capture testpmd verbose output.

         Verify:
-            Check that each packet has a destination MAC address matching the set ID.
-            Check the packet type fields in verbose output, verify the flags match.
+            * Each packet has a destination MAC address matching the set ID.
+            * Packet type flags match in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -218,20 +218,20 @@ def gre_tunnel_packet_detect(self) -> None:
             RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_ICMP,
         ]
         with TestPmd() as testpmd:
-            self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
+            self._setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @func_test
     def nsh_packet_detect(self) -> None:
         """Verify the correct flags are shown in the verbose output when sending NSH packets.

         Steps:
-            Create a list of packets to test, with a corresponding flag list to check against.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            * Create a list of packets to test, with a corresponding flag list to check against.
+            * Launch testpmd with the necessary configuration.
+            * Send each packet in the list, capture testpmd verbose output.

         Verify:
-            Check that each packet has a destination MAC address matching the set ID.
-            Check the packet type fields in verbose output, verify the flags match.
+            * Each packet has a destination MAC address matching the set ID.
+            * Packet type flags match in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -258,7 +258,7 @@ def nsh_packet_detect(self) -> None:
             RtePTypes.L2_ETHER_NSH | RtePTypes.L3_IPV6_EXT_UNKNOWN | RtePTypes.L4_NONFRAG,
         ]
         with TestPmd() as testpmd:
-            self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
+            self._setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
     @func_test
@@ -266,14 +266,14 @@ def vxlan_tunnel_packet_detect(self) -> None:
         """Ensure the correct flags are shown in the verbose output when sending VXLAN packets.

         Steps:
-            Create a list of packets to test, with a corresponding flag list to check against.
-            Add a UDP port for VXLAN packet filter within testpmd.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            * Create a list of packets to test, with a corresponding flag list to check against.
+            * Add a UDP port for VXLAN packet filter within testpmd.
+            * Launch testpmd with the necessary configuration.
+            * Send each packet in the list, capture testpmd verbose output.

         Verify:
-            Check that each packet has a destination MAC address matching the set ID.
-            Check the packet type fields in verbose output, verify the flags match.
+            * Each packet has a destination MAC address matching the set ID.
+            * Packet type flags match in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -296,4 +296,4 @@ def vxlan_tunnel_packet_detect(self) -> None:
         ]
         with TestPmd() as testpmd:
             testpmd.rx_vxlan(4789, 0, True)
-            self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
+            self._setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index 490f665747..6c1b181c74 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -44,7 +44,7 @@ class TestVlan(TestSuite):
     tag when insertion is enabled.
     """

-    def send_vlan_packet_and_verify(self, should_receive: bool, strip: bool, vlan_id: int) -> None:
+    def _send_vlan_packet_and_verify(self, should_receive: bool, strip: bool, vlan_id: int) -> None:
         """Generate a VLAN packet, send and verify packet with same payload is received on the dut.

         Args:
@@ -83,7 +83,7 @@ def send_vlan_packet_and_verify(self, should_receive: bool, strip: bool, vlan_id
                 "Packet was received when it should have been dropped",
             )

-    def send_packet_and_verify_insertion(self, expected_id: int) -> None:
+    def _send_packet_and_verify_insertion(self, expected_id: int) -> None:
         """Generate a packet with no VLAN tag, send and verify on the dut.

         Args:
@@ -110,7 +110,7 @@ def send_packet_and_verify_insertion(self, expected_id: int) -> None:
                 "The received tag did not match the expected tag",
             )

-    def vlan_setup(self, testpmd: TestPmd, port_id: int, filtered_id: int) -> None:
+    def _vlan_setup(self, testpmd: TestPmd, port_id: int, filtered_id: int) -> None:
         """Setup method for all test cases.

         Args:
@@ -127,46 +127,68 @@ def vlan_setup(self, testpmd: TestPmd, port_id: int, filtered_id: int) -> None:
     def vlan_receipt_no_stripping(self) -> None:
         """Verify packets are received with their VLAN IDs when stripping is disabled.

-        Test:
-            Create an interactive testpmd shell and verify a VLAN packet.
+        Steps:
+            * Start testpmd.
+            * Set up VLAN.
+            * Send and capture VLAN packet.
+
+        Verify:
+            * Packets are received with their VLAN IDS.
         """
         with TestPmd() as testpmd:
-            self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
+            self._vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
             testpmd.start()
-            self.send_vlan_packet_and_verify(True, strip=False, vlan_id=1)
+            self._send_vlan_packet_and_verify(should_receive=True, strip=False, vlan_id=1)

     @requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN_STRIP)
     @func_test
     def vlan_receipt_stripping(self) -> None:
         """Ensure VLAN packet received with no tag when receipts and header stripping are enabled.

-        Test:
-            Create an interactive testpmd shell and verify a VLAN packet.
+        Steps:
+            * Start testpmd.
+            * Set up VLAN.
+            * Send and capture VLAN packet with the packet header stripped.
+
+        Verify:
+            * Packets are received with no tag when receipts and header stripping are enabled.
         """
         with TestPmd() as testpmd:
-            self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
+            self._vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
             testpmd.set_vlan_strip(port=0, enable=True)
             testpmd.start()
-            self.send_vlan_packet_and_verify(should_receive=True, strip=True, vlan_id=1)
+            self._send_vlan_packet_and_verify(should_receive=True, strip=True, vlan_id=1)

     @func_test
     def vlan_no_receipt(self) -> None:
         """Ensure VLAN packet dropped when filter is on and sent tag not in the filter list.

-        Test:
-            Create an interactive testpmd shell and verify a VLAN packet.
+        Steps:
+            * Start testpmd.
+            * Set up VLAN.
+            * Send VLAN packets.
+
+        Verify:
+            * VLAN packets are dropped.
         """
         with TestPmd() as testpmd:
-            self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
+            self._vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
             testpmd.start()
-            self.send_vlan_packet_and_verify(should_receive=False, strip=False, vlan_id=2)
+            self._send_vlan_packet_and_verify(should_receive=False, strip=False, vlan_id=2)

     @func_test
     def vlan_header_insertion(self) -> None:
         """Ensure that VLAN packet is received with the correct inserted VLAN tag.

-        Test:
-            Create an interactive testpmd shell and verify a non-VLAN packet.
+        Steps:
+            * Start testpmd.
+            * Set forwarding mode to MAC.
+            * Disable promiscuous mode.
+            * Enable Tx VLAN and set the VLAN tag.
+            * Send and capture VLAN packets.
+
+        Verify:
+            * VLAN packets are received with the correct inserted VLAN tag.
         """
         with TestPmd() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
@@ -175,4 +197,4 @@ def vlan_header_insertion(self) -> None:
             testpmd.tx_vlan_set(port=1, enable=True, vlan=51)
             testpmd.start_all_ports()
             testpmd.start()
-            self.send_packet_and_verify_insertion(expected_id=51)
+            self._send_packet_and_verify_insertion(expected_id=51)
--
2.39.5

