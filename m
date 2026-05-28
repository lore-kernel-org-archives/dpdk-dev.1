Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BB6CD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 12:49:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60D204066E;
	Thu, 28 May 2026 14:48:38 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 06E8D40695
 for <dev@dpdk.org>; Thu, 28 May 2026 14:48:37 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AEDD01400048;
 Thu, 28 May 2026 08:48:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Thu, 28 May 2026 08:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779972516; x=
 1780058916; bh=TOXyZ6Y80ZwaBr9psdNcrh4RkcL71fowUCEFw20JOVc=; b=u
 09OaEe2UOOilt2nRzbEP8HiA3zmHPiXbEfIaO6pAdUOWqrS9ML+v5iaXpOr0NJ2p
 uGi64KbfH+IG0/+ehe73zYIA+cXJGSVHrKMOUhkBrklyvUSnorL0kjhy4GBz898v
 bU06/8EvEMYv+1Hu+mvjPb7LOsjeQTERXcmSCo0u6rnFXczMoJeY2ajPkTzSspyR
 VIXJZDvPXfhZ9OT1/mUa2nygJesQ0xYAbKgNleUOIaQWSh26DOKfUj3FMdq9zilI
 Tgm5WcE70xcgGvwV0o+N9I6TbP+xVeoIkjDq2wDl2fe+xpU2z6zRtTdkgKyAGcvy
 yZViZPGZBfv2TfpLpW3RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779972516; x=1780058916; bh=T
 OXyZ6Y80ZwaBr9psdNcrh4RkcL71fowUCEFw20JOVc=; b=OAq+6kbGZDxpQBsHI
 e64qHCH5TaT09qYxp8yz/52glr110Idsy4dC4LPlAoPhm9bSha2/eqILXgpAFTtv
 zb/eQBVFhcCrELbrwShfzrmepvIrS5T/hcZJ/VGlylK0dApYoiCJKAtNCzo59kQX
 QgJPxfwRtRCYGpgyBACcGb2sZ+0ZB79Nm/6wc5Ylyt44wtm7/66/AYEkcSyyFOdu
 e0ig9R1mQBzlGHfiMLwdt2iE14wF053WXD1vGv109P/CTzfdYPI3M5dkybVez8vx
 kSvOKGYNkHKisEMb05LMl013seUk2LjSh2bS/rchVI3jCALIY9WOZp2Q9/eGdRXq
 bPVkQ==
X-ME-Sender: <xms:pDkYau8wHOjGY60vlYge0Mke0kB9uS2dMQhprQOPn9VFYOPa0Kez9w>
 <xme:pDkYau0Q3ZD2kLUwW9YoNffozArQ2LHVh-t6kG5nURKhJ0ceRp8GHr73vhRzKcjWD
 yF3X-2RGpEj7NbL4tZ-_u5RESYStyZfT1uJb3EvzCv0H8BFpTG9oQ>
X-ME-Received: <xmr:pDkYar8spNldkF8Oex5Eon6HMWlXSdUqQQJqCKBXd3_A9HVqsMJVSTpyb2PXnvV5rw8IdAgXWeLm4j8kKZ1BexEwyBBm10Q>
X-ME-Proxy-Cause: dmFkZTFiIFYr4KLY4W2M0xlJJZ1/I7hkDuZASl+aHqkwwJ8oTswmpETnAPK1A0blMmB+ph
 HcrglGRd8UOgC6NXYFPw5vxYVorRAXHUizEPKFrGBng6+0y0sxfPOeCqcwKYEB3NK4YzYX
 QJMSwI0H/wr1ZJiuatyISugFqgefe0tdZn/1PwWCS5qSwtq9yVWLm1SEPc2/1i9wSnwbJC
 v3OFtyE2UJ3jz7Fr/tA2xjyULqg2FmggqMriBx9DPDALUdj0f4SImOl5DU+fhlcwEaltFF
 cFrNWWQyxmgQxdfFUGgBoOFX/sm+sbwlLftirRFtmUZjSy+X5aCFjrDSru3lSe5kYUSoVQ
 ociCbFj2eqsU0o/XlxiAQJYFUpOL5pfFcljEfC5Wc/sL/Kd7YE+klBU2e62/3sf0bYuEse
 k4ZaXgYp3WreAsKedTy81ssDk04mMytYRnZBU79KQ3UA2BeO8DqKI8ZinaAEiYzASRhoCL
 on8OUjFI6G2rwP7Ol6tBOHTuHz1H9poaVc7wboQrdQx5ibHeMZMLsRH+tx4mfXqThviTM+
 FUOJKsmpK6jTIp5wYYxu01JYykzcO0Neyg++hjXUm2cMT6Z0DDj1JFTwL1I3Qth0SkwnUH
 N6PYIvWLkLSVtjLPDWKph0fEhHEOW+XNfm8SzMTmeuFGGxfkSYdA/nv68ELA
X-ME-Proxy: <xmx:pDkYautnXXAzOrKudU359Bj-ETnALYCGcXiJUqwlWJFrwVcIh8edpg>
 <xmx:pDkYauBusMdTMc9J0Fpev54XFF8EHetZ2XcME6nOOGTIVTb-_h9RvA>
 <xmx:pDkYamWDXNmqgtUpTz3Wi4Nb33yIexfIJnj0owy5Hxao_gSKSKHcow>
 <xmx:pDkYasDlzQ7ZykHFZqTZc8RpOxNeY5te9eV8Fl9X9MXJng5vrpWrag>
 <xmx:pDkYahLmCcfjnFyg-rascr0onMqXgZ5vIA8CH3cRochBxaC1JVZBD6_X>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 08:48:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: [PATCH v3 10/10] dts: add selective Rx tests
Date: Thu, 28 May 2026 14:46:37 +0200
Message-ID: <20260528124758.1984528-11-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528124758.1984528-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260528124758.1984528-1-thomas@monjalon.net>
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
index 0000000000..42ff70fe64
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
+from scapy.packet import Raw
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
+    def _build_packet(self) -> Ether:
+        """Build a test packet with an incrementing byte pattern payload."""
+        return Ether() / IP() / Raw(load=PAYLOAD)
+
+    def _send_and_verify(
+        self,
+        testpmd: TestPmd,
+        packet: Ether,
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

