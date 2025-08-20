Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC927CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 15:12:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E188B402CC;
	Wed, 20 Aug 2025 17:12:20 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id BCE044027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 17:12:19 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4b297962525so4805191cf.1
 for <dev@dpdk.org>; Wed, 20 Aug 2025 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755702739; x=1756307539; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wdbGNBIPRryhxPDJ5Q4zHPCewgjzES+OlqjB69UjXX0=;
 b=OVwB3jnollb5hsunjq1cogZmuYEW9cwri0v+dl7PttnOR7SAraSaikLfKGgwkmq3p7
 TvW2JQN2Kgu4iPNmCPtzRZWOHSh2kvsM5oUe4q+Tl1foxpQZaix7cAiq+Dadio9+gXVp
 bv9wMHNMcS5vhtkHkTu1z7j14rdqz6fuvT/XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755702739; x=1756307539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wdbGNBIPRryhxPDJ5Q4zHPCewgjzES+OlqjB69UjXX0=;
 b=flrhfebT8YI0/Ag4l6AW25A0oQvG4k7TDgoy21MKRlPaKrtArl8UjycyWOTScTa1cT
 jpV/sSzU5vJlCleHoU5W1l0Gg8q/1gYhjOJ5LM5OHInzRRWE60c2MDsOQ+EprL1WqRmD
 kDDF+oruF5hyP3DbMeVJh4wn3RapY8rZZuFolzYts5xeJsq0vsZ87xUo969Ec+Yz6k0d
 +D/Nr4pbvVtmMaBd0nbsK4ErG+qUvJ6FJ6M24Dluw7Ij1wLF7o+1NDVFwC6GYL+Kp0P+
 M6Ngn7rwsstv5PXcrNI86bNEepnZ6a1Z/TmowN7L5RFcyZ14+9tmUkLA2H+pt9S2Txg9
 stSg==
X-Gm-Message-State: AOJu0YwpmkchJBCpwoeccY/GoA8FwfgODKUy7i+gH3tSB3Dd8ALzClAQ
 0drYK0yLfkP9t797xzvFWS2twyemsoIdHbN7o3SgT9HeL9+orUQ63af5qA1eB5YU4q0=
X-Gm-Gg: ASbGncvYtU482mD/KovAFRNBHCGoypKyhE5dSBDlD0ljOe78egXzvw1uui4HmXHrk9t
 xh14rsXvB0TQpowo4AweVY0jP8vmtcRBKM25dPMUH7+4rMGKz03i0ACvfpIXF4/rjl6YLaod5zg
 C33sto/U3sCdPTEUkgxvkFVJSNVW6sdGtOXsA9ULOUrcDzj+ceDtzxlur9Wsti3KdzYw5I1Yx3y
 oAy0fDBItFbJLekh7ICmm6OZTHMFsthzXuOodpQytWOxKORpIX0YAYpygKDTKk+glk0a5U9e2kH
 6GMrwPqJAzRwU87xcM0eivoVz99sKuC5UzdT0QKPDz8FFcn15XIM8XStsWb2T+f4hdLAUN+AIQV
 P1Hw9dHpzKvI1Kg==
X-Google-Smtp-Source: AGHT+IE8FCtsVqyGeUfDdhQm/1CuSH+SWi0y0CivjAzTAnsftLHUNFLBrIY0pUa3lo8uRPwcqYJyzg==
X-Received: by 2002:a05:622a:2cd:b0:4ab:40d6:ba26 with SMTP id
 d75a77b69052e-4b29122c2cemr36907121cf.24.1755702738451; 
 Wed, 20 Aug 2025 08:12:18 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b12509cdcdsm79298441cf.27.2025.08.20.08.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 08:12:17 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1] dts: remove test_ prefix from test case names
Date: Wed, 20 Aug 2025 11:12:15 -0400
Message-ID: <20250820151215.47742-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

A majority of test cases in DTS are prepended with 'test_',
however this is no longer required with the introduction of
functional/performance test decorators some time ago.
Remove all of these prefixes from test cases.

Bugzilla ID: 1770

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_checksum_offload.py   | 14 ++++++-------
 dts/tests/TestSuite_dynamic_config.py     |  8 ++++----
 dts/tests/TestSuite_dynamic_queue_conf.py |  8 ++++----
 dts/tests/TestSuite_hello_world.py        |  2 +-
 dts/tests/TestSuite_mac_filter.py         |  6 +++---
 dts/tests/TestSuite_mtu.py                |  8 ++++----
 dts/tests/TestSuite_packet_capture.py     |  4 ++--
 dts/tests/TestSuite_pmd_buffer_scatter.py |  4 ++--
 dts/tests/TestSuite_port_control.py       |  6 +++---
 dts/tests/TestSuite_port_stats.py         |  2 +-
 dts/tests/TestSuite_promisc_support.py    |  2 +-
 dts/tests/TestSuite_queue_start_stop.py   |  8 ++++----
 dts/tests/TestSuite_rte_flow.py           | 24 +++++++++++------------
 dts/tests/TestSuite_smoke_tests.py        |  8 ++++----
 dts/tests/TestSuite_uni_pkt.py            | 14 ++++++-------
 dts/tests/TestSuite_vlan.py               |  8 ++++----
 16 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index d411af70a9..ff916a4bb7 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -111,7 +111,7 @@ def setup_hw_offload(self, testpmd: TestPmdShell) -> None:
         testpmd.start_all_ports()
 
     @func_test
-    def test_insert_checksums(self) -> None:
+    def insert_checksums(self) -> None:
         """Enable checksum offload insertion and verify packet reception.
 
         Steps:
@@ -144,7 +144,7 @@ def test_insert_checksums(self) -> None:
                 )
 
     @func_test
-    def test_no_insert_checksums(self) -> None:
+    def no_insert_checksums(self) -> None:
         """Disable checksum offload insertion and verify packet reception.
 
         Steps:
@@ -175,7 +175,7 @@ def test_no_insert_checksums(self) -> None:
                 )
 
     @func_test
-    def test_l4_rx_checksum(self) -> None:
+    def l4_rx_checksum(self) -> None:
         """Tests L4 Rx checksum in a variety of scenarios.
 
         Steps:
@@ -208,7 +208,7 @@ def test_l4_rx_checksum(self) -> None:
                 )
 
     @func_test
-    def test_l3_rx_checksum(self) -> None:
+    def l3_rx_checksum(self) -> None:
         """Tests L3 Rx checksum hardware offload.
 
         Steps:
@@ -241,7 +241,7 @@ def test_l3_rx_checksum(self) -> None:
                 )
 
     @func_test
-    def test_validate_rx_checksum(self) -> None:
+    def validate_rx_checksum(self) -> None:
         """Verify verbose output of Rx packets matches expected behavior.
 
         Steps:
@@ -287,7 +287,7 @@ def test_validate_rx_checksum(self) -> None:
 
     @requires(NicCapability.RX_OFFLOAD_VLAN)
     @func_test
-    def test_vlan_checksum(self) -> None:
+    def vlan_checksum(self) -> None:
         """Test VLAN Rx checksum hardware offload and verify packet reception.
 
         Steps:
@@ -344,7 +344,7 @@ def test_vlan_checksum(self) -> None:
 
     @requires(NicCapability.RX_OFFLOAD_SCTP_CKSUM)
     @func_test
-    def test_validate_sctp_checksum(self) -> None:
+    def validate_sctp_checksum(self) -> None:
         """Test SCTP Rx checksum hardware offload and verify packet reception.
 
         Steps:
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 49f295a39a..8358675b12 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -82,7 +82,7 @@ def disable_promisc_setup(self, testpmd: TestPmdShell, port_id: int) -> TestPmdS
         return testpmd
 
     @func_test
-    def test_default_mode(self) -> None:
+    def default_mode(self) -> None:
         """Tests default configuration.
 
         Creates a testpmd shell, verifies that promiscuous mode is enabled by default,
@@ -100,7 +100,7 @@ def test_default_mode(self) -> None:
             self.send_packet_and_verify(should_receive=True, mac_address="00:00:00:00:00:01")
 
     @func_test
-    def test_disable_promisc(self) -> None:
+    def disable_promisc(self) -> None:
         """Tests disabled promiscuous mode configuration.
 
         Creates an interactive testpmd shell, disables promiscuous mode,
@@ -114,7 +114,7 @@ def test_disable_promisc(self) -> None:
             self.send_packet_and_verify(should_receive=False, mac_address="00:00:00:00:00:01")
 
     @func_test
-    def test_disable_promisc_broadcast(self) -> None:
+    def disable_promisc_broadcast(self) -> None:
         """Tests broadcast reception with disabled promisc mode config.
 
         Creates an interactive testpmd shell, disables promiscuous mode,
@@ -128,7 +128,7 @@ def test_disable_promisc_broadcast(self) -> None:
             self.send_packet_and_verify(should_receive=True, mac_address="ff:ff:ff:ff:ff:ff")
 
     @func_test
-    def test_disable_promisc_multicast(self) -> None:
+    def disable_promisc_multicast(self) -> None:
         """Tests allmulticast mode with disabled promisc config.
 
         Creates an interactive testpmd shell, disables promiscuous mode,
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index f8c7dbfb71..0e9cda1b9f 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -277,24 +277,24 @@ def stop_queues(
 
     @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
-    def test_rx_queue_stop(self):
+    def rx_queue_stop(self):
         """Run method for stopping queues with flag for Rx testing set to :data:`True`."""
         self.stop_queues(True)
 
     @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
-    def test_rx_queue_configuration(self):
+    def rx_queue_configuration(self):
         """Run method for configuring queues with flag for Rx testing set to :data:`True`."""
         self.modify_ring_size(True)
 
     @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
-    def test_tx_queue_stop(self):
+    def tx_queue_stop(self):
         """Run method for stopping queues with flag for Rx testing set to :data:`False`."""
         self.stop_queues(False)
 
     @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
-    def test_tx_queue_configuration(self):
+    def tx_queue_configuration(self):
         """Run method for configuring queues with flag for Rx testing set to :data:`False`."""
         self.modify_ring_size(False)
diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hello_world.py
index 6c9ecc1177..939990835c 100644
--- a/dts/tests/TestSuite_hello_world.py
+++ b/dts/tests/TestSuite_hello_world.py
@@ -25,7 +25,7 @@ class TestHelloWorld(TestSuite):
     config: Config
 
     @func_test
-    def test_hello_world(self) -> None:
+    def hello_world(self) -> None:
         """EAL confidence test.
 
         Steps:
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index 2387fdfac2..89727d90f1 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -85,7 +85,7 @@ def send_packet_and_verify(
             )
 
     @func_test
-    def test_add_remove_mac_addresses(self) -> None:
+    def add_remove_mac_addresses(self) -> None:
         """Assess basic mac addressing filtering functionalities.
 
         This test case validates for proper behavior of mac address filtering with both
@@ -120,7 +120,7 @@ def test_add_remove_mac_addresses(self) -> None:
             self.send_packet_and_verify(mac_address=fake_address, should_receive=False)
 
     @func_test
-    def test_invalid_address(self) -> None:
+    def invalid_address(self) -> None:
         """Assess the behavior of a NIC mac address pool while bound to the PMD.
 
         An assessment of a NIC's behavior when mounted to a PMD as it relates to mac addresses
@@ -179,7 +179,7 @@ def test_invalid_address(self) -> None:
 
     @requires(NicCapability.MCAST_FILTERING)
     @func_test
-    def test_multicast_filter(self) -> None:
+    def multicast_filter(self) -> None:
         """Assess basic multicast address filtering functionalities.
 
         Ensure that multicast filtering performs as intended when a given device is bound
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index d5b3fe02af..907364fc27 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -124,7 +124,7 @@ def assess_mtu_boundary(self, testpmd_shell: TestPmdShell, mtu: int) -> None:
             self.send_packet_and_verify(pkt_size=larger_frame_size, should_receive=False)
 
     @func_test
-    def test_runtime_mtu_updating_and_forwarding(self) -> None:
+    def runtime_mtu_updating_and_forwarding(self) -> None:
         """Verify runtime MTU adjustments and assess packet forwarding behavior.
 
         Test:
@@ -183,7 +183,7 @@ def test_runtime_mtu_updating_and_forwarding(self) -> None:
             testpmd.stop()
 
     @func_test
-    def test_cli_mtu_forwarding_for_std_packets(self) -> None:
+    def cli_mtu_forwarding_for_std_packets(self) -> None:
         """Assesses packet forwarding of standard MTU packets after pre-runtime MTU adjustments.
 
         Test:
@@ -213,7 +213,7 @@ def test_cli_mtu_forwarding_for_std_packets(self) -> None:
             )
 
     @func_test
-    def test_cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:
+    def cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:
         """Assess packet forwarding of packets within the bounds of a pre-runtime MTU adjustment.
 
         Test:
@@ -239,7 +239,7 @@ def test_cli_jumbo_forwarding_for_jumbo_mtu(self) -> None:
             self.send_packet_and_verify(STANDARD_MTU + VENDOR_AGNOSTIC_PADDING, should_receive=True)
 
     @func_test
-    def test_cli_mtu_std_packets_for_jumbo_mtu(self) -> None:
+    def cli_mtu_std_packets_for_jumbo_mtu(self) -> None:
         """Assess boundary of jumbo MTU value set pre-runtime.
 
         Test:
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index bad243a571..ea710454ca 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -152,7 +152,7 @@ def _send_and_dump(
         return received_packets
 
     @func_test
-    def test_dumpcap(self) -> None:
+    def dumpcap(self) -> None:
         """Test dumpcap on Rx and Tx interfaces.
 
         Steps:
@@ -182,7 +182,7 @@ def test_dumpcap(self) -> None:
             )
 
     @func_test
-    def test_dumpcap_filter(self) -> None:
+    def dumpcap_filter(self) -> None:
         """Test the dumpcap filtering feature.
 
         Steps:
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
index 015163dd11..802777a697 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
@@ -131,13 +131,13 @@ def pmd_scatter(self, mb_size: int, enable_offload: bool = False) -> None:
 
     @requires(NicCapability.SCATTERED_RX_ENABLED)
     @func_test
-    def test_scatter_mbuf_2048(self) -> None:
+    def scatter_mbuf_2048(self) -> None:
         """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048."""
         self.pmd_scatter(mb_size=2048)
 
     @requires(NicCapability.RX_OFFLOAD_SCATTER)
     @func_test
-    def test_scatter_mbuf_2048_with_offload(self) -> None:
+    def scatter_mbuf_2048_with_offload(self) -> None:
         """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload."""
         self.pmd_scatter(mb_size=2048, enable_offload=True)
 
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index 58783f1d18..c5867617c0 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -52,7 +52,7 @@ def send_packets_and_verify(self) -> None:
         )
 
     @func_test
-    def test_start_ports(self) -> None:
+    def start_ports(self) -> None:
         """Start all ports and send a small number of packets.
 
         Steps:
@@ -69,7 +69,7 @@ def test_start_ports(self) -> None:
             self.send_packets_and_verify()
 
     @func_test
-    def test_stop_ports(self) -> None:
+    def stop_ports(self) -> None:
         """Stop all ports, then start all ports, amd then send a small number of packets.
 
         Steps:
@@ -92,7 +92,7 @@ def test_stop_ports(self) -> None:
             self.send_packets_and_verify()
 
     @func_test
-    def test_close_ports(self) -> None:
+    def close_ports(self) -> None:
         """Close all the ports via testpmd.
 
         Steps:
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_stats.py
index ddd28623b3..d05f799858 100644
--- a/dts/tests/TestSuite_port_stats.py
+++ b/dts/tests/TestSuite_port_stats.py
@@ -117,7 +117,7 @@ def extract_noise_information(
         return recv_noise_bytes, recv_noise_packets, sent_noise_bytes, num_sent_packets
 
     @func_test
-    def test_stats_updates(self) -> None:
+    def stats_updates(self) -> None:
         """Send a packet with a fixed length and verify port stats updated properly.
 
         Send a packet with a total length of `self.total_packet_len` and verify that the rx port
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_promisc_support.py
index 8a7a7efb57..a38c65ef4b 100644
--- a/dts/tests/TestSuite_promisc_support.py
+++ b/dts/tests/TestSuite_promisc_support.py
@@ -24,7 +24,7 @@ class TestPromiscSupport(TestSuite):
     ALTERNATIVE_MAC_ADDRESS: str = "02:00:00:00:00:00"
 
     @func_test
-    def test_promisc_packets(self) -> None:
+    def promisc_packets(self) -> None:
         """Verify that promiscuous mode works.
 
         Steps:
diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuite_queue_start_stop.py
index d739ddedfe..4ab5393656 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_start_stop.py
@@ -53,7 +53,7 @@ def send_packet_and_verify(self, should_receive: bool = True) -> None:
         )
 
     @func_test
-    def test_rx_queue_start_stop(self) -> None:
+    def rx_queue_start_stop(self) -> None:
         """Rx queue start stop test.
 
         Steps:
@@ -74,7 +74,7 @@ def test_rx_queue_start_stop(self) -> None:
             self.send_packet_and_verify(should_receive=True)
 
     @func_test
-    def test_tx_queue_start_stop(self) -> None:
+    def tx_queue_start_stop(self) -> None:
         """Tx queue start stop test.
 
         Steps:
@@ -95,7 +95,7 @@ def test_tx_queue_start_stop(self) -> None:
             self.send_packet_and_verify(should_receive=True)
 
     @func_test
-    def test_rx_queue_deferred_start(self) -> None:
+    def rx_queue_deferred_start(self) -> None:
         """Rx queue deferred start stop test.
 
         Steps:
@@ -120,7 +120,7 @@ def test_rx_queue_deferred_start(self) -> None:
             self.send_packet_and_verify(should_receive=True)
 
     @func_test
-    def test_tx_queue_deferred_start(self) -> None:
+    def tx_queue_deferred_start(self) -> None:
         """Tx queue start stop test.
 
         Steps:
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 4855e4261d..7b799ffcd1 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -217,7 +217,7 @@ def send_packet_and_verify_jump(
             self.verify(received, f"Expected packet was not received on queue {test_queue}")
 
     @func_test
-    def test_queue_action_ETH(self) -> None:
+    def queue_action_ETH(self) -> None:
         """Validate flow rules with queue actions and ethernet patterns.
 
         Steps:
@@ -259,7 +259,7 @@ def test_queue_action_ETH(self) -> None:
         )
 
     @func_test
-    def test_queue_action_IP(self) -> None:
+    def queue_action_IP(self) -> None:
         """Validate flow rules with queue actions and IPv4/IPv6 patterns.
 
         Steps:
@@ -318,7 +318,7 @@ def test_queue_action_IP(self) -> None:
 
     @requires(NicCapability.PHYSICAL_FUNCTION)
     @func_test
-    def test_queue_action_L4(self) -> None:
+    def queue_action_L4(self) -> None:
         """Validate flow rules with queue actions and TCP/UDP patterns.
 
         Steps:
@@ -374,7 +374,7 @@ def test_queue_action_L4(self) -> None:
         )
 
     @func_test
-    def test_queue_action_VLAN(self) -> None:
+    def queue_action_VLAN(self) -> None:
         """Validate flow rules with queue actions and VLAN patterns.
 
         Steps:
@@ -401,7 +401,7 @@ def test_queue_action_VLAN(self) -> None:
         )
 
     @func_test
-    def test_drop_action_ETH(self) -> None:
+    def drop_action_ETH(self) -> None:
         """Validate flow rules with drop actions and ethernet patterns.
 
         Steps:
@@ -446,7 +446,7 @@ def test_drop_action_ETH(self) -> None:
         )
 
     @func_test
-    def test_drop_action_IP(self) -> None:
+    def drop_action_IP(self) -> None:
         """Validate flow rules with drop actions and ethernet patterns.
 
         Steps:
@@ -501,7 +501,7 @@ def test_drop_action_IP(self) -> None:
         )
 
     @func_test
-    def test_drop_action_L4(self) -> None:
+    def drop_action_L4(self) -> None:
         """Validate flow rules with drop actions and ethernet patterns.
 
         Steps:
@@ -552,7 +552,7 @@ def test_drop_action_L4(self) -> None:
         )
 
     @func_test
-    def test_drop_action_VLAN(self) -> None:
+    def drop_action_VLAN(self) -> None:
         """Validate flow rules with drop actions and ethernet patterns.
 
         Steps:
@@ -591,7 +591,7 @@ def test_drop_action_VLAN(self) -> None:
         )
 
     @func_test
-    def test_modify_actions(self) -> None:
+    def modify_actions(self) -> None:
         """Validate flow rules with actions that modify that packet during transmission.
 
         Steps:
@@ -636,7 +636,7 @@ def test_modify_actions(self) -> None:
         )
 
     @func_test
-    def test_egress_rules(self) -> None:
+    def egress_rules(self) -> None:
         """Validate flow rules with egress directions.
 
         Steps:
@@ -681,7 +681,7 @@ def test_egress_rules(self) -> None:
         )
 
     @func_test
-    def test_jump_action(self) -> None:
+    def jump_action(self) -> None:
         """Validate flow rules with different group levels and jump actions.
 
         Steps:
@@ -736,7 +736,7 @@ def test_jump_action(self) -> None:
             )
 
     @func_test
-    def test_priority_attribute(self) -> None:
+    def priority_attribute(self) -> None:
         """Validate flow rules with queue actions and ethernet patterns.
 
         Steps:
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 5602b316c0..b572002808 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -50,7 +50,7 @@ def set_up_suite(self) -> None:
         self.nics_in_node = [p.config for p in self.topology.sut_ports]
 
     @func_test
-    def test_unit_tests(self) -> None:
+    def unit_tests(self) -> None:
         """DPDK meson ``fast-tests`` unit tests.
 
         Test that all unit test from the ``fast-tests`` suite pass.
@@ -67,7 +67,7 @@ def test_unit_tests(self) -> None:
         )
 
     @func_test
-    def test_driver_tests(self) -> None:
+    def driver_tests(self) -> None:
         """DPDK meson ``driver-tests`` unit tests.
 
         Test that all unit test from the ``driver-tests`` suite pass.
@@ -96,7 +96,7 @@ def test_driver_tests(self) -> None:
         )
 
     @func_test
-    def test_devices_listed_in_testpmd(self) -> None:
+    def devices_listed_in_testpmd(self) -> None:
         """Testpmd device discovery.
 
         Test that the devices configured in the test run configuration are found in testpmd.
@@ -114,7 +114,7 @@ def test_devices_listed_in_testpmd(self) -> None:
             )
 
     @func_test
-    def test_device_bound_to_driver(self) -> None:
+    def device_bound_to_driver(self) -> None:
         """Device driver in OS.
 
         Test that the devices configured in the test run configuration are bound to
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index 690c5d4fd1..7fdcfd9b6f 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -71,7 +71,7 @@ def setup_session(
             )
 
     @func_test
-    def test_l2_packet_detect(self) -> None:
+    def l2_packet_detect(self) -> None:
         """Ensure the correct flags are shown in verbose output when sending L2 packets.
 
         Steps:
@@ -90,7 +90,7 @@ def test_l2_packet_detect(self) -> None:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
 
     @func_test
-    def test_l3_l4_packet_detect(self) -> None:
+    def l3_l4_packet_detect(self) -> None:
         """Ensure correct flags are shown in the verbose output when sending IP/L4 packets.
 
         Steps:
@@ -123,7 +123,7 @@ def test_l3_l4_packet_detect(self) -> None:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
 
     @func_test
-    def test_ipv6_l4_packet_detect(self) -> None:
+    def ipv6_l4_packet_detect(self) -> None:
         """Ensure correct flags are shown in the verbose output when sending IPv6/L4 packets.
 
         Steps:
@@ -152,7 +152,7 @@ def test_ipv6_l4_packet_detect(self) -> None:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
 
     @func_test
-    def test_l3_tunnel_packet_detect(self) -> None:
+    def l3_tunnel_packet_detect(self) -> None:
         """Ensure correct flags are shown in the verbose output when sending IPv6/L4 packets.
 
         Steps:
@@ -187,7 +187,7 @@ def test_l3_tunnel_packet_detect(self) -> None:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
 
     @func_test
-    def test_gre_tunnel_packet_detect(self) -> None:
+    def gre_tunnel_packet_detect(self) -> None:
         """Ensure the correct flags are shown in the verbose output when sending GRE packets.
 
         Steps:
@@ -220,7 +220,7 @@ def test_gre_tunnel_packet_detect(self) -> None:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
 
     @func_test
-    def test_nsh_packet_detect(self) -> None:
+    def nsh_packet_detect(self) -> None:
         """Verify the correct flags are shown in the verbose output when sending NSH packets.
 
         Steps:
@@ -261,7 +261,7 @@ def test_nsh_packet_detect(self) -> None:
 
     @requires(NicCapability.PHYSICAL_FUNCTION)
     @func_test
-    def test_vxlan_tunnel_packet_detect(self) -> None:
+    def vxlan_tunnel_packet_detect(self) -> None:
         """Ensure the correct flags are shown in the verbose output when sending VXLAN packets.
 
         Steps:
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index d2a9e614d4..ed36a2950d 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -118,7 +118,7 @@ def vlan_setup(self, testpmd: TestPmdShell, port_id: int, filtered_id: int) -> N
         testpmd.rx_vlan(vlan=filtered_id, port=port_id, add=True)
 
     @func_test
-    def test_vlan_receipt_no_stripping(self) -> None:
+    def vlan_receipt_no_stripping(self) -> None:
         """Verify packets are received with their VLAN IDs when stripping is disabled.
 
         Test:
@@ -131,7 +131,7 @@ def test_vlan_receipt_no_stripping(self) -> None:
 
     @requires(NicCapability.RX_OFFLOAD_VLAN_STRIP)
     @func_test
-    def test_vlan_receipt_stripping(self) -> None:
+    def vlan_receipt_stripping(self) -> None:
         """Ensure VLAN packet received with no tag when receipts and header stripping are enabled.
 
         Test:
@@ -144,7 +144,7 @@ def test_vlan_receipt_stripping(self) -> None:
             self.send_vlan_packet_and_verify(should_receive=True, strip=True, vlan_id=1)
 
     @func_test
-    def test_vlan_no_receipt(self) -> None:
+    def vlan_no_receipt(self) -> None:
         """Ensure VLAN packet dropped when filter is on and sent tag not in the filter list.
 
         Test:
@@ -156,7 +156,7 @@ def test_vlan_no_receipt(self) -> None:
             self.send_vlan_packet_and_verify(should_receive=False, strip=False, vlan_id=2)
 
     @func_test
-    def test_vlan_header_insertion(self) -> None:
+    def vlan_header_insertion(self) -> None:
         """Ensure that VLAN packet is received with the correct inserted VLAN tag.
 
         Test:
-- 
2.50.1

