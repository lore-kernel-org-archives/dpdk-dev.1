Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7A4C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:20:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4808040658;
	Tue, 22 Jul 2025 19:20:03 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 107BC40647
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:20:02 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4aaaf1a63c1so44190421cf.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753204801; x=1753809601; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4S5BO5+orc+jeZWnyl50e3dBARiX/B96GJQo0c3NQA=;
 b=H0in0djTW3HuQnuFUXSqkXezArC2bxToAYoof0yNy/hgddJSK4JNG2d5cjTAsDHZU4
 f+z9wxDezFVz20wyuSHJgvD25fqQrflUrm3aS+bMa6Ig9Al2KSwq1rD0EyvMdV3ksjGo
 SGoCCgmTo3gSdMGkzr2GElzT4ow++vgE6BxI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753204801; x=1753809601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4S5BO5+orc+jeZWnyl50e3dBARiX/B96GJQo0c3NQA=;
 b=VHaAyvz0UtD+WJmIUgrQB+GRoNDw2AdAp2O+jFCUmSyPBLm5VLdzMWjgsczFnX1wLa
 j7gAS4SwYbVcY2fvDPzz30OmVW/FyYVLhV+s/lcXuoJYkNpeKG6sWGvaKzOxsAWUShOy
 4ejDgE50UPynevegTj+VeEFxNapnqXKcoTnXrw6gSI2/GIJ4xptHy4MC2dTf1XhN7RqY
 VXAi5jCwMAYJhnBnKn9nmjQgK9SV3pYsY02HHEuFMBaby+ML6ljSRHffAG3vH2hcGgSV
 SFKbS7yNbIaXs2nQWGtB0sWZIDYn7uVSODbFiqRpnrpxYXtJjHzmdtzbyXzTArgHoyq3
 Yx3A==
X-Gm-Message-State: AOJu0YyHj+HsZ4Bxr+wDJFP78Txd0HTucsxVws31J+hUOvNenpm17c/a
 QpgRbO7b9w9IVYZiQ/bpEsKMz8tUBgVk0Pa0LFKg5fXpLFKArPLIbZMnyFV4PUyTj9Q=
X-Gm-Gg: ASbGnct2QDWfTEO3zek17iV4uj1I6nN6Zh+JayN9JrcQ+j7iuzQ1Wr4miBwx3YafHbM
 Ny+Go4Lu/M58HvJluXOytU28inuZYQqwEREJGMUtPRxBcLN3opXcoxvDHi3E+ajNX9QridqEm0t
 gcRb2yrn0pD3YQdEPOvz5pHiisGP5OJulZMS1ck/IAqpXN8Xz2N2idrZnl5tDNNjJ/lnZ6GS/le
 9KAQ3buLeGfEhiBOpFEgx2DnQSWn1YBqUJ8bgw6gdhBsNF1VdgdL7AjcuKFOzSf6pU/x1Irv/O2
 1yV2ZV+GuxUmcgyJrZW46FPClBTI45PanpgfxYmsMGc9biQm7mNdn7guCqh7e1EIGS+683jA+y6
 p9Jpw+OMsYsP1+P8wTN6OQQDC605t1YFY7DsnY4pCeoKRMgjBUhXb
X-Google-Smtp-Source: AGHT+IH9DviWOiscwkcZ94GBzaglKCrB/GhTcMPfAUq7ldTkyOxw+iEmtQjoEsGuttolZ+DxdC7yWA==
X-Received: by 2002:a05:622a:1cc8:b0:4ab:38c1:f9a9 with SMTP id
 d75a77b69052e-4ab93c87542mr381683901cf.19.1753204800855; 
 Tue, 22 Jul 2025 10:20:00 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb4981ec5sm55175521cf.11.2025.07.22.10.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:20:00 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 2/2] dts: add steps and verify sections to docstrings
Date: Tue, 22 Jul 2025 13:19:57 -0400
Message-ID: <20250722171957.200698-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722171957.200698-1-dmarx@iol.unh.edu>
References: <20250722171957.200698-1-dmarx@iol.unh.edu>
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

The standard for test case docstrings in DTS requires each
case to have a Steps and Verify section to outline
each respective step of the test. Add these sections
to existing suites that are not formatted this way.

Bugzilla ID: 1599

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_dynamic_config.py     | 46 +++++++++----
 dts/tests/TestSuite_dynamic_queue_conf.py | 36 ++++++++--
 dts/tests/TestSuite_mac_filter.py         | 65 +++++++++++-------
 dts/tests/TestSuite_mtu.py                | 84 +++++++++++------------
 dts/tests/TestSuite_packet_capture.py     | 18 ++---
 dts/tests/TestSuite_pmd_buffer_scatter.py | 18 ++++-
 dts/tests/TestSuite_smoke_tests.py        | 25 +++++--
 dts/tests/TestSuite_vlan.py               | 41 ++++++++---
 8 files changed, 223 insertions(+), 110 deletions(-)

diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 49f295a39a..bd07953ff9 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -85,27 +85,34 @@ def disable_promisc_setup(self, testpmd: TestPmdShell, port_id: int) -> TestPmdS
     def test_default_mode(self) -> None:
         """Tests default configuration.
 
-        Creates a testpmd shell, verifies that promiscuous mode is enabled by default,
-        and sends two packets; one matching source MAC address and one unknown.
-        Verifies that both are received.
+        Steps:
+            Launch testpmd.
+            Send a packet with Rx port mac address.
+            Send a packet with mismatched mac address.
+
+        Verify:
+            Both packets are received.
         """
         with TestPmdShell() as testpmd:
             is_promisc = testpmd.show_port_info(0).is_promiscuous_mode_enabled
             self.verify(is_promisc, "Promiscuous mode was not enabled by default.")
             testpmd.start()
             mac = testpmd.show_port_info(0).mac_address
-            # send a packet with Rx port mac address
             self.send_packet_and_verify(should_receive=True, mac_address=str(mac))
-            # send a packet with mismatched mac address
             self.send_packet_and_verify(should_receive=True, mac_address="00:00:00:00:00:01")
 
     @func_test
     def test_disable_promisc(self) -> None:
         """Tests disabled promiscuous mode configuration.
 
-        Creates an interactive testpmd shell, disables promiscuous mode,
-        and sends two packets; one matching source MAC address and one unknown.
-        Verifies that only the matching address packet is received.
+        Steps:
+            Launch testpmd and enable promiscuous mode.
+            Send a packet with Rx port mac address.
+            Send a packet with mismatched mac address.
+
+        Verify:
+            Rx port mac address packet is received.
+            Mismatched mac address packet is dropped.
         """
         with TestPmdShell() as testpmd:
             testpmd = self.disable_promisc_setup(testpmd=testpmd, port_id=0)
@@ -117,9 +124,13 @@ def test_disable_promisc(self) -> None:
     def test_disable_promisc_broadcast(self) -> None:
         """Tests broadcast reception with disabled promisc mode config.
 
-        Creates an interactive testpmd shell, disables promiscuous mode,
-        and sends two packets; one matching source MAC address and one broadcast.
-        Verifies that both packets are received.
+        Steps:
+            Launch testpmd and disable promiscuous mode.
+            Send a packet with Rx port mac address.
+            Send a packet with broadcast mac address.
+
+        Verify:
+            Both packets are received.
         """
         with TestPmdShell() as testpmd:
             testpmd = self.disable_promisc_setup(testpmd=testpmd, port_id=0)
@@ -131,9 +142,16 @@ def test_disable_promisc_broadcast(self) -> None:
     def test_disable_promisc_multicast(self) -> None:
         """Tests allmulticast mode with disabled promisc config.
 
-        Creates an interactive testpmd shell, disables promiscuous mode,
-        and sends two packets; one matching source MAC address and one multicast.
-        Verifies that the multicast packet is only received once allmulticast mode is enabled.
+        Steps:
+            Launch testpmd and disable promiscuous mode.
+            Disable multicast mode on all ports.
+            Send a packet with a multicast mac address.
+            Enable multicast mode on all ports.
+            Send another packet with a multicast mac address.
+
+        Verify:
+            First multicast packet is dropped.
+            Second multicast packet is received.
         """
         with TestPmdShell() as testpmd:
             testpmd = self.disable_promisc_setup(testpmd=testpmd, port_id=0)
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index f8c7dbfb71..4ea2097051 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -278,23 +278,51 @@ def stop_queues(
     @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
     def test_rx_queue_stop(self):
-        """Run method for stopping queues with flag for Rx testing set to :data:`True`."""
+        """Rx queue stop test.
+
+        Steps:
+            Run method for stopping queues with flag for Rx testing set to :data:`True`.
+
+        Verify:
+            Stopped Rx queues do not receive traffic.
+        """
         self.stop_queues(True)
 
     @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
     def test_rx_queue_configuration(self):
-        """Run method for configuring queues with flag for Rx testing set to :data:`True`."""
+        """Rx queue configuration test.
+
+        Steps:
+            Run method for configuring queues with flag for Rx testing set to :data:`True`.
+
+        Verify:
+            Rx queue ring size is correctly modified during runtime.
+        """
         self.modify_ring_size(True)
 
     @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
     def test_tx_queue_stop(self):
-        """Run method for stopping queues with flag for Rx testing set to :data:`False`."""
+        """Tx queue stop test.
+
+        Steps:
+            Run method for stopping queues with flag for Rx testing set to :data:`False`.
+
+        Verify:
+            Stopped Tx queues do not receive traffic.
+        """
         self.stop_queues(False)
 
     @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
     def test_tx_queue_configuration(self):
-        """Run method for configuring queues with flag for Rx testing set to :data:`False`."""
+        """Tx queue configuration test.
+
+        Steps:
+            Run method for configuring queues with flag for Rx testing set to :data:`False`.
+
+        Verify:
+            Tx queue ring size is correctly modified during runtime.
+        """
         self.modify_ring_size(False)
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index 2387fdfac2..ec7d7f292d 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -93,14 +93,20 @@ def test_add_remove_mac_addresses(self) -> None:
         added to the PMD. Packets should either be received or not received depending on
         the properties applied to the PMD at any given time.
 
-        Test:
-            * Start TestPMD without promiscuous mode.
-            * Send a packet with the port's default mac address. (Should receive)
-            * Send a packet with fake mac address. (Should not receive)
-            * Add fake mac address to the PMD's address pool.
-            * Send a packet with the fake mac address to the PMD. (Should receive)
-            * Remove the fake mac address from the PMD's address pool.
-            * Send a packet with the fake mac address to the PMD. (Should not receive)
+        Steps:
+            Start TestPMD without promiscuous mode.
+            Send a packet with the port's default mac address.
+            Send a packet with fake mac address.
+            Add fake mac address to the PMD's address pool.
+            Send a packet with the fake mac address to the PMD.
+            Remove the fake mac address from the PMD's address pool.
+            Send a packet with the fake mac address to the PMD.
+
+        Verify:
+            Sent packet with default mac address is received.
+            Sent packet with fake mac address is dropped.
+            Second sent packet with fake mac address is received.
+            Third sent packet with fake mac address is dropped.
         """
         with TestPmdShell() as testpmd:
             testpmd.set_promisc(0, enable=False)
@@ -127,16 +133,23 @@ def test_invalid_address(self) -> None:
         and address pooling. Devices should not be able to use invalid mac addresses, remove their
         built-in hardware address, or exceed their address pools.
 
-        Test:
-            * Start TestPMD.
-            * Attempt to add an invalid mac address. (Should fail)
-            * Attempt to remove the device's hardware address with no additional addresses in the
-              address pool. (Should fail)
-            * Add a fake mac address to the pool twice in succession. (Should not create any errors)
-            * Attempt to remove the device's hardware address with other addresses in the address
-              pool. (Should fail)
-            * Determine the device's mac address pool size, and fill the pool with fake addresses.
-            * Attempt to add another fake mac address, overloading the address pool. (Should fail)
+        Steps:
+            Start TestPMD.
+            Attempt to add an invalid mac address.
+            Attempt to remove the device's hardware address with no additional addresses in the
+              address pool.
+            Add a fake mac address to the pool twice in succession.
+            Attempt to remove the device's hardware address with other addresses in the address
+              pool.
+            Determine the device's mac address pool size, and fill the pool with fake addresses.
+            Attempt to add another fake mac address, overloading the address pool.
+
+        Verify:
+            Invalid mac address addition fails.
+            Hardware address removal with no additional address fails.
+            Fake mac address additions does not create any errors.
+            Hardware address removal with other addresses in pool fails.
+            Overloading the address pool with another fake mac address fails.
         """
         with TestPmdShell() as testpmd:
             testpmd.start()
@@ -185,12 +198,16 @@ def test_multicast_filter(self) -> None:
         Ensure that multicast filtering performs as intended when a given device is bound
         to the PMD.
 
-        Test:
-            * Start TestPMD without promiscuous mode.
-            * Add a fake multicast address to the PMD's multicast address pool.
-            * Send a packet with the fake multicast address to the PMD. (Should receive)
-            * Remove the fake multicast address from the PMDs multicast address filter.
-            * Send a packet with the fake multicast address to the PMD. (Should not receive)
+        Steps:
+            Start TestPMD without promiscuous mode.
+            Add a fake multicast address to the PMD's multicast address pool.
+            Send a packet with the fake multicast address to the PMD. (Should receive)
+            Remove the fake multicast address from the PMDs multicast address filter.
+            Send a packet with the fake multicast address to the PMD. (Should not receive)
+
+        Verify:
+            Sent packet with fake multicast address is received.
+            Second sent packet with fake multicast address is dropped.
         """
         with TestPmdShell() as testpmd:
             testpmd.start()
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index d5b3fe02af..d095d40366 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -127,35 +127,35 @@ def assess_mtu_boundary(self, testpmd_shell: TestPmdShell, mtu: int) -> None:
     def test_runtime_mtu_updating_and_forwarding(self) -> None:
         """Verify runtime MTU adjustments and assess packet forwarding behavior.
 
-        Test:
-            * Start TestPMD in a paired topology.
-            * Set port MTU to 1500.
-            * Send packets of 1491, 1500 and 1509 bytes.
-                * Verify the first two packets are forwarded and the last is dropped.
-
-            * Set port MTU to 2400.
-            * Send packets of 1491, 1500 and 1509 bytes.
-                * Verify all three packets are forwarded.
-            * Send packets of 2391, 2400 and 2409 bytes.
-                * Verify the first two packets are forwarded and the last is dropped.
-
-            * Set port MTU to 4800.
-            * Send packets of 1491, 1500 and 1509 bytes.
-                * Verify all three packets are forwarded.
-            * Send packets of 4791, 4800 and 4809 bytes.
-                * Verify the first two packets are forwarded and the last is dropped.
-
-            * Set port MTU to 9000.
-            * Send packets of 1491, 1500 and 1509 bytes.
-                * Verify all three packets are forwarded.
-            * Send packets of 8991, 9000 and 9009 bytes.
-                * Verify the first two packets are forwarded and the last is dropped.
+        Steps:
+            Start TestPMD in a paired topology.
+            Set port MTU to 1500.
+            Send packets of 1491, 1500 and 1509 bytes.
+                Verify the first two packets are forwarded and the last is dropped.
+
+            Set port MTU to 2400.
+            Send packets of 1491, 1500 and 1509 bytes.
+                Verify all three packets are forwarded.
+            Send packets of 2391, 2400 and 2409 bytes.
+                Verify the first two packets are forwarded and the last is dropped.
+
+            Set port MTU to 4800.
+            Send packets of 1491, 1500 and 1509 bytes.
+                Verify all three packets are forwarded.
+            Send packets of 4791, 4800 and 4809 bytes.
+                Verify the first two packets are forwarded and the last is dropped.
+
+            Set port MTU to 9000.
+            Send packets of 1491, 1500 and 1509 bytes.
+                Verify all three packets are forwarded.
+            Send packets of 8991, 9000 and 9009 bytes.
+                Verify the first two packets are forwarded and the last is dropped.
         Verify:
-            * Verifies the successful forwarding of packets via a search for an inserted payload.
+            Verifies the successful forwarding of packets via a search for an inserted payload.
               If the payload is found, the packet was transmitted successfully. Otherwise, the
               packet is considered dropped.
 
-            * Verify that standard MTU packets forward, in addition to packets within the limits of
+            Verify that standard MTU packets forward, in addition to packets within the limits of
               an MTU size set during runtime.
         """
         with TestPmdShell(tx_offloads=0x8000, mbuf_size=[JUMBO_MTU + 200]) as testpmd:
@@ -186,16 +186,16 @@ def test_runtime_mtu_updating_and_forwarding(self) -> None:
     def test_cli_mtu_forwarding_for_std_packets(self) -> None:
         """Assesses packet forwarding of standard MTU packets after pre-runtime MTU adjustments.
 
-        Test:
-            * Start TestPMD with MTU size of 1518 bytes, set pre-runtime.
-            * Send packets of size 1491, 1500 and 1509 bytes.
-            * Verify the first two packets are forwarded and the last is dropped.
+        Steps:
+            Start TestPMD with MTU size of 1518 bytes, set pre-runtime.
+            Send packets of size 1491, 1500 and 1509 bytes.
+            Verify the first two packets are forwarded and the last is dropped.
         Verify:
-            * Verifies the successful forwarding of packets via a search for an inserted payload.
+            Verifies the successful forwarding of packets via a search for an inserted payload.
               If the payload is found, the packet was transmitted successfully. Otherwise, the
               packet is considered dropped.
 
-            * Verify the first two packets are forwarded and the last is dropped after pre-runtime
+            Verify the first two packets are forwarded and the last is dropped after pre-runtime
               MTU modification.
         """
         with TestPmdShell(
@@ -216,15 +216,15 @@ def test_cli_mtu_forwarding_for_std_packets(self) -> None:
     def test_cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:
         """Assess packet forwarding of packets within the bounds of a pre-runtime MTU adjustment.
 
-        Test:
-            * Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
-            * Send packets of size 8991, 9000 and 1509 bytes.
+        Steps:
+            Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
+            Send packets of size 8991, 9000 and 1509 bytes.
         Verify:
-            * Verifies the successful forwarding of packets via a search for an inserted payload.
+            Verifies the successful forwarding of packets via a search for an inserted payload.
               If the payload is found, the packet was transmitted successfully. Otherwise, the
               packet is considered dropped.
 
-            * Verify that all packets are forwarded after pre-runtime MTU modification.
+            Verify that all packets are forwarded after pre-runtime MTU modification.
         """
         with TestPmdShell(
             tx_offloads=0x8000,
@@ -242,16 +242,16 @@ def test_cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:
     def test_cli_mtu_std_packets_for_jumbo_mtu(self) -> None:
         """Assess boundary of jumbo MTU value set pre-runtime.
 
-        Test:
-            * Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
-            * Send a packets of size 8991, 9000 and 9009 bytes.
-            * Verify the first two packets are forwarded and the last is dropped.
+        Steps:
+            Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
+            Send a packets of size 8991, 9000 and 9009 bytes.
+            Verify the first two packets are forwarded and the last is dropped.
         Verify:
-            * Verifies the successful forwarding of packets via a search for an inserted payload.
+            Verifies the successful forwarding of packets via a search for an inserted payload.
               If the payload is found, the packet was transmitted successfully. Otherwise, the
               packet is considered dropped.
 
-            * Verify the first two packets are forwarded and the last is dropped after pre-runtime
+            Verify the first two packets are forwarded and the last is dropped after pre-runtime
               MTU modification.
         """
         with TestPmdShell(
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index bad243a571..4232c01386 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -156,13 +156,13 @@ def test_dumpcap(self) -> None:
         """Test dumpcap on Rx and Tx interfaces.
 
         Steps:
-            * Start up testpmd shell.
-            * Start up dpdk-dumpcap with the default values.
-            * Send packets.
+            Start up testpmd shell.
+            Start up dpdk-dumpcap with the default values.
+            Send packets.
 
         Verify:
-            * The expected packets are the same as the Rx packets.
-            * The Tx packets are the same as the packets received from Scapy.
+            The expected packets are the same as the Rx packets.
+            The Tx packets are the same as the packets received from Scapy.
         """
         with TestPmdShell() as testpmd:
             testpmd.start()
@@ -186,12 +186,12 @@ def test_dumpcap_filter(self) -> None:
         """Test the dumpcap filtering feature.
 
         Steps:
-            * Start up testpmd shell.
-            * Start up dpdk-dumpcap listening for TCP packets on the Rx interface.
-            * Send packets.
+            Start up testpmd shell.
+            Start up dpdk-dumpcap listening for TCP packets on the Rx interface.
+            Send packets.
 
         Verify:
-            * The dumped packets did not contain any of the packets meant for filtering.
+            The dumped packets did not contain any of the packets meant for filtering.
         """
         with TestPmdShell() as testpmd:
             testpmd.start()
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
index 015163dd11..f0cc924b0e 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
@@ -132,13 +132,27 @@ def pmd_scatter(self, mb_size: int, enable_offload: bool = False) -> None:
     @requires(NicCapability.SCATTERED_RX_ENABLED)
     @func_test
     def test_scatter_mbuf_2048(self) -> None:
-        """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048."""
+        """Scatter mbuf test.
+
+        Steps:
+            Run the :meth:`pmd_scatter` test with `mb_size` set to 2048.
+
+        Verify:
+            Payload of scattered packet matches expected payload.
+        """
         self.pmd_scatter(mb_size=2048)
 
     @requires(NicCapability.RX_OFFLOAD_SCATTER)
     @func_test
     def test_scatter_mbuf_2048_with_offload(self) -> None:
-        """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload."""
+        """Scatter mbuf test with rx_scatter offloaded.
+
+        Steps:
+            Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload.
+
+        Verify:
+            Payload of scattered packet matches expected payload.
+        """
         self.pmd_scatter(mb_size=2048, enable_offload=True)
 
     def tear_down_suite(self) -> None:
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 5602b316c0..7d0f5198af 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -56,8 +56,11 @@ def test_unit_tests(self) -> None:
         Test that all unit test from the ``fast-tests`` suite pass.
         The suite is a subset with only the most basic tests.
 
-        Test:
+        Steps:
             Run the ``fast-tests`` unit test suite through meson.
+
+        Verify:
+            All unit tests from ``fast-tests`` suite pass.
         """
         self.sut_node.main_session.send_command(
             f"meson test -C {self.dpdk_build_dir_path} --suite fast-tests -t 120",
@@ -74,8 +77,11 @@ def test_driver_tests(self) -> None:
         The suite is a subset with driver tests. This suite may be run with virtual devices
         configured in the test run configuration.
 
-        Test:
+        Steps:
             Run the ``driver-tests`` unit test suite through meson.
+
+        Verify:
+            All unit tests from ``driver-tests`` suite pass.
         """
         vdev_args = ""
         for dev in self._ctx.dpdk.get_virtual_devices():
@@ -101,8 +107,11 @@ def test_devices_listed_in_testpmd(self) -> None:
 
         Test that the devices configured in the test run configuration are found in testpmd.
 
-        Test:
-            List all devices found in testpmd and verify the configured devices are among them.
+        Steps:
+            List all devices found in testpmd.
+
+        Verify:
+            Configured devices are found within testpmd list.
         """
         with TestPmdShell() as testpmd:
             dev_list = [str(x) for x in testpmd.get_devices()]
@@ -120,9 +129,11 @@ def test_device_bound_to_driver(self) -> None:
         Test that the devices configured in the test run configuration are bound to
         the proper driver. This test case runs on Linux only.
 
-        Test:
-            List all devices with the ``dpdk-devbind.py`` script and verify that
-            the configured devices are bound to the proper driver.
+        Steps:
+            List all devices with the ``dpdk-devbind.py`` script.
+
+        Verify:
+            Configured devices are bound to the proper driver.
         """
         if not isinstance(self._ctx.sut_node.main_session, LinuxSession):
             return
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index d2a9e614d4..18c7e9e804 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -121,8 +121,14 @@ def vlan_setup(self, testpmd: TestPmdShell, port_id: int, filtered_id: int) -> N
     def test_vlan_receipt_no_stripping(self) -> None:
         """Verify packets are received with their VLAN IDs when stripping is disabled.
 
-        Test:
-            Create an interactive testpmd shell and verify a VLAN packet.
+        Steps:
+            Launch testpmd.
+            Disable promiscuous mode, enable VLAN filter mode.
+            Add VLAN ID 1 to Rx VLAN filter list.
+            Send VLAN packet with VLAN ID 1.
+
+        Verify:
+            Sent VLAN packet is received with VLAN ID.
         """
         with TestPmdShell() as testpmd:
             self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
@@ -134,8 +140,15 @@ def test_vlan_receipt_no_stripping(self) -> None:
     def test_vlan_receipt_stripping(self) -> None:
         """Ensure VLAN packet received with no tag when receipts and header stripping are enabled.
 
-        Test:
-            Create an interactive testpmd shell and verify a VLAN packet.
+        Steps:
+            Launch testpmd.
+            Disable promiscuous mode, enable VLAN filter mode.
+            Add VLAN ID 1 to Rx VLAN filter list.
+            Enable VLAN stripping on port 0.
+            Send VLAN packet with VLAN ID 1.
+
+        Verify:
+            Sent VLAN packet is received without VLAN ID.
         """
         with TestPmdShell() as testpmd:
             self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
@@ -147,8 +160,14 @@ def test_vlan_receipt_stripping(self) -> None:
     def test_vlan_no_receipt(self) -> None:
         """Ensure VLAN packet dropped when filter is on and sent tag not in the filter list.
 
-        Test:
-            Create an interactive testpmd shell and verify a VLAN packet.
+        Steps:
+            Launch testpmd.
+            Disable promiscuous mode, enable VLAN filter mode.
+            Add VLAN ID 1 to Rx VLAN filter list.
+            Send VLAN packet with VLAN ID 2.
+
+        Verify:
+            Sent VLAN packet is dropped.
         """
         with TestPmdShell() as testpmd:
             self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
@@ -159,8 +178,14 @@ def test_vlan_no_receipt(self) -> None:
     def test_vlan_header_insertion(self) -> None:
         """Ensure that VLAN packet is received with the correct inserted VLAN tag.
 
-        Test:
-            Create an interactive testpmd shell and verify a non-VLAN packet.
+        Steps:
+            Launch testpmd.
+            Disable promiscuous mode.
+            Add VLAN ID 51 to Tx VLAN insertion list.
+            Send non-VLAN packet.
+
+        Verify:
+            Sent packet is received with VLAN ID 51.
         """
         with TestPmdShell() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
-- 
2.50.1

