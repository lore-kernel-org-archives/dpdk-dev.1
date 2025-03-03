Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0061BC282CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 14:57:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BD14402E3;
	Mon,  3 Mar 2025 15:57:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E06A8402AE
 for <dev@dpdk.org>; Mon,  3 Mar 2025 15:57:20 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B122113E;
 Mon,  3 Mar 2025 06:57:34 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.64.81])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89A1D3F66E;
 Mon,  3 Mar 2025 06:57:19 -0800 (PST)
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 2/7] dts: amend test suites docstring
Date: Mon,  3 Mar 2025 16:57:04 +0200
Message-ID: <20250303145709.126126-3-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303145709.126126-1-Luca.Vizzarro@arm.com>
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
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

From: Luca Vizzarro <luca.vizzarro@arm.com>

Amend the test suites docstring to conform to valid rst.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/tests/TestSuite_dynamic_config.py |  10 +--
 dts/tests/TestSuite_mac_filter.py     |  42 +++++-----
 dts/tests/TestSuite_mtu.py            | 114 +++++++++++++-------------
 3 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index a4bee2e90b..1fce31a0b5 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -36,13 +36,13 @@ class TestDynamicConfig(TestSuite):
 
     1. Default mode: verify packets are received and forwarded.
     2. Disable promiscuous mode: verify that packets are received
-    only for the packet with destination address matching the port address.
+       only for the packet with destination address matching the port address.
     3. Disable promiscuous mode broadcast: verify that packets with destination
-    MAC address not matching the port are received and not forwarded, and verify
-    that broadcast packets are received and forwarded.
+       MAC address not matching the port are received and not forwarded, and verify
+       that broadcast packets are received and forwarded.
     4. Disable promiscuous mode multicast: verify that packets with destination
-    MAC address not matching the port are received and not forwarded, and verify
-    that multicast packets are received and forwarded.
+       MAC address not matching the port are received and not forwarded, and verify
+       that multicast packets are received and forwarded.
     """
 
     def send_packet_and_verify(self, should_receive: bool, mac_address: str) -> None:
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index e6c55d3ec6..9dbfec5da2 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -93,13 +93,13 @@ def test_add_remove_mac_addresses(self) -> None:
         the properties applied to the PMD at any given time.
 
         Test:
-            Start TestPMD without promiscuous mode.
-            Send a packet with the port's default mac address. (Should receive)
-            Send a packet with fake mac address. (Should not receive)
-            Add fake mac address to the PMD's address pool.
-            Send a packet with the fake mac address to the PMD. (Should receive)
-            Remove the fake mac address from the PMD's address pool.
-            Send a packet with the fake mac address to the PMD. (Should not receive)
+            * Start TestPMD without promiscuous mode.
+            * Send a packet with the port's default mac address. (Should receive)
+            * Send a packet with fake mac address. (Should not receive)
+            * Add fake mac address to the PMD's address pool.
+            * Send a packet with the fake mac address to the PMD. (Should receive)
+            * Remove the fake mac address from the PMD's address pool.
+            * Send a packet with the fake mac address to the PMD. (Should not receive)
         """
         with TestPmdShell() as testpmd:
             testpmd.set_promisc(0, enable=False)
@@ -127,15 +127,15 @@ def test_invalid_address(self) -> None:
         built-in hardware address, or exceed their address pools.
 
         Test:
-            Start TestPMD.
-            Attempt to add an invalid mac address. (Should fail)
-            Attempt to remove the device's hardware address with no additional addresses in the
-                address pool. (Should fail)
-            Add a fake mac address to the pool twice in succession. (Should not create any errors)
-            Attempt to remove the device's hardware address with other addresses in the address
-                pool. (Should fail)
-            Determine the device's mac address pool size, and fill the pool with fake addresses.
-            Attempt to add another fake mac address, overloading the address pool. (Should fail)
+            * Start TestPMD.
+            * Attempt to add an invalid mac address. (Should fail)
+            * Attempt to remove the device's hardware address with no additional addresses in the
+              address pool. (Should fail)
+            * Add a fake mac address to the pool twice in succession. (Should not create any errors)
+            * Attempt to remove the device's hardware address with other addresses in the address
+              pool. (Should fail)
+            * Determine the device's mac address pool size, and fill the pool with fake addresses.
+            * Attempt to add another fake mac address, overloading the address pool. (Should fail)
         """
         with TestPmdShell() as testpmd:
             testpmd.start()
@@ -185,11 +185,11 @@ def test_multicast_filter(self) -> None:
         to the PMD.
 
         Test:
-            Start TestPMD without promiscuous mode.
-            Add a fake multicast address to the PMD's multicast address pool.
-            Send a packet with the fake multicast address to the PMD. (Should receive)
-            Remove the fake multicast address from the PMDs multicast address filter.
-            Send a packet with the fake multicast address to the PMD. (Should not receive)
+            * Start TestPMD without promiscuous mode.
+            * Add a fake multicast address to the PMD's multicast address pool.
+            * Send a packet with the fake multicast address to the PMD. (Should receive)
+            * Remove the fake multicast address from the PMDs multicast address filter.
+            * Send a packet with the fake multicast address to the PMD. (Should not receive)
         """
         with TestPmdShell() as testpmd:
             testpmd.start()
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index 63e570ba03..af6ab88501 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -48,8 +48,7 @@ def set_up_suite(self) -> None:
         """Set up the test suite.
 
         Setup:
-            Set traffic generator MTU lengths to a size greater than scope of all
-            test cases.
+            Set traffic generator MTU lengths to a size greater than scope of all test cases.
         """
         self.topology.tg_port_egress.configure_mtu(JUMBO_MTU + 200)
         self.topology.tg_port_ingress.configure_mtu(JUMBO_MTU + 200)
@@ -89,12 +88,13 @@ def assess_mtu_boundary(self, testpmd_shell: TestPmdShell, mtu: int) -> None:
         will not.
 
         First, start testpmd and update the MTU. Then ensure the new value appears
-        on port info for all ports.
-        Next, start packet capturing and send 3 different lengths of packet and verify
-        they are handled correctly.
-            # 1. VENDOR_AGNOSTIC_PADDING units smaller than the MTU specified.
-            # 2. Equal to the MTU specified.
-            # 3. VENDOR_AGNOSTIC_PADDING units larger than the MTU specified (should be fragmented).
+        on port info for all ports. Next, start packet capturing and send 3 different lengths of
+        packet and verify they are handled correctly:
+
+        1. VENDOR_AGNOSTIC_PADDING units smaller than the MTU specified.
+        2. Equal to the MTU specified.
+        3. VENDOR_AGNOSTIC_PADDING units larger than the MTU specified (should be fragmented).
+
         Finally, stop packet capturing.
 
         Args:
@@ -126,35 +126,35 @@ def test_runtime_mtu_updating_and_forwarding(self) -> None:
         """Verify runtime MTU adjustments and assess packet forwarding behavior.
 
         Test:
-            Start TestPMD in a paired topology.
-            Set port MTU to 1500.
-            Send packets of 1491, 1500 and 1509 bytes.
-                Verify the first two packets are forwarded and the last is dropped.
-
-            Set port MTU to 2400.
-            Send packets of 1491, 1500 and 1509 bytes.
-                Verify all three packets are forwarded.
-            Send packets of 2391, 2400 and 2409 bytes.
-                Verify the first two packets are forwarded and the last is dropped.
-
-            Set port MTU to 4800.
-            Send packets of 1491, 1500 and 1509 bytes.
-                Verify all three packets are forwarded.
-            Send packets of 4791, 4800 and 4809 bytes.
-                Verify the first two packets are forwarded and the last is dropped.
-
-            Set port MTU to 9000.
-            Send packets of 1491, 1500 and 1509 bytes.
-                Verify all three packets are forwarded.
-            Send packets of 8991, 9000 and 9009 bytes.
-                Verify the first two packets are forwarded and the last is dropped.
+            * Start TestPMD in a paired topology.
+            * Set port MTU to 1500.
+            * Send packets of 1491, 1500 and 1509 bytes.
+                * Verify the first two packets are forwarded and the last is dropped.
+
+            * Set port MTU to 2400.
+            * Send packets of 1491, 1500 and 1509 bytes.
+                * Verify all three packets are forwarded.
+            * Send packets of 2391, 2400 and 2409 bytes.
+                * Verify the first two packets are forwarded and the last is dropped.
+
+            * Set port MTU to 4800.
+            * Send packets of 1491, 1500 and 1509 bytes.
+                * Verify all three packets are forwarded.
+            * Send packets of 4791, 4800 and 4809 bytes.
+                * Verify the first two packets are forwarded and the last is dropped.
+
+            * Set port MTU to 9000.
+            * Send packets of 1491, 1500 and 1509 bytes.
+                * Verify all three packets are forwarded.
+            * Send packets of 8991, 9000 and 9009 bytes.
+                * Verify the first two packets are forwarded and the last is dropped.
         Verify:
-            Verifies the successful forwarding of packets via a search for an inserted payload.
-            If the payload is found, the packet was transmitted successfully. Otherwise, the packet
-            is considered dropped.
+            * Verifies the successful forwarding of packets via a search for an inserted payload.
+              If the payload is found, the packet was transmitted successfully. Otherwise, the
+              packet is considered dropped.
 
-            Verify that standard MTU packets forward, in addition to packets within the limits of
-            an MTU size set during runtime.
+            * Verify that standard MTU packets forward, in addition to packets within the limits of
+              an MTU size set during runtime.
         """
         with TestPmdShell(tx_offloads=0x8000, mbuf_size=[JUMBO_MTU + 200]) as testpmd:
             testpmd.set_port_mtu_all(1500, verify=True)
@@ -185,16 +185,16 @@ def test_cli_mtu_forwarding_for_std_packets(self) -> None:
         """Assesses packet forwarding of standard MTU packets after pre-runtime MTU adjustments.
 
         Test:
-            Start TestPMD with MTU size of 1518 bytes, set pre-runtime.
-            Send packets of size 1491, 1500 and 1509 bytes.
-            Verify the first two packets are forwarded and the last is dropped.
+            * Start TestPMD with MTU size of 1518 bytes, set pre-runtime.
+            * Send packets of size 1491, 1500 and 1509 bytes.
+            * Verify the first two packets are forwarded and the last is dropped.
         Verify:
-            Verifies the successful forwarding of packets via a search for an inserted payload.
-            If the payload is found, the packet was transmitted successfully. Otherwise, the packet
-            is considered dropped.
+            * Verifies the successful forwarding of packets via a search for an inserted payload.
+              If the payload is found, the packet was transmitted successfully. Otherwise, the
+              packet is considered dropped.
 
-            Verify the first two packets are forwarded and the last is dropped after pre-runtime
-            MTU modification.
+            * Verify the first two packets are forwarded and the last is dropped after pre-runtime
+              MTU modification.
         """
         with TestPmdShell(
             tx_offloads=0x8000,
@@ -215,14 +215,14 @@ def test_cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:
         """Assess packet forwarding of packets within the bounds of a pre-runtime MTU adjustment.
 
         Test:
-            Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
-            Send packets of size 8991, 9000 and 1509 bytes.
+            * Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
+            * Send packets of size 8991, 9000 and 1509 bytes.
         Verify:
-            Verifies the successful forwarding of packets via a search for an inserted payload.
-            If the payload is found, the packet was transmitted successfully. Otherwise, the packet
-            is considered dropped.
+            * Verifies the successful forwarding of packets via a search for an inserted payload.
+              If the payload is found, the packet was transmitted successfully. Otherwise, the
+              packet is considered dropped.
 
-            Verify that all packets are forwarded after pre-runtime MTU modification.
+            * Verify that all packets are forwarded after pre-runtime MTU modification.
         """
         with TestPmdShell(
             tx_offloads=0x8000,
@@ -241,16 +241,16 @@ def test_cli_mtu_std_packets_for_jumbo_mtu(self) -> None:
         """Assess boundary of jumbo MTU value set pre-runtime.
 
         Test:
-            Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
-            Send a packets of size 8991, 9000 and 9009 bytes.
-            Verify the first two packets are forwarded and the last is dropped.
+            * Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
+            * Send a packets of size 8991, 9000 and 9009 bytes.
+            * Verify the first two packets are forwarded and the last is dropped.
         Verify:
-            Verifies the successful forwarding of packets via a search for an inserted payload.
-            If the payload is found, the packet was transmitted successfully. Otherwise, the packet
-            is considered dropped.
+            * Verifies the successful forwarding of packets via a search for an inserted payload.
+              If the payload is found, the packet was transmitted successfully. Otherwise, the
+              packet is considered dropped.
 
-            Verify the first two packets are forwarded and the last is dropped after pre-runtime
-            MTU modification.
+            * Verify the first two packets are forwarded and the last is dropped after pre-runtime
+              MTU modification.
         """
         with TestPmdShell(
             tx_offloads=0x8000,
-- 
2.43.0

