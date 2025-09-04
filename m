Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D21CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 11:47:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BB6642670;
	Thu,  4 Sep 2025 13:47:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id BB2F241140
 for <dev@dpdk.org>; Thu,  4 Sep 2025 13:47:18 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53571756;
 Thu,  4 Sep 2025 04:47:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.57.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 985513F6A8;
 Thu,  4 Sep 2025 04:47:17 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 6/7] dts: use artifacts in packet capture and softnic
Date: Thu,  4 Sep 2025 12:45:06 +0100
Message-ID: <20250904114653.199080-7-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904114653.199080-1-luca.vizzarro@arm.com>
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250904114653.199080-1-luca.vizzarro@arm.com>
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

Use the newly added artifact/file manager in the packet capture and
softnic test suites.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/tests/TestSuite_packet_capture.py | 73 ++++++++++----------
 dts/tests/TestSuite_softnic.py        | 95 +++++++++++----------------
 2 files changed, 74 insertions(+), 94 deletions(-)

diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index ea710454ca..e492d4d1f2 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -7,7 +7,7 @@
 """
 
 from dataclasses import dataclass, field
-from pathlib import Path, PurePath
+from pathlib import PurePath
 
 from scapy.contrib.lldp import (
     LLDPDUChassisID,
@@ -29,11 +29,10 @@
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.remote_session.testpmd_shell import TestPmdShell
-from framework.settings import SETTINGS
 from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.artifact import Artifact
 from framework.testbed_model.capability import requires
 from framework.testbed_model.cpu import LogicalCoreList
-from framework.testbed_model.os_session import FilePermissions
 from framework.testbed_model.topology import TopologyType
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
@@ -65,13 +64,13 @@ class TestPacketCapture(TestSuite):
 
     Attributes:
         packets: List of packets to send for testing dumpcap.
-        rx_pcap_path: The remote path where to create the Rx packets pcap with dumpcap.
-        tx_pcap_path: The remote path where to create the Tx packets pcap with dumpcap.
+        rx_pcap: The artifact associated with the Rx packets pcap created by dumpcap.
+        tx_pcap: The artifact associated with the Tx packets pcap created by dumpcap.
     """
 
     packets: list[Packet]
-    rx_pcap_path: PurePath
-    tx_pcap_path: PurePath
+    rx_pcap: Artifact
+    tx_pcap: Artifact
 
     def _run_dumpcap(self, params: DumpcapParams) -> BlockingApp:
         eal_params = compute_eal_params()
@@ -108,29 +107,32 @@ def set_up_suite(self) -> None:
             / LLDPDUSystemCapabilities()
             / LLDPDUEndOfLLDPDU(),
         ]
-        self.tx_pcap_path = self._ctx.sut_node.tmp_dir.joinpath("tx.pcapng")
-        self.rx_pcap_path = self._ctx.sut_node.tmp_dir.joinpath("rx.pcapng")
 
-    def _load_pcap_packets(self, remote_pcap_path: PurePath) -> list[Packet]:
-        local_pcap_path = Path(SETTINGS.output_dir).joinpath(remote_pcap_path.name)
-        self._ctx.sut_node.main_session.copy_from(remote_pcap_path, local_pcap_path)
-        return list(rdpcap(str(local_pcap_path)))
+    def set_up_test_case(self):
+        """Test case setup.
+
+        Prepare the artifacts for the Rx and Tx pcap files.
+        """
+        self.tx_pcap = Artifact("sut", "tx.pcapng")
+        self.rx_pcap = Artifact("sut", "rx.pcapng")
 
     def _send_and_dump(
         self, packet_filter: str | None = None, rx_only: bool = False
     ) -> list[Packet]:
+        self.rx_pcap.touch()
         dumpcap_rx = self._run_dumpcap(
             DumpcapParams(
                 interface=self.topology.sut_port_ingress.pci,
-                output_pcap_path=self.rx_pcap_path,
+                output_pcap_path=self.rx_pcap.path,
                 packet_filter=packet_filter,
             )
         )
         if not rx_only:
+            self.tx_pcap.touch()
             dumpcap_tx = self._run_dumpcap(
                 DumpcapParams(
                     interface=self.topology.sut_port_egress.pci,
-                    output_pcap_path=self.tx_pcap_path,
+                    output_pcap_path=self.tx_pcap.path,
                     packet_filter=packet_filter,
                 )
             )
@@ -140,14 +142,8 @@ def _send_and_dump(
         )
 
         dumpcap_rx.close()
-        self._ctx.sut_node.main_session.change_permissions(
-            self.rx_pcap_path, FilePermissions(0o644)
-        )
         if not rx_only:
             dumpcap_tx.close()
-            self._ctx.sut_node.main_session.change_permissions(
-                self.tx_pcap_path, FilePermissions(0o644)
-            )
 
         return received_packets
 
@@ -169,17 +165,19 @@ def dumpcap(self) -> None:
             received_packets = self._send_and_dump()
 
             expected_packets = self.get_expected_packets(self.packets, sent_from_tg=True)
-            rx_pcap_packets = self._load_pcap_packets(self.rx_pcap_path)
-            self.verify(
-                self.match_all_packets(expected_packets, rx_pcap_packets, verify=False),
-                "Rx packets from dumpcap weren't the same as the expected packets.",
-            )
+            with self.rx_pcap.open() as fd:
+                rx_pcap_packets = list(rdpcap(fd))
+                self.verify(
+                    self.match_all_packets(expected_packets, rx_pcap_packets, verify=False),
+                    "Rx packets from dumpcap weren't the same as the expected packets.",
+                )
 
-            tx_pcap_packets = self._load_pcap_packets(self.tx_pcap_path)
-            self.verify(
-                self.match_all_packets(tx_pcap_packets, received_packets, verify=False),
-                "Tx packets from dumpcap weren't the same as the packets received by Scapy.",
-            )
+            with self.tx_pcap.open() as fd:
+                tx_pcap_packets = list(rdpcap(fd))
+                self.verify(
+                    self.match_all_packets(tx_pcap_packets, received_packets, verify=False),
+                    "Tx packets from dumpcap weren't the same as the packets received by Scapy.",
+                )
 
     @func_test
     def dumpcap_filter(self) -> None:
@@ -202,9 +200,10 @@ def dumpcap_filter(self) -> None:
                 if not p.haslayer(TCP)
             ]
 
-            rx_pcap_packets = [raw(p) for p in self._load_pcap_packets(self.rx_pcap_path)]
-            for filtered_packet in filtered_packets:
-                self.verify(
-                    filtered_packet not in rx_pcap_packets,
-                    "Found a packet in the pcap that was meant to be filtered out.",
-                )
+            with self.rx_pcap.open() as fd:
+                rx_pcap_packets = [raw(p) for p in rdpcap(fd)]
+                for filtered_packet in filtered_packets:
+                    self.verify(
+                        filtered_packet not in rx_pcap_packets,
+                        "Found a packet in the pcap that was meant to be filtered out.",
+                    )
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index 27754c08e7..edeca55f32 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -6,11 +6,10 @@
 Create a softnic virtual device and verify it successfully forwards packets.
 """
 
-from pathlib import Path, PurePath
-
 from framework.params.testpmd import EthPeer
 from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.artifact import Artifact
 from framework.testbed_model.capability import requires
 from framework.testbed_model.topology import TopologyType
 from framework.testbed_model.virtual_device import VirtualDevice
@@ -35,62 +34,44 @@ def set_up_suite(self) -> None:
         """
         self.sut_node = self._ctx.sut_node  # FIXME: accessing the context should be forbidden
         self.packets = generate_random_packets(self.NUMBER_OF_PACKETS_TO_SEND, self.PAYLOAD_SIZE)
-        self.cli_file = self.prepare_softnic_files()
-
-    def prepare_softnic_files(self) -> PurePath:
-        """Creates the config files that are required for the creation of the softnic.
-
-        The config files are created at runtime to accommodate paths and device addresses.
-        """
-        # paths of files needed by softnic
-        cli_file = Path("rx_tx.cli")
-        spec_file = Path("rx_tx.spec")
-        rx_tx_1_file = Path("rx_tx_1.io")
-        rx_tx_2_file = Path("rx_tx_2.io")
-        path_sut = self._ctx.sut_node.tmp_dir
-        cli_file_sut = self.sut_node.main_session.join_remote_path(path_sut, cli_file)
-        spec_file_sut = self.sut_node.main_session.join_remote_path(path_sut, spec_file)
-        rx_tx_1_file_sut = self.sut_node.main_session.join_remote_path(path_sut, rx_tx_1_file)
-        rx_tx_2_file_sut = self.sut_node.main_session.join_remote_path(path_sut, rx_tx_2_file)
-        firmware_c_file_sut = self.sut_node.main_session.join_remote_path(path_sut, "firmware.c")
-        firmware_so_file_sut = self.sut_node.main_session.join_remote_path(path_sut, "firmware.so")
-
-        # write correct remote paths to local files
-        with open(cli_file, "w+") as fh:
-            fh.write(f"pipeline codegen {spec_file_sut} {firmware_c_file_sut}\n")
-            fh.write(f"pipeline libbuild {firmware_c_file_sut} {firmware_so_file_sut}\n")
-            fh.write(f"pipeline RX build lib {firmware_so_file_sut} io {rx_tx_1_file_sut} numa 0\n")
-            fh.write(f"pipeline TX build lib {firmware_so_file_sut} io {rx_tx_2_file_sut} numa 0\n")
-            fh.write("thread 2 pipeline RX enable\n")
-            fh.write("thread 2 pipeline TX enable\n")
-        with open(spec_file, "w+") as fh:
-            fh.write("struct metadata_t {{\n")
-            fh.write("	bit<32> port\n")
-            fh.write("}}\n")
-            fh.write("metadata instanceof metadata_t\n")
-            fh.write("apply {{\n")
-            fh.write("	rx m.port\n")
-            fh.write("	tx m.port\n")
-            fh.write("}}\n")
-        with open(rx_tx_1_file, "w+") as fh:
-            fh.write(f"port in 0 ethdev {self.sut_node.config.ports[0].pci} rxq 0 bsz 32\n")
-            fh.write("port out 0 ring RXQ0 bsz 32\n")
-        with open(rx_tx_2_file, "w+") as fh:
-            fh.write("port in 0 ring TXQ0 bsz 32\n")
-            fh.write(f"port out 1 ethdev {self.sut_node.config.ports[1].pci} txq 0 bsz 32\n")
-
-        # copy files over to SUT
-        self.sut_node.main_session.copy_to(cli_file, cli_file_sut)
-        self.sut_node.main_session.copy_to(spec_file, spec_file_sut)
-        self.sut_node.main_session.copy_to(rx_tx_1_file, rx_tx_1_file_sut)
-        self.sut_node.main_session.copy_to(rx_tx_2_file, rx_tx_2_file_sut)
-        # and cleanup local files
-        cli_file.unlink()
-        spec_file.unlink()
-        rx_tx_1_file.unlink()
-        rx_tx_2_file.unlink()
 
-        return cli_file_sut
+        self.cli_file = Artifact("sut", "rx_tx.cli")
+        self.spec_file = Artifact("sut", "rx_tx.spec")
+        self.rx_tx_1_file = Artifact("sut", "rx_tx_1.io")
+        self.rx_tx_2_file = Artifact("sut", "rx_tx_2.io")
+        self.firmware_c_file = Artifact("sut", "firmware.c")
+        self.firmware_so_file = Artifact("sut", "firmware.so")
+
+        with self.cli_file.open("w+") as fh:
+            fh.write(
+                f"pipeline codegen {self.spec_file} {self.firmware_c_file}\n"
+                f"pipeline libbuild {self.firmware_c_file} {self.firmware_so_file}\n"
+                f"pipeline RX build lib {self.firmware_so_file} io {self.rx_tx_1_file} numa 0\n"
+                f"pipeline TX build lib {self.firmware_so_file} io {self.rx_tx_2_file} numa 0\n"
+                "thread 2 pipeline RX enable\n"
+                "thread 2 pipeline TX enable\n"
+            )
+        with self.spec_file.open("w+") as fh:
+            fh.write(
+                "struct metadata_t {\n"
+                "	bit<32> port\n"
+                "}\n"
+                "metadata instanceof metadata_t\n"
+                "apply {\n"
+                "	rx m.port\n"
+                "	tx m.port\n"
+                "}\n"
+            )
+        with self.rx_tx_1_file.open("w+") as fh:
+            fh.write(
+                f"port in 0 ethdev {self.sut_node.config.ports[0].pci} rxq 0 bsz 32\n"
+                "port out 0 ring RXQ0 bsz 32\n"
+            )
+        with self.rx_tx_2_file.open("w+") as fh:
+            fh.write(
+                "port in 0 ring TXQ0 bsz 32\n"
+                f"port out 1 ethdev {self.sut_node.config.ports[1].pci} txq 0 bsz 32\n"
+            )
 
     @func_test
     def softnic(self) -> None:
-- 
2.43.0

