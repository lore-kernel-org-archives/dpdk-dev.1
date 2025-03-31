Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EB9C36013
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 15:58:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6BB1406B4;
	Mon, 31 Mar 2025 17:58:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B5FB940689
 for <dev@dpdk.org>; Mon, 31 Mar 2025 17:58:13 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0E61764;
 Mon, 31 Mar 2025 08:58:16 -0700 (PDT)
Received: from e132991.cambridge.arm.com (e132991.arm.com [10.1.39.18])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 535A53F63F;
 Mon, 31 Mar 2025 08:58:12 -0700 (PDT)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Thomas Wilks <thomas.wilks@arm.com>
Subject: [PATCH 1/2] dts: add packet capture test suite
Date: Mon, 31 Mar 2025 16:57:59 +0100
Message-ID: <20250331155800.449823-2-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331155800.449823-1-thomas.wilks@arm.com>
References: <20250331155800.449823-1-thomas.wilks@arm.com>
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

Add a test suite that tests the packet capture framework
through the use of dpdk-pdump.

Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 .../dts/tests.TestSuite_packet_capture.rst    |   8 +
 dts/tests/TestSuite_packet_capture.py         | 358 ++++++++++++++++++
 2 files changed, 366 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_packet_capture.rst
 create mode 100644 dts/tests/TestSuite_packet_capture.py

diff --git a/doc/api/dts/tests.TestSuite_packet_capture.rst b/doc/api/dts/tests.TestSuite_packet_capture.rst
new file mode 100644
index 0000000000..3d760d3ae4
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_packet_capture.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+packet_capture Test Suite
+=========================
+
+.. automodule:: tests.TestSuite_packet_capture
+   :members:
+   :show-inheritance:
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
new file mode 100644
index 0000000000..bdc3d008a3
--- /dev/null
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -0,0 +1,358 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""Packet capture TestSuite.
+
+Tests pdump by sending packets, changing the arguments of pdump
+and verifying the received packets.
+"""
+
+from dataclasses import asdict, dataclass
+from pathlib import Path, PurePath
+from random import randint
+from typing import Union
+
+from scapy.contrib.lldp import (
+    LLDPDUChassisID,
+    LLDPDUEndOfLLDPDU,
+    LLDPDUPortID,
+    LLDPDUSystemCapabilities,
+    LLDPDUSystemDescription,
+    LLDPDUSystemName,
+    LLDPDUTimeToLive,
+)
+from scapy.layers.inet import IP, TCP, UDP
+from scapy.layers.inet6 import IPv6
+from scapy.layers.l2 import Dot1Q, Ether
+from scapy.layers.sctp import SCTP
+from scapy.packet import Packet, Raw
+from scapy.utils import rdpcap
+from typing_extensions import Literal
+
+from framework.params.eal import EalParams
+from framework.params.testpmd import PortTopology
+from framework.remote_session.dpdk_app import BlockingDPDKApp
+from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.settings import SETTINGS
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
+    PacketFilteringConfig,
+)
+
+
+@dataclass(order=True, kw_only=True)
+class PdumpParameters:
+    """Parameters for --pdump.
+
+    Attributes:
+        device_id: The PCIE address of the device to capture packets.
+        port: The port id of the device to capture packets.
+        queue: The ID of the RX and TX queue.
+        tx_dev: The path or iface that the TX packets captured on TX will be outputted at.
+        rx_dev: The path or iface that the RX packets captured on RX will be outputted at.
+        ring_size: The size of the ring.
+        mbuf_size: The size of the mbuf data.
+        total_num_mbufs: Total number of the mbufs in the memory pool.
+    """
+
+    device_id: str | None = None
+    port: int | None = None
+    queue: Union[int, Literal["*"]] = "*"
+    tx_dev: PurePath | str | None = None
+    rx_dev: PurePath | str | None = None
+    ring_size: int | None = None
+    mbuf_size: int | None = None
+    total_num_mbufs: int | None = None
+
+    def __str__(self) -> str:
+        """Parameters as string for --pdump.
+
+        Returns:
+            String of the pdump commands
+        """
+
+        def pair_to_str(field, value):
+            if field != "device_id":
+                field = field.replace("_", "-")
+            return f"{field}={value}"
+
+        arg = ",".join(
+            [
+                pair_to_str(field, value)
+                for field, value in asdict(self).items()
+                if value is not None
+            ]
+        )
+
+        return arg
+
+
+class TestPacketCapture(TestSuite):
+    """Packet Capture TestSuite.
+
+    Attributes:
+        packets: List of packets to send for testing pdump.
+        rx_pcap_path: The remote path where to create the RX packets pcap with pdump.
+        tx_pcap_path: The remote path where to create the TX packets pcap with pdump.
+        pdump_params: The list of pdump parameters.
+    """
+
+    packets: list[Packet]
+    rx_pcap_path: PurePath
+    tx_pcap_path: PurePath
+    pdump_params: list[PdumpParameters]
+
+    def set_up_suite(self) -> None:
+        """Test suite setup.
+
+        Prepare the packets, file paths and queue range to be used in the test suite.
+        """
+        self.packets = [
+            Ether() / IP() / Raw(b"\0" * 60),
+            Ether() / IP() / TCP() / Raw(b"\0" * 60),
+            Ether() / IP() / UDP() / Raw(b"\0" * 60),
+            Ether() / IP() / SCTP() / Raw(b"\0" * 40),
+            Ether() / IPv6() / TCP() / Raw(b"\0" * 60),
+            Ether() / IPv6() / UDP() / Raw(b"\0" * 60),
+            Ether() / IP() / IPv6() / SCTP() / Raw(b"\0" * 40),
+            Ether() / Dot1Q() / IP() / UDP() / Raw(b"\0" * 40),
+            Ether(dst="FF:FF:FF:FF:FF:FF", type=0x88F7) / Raw(b"\0" * 60),
+            Ether(type=0x88CC)
+            / LLDPDUChassisID(subtype=4, id=self.topology.tg_port_egress.mac_address)
+            / LLDPDUPortID(subtype=5, id="Test Id")
+            / LLDPDUTimeToLive(ttl=180)
+            / LLDPDUSystemName(system_name="DTS Test sys")
+            / LLDPDUSystemDescription(description="DTS Test Packet")
+            / LLDPDUSystemCapabilities()
+            / LLDPDUEndOfLLDPDU(),
+        ]
+        self.tx_pcap_path = self._ctx.sut_node.tmp_dir.joinpath("tx.pcap")
+        self.rx_pcap_path = self._ctx.sut_node.tmp_dir.joinpath("rx.pcap")
+
+    def set_up_test_case(self) -> None:
+        """Set up test case.
+
+        Prepare default pdump parameters.
+        """
+        self.pdump_params = [
+            PdumpParameters(
+                device_id=self.topology.sut_port_ingress.pci,
+                rx_dev=self.rx_pcap_path,
+            ),
+            PdumpParameters(
+                device_id=self.topology.sut_port_egress.pci,
+                tx_dev=self.tx_pcap_path,
+            ),
+        ]
+
+    def _load_pcap_packets(self, remote_pcap_path: PurePath) -> list[Packet]:
+        local_pcap_path = Path(SETTINGS.output_dir).joinpath(remote_pcap_path.name)
+        self._ctx.sut_node.main_session.copy_from(remote_pcap_path, local_pcap_path)
+        return list(rdpcap(str(local_pcap_path)))
+
+    def _verify_packets(self, received_packets: list[Packet]) -> None:
+        expected_packets = self.get_expected_packets(self.packets, sent_from_tg=True)
+        rx_pcap_packets = self._load_pcap_packets(self.rx_pcap_path)
+        self.verify(
+            self.match_all_packets(expected_packets, rx_pcap_packets, verify=False),
+            "RX packet from pdump wasn't the same as the packet from Scapy.",
+        )
+
+        tx_pcap_packets = self._load_pcap_packets(self.tx_pcap_path)
+        self.verify(
+            self.match_all_packets(tx_pcap_packets, received_packets, verify=False),
+            "TX packet from pdump wasn't the same as the expected packet.",
+        )
+
+    def _start_pdump(
+        self,
+        pdump_params: list[PdumpParameters],
+        eal_params: EalParams | None = None,
+    ) -> BlockingDPDKApp:
+        if eal_params is None:
+            eal_params = EalParams()
+
+        eal_params.append_str(" ".join([f'--pdump "{param}"' for param in pdump_params]))
+
+        pdump = BlockingDPDKApp(PurePath("app/dpdk-pdump"), app_params=eal_params)
+        pdump.wait_until_ready(
+            "queue 65535" if pdump_params[0].queue == "*" else f"queue {pdump_params[0].queue}"
+        )
+        return pdump
+
+    def _start_pdump_and_verify_packets(self) -> None:
+        pdump = self._start_pdump(self.pdump_params)
+        received_packets = self.send_packets_and_capture(
+            self.packets, PacketFilteringConfig(no_lldp=False)
+        )
+        pdump.close()
+        self._verify_packets(received_packets)
+
+    @func_test
+    def test_pdump_device_id(self) -> None:
+        """Test pdump device id.
+
+        Steps:
+            Start up TestPMD Shell.
+            Boot up Pdump with the default values.
+            Send packets.
+
+        Verify:
+            Verify the expected packets are the same as the RX packets.
+            Verify the TX packets are the same as the packets received from Scapy.
+        """
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            self._start_pdump_and_verify_packets()
+
+    @func_test
+    def test_pdump_port(self) -> None:
+        """Test pdump port.
+
+        Steps:
+            Start up TestPMD Shell.
+            Boot up Pdump specifying port numbers instead of device ids.
+            Send packets.
+
+        Verify:
+            Verify the expected packets are the same as the RX packets.
+            Verify the TX packets are the same as the packets received from Scapy.
+        """
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+
+            self.pdump_params[0].port = 0
+            self.pdump_params[0].device_id = None
+            self.pdump_params[1].port = 1
+            self.pdump_params[1].device_id = None
+
+            self._start_pdump_and_verify_packets()
+
+    @func_test
+    def test_pdump_queue(self) -> None:
+        """Test pdump queue.
+
+        Steps:
+            Start up TestPMD Shell.
+            Boot up Pdump specifying queue 0 instead of the default queue value.
+            Send packets.
+
+        Verify:
+            Verify the expected packets are the same as the RX packets.
+            Verify the TX packets are the same as the packets received from Scapy.
+        """
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+
+            self.pdump_params[0].queue = 0
+            self.pdump_params[1].queue = 0
+
+            self._start_pdump_and_verify_packets()
+
+    @func_test
+    def test_pdump_dev_iface(self) -> None:
+        """Test pdump dev iface.
+
+        Dump RX packets to the link that scapy is capturing packets on.
+
+        Steps:
+            Switch the SUT egress port driver to the kernel driver and bring up the device.
+            Start up TestPMD Shell with loop port topology.
+            Boot up Pdump with the SUT port egress logical name instead of the pcap file.
+            Send packet and capture.
+
+        Verify:
+            Verify the expected packets are the same as the packets received by Scapy.
+        """
+        try:
+            self._ctx.dpdk.bind_ports_to_driver(self.topology.sut_ports[1:], for_dpdk=False)
+            self._ctx.sut_node.main_session.bring_up_link(self.topology.sut_ports[1:])
+
+            with TestPmdShell(
+                allowed_ports=self.topology.sut_ports[:1], port_topology=PortTopology.loop
+            ) as testpmd:
+                testpmd.start()
+
+                pdump = self._start_pdump(
+                    eal_params=EalParams(allowed_ports=self.topology.sut_ports[:1]),
+                    pdump_params=[
+                        PdumpParameters(
+                            device_id=self.topology.sut_port_ingress.pci,
+                            rx_dev=self.topology.sut_port_egress.logical_name,
+                        ),
+                    ],
+                )
+                received_packets = self.send_packets_and_capture(
+                    self.packets, PacketFilteringConfig(no_lldp=False)
+                )
+                pdump.close()
+
+                self.match_all_packets(
+                    self.get_expected_packets(self.packets, sent_from_tg=True), received_packets
+                )
+        finally:
+            self._ctx.dpdk.bind_ports_to_driver(self.topology.sut_ports[1:], for_dpdk=True)
+
+    @func_test
+    def test_pdump_ring_size(self) -> None:
+        """Test pdump mbuf size.
+
+        Steps:
+            Start up TestPMD Shell.
+            Boot up Pdump with a custom ring size of 1024.
+            Send packets.
+
+        Verify:
+            Verify the expected packets are the same as the RX packets.
+            Verify the TX packets are the same as the packets received from Scapy.
+        """
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+
+            self.pdump_params[0].ring_size = 1024
+            self.pdump_params[1].ring_size = 1024
+
+            self._start_pdump_and_verify_packets()
+
+    @func_test
+    def test_pdump_mbuf_size(self) -> None:
+        """Test pdump total num mbufs.
+
+        Steps:
+            Start up TestPMD Shell.
+            Boot up Pdump with a custom mbuf size of 2048.
+            Send packets.
+
+        Verify:
+            Verify the expected packets are the same as the RX packets.
+            Verify the TX packets are the same as the packets received from Scapy.
+        """
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+
+            self.pdump_params[0].mbuf_size = 2048
+            self.pdump_params[1].mbuf_size = 2048
+
+            self._start_pdump_and_verify_packets()
+
+    @func_test
+    def test_pdump_total_num_mbufs(self) -> None:
+        """Test pdump total num mbufs.
+
+        Steps:
+            Start up TestPMD Shell.
+            Boot up Pdump with a custom total num mbufs value chosen at random from 1025 to 65535.
+            Send packets.
+
+        Verify:
+            Verify the expected packets are the same as the RX packets.
+            Verify the TX packets are the same as the packets received from Scapy.
+        """
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+
+            total_num_mbufs = randint(1025, 65535)
+            self.pdump_params[0].total_num_mbufs = total_num_mbufs
+            self.pdump_params[1].total_num_mbufs = total_num_mbufs
+
+            self._start_pdump_and_verify_packets()
-- 
2.43.0

