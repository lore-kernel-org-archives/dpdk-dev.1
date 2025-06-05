Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB806C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 18:42:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12189402D5;
	Thu,  5 Jun 2025 20:41:52 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 5C0E240613
 for <dev@dpdk.org>; Thu,  5 Jun 2025 20:41:50 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7d219896edeso143707185a.1
 for <dev@dpdk.org>; Thu, 05 Jun 2025 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1749148910; x=1749753710; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwo0nmUx4OjI608lkGL1epPVbIg+5z3idz1ns1dBWdk=;
 b=R/IoKQGGh0Mxx5yzyC1+tuhMYATeTieyb8JBWFtXQFTnt/7WONy52Ms/oX3TcXpiqN
 Pa4FycgawHiVBIGtNh2rawpw4/tYHaDZDuxduYYIYhxdK4pzk22qtLukTNThgxo5jhVK
 kUOZr4Qe4jBP0O8Ol8Gqt251uCnONfVKp7l1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749148910; x=1749753710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zwo0nmUx4OjI608lkGL1epPVbIg+5z3idz1ns1dBWdk=;
 b=mB5MmZILSW8eI64+LZJHh0IIft+Wx53S2ZGOJiz+4D/1nHOM5SUGKqQIwvmRrJsJVg
 NUoxzg6uvTRVtjv/PdrozdOKUbesjzMuC2rwxrjVJdJ5mzsWUEvyFVf3GUiU0GLFBA2p
 v+igY7AhU38olCGxbeAUhoJTiVGLMt2uIg+tZqkOBBBYdjmVNL3qbsxWwkPt94/jJym/
 fEOEmqaWQrJJ0iHL/i8ir7I8nKt3k7VCt5zeGAqJ3cfBTMu8JJprcgZAz8MYxZbq7wJv
 TmxghdAzP80PRkuq7eQdzD4L+6pBx7rPk5q0syZO/EX3EpO8NipHQlZDtaoX0JaNnUWg
 HY7g==
X-Gm-Message-State: AOJu0Yw1lzb564FoOqv2XV6KRTpVGBK0/zIK8okp4WAz1evK+675LyJ4
 qkVh/WE7krU9W66nNNnetLbPr9IfwGXDmOuxd8Qa4PqxLc2M1yJnNIeoMYg+mex4rP4=
X-Gm-Gg: ASbGncs1H3jGGwwlsg1gAO7Purl+3z2SpbmhWYudgnUZp0Pvd2ZpFjIO+TlBhLQNjHr
 4XWQpLFq3BRnuZqSsvbCay+M+vwylEBfNHNUQAwdTuIv66Yf7psjcJAJhNOgKCo3uYl4ON6ccZ8
 iXAtowwn+RVlZtnGL3bBFYOiFTs2WLL9nk4wkBKXXp6dOs5wMyrzvGNoZkSnEom330sSP3KvOk5
 0WMAQNdO9oPJjt0frA11khcEkvEjEtbWBp82OF5HWRvvd6dcoWTrweoNPAZdztoKtwPWt+EFopt
 zqvILenIvo3iix+EHsDBISNMHbWEQyvylDJxUgGnTgs=
X-Google-Smtp-Source: AGHT+IHbfWAK6n/EXe02tAhHyj28u9Q5IPvlq8Kx88hgKYHCL6ANuKXOJwRbpsgzGOhC8gZN6P8L5w==
X-Received: by 2002:a05:620a:26a6:b0:7d0:96e8:4797 with SMTP id
 af79cd13be357-7d2298ce89bmr96251885a.45.1749148909570; 
 Thu, 05 Jun 2025 11:41:49 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d250f64b8bsm3865385a.8.2025.06.05.11.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 11:41:49 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [RFC PATCH 2/2] dts: add qinq test suite
Date: Thu,  5 Jun 2025 14:41:43 -0400
Message-ID: <20250605184143.498892-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605184143.498892-1-dmarx@iol.unh.edu>
References: <20250605184143.498892-1-dmarx@iol.unh.edu>
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

Add QinQ test suite, which verifies PMD behavior when
sending QinQ (IEEE 802.1ad) packets.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_qinq.py | 240 ++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)
 create mode 100644 dts/tests/TestSuite_qinq.py

diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
new file mode 100644
index 0000000000..4bfa2c1920
--- /dev/null
+++ b/dts/tests/TestSuite_qinq.py
@@ -0,0 +1,240 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""QinQ (802.1ad) Test Suite.
+
+This test suite verifies the correctness and capability of DPDK Poll Mode Drivers (PMDs)
+in handling QinQ-tagged Ethernet frames, which contain a pair of stacked VLAN headers
+(outer S-VLAN and inner C-VLAN). These tests ensure that both software and hardware offloads
+related to QinQ behave as expected across different NIC vendors and PMD implementations.
+
+"""
+
+from scapy.layers.inet import IP, UDP
+from scapy.layers.l2 import Dot1Q, Ether
+from scapy.packet import Packet
+
+from framework.params.testpmd import SimpleForwardingModes
+from framework.remote_session.testpmd_shell import PacketOffloadFlag, TestPmdShell
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import NicCapability, TopologyType, requires
+
+
+@requires(topology_type=TopologyType.two_links)
+@requires(NicCapability.RX_OFFLOAD_VLAN_FILTER)
+@requires(NicCapability.RX_OFFLOAD_VLAN_EXTEND)
+class TestQinq(TestSuite):
+    """QinQ test suite.
+
+    This suite consists of 3 test cases:
+    1. QinQ Rx parse: Ensures correct classification and detection of double VLAN packets (QinQ).
+    2. QinQ strip: Validates hardware offload of VLAN header removal and correct TCI population.
+    3. QinQ filter:
+
+    """
+
+    def send_packet_and_verify_offload_flags(
+        self, packet: Packet, testpmd: TestPmdShell, offload_flags: list[PacketOffloadFlag]
+    ) -> None:
+        """Send packet and verify offload flags match the stripping action.
+
+        Args:
+            packet: The packet to send to testpmd.
+            testpmd: The testpmd session to send commands to.
+            offload_flags: List of PacketOffloadFlags that should be in verbose output.
+        """
+        testpmd.start()
+        self.send_packet_and_capture(packet=packet)
+        verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+        for flag in offload_flags:
+            self.verify(flag in verbose_output, f"Expected flag {flag} not found in output")
+
+    def send_packet_and_verify(
+        self, packet: Packet, testpmd: TestPmdShell, should_receive: bool
+    ) -> None:
+        """Send packet and verify reception.
+
+        Args:
+            packet: The packet to send to testpmd.
+            testpmd: The testpmd session to send commands to.
+            should_receive: If :data:`True`, verifies packet was received.
+        """
+        testpmd.start()
+        received = self.send_packet_and_capture(packet=packet)
+        if should_receive:
+            self.verify(received != [], "Packet was dropped when it should have been received.")
+        else:
+            self.verify(received == [], "Packet was received when it should have been dropped.")
+
+    @property
+    def test_packet(self):
+        """QinQ packet to be used in each test case."""
+        return (
+            Ether(dst="ff:ff:ff:ff:ff:ff")
+            / Dot1Q(vlan=100, type=0x8100)
+            / Dot1Q(vlan=200)
+            / IP(dst="1.2.3.4")
+            / UDP(dport=1234, sport=4321)
+        )
+
+    @func_test
+    def test_qinq_rx_parse(self) -> None:
+        """QinQ Rx parse test case.
+
+        Steps:
+            Launch testpmd with Rxonly forwarding mode.
+            Set verbose level to 1.
+            Enable VLAN filter/extend modes on port 0.
+            Send test packet and capture verbose output.
+
+        Verify:
+            Check that all expected offload flags are in verbose output.
+        """
+        offload_flags = [PacketOffloadFlag.RTE_MBUF_F_RX_QINQ, PacketOffloadFlag.RTE_MBUF_F_RX_VLAN]
+        with TestPmdShell(forward_mode=SimpleForwardingModes.rxonly) as testpmd:
+            testpmd.set_verbose(level=1)
+            testpmd.stop_all_ports()
+            testpmd.set_vlan_filter(0, True)
+            testpmd.set_vlan_extend(0, True)
+            testpmd.start_all_ports()
+            self.send_packet_and_verify_offload_flags(self.test_packet, testpmd, offload_flags)
+
+    @requires(NicCapability.RX_OFFLOAD_QINQ_STRIP)
+    @func_test
+    def test_qinq_strip(self) -> None:
+        """QinQ Rx strip test case.
+
+        Steps:
+            Launch testpmd with Rxonly forwarding mode.
+            Set verbose level to 1.
+            Enable VLAN filter/extend modes on port 0.
+            Enable QinQ strip mode on port 0.
+            Send test packet and capture verbose output.
+
+        Verify:
+            Check that all expected offload flags are in verbose output.
+        """
+        offload_flags = [
+            PacketOffloadFlag.RTE_MBUF_F_RX_QINQ_STRIPPED,
+            PacketOffloadFlag.RTE_MBUF_F_RX_VLAN_STRIPPED,
+            PacketOffloadFlag.RTE_MBUF_F_RX_VLAN,
+            PacketOffloadFlag.RTE_MBUF_F_RX_QINQ,
+        ]
+        with TestPmdShell(forward_mode=SimpleForwardingModes.rxonly) as testpmd:
+            testpmd.set_verbose(level=1)
+            testpmd.stop_all_ports()
+            testpmd.set_vlan_filter(0, True)
+            testpmd.set_vlan_extend(0, True)
+            testpmd.set_qinq_strip(0, True)
+            testpmd.start_all_ports()
+            self.send_packet_and_verify_offload_flags(self.test_packet, testpmd, offload_flags)
+
+    @func_test
+    def test_qinq_filter(self) -> None:
+        """QinQ Rx filter test case.
+
+        Steps:
+            Launch testpmd with Rxonly forwarding mode.
+            Enable VLAN filter/extend modes on port 0.
+            Add VLAN tag 100 to the filter on port 0.
+            Send test packet and capture verbose output.
+
+        Verify:
+            Check that all expected offload flags are in verbose output.
+        """
+        packets = [
+            Ether(dst="00:11:22:33:44:55", src="66:77:88:99:aa:bb")
+            / Dot1Q(vlan=100)
+            / Dot1Q(vlan=200)
+            / IP(dst="192.0.2.1", src="198.51.100.1")
+            / UDP(dport=1234, sport=5678),
+            Ether(dst="00:11:22:33:44:55", src="66:77:88:99:aa:bb")
+            / Dot1Q(vlan=101)
+            / Dot1Q(vlan=200)
+            / IP(dst="192.0.2.1", src="198.51.100.1")
+            / UDP(dport=1234, sport=5678),
+        ]
+        with TestPmdShell(forward_mode=SimpleForwardingModes.rxonly) as testpmd:
+            testpmd.stop_all_ports()
+            testpmd.set_vlan_filter(0, True)
+            testpmd.set_vlan_extend(0, True)
+            testpmd.start_all_ports()
+            testpmd.rx_vlan(100, 0)
+            self.send_packet_and_verify(packets[0], testpmd, should_receive=True)
+            self.send_packet_and_verify(packets[1], testpmd, should_receive=False)
+
+    @func_test
+    def test_qinq_forwarding(self) -> None:
+        """QinQ Rx filter test case.
+
+        Steps:
+            Launch testpmd with mac forwarding mode.
+            Disable VLAN filter mode on port 0.
+            Send test packet and capture verbose output.
+
+        Verify:
+            Check that the received packet has two separate VLAN layers in proper QinQ fashion.
+            Check that the received packet outer and inner VLAN layer has the appropriate ID.
+        """
+        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
+            testpmd.stop_all_ports()
+            testpmd.set_vlan_filter(0, False)
+            testpmd.start_all_ports()
+            received_packet = self.send_packet_and_capture(self.test_packet)
+            for packet in received_packet:
+                vlan_tags = [layer for layer in packet.layers() if layer == Dot1Q]
+                self.verify(len(vlan_tags) == 2, f"Expected 2 VLAN tags, found {len(vlan_tags)}")
+
+                if packet.haslayer(Dot1Q):
+                    outer_vlan_id = packet[Dot1Q].vlan
+                    self.verify(
+                        outer_vlan_id == 100,
+                        f"Outer VLAN ID was {outer_vlan_id} when it should have been 100.",
+                    )
+
+                if packet[Dot1Q].haslayer(Dot1Q):
+                    inner_vlan_id = packet[Dot1Q].payload[Dot1Q].vlan
+                    self.verify(
+                        inner_vlan_id == 200,
+                        f"Inner VLAN ID was {inner_vlan_id} when it should have been 200",
+                    )
+
+    @func_test
+    def test_mismatched_tpid(self) -> None:
+        """Test behavior when outer VLAN tag has a non-standard TPID (not 0x8100 or 0x88a8).
+
+        Steps:
+            Launch testpmd in rxonly forward mode.
+            Set verbose level to 1.
+            Disable VLAN filtering on port 0.
+            Send and capture test packet.
+
+        Verify:
+            Only 1 VLAN tag is in received packet.
+            Inner VLAN ID matches the original packet.
+        """
+        with TestPmdShell(forward_mode=SimpleForwardingModes.rxonly) as testpmd:
+            testpmd.set_verbose(level=1)
+            testpmd.stop_all_ports()
+            testpmd.set_vlan_filter(0, False)
+            testpmd.start_all_ports()
+
+            mismatched_packet = (
+                Ether(dst="ff:ff:ff:ff:ff:ff")
+                / Dot1Q(vlan=100, type=0x1234)
+                / Dot1Q(vlan=200)
+                / IP(dst="1.2.3.4")
+                / UDP(dport=1234, sport=4321)
+            )
+
+            received_packet = self.send_packet_and_capture(mismatched_packet)
+
+            for packet in received_packet:
+                vlan_tags = [layer for layer in packet.layers() if layer == Dot1Q]
+                self.verify(
+                    len(vlan_tags) == 1,
+                    f"Expected 1 VLAN tag due to mismatched TPID, found {len(vlan_tags)}",
+                )
+
+                vlan_id = packet[Dot1Q].vlan
+                self.verify(vlan_id == 200, f"Expected inner VLAN ID 200, got {vlan_id}")
-- 
2.49.0

