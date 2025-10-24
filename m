Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D3FCCF9EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 18:16:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D61E40395;
	Fri, 24 Oct 2025 20:16:14 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id ECBC54021E
 for <dev@dpdk.org>; Fri, 24 Oct 2025 20:16:10 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-893c373500cso245550585a.0
 for <dev@dpdk.org>; Fri, 24 Oct 2025 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761329770; x=1761934570; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RD6BvLjdMG+dwuQrWcrGyEsVMJiJS4SIop/HuFyQ3pA=;
 b=QNd+nDyaghGY4ih5dftWmUvyhvJNI332GeVqYqot38nXBRDZoMR6Qj2Ixew4hd+A/K
 ctRZOivf57BBRmDk3vbpRoJeXKMB1zioYwlDLd8bHPL6Mfxish34V8442auhtCL0xxrq
 STVZX256ATzgFNxDeH7jKttmDJmVCqn8YV49E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761329770; x=1761934570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RD6BvLjdMG+dwuQrWcrGyEsVMJiJS4SIop/HuFyQ3pA=;
 b=ejznXePs5bzb6k/qASzQ+RnnLLMJPr0AhfEge5neoREq2Li7IRFRG7XINIo8dlr5ZV
 vrxACUJmQ/rc+K3JevCxurQlTyPYYcB9XjUn7aMCAqX8LBLn2XgZP3fN8FYvUEyh+fEF
 aPRBm1r2rITK4heZcCi4y46RW+7n5ehNkarkd4vgkN7qs7VgMTPCg18cWwXOecsXip6Y
 VZAaoXvn2eo1Lhy2VYygleSFYMdkePNPeFzfouKvSReM3TXYvOzqr/GSfY6pFDT4oxeu
 SRUtOxJb6Nv2ht++Cl6tTHtrlIxidWcANeMWTp4sVLYVyvpQtePGH4OvN807qJmktHBp
 GOng==
X-Gm-Message-State: AOJu0YwoVz5GDINubcRk4rsOeXu20Svlgq+rPUHAZ9BitbQHzykgrjXf
 a05dlM263U+b/XZGIZdx/zSbMKhR2QUakUq/m3FMbQenZNqghBjWwYBFxLuVEWIQeq0=
X-Gm-Gg: ASbGncumr5ZlnSB3JvL8Aw3kT9h+WziwwR/wK0H8yOgpX3e6x5bYh1LHPRSjyhporXk
 QkoXoAHY5ohYAUwFId7bdGi1kLDkU6sijCgo+j4zsTOztUjJ5WuKBneEZZO8v6G8r295n5U4w02
 Cm0rJwrKtiOZ801ZFlWFhrgrBhAeXp7n49n3YXeWelc09GGWQ9OzZohkvHS/qbWN1zLXNgFaR5k
 E++W+Kfb4y1XFq3TUDZ1+1npxhbszjhhzaLI9M2a7tW08D/RzK//J7VF11dkLIvEhFfPYjO9zYX
 AHjmClNUmBKdqELkvc02yQ8lNehPHeWMOu5TdYR0qiDPPdCvhjWqI/3Ly7UxGCilSUdqJAl4j2/
 8mEgFAOuT6k2SL/WZVuGtfPCBmIDQJqc8sD39UaZm8G/DtPwtgT6kp6OxX3txaYK5MR7qQlsZ6L
 RiFgE=
X-Google-Smtp-Source: AGHT+IFvbQ1tj2gbuadw1oS4bl9htToECM0FJWTDgC4NLlbRrCyTA3+W27wwyg/n1iiW8+ytExnpBQ==
X-Received: by 2002:a05:620a:1999:b0:85f:fd7c:865a with SMTP id
 af79cd13be357-89da0e23f13mr472849285a.21.1761329770060; 
 Fri, 24 Oct 2025 11:16:10 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c116989fesm437569185a.36.2025.10.24.11.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 11:16:09 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 2/2] dts: add QinQ test suite
Date: Fri, 24 Oct 2025 14:16:06 -0400
Message-ID: <20251024181606.604135-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024181606.604135-1-dmarx@iol.unh.edu>
References: <20251017203159.557830-1-dmarx@iol.unh.edu>
 <20251024181606.604135-1-dmarx@iol.unh.edu>
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
 dts/tests/TestSuite_qinq.py | 234 ++++++++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)
 create mode 100644 dts/tests/TestSuite_qinq.py

diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
new file mode 100644
index 0000000000..4fb4c64559
--- /dev/null
+++ b/dts/tests/TestSuite_qinq.py
@@ -0,0 +1,234 @@
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
+            received_packets = send_packet_and_capture(test_packet)
+            packet = self._get_relevant_packet(received_packets)
+
+            verify(packet is not None, "Packet was dropped when it should have been received.")
+
+            if packet is not None:
+                verify(bool(packet.haslayer(Dot1AD)), "QinQ layer not found in packet")
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
+            received_packets1 = send_packet_and_capture(test_packets[0])
+            packet1 = self._get_relevant_packet(received_packets1)
+            received_packets2 = send_packet_and_capture(test_packets[1])
+            packet2 = self._get_relevant_packet(received_packets2)
+            received_packets3 = send_packet_and_capture(test_packets[2])
+            packet3 = self._get_relevant_packet(received_packets3)
+            received_packets4 = send_packet_and_capture(test_packets[3])
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
+            verify(
+                not failed,
+                f"The following packets were not stripped correctly: {', '.join(failed)}",
+            )
-- 
2.51.0

