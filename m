Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0158CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 14:39:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32A9540654;
	Wed, 20 Aug 2025 16:39:32 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 8998B40616
 for <dev@dpdk.org>; Wed, 20 Aug 2025 16:39:30 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7e8706856e0so683252485a.3
 for <dev@dpdk.org>; Wed, 20 Aug 2025 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755700770; x=1756305570; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMwmWH7Wbo4QtM/EExhSFIxjNyAZ2Q16x0eV0bAyBqI=;
 b=cxuWGd1jdszWvLfzXT0hY45kjCuk8FGZR4H/9gmNxUWvDYqpWtseShM8N04qg5bFJL
 TJ3QaIfkhIg4tBjuFAiay5D8Qai0Gjl8gjTl3Ybs83YL06bH0jb6kAAW+6C2RkNz7dQn
 fVSquud9QnZZNhQ71S6B7I/jpHAyiJPszvQC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755700770; x=1756305570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMwmWH7Wbo4QtM/EExhSFIxjNyAZ2Q16x0eV0bAyBqI=;
 b=I2R37k+TgAUkljp6bZs8wU0W02eRCWaMxGWplS/p7SE1qu1jZzFadcI7oLvSWTyHG9
 CcEzKmVDmA6IthUSQwu9Pzri7jHH0R5owPUW0MrvjraOIw7o59aSHrmlxlgr6jsemIry
 lHcvq9MhUEQbGkbZZBN++7d7hB9/5rr2ywqMVzO1cCpi+k2d1jQk5x0ra6Xh6cj22b/N
 pitHghDiBCJ5AnMAqfSyFmUVLhOMQQGp1djWHCKYVVHbPL7s8R6SffS3hKtfFTI6q2V/
 2D3dxwurvKOC/xOjrgcYqXO7cFjkl5pvIee22MnTqsJjsm5770t9v6BF0M8HvdUTC+z9
 H/Xg==
X-Gm-Message-State: AOJu0YzjeF6fx0sSmWRAEQP2HIXFfx+ncZ2KjNUmaeMQVvg1K0j6a3TV
 qVFHyUKLxdAOj3YiRhAvJzAtP1B4CQ2I7isaiW8ITrrGM1iKfOx4YO4PPUKLcCYhK20=
X-Gm-Gg: ASbGncvJNrFOhvcWS+95IYAJHZLbpgVcN6CFx/SifR04RCtoB8x9b5J7iBo5Hmx5s2X
 +ZPF01ivhG18Cbu56/BveeaK4f3dGAgq0xHEi8oI1Wdezi6Rh4KFr8PILFZpf4kLuKIM7T673U1
 rLa1t488d1tWyd6G1MSbpvswgB+18H+m/AtsqxhdIp8dDHfYzi8O6PmkziFRMTQPrbR1z9j2jY+
 FB3P8sDvB5k5V/iBuxD9X5QQHgpwrjxpbBbMGEWptayyKh7mcM04djpiz3aRSskCUcu0vJnsa18
 Y4L6WjiZHquGQgsvBIX5zBN7Vblnco6h8O0/StinpCyGh5LOY1AXBaFht6Z7EZLK0Y32ARnVfug
 0suPXWq6MA9swZQxRxu5CrV93
X-Google-Smtp-Source: AGHT+IFv4VvYX1wupblFIk0XSbNcyvElauUBKKhoxJljYLZMI0lZReF2APQb3Ju3QcWG4sYTSuWX6A==
X-Received: by 2002:a05:6214:2304:b0:70d:6de2:1b2d with SMTP id
 6a1803df08f44-70d77149afamr29048806d6.57.1755700768602; 
 Wed, 20 Aug 2025 07:39:28 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70bafbd35f5sm77408366d6.23.2025.08.20.07.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 07:39:27 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 2/2] dts: add steps and verify sections to docstrings
Date: Wed, 20 Aug 2025 10:39:22 -0400
Message-ID: <20250820143922.42596-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820143922.42596-1-dmarx@iol.unh.edu>
References: <20250807145002.297452-1-dmarx@iol.unh.edu>
 <20250820143922.42596-1-dmarx@iol.unh.edu>
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
 dts/tests/TestSuite_blocklist.py              |  12 +-
 dts/tests/TestSuite_checksum_offload.py       |  72 ++++-----
 dts/tests/TestSuite_dual_vlan.py              |  28 ++--
 dts/tests/TestSuite_dynamic_config.py         |  46 ++++--
 dts/tests/TestSuite_dynamic_queue_conf.py     |  36 ++++-
 dts/tests/TestSuite_hello_world.py            |   4 +-
 dts/tests/TestSuite_l2fwd.py                  |  10 +-
 dts/tests/TestSuite_mac_filter.py             |  41 +++--
 dts/tests/TestSuite_mtu.py                    |   8 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |  18 ++-
 dts/tests/TestSuite_port_control.py           |  24 +--
 ...stSuite_port_restart_config_persistency.py |   8 +-
 dts/tests/TestSuite_port_stats.py             |   8 +-
 dts/tests/TestSuite_promisc_support.py        |  12 +-
 dts/tests/TestSuite_queue_start_stop.py       |  40 ++---
 dts/tests/TestSuite_rte_flow.py               | 142 +++++++++---------
 dts/tests/TestSuite_smoke_tests.py            |  29 ++--
 dts/tests/TestSuite_softnic.py                |  10 +-
 dts/tests/TestSuite_uni_pkt.py                |  72 ++++-----
 dts/tests/TestSuite_vlan.py                   |  41 ++++-
 20 files changed, 388 insertions(+), 273 deletions(-)

diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index ce7da1cc8f..993c90acf6 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -34,9 +34,9 @@ def no_blocklisted(self):
         """Run testpmd with no blocklisted device.
 
         Steps:
-            Run testpmd without specifying allowed or blocked ports.
+            * Run testpmd without specifying allowed or blocked ports.
         Verify:
-            That no ports were blocked.
+            * That no ports were blocked.
         """
         self.verify_blocklisted_ports([])
 
@@ -45,9 +45,9 @@ def one_port_blocklisted(self):
         """Run testpmd with one blocklisted port.
 
         Steps:
-            Run testpmd with one only one blocklisted port and allowing all the other ones.
+            * Run testpmd with one only one blocklisted port and allowing all the other ones.
         Verify:
-            That the port was successfully blocklisted.
+            * That the port was successfully blocklisted.
         """
         self.verify_blocklisted_ports(self.topology.sut_ports[:1])
 
@@ -56,8 +56,8 @@ def all_but_one_port_blocklisted(self):
         """Run testpmd with all but one blocklisted port.
 
         Steps:
-            Run testpmd with only one allowed port, blocking all the other ones.
+            * Run testpmd with only one allowed port, blocking all the other ones.
         Verify:
-            That all specified ports were successfully blocklisted.
+            * That all specified ports were successfully blocklisted.
         """
         self.verify_blocklisted_ports(self.topology.sut_ports[:-1])
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index d411af70a9..dc0c89eccd 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -115,14 +115,14 @@ def test_insert_checksums(self) -> None:
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
+            * Verify packets are received.
+            * Verify packet checksums match the expected flags.
         """
         dport_id = 50000
         payload = b"xxxxx"
@@ -148,13 +148,13 @@ def test_no_insert_checksums(self) -> None:
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
+            * Verify packets are received.
+            * Verify packet checksums match the expected flags.
         """
         dport_id = 50000
         payload = b"xxxxx"
@@ -179,13 +179,13 @@ def test_l4_rx_checksum(self) -> None:
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
+            * Verify packet checksums match the expected flags.
         """
         dport_id = 50000
         packet_list = [
@@ -212,13 +212,13 @@ def test_l3_rx_checksum(self) -> None:
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
+            * Verify packet checksums match the expected flags.
         """
         dport_id = 50000
         packet_list = [
@@ -245,13 +245,13 @@ def test_validate_rx_checksum(self) -> None:
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
+            * Verify packet checksums match the expected flags.
         """
         dport_id = 50000
         packet_list = [
@@ -291,13 +291,13 @@ def test_vlan_checksum(self) -> None:
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
+            * Verify packet checksums match the expected flags.
         """
         dport_id = 50000
         payload = b"xxxxx"
@@ -348,13 +348,13 @@ def test_validate_sctp_checksum(self) -> None:
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
+            * Verify packet checksums match the expected flags.
         """
         dport_id = 50000
         packet_list = [
diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_vlan.py
index 6af503528d..1c17844a50 100644
--- a/dts/tests/TestSuite_dual_vlan.py
+++ b/dts/tests/TestSuite_dual_vlan.py
@@ -186,12 +186,12 @@ def insert_second_vlan(self) -> None:
         """Test that a packet with a single VLAN can have an additional one inserted into it.
 
         Steps:
-            Set VLAN tag on the tx port.
-            Create a packet with a VLAN tag.
-            Send and receive the packet.
+            * Set VLAN tag on the tx port.
+            * Create a packet with a VLAN tag.
+            * Send and receive the packet.
         Verify:
-            Packets are received.
-            Packet contains two VLAN tags.
+            * Packets are received.
+            * Packet contains two VLAN tags.
         """
         with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.tx_vlan_set(port=self.tx_port, enable=True, vlan=self.vlan_insert_tag)
@@ -216,12 +216,12 @@ def all_vlan_functions(self) -> None:
         """Test that all combinations of :class:`TestCaseOptions` behave as expected.
 
         Steps:
-            Send packets with VLAN functions disabled.
-            Send packets with a set of combinations of VLAN functions enabled.
-            Disable VLAN function to allow for a clean environment for the next test.
+            * Send packets with VLAN functions disabled.
+            * Send packets with a set of combinations of VLAN functions enabled.
+            * Disable VLAN function to allow for a clean environment for the next test.
         Verify:
-            Packet with two VLANs is unchanged without the VLAN modification functions enabled.
-            VLAN functions work as expected.
+            * Packet with two VLANs is unchanged without the VLAN modification functions enabled.
+            * VLAN functions work as expected.
         """
         send_pkt = (
             Ether()
@@ -257,11 +257,11 @@ def maintains_priority(self) -> None:
         """Test that priorities of multiple VLAN tags are preserved by the PMD.
 
         Steps:
-            Create packets with VLAN tags with priorities.
-            Send and receive packets.
+            * Create packets with VLAN tags with priorities.
+            * Send and receive packets.
         Verify:
-            Packets are received.
-            Priorities are unchanged.
+            * Packets are received.
+            * Priorities are unchanged.
         """
         pkt = (
             Ether()
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 49f295a39a..7ca445e40d 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -85,27 +85,34 @@ def disable_promisc_setup(self, testpmd: TestPmdShell, port_id: int) -> TestPmdS
     def test_default_mode(self) -> None:
         """Tests default configuration.
 
-        Creates a testpmd shell, verifies that promiscuous mode is enabled by default,
-        and sends two packets; one matching source MAC address and one unknown.
-        Verifies that both are received.
+        Steps:
+            * Launch testpmd.
+            * Send a packet with Rx port mac address.
+            * Send a packet with mismatched mac address.
+
+        Verify:
+            * Both packets are received.
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
+            * Launch testpmd and enable promiscuous mode.
+            * Send a packet with Rx port mac address.
+            * Send a packet with mismatched mac address.
+
+        Verify:
+            * Rx port mac address packet is received.
+            * Mismatched mac address packet is dropped.
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
+            * Launch testpmd and disable promiscuous mode.
+            * Send a packet with Rx port mac address.
+            * Send a packet with broadcast mac address.
+
+        Verify:
+            * Both packets are received.
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
+            * Launch testpmd and disable promiscuous mode.
+            * Disable multicast mode on all ports.
+            * Send a packet with a multicast mac address.
+            * Enable multicast mode on all ports.
+            * Send another packet with a multicast mac address.
+
+        Verify:
+            * First multicast packet is dropped.
+            * Second multicast packet is received.
         """
         with TestPmdShell() as testpmd:
             testpmd = self.disable_promisc_setup(testpmd=testpmd, port_id=0)
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index f8c7dbfb71..196c2eddde 100644
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
+            * Run method for stopping queues with flag for Rx testing set to :data:`True`.
+
+        Verify:
+            * Stopped Rx queues do not receive traffic.
+        """
         self.stop_queues(True)
 
     @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
     def test_rx_queue_configuration(self):
-        """Run method for configuring queues with flag for Rx testing set to :data:`True`."""
+        """Rx queue configuration test.
+
+        Steps:
+            * Run method for configuring queues with flag for Rx testing set to :data:`True`.
+
+        Verify:
+            * Rx queue ring size is correctly modified during runtime.
+        """
         self.modify_ring_size(True)
 
     @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
     def test_tx_queue_stop(self):
-        """Run method for stopping queues with flag for Rx testing set to :data:`False`."""
+        """Tx queue stop test.
+
+        Steps:
+            * Run method for stopping queues with flag for Rx testing set to :data:`False`.
+
+        Verify:
+            * Stopped Tx queues do not receive traffic.
+        """
         self.stop_queues(False)
 
     @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
     def test_tx_queue_configuration(self):
-        """Run method for configuring queues with flag for Rx testing set to :data:`False`."""
+        """Tx queue configuration test.
+
+        Steps:
+            * Run method for configuring queues with flag for Rx testing set to :data:`False`.
+
+        Verify:
+            * Tx queue ring size is correctly modified during runtime.
+        """
         self.modify_ring_size(False)
diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hello_world.py
index 6c9ecc1177..1a70596d74 100644
--- a/dts/tests/TestSuite_hello_world.py
+++ b/dts/tests/TestSuite_hello_world.py
@@ -29,9 +29,9 @@ def test_hello_world(self) -> None:
         """EAL confidence test.
 
         Steps:
-            Start testpmd session and check status.
+            * Start testpmd session and check status.
         Verify:
-            The testpmd session throws no errors.
+            * The testpmd session throws no errors.
         """
         with TestPmdShell() as testpmd:
             testpmd.start()
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 5ffa2dcd19..addc4598b6 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -40,10 +40,12 @@ def set_up_suite(self) -> None:
     def l2fwd_integrity(self) -> None:
         """Test the L2 forwarding integrity.
 
-        Test:
-            Configure a testpmd shell with a different numbers of queues (1, 2, 4 and 8) per run.
-            Start up L2 forwarding, send random packets from the TG and verify they were all
-            received back.
+        Steps:
+            * Configure a testpmd shell with a different numbers of queues (1, 2, 4 and 8) per run.
+            * Start up L2 forwarding, send random packets from the TG.
+
+        Verify:
+            * Ensure all packets are received.
         """
         queues = [1, 2, 4, 8]
 
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index 2387fdfac2..cbd48f636b 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -93,14 +93,20 @@ def test_add_remove_mac_addresses(self) -> None:
         added to the PMD. Packets should either be received or not received depending on
         the properties applied to the PMD at any given time.
 
-        Test:
+        Steps:
             * Start TestPMD without promiscuous mode.
-            * Send a packet with the port's default mac address. (Should receive)
-            * Send a packet with fake mac address. (Should not receive)
+            * Send a packet with the port's default mac address.
+            * Send a packet with fake mac address.
             * Add fake mac address to the PMD's address pool.
-            * Send a packet with the fake mac address to the PMD. (Should receive)
+            * Send a packet with the fake mac address to the PMD.
             * Remove the fake mac address from the PMD's address pool.
-            * Send a packet with the fake mac address to the PMD. (Should not receive)
+            * Send a packet with the fake mac address to the PMD.
+
+        Verify:
+            * Sent packet with default mac address is received.
+            * Sent packet with fake mac address is dropped.
+            * Second sent packet with fake mac address is received.
+            * Third sent packet with fake mac address is dropped.
         """
         with TestPmdShell() as testpmd:
             testpmd.set_promisc(0, enable=False)
@@ -127,16 +133,23 @@ def test_invalid_address(self) -> None:
         and address pooling. Devices should not be able to use invalid mac addresses, remove their
         built-in hardware address, or exceed their address pools.
 
-        Test:
+        Steps:
             * Start TestPMD.
-            * Attempt to add an invalid mac address. (Should fail)
+            * Attempt to add an invalid mac address.
             * Attempt to remove the device's hardware address with no additional addresses in the
-              address pool. (Should fail)
-            * Add a fake mac address to the pool twice in succession. (Should not create any errors)
+              address pool.
+            * Add a fake mac address to the pool twice in succession.
             * Attempt to remove the device's hardware address with other addresses in the address
-              pool. (Should fail)
+              pool.
             * Determine the device's mac address pool size, and fill the pool with fake addresses.
-            * Attempt to add another fake mac address, overloading the address pool. (Should fail)
+            * Attempt to add another fake mac address, overloading the address pool.
+
+        Verify:
+            * Invalid mac address addition fails.
+            * Hardware address removal with no additional address fails.
+            * Fake mac address additions does not create any errors.
+            * Hardware address removal with other addresses in pool fails.
+            * Overloading the address pool with another fake mac address fails.
         """
         with TestPmdShell() as testpmd:
             testpmd.start()
@@ -185,12 +198,16 @@ def test_multicast_filter(self) -> None:
         Ensure that multicast filtering performs as intended when a given device is bound
         to the PMD.
 
-        Test:
+        Steps:
             * Start TestPMD without promiscuous mode.
             * Add a fake multicast address to the PMD's multicast address pool.
             * Send a packet with the fake multicast address to the PMD. (Should receive)
             * Remove the fake multicast address from the PMDs multicast address filter.
             * Send a packet with the fake multicast address to the PMD. (Should not receive)
+
+        Verify:
+            * Sent packet with fake multicast address is received.
+            * Second sent packet with fake multicast address is dropped.
         """
         with TestPmdShell() as testpmd:
             testpmd.start()
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index d5b3fe02af..c649f6c6b7 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -127,7 +127,7 @@ def assess_mtu_boundary(self, testpmd_shell: TestPmdShell, mtu: int) -> None:
     def test_runtime_mtu_updating_and_forwarding(self) -> None:
         """Verify runtime MTU adjustments and assess packet forwarding behavior.
 
-        Test:
+        Steps:
             * Start TestPMD in a paired topology.
             * Set port MTU to 1500.
             * Send packets of 1491, 1500 and 1509 bytes.
@@ -186,7 +186,7 @@ def test_runtime_mtu_updating_and_forwarding(self) -> None:
     def test_cli_mtu_forwarding_for_std_packets(self) -> None:
         """Assesses packet forwarding of standard MTU packets after pre-runtime MTU adjustments.
 
-        Test:
+        Steps:
             * Start TestPMD with MTU size of 1518 bytes, set pre-runtime.
             * Send packets of size 1491, 1500 and 1509 bytes.
             * Verify the first two packets are forwarded and the last is dropped.
@@ -216,7 +216,7 @@ def test_cli_mtu_forwarding_for_std_packets(self) -> None:
     def test_cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:
         """Assess packet forwarding of packets within the bounds of a pre-runtime MTU adjustment.
 
-        Test:
+        Steps:
             * Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
             * Send packets of size 8991, 9000 and 1509 bytes.
         Verify:
@@ -242,7 +242,7 @@ def test_cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:
     def test_cli_mtu_std_packets_for_jumbo_mtu(self) -> None:
         """Assess boundary of jumbo MTU value set pre-runtime.
 
-        Test:
+        Steps:
             * Start TestPMD with MTU size of 9018 bytes, set pre-runtime.
             * Send a packets of size 8991, 9000 and 9009 bytes.
             * Verify the first two packets are forwarded and the last is dropped.
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
index 015163dd11..f7fae2a7d9 100644
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
+            * Run the :meth:`pmd_scatter` test with `mb_size` set to 2048.
+
+        Verify:
+            * Payload of scattered packet matches expected payload.
+        """
         self.pmd_scatter(mb_size=2048)
 
     @requires(NicCapability.RX_OFFLOAD_SCATTER)
     @func_test
     def test_scatter_mbuf_2048_with_offload(self) -> None:
-        """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload."""
+        """Scatter mbuf test with rx_scatter offloaded.
+
+        Steps:
+            * Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload.
+
+        Verify:
+            * Payload of scattered packet matches expected payload.
+        """
         self.pmd_scatter(mb_size=2048, enable_offload=True)
 
     def tear_down_suite(self) -> None:
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index 58783f1d18..8007631d7a 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -56,12 +56,12 @@ def test_start_ports(self) -> None:
         """Start all ports and send a small number of packets.
 
         Steps:
-            Start all ports
-            Start forwarding in MAC mode
-            Send 100 generic packets to the SUT
+            * Start all ports
+            * Start forwarding in MAC mode
+            * Send 100 generic packets to the SUT
 
         Verify:
-            Check that all the packets sent are sniffed on the TG receive port.
+            * Check that all the packets sent are sniffed on the TG receive port.
         """
         with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.start_all_ports()
@@ -73,14 +73,14 @@ def test_stop_ports(self) -> None:
         """Stop all ports, then start all ports, amd then send a small number of packets.
 
         Steps:
-            Stop all ports
-            Start all ports
-            Start forwarding in MAC mode
-            Send 100 generic packets to the SUT
+            * Stop all ports
+            * Start all ports
+            * Start forwarding in MAC mode
+            * Send 100 generic packets to the SUT
 
         Verify:
-            Check that stopping the testpmd ports brings down their links
-            Check that all the packets sent are sniffed on the TG receive port.
+            * Check that stopping the testpmd ports brings down their links
+            * Check that all the packets sent are sniffed on the TG receive port.
         """
         with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.stop_all_ports()
@@ -96,10 +96,10 @@ def test_close_ports(self) -> None:
         """Close all the ports via testpmd.
 
         Steps:
-            Close all the testpmd ports
+            * Close all the testpmd ports
 
         Verify:
-            Check that testpmd no longer reports having any ports
+            * Check that testpmd no longer reports having any ports
         """
         with TestPmdShell() as testpmd:
             testpmd.close_all_ports()
diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts/tests/TestSuite_port_restart_config_persistency.py
index 42ea221586..10b416bc3b 100644
--- a/dts/tests/TestSuite_port_restart_config_persistency.py
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py
@@ -56,10 +56,10 @@ def port_configuration_persistence(self) -> None:
         """Port restart configuration persistency test.
 
         Steps:
-            For each port set the port MTU, VLAN filter, mac address, and promiscuous mode.
+            * For each port set the port MTU, VLAN filter, mac address, and promiscuous mode.
 
         Verify:
-            The configuration persists after the port is restarted.
+            * The configuration persists after the port is restarted.
         """
         with TestPmdShell(disable_device_start=True) as testpmd:
             for port_id, _ in enumerate(self.topology.sut_ports):
@@ -86,9 +86,9 @@ def flow_ctrl_port_configuration_persistence(self) -> None:
         """Flow control port configuration persistency test.
 
         Steps:
-            For each port enable flow control for RX and TX individually.
+            * For each port enable flow control for RX and TX individually.
         Verify:
-            The configuration persists after the port is restarted.
+            * The configuration persists after the port is restarted.
         """
         with TestPmdShell(disable_device_start=True) as testpmd:
             for port_id, _ in enumerate(self.topology.sut_ports):
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_stats.py
index ddd28623b3..ab6d544f16 100644
--- a/dts/tests/TestSuite_port_stats.py
+++ b/dts/tests/TestSuite_port_stats.py
@@ -130,12 +130,12 @@ def test_stats_updates(self) -> None:
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
+            * Parse verbose info from stopping packet forwarding and verify values in port stats.
         """
         with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.set_verbose(3)
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_promisc_support.py
index 8a7a7efb57..05767239d8 100644
--- a/dts/tests/TestSuite_promisc_support.py
+++ b/dts/tests/TestSuite_promisc_support.py
@@ -28,13 +28,13 @@ def test_promisc_packets(self) -> None:
         """Verify that promiscuous mode works.
 
         Steps:
-            Create a packet with a different mac address to the destination.
-            Enable promiscuous mode.
-            Send and receive packet.
-            Disable promiscuous mode.
-            Send and receive packet.
+            * Create a packet with a different mac address to the destination.
+            * Enable promiscuous mode.
+            * Send and receive packet.
+            * Disable promiscuous mode.
+            * Send and receive packet.
         Verify:
-            Packet sent with the wrong address is received in promiscuous mode and filtered out
+            * Packet sent with the wrong address is received in promiscuous mode and filtered out
             otherwise.
 
         """
diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuite_queue_start_stop.py
index d739ddedfe..02fea93150 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_start_stop.py
@@ -57,11 +57,11 @@ def test_rx_queue_start_stop(self) -> None:
         """Rx queue start stop test.
 
         Steps:
-            Launch testpmd, stop Rx queue 0 on port 0.
-            Stop testpmd, start Rx queue 0 on port 0, start testpmd.
+            * Launch testpmd, stop Rx queue 0 on port 0.
+            * Stop testpmd, start Rx queue 0 on port 0, start testpmd.
         Verify:
-            Send a packet on port 0 after Rx queue is stopped, ensure it is not received.
-            Send a packet on port 0 after Rx queue is started, ensure it is received.
+            * Send a packet on port 0 after Rx queue is stopped, ensure it is not received.
+            * Send a packet on port 0 after Rx queue is started, ensure it is received.
         """
         with TestPmdShell() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
@@ -78,11 +78,11 @@ def test_tx_queue_start_stop(self) -> None:
         """Tx queue start stop test.
 
         Steps:
-            Launch testpmd, stop Tx queue 0 on port 0.
-            Stop testpmd, start Tx queue 0 on port 0, start testpmd.
+            * Launch testpmd, stop Tx queue 0 on port 0.
+            * Stop testpmd, start Tx queue 0 on port 0, start testpmd.
         Verify:
-            Send a packet on port 0 after Tx queue is stopped, ensure it is not received.
-            Send a packet on port 0 after Tx queue is started, ensure it is received.
+            * Send a packet on port 0 after Tx queue is stopped, ensure it is not received.
+            * Send a packet on port 0 after Tx queue is started, ensure it is received.
         """
         with TestPmdShell() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
@@ -99,13 +99,13 @@ def test_rx_queue_deferred_start(self) -> None:
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
         Verify:
-            Send a packet on port 0 after deferred start is set, ensure it is not received.
-            Send a packet on port 0 after Rx queue 0 is started, ensure it is received.
+            * Send a packet on port 0 after deferred start is set, ensure it is not received.
+            * Send a packet on port 0 after Rx queue 0 is started, ensure it is received.
         """
         with TestPmdShell() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
@@ -124,13 +124,13 @@ def test_tx_queue_deferred_start(self) -> None:
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
         Verify:
-            Send a packet on port 1 after deferred start is set, ensure it is not received.
-            Send a packet on port 1 after Tx queue 0 is started, ensure it is received.
+            * Send a packet on port 1 after deferred start is set, ensure it is not received.
+            * Send a packet on port 1 after Tx queue 0 is started, ensure it is received.
         """
         with TestPmdShell() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 4855e4261d..6ed95b736f 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -221,14 +221,14 @@ def test_queue_action_ETH(self) -> None:
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
+            * Check that each packet is received on the appropriate queue.
         """
         packet_list = [
             Ether(src="02:00:00:00:00:00"),
@@ -263,14 +263,14 @@ def test_queue_action_IP(self) -> None:
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
+            * Check that each packet is received on the appropriate queue.
         """
         packet_list = [
             Ether() / IP(src="192.168.1.1"),
@@ -322,14 +322,14 @@ def test_queue_action_L4(self) -> None:
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
+            * Check that each packet is received on the appropriate queue.
         """
         packet_list = [
             Ether() / IP() / TCP(sport=1234),
@@ -378,14 +378,14 @@ def test_queue_action_VLAN(self) -> None:
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
+            * Check that each packet is received on the appropriate queue.
         """
         packet_list = [Ether() / Dot1Q(vlan=100), Ether() / Dot1Q(type=0x0800)]
         flow_list = [
@@ -405,14 +405,14 @@ def test_drop_action_ETH(self) -> None:
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
+            * Check that each packet is dropped.
 
         One packet will be sent as a confidence check, to ensure packets are being
         received under normal circumstances.
@@ -450,14 +450,14 @@ def test_drop_action_IP(self) -> None:
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
+            * Check that each packet is dropped.
 
         One packet will be sent as a confidence check, to ensure packets are being
         received under normal circumstances.
@@ -505,14 +505,14 @@ def test_drop_action_L4(self) -> None:
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
+            * Check that each packet is dropped.
 
         One packet will be sent as a confidence check, to ensure packets are being
         received under normal circumstances.
@@ -556,14 +556,14 @@ def test_drop_action_VLAN(self) -> None:
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
+            * Check that each packet is dropped.
 
         One packet will be sent as a confidence check, to ensure packets are being
         received under normal circumstances.
@@ -595,14 +595,14 @@ def test_modify_actions(self) -> None:
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
@@ -640,14 +640,14 @@ def test_egress_rules(self) -> None:
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
+            * Check that each packet is dropped.
 
         One packet will be sent as a confidence check, to ensure packets are being
         received under normal circumstances.
@@ -685,13 +685,13 @@ def test_jump_action(self) -> None:
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
@@ -740,14 +740,14 @@ def test_priority_attribute(self) -> None:
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
+            * Check that each packet is received on the appropriate queue.
         """
         test_packet = Ether() / IP() / Raw()
         flow_list = [
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 5602b316c0..35128ff5d4 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -56,8 +56,11 @@ def test_unit_tests(self) -> None:
         Test that all unit test from the ``fast-tests`` suite pass.
         The suite is a subset with only the most basic tests.
 
-        Test:
-            Run the ``fast-tests`` unit test suite through meson.
+        Steps:
+            * Run the ``fast-tests`` unit test suite through meson.
+
+        Verify:
+            * All unit tests from ``fast-tests`` suite pass.
         """
         self.sut_node.main_session.send_command(
             f"meson test -C {self.dpdk_build_dir_path} --suite fast-tests -t 120",
@@ -74,8 +77,11 @@ def test_driver_tests(self) -> None:
         The suite is a subset with driver tests. This suite may be run with virtual devices
         configured in the test run configuration.
 
-        Test:
-            Run the ``driver-tests`` unit test suite through meson.
+        Steps:
+            * Run the ``driver-tests`` unit test suite through meson.
+
+        Verify:
+            * All unit tests from ``driver-tests`` suite pass.
         """
         vdev_args = ""
         for dev in self._ctx.dpdk.get_virtual_devices():
@@ -101,8 +107,11 @@ def test_devices_listed_in_testpmd(self) -> None:
 
         Test that the devices configured in the test run configuration are found in testpmd.
 
-        Test:
-            List all devices found in testpmd and verify the configured devices are among them.
+        Steps:
+            * List all devices found in testpmd.
+
+        Verify:
+            * Configured devices are found within testpmd list.
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
+            * List all devices with the ``dpdk-devbind.py`` script.
+
+        Verify:
+            * Configured devices are bound to the proper driver.
         """
         if not isinstance(self._ctx.sut_node.main_session, LinuxSession):
             return
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index 27754c08e7..f6bc6f120b 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -97,13 +97,13 @@ def softnic(self) -> None:
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
+            * The packets that are received are the same as the packets sent.
 
         """
         with TestPmdShell(
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index 690c5d4fd1..70377eaa9d 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -75,13 +75,13 @@ def test_l2_packet_detect(self) -> None:
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
+            * Check that each packet has a destination MAC address matching the set ID.
+            * Check the packet type fields in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [Ether(type=0x88F7) / UDP(dport=dport_id) / Raw(), Ether() / ARP() / Raw()]
@@ -94,13 +94,13 @@ def test_l3_l4_packet_detect(self) -> None:
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
+            * Check that each packet has a destination MAC address matching the set ID.
+            * Check the packet type fields in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -127,13 +127,13 @@ def test_ipv6_l4_packet_detect(self) -> None:
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
+            * Check that each packet has a destination MAC address matching the set ID.
+            * Check the packet type fields in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -156,13 +156,13 @@ def test_l3_tunnel_packet_detect(self) -> None:
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
+            * Check that each packet has a destination MAC address matching the set ID.
+            * Check the packet type fields in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -191,13 +191,13 @@ def test_gre_tunnel_packet_detect(self) -> None:
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
+            * Check that each packet has a destination MAC address matching the set ID.
+            * Check the packet type fields in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -224,13 +224,13 @@ def test_nsh_packet_detect(self) -> None:
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
+            * Check that each packet has a destination MAC address matching the set ID.
+            * Check the packet type fields in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
@@ -265,14 +265,14 @@ def test_vxlan_tunnel_packet_detect(self) -> None:
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
+            * Check that each packet has a destination MAC address matching the set ID.
+            * Check the packet type fields in verbose output, verify the flags match.
         """
         dport_id = 50000
         packet_list = [
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index d2a9e614d4..093a814e3c 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -121,8 +121,14 @@ def vlan_setup(self, testpmd: TestPmdShell, port_id: int, filtered_id: int) -> N
     def test_vlan_receipt_no_stripping(self) -> None:
         """Verify packets are received with their VLAN IDs when stripping is disabled.
 
-        Test:
-            Create an interactive testpmd shell and verify a VLAN packet.
+        Steps:
+            * Launch testpmd.
+            * Disable promiscuous mode, enable VLAN filter mode.
+            * Add VLAN ID 1 to Rx VLAN filter list.
+            * Send VLAN packet with VLAN ID 1.
+
+        Verify:
+            * Sent VLAN packet is received with VLAN ID.
         """
         with TestPmdShell() as testpmd:
             self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
@@ -134,8 +140,15 @@ def test_vlan_receipt_no_stripping(self) -> None:
     def test_vlan_receipt_stripping(self) -> None:
         """Ensure VLAN packet received with no tag when receipts and header stripping are enabled.
 
-        Test:
-            Create an interactive testpmd shell and verify a VLAN packet.
+        Steps:
+            * Launch testpmd.
+            * Disable promiscuous mode, enable VLAN filter mode.
+            * Add VLAN ID 1 to Rx VLAN filter list.
+            * Enable VLAN stripping on port 0.
+            * Send VLAN packet with VLAN ID 1.
+
+        Verify:
+            * Sent VLAN packet is received without VLAN ID.
         """
         with TestPmdShell() as testpmd:
             self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
@@ -147,8 +160,14 @@ def test_vlan_receipt_stripping(self) -> None:
     def test_vlan_no_receipt(self) -> None:
         """Ensure VLAN packet dropped when filter is on and sent tag not in the filter list.
 
-        Test:
-            Create an interactive testpmd shell and verify a VLAN packet.
+        Steps:
+            * Launch testpmd.
+            * Disable promiscuous mode, enable VLAN filter mode.
+            * Add VLAN ID 1 to Rx VLAN filter list.
+            * Send VLAN packet with VLAN ID 2.
+
+        Verify:
+            * Sent VLAN packet is dropped.
         """
         with TestPmdShell() as testpmd:
             self.vlan_setup(testpmd=testpmd, port_id=0, filtered_id=1)
@@ -159,8 +178,14 @@ def test_vlan_no_receipt(self) -> None:
     def test_vlan_header_insertion(self) -> None:
         """Ensure that VLAN packet is received with the correct inserted VLAN tag.
 
-        Test:
-            Create an interactive testpmd shell and verify a non-VLAN packet.
+        Steps:
+            * Launch testpmd.
+            * Disable promiscuous mode.
+            * Add VLAN ID 51 to Tx VLAN insertion list.
+            * Send non-VLAN packet.
+
+        Verify:
+            * Sent packet is received with VLAN ID 51.
         """
         with TestPmdShell() as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.mac)
-- 
2.50.1

