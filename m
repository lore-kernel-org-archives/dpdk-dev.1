Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3A9CA5FA3
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 19:22:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 833BC40DDA;
	Mon, 28 Sep 2026 21:22:54 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 49008402F0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 21:22:53 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-93a40a9a01aso18841785a.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 12:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790623372; x=1791228172; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UXebrUZjwWv1qooj7AWbjczOM8N/q0gWNetWvdDX1ZA=;
 b=CVAKFv2OyqVo7gUH6O2yiyg87DEFYl/mQ7Ud8pjub6qO22Sy1myycwOeUct25M16wE
 69nhZIhLPh5emNNe3xITv3eyfE13Bxbz+4i67UIR1kHOIIEuGU5jPfW7pItxYfBKAffE
 1ptHTX+AS3/lZFa3ev3XN72fhWsUanPEMebmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790623372; x=1791228172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UXebrUZjwWv1qooj7AWbjczOM8N/q0gWNetWvdDX1ZA=;
 b=1DCI2JM8vSHJ+ygqLdTva+X2ijfBUNmVxyluEvZkMBUVdmRYeBdbqM6h2SYZgB14jD
 7QQy7BRfpTiE1UfBq7S5BT7GnXVVmKDlGvUXj6Q9CvM4qz0zTiztht8k1F7yWYfbIiwj
 4M4rfEX2AALVZsnjMi9uWtAW/ao9pBPtICvtl3KF18ULz7C2DrkWlpT4RwVEX9UQxPiv
 NPBP6NPnugE/XsA/n+4G6f0hnkKqyj4bojguCjRZ5BvCbKM2JgKy1/38cnLTxIgxVklg
 0PUg5lwjIu9XaJ0lIzSINYuidreRJZmZmLw1X/VJ09TzXwshu5qANIwVvfBTpTtw9VJV
 sT4A==
X-Gm-Message-State: AFuF++luuT0vvixbrojbG1qkYHla+vVxWjqv73Eukjf8HqC3pppXnBpG
 67M9Y0CAvS0WBVM3IwPwvtfbgHFNJDCTWes2KHTHrvfm9i8fz0n2REg+uQe3FwlewOw+YgSneKX
 G/9wSsGYI/kdHSPPW5mq497VsRXv20Mz6nJPEBifhNJUMiimX061wkzSfFsFHlWW1z4yFr7/bys
 ePmy04Qg3Ps9tZJJt6KvojwT1WC2w=
X-Gm-Gg: AYBFou2EXFYJtSf4Ai7qQxQc+DtEJVXi0xdz72+hWShN49c9AFrCZ3MIiGJc1fcePw4
 MgMX54FFZVyAEo/1vy+TMLM0sainmEScidENtQMx/Pb3hzslrpzyfBm8ohmZOLG2j/F3sYzmeAa
 GQd2DWImOF9JrQJauLrVHfiFR0WVj/kUyQaEvtbbs7K/UkBVrUzQWIAH2reH75MsVon+voUG0kS
 iMXsB/SEI9DGBHrS1CbSXgAodMCP3fPUFrfSH5dqow6voyTA/k0iyiwp10ioyVkHRJc9Phd0w9m
 S4umlHtFUHc48Gte9H0UVDYUGY2DYbBPE/7rCk9QWKeg6gtQe5pctb+P5ysPPkvS8kj0p0r7gKo
 r4lF98X2m28VTwnCSS9BK5UTJV8Kd4gWnVTpI2OyStWJ8Cv2Z9EHXCYpWnmG15EFDuZwa/Xnpbg
 052hvnNzOSaJLj2MGwOabrb0IExwmityI0qylYhoQFPcsYNcN4UU7jGYCIe1VHE9RjaTdE3JrHN
 xdPsXnB+Jqm34/hw7U+
X-Received: by 2002:a05:620a:1a02:b0:93c:6450:9cec with SMTP id
 af79cd13be357-93c8be72642mr66767985a.5.1790623372282; 
 Mon, 28 Sep 2026 12:22:52 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c81423acasm220042685a.27.2026.09.28.12.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:22:51 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5] dts: add ipgre test suite
Date: Mon, 28 Sep 2026 15:22:46 -0400
Message-ID: <20260928192246.254752-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260327180232.443820-1-abailey@iol.unh.edu>
References: <20260327180232.443820-1-abailey@iol.unh.edu>
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

Port over the IP GRE test suite from old DTS to next DTS. This test
suite covers GRE tunneling and checksum offload verification using this
protocol.

Bugzilla ID: 1480

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_ip_gre.rst |   8 +
 dts/api/testpmd/__init__.py            |  23 ++
 dts/tests/TestSuite_ip_gre.py          | 310 +++++++++++++++++++++++++
 3 files changed, 341 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_ip_gre.rst
 create mode 100644 dts/tests/TestSuite_ip_gre.py

diff --git a/doc/api/dts/tests.TestSuite_ip_gre.rst b/doc/api/dts/tests.TestSuite_ip_gre.rst
new file mode 100644
index 0000000000..e8ce01dc0b
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_ip_gre.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+ip_gre Test Suite
+=================
+
+.. automodule:: tests.TestSuite_ip_gre
+   :members:
+   :show-inheritance:
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index 7118f9470f..0466777b5f 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -957,6 +957,29 @@ def set_flow_control(
                     f"Testpmd failed to set the {flow_ctrl} in port {port}."
                 )
 
+    def set_csum_parse_tunnel(self, port: int, on: bool, verify: bool = True) -> None:
+        """Set parse tunnel on or off in testpmd for a given port.
+
+        Args:
+            port: The ID of the requested port
+            on: set parse tunnel on if `on` is :data:`True`, otherwise off
+            verify: if :data:`True`, the output of the command is scanned to verify that
+                parse tunnel was set successfully
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the command
+                fails to execute.
+
+        """
+        output = self.send_command(f"csum parse-tunnel {'on' if on else 'off'} {port}")
+        if verify and f"Parse tunnel is {'on' if on else 'off'}" not in output:
+            self._logger.debug(
+                f"Testpmd failed to set csum parse-tunnel {'on' if on else 'off'} in port {port}"
+            )
+            raise InteractiveCommandExecutionError(
+                f"Testpmd failed to set csum parse-tunnel {'on' if on else 'off'} in port {port}"
+            )
+
     def show_port_flow_info(self, port: int) -> TestPmdPortFlowCtrl | None:
         """Show port info flow.
 
diff --git a/dts/tests/TestSuite_ip_gre.py b/dts/tests/TestSuite_ip_gre.py
new file mode 100644
index 0000000000..c113b25130
--- /dev/null
+++ b/dts/tests/TestSuite_ip_gre.py
@@ -0,0 +1,310 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
+
+"""DPDK IP GRE test suite."""
+
+from scapy.layers.inet import GRE, IP, TCP, UDP
+from scapy.layers.inet6 import IPv6
+from scapy.layers.l2 import Dot1Q, Ether
+from scapy.layers.sctp import SCTP
+from scapy.packet import Packet
+
+from api.capabilities import (
+    NicCapability,
+    requires_nic_capability,
+)
+from api.packet import send_packet_and_capture
+from api.test import verify
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
+from api.testpmd.types import (
+    ChecksumOffloadOptions,
+    PacketOffloadFlag,
+    RtePTypes,
+    TestPmdVerbosePacket,
+)
+from framework.test_suite import TestSuite, func_test
+
+SRC_ID = "00:00:10:00:00:00"
+
+
+class TestIpGre(TestSuite):
+    """IP GRE test suite."""
+
+    def _check_for_matching_packet(
+        self, output: list[TestPmdVerbosePacket], flags: RtePTypes
+    ) -> bool:
+        """Returns :data:`True` if the packet in verbose output contains all specified flags."""
+        for packet in output:
+            if packet.src_mac == SRC_ID and flags & (packet.hw_ptype | packet.sw_ptype) == flags:
+                return True
+        return False
+
+    def _send_packet_and_verify_flags(
+        self, expected_flag: RtePTypes, packet: Packet, testpmd: TestPmd
+    ) -> None:
+        """Sends a packet to the DUT and verifies the verbose ptype flags."""
+        send_packet_and_capture(packet=packet)
+        verbose_output = testpmd.extract_verbose_output(testpmd.stop(verify=True))
+        valid = self._check_for_matching_packet(output=verbose_output, flags=expected_flag)
+        verify(valid, f"Packet type flag did not match the expected flag: {expected_flag}.")
+
+    def _setup_session(
+        self, testpmd: TestPmd, expected_and_packets: tuple[list[RtePTypes], list[Packet]]
+    ) -> None:
+        """Sets the forwarding and verbose mode of each test case interactive shell session."""
+        testpmd.set_forward_mode(SimpleForwardingModes.rxonly)
+        testpmd.set_verbose(level=1)
+        expected_flags, packet_list = expected_and_packets
+
+        for expected_flag, packet in zip(expected_flags, packet_list):
+            testpmd.start(verify=True)
+            self._send_packet_and_verify_flags(
+                expected_flag=expected_flag, packet=packet, testpmd=testpmd
+            )
+
+    def _send_packet_and_verify_checksum(
+        self, packet: Packet, good_L4: bool, good_L3: bool, testpmd: TestPmd
+    ) -> None:
+        """Send packet and verify verbose output matches expected output."""
+        testpmd.start()
+        send_packet_and_capture(packet=packet)
+        verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+        correct_L3_cksum = correct_L4 = None
+        for testpmd_packet in verbose_output:
+            if testpmd_packet.src_mac == SRC_ID:
+                correct_L3_cksum = (
+                    PacketOffloadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD in testpmd_packet.ol_flags
+                )
+                correct_L4 = (
+                    PacketOffloadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD in testpmd_packet.ol_flags
+                )
+        verify(
+            correct_L3_cksum is not None and correct_L4 is not None,
+            "Test packet was dropped when it should have been received.",
+        )
+        verify(correct_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
+        verify(
+            correct_L3_cksum == good_L3,
+            "Layer 3 checksum flag did not match expected checksum flag.",
+        )
+
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_GRE_TNL_TSO)
+    @func_test
+    def gre_ip4_pkt_detect(self) -> None:
+        """GRE IP4 packet send and detect.
+
+        Steps:
+            * Craft packets using GRE tunneling.
+            * Send them to the testpmd application.
+
+        Verify:
+            * All packets were received.
+        """
+        packets = [
+            Ether(src=SRC_ID) / IP() / GRE() / IP() / UDP(),
+            Ether(src=SRC_ID) / IP() / GRE() / IP() / TCP(),
+            Ether(src=SRC_ID) / IP() / GRE() / IP() / SCTP(),
+            Ether(src=SRC_ID) / Dot1Q() / IP() / GRE() / IP() / UDP(),
+            Ether(src=SRC_ID) / Dot1Q() / IP() / GRE() / IP() / TCP(),
+            Ether(src=SRC_ID) / Dot1Q() / IP() / GRE() / IP() / SCTP(),
+        ]
+        flags = [
+            RtePTypes.L2_ETHER
+            | RtePTypes.L3_IPV4
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_UDP,
+            RtePTypes.L2_ETHER
+            | RtePTypes.L3_IPV4
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_TCP,
+            RtePTypes.L2_ETHER
+            | RtePTypes.L3_IPV4
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_SCTP,
+            RtePTypes.L2_ETHER_QINQ
+            | RtePTypes.L3_IPV4
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_UDP,
+            RtePTypes.L2_ETHER_QINQ
+            | RtePTypes.L3_IPV4
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_TCP,
+            RtePTypes.L2_ETHER_QINQ
+            | RtePTypes.L3_IPV4
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_SCTP,
+        ]
+        with TestPmd() as testpmd:
+            testpmd.set_forward_mode(SimpleForwardingModes.rxonly)
+            self._setup_session(testpmd=testpmd, expected_and_packets=(flags, packets))
+
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_GRE_TNL_TSO)
+    @func_test
+    def gre_ip6_outer_ip4_inner_pkt_detect(self) -> None:
+        """GRE IPv6 outer and IPv4 inner send and detect.
+
+        Steps:
+            * Craft packets using GRE tunneling.
+            * Send them to the testpmd application.
+
+        Verify:
+            * All packets were received.
+        """
+        packets = [
+            Ether(src=SRC_ID) / IPv6() / GRE() / IP() / UDP(),
+            Ether(src=SRC_ID) / IPv6() / GRE() / IP() / TCP(),
+            Ether(src=SRC_ID) / IPv6() / GRE() / IP() / SCTP(),
+            Ether(src=SRC_ID) / Dot1Q() / IPv6() / GRE() / IP() / UDP(),
+            Ether(src=SRC_ID) / Dot1Q() / IPv6() / GRE() / IP() / TCP(),
+            Ether(src=SRC_ID) / Dot1Q() / IPv6() / GRE() / IP() / SCTP(),
+        ]
+        flags = [
+            RtePTypes.L2_ETHER
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_UDP,
+            RtePTypes.L2_ETHER
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_TCP,
+            RtePTypes.L2_ETHER
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_SCTP,
+            RtePTypes.L2_ETHER_QINQ
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_UDP,
+            RtePTypes.L2_ETHER_QINQ
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_TCP,
+            RtePTypes.L2_ETHER_QINQ
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_SCTP,
+        ]
+        with TestPmd() as testpmd:
+            testpmd.set_forward_mode(SimpleForwardingModes.rxonly)
+            self._setup_session(testpmd=testpmd, expected_and_packets=(flags, packets))
+
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_GRE_TNL_TSO)
+    @func_test
+    def gre_ip6_outer_ip6_inner_pkt_detect(self) -> None:
+        """GRE IPv6 outer and inner send and detect.
+
+        Steps:
+            * Craft packets using GRE tunneling.
+            * Send them to the testpmd application.
+
+        Verify:
+            * All packets were received.
+        """
+        packets = [
+            Ether(src=SRC_ID) / IPv6() / GRE() / IPv6() / UDP(),
+            Ether(src=SRC_ID) / IPv6() / GRE() / IPv6() / TCP(),
+            Ether(src=SRC_ID) / IPv6() / GRE() / IPv6() / SCTP(),
+            Ether(src=SRC_ID) / Dot1Q() / IPv6() / GRE() / IPv6() / UDP(),
+            Ether(src=SRC_ID) / Dot1Q() / IPv6() / GRE() / IPv6() / TCP(),
+            Ether(src=SRC_ID) / Dot1Q() / IPv6() / GRE() / IPv6() / SCTP(),
+        ]
+        flags = [
+            RtePTypes.L2_ETHER
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV6
+            | RtePTypes.INNER_L4_UDP,
+            RtePTypes.L2_ETHER
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV6
+            | RtePTypes.INNER_L4_TCP,
+            RtePTypes.L2_ETHER
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV6
+            | RtePTypes.INNER_L4_SCTP,
+            RtePTypes.L2_ETHER_QINQ
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV6
+            | RtePTypes.INNER_L4_UDP,
+            RtePTypes.L2_ETHER_QINQ
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV6
+            | RtePTypes.INNER_L4_TCP,
+            RtePTypes.L2_ETHER_QINQ
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV6
+            | RtePTypes.INNER_L4_SCTP,
+        ]
+        with TestPmd() as testpmd:
+            testpmd.set_forward_mode(SimpleForwardingModes.rxonly)
+            self._setup_session(testpmd=testpmd, expected_and_packets=(flags, packets))
+
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_OUTER_IPV4_CKSUM)
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_IPV4_CKSUM)
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_TCP_CKSUM)
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_UDP_CKSUM)
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_SCTP_CKSUM)
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_GRE_TNL_TSO)
+    @func_test
+    def gre_checksum_offload(self) -> None:
+        """GRE checksum offload test.
+
+        Steps:
+            * Craft packets using GRE tunneling.
+            * Alter checksum of each packet.
+            * Send packets to the testpmd application.
+
+        Verify:
+            * All packets were received with the expected checksum flags.
+        """
+        packets = [
+            Ether(src=SRC_ID) / IP(chksum=0x0) / GRE() / IP() / TCP(),
+            Ether(src=SRC_ID) / IP() / GRE() / IP() / TCP(chksum=0x0),
+            Ether(src=SRC_ID) / IP() / GRE() / IP() / UDP(chksum=0xFFFF),
+            Ether(src=SRC_ID) / IP() / GRE() / IP() / SCTP(chksum=0x0),
+        ]
+        good_l4_l3 = [
+            (False, True),
+            (False, True),
+            (False, True),
+            (False, True),
+        ]
+        with TestPmd() as testpmd:
+            testpmd.set_forward_mode(SimpleForwardingModes.csum)
+            testpmd.set_verbose(1)
+            testpmd.csum_set_hw(
+                layers=ChecksumOffloadOptions.ip
+                | ChecksumOffloadOptions.udp
+                | ChecksumOffloadOptions.sctp
+                | ChecksumOffloadOptions.outer_ip
+                | ChecksumOffloadOptions.tcp,
+                port_id=0,
+            )
+            testpmd.set_csum_parse_tunnel(port=0, on=True)
+            testpmd.start_all_ports()
+            testpmd.start()
+            for i in range(len(packets)):
+                self._send_packet_and_verify_checksum(
+                    packets[i],
+                    good_l4_l3[i][0],
+                    good_l4_l3[i][1],
+                    testpmd,
+                )
-- 
2.55.0

