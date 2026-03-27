Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9334D10F2863
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 18:02:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A38A740E49;
	Fri, 27 Mar 2026 19:02:47 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 27431402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 19:02:46 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-89cc638496aso24208746d6.0
 for <dev@dpdk.org>; Fri, 27 Mar 2026 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774634565; x=1775239365; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ysMrsB9ih5snTUoFofO4KMOI1b0sMfsNuXVPuAy/bM=;
 b=C64YzN+fUgQz3sgAqTlfjDFnhi/Yl+XL5tNP8BHKMzrd0hEdzdYqBHwxhiJkkEuCMi
 JGd4N2pu6q/eQS1+dnmsZ0Gy5e7NjEpKhGbsuWj3n1llDgZHgwmQ1a7oFTTPvfUPfvks
 V22Zdkv1/wuu+M/rVkpVqBm//bQnCTFZ1A+uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774634565; x=1775239365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ysMrsB9ih5snTUoFofO4KMOI1b0sMfsNuXVPuAy/bM=;
 b=WHQbnBZaLrKpVrb4S7rgK7CBzxVkcfQBUCapC3ugMPxBCHyTcm2ZUXQ9Y7Ol5KrMxQ
 xpjD5C+C4NhXkJtK8sn2k+pe7xBoEsV9raT/ROamLBQucLcuE6zVNTp1mim+BZCeYPUJ
 SEGZpxJQ0pHsJx+/7fZmVtK5XIWv6S+pYE9uZR5onHa/wiEzCKzO3WMLulvFsIHKJqQj
 ojgEIF0w6P7N/HLv/CNpR2lLYorQyFHMWxuNqaun+DYMqqIj6YkhPgXSjFurr1FWKxG2
 L+KqInbTCuk+UpkjWRSvDyMLjyIw/Vkqzu0sLVV3OaS9S8D4AMurX6d7SmXE7BG4EhmL
 GUSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMU0Ei4azczutrjByR5VjdG4zz53FX5W8JdHlDiZIf1cbGN3pZXLzoExcu6WzTwlPx9Ls=@dpdk.org
X-Gm-Message-State: AOJu0YzeZEsykRpgVCWsh8w4DLR/zuZgOVdzR1zIbDt6EzeViiJ3CH6C
 oz024F1OMH21AUWeXbdW4/5xrnYzDE2/7xzEOtS30xb6F14BOO41SCf7eUCXoFD41sU=
X-Gm-Gg: ATEYQzy2TDVurftdYAPZ9eK9KWljqJPQuTBblupwwbd9AmkM739X5VH4K61v+O5MkxW
 /JOXKoR5S3rOn1oIhn7htNvY+GhhBzQ3AS2rT60xy7v02419yM/ifDCcvkoEfKfOTmxEhRA5vUp
 b9v+ZfwJvZT4nQIXd4R++YaCXIjMmGlchMkTmx1rVZr4KL8Alc6c5CxJdBm1gx9GBa9DqVQ6MOW
 NmFWsNMlSCm6pzVQzlD4LWTVWkp+a6xXN2tzLOiS7dfG9CBOgm5gd6rGHyPdE5tYw5j6r0bOj5G
 5rKR1HRrqbkgtNhtKV5M2pNNo4oDVYqO4RPq6GHJFf/SV5amzJ6Jlm72ByQSgjuqRELIZAcLCsq
 GX9DxuJyn1Jv+R22W/TvT387+ZonwBXVdEI5Jkutpa+iaO6fOLLYcCcGHoblPixpHwg3gk0ZQyT
 PFxssIy/NWQDacncvkoxMQ2H7vC2rxM97z0xKUkxDtOL3GMzjRo83UZSeESq1x0HbU
X-Received: by 2002:a05:6214:21e6:b0:895:4c2b:343f with SMTP id
 6a1803df08f44-89ce8da89c2mr49020706d6.19.1774634564239; 
 Fri, 27 Mar 2026 11:02:44 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd56f1caasm55206686d6.0.2026.03.27.11.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 11:02:43 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu,
	dev@dpdk.org
Cc: dmarx@iol.unh.edu, knimoji@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: add ipgre test suite
Date: Fri, 27 Mar 2026 14:02:32 -0400
Message-ID: <20260327180232.443820-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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
 dts/tests/TestSuite_ip_gre.py          | 301 +++++++++++++++++++++++++
 3 files changed, 332 insertions(+)
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
index e9187440bb..33bf5e63de 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -951,6 +951,29 @@ def set_flow_control(
                     f"Testpmd failed to set the {flow_ctrl} in port {port}."
                 )
 
+    def set_csum_parse_tunnel(self, port: int, on: bool, verify: bool = True) -> None:
+        """Set parse tunnel on or of in testpmd for a given port.
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
+        output = self.send_command(f"csum parse-tunnel {"on" if on else "off"} {port}")
+        if verify and f"Parse tunnel is {'on' if on else'off'}" not in output:
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
index 0000000000..fc51eef181
--- /dev/null
+++ b/dts/tests/TestSuite_ip_gre.py
@@ -0,0 +1,301 @@
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
+SRC_ID = "FF:FF:FF:FF:FF:FF"
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
+            if packet.src_mac == SRC_ID:
+                if flags not in packet.hw_ptype and flags not in packet.sw_ptype:
+                    return False
+        return True
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
+        self, testpmd: TestPmd, expected_flags: list[RtePTypes], packet_list=list[Packet]
+    ) -> None:
+        """Sets the forwarding and verbose mode of each test case interactive shell session."""
+        testpmd.set_forward_mode(SimpleForwardingModes.rxonly)
+        testpmd.set_verbose(level=1)
+        for i in range(0, len(packet_list)):
+            testpmd.start(verify=True)
+            self._send_packet_and_verify_flags(
+                expected_flag=expected_flags[i], packet=packet_list[i], testpmd=testpmd
+            )
+
+    def _send_packet_and_verify_checksum(
+        self, packet: Packet, good_L4: bool, good_IP: bool, testpmd: TestPmd
+    ) -> None:
+        """Send packet and verify verbose output matches expected output."""
+        testpmd.start()
+        send_packet_and_capture(packet=packet)
+        verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+        is_IP = is_L4 = None
+        for testpmd_packet in verbose_output:
+            if testpmd_packet.src_mac == SRC_ID:
+                is_IP = PacketOffloadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD in testpmd_packet.ol_flags
+                is_L4 = PacketOffloadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD in testpmd_packet.ol_flags
+        verify(
+            is_IP is not None and is_L4 is not None,
+            "Test packet was dropped when it should have been received.",
+        )
+        verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
+        verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")
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
+            RtePTypes.L2_ETHER_VLAN
+            | RtePTypes.L3_IPV4
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_UDP,
+            RtePTypes.L2_ETHER_VLAN
+            | RtePTypes.L3_IPV4
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_TCP,
+            RtePTypes.L2_ETHER_VLAN
+            | RtePTypes.L3_IPV4
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_SCTP,
+        ]
+        with TestPmd() as testpmd:
+            self._setup_session(testpmd=testpmd, expected_flags=flags, packet_list=packets)
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
+            RtePTypes.L2_ETHER_VLAN
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_UDP,
+            RtePTypes.L2_ETHER_VLAN
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_TCP,
+            RtePTypes.L2_ETHER_VLAN
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV4
+            | RtePTypes.INNER_L4_SCTP,
+        ]
+        with TestPmd() as testpmd:
+            self._setup_session(testpmd=testpmd, expected_flags=flags, packet_list=packets)
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
+            RtePTypes.L2_ETHER_VLAN
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV6
+            | RtePTypes.INNER_L4_UDP,
+            RtePTypes.L2_ETHER_VLAN
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV6
+            | RtePTypes.INNER_L4_TCP,
+            RtePTypes.L2_ETHER_VLAN
+            | RtePTypes.L3_IPV6
+            | RtePTypes.TUNNEL_GRE
+            | RtePTypes.INNER_L3_IPV6
+            | RtePTypes.INNER_L4_SCTP,
+        ]
+        with TestPmd() as testpmd:
+            self._setup_session(testpmd=testpmd, expected_flags=flags, packet_list=packets)
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
+            Ether(src=SRC_ID) / IP() / GRE() / IP(chksum=0x0) / TCP(),
+            Ether(src=SRC_ID) / IP() / GRE() / IP() / TCP(chksum=0x0),
+            Ether(src=SRC_ID) / IP() / GRE() / IP() / UDP(chksum=0xFFFF),
+            Ether(src=SRC_ID) / IP() / GRE() / IP() / SCTP(chksum=0x0),
+        ]
+        good_l4_ip = [
+            (True, True),
+            (True, False),
+            (False, True),
+            (False, True),
+            (False, True),
+        ]
+        with TestPmd() as testpmd:
+            testpmd.set_forward_mode(SimpleForwardingModes.csum)
+            testpmd.csum_set_hw(
+                layers=ChecksumOffloadOptions.ip
+                | ChecksumOffloadOptions.udp
+                | ChecksumOffloadOptions.outer_ip
+                | ChecksumOffloadOptions.sctp
+                | ChecksumOffloadOptions.tcp,
+                port_id=0,
+            )
+            testpmd.set_csum_parse_tunnel(port=0, on=True)
+            testpmd.set_verbose(1)
+            testpmd.start_all_ports()
+            testpmd.start()
+            for i in range(len(packets)):
+                self._send_packet_and_verify_checksum(
+                    packets[i],
+                    good_l4_ip[i][0],
+                    good_l4_ip[i][1],
+                    testpmd,
+                )
-- 
2.50.1

