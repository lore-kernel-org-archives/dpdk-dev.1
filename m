Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D91ECD98D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 19:03:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C720B40E28;
	Thu, 13 Nov 2025 20:03:14 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 5BC6940E21
 for <dev@dpdk.org>; Thu, 13 Nov 2025 20:03:14 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-882475d8851so12125586d6.2
 for <dev@dpdk.org>; Thu, 13 Nov 2025 11:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763060594; x=1763665394; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2sC07r1shjE7RYNGMUvwMYbGPtdaV5cqKfitiF3d9E=;
 b=GmNGT+5oPP4y5Q5fRRphXstHLYnG5hrAOjaJPHeUoJn+Vl5le6qYfjKkZyFAR6bOdo
 NNd4g9gEhNgPiZ1sFyCPIUwGTFovOlanCD8r/oQY7SdetvK8MT3AP7+uC0Dn0sFLkgYW
 zTcdSXG0dTUSpPNQnmRC0HApKxMMKfffbi0GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763060594; x=1763665394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z2sC07r1shjE7RYNGMUvwMYbGPtdaV5cqKfitiF3d9E=;
 b=CgXlJ39uQYZHSPQNN8eCyIaRyOBj3w64pHvNnpf2EqMAgAzPHnQamyjV1XowfISWtb
 vka7GxD2DN8iPliuDlthjSa8HL+/QNWV6NHc7LrzGyssF5d5fE4c0ssgqgMPrKcVV1tj
 dXlBn254QjzxN45qB3QLsUZSRG+YIIqId2Lzbk/DqTdeEDaLQwW5AXmZpsgjWdXo2d84
 ds9kNK9i8vgjUHydvSO4fDYIP+2/rJMHb2Lq8+OhC/FB6NMgEJXctRg00LRzzMSlNzel
 WA/DA7DY6HcHVunv1Y5q2WKI6lR+1lz22p7lYUEEt3epoYAXi2bTJjEmHiT1wXADf61H
 Yk2A==
X-Gm-Message-State: AOJu0YzCRGradAM9Q+kDoe3yO2JrneTL6asQrH9k9MMnVKwozmOI6xAf
 kEu3a/w/pBi5yIXvej3J9vU8kAhH2KvPe6SyUOkuYFk6+PHO/jLyHQpm4Pz7c7nU9tk=
X-Gm-Gg: ASbGnct2ADJq7pP83r3mMs7q5svFy02+Tclj/o1AA7Fy0y1uVUgx9Y2Cs/HTyDSf5mh
 g6s4T3LFpwJE1sYuv9Fifoku9O737jlEtx3uzeFziJ/zlJnRb2VGGGXyYDouQOgMsbBCNznCEC/
 EkTDt7aYwLju99ag9YHwXKu0SBXPul4PR3GxvaNG4sER5T9QHDRNkJgcwZdNpKVITbYAtnX4htf
 eCeHUpbGtrSQWTMkv2kgOeQ8TUlHHDPC0jj3PnLP5ScMUjk2c5QepQ++4O7XzZdJhF9QqL1+s4M
 Gq73QbhVzITHmThNLD9GdbxiqYOHvsLPBQ77TnQ2J0tneD3mSj4fNZDgtQdRRdsVi3l3c3E53Do
 EOkNnpuklvIz2BS68Y84TmokFfhVTz3cncwTE8T0lYPNm3P8RJYK3rLOpsmPyC49QIAVtNrUZWi
 OhgswkIB9DiO9Nhw==
X-Google-Smtp-Source: AGHT+IFhQ5UhDan0pO3Jcga+UMCa0nyOOR1cIzdq7atyDFhZoR+fPriFGFc8H5+fGN4t9uNSI3niBA==
X-Received: by 2002:ad4:5bc5:0:b0:880:5279:98eb with SMTP id
 6a1803df08f44-882926d561dmr2676096d6.44.1763060593554; 
 Thu, 13 Nov 2025 11:03:13 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-882865d3e25sm17248076d6.61.2025.11.13.11.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 11:03:13 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 2/2] dts: add QinQ test suite
Date: Thu, 13 Nov 2025 14:03:09 -0500
Message-ID: <20251113190309.310821-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113190309.310821-1-dmarx@iol.unh.edu>
References: <20251024181606.604135-2-dmarx@iol.unh.edu>
 <20251113190309.310821-1-dmarx@iol.unh.edu>
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
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/tests/TestSuite_qinq.py | 204 ++++++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 dts/tests/TestSuite_qinq.py

diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
new file mode 100644
index 0000000000..953c2c1629
--- /dev/null
+++ b/dts/tests/TestSuite_qinq.py
@@ -0,0 +1,204 @@
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
+from api.packet import send_packet_and_capture
+from api.test import log, verify
+from api.testpmd import TestPmd
+from framework.test_suite import TestSuite, func_test
+
+
+class TestQinq(TestSuite):
+    """QinQ test suite.
+
+    This suite consists of 2 test cases:
+    1. QinQ Forwarding: Send a QinQ packet and verify the received packet contains
+        both QinQ/VLAN layers.
+    2. QinQ Strip: Enable VLAN/QinQ stripping and verify sent packets are received with the
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
+        packets = send_packet_and_capture(packet=packet)
+        test_packet = self._get_relevant_packet(packets)
+        if should_receive:
+            verify(test_packet is not None, "Packet was dropped when it should have been received.")
+        else:
+            verify(test_packet is None, "Packet was received when it should have been dropped.")
+
+    def _strip_verify(self, packet: Packet | None, expects_tag: bool, context: str) -> bool:
+        """Helper method for verifying packet stripping functionality.
+
+        Returns: :data:`True` if tags are stripped or not stripped accordingly,
+            otherwise :data:`False`
+        """
+        if packet is None:
+            log(f"{context} packet was dropped when it should have been received.")
+            return False
+
+        if not expects_tag:
+            if packet.haslayer(Dot1Q) or packet.haslayer(Dot1AD):
+                log(
+                    f"VLAN tags found in packet when should have been stripped: "
+                    f"{packet.summary()}\tsent packet: {context}",
+                )
+                return False
+
+        if expects_tag:
+            if vlan_layer := packet.getlayer(Dot1Q):
+                if vlan_layer.vlan != 200:
+                    log(
+                        f"Expected VLAN ID 200 but found ID {vlan_layer.vlan}: "
+                        f"{packet.summary()}\tsent packet: {context}",
+                    )
+                    return False
+            else:
+                log(
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
+            received_packets = send_packet_and_capture(test_packet)
+            packet = self._get_relevant_packet(received_packets)
+
+            verify(packet is not None, "Packet was dropped when it should have been received.")
+
+            if packet is not None:
+                verify(
+                    bool(packet.haslayer(Dot1AD)) and bool(packet.haslayer(Dot1Q)),
+                    "QinQ/VLAN layers not found in packet",
+                )
+
+                if outer_vlan := packet.getlayer(Dot1AD):
+                    outer_vlan_id = outer_vlan.vlan
+                    verify(
+                        outer_vlan_id == 100,
+                        f"Outer VLAN ID was {outer_vlan_id} when it should have been 100.",
+                    )
+                else:
+                    verify(False, "VLAN layer not found in received packet.")
+
+                if outer_vlan and (inner_vlan := outer_vlan.getlayer(Dot1Q)):
+                    inner_vlan_id = inner_vlan.vlan
+                    verify(
+                        inner_vlan_id == 200,
+                        f"Inner VLAN ID was {inner_vlan_id} when it should have been 200",
+                    )
+
+    @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_QINQ_STRIP)
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
+            received_packets1 = send_packet_and_capture(test_packets[0])
+            vlan_packet = self._get_relevant_packet(received_packets1)
+            received_packets2 = send_packet_and_capture(test_packets[1])
+            double_vlan_packet = self._get_relevant_packet(received_packets2)
+            received_packets3 = send_packet_and_capture(test_packets[2])
+            single_88a8_packet = self._get_relevant_packet(received_packets3)
+            received_packets4 = send_packet_and_capture(test_packets[3])
+            qinq_packet = self._get_relevant_packet(received_packets4)
+
+            testpmd.stop()
+
+            tests = [
+                ("Single 8100 tag", self._strip_verify(vlan_packet, False, "Single 8100 tag")),
+                (
+                    "Double 8100 tag",
+                    self._strip_verify(double_vlan_packet, True, "Double 8100 tag"),
+                ),
+                (
+                    "Single 88a8 tag",
+                    self._strip_verify(single_88a8_packet, False, "Single 88a8 tag"),
+                ),
+                (
+                    "QinQ (88a8 and 8100 tags)",
+                    self._strip_verify(qinq_packet, False, "QinQ (88a8 and 8100 tags)"),
+                ),
+            ]
+
+            failed = [ctx for ctx, result in tests if not result]
+
+            verify(
+                not failed,
+                f"The following packets were not stripped correctly: {', '.join(failed)}",
+            )
-- 
2.51.0

