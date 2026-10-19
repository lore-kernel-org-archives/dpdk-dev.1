Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B79606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=WfLl6Kco
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61B8940297;
	Mon, 19 Oct 2026 21:48:56 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 51B804021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 21:48:55 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-93f259cdc86so249031385a.3
 for <dev@dpdk.org>; Mon, 19 Oct 2026 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792439334; x=1793044134; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fHim2PKlhlOJ4cWIr7S9tlka4H+/f7cAQsnY67vpqLQ=;
 b=WfLl6KcoMv32Cvjk9/ReaG/Ff/aRrNTcSJ6QNDIOp6RJ31SA0hv5/cffpHwwf6lpMU
 tpYfX9yvT/uvPvCl5wk4OrCYNO4HCQ8Vi1LgrxbNq6TUBpp9kdUBvG8OaLhijUmrzFLr
 NUishh6p+k7sn2t0Y0PNAW2f2Vy5OuTnKNN5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792439334; x=1793044134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fHim2PKlhlOJ4cWIr7S9tlka4H+/f7cAQsnY67vpqLQ=;
 b=O3zoUiqpzwItxuiQ6nJFnxL8jPLTeKJhTKAj3paV8HCylJ39LzWtHObhDstxMM9ll0
 udhmA8liBStIirVdbW//eSu2R4AIJKAgY2jreynw8h3gv6ZGF5B3ZkWlEL9x6OBdToJQ
 DV+vRucCS7ADFmQbYgfvgivMh2kYWFIh32Ids4HYmoGUHBGNj5u+xiA3GQpE1dlQ+cWu
 wHEfX4k2ipmvDR+5g7p2AZyw0SusT42RKdoFwagtOOA8FPnAAcT8a+8hy8x38va1C3BI
 U4NU8gdleLC7H8gaFx6fEUPfvYBMi2zY3ENyAs5zVFrVE4EK+IyafhDYuZKfFzdYXlIk
 c6mA==
X-Gm-Message-State: AFq9FYLCBVTXxt/3tAaXJ4fBw7dofnHxWuyCZV2knzp3zzX+Lh/ep6X8
 BZqYHMdZJNoZpXtLjUfLGfvWXKdHbIZLKB/i8jfyNAgYYYb38pL7UqOOg7RpqcqZCFpGQQE+vsb
 7EzUz3XLjncR8xLFgtxQSiYtHYhj7L5Sa9PhobO7zoyTCGgweprSxxUszRV7zjPgCRGrpbTr8T7
 AWvTDwoyJvkCNCIOMjN3xsHeQXbMw=
X-Gm-Gg: AYBFou1GqhLmmlP8w4vd9jV7mcfy7pNjpPEeTJDKk/LGxz6PCSGTMJi6g6d/RLpxhWf
 o+9GYsNxMXmMW+dO6iTP91vh8Wy0dpGTRhEg5V62ZD/BmY14cRDhWnBfXWT7wgRyFyFLKZ+jSf1
 QYhhp0xfjZOCdmYw727CxZL5ofssHdz2gzWZOXf/1c6lrUbWS8/VhPH4UUJEauiuU3jIoQ4F6bI
 tusMH92rVcz4DVF5U/rZdc0vUy5X25ezMMjY3QcWb6EzZyZrsOh3oa1hglEDxcBjhzo8Szg/ZcQ
 xcpdJgqaGpG/l/FEO3KfEJDs7DsFNrY/71PiCiWC18mgT7/Amq7MC3rFXgT97vx42NNM1eTp9dv
 bYpPshbSKe6IKPB4Q2bXaps/8Ap5LAW0eZ+ISN3L92/vBDbBEE6E4k3v87377Zbz6rQZg3nL+p+
 yNyXmd15/lkUgM3RVy5+hTQuXDIc9qIdA9F5IO3cSNOLvFc4WW63EPJpXEk+YpZidlB7Hmyq75D
 zP7V8ZecYIgJUWHXmcw6w==
X-Received: by 2002:a05:620a:17a2:b0:93e:f9ba:690e with SMTP id
 af79cd13be357-93f29b632c6mr1439444985a.3.1792439334238; 
 Mon, 19 Oct 2026 12:48:54 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f4b0d7c74sm40430485a.35.2026.10.19.12.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:48:53 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com,
 dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v6] dts: add ipgre test suite
Date: Mon, 19 Oct 2026 15:48:41 -0400
Message-ID: <20261019194841.890257-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260327180232.443820-1-abailey@iol.unh.edu>
References: <20260327180232.443820-1-abailey@iol.unh.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Port over the IP GRE test suite from old DTS to next DTS. This test
suite covers GRE tunneling and checksum offload verification using this
protocol.

Bugzilla ID: 1480

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
v6:
 * Rebased on main.

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
index 2713737360..272c3819df 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -962,6 +962,29 @@ def set_flow_control(
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
index 0000000000..5c665846e0
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
+from api.test_suite import TestSuite, func_test
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
+from api.testpmd.types import (
+    ChecksumOffloadOptions,
+    PacketOffloadFlag,
+    RtePTypes,
+    TestPmdVerbosePacket,
+)
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

