Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1018C3ABBF
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:31:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 553CA40663;
	Tue,  6 May 2025 15:31:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 78E9E40659
 for <dev@dpdk.org>; Tue,  6 May 2025 15:31:14 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 384811007;
 Tue,  6 May 2025 06:31:04 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.25.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 088873F5A1;
 Tue,  6 May 2025 06:31:12 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Wilks <thomas.wilks@arm.com>, Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 3/3] dts: add packet capture test suite
Date: Tue,  6 May 2025 14:29:33 +0100
Message-ID: <20250506132933.1580584-4-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506132933.1580584-1-luca.vizzarro@arm.com>
References: <20250331155800.449823-1-thomas.wilks@arm.com>
 <20250506132933.1580584-1-luca.vizzarro@arm.com>
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

Add a test suite that tests the packet capture framework
through the use of dpdk-dumpcap.

Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 .../dts/tests.TestSuite_packet_capture.rst    |   8 +
 dts/tests/TestSuite_packet_capture.py         | 238 ++++++++++++++++++
 2 files changed, 246 insertions(+)
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
index 0000000000..67a3049b78
--- /dev/null
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -0,0 +1,238 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""Packet capture test suite.
+
+Test the DPDK packet capturing framework through the combined use of testpmd and dumpcap.
+"""
+
+from dataclasses import dataclass, field
+from pathlib import Path, PurePath
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
+from scapy.packet import Packet, Raw, raw
+from scapy.utils import rdpcap
+from typing_extensions import Self
+
+from framework.context import get_ctx
+from framework.params import Params
+from framework.remote_session.dpdk_shell import compute_eal_params
+from framework.remote_session.interactive_shell import InteractiveShell
+from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.settings import SETTINGS
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import requires
+from framework.testbed_model.cpu import LogicalCoreList
+from framework.testbed_model.os_session import FilePermissions
+from framework.testbed_model.topology import TopologyType
+from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
+    PacketFilteringConfig,
+)
+
+
+@dataclass(kw_only=True)
+class DumpcapParams(Params):
+    """Parameters for the dpdk-dumpcap app.
+
+    Attributes:
+        lcore_list: The list of logical cores to use.
+        file_prefix: The DPDK file prefix that the primary DPDK application is using.
+        interface: The PCI address of the interface to capture.
+        output_pcap_path: The path to the pcapng file to dump captured packets into.
+        packet_filter: A packet filter in libpcap filter syntax.
+    """
+
+    lcore_list: LogicalCoreList | None = field(default=None, metadata=Params.long("lcore"))
+    file_prefix: str | None = None
+    interface: str = field(metadata=Params.short("i"))
+    output_pcap_path: PurePath = field(metadata=Params.convert_value(str) | Params.short("w"))
+    packet_filter: str | None = field(default=None, metadata=Params.short("f"))
+
+
+class Dumpcap(InteractiveShell):
+    """Class to spawn and manage a dpdk-dumpcap process.
+
+    The dpdk-dumpcap is a DPDK app but instead of providing a regular DPDK EAL interface to the
+    user, it replicates the Wireshark dumpcap app.
+    """
+
+    _app_params: DumpcapParams
+
+    def __init__(self, params: DumpcapParams) -> None:
+        """Extends :meth:`~.interactive_shell.InteractiveShell.__init__`."""
+        self.ctx = get_ctx()
+        eal_params = compute_eal_params()
+        params.lcore_list = eal_params.lcore_list
+        params.file_prefix = eal_params.prefix
+
+        super().__init__(self.ctx.sut_node, name=None, privileged=True, app_params=params)
+
+    @property
+    def path(self) -> PurePath:
+        """Path to the shell executable."""
+        return PurePath(self.ctx.dpdk_build.remote_dpdk_build_dir).joinpath("app/dpdk-dumpcap")
+
+    def wait_until_ready(self) -> Self:
+        """Start app and wait until ready."""
+        self.start_application(f"Capturing on '{self._app_params.interface}'")
+        return self
+
+    def close(self) -> None:
+        """Close the application.
+
+        Sends a SIGINT to close the application.
+        """
+        self.send_command("\x03")
+        super().close()
+
+
+@requires(topology_type=TopologyType.two_links)
+class TestPacketCapture(TestSuite):
+    """Packet Capture TestSuite.
+
+    Attributes:
+        packets: List of packets to send for testing pdump.
+        rx_pcap_path: The remote path where to create the RX packets pcap with pdump.
+        tx_pcap_path: The remote path where to create the TX packets pcap with pdump.
+    """
+
+    packets: list[Packet]
+    rx_pcap_path: PurePath
+    tx_pcap_path: PurePath
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
+        self.tx_pcap_path = self._ctx.sut_node.tmp_dir.joinpath("tx.pcapng")
+        self.rx_pcap_path = self._ctx.sut_node.tmp_dir.joinpath("rx.pcapng")
+
+    def _load_pcap_packets(self, remote_pcap_path: PurePath) -> list[Packet]:
+        local_pcap_path = Path(SETTINGS.output_dir).joinpath(remote_pcap_path.name)
+        self._ctx.sut_node.main_session.copy_from(remote_pcap_path, local_pcap_path)
+        return list(rdpcap(str(local_pcap_path)))
+
+    def _send_and_dump(
+        self, packet_filter: str | None = None, rx_only: bool = False
+    ) -> list[Packet]:
+        dumpcap_rx = Dumpcap(
+            DumpcapParams(
+                interface=self.topology.sut_port_ingress.pci,
+                output_pcap_path=self.rx_pcap_path,
+                packet_filter=packet_filter,
+            )
+        ).wait_until_ready()
+        if not rx_only:
+            dumpcap_tx = Dumpcap(
+                DumpcapParams(
+                    interface=self.topology.sut_port_egress.pci,
+                    output_pcap_path=self.tx_pcap_path,
+                    packet_filter=packet_filter,
+                )
+            ).wait_until_ready()
+
+        received_packets = self.send_packets_and_capture(
+            self.packets, PacketFilteringConfig(no_lldp=False)
+        )
+
+        dumpcap_rx.close()
+        self._ctx.sut_node.main_session.change_permissions(
+            self.rx_pcap_path, FilePermissions(0o644)
+        )
+        if not rx_only:
+            dumpcap_tx.close()
+            self._ctx.sut_node.main_session.change_permissions(
+                self.tx_pcap_path, FilePermissions(0o644)
+            )
+
+        return received_packets
+
+    @func_test
+    def test_dumpcap(self) -> None:
+        """Test dumpcap on RX and TX interfaces.
+
+        Steps:
+            * Start up testpmd shell.
+            * Start up dpdk-dumpcap with the default values.
+            * Send packets.
+
+        Verify:
+            * The expected packets are the same as the RX packets.
+            * The TX packets are the same as the packets received from Scapy.
+        """
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received_packets = self._send_and_dump()
+
+            expected_packets = self.get_expected_packets(self.packets, sent_from_tg=True)
+            rx_pcap_packets = self._load_pcap_packets(self.rx_pcap_path)
+            self.verify(
+                self.match_all_packets(expected_packets, rx_pcap_packets, verify=False),
+                "RX packets from dumpcap weren't the same as the expected packets.",
+            )
+
+            tx_pcap_packets = self._load_pcap_packets(self.tx_pcap_path)
+            self.verify(
+                self.match_all_packets(tx_pcap_packets, received_packets, verify=False),
+                "TX packets from dumpcap weren't the same as the packets received by Scapy.",
+            )
+
+    @func_test
+    def test_dumpcap_filter(self) -> None:
+        """Test the dumpcap filtering feature.
+
+        Steps:
+            * Start up testpmd shell.
+            * Start up dpdk-dumpcap listening for TCP packets on the RX interface.
+            * Send packets.
+
+        Verify:
+            * The dumped packets did not contain any of the packets meant for filtering.
+        """
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            self._send_and_dump("tcp", rx_only=True)
+            filtered_packets = [
+                raw(p)
+                for p in self.get_expected_packets(self.packets, sent_from_tg=True)
+                if not p.haslayer(TCP)
+            ]
+
+            rx_pcap_packets = [raw(p) for p in self._load_pcap_packets(self.rx_pcap_path)]
+            for filtered_packet in filtered_packets:
+                self.verify(
+                    filtered_packet not in rx_pcap_packets,
+                    "Found a packet in the pcap that was meant to be filtered out.",
+                )
-- 
2.43.0

