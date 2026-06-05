Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC01ACD6E7E
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:36:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D6DD40A6E;
	Sat,  6 Jun 2026 01:35:35 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id B176D40A76
 for <dev@dpdk.org>; Sat,  6 Jun 2026 01:35:33 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 65C20140012D;
 Fri,  5 Jun 2026 19:35:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 19:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780702533; x=
 1780788933; bh=z4aO3kGBmAsv9yzlf/t7rMNVkCaCkFL+LmcQFWVlu+g=; b=e
 +RhtGo4Ylzza1zJ6m7BvBw3b++5GMTKUsi0LInQ5euigTpattrBtq0qS0eWpK4cs
 XX3ei5D6od0RZSK0O+jkf2gwHAuK03Rxh4Cc3p0KYFVlINi3fVsoTLsfANKTiJMG
 2l4fjblD8CKHTyJb43Wj/pd6tVv3oegaGfuOwaJgv8v26iJ+Qrj+jXEHaY4oG5ij
 aBPkuK0FeFSta+4IiBHihEOFxkNPDM0U+TrQ42bydgOvKh7EwHQdErVH01pziF6c
 RfXwAPzkqj8Q+5pyOTEQkl2Uwvb2zuiADzetse1j2RIdQ266r7TiesXrpuyCpDCx
 Ft4O2lssX+h0llhTSVQjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780702533; x=1780788933; bh=z
 4aO3kGBmAsv9yzlf/t7rMNVkCaCkFL+LmcQFWVlu+g=; b=gkj4jkY3Q5YvOQIkr
 gPH0b+QN+54vsdDG7kMI3kBVSCmyWEQrep0ZIO+WOyBm4IhER0TGw4ICbkDYH6A/
 LL9JZw1GP2Bn2rB4dV8nwfVl5OR516xaKXWQGKUTetPoMH26R/JqiS2nv8cxg3gE
 fbK5/YHdi8esAnprgxmWXn97AxBAqNttxaxznk031PyZY+bBZVirAXkziJ9Nd7xt
 nwvsVvauawISLVqX/t/Rrz9WDPzFzgAH4AZ1hqTCGkfM/Ix3iTCAcwbb1A6VrXLf
 TkHqsjlZJPfYo/Vc3fBV9tr3fwkrIJBqYJCCBGbw2/OQPD955krGVYGDZdVXtj1h
 86oNg==
X-ME-Sender: <xms:RV0javNWfi7ysFlM3dOAvV5j7J2LgDw4q9y8Ct8FqHbWkyKi641axg>
 <xme:RV0jaqHYfjod-vMIVtqHU_DDonyq92JBq-7kOYOAwab-SamE4B6PGx9TWyDn14sBf
 GwTECioyBCXbVFN546xtid4Rdi-qM0YlgJ-vjF6qJl9kIguZ9Sgsw>
X-ME-Received: <xmr:RV0jamPs4Z7oBwDT5RNAZ8z01hrAMZ3C7tCBVp_lRQ1l2jPu45LY6Zl81aAmYxvvP6QMDgR2igVM8F9niNmBGYpzbkIXujs>
X-ME-Proxy-Cause: dmFkZTGzqB9VtFI99eOw6BobuLm3hk3TtecrLkwGZnoPzSMqKBIvARG1bnFYZMgW7RR3Sn
 d8HGOh3+U9suVcGhC9wLPD8PQQV+TTrBGhcQOzAVlNb9EhVfRko8hR6bg+arR9FDtyrqr+
 Oh9krPYIKsY3Fo5XJUhCm2g8VmGWg0RNxvEnSTORpivfsWS18goJE4hkGlV2XNc5+hFbCO
 8eWq4kW4BsbPtAXXNwwvez6E5oc/ehQmRYNYqcepTVBdBaZK2+VT6rImCTjVt3/xz9Nhli
 TRIhvLCrzk8cXTHD6P9ytRlAs7G2Brli4KinTp3i+GPPLfVBgJAe5NyVzKzT0yh2P03DLr
 WJQKYt3SIg/UYthjbycuTbqwvjh7QvQsDvmkKjJsMyUAeOuHhmLb4jl0R0V/g/NFF7258V
 LUtAO7sgVlZ0EmezIZhijlWJZqh4kAXdqjF3e36TOpZnUg2o1Szh9E7n+gIgaIK+B0x0dA
 sxwvl7zwuIfL5ay0JCXjIhG8V69y0Ta8sP47wL5j0gFX5hR1GTte1rEPvo2plVs6n47IR9
 +dkohYjDrL5cHrjCT3vcf2FPty6qE5/epgsshEyj2qdpQ2rRRV1DnqRDkkLjAA5vraN8Nf
 gXIBp/uQbzsk6lD3+lohPK0NDFxft+xKAvormkIZqX6nc2Md9h7Pdrx7hIcw
X-ME-Proxy: <xmx:RV0jar9YBck4keKIPnmcfasYzJ8th-bZuuCOYIDYoQL3qzxcXN8Bug>
 <xmx:RV0jaiRxAEXgt3_iXxVJECKZ6gwj3T9gBSUx9d_ZLerCfnMcB08OiA>
 <xmx:RV0jalmSJiUTIIqqFW1oguLf2AMMHbRsluX4rmtPJPDaMKWEYWjBQA>
 <xmx:RV0jaqR7NT7saRuW8sVVJSj0VUOkXA16kI7BN8BDuGjp0wOQfiUtcw>
 <xmx:RV0jarkdNpz7eGZHON9t6o99Jvm4Li-wZt0F5BAMMJSRIS_BtFIfCabg>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:35:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: [PATCH v9 10/10] dts: add selective Rx tests
Date: Sat,  6 Jun 2026 01:33:50 +0200
Message-ID: <20260605233456.3017423-11-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233456.3017423-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260605233456.3017423-1-thomas@monjalon.net>
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
 dts/tests/TestSuite_rx_split.py           | 277 ++++++++++++++++++++++
 5 files changed, 304 insertions(+)
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
index 0000000000..0c7913bbd8
--- /dev/null
+++ b/dts/tests/TestSuite_rx_split.py
@@ -0,0 +1,277 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 NVIDIA Corporation & Affiliates
+
+"""Rx split test suite.
+
+Test configuring a packet split on Rx,
+and discarding some segments (selective Rx) at NIC level.
+"""
+
+from collections.abc import Callable
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
+from api.packet import adjust_addresses, send_packet_and_capture
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
+ETHER_MIN_FRAME_LEN = 60
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
+            "forward_mode": SimpleForwardingModes.io,
+            "rx_offloads": RxOffloadCapability.BUFFER_SPLIT | RxOffloadCapability.SCATTER,
+        }
+        return TestPmd(**{**defaults, **kwargs})
+
+    def _build_packet(self) -> Packet:
+        """Build a test packet with an incrementing byte pattern payload."""
+        packet = Ether() / IP() / Raw(load=PAYLOAD)
+        return adjust_addresses([packet])[0]
+
+    def _start_and_verify(self, testpmd: TestPmd, expected: Callable[[bytes], bytes]) -> None:
+        """Start testpmd, send the default packet, and verify received bytes."""
+        testpmd.start()
+        packet = self._build_packet()
+        self._send_and_verify(testpmd, packet, expected(bytes(packet)))
+
+    def _send_and_verify(self, testpmd: TestPmd, tg_packet: Packet, expected: bytes) -> None:
+        """Clear stats, send a packet, and verify received content and stats.
+
+        Args:
+            testpmd: The running testpmd instance.
+            tg_packet: The packet to send by Scapy on the TG.
+            expected: Expected raw bytes received by testpmd on the SUT.
+        """
+        testpmd.clear_port_stats_all(verify=False)
+
+        # TG send, SUT receive and forward back, then TG capture
+        sut_len = len(expected)
+        capture_len = max(sut_len, ETHER_MIN_FRAME_LEN)
+        received = send_packet_and_capture(tg_packet)
+        verify(
+            len(received) > 0,
+            "Did not receive any packets.",
+        )
+
+        recv_bytes = bytes(received[0])
+        verify(
+            len(recv_bytes) == capture_len,
+            f"Expected packet length {capture_len}, got {len(recv_bytes)}.",
+        )
+        verify(
+            recv_bytes[:sut_len] == expected,
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
+            total_rx_bytes == sut_len,
+            f"Expected {sut_len} Rx bytes, got {total_rx_bytes}.",
+        )
+
+    def _verify_port_start_fails(self, testpmd: TestPmd, message: str) -> None:
+        """Verify that starting ports fails, then drain testpmd output."""
+        try:
+            testpmd.start_all_ports()
+            fail(message)
+        except InteractiveCommandExecutionError:
+            testpmd.stop(verify=False)
+
+    @func_test
+    def selective_rx_headers(self) -> None:
+        """Keep only the Ethernet + IP headers, discard the rest.
+
+        Steps:
+            Start testpmd with rxpkts, mbuf-size and buffer split enabled.
+            Configure the payload discard segment with length 0 (rest).
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
+
+            def expected(packet: bytes) -> bytes:
+                return packet[:ETHER_IP_HDR_LEN]
+
+            self._start_and_verify(testpmd, expected)
+
+    @func_test
+    def selective_rx_headers_discard_length(self) -> None:
+        """Keep only the Ethernet + IP headers, discard the remaining length.
+
+        Steps:
+            Start testpmd with rxpkts, mbuf-size and buffer split enabled.
+            Configure the payload discard segment with an explicit length.
+            Send an Ether/IP/payload packet.
+
+        Verify:
+            Received packet has Ether + IP headers only.
+            Port stats show expected rx_packets and rx_bytes.
+        """
+        with self._create_testpmd(
+            rx_segments_length=[ETHER_IP_HDR_LEN, len(PAYLOAD)],
+            mbuf_size=[256, 0],
+        ) as testpmd:
+
+            def expected(packet: bytes) -> bytes:
+                return packet[:ETHER_IP_HDR_LEN]
+
+            self._start_and_verify(testpmd, expected)
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
+
+            def expected(_: bytes) -> bytes:
+                return PAYLOAD
+
+            self._start_and_verify(testpmd, expected)
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
+            rx_segments_length=[ETHER_HDR_LEN, IP_HDR_LEN, payload_offset, payload_length, 0],
+            mbuf_size=[0, 256, 0, 256, 0],
+        ) as testpmd:
+
+            def expected(packet: bytes) -> bytes:
+                payload_start = ETHER_IP_HDR_LEN + payload_offset
+                return (
+                    packet[ETHER_HDR_LEN:ETHER_IP_HDR_LEN]
+                    + packet[payload_start : payload_start + payload_length]
+                )
+
+            self._start_and_verify(testpmd, expected)
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
+            self._verify_port_start_fails(
+                testpmd,
+                "Expected configuration to fail with buffer split disabled.",
+            )
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
+            self._verify_port_start_fails(
+                testpmd,
+                "Expected configuration to fail with segment > mbuf size.",
+            )
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
+            self._verify_port_start_fails(
+                testpmd,
+                "Expected configuration to fail with only discard segment.",
+            )
-- 
2.54.0

