Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CAACD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:51:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67EC740A80;
	Tue,  2 Jun 2026 23:51:00 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 99BB340A7F
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:50:59 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id 1C1F81D00060;
 Tue,  2 Jun 2026 17:50:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Tue, 02 Jun 2026 17:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780437058; x=
 1780523458; bh=zGHsZLByrdaKA4eSE1d3rOYOXowJONqm5m0ltrI5yDs=; b=r
 f1MwN+mQMMhNVwkWQlcXUUGiJ4w5coKKQsoVOVvUMRBq2XEqKGStH3HyBxOcxWrP
 gC009sPU4uLOCEx1p/lb7oJ28eHbuGWhNBFi6cUQH+zK5XEyPBlvSBGgiauJCV/Q
 LnraT1gXCWroZmRqzriA0DbUMdA/mC7fuj/c63T29JBhiRg4/FgQUJLLNMme/6+y
 FpMADXIpSZZu9GN32cWD3nJ29XIsAeruGSAyUMa2EigeK6d9i75ioBeIlGEZoiMO
 9H5ROOJsEn1sLqFjYOahB3s7tDJu6+nVVAPi9WnN2L8OJerKiyBSqtwAORYzZFuu
 Nlksn9nChAF/R+V34l5aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780437058; x=1780523458; bh=z
 GHsZLByrdaKA4eSE1d3rOYOXowJONqm5m0ltrI5yDs=; b=ZvtwPx1Pvl6tetT0Y
 JSe+8lhrgu+DZBua1Y0OfYNFwZWzZHbdgfulaEHd5lGsI8RosP2Lpu9ISNplKu1N
 tn2rNHiSR/+ducF1Dosr+Al/hyEjMGijDJk0sGUygmqbNmmZFkWnM5o/8efBI7dk
 Vn3W9Kv82IdyOb1CxSq422HPgj66uFHQEDJcws+hSMGn/TEo+z7jkpvGibo2uOUp
 Rey15Sdg0bZ5PB/VKMmp9xfBbDL87axKHrtjkkm/M5HizfyUN1i8Neee96V/Ox3/
 KzDLB89DteBoP23zIjg/JmkT1auVdd7iHC+N1OPc2MTZnzLgsLb6KlSDGn9WrjhM
 TD4LQ==
X-ME-Sender: <xms:QlAfap-5s9HqdvXeAhEhs_8Hc1QgYy5KYYL8ltSJiKsrQ29htW61UA>
 <xme:QlAfat1jcM3ltds4KnCWHP_IBNj3CabeMVB-5PFLSFcrVTSK7C4io8LdaByX8Ifnu
 m8L2ixKFGgxkRZcngWohllaofQ4NlRrG-Ht2PHv4MfDLbZoW34T4A>
X-ME-Received: <xmr:QlAfau8cIpbc3Vu2aDluk2puzVejOZFam14xqA72D4yEXCoD-LHa1YCFQ8Ia0msRVXQ8wQFD8T2b-R6fD5nuuKh-g2ja5qY>
X-ME-Proxy-Cause: dmFkZTE7XNncrevea7iWf/xwYGgeYH2JRW5bnMLX9iqqC1QOqCQbn+3CvT//eFEnNb5MKM
 pAg+1ZeY/VpaG+C3lLv0wpr3UR4oDT1Z3oG9O/w8LfQTiBzy26zQBeBGdsFfL6YeGNTJPf
 V/a68yHO0XB9O0gvpERYVivKDAU9PFNNU0BnZgdetglAEGvI5hdUfEyERyUdE6zre6RVHA
 pkm/wfOyKJfUd/zzMchO7Ki8eIxl3rya8/ZUD4mbHiWgpxRZCVb0CEfuTp2wlh70WfOXMz
 HBOpe0Boel/wzfznRhNE5ur5GBVhiEWRhf9G4HaREkLQJ0/hDAT66PM0Pryfp9+zMB1Tk8
 ChSyc+ukuP0ZHrm6+KO8i+0mX9cjGTFpvSPUoj9LbqO+v8WklDFRaVw/ZSXSdDW6otX3Kt
 iQMfZTt1j7j+XQLlO/M8MiaxwrqxbF8oiAKYSQVt40MMjYAQ39n5S584Sgh8Q/eUH5frYg
 RgYjq4BnV7+Z9zYs+Xe1rFJsui0Vkko1C9iVXdz75IOt3N5dPhL8fymcOqx9i6TFc3XoZW
 PlKIOZr7LDAmJ30ow9ItVQhxyikAFOkJBAjnhLgtpFLRaXRCzabLb9DoTjf9KPs4W0Wy93
 SadsRwhY5wCTcGj68hdHHLPIEgbE6pNAa1hPqZn8ekW9R3jKdO24KxAtKOaA
X-ME-Proxy: <xmx:QlAfalvMB-Tj-mqm49KqpSU9pNLbM8dtaL3WYZcNRBZqjHklx5LC7A>
 <xmx:QlAfapDSudTLF0CzDEft1YKrIZNnGPu7b9_tGFObCszkRPxVieqSEA>
 <xmx:QlAfalUVLFxrd0byISBdEIZkCiavxUKtkbcjPiVoNd6I-Rf_SDtYpg>
 <xmx:QlAfavCojOeboYOk9H3E0_jZFO-a8szc6j1YtxFUHdmON-g6ViSRmA>
 <xmx:QlAfakLdqZtJSDgNhmlGgpwXzZDdidjnoX_bFfqVthPZP0SmRiHrOSUp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:50:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: [PATCH v6 10/10] dts: add selective Rx tests
Date: Tue,  2 Jun 2026 23:49:22 +0200
Message-ID: <20260602215022.3698662-11-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602215022.3698662-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602215022.3698662-1-thomas@monjalon.net>
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

Add TestSuite_rx_split with 7 test cases:
- 3 positive: headers only, payload only, two non-contiguous segments
- 4 negative: missing offload flag, out-of-range, overlap, all-discard

Add selective Rx capability detection via testpmd "show port info".

The test suite could be completed later for the basic buffer split
configuration based on offsets or protocols.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 dts/api/capabilities.py                   |   2 +
 dts/api/testpmd/__init__.py               |  17 ++
 dts/api/testpmd/types.py                  |   6 +
 dts/framework/testbed_model/capability.py |   2 +
 dts/tests/TestSuite_rx_split.py           | 262 ++++++++++++++++++++++
 5 files changed, 289 insertions(+)
 create mode 100644 dts/tests/TestSuite_rx_split.py

diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 09bc538523..b0c1d81d36 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -136,6 +136,8 @@ class NicCapability(IntEnum):
     #: Device supports all VLAN capabilities.
     PORT_RX_OFFLOAD_VLAN = auto()
     QUEUE_RX_OFFLOAD_VLAN = auto()
+    #: Device supports selective Rx.
+    SELECTIVE_RX = auto()
     #: Device supports Rx queue setup after device started.
     RUNTIME_RX_QUEUE_SETUP = auto()
     #: Device supports Tx queue setup after device started.
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index e9187440bb..6973a64573 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -1409,6 +1409,23 @@ def get_capabilities_show_port_info(
             self.ports[0].device_capabilities,
         )
 
+    def get_capabilities_selective_rx(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get selective Rx capability from show port info.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        port_info = self.show_port_info(self.ports[0].id)
+        if port_info.selective_rx:
+            supported_capabilities.add(NicCapability.SELECTIVE_RX)
+        else:
+            unsupported_capabilities.add(NicCapability.SELECTIVE_RX)
+
     def get_capabilities_mcast_filtering(
         self,
         supported_capabilities: MutableSet["NicCapability"],
diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py
index 0d322aece2..6f1eaf47cc 100644
--- a/dts/api/testpmd/types.py
+++ b/dts/api/testpmd/types.py
@@ -614,6 +614,12 @@ def _validate(info: str) -> str | None:
         metadata=VLANOffloadFlag.make_parser(),
     )
 
+    #: Selective Rx support
+    selective_rx: bool = field(
+        default=False,
+        metadata=TextParser.find(r"Selective Rx: supported"),
+    )
+
     #: Maximum size of RX buffer
     max_rx_bufsize: int | None = field(
         default=None, metadata=TextParser.find_int(r"Maximum size of RX buffer: (\d+)")
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index 96e1cd449f..b10799ea4b 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -324,6 +324,8 @@ def mapping(cap: NicCapability) -> TestPmdNicCapability:
                     | NicCapability.FLOW_SHARED_OBJECT_KEEP
                 ):
                     return (TestPmd.get_capabilities_show_port_info, None)
+                case NicCapability.SELECTIVE_RX:
+                    return (TestPmd.get_capabilities_selective_rx, None)
                 case NicCapability.MCAST_FILTERING:
                     return (TestPmd.get_capabilities_mcast_filtering, None)
                 case NicCapability.FLOW_CTRL:
diff --git a/dts/tests/TestSuite_rx_split.py b/dts/tests/TestSuite_rx_split.py
new file mode 100644
index 0000000000..e12fe1a828
--- /dev/null
+++ b/dts/tests/TestSuite_rx_split.py
@@ -0,0 +1,262 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 NVIDIA Corporation & Affiliates
+
+"""Rx split test suite.
+
+Test configuring a packet split on Rx,
+and discarding some segments (selective Rx) at NIC level.
+"""
+
+from typing import Any
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Packet, Raw
+
+from api.capabilities import (
+    NicCapability,
+    requires_nic_capability,
+)
+from api.packet import send_packet_and_capture
+from api.test import fail, verify
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
+from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
+from framework.exception import InteractiveCommandExecutionError
+from framework.test_suite import TestSuite, func_test
+
+PAYLOAD = bytes(range(256))
+ETHER_HDR_LEN = len(Ether())
+IP_HDR_LEN = len(IP())
+ETHER_IP_HDR_LEN = ETHER_HDR_LEN + IP_HDR_LEN
+
+
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_BUFFER_SPLIT)
+@requires_nic_capability(NicCapability.SELECTIVE_RX)
+class TestRxSplit(TestSuite):
+    """Rx split test suite.
+
+    Configure testpmd with various Rx segment offset/length combinations
+    and verify that only the requested portions of the packet are received
+    and forwarded.
+    """
+
+    def _create_testpmd(self, **kwargs: Any) -> TestPmd:
+        """Create a TestPmd instance with defaults overridden by kwargs."""
+        defaults: dict[str, Any] = {
+            "forward_mode": SimpleForwardingModes.mac,
+            "rx_offloads": RxOffloadCapability.BUFFER_SPLIT,
+            "enable_scatter": True,
+        }
+        return TestPmd(**{**defaults, **kwargs})
+
+    def _build_packet(self) -> Packet:
+        """Build a test packet with an incrementing byte pattern payload."""
+        return Ether() / IP() / Raw(load=PAYLOAD)
+
+    def _send_and_verify(
+        self,
+        testpmd: TestPmd,
+        packet: Packet,
+        expected_bytes: bytes,
+    ) -> None:
+        """Clear stats, send a packet, and verify received content and stats.
+
+        Args:
+            testpmd: The running testpmd instance.
+            packet: The packet to send.
+            expected_bytes: Expected raw bytes of the received packet.
+        """
+        expected_len = len(expected_bytes)
+        testpmd.clear_port_stats_all(verify=False)
+
+        received = send_packet_and_capture(packet)
+        verify(
+            len(received) > 0,
+            "Did not receive any packets.",
+        )
+
+        recv_bytes = bytes(received[0])
+        verify(
+            len(recv_bytes) == expected_len,
+            f"Expected packet length {expected_len}, got {len(recv_bytes)}.",
+        )
+        verify(
+            recv_bytes == expected_bytes,
+            "Received packet content does not match expected bytes.",
+        )
+
+        all_stats, _ = testpmd.show_port_stats_all()
+        total_rx_packets = sum(s.rx_packets for s in all_stats)
+        total_rx_bytes = sum(s.rx_bytes for s in all_stats)
+        verify(
+            total_rx_packets == 1,
+            f"Expected 1 Rx packet, got {total_rx_packets}.",
+        )
+        verify(
+            total_rx_bytes == expected_len,
+            f"Expected {expected_len} Rx bytes, got {total_rx_bytes}.",
+        )
+
+    @func_test
+    def selective_rx_headers(self) -> None:
+        """Keep only the Ethernet + IP headers, discard the payload.
+
+        Steps:
+            Start testpmd with rxoffs/rxpkts and buffer split enabled.
+            Send an Ether/IP/payload packet.
+
+        Verify:
+            Received packet has Ether + IP headers only.
+            Port stats show expected rx_packets and rx_bytes.
+        """
+        with self._create_testpmd(
+            rx_segments_offsets=[0],
+            rx_segments_length=[ETHER_IP_HDR_LEN],
+        ) as testpmd:
+            testpmd.start()
+            packet = self._build_packet()
+            expected = bytes(packet)[:ETHER_IP_HDR_LEN]
+            self._send_and_verify(testpmd, packet, expected)
+
+    @func_test
+    def selective_rx_payload_only(self) -> None:
+        """Skip the Ethernet + IP headers, keep only the payload.
+
+        Steps:
+            Start testpmd with rxoffs/rxpkts and buffer split enabled.
+            Send an Ether/IP/payload packet.
+
+        Verify:
+            Received packet is matching the original payload.
+            Port stats show expected rx_packets and rx_bytes.
+        """
+        with self._create_testpmd(
+            rx_segments_offsets=[ETHER_IP_HDR_LEN],
+            rx_segments_length=[len(PAYLOAD)],
+        ) as testpmd:
+            testpmd.start()
+            self._send_and_verify(testpmd, self._build_packet(), PAYLOAD)
+
+    @func_test
+    def selective_rx_two_segments(self) -> None:
+        """Keep the IP header and the middle of the payload, skip the rest.
+
+        Steps:
+            Start testpmd with rxoffs/rxpkts, buffer split
+            and multi-segment Tx enabled.
+            Send an Ether/IP/payload packet.
+
+        Verify:
+            Received packet is matching the IP header and middle of payload.
+            Port stats show expected rx_packets and rx_bytes.
+        """
+        payload_offset = 100
+        payload_length = 100
+        with self._create_testpmd(
+            tx_offloads=TxOffloadCapability.MULTI_SEGS,
+            rx_segments_offsets=[ETHER_HDR_LEN, ETHER_IP_HDR_LEN + payload_offset],
+            rx_segments_length=[IP_HDR_LEN, payload_length],
+        ) as testpmd:
+            testpmd.start()
+            packet = self._build_packet()
+            raw = bytes(packet)
+            payload_start = ETHER_IP_HDR_LEN + payload_offset
+            expected = (
+                raw[ETHER_HDR_LEN:ETHER_IP_HDR_LEN]
+                + raw[payload_start : payload_start + payload_length]
+            )
+            self._send_and_verify(testpmd, packet, expected)
+
+    @func_test
+    def selective_rx_no_offload(self) -> None:
+        """Configure selective Rx with buffer split disabled.
+
+        Steps:
+            Start testpmd with rxoffs/rxpkts, buffer split
+            and device start disabled.
+            Attempt to start ports.
+
+        Verify:
+            Queue configuration fails.
+        """
+        with self._create_testpmd(
+            rx_offloads=None,
+            rx_segments_offsets=[0],
+            rx_segments_length=[ETHER_IP_HDR_LEN],
+            disable_device_start=True,
+        ) as testpmd:
+            try:
+                testpmd.start_all_ports()
+                fail("Expected configuration to fail with buffer split disabled.")
+            except InteractiveCommandExecutionError:
+                pass
+
+    @func_test
+    def selective_rx_offset_out_of_range(self) -> None:
+        """Configure selective Rx with an offset beyond max_rx_pktlen.
+
+        Steps:
+            Start testpmd with rxoffs too big, buffer split enabled,
+            and device start disabled.
+            Attempt to start ports.
+
+        Verify:
+            Queue configuration fails.
+        """
+        with self._create_testpmd(
+            rx_segments_offsets=[20000],
+            rx_segments_length=[100],
+            disable_device_start=True,
+        ) as testpmd:
+            try:
+                testpmd.start_all_ports()
+                fail("Expected configuration to fail with out-of-range offset.")
+            except InteractiveCommandExecutionError:
+                pass
+
+    @func_test
+    def selective_rx_overlap(self) -> None:
+        """Configure selective Rx with overlapping segments.
+
+        Steps:
+            Start testpmd with overlapping rxoffs/rxpkts, buffer split enabled,
+            and device start disabled.
+            Attempt to start ports.
+
+        Verify:
+            Queue configuration fails.
+        """
+        with self._create_testpmd(
+            rx_segments_offsets=[0, 10],
+            rx_segments_length=[64, 64],
+            disable_device_start=True,
+        ) as testpmd:
+            try:
+                testpmd.start_all_ports()
+                fail("Expected configuration to fail with overlapping segments.")
+            except InteractiveCommandExecutionError:
+                pass
+
+    @func_test
+    def selective_rx_all_discard(self) -> None:
+        """Configure selective Rx with only discard segment.
+
+        Steps:
+            Start testpmd with rxoffs/rxpkts=0 (null segment), buffer split enabled,
+            and device start disabled.
+            Attempt to start ports.
+
+        Verify:
+            Queue configuration fails.
+        """
+        with self._create_testpmd(
+            rx_segments_offsets=[0],
+            rx_segments_length=[0],
+            disable_device_start=True,
+        ) as testpmd:
+            try:
+                testpmd.start_all_ports()
+                fail("Expected configuration to fail with only discard segment.")
+            except InteractiveCommandExecutionError:
+                pass
-- 
2.54.0

