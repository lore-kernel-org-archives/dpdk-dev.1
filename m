Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF40CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 20:32:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41C1542DB0;
	Fri, 17 Oct 2025 22:32:08 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 60C99427E8
 for <dev@dpdk.org>; Fri, 17 Oct 2025 22:32:06 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-89048f76ec2so272945785a.1
 for <dev@dpdk.org>; Fri, 17 Oct 2025 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760733126; x=1761337926; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCBJTCjgOw9JHf/B00iIBuqBdkqir01D67qeOwRBfuA=;
 b=ThOIZ4fUSDEG2Wd5qwky6Uhi7XbLhW3j/eZwrCCiHSzfHtyno8IA4455NKIQIfRLr/
 dZkMTK+JWSpbsPaVW68irC0Wb4zUn1SSIN/b0Z3sCGV54Q8fs+pwGNVn/rFn8p2cqAcb
 UHp9lSDMj5RZ3MEWihYl/HngKx1J6/lMx9CH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760733126; x=1761337926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCBJTCjgOw9JHf/B00iIBuqBdkqir01D67qeOwRBfuA=;
 b=M8EcZJwIEmWreMepJ/Wya0d3lh+abEJbRK+Z/dkymKwAwOMWGcnDU6ALk385U3EKXq
 6GDJC6a5UOBqqO3o9dmFwU6LLLor6iPtL7xgmNT4oh26/kZb3L3x7MKNNZYvbcfqTYq2
 VsDFg81mnNS+KiChJ4RQ5P1ci80DTb+sFR8VE0pqKB4sAaozV+fcOuGJdpWQaN4wQ9ZQ
 YQAcYexr+bjVueyDwmz2pCVkLtxSiv6vQB1dj+HqQEGo72lLO3tEt0UT/uMrvjDdmZXs
 2t7H/lUwUvD4aV8FdPfn8wrEnHJQ9W0i81/WKRVIsfEXUmHr05jqmPPPiLYLUobqWpb5
 wDVg==
X-Gm-Message-State: AOJu0Yxf6Mob05Yyo1klzu2Jw6Lcihp6D/OamDXOzqoceikznAwl2h+Z
 +JAD63KSa0zJPx8IK+KH76qvOqJabLpLbUU+3ilJQepDagP0GH6UYZt5H0/TuTi/btI=
X-Gm-Gg: ASbGnctTHcI7VeEJ8DS/JtehKkGJIXNLoNKqaXe5pfD5hZV3/A1dXRg5N6hNBFVxIy7
 qLQaxixOg90OY5V/KUQSInpRsNHHjV7H6USFz5PrGxhLnsPT9lcDO4weDs/DWp2ceYF1vgilfQx
 qy4pFN448YrOcUmf4nEmn3hoLGjDiybo0Lt5K1N3CWGF34+s9la3GuS1Cu75aozVLDx1BiJeY+l
 VRaQXZVQH2E3A3uVvJ5yqbN4j6TUxCW1xullM0vu0xAcNHzVjqV4N77mQx+Z6Epf66kSUKA1AAg
 B+YyH9nsIK07TfXbNNbVIkWtwRRlU44kDSbdCFQz7czdvtZ+VGq1AJpvCPHwTMz7twT07iuDp5t
 obLqtsTM3ogZQixGBhKPug20t7s/MmbLgNUy0E/Az+8IC6TjVUvBr0+pPdZdfHFWHo80=
X-Google-Smtp-Source: AGHT+IE7u8jxk7eoQWS0SQjPGz3VbnAeMuWdJr2vHQNNDD1ijH4qEx5LPGiP5nF/pJ5MiApG8X8fLA==
X-Received: by 2002:a05:622a:8c03:b0:4e8:9e8a:294e with SMTP id
 d75a77b69052e-4e89e8a2d7cmr58373491cf.6.1760733125465; 
 Fri, 17 Oct 2025 13:32:05 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::27b])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm5294531cf.1.2025.10.17.13.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 13:32:03 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: add QinQ test suite
Date: Fri, 17 Oct 2025 16:31:59 -0400
Message-ID: <20251017203159.557830-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017203159.557830-1-dmarx@iol.unh.edu>
References: <20250717205718.108826-1-dmarx@iol.unh.edu>
 <20251017203159.557830-1-dmarx@iol.unh.edu>
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
 dts/tests/TestSuite_qinq.py | 236 ++++++++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)
 create mode 100644 dts/tests/TestSuite_qinq.py

diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
new file mode 100644
index 0000000000..e97f407c1d
--- /dev/null
+++ b/dts/tests/TestSuite_qinq.py
@@ -0,0 +1,236 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""QinQ (802.1ad) Test Suite.
+
+This test suite verifies the correctness and capability of DPDK Poll Mode Drivers (PMDs)
+in handling QinQ-tagged Ethernet frames, which contain a pair of stacked VLAN headers
+(outer S-VLAN and inner C-VLAN). These tests ensure that both software and hardware offloads
+related to QinQ behave as expected across different NIC vendors and PMD implementations.
+"""
+
+from scapy.layers.inet import IP, UDP
+from scapy.layers.l2 import Dot1AD, Dot1Q, Ether
+from scapy.packet import Packet, Raw
+
+from api.capabilities import NicCapability, requires_nic_capability
+from api.testpmd import TestPmd
+from framework.test_suite import TestSuite, func_test
+
+
+class TestQinq(TestSuite):
+    """QinQ test suite.
+
+    This suite consists of 3 test cases:
+    1. QinQ Filter: Enable VLAN filter and verify packets with mismatched VLAN IDs are dropped,
+        and packets with matching VLAN IDs are received.
+    2. QinQ Forwarding: Send a QinQ packet and verify the received packet contains
+        both QinQ/VLAN layers.
+    3. QinQ Strip: Enable VLAN/QinQ stripping and verify sent packets are received with the
+        expected VLAN/QinQ layers.
+    """
+
+    def _send_packet_and_verify(
+        self, packet: Packet, testpmd: TestPmd, should_receive: bool
+    ) -> None:
+        """Send packet and verify reception.
+
+        Args:
+            packet: The packet to send to testpmd.
+            testpmd: The testpmd session to send commands to.
+            should_receive: If :data:`True`, verifies packet was received.
+        """
+        testpmd.start()
+        packets = self.send_packet_and_capture(packet=packet)
+        test_packet = self._get_relevant_packet(packets)
+        if should_receive:
+            self.verify(
+                test_packet is not None, "Packet was dropped when it should have been received."
+            )
+        else:
+            self.verify(
+                test_packet is None, "Packet was received when it should have been dropped."
+            )
+
+    def _strip_verify(self, packet: Packet | None, expects_tag: bool, context: str) -> bool:
+        """Helper method for verifying packet stripping functionality.
+
+        Returns: :data:`True` if tags are stripped or not stripped accordingly,
+            otherwise :data:`False`
+        """
+        if packet is None:
+            self.log(f"{context} packet was dropped when it should have been received.")
+            return False
+
+        if not expects_tag:
+            if packet.haslayer(Dot1Q) or packet.haslayer(Dot1AD):
+                self.log(
+                    f"VLAN tags found in packet when should have been stripped: "
+                    f"{packet.summary()}\tsent packet: {context}",
+                )
+                return False
+
+        if expects_tag:
+            if vlan_layer := packet.getlayer(Dot1Q):
+                if vlan_layer.vlan != 200:
+                    self.log(
+                        f"Expected VLAN ID 200 but found ID {vlan_layer.vlan}: "
+                        f"{packet.summary()}\tsent packet: {context}",
+                    )
+                    return False
+            else:
+                self.log(
+                    f"Expected 0x8100 VLAN tag but none found: {packet.summary()}"
+                    f"\tsent packet: {context}"
+                )
+                return False
+
+        return True
+
+    def _get_relevant_packet(self, packet_list: list[Packet]) -> Packet | None:
+        """Helper method for checking received packet list for sent packet."""
+        for packet in packet_list:
+            if hasattr(packet, "load") and b"xxxxx" in packet.load:
+                return packet
+        return None
+
+    @requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN_EXTEND)
+    @func_test
+    def test_qinq_filter(self) -> None:
+        """QinQ Rx filter test case.
+
+        Steps:
+            Launch testpmd with mac forwarding mode.
+            Enable VLAN filter/extend modes on port 0.
+            Add VLAN tag 100 to the filter on port 0.
+            Send test packet and capture verbose output.
+
+        Verify:
+            Packet with matching VLAN ID is received.
+            Packet with mismatched VLAN ID is dropped.
+        """
+        packets = [
+            Ether(dst="00:11:22:33:44:55", src="66:77:88:99:aa:bb")
+            / Dot1AD(vlan=100)
+            / Dot1Q(vlan=200)
+            / IP(dst="192.0.2.1", src="198.51.100.1")
+            / UDP(dport=1234, sport=5678),
+            Ether(dst="00:11:22:33:44:55", src="66:77:88:99:aa:bb")
+            / Dot1AD(vlan=101)
+            / Dot1Q(vlan=200)
+            / IP(dst="192.0.2.1", src="198.51.100.1")
+            / UDP(dport=1234, sport=5678),
+        ]
+        with TestPmd() as testpmd:
+            testpmd.set_vlan_filter(0, True)
+            testpmd.set_vlan_extend(0, True)
+            testpmd.rx_vlan(100, 0, True)
+            self._send_packet_and_verify(packets[0], testpmd, should_receive=True)
+            self._send_packet_and_verify(packets[1], testpmd, should_receive=False)
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
+        test_packet = (
+            Ether(dst="ff:ff:ff:ff:ff:ff")
+            / Dot1AD(vlan=100)
+            / Dot1Q(vlan=200)
+            / IP(dst="1.2.3.4")
+            / UDP(dport=1234, sport=4321)
+            / Raw(load="xxxxx")
+        )
+        with TestPmd() as testpmd:
+            testpmd.set_vlan_filter(0, False)
+            testpmd.start()
+            received_packets = self.send_packet_and_capture(test_packet)
+            packet = self._get_relevant_packet(received_packets)
+
+            self.verify(packet is not None, "Packet was dropped when it should have been received.")
+
+            if packet is not None:
+                self.verify(bool(packet.haslayer(Dot1AD)), "QinQ layer not found in packet")
+
+                if outer_vlan := packet.getlayer(Dot1AD):
+                    outer_vlan_id = outer_vlan.vlan
+                    self.verify(
+                        outer_vlan_id == 100,
+                        f"Outer VLAN ID was {outer_vlan_id} when it should have been 100.",
+                    )
+                else:
+                    self.verify(False, "VLAN layer not found in received packet.")
+
+                if outer_vlan and (inner_vlan := outer_vlan.getlayer(Dot1Q)):
+                    inner_vlan_id = inner_vlan.vlan
+                    self.verify(
+                        inner_vlan_id == 200,
+                        f"Inner VLAN ID was {inner_vlan_id} when it should have been 200",
+                    )
+
+    @requires_nic_capability(NicCapability.RX_OFFLOAD_QINQ_STRIP)
+    @func_test
+    def test_qinq_strip(self) -> None:
+        """Test combinations of VLAN/QinQ strip settings with various QinQ packets.
+
+        Steps:
+            Launch testpmd with QinQ and VLAN strip enabled.
+            Send four VLAN/QinQ related test packets.
+
+        Verify:
+            Check received packets have the expected VLAN/QinQ layers/tags.
+        """
+        test_packets = [
+            Ether() / Dot1Q() / IP() / UDP(dport=1234, sport=4321) / Raw(load="xxxxx"),
+            Ether()
+            / Dot1Q(vlan=100)
+            / Dot1Q(vlan=200)
+            / IP()
+            / UDP(dport=1234, sport=4321)
+            / Raw(load="xxxxx"),
+            Ether() / Dot1AD() / IP() / UDP(dport=1234, sport=4321) / Raw(load="xxxxx"),
+            Ether() / Dot1AD() / Dot1Q() / IP() / UDP(dport=1234, sport=4321) / Raw(load="xxxxx"),
+        ]
+        with TestPmd() as testpmd:
+            testpmd.set_qinq_strip(0, True)
+            testpmd.set_vlan_strip(0, True)
+            testpmd.start()
+
+            received_packets1 = self.send_packet_and_capture(test_packets[0])
+            packet1 = self._get_relevant_packet(received_packets1)
+            received_packets2 = self.send_packet_and_capture(test_packets[1])
+            packet2 = self._get_relevant_packet(received_packets2)
+            received_packets3 = self.send_packet_and_capture(test_packets[2])
+            packet3 = self._get_relevant_packet(received_packets3)
+            received_packets4 = self.send_packet_and_capture(test_packets[3])
+            packet4 = self._get_relevant_packet(received_packets4)
+
+            testpmd.stop()
+
+            tests = [
+                ("Single 8100 tag", self._strip_verify(packet1, False, "Single 8100 tag")),
+                (
+                    "Double 8100 tag",
+                    self._strip_verify(packet2, True, "Double 8100 tag"),
+                ),
+                ("Single 88a8 tag", self._strip_verify(packet3, False, "Single 88a8 tag")),
+                (
+                    "QinQ (88a8 and 8100 tags)",
+                    self._strip_verify(packet4, False, "QinQ (88a8 and 8100 tags)"),
+                ),
+            ]
+
+            failed = [ctx for ctx, result in tests if not result]
+
+            self.verify(
+                not failed,
+                f"The following packets were not stripped correctly: {', '.join(failed)}",
+            )
-- 
2.51.0

