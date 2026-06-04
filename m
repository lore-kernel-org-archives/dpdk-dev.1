Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC60CD6E6E
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 19:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09B724066C;
	Thu,  4 Jun 2026 21:34:11 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id A5E8E4066C
 for <dev@dpdk.org>; Thu,  4 Jun 2026 21:34:09 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 588291400129;
 Thu,  4 Jun 2026 15:34:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 15:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780601649; x=
 1780688049; bh=rj30aAEAg3MytwmHbBk2ymrTH97uw+PvnhK5/tsSpZc=; b=i
 0je7g7iNLvf10bsqSIvG5ESEdmpecPVEL3H4WoqTBY0F3UwRyO+QyATU4G3aJQYD
 LoSoDW7BS/oSJJr+QT78pRgFgpZ3WCzJKQ6eFBxwYdX8eHjWln+BsyO4wUzlU2tR
 9LV/VX683/WMsSCgDn22IWAgOPW4J1EoeoRICEahQUtmSJamFJQcXJJs3/oJbhqh
 Tu5v4brEeZetIe/pTz+phPeiCtg/CqAMJa35roR3EurS+7tDMfpec02GvYkb7nhr
 dtc/Yl+kwJdloMoGqA6iKKevUjIXhXRdhAlQdpuARIOWHyLaV/RNRGWa5BUua86T
 AxC8W8y9/YMi0MuMC7HsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780601649; x=1780688049; bh=r
 j30aAEAg3MytwmHbBk2ymrTH97uw+PvnhK5/tsSpZc=; b=hLGDKPPYUsLBYdQxa
 hPixSgUY/pa2iaHu+mxY5l7bgdsm/CplNTHxkFuUXicNNUxeIgIY22ansDJA9NtY
 SToZt6jx6FHb92bXBpbdMqlI2i1YT58kEBu95FJOR8O3rV1bS6YF+oJiJSkH2A2a
 4VNsMfD33oqHr6pZw1z2qrNJOB8alUmsnudoNpJQjFoGAK+5AM3wMq/DXhImDluF
 DxZJdo8JRj62fBLiid8S1YIeFVgNnpHDBhWGg8t+olAjzviKfoQyM7qIGlMSoEW5
 tktCV2n/dnaoEO2zhulMVospp+jSTWOP7V7J2gRADybZOrs9xjf5WZ6B0HdDrko4
 IyL0A==
X-ME-Sender: <xms:MdMhajYCiedOtKv53bzdGOm5TQguFVsR3YS-l6Zt5jW0x1RqiYPyFg>
 <xme:MdMhaij2q5W5KdRrHDbDDIvHyQGj0uGdsRSJUvkmmm6kE-F22HetfsB0KGdaXm0YY
 GvklEfrwRvYkY-qr9A8WqyBFY5cb9LADnDVC51eTX-U28oJGhr7>
X-ME-Received: <xmr:MdMhat7IEkSVZi6Fl_wnHWQWbeO12e4jqsolRDhF50S9ccdh0xaMEbxGdbLOIFUNpJGgl3pT5ygzm2_I0rP_jK252nPaHLs>
X-ME-Proxy-Cause: dmFkZTFBVtFu73v6kEfmvEVYm2wybPSOOTBO2QZQTLxMmhRKicwazOPAhmwg6YOl/udFjG
 9CMckWvsaG3S/jXdOqGQ5YBD4798m4D3rAKVoB8d50ghLHACp09RRpMyKxbxJtg2kE4byq
 Wp+HcF41u2/fePWGB0Uoi0ggfcS2OmIDt7CA/hRM1+p1IN9erhF5steHvQA9oFz66G1z/y
 O12rNKrmv1xf2hrywdgv534RP7gMBVDK99h9nsQJRbuaOBkZo8ScTD2/4XPDewNtPAzPjR
 ComfayxCQpZAQ5JXvsrV1I8vr239TJi7FrAX9RwQ6Hiol1JR4VNExV6vm4spCCRsmuhAIu
 S8M7u+6D2t0pm48Ydn0ECbwvyAAGtc13rceiRAC1f8MhiRba8f6eSGr1I47O/5kcp10qgM
 uWKWsDgrVu1ICRZ/eHehx7J32WSrP/LpGfY4FxwQjuEyHg7jvlZCg2Bw01Qdt16O4EgCTD
 umcAFhW08plE958RNKYiMGn/ZBcH95wZ2vi9SS6zARpaZ6A0LzHMoIWEy0+LgHWFvb0J0E
 yVHZXEawgXxEU9TSDjfaa4a2uA1wGsA6TWha1bK4PYSfsBKIhpE3k6KqVUfepCURw7gZ1Z
 b5/GEy6aVmuqtMgt5/Miykh6ztps89gW7ONyJqbWBHuDhQGrZaT59o9ROK3w
X-ME-Proxy: <xmx:MdMhah67TfBs7nQVa1qlas-mMWr0nD_ckYc239Hem65mZ1ZdjK3JzQ>
 <xmx:MdMhapetxxgzfXlrza33Mg1gwv0maO7G5Fs-phfh_w2bBo2My8_DDQ>
 <xmx:MdMhalChTsUNSZQLhC7HPVZjOiq1tww5evckCsB2t5RUSD45T5bwGw>
 <xmx:MdMhas_EaWrg1p60MFMM6yOIoZs3eb8JxkieCb50wmJVFbWmynoyNw>
 <xmx:MdMhakgzw7dNDJoCYSMz7Y2CK5Uruk44DW2F6u_k8blUFLZ0cE0U9MJJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 15:34:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: [PATCH v8 9/9] dts: add selective Rx tests
Date: Thu,  4 Jun 2026 21:31:01 +0200
Message-ID: <20260604193324.1996141-10-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604193324.1996141-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260604193324.1996141-1-thomas@monjalon.net>
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
 dts/tests/TestSuite_rx_split.py           | 265 ++++++++++++++++++++++
 5 files changed, 292 insertions(+)
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
index 0000000000..5e7dc76463
--- /dev/null
+++ b/dts/tests/TestSuite_rx_split.py
@@ -0,0 +1,265 @@
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
+            Start testpmd with rxpkts, mbuf-size and buffer split enabled.
+            Send an Ether/IP/payload packet.
+
+        Verify:
+            Received packet has Ether + IP headers only.
+            Port stats show expected rx_packets and rx_bytes.
+        """
+        with self._create_testpmd(
+            rx_segments_length=[ETHER_IP_HDR_LEN, 0],
+            mbuf_size=[256, 0],
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
+            Start testpmd with rxpkts, mbuf-size and buffer split enabled.
+            Send an Ether/IP/payload packet.
+
+        Verify:
+            Received packet is matching the original payload.
+            Port stats show expected rx_packets and rx_bytes.
+        """
+        with self._create_testpmd(
+            rx_segments_length=[ETHER_IP_HDR_LEN, len(PAYLOAD)],
+            mbuf_size=[0, 512],
+        ) as testpmd:
+            testpmd.start()
+            self._send_and_verify(testpmd, self._build_packet(), PAYLOAD)
+
+    @func_test
+    def selective_rx_two_segments(self) -> None:
+        """Keep the IP header and the middle of the payload, skip the rest.
+
+        Steps:
+            Start testpmd with rxpkts, mbuf-size, buffer split
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
+            rx_segments_length=[
+                ETHER_HDR_LEN, IP_HDR_LEN,
+                payload_offset, payload_length, 0,
+            ],
+            mbuf_size=[0, 256, 0, 256, 0],
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
+            Start testpmd with rxpkts, mbuf-size including a discard segment,
+            buffer split disabled, and device start disabled.
+            Attempt to start ports.
+
+        Verify:
+            Queue configuration fails.
+        """
+        with self._create_testpmd(
+            rx_offloads=None,
+            rx_segments_length=[ETHER_IP_HDR_LEN, 0],
+            mbuf_size=[256, 0],
+            disable_device_start=True,
+        ) as testpmd:
+            try:
+                testpmd.start_all_ports()
+                fail("Expected configuration to fail with buffer split disabled.")
+            except InteractiveCommandExecutionError:
+                pass
+
+    @func_test
+    def selective_rx_out_of_range(self) -> None:
+        """Configure selective Rx with total lengths exceeding max_rx_pktlen.
+
+        Steps:
+            Start testpmd with rxpkts too big, buffer split enabled,
+            and device start disabled.
+            Attempt to start ports.
+
+        Verify:
+            Queue configuration fails.
+        """
+        with self._create_testpmd(
+            rx_segments_length=[ETHER_IP_HDR_LEN, 20000],
+            mbuf_size=[256, 0],
+            disable_device_start=True,
+        ) as testpmd:
+            try:
+                testpmd.start_all_ports()
+                fail("Expected configuration to fail with out-of-range length.")
+            except InteractiveCommandExecutionError:
+                pass
+
+    @func_test
+    def selective_rx_segment_exceeds_mbuf(self) -> None:
+        """Configure selective Rx with segment length exceeding mbuf capacity.
+
+        Steps:
+            Start testpmd with rxpkts larger than mbuf-size,
+            buffer split enabled, and device start disabled.
+            Attempt to start ports.
+
+        Verify:
+            Queue configuration fails.
+        """
+        with self._create_testpmd(
+            rx_segments_length=[4096, 0],
+            mbuf_size=[128, 0],
+            disable_device_start=True,
+        ) as testpmd:
+            try:
+                testpmd.start_all_ports()
+                fail("Expected configuration to fail with segment > mbuf size.")
+            except InteractiveCommandExecutionError:
+                pass
+
+    @func_test
+    def selective_rx_all_discard(self) -> None:
+        """Configure selective Rx with only discard segment.
+
+        Steps:
+            Start testpmd with only discard segment,
+            buffer split enabled, and device start disabled.
+            Attempt to start ports.
+
+        Verify:
+            Queue configuration fails.
+        """
+        with self._create_testpmd(
+            rx_segments_length=[0],
+            mbuf_size=[0],
+            disable_device_start=True,
+        ) as testpmd:
+            try:
+                testpmd.start_all_ports()
+                fail("Expected configuration to fail with only discard segment.")
+            except InteractiveCommandExecutionError:
+                pass
-- 
2.54.0

