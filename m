Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E60CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 17:43:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28C0940670;
	Fri, 29 Aug 2025 19:43:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 90832402C1
 for <dev@dpdk.org>; Fri, 29 Aug 2025 19:43:29 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B3EC19F0;
 Fri, 29 Aug 2025 10:43:20 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.64.222])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 660BA3F738;
 Fri, 29 Aug 2025 10:43:28 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [RFC 2/2] dts: update tests to use new API
Date: Fri, 29 Aug 2025 18:43:12 +0100
Message-Id: <20250829174312.2855311-3-paul.szczepanek@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829174312.2855311-1-paul.szczepanek@arm.com>
References: <20250829174312.2855311-1-paul.szczepanek@arm.com>
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

Adjust imports and calls in all tests to use the new public API.

Signed-off-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/tests/TestSuite_blocklist.py              | 11 +++--
 dts/tests/TestSuite_checksum_offload.py       | 44 ++++++++++---------
 dts/tests/TestSuite_dual_vlan.py              | 12 ++---
 dts/tests/TestSuite_dynamic_config.py         | 27 +++++++-----
 dts/tests/TestSuite_dynamic_queue_conf.py     | 29 ++++++------
 dts/tests/TestSuite_hello_world.py            |  4 +-
 dts/tests/TestSuite_l2fwd.py                  | 18 +++++---
 dts/tests/TestSuite_mac_filter.py             | 17 ++++---
 dts/tests/TestSuite_mtu.py                    | 19 ++++----
 dts/tests/TestSuite_packet_capture.py         | 14 +++---
 dts/tests/TestSuite_pmd_buffer_scatter.py     | 19 ++++----
 dts/tests/TestSuite_port_control.py           | 21 +++++----
 ...stSuite_port_restart_config_persistency.py | 14 +++---
 dts/tests/TestSuite_port_stats.py             | 21 ++++-----
 dts/tests/TestSuite_promisc_support.py        | 11 +++--
 dts/tests/TestSuite_queue_start_stop.py       | 24 ++++++----
 dts/tests/TestSuite_rte_flow.py               | 36 ++++++++-------
 dts/tests/TestSuite_smoke_tests.py            | 11 +++--
 dts/tests/TestSuite_softnic.py                | 18 +++++---
 dts/tests/TestSuite_uni_pkt.py                | 35 ++++++++-------
 dts/tests/TestSuite_vlan.py                   | 26 ++++++-----
 21 files changed, 247 insertions(+), 184 deletions(-)

diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index ce7da1cc8f..1d1d1f3390 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -6,19 +6,22 @@
 This testing suite ensures tests the port blocklisting functionality of testpmd.
 """

-from framework.remote_session.testpmd_shell import TestPmdShell
+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.testpmd import TestPmd
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import TopologyType, requires
 from framework.testbed_model.port import Port


-@requires(topology_type=TopologyType.two_links)
+@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestBlocklist(TestSuite):
     """DPDK device blocklisting test suite."""

     def verify_blocklisted_ports(self, ports_to_block: list[Port]):
         """Runs testpmd with the given ports blocklisted and verifies the ports."""
-        with TestPmdShell(allowed_ports=[], blocked_ports=ports_to_block) as testpmd:
+        with TestPmd(allowed_ports=[], blocked_ports=ports_to_block) as testpmd:
             allowlisted_ports = {port.device_name for port in testpmd.show_port_info_all()}
             blocklisted_ports = {port.pci for port in ports_to_block}

diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index d411af70a9..e72132d52d 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -19,20 +19,22 @@
 from scapy.layers.sctp import SCTP
 from scapy.packet import Packet, Raw

-from framework.params.testpmd import SimpleForwardingModes
-from framework.remote_session.testpmd_shell import (
-    ChecksumOffloadOptions,
-    PacketOffloadFlag,
-    TestPmdShell,
+from api.capabilities import (
+    LinkTopology,
+    NicCapability,
+    requires_link_topology,
+    requires_nic_capability,
 )
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
+from api.testpmd.types import ChecksumOffloadOptions, PacketOffloadFlag
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import NicCapability, TopologyType, requires


-@requires(topology_type=TopologyType.two_links)
-@requires(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
-@requires(NicCapability.RX_OFFLOAD_UDP_CKSUM)
-@requires(NicCapability.RX_OFFLOAD_TCP_CKSUM)
+@requires_link_topology(LinkTopology.TWO_LINKS)
+@requires_nic_capability(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
+@requires_nic_capability(NicCapability.RX_OFFLOAD_UDP_CKSUM)
+@requires_nic_capability(NicCapability.RX_OFFLOAD_TCP_CKSUM)
 class TestChecksumOffload(TestSuite):
     """Checksum offload test suite.

@@ -69,7 +71,7 @@ def send_packets_and_verify(
             )

     def send_packet_and_verify_checksum(
-        self, packet: Packet, good_L4: bool, good_IP: bool, testpmd: TestPmdShell, id: int
+        self, packet: Packet, good_L4: bool, good_IP: bool, testpmd: TestPmd, id: int
     ) -> None:
         """Send packet and verify verbose output matches expected output.

@@ -97,7 +99,7 @@ def send_packet_and_verify_checksum(
         self.verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
         self.verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")

-    def setup_hw_offload(self, testpmd: TestPmdShell) -> None:
+    def setup_hw_offload(self, testpmd: TestPmd) -> None:
         """Sets IP, UDP, and TCP layers to hardware offload.

         Args:
@@ -132,7 +134,7 @@ def test_insert_checksums(self) -> None:
             Ether() / IPv6(src="::1") / UDP(dport=dport_id) / Raw(payload),
             Ether() / IPv6(src="::1") / TCP(dport=dport_id) / Raw(payload),
         ]
-        with TestPmdShell(enable_rx_cksum=True) as testpmd:
+        with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
             self.setup_hw_offload(testpmd=testpmd)
@@ -164,7 +166,7 @@ def test_no_insert_checksums(self) -> None:
             Ether() / IPv6(src="::1") / UDP(dport=dport_id) / Raw(payload),
             Ether() / IPv6(src="::1") / TCP(dport=dport_id) / Raw(payload),
         ]
-        with TestPmdShell(enable_rx_cksum=True) as testpmd:
+        with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
             testpmd.start()
@@ -194,7 +196,7 @@ def test_l4_rx_checksum(self) -> None:
             Ether() / IP() / UDP(chksum=0xF, dport=dport_id),
             Ether() / IP() / TCP(chksum=0xF, dport=dport_id),
         ]
-        with TestPmdShell(enable_rx_cksum=True) as testpmd:
+        with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
             self.setup_hw_offload(testpmd=testpmd)
@@ -227,7 +229,7 @@ def test_l3_rx_checksum(self) -> None:
             Ether() / IP(chksum=0xF) / UDP(dport=dport_id),
             Ether() / IP(chksum=0xF) / TCP(dport=dport_id),
         ]
-        with TestPmdShell(enable_rx_cksum=True) as testpmd:
+        with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
             self.setup_hw_offload(testpmd=testpmd)
@@ -264,7 +266,7 @@ def test_validate_rx_checksum(self) -> None:
             Ether() / IPv6(src="::1") / UDP(chksum=0xF, dport=dport_id),
             Ether() / IPv6(src="::1") / TCP(chksum=0xF, dport=dport_id),
         ]
-        with TestPmdShell(enable_rx_cksum=True) as testpmd:
+        with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
             self.setup_hw_offload(testpmd=testpmd)
@@ -285,7 +287,7 @@ def test_validate_rx_checksum(self) -> None:
                     packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )

-    @requires(NicCapability.RX_OFFLOAD_VLAN)
+    @requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN)
     @func_test
     def test_vlan_checksum(self) -> None:
         """Test VLAN Rx checksum hardware offload and verify packet reception.
@@ -323,7 +325,7 @@ def test_vlan_checksum(self) -> None:
             / TCP(chksum=0xF, dport=dport_id)
             / Raw(payload),
         ]
-        with TestPmdShell(enable_rx_cksum=True) as testpmd:
+        with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
             self.setup_hw_offload(testpmd=testpmd)
@@ -342,7 +344,7 @@ def test_vlan_checksum(self) -> None:
                     packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )

-    @requires(NicCapability.RX_OFFLOAD_SCTP_CKSUM)
+    @requires_nic_capability(NicCapability.RX_OFFLOAD_SCTP_CKSUM)
     @func_test
     def test_validate_sctp_checksum(self) -> None:
         """Test SCTP Rx checksum hardware offload and verify packet reception.
@@ -361,7 +363,7 @@ def test_validate_sctp_checksum(self) -> None:
             Ether() / IP() / UDP(dport=dport_id) / SCTP(),
             Ether() / IP() / UDP(dport=dport_id) / SCTP(chksum=0xF),
         ]
-        with TestPmdShell(enable_rx_cksum=True) as testpmd:
+        with TestPmd(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
             testpmd.set_verbose(level=1)
             testpmd.csum_set_hw(layers=ChecksumOffloadOptions.sctp)
diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_vlan.py
index 6af503528d..41334b60c4 100644
--- a/dts/tests/TestSuite_dual_vlan.py
+++ b/dts/tests/TestSuite_dual_vlan.py
@@ -18,8 +18,8 @@
 from scapy.layers.l2 import Dot1Q, Ether
 from scapy.packet import Packet, Raw

-from framework.params.testpmd import SimpleForwardingModes
-from framework.remote_session.testpmd_shell import TestPmdShell
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test


@@ -153,7 +153,7 @@ def verify_vlan_functions(self, send_packet: Packet, options: TestCaseOptions) -
                 f"{expected_layers} with options {options}.",
             )

-    def configure_testpmd(self, shell: TestPmdShell, options: TestCaseOptions, add: bool) -> None:
+    def configure_testpmd(self, shell: TestPmd, options: TestCaseOptions, add: bool) -> None:
         """Configure VLAN functions in testpmd based on `options`.

         Args:
@@ -193,7 +193,7 @@ def insert_second_vlan(self) -> None:
             Packets are received.
             Packet contains two VLAN tags.
         """
-        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
+        with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.tx_vlan_set(port=self.tx_port, enable=True, vlan=self.vlan_insert_tag)
             testpmd.start()
             recv = self.send_packet_and_capture(
@@ -229,7 +229,7 @@ def all_vlan_functions(self) -> None:
             / Dot1Q(vlan=self.inner_vlan_tag)
             / Raw(b"X" * 20)
         )
-        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
+        with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.start()
             recv = self.send_packet_and_capture(send_pkt)
             self.verify(len(recv) > 0, "Unmodified packet was not received.")
@@ -269,7 +269,7 @@ def maintains_priority(self) -> None:
             / Dot1Q(vlan=self.inner_vlan_tag, prio=2)
             / Raw(b"X" * 20)
         )
-        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
+        with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.start()
             recv = self.send_packet_and_capture(pkt)
             self.verify(len(recv) > 0, "Did not receive any packets when testing VLAN priority.")
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 49f295a39a..ab500e3a7e 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -19,14 +19,19 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Raw

-from framework.params.testpmd import SimpleForwardingModes
-from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
+from api.capabilities import (
+    LinkTopology,
+    NicCapability,
+    requires_link_topology,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import TopologyType, requires


-@requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(topology_type=TopologyType.two_links)
+@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestDynamicConfig(TestSuite):
     """Dynamic config suite.

@@ -66,7 +71,7 @@ def send_packet_and_verify(self, should_receive: bool, mac_address: str) -> None
             f"Packet was {'dropped' if should_receive else 'received'}",
         )

-    def disable_promisc_setup(self, testpmd: TestPmdShell, port_id: int) -> TestPmdShell:
+    def disable_promisc_setup(self, testpmd: TestPmd, port_id: int) -> TestPmd:
         """Sets up testpmd shell config for cases where promisc mode is disabled.

         Args:
@@ -74,7 +79,7 @@ def disable_promisc_setup(self, testpmd: TestPmdShell, port_id: int) -> TestPmdS
             port_id: Port number to disable promisc mode on.

         Returns:
-            TestPmdShell: interactive testpmd shell object.
+            TestPmd: interactive testpmd shell object.
         """
         testpmd.start()
         testpmd.set_promisc(port=port_id, enable=False)
@@ -89,7 +94,7 @@ def test_default_mode(self) -> None:
         and sends two packets; one matching source MAC address and one unknown.
         Verifies that both are received.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             is_promisc = testpmd.show_port_info(0).is_promiscuous_mode_enabled
             self.verify(is_promisc, "Promiscuous mode was not enabled by default.")
             testpmd.start()
@@ -107,7 +112,7 @@ def test_disable_promisc(self) -> None:
         and sends two packets; one matching source MAC address and one unknown.
         Verifies that only the matching address packet is received.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd = self.disable_promisc_setup(testpmd=testpmd, port_id=0)
             mac = testpmd.show_port_info(0).mac_address
             self.send_packet_and_verify(should_receive=True, mac_address=str(mac))
@@ -121,7 +126,7 @@ def test_disable_promisc_broadcast(self) -> None:
         and sends two packets; one matching source MAC address and one broadcast.
         Verifies that both packets are received.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd = self.disable_promisc_setup(testpmd=testpmd, port_id=0)
             mac = testpmd.show_port_info(0).mac_address
             self.send_packet_and_verify(should_receive=True, mac_address=str(mac))
@@ -135,7 +140,7 @@ def test_disable_promisc_multicast(self) -> None:
         and sends two packets; one matching source MAC address and one multicast.
         Verifies that the multicast packet is only received once allmulticast mode is enabled.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd = self.disable_promisc_setup(testpmd=testpmd, port_id=0)
             testpmd.set_multicast_all(on=False)
             # 01:00:5E:00:00:01 is the first of the multicast MAC range of addresses
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index f8c7dbfb71..d6bdcfc5f1 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -31,17 +31,18 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Raw

+from api.capabilities import (
+    NicCapability,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
+from api.testpmd.config import PortTopology, SimpleForwardingModes
 from framework.exception import InteractiveCommandExecutionError
-from framework.params.testpmd import PortTopology, SimpleForwardingModes
-from framework.remote_session.testpmd_shell import TestPmdShell
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import NicCapability, requires


 def setup_and_teardown_test(
-    test_meth: Callable[
-        ["TestDynamicQueueConf", int, MutableSet, MutableSet, TestPmdShell, bool], None
-    ],
+    test_meth: Callable[["TestDynamicQueueConf", int, MutableSet, MutableSet, TestPmd, bool], None],
 ) -> Callable[["TestDynamicQueueConf", bool], None]:
     """Decorator that provides a setup and teardown for testing methods.

@@ -83,7 +84,7 @@ def wrap(self: "TestDynamicQueueConf", is_rx_testing: bool) -> None:
         while len(queues_to_config) < self.num_ports_to_modify:
             queues_to_config.add(random.randint(1, self.number_of_queues - 1))
         unchanged_queues = set(range(self.number_of_queues)) - queues_to_config
-        with TestPmdShell(
+        with TestPmd(
             port_topology=PortTopology.chained,
             rx_queues=self.number_of_queues,
             tx_queues=self.number_of_queues,
@@ -117,7 +118,7 @@ def wrap(self: "TestDynamicQueueConf", is_rx_testing: bool) -> None:
     return wrap


-@requires(NicCapability.PHYSICAL_FUNCTION)
+@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 class TestDynamicQueueConf(TestSuite):
     """DPDK dynamic queue configuration test suite.

@@ -197,7 +198,7 @@ def modify_ring_size(
         port_id: int,
         queues_to_modify: MutableSet[int],
         unchanged_queues: MutableSet[int],
-        testpmd: TestPmdShell,
+        testpmd: TestPmd,
         is_rx_testing: bool,
     ) -> None:
         """Verify ring size of port queues can be configured at runtime.
@@ -237,7 +238,7 @@ def stop_queues(
         port_id: int,
         queues_to_modify: MutableSet[int],
         unchanged_queues: MutableSet[int],
-        testpmd: TestPmdShell,
+        testpmd: TestPmd,
         is_rx_testing: bool,
     ) -> None:
         """Verify stopped queues do not handle traffic and do not block traffic on other queues.
@@ -275,25 +276,25 @@ def stop_queues(
                 f"Queue {stopped_q_id} should be stopped but still received traffic.",
             )

-    @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
+    @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
     def test_rx_queue_stop(self):
         """Run method for stopping queues with flag for Rx testing set to :data:`True`."""
         self.stop_queues(True)

-    @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
+    @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
     def test_rx_queue_configuration(self):
         """Run method for configuring queues with flag for Rx testing set to :data:`True`."""
         self.modify_ring_size(True)

-    @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
+    @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
     def test_tx_queue_stop(self):
         """Run method for stopping queues with flag for Rx testing set to :data:`False`."""
         self.stop_queues(False)

-    @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
+    @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
     def test_tx_queue_configuration(self):
         """Run method for configuring queues with flag for Rx testing set to :data:`False`."""
diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hello_world.py
index 6c9ecc1177..dded556d9d 100644
--- a/dts/tests/TestSuite_hello_world.py
+++ b/dts/tests/TestSuite_hello_world.py
@@ -8,7 +8,7 @@
 are properly configured.
 """

-from framework.remote_session.testpmd_shell import TestPmdShell
+from api.testpmd import TestPmd
 from framework.test_suite import BaseConfig, TestSuite, func_test


@@ -33,6 +33,6 @@ def test_hello_world(self) -> None:
         Verify:
             The testpmd session throws no errors.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.start()
         self.log(self.config.msg)
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 5ffa2dcd19..9d56c7d5c9 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -7,18 +7,22 @@
 The forwarding test is performed with several packets being sent at once.
 """

+from api.capabilities import (
+    LinkTopology,
+    NicCapability,
+    requires_link_topology,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
+from api.testpmd.config import EthPeer, SimpleForwardingModes
 from framework.context import filter_cores
-from framework.params.testpmd import EthPeer, SimpleForwardingModes
-from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import requires
 from framework.testbed_model.cpu import LogicalCoreCount
-from framework.testbed_model.topology import TopologyType
 from framework.utils import generate_random_packets


-@requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(topology_type=TopologyType.two_links)
+@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestL2fwd(TestSuite):
     """L2 forwarding test suite."""

@@ -50,7 +54,7 @@ def l2fwd_integrity(self) -> None:
         self.topology.sut_ports[0]
         self.topology.tg_ports[0]

-        with TestPmdShell(
+        with TestPmd(
             forward_mode=SimpleForwardingModes.mac,
             eth_peer=[EthPeer(1, self.topology.tg_port_ingress.mac_address)],
             disable_device_start=True,
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index 2387fdfac2..43f3caba72 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -19,13 +19,16 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Raw

+from api.capabilities import (
+    NicCapability,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
 from framework.exception import InteractiveCommandExecutionError
-from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import requires


-@requires(NicCapability.PHYSICAL_FUNCTION)
+@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 class TestMacFilter(TestSuite):
     """Mac address allowlist filtering test suite.

@@ -102,7 +105,7 @@ def test_add_remove_mac_addresses(self) -> None:
             * Remove the fake mac address from the PMD's address pool.
             * Send a packet with the fake mac address to the PMD. (Should not receive)
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.set_promisc(0, enable=False)
             testpmd.start()
             mac_address = self.topology.sut_port_ingress.mac_address
@@ -138,7 +141,7 @@ def test_invalid_address(self) -> None:
             * Determine the device's mac address pool size, and fill the pool with fake addresses.
             * Attempt to add another fake mac address, overloading the address pool. (Should fail)
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.start()
             mac_address = self.topology.sut_port_ingress.mac_address
             try:
@@ -177,7 +180,7 @@ def test_invalid_address(self) -> None:
             except InteractiveCommandExecutionError:
                 pass

-    @requires(NicCapability.MCAST_FILTERING)
+    @requires_nic_capability(NicCapability.MCAST_FILTERING)
     @func_test
     def test_multicast_filter(self) -> None:
         """Assess basic multicast address filtering functionalities.
@@ -192,7 +195,7 @@ def test_multicast_filter(self) -> None:
             * Remove the fake multicast address from the PMDs multicast address filter.
             * Send a packet with the fake multicast address to the PMD. (Should not receive)
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.start()
             testpmd.set_promisc(0, enable=False)
             multicast_address = "01:00:5E:00:00:00"
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index d5b3fe02af..12617d612d 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -17,9 +17,12 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Raw

-from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
+from api.capabilities import (
+    NicCapability,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import requires

 STANDARD_FRAME = 1518  # --max-pkt-len will subtract l2 information at a minimum of 18 bytes.
 JUMBO_FRAME = 9018
@@ -31,7 +34,7 @@
 VENDOR_AGNOSTIC_PADDING = 9  # Used as a work around for varying MTU definitions between vendors.


-@requires(NicCapability.PHYSICAL_FUNCTION)
+@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 class TestMtu(TestSuite):
     """DPDK PMD jumbo frames and MTU update test suite.

@@ -83,7 +86,7 @@ def send_packet_and_verify(self, pkt_size: int, should_receive: bool) -> None:
         else:
             self.verify(not found, "Received packet.")

-    def assess_mtu_boundary(self, testpmd_shell: TestPmdShell, mtu: int) -> None:
+    def assess_mtu_boundary(self, testpmd_shell: TestPmd, mtu: int) -> None:
         """Sets the new MTU and verifies packets at the set boundary.

         Ensure that packets smaller than or equal to a set MTU will be received and packets larger
@@ -158,7 +161,7 @@ def test_runtime_mtu_updating_and_forwarding(self) -> None:
             * Verify that standard MTU packets forward, in addition to packets within the limits of
               an MTU size set during runtime.
         """
-        with TestPmdShell(tx_offloads=0x8000, mbuf_size=[JUMBO_MTU + 200]) as testpmd:
+        with TestPmd(tx_offloads=0x8000, mbuf_size=[JUMBO_MTU + 200]) as testpmd:
             testpmd.set_port_mtu_all(1500, verify=True)
             testpmd.start()
             self.assess_mtu_boundary(testpmd, 1500)
@@ -198,7 +201,7 @@ def test_cli_mtu_forwarding_for_std_packets(self) -> None:
             * Verify the first two packets are forwarded and the last is dropped after pre-runtime
               MTU modification.
         """
-        with TestPmdShell(
+        with TestPmd(
             tx_offloads=0x8000,
             mbuf_size=[JUMBO_MTU + 200],
             mbcache=200,
@@ -226,7 +229,7 @@ def test_cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:

             * Verify that all packets are forwarded after pre-runtime MTU modification.
         """
-        with TestPmdShell(
+        with TestPmd(
             tx_offloads=0x8000,
             mbuf_size=[JUMBO_MTU + 200],
             mbcache=200,
@@ -254,7 +257,7 @@ def test_cli_mtu_std_packets_for_jumbo_mtu(self) -> None:
             * Verify the first two packets are forwarded and the last is dropped after pre-runtime
               MTU modification.
         """
-        with TestPmdShell(
+        with TestPmd(
             tx_offloads=0x8000,
             mbuf_size=[JUMBO_MTU + 200],
             mbcache=200,
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index bad243a571..ba715e45cf 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -25,16 +25,18 @@
 from scapy.packet import Packet, Raw, raw
 from scapy.utils import rdpcap

+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.testpmd import TestPmd
 from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
-from framework.remote_session.testpmd_shell import TestPmdShell
 from framework.settings import SETTINGS
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import requires
 from framework.testbed_model.cpu import LogicalCoreList
 from framework.testbed_model.os_session import FilePermissions
-from framework.testbed_model.topology import TopologyType
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
 )
@@ -59,7 +61,7 @@ class DumpcapParams(Params):
     packet_filter: str | None = field(default=None, metadata=Params.short("f"))


-@requires(topology_type=TopologyType.two_links)
+@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestPacketCapture(TestSuite):
     """Packet Capture TestSuite.

@@ -164,7 +166,7 @@ def test_dumpcap(self) -> None:
             * The expected packets are the same as the Rx packets.
             * The Tx packets are the same as the packets received from Scapy.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.start()
             received_packets = self._send_and_dump()

@@ -193,7 +195,7 @@ def test_dumpcap_filter(self) -> None:
         Verify:
             * The dumped packets did not contain any of the packets meant for filtering.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.start()
             self._send_and_dump("tcp", rx_only=True)
             filtered_packets = [
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
index 015163dd11..71af302242 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
@@ -22,14 +22,17 @@
 from scapy.packet import Packet, Raw
 from scapy.utils import hexstr

-from framework.params.testpmd import SimpleForwardingModes
-from framework.remote_session.testpmd_shell import TestPmdShell
+from api.capabilities import (
+    NicCapability,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import NicCapability, requires


-@requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(NicCapability.RX_OFFLOAD_SCATTER)
+@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@requires_nic_capability(NicCapability.RX_OFFLOAD_SCATTER)
 class TestPmdBufferScatter(TestSuite):
     """DPDK PMD packet scattering test suite.

@@ -110,7 +113,7 @@ def pmd_scatter(self, mb_size: int, enable_offload: bool = False) -> None:
         Test:
             Start testpmd and run functional test with preset `mb_size`.
         """
-        with TestPmdShell(
+        with TestPmd(
             forward_mode=SimpleForwardingModes.mac,
             mbcache=200,
             mbuf_size=[mb_size],
@@ -129,13 +132,13 @@ def pmd_scatter(self, mb_size: int, enable_offload: bool = False) -> None:
                     f"{offset}.",
                 )

-    @requires(NicCapability.SCATTERED_RX_ENABLED)
+    @requires_nic_capability(NicCapability.SCATTERED_RX_ENABLED)
     @func_test
     def test_scatter_mbuf_2048(self) -> None:
         """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048."""
         self.pmd_scatter(mb_size=2048)

-    @requires(NicCapability.RX_OFFLOAD_SCATTER)
+    @requires_nic_capability(NicCapability.RX_OFFLOAD_SCATTER)
     @func_test
     def test_scatter_mbuf_2048_with_offload(self) -> None:
         """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload."""
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index 58783f1d18..cc1728ba65 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -12,14 +12,19 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Packet, Raw

-from framework.params.testpmd import SimpleForwardingModes
-from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
+from api.capabilities import (
+    LinkTopology,
+    NicCapability,
+    requires_link_topology,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import TopologyType, requires


-@requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(topology_type=TopologyType.two_links)
+@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestPortControl(TestSuite):
     """DPDK Port Control Testing Suite."""

@@ -63,7 +68,7 @@ def test_start_ports(self) -> None:
         Verify:
             Check that all the packets sent are sniffed on the TG receive port.
         """
-        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
+        with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.start_all_ports()
             testpmd.start()
             self.send_packets_and_verify()
@@ -82,7 +87,7 @@ def test_stop_ports(self) -> None:
             Check that stopping the testpmd ports brings down their links
             Check that all the packets sent are sniffed on the TG receive port.
         """
-        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
+        with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.stop_all_ports()
             self.verify(
                 all(not p.is_link_up for p in testpmd.show_port_info_all()),
@@ -101,7 +106,7 @@ def test_close_ports(self) -> None:
         Verify:
             Check that testpmd no longer reports having any ports
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.close_all_ports()
             self.verify(
                 len(testpmd.show_port_info_all()) == 0, "Failed to close all ports in testpmd."
diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts/tests/TestSuite_port_restart_config_persistency.py
index 42ea221586..56ce4c9f27 100644
--- a/dts/tests/TestSuite_port_restart_config_persistency.py
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py
@@ -9,9 +9,13 @@

 from dataclasses import asdict

-from framework.remote_session.testpmd_shell import TestPmdPortFlowCtrl, TestPmdShell
+from api.capabilities import (
+    NicCapability,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
+from api.testpmd.types import TestPmdPortFlowCtrl
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import NicCapability, requires

 ALTERNATIVE_MTU: int = 800
 STANDARD_MTU: int = 1500
@@ -61,7 +65,7 @@ def port_configuration_persistence(self) -> None:
         Verify:
             The configuration persists after the port is restarted.
         """
-        with TestPmdShell(disable_device_start=True) as testpmd:
+        with TestPmd(disable_device_start=True) as testpmd:
             for port_id, _ in enumerate(self.topology.sut_ports):
                 testpmd.set_port_mtu(port_id=port_id, mtu=STANDARD_MTU, verify=True)
                 self.restart_port_and_verify(port_id, testpmd, "MTU")
@@ -80,7 +84,7 @@ def port_configuration_persistence(self) -> None:
                 testpmd.set_promisc(port=port_id, enable=True, verify=True)
                 self.restart_port_and_verify(port_id, testpmd, "promiscuous mode")

-    @requires(NicCapability.FLOW_CTRL)
+    @requires_nic_capability(NicCapability.FLOW_CTRL)
     @func_test
     def flow_ctrl_port_configuration_persistence(self) -> None:
         """Flow control port configuration persistency test.
@@ -90,7 +94,7 @@ def flow_ctrl_port_configuration_persistence(self) -> None:
         Verify:
             The configuration persists after the port is restarted.
         """
-        with TestPmdShell(disable_device_start=True) as testpmd:
+        with TestPmd(disable_device_start=True) as testpmd:
             for port_id, _ in enumerate(self.topology.sut_ports):
                 flow_ctrl = TestPmdPortFlowCtrl(rx=True)
                 testpmd.set_flow_control(port=port_id, flow_ctrl=flow_ctrl)
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_stats.py
index ddd28623b3..f5094ce96c 100644
--- a/dts/tests/TestSuite_port_stats.py
+++ b/dts/tests/TestSuite_port_stats.py
@@ -17,19 +17,20 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Packet, Raw

-from framework.params.testpmd import SimpleForwardingModes
-from framework.remote_session.testpmd_shell import (
+from api.capabilities import (
+    LinkTopology,
     NicCapability,
-    RtePTypes,
-    TestPmdShell,
-    TestPmdVerbosePacket,
+    requires_link_topology,
+    requires_nic_capability,
 )
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
+from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import TopologyType, requires


-@requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(topology_type=TopologyType.two_links)
+@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestPortStats(TestSuite):
     """DPDK Port statistics testing suite.

@@ -137,13 +138,13 @@ def test_stats_updates(self) -> None:
         Verify:
             Parse verbose info from stopping packet forwarding and verify values in port stats.
         """
-        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
+        with TestPmd(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.set_verbose(3)
             testpmd.start()
             testpmd.clear_port_stats_all()
             self.send_packet_and_capture(self.send_pkt)
             port_stats_all, forwarding_info = testpmd.show_port_stats_all()
-            verbose_information = TestPmdShell.extract_verbose_output(forwarding_info)
+            verbose_information = TestPmd.extract_verbose_output(forwarding_info)

         # Gather information from irrelevant packets sent/ received on the same port.
         rx_irr_bytes, rx_irr_pakts, tx_irr_bytes, tx_irr_pakts = self.extract_noise_information(
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_promisc_support.py
index 8a7a7efb57..75ebfc083c 100644
--- a/dts/tests/TestSuite_promisc_support.py
+++ b/dts/tests/TestSuite_promisc_support.py
@@ -11,12 +11,15 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Raw

-from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
+from api.capabilities import (
+    NicCapability,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import requires


-@requires(NicCapability.PHYSICAL_FUNCTION)
+@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 class TestPromiscSupport(TestSuite):
     """Promiscuous mode support test suite."""

@@ -40,7 +43,7 @@ def test_promisc_packets(self) -> None:
         """
         packet = [Ether(dst=self.ALTERNATIVE_MAC_ADDRESS) / IP() / Raw(load=b"\x00" * 64)]

-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             for port_id, _ in enumerate(self.topology.sut_ports):
                 testpmd.set_promisc(port=port_id, enable=True, verify=True)
             testpmd.start()
diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuite_queue_start_stop.py
index d739ddedfe..5eca9926ec 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_start_stop.py
@@ -16,14 +16,20 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Raw

-from framework.remote_session.testpmd_shell import SimpleForwardingModes, TestPmdShell
+from api.capabilities import (
+    LinkTopology,
+    NicCapability,
+    requires_link_topology,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import NicCapability, TopologyType, requires


-@requires(topology_type=TopologyType.two_links)
-@requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
-@requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
+@requires_link_topology(LinkTopology.TWO_LINKS)
+@requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
+@requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
 class TestQueueStartStop(TestSuite):
     """DPDK Queue start/stop test suite.

@@ -63,7 +69,7 @@ def test_rx_queue_start_stop(self) -> None:
             Send a packet on port 0 after Rx queue is stopped, ensure it is not received.
             Send a packet on port 0 after Rx queue is started, ensure it is received.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
             testpmd.stop_port_queue(0, 0, True)
             testpmd.start()
@@ -84,7 +90,7 @@ def test_tx_queue_start_stop(self) -> None:
             Send a packet on port 0 after Tx queue is stopped, ensure it is not received.
             Send a packet on port 0 after Tx queue is started, ensure it is received.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
             testpmd.stop_port_queue(1, 0, False)
             testpmd.start()
@@ -107,7 +113,7 @@ def test_rx_queue_deferred_start(self) -> None:
             Send a packet on port 0 after deferred start is set, ensure it is not received.
             Send a packet on port 0 after Rx queue 0 is started, ensure it is received.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
             testpmd.stop_all_ports()
             testpmd.set_queue_deferred_start(0, 0, True, True)
@@ -132,7 +138,7 @@ def test_tx_queue_deferred_start(self) -> None:
             Send a packet on port 1 after deferred start is set, ensure it is not received.
             Send a packet on port 1 after Tx queue 0 is started, ensure it is received.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
             testpmd.stop_all_ports()
             testpmd.set_queue_deferred_start(1, 0, False, True)
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 4855e4261d..9c46038b97 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -19,13 +19,17 @@
 from scapy.layers.l2 import Dot1Q, Ether
 from scapy.packet import Packet, Raw

+from api.capabilities import (
+    NicCapability,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
+from api.testpmd.types import FlowRule
 from framework.exception import InteractiveCommandExecutionError
-from framework.remote_session.testpmd_shell import FlowRule, TestPmdShell
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import NicCapability, requires


-@requires(NicCapability.FLOW_CTRL)
+@requires_nic_capability(NicCapability.FLOW_CTRL)
 class TestRteFlow(TestSuite):
     """RTE Flow test suite.

@@ -84,7 +88,7 @@ def zip_lists(
                 zip_longest(rules, packets1, packets2 or [], fillvalue=None),
             )

-        with TestPmdShell(rx_queues=4, tx_queues=4) as testpmd:
+        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
             for flow, packet, expected_packet in zip_lists(flows, packets, expected_packets):
                 is_valid = testpmd.flow_validate(flow_rule=flow, port_id=port_id)
                 self.verify_else_skip(is_valid, "flow rule failed validation.")
@@ -125,14 +129,14 @@ def send_packet_and_verify(self, packet: Packet, should_receive: bool = True) ->
         )

     def send_packet_and_verify_queue(
-        self, packet: Packet, test_queue: int, testpmd: TestPmdShell
+        self, packet: Packet, test_queue: int, testpmd: TestPmd
     ) -> None:
         """Send packet and verify queue stats show packet was received.

         Args:
             packet: Scapy packet to send to the SUT.
             test_queue: Represents the queue the test packet is being sent to.
-            testpmd: TestPmdShell instance being used to send test packet.
+            testpmd: TestPmd instance being used to send test packet.
         """
         testpmd.set_verbose(level=8)
         testpmd.start()
@@ -185,7 +189,7 @@ def send_packet_and_verify_jump(
         packets: list[Packet],
         flow_rules: list[FlowRule],
         test_queues: list[int],
-        testpmd: TestPmdShell,
+        testpmd: TestPmd,
     ) -> None:
         """Create a testpmd session with every rule in the given list, verify jump behavior.

@@ -193,7 +197,7 @@ def send_packet_and_verify_jump(
             packets: List of packets to send.
             flow_rules: List of flow rules to create in the same session.
             test_queues: List of Rx queue IDs each packet should be received on.
-            testpmd: TestPmdShell instance to create flows on.
+            testpmd: TestPmd instance to create flows on.
         """
         testpmd.set_verbose(level=8)
         for flow in flow_rules:
@@ -316,7 +320,7 @@ def test_queue_action_IP(self) -> None:
             test_queue=2,
         )

-    @requires(NicCapability.PHYSICAL_FUNCTION)
+    @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
     @func_test
     def test_queue_action_L4(self) -> None:
         """Validate flow rules with queue actions and TCP/UDP patterns.
@@ -433,7 +437,7 @@ def test_drop_action_ETH(self) -> None:
         ]
         # verify reception with test packet
         packet = Ether() / IP() / Raw(load="xxxxx")
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.start()
             received = self.send_packet_and_capture(packet)
             self.verify(received != [], "Test packet was never received.")
@@ -488,7 +492,7 @@ def test_drop_action_IP(self) -> None:
         ]
         # verify reception with test packet
         packet = Ether() / IP() / Raw(load="xxxxx")
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.start()
             received = self.send_packet_and_capture(packet)
             self.verify(received != [], "Test packet was never received.")
@@ -539,7 +543,7 @@ def test_drop_action_L4(self) -> None:
         ]
         # verify reception with test packet
         packet = Ether() / IP() / Raw(load="xxxxx")
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.start()
             received = self.send_packet_and_capture(packet)
             self.verify(received != [], "Test packet was never received.")
@@ -578,7 +582,7 @@ def test_drop_action_VLAN(self) -> None:
         ]
         # verify reception with test packet
         packet = Ether() / IP() / Raw(load="xxxxx")
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.start()
             received = self.send_packet_and_capture(packet)
             self.verify(received != [], "Test packet was never received.")
@@ -668,7 +672,7 @@ def test_egress_rules(self) -> None:
         ]
         # verify reception with test packet
         packet = Ether() / IP() / Raw(load="xxxxx")
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.start()
             received = self.send_packet_and_capture(packet)
             self.verify(received != [], "Test packet was never received.")
@@ -727,7 +731,7 @@ def test_jump_action(self) -> None:
             ),
         ]
         expected_queue_list = [1, 2, 3]
-        with TestPmdShell(rx_queues=4, tx_queues=4) as testpmd:
+        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
             self.send_packet_and_verify_jump(
                 packets=packet_list,
                 flow_rules=flow_list,
@@ -771,7 +775,7 @@ def test_priority_attribute(self) -> None:
             ),
         ]
         expected_queue_list = [1, 2, 3]
-        with TestPmdShell(rx_queues=4, tx_queues=4) as testpmd:
+        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
             testpmd.set_verbose(level=8)
             for flow, expected_queue in zip(flow_list, expected_queue_list):
                 is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 5602b316c0..313136c43e 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -14,16 +14,19 @@

 import re

+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.testpmd import TestPmd
 from framework.config.node import PortConfig
-from framework.remote_session.testpmd_shell import TestPmdShell
 from framework.settings import SETTINGS
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import TopologyType, requires
 from framework.testbed_model.linux_session import LinuxSession
 from framework.utils import REGEX_FOR_PCI_ADDRESS


-@requires(topology_type=TopologyType.no_link)
+@requires_link_topology(LinkTopology.NO_LINK)
 class TestSmokeTests(TestSuite):
     """DPDK and infrastructure smoke test suite.

@@ -104,7 +107,7 @@ def test_devices_listed_in_testpmd(self) -> None:
         Test:
             List all devices found in testpmd and verify the configured devices are among them.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             dev_list = [str(x) for x in testpmd.get_devices()]
         for nic in self.nics_in_node:
             self.verify(
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index 27754c08e7..d690808981 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -8,17 +8,21 @@

 from pathlib import Path, PurePath

-from framework.params.testpmd import EthPeer
-from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
+from api.capabilities import (
+    LinkTopology,
+    NicCapability,
+    requires_link_topology,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
+from api.testpmd.config import EthPeer
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import requires
-from framework.testbed_model.topology import TopologyType
 from framework.testbed_model.virtual_device import VirtualDevice
 from framework.utils import generate_random_packets


-@requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(topology_type=TopologyType.two_links)
+@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestSoftnic(TestSuite):
     """Softnic test suite."""

@@ -106,7 +110,7 @@ def softnic(self) -> None:
             The packets that are received are the same as the packets sent.

         """
-        with TestPmdShell(
+        with TestPmd(
             vdevs=[VirtualDevice(f"net_softnic0,firmware={self.cli_file},cpu_id=1,conn_port=8086")],
             eth_peer=[EthPeer(1, self.topology.tg_port_ingress.mac_address)],
             port_topology=None,
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index 690c5d4fd1..f457a36d15 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -19,18 +19,19 @@
 from scapy.layers.vxlan import VXLAN
 from scapy.packet import Packet, Raw

-from framework.remote_session.testpmd_shell import (
+from api.capabilities import (
+    LinkTopology,
     NicCapability,
-    RtePTypes,
-    SimpleForwardingModes,
-    TestPmdShell,
-    TestPmdVerbosePacket,
+    requires_link_topology,
+    requires_nic_capability,
 )
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
+from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import TopologyType, requires


-@requires(topology_type=TopologyType.two_links)
+@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestUniPkt(TestSuite):
     """DPDK Unified packet test suite.

@@ -51,7 +52,7 @@ def check_for_matching_packet(
         return True

     def send_packet_and_verify_flags(
-        self, expected_flag: RtePTypes, packet: Packet, testpmd: TestPmdShell
+        self, expected_flag: RtePTypes, packet: Packet, testpmd: TestPmd
     ) -> None:
         """Sends a packet to the DUT and verifies the verbose ptype flags."""
         self.send_packet_and_capture(packet=packet)
@@ -60,7 +61,7 @@ def send_packet_and_verify_flags(
         self.verify(valid, f"Packet type flag did not match the expected flag: {expected_flag}.")

     def setup_session(
-        self, testpmd: TestPmdShell, expected_flags: list[RtePTypes], packet_list=list[Packet]
+        self, testpmd: TestPmd, expected_flags: list[RtePTypes], packet_list=list[Packet]
     ) -> None:
         """Sets the forwarding and verbose mode of each test case interactive shell session."""
         testpmd.set_forward_mode(SimpleForwardingModes.rxonly)
@@ -86,7 +87,7 @@ def test_l2_packet_detect(self) -> None:
         dport_id = 50000
         packet_list = [Ether(type=0x88F7) / UDP(dport=dport_id) / Raw(), Ether() / ARP() / Raw()]
         flag_list = [RtePTypes.L2_ETHER_TIMESYNC, RtePTypes.L2_ETHER_ARP]
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @func_test
@@ -119,7 +120,7 @@ def test_l3_l4_packet_detect(self) -> None:
             RtePTypes.L4_ICMP,
             RtePTypes.L4_FRAG | RtePTypes.L3_IPV4_EXT_UNKNOWN | RtePTypes.L2_ETHER,
         ]
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @func_test
@@ -148,7 +149,7 @@ def test_ipv6_l4_packet_detect(self) -> None:
             RtePTypes.L4_TCP,
             RtePTypes.L3_IPV6_EXT_UNKNOWN,
         ]
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @func_test
@@ -183,7 +184,7 @@ def test_l3_tunnel_packet_detect(self) -> None:
             RtePTypes.TUNNEL_IP | RtePTypes.INNER_L4_ICMP,
             RtePTypes.TUNNEL_IP | RtePTypes.INNER_L3_IPV6_EXT_UNKNOWN | RtePTypes.INNER_L4_FRAG,
         ]
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @func_test
@@ -216,7 +217,7 @@ def test_gre_tunnel_packet_detect(self) -> None:
             RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_SCTP,
             RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_ICMP,
         ]
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

     @func_test
@@ -256,10 +257,10 @@ def test_nsh_packet_detect(self) -> None:
             RtePTypes.L2_ETHER_NSH | RtePTypes.L3_IPV4_EXT_UNKNOWN | RtePTypes.L4_SCTP,
             RtePTypes.L2_ETHER_NSH | RtePTypes.L3_IPV6_EXT_UNKNOWN | RtePTypes.L4_NONFRAG,
         ]
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)

-    @requires(NicCapability.PHYSICAL_FUNCTION)
+    @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
     @func_test
     def test_vxlan_tunnel_packet_detect(self) -> None:
         """Ensure the correct flags are shown in the verbose output when sending VXLAN packets.
@@ -293,6 +294,6 @@ def test_vxlan_tunnel_packet_detect(self) -> None:
             RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_ICMP,
             RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L3_IPV6_EXT_UNKNOWN | RtePTypes.INNER_L4_FRAG,
         ]
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.rx_vxlan(4789, 0, True)
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index d2a9e614d4..a80f238955 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -15,13 +15,19 @@
 from scapy.layers.l2 import Dot1Q, Ether
 from scapy.packet import Raw

-from framework.remote_session.testpmd_shell import SimpleForwardingModes, TestPmdShell
+from api.capabilities import (
+    LinkTopology,
+    NicCapability,
+    requires_link_topology,
+    requires_nic_capability,
+)
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import NicCapability, TopologyType, requires


-@requires(NicCapability.RX_OFFLOAD_VLAN_FILTER)
-@requires(topology_type=TopologyType.two_links)
+@requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN_FILTER)
+@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestVlan(TestSuite):
     """DPDK VLAN test suite.

@@ -104,7 +110,7 @@ def send_packet_and_verify_insertion(self, expected_id: int) -> None:
                 "The received tag did not match the expected tag",
             )

-    def vlan_setup(self, testpmd: TestPmdShell, port_id: int, filtered_id: int) -> None:
+    def vlan_setup(self, testpmd: TestPmd, port_id: int, filtered_id: int) -> None:
         """Setup method for all test cases.

         Args:
@@ -124,12 +130,12 @@ def test_vlan_receipt_no_stripping(self) -> None:
         Test:
             Create an interactive testpmd shell and verify a VLAN packet.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
             testpmd.start()
             self.send_vlan_packet_and_verify(True, strip=False, vlan_id=1)

-    @requires(NicCapability.RX_OFFLOAD_VLAN_STRIP)
+    @requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN_STRIP)
     @func_test
     def test_vlan_receipt_stripping(self) -> None:
         """Ensure VLAN packet received with no tag when receipts and header stripping are enabled.
@@ -137,7 +143,7 @@ def test_vlan_receipt_stripping(self) -> None:
         Test:
             Create an interactive testpmd shell and verify a VLAN packet.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
             testpmd.set_vlan_strip(port=0, enable=True)
             testpmd.start()
@@ -150,7 +156,7 @@ def test_vlan_no_receipt(self) -> None:
         Test:
             Create an interactive testpmd shell and verify a VLAN packet.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
             testpmd.start()
             self.send_vlan_packet_and_verify(should_receive=False, strip=False, vlan_id=2)
@@ -162,7 +168,7 @@ def test_vlan_header_insertion(self) -> None:
         Test:
             Create an interactive testpmd shell and verify a non-VLAN packet.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmd() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
             testpmd.set_promisc(port=0, enable=False)
             testpmd.stop_all_ports()
--
2.39.5

