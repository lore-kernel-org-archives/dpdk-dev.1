Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9218CA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 18:24:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D15F40DDA;
	Mon, 28 Sep 2026 20:24:24 +0200 (CEST)
Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com
 [74.125.230.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9A05F402F0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 20:24:22 +0200 (CEST)
Received: by mail-qv2-f42.google.com with SMTP id
 6a1803df08f44-916304a1fadso1405876d6.1
 for <dev@dpdk.org>; Mon, 28 Sep 2026 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790619862; x=1791224662; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qGd2VOvEk0xoZ0+8LOc1U0nT+XMtlZ2JsuLJxQSWJwE=;
 b=bCSLT8/c4IeWttlru/GaOyEOsbWX+Hkn3HmI78GGqtJ7Yv1cTPt/OUtcq5c2bHbuVl
 /cr2+w1J6jIX4avz9/ddS7CvKqXFKkZ7v51LtMjbKoZUmtelWxrS5jRWX61YA2se5oRu
 NmWz2+epVQU3l2uf5NDbPAL8ETGKJX11dzBms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790619862; x=1791224662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qGd2VOvEk0xoZ0+8LOc1U0nT+XMtlZ2JsuLJxQSWJwE=;
 b=GZxOJxY/ZCi/FoT1fjPgS2IJ6Af7HdDqNc1FfiuIbSRu1zxlRm6Qhph7+I/mse0L+O
 4pY16fvKWhvaS/yAVVwSpgZ7SNHu2QhbXo+YlKZKtUo9XfhXmLcggBKpoujRIiUSslVT
 N8srM2GtLeN4uTrjPZOAB77WbkibiZMN6NZTOw7hNFRp2Xraz7pDBsxdWpei6307hrzD
 6uDpy21a0+6kYBt3uaIa7ZYyIa88qhtg0YAcBt7Ex9UO7xqnpwTybDrZMFCYEOsh0Stc
 jjnf+0tq7Hql1mqxeg11ke17dvzo5vanZfPiNwUGKChy/G4Pchk8rvPIjrL72A4t2oX2
 dvsQ==
X-Gm-Message-State: AFuF++l93UmXyrzY7k8wiGYrwsZ9JdC7Z3O2Yiw45c8YkDJeTxq8Kcbo
 fpP2q25LRJAAAanVgvmFN75dpz1kUsMjZ+P06bP+zjH8g5pjWAuJC1vKaHWSIsP3WdhNqlD9rsr
 sD/GzqbcvTd/ToMAPxuBLFlLgwVD48s6eJYIG/twDduAGGCLQKaY3HV34ncYVK9jYvfBEzsYwUd
 XKwvcapjB90Y7yXHAqt4265hpmhCU=
X-Gm-Gg: AYBFou2ydAr/I068dL6xVhmS1lgqyNs00g5NR2dz+yVhOJJSdaIgXazgdSrmslkO7IX
 72L0x3hUdyq0GC14/o1Vsunw3nFZ7dpYJkrqcOQ+sOr5SRxAqMU2Qbr/R6f/aQoxva1b3wqfKhx
 nPNtYRt4f56R+jGiyd3bCtnyUY0Iur6bPpeCXnZ/0TbE6h6u79ukodCBb4Lii9pbFZJ4LxBvgw9
 /RDK/PWhCjlS9eGCRkrSvKOtTXM+bcRjFlGmvmZdFgtTEaJoNMZ4d/6ahzNUAewcwW78ly02wuN
 HgnOlfBkhKXGTuo2TRedB9bwVN9G/42ZZuowGtyBzQPsfly/XQank9NRVfKp+93bhFaVWzDdWFl
 6oVjyk7lvOFhygAFZPckiiCS+AenPGp/qY2G/E2hhRYSTYn+NHw1Nv6fWsQaAg/7h/UqORxjGel
 G42RcmY5hR7Ap/bY2kBsaRXOojQz6dwHme80+o7dSPbO5EZWJ51moKtgn/GGb6cmIMe/Wx78Eob
 pAX7lz2Zw7uc9ldZPBt
X-Received: by 2002:a05:6214:450f:b0:917:863d:1c39 with SMTP id
 6a1803df08f44-9178645935emr2288366d6.14.1790619861768; 
 Mon, 28 Sep 2026 11:24:21 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430dcba2dsm86077216d6.18.2026.09.28.11.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:24:21 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4] dts: add ipgre test suite
Date: Mon, 28 Sep 2026 14:24:11 -0400
Message-ID: <20260928182411.231797-1-abailey@iol.unh.edu>
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
 dts/tests/TestSuite_ip_gre.py          | 313 +++++++++++++++++++++++++
 3 files changed, 344 insertions(+)
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
index 0000000000..984f48a0be
--- /dev/null
+++ b/dts/tests/TestSuite_ip_gre.py
@@ -0,0 +1,313 @@
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
+            if packet.src_mac == SRC_ID and flags & (packet.hw_ptype | packet.sw_ptype) != flags:
+                return False
+            elif packet.src_mac == SRC_ID:
+                return True
+
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

