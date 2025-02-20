Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD282C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 21:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DB484065C;
	Thu, 20 Feb 2025 22:24:55 +0100 (CET)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 58C1D40395
 for <dev@dpdk.org>; Thu, 20 Feb 2025 22:24:52 +0100 (CET)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-47220d28138so8224451cf.3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 13:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1740086692; x=1740691492; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQ0w77mfpuPqgDV+r8N2jPhTMVzG4kd//hbclYnyZ8A=;
 b=D29R+EP6oe15sSxjYRg+8TNyIQyilzGe7QYqgUPu2cRS3i4Y+ASQ31lHSo61nJIDQj
 r+qGdW+JEKO8V7D275iimlQQvma49vkU81uki2FDwilyLhX25zRcrhLHFPXyzlHRqNVj
 kfOM/PjtPWKc/JR8CdVVHPELBrxkcc8DgH/Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740086692; x=1740691492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQ0w77mfpuPqgDV+r8N2jPhTMVzG4kd//hbclYnyZ8A=;
 b=FK2NyafBXOn1gKUKO/Wsa/6PPdZZ9bS8hvB+HhFo3gDXzaV63g5TZwjpbyovJpttzf
 cliFOrISMEzDK5OSXi1UVNj1Mt5EbitR01DZT2KZ8LEw8dZkZwSCxI/5R30RiPLAC1L7
 dNgXTH897ypW11pLMW0HHVcJyhROGwQoAbPBgaB/PhzyM75Tn0TMH/KnATXC5+ptaTnE
 CWa294uLkwScmus7dv25mPV2RdRuEh5deQY/+M+RaobAlyZUSNr6tgxiZ/rcdSGngWWq
 5kxtGmI5UNT6A4/RkTvA4cZ+3OafcLvWZGlhrGVrhxt8EHOZqdDWxgx/9vNDJZqbLteQ
 0t0g==
X-Gm-Message-State: AOJu0YyW4XGqTBZRQzyYAVToFk39THLJw7k2zoO/K/eO4roS+xXYUlbG
 TNAqDSlM8EI1ya42NA1nGHXr9CGII5HlaLcgYF5HEzyfR2qn/5eq2bi+xU2xTQc=
X-Gm-Gg: ASbGnctUS8P7RIoV/lVr0RMcv57hznzAeNGbObdfu96KCgh7oKo0UaWZ40EbJTCGLpC
 14LnTtGd6HEW3M3NPj+HdwxG6HY6YA+PuSmfSpibL38kJSgYh8xURwxnDX0lMHXgoL+YYGf0l87
 B46GcjzQHy3ukpc4mCkG6O16yrSrpWaOBxTRwT09k6Oij0ZOjtJ76vOHvMRTrHFd1p9YIt7XRuw
 RMgdMUUh2w/vRaBDuhY6XnU091EwLUFBCPEQQJ8RVOCAqEzmWgpw+mYtWqgsOiom0yRme7uZV8T
 tQnU3Jpk6UlM6kuFfXecHXhZGI9bmq4xQjsfaR0nYsAA+3Bg/VXqRsY=
X-Google-Smtp-Source: AGHT+IF+5b+xDAwrv/qptlFSc+5CCUFgkBGW/L87elQOi1ggKczPbHRzDj59FtQNfeRYnYga/2qyFg==
X-Received: by 2002:a05:620a:1b99:b0:7c0:c822:c4e8 with SMTP id
 af79cd13be357-7c0cef744a2mr116523485a.57.1740086691688; 
 Thu, 20 Feb 2025 13:24:51 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c0b16072b7sm313030885a.98.2025.02.20.13.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 13:24:51 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org, Dean Marx <dmarx@iol.unh.edu>,
 Jeremy Spewock <jspewock@iol.unh.edu>
Subject: [PATCH v4 2/2] dts: add port stats checks test suite
Date: Thu, 20 Feb 2025 16:24:43 -0500
Message-ID: <20250220212443.66483-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220212443.66483-1-dmarx@iol.unh.edu>
References: <20240923154936.15952-1-jspewock@iol.unh.edu>
 <20250220212443.66483-1-dmarx@iol.unh.edu>
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

This patch adds a new test suite to DTS that validates the accuracy of
the port statistics using testpmd. The functionality is tested by
sending a packet of a fixed side to the SUT and verifying that the
statistic for packets received, received bytes, packets sent, and sent
bytes all update accordingly.

Signed-off-by: Jeremy Spewock <jspewock@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_port_stats_checks.py | 168 +++++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 dts/tests/TestSuite_port_stats_checks.py

diff --git a/dts/tests/TestSuite_port_stats_checks.py b/dts/tests/TestSuite_port_stats_checks.py
new file mode 100644
index 0000000000..2a3fb06946
--- /dev/null
+++ b/dts/tests/TestSuite_port_stats_checks.py
@@ -0,0 +1,168 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Port Statistics testing suite.
+
+This test suite tests the functionality of querying the statistics of a port and verifies that the
+values provided in the statistics accurately reflect the traffic that has been handled on the port.
+This is shown by sending a packet of a fixed size to the SUT and verifying that the number of RX
+packets has increased by 1, the number of RX bytes has increased by the specified size, the number
+of TX packets has also increased by 1 (since we expect the packet to be forwarded), and the number
+of TX bytes has also increased by the same fixed amount.
+"""
+
+from typing import ClassVar, Tuple
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Packet, Raw
+
+from framework.params.testpmd import SimpleForwardingModes
+from framework.remote_session.testpmd_shell import (
+    RtePTypes,
+    TestPmdShell,
+    TestPmdVerbosePacket,
+)
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import TopologyType, requires
+
+
+@requires(topology_type=TopologyType.two_links)
+class TestPortStatsChecks(TestSuite):
+    """DPDK Port statistics testing suite.
+
+    Support for port statistics is tested by sending a packet of a fixed size denoted by
+    `total_packet_len` and verifying the that TX/RX packets of the TX/RX ports updated by exactly
+    1 and the TX/RX bytes of the TX/RX ports updated by exactly `total_packet_len`. This is done by
+    finding the total amount of packets that were sent/received which did not originate from this
+    test suite and taking the sum of the lengths of each of these "noise" packets and subtracting
+    it from the total values in the port statistics so that all that is left are relevant values.
+    """
+
+    #: Port where traffic will be received on the SUT.
+    recv_port: ClassVar[int] = 0
+    #: Port where traffic will be sent from on the SUT.
+    send_port: ClassVar[int] = 1
+
+    #:
+    ip_header_len: ClassVar[int] = 20
+    #:
+    ether_header_len: ClassVar[int] = 14
+
+    #: Length of the packet being sent including the IP and frame headers.
+    total_packet_len: ClassVar[int] = 100
+    #: Packet to send during testing.
+    send_pkt: ClassVar[Packet] = (
+        Ether() / IP() / Raw(b"X" * (total_packet_len - ip_header_len - ether_header_len))
+    )
+
+    def extract_noise_information(
+        self, verbose_out: list[TestPmdVerbosePacket]
+    ) -> Tuple[int, int, int, int]:
+        """Extract information about packets that were not sent by the framework in `verbose_out`.
+
+        Extract the number of sent/received packets that did not originate from this test suite as
+        well as the sum of the lengths of said "noise" packets. Note that received packets are only
+        examined on the port with the ID `self.recv_port` since these are the receive stats that
+        will be analyzed in this suite. Sent packets are also only examined on the port with the ID
+        `self.send_port`.
+
+        Packets are considered to be "noise" when they don't match the expected structure of the
+        packets that are being sent by this test suite. Specifically, the source and destination
+        mac addresses as well as the software packet type are checked on packets received by
+        testpmd to ensure they match the proper addresses of the TG and SUT nodes. Packets that are
+        sent by testpmd however only check the source mac address and the software packet type.
+        This is because MAC forwarding mode adjusts both addresses, but only the source will belong
+        to the TG or SUT node.
+
+        Args:
+            verbose_out: Parsed testpmd verbose output to collect the noise information from.
+
+        Returns:
+            A tuple containing the total size of received noise in bytes, the number of received
+            noise packets, size of all noise packets sent by testpmd in bytes, and the number of
+            noise packets sent by testpmd.
+        """
+        recv_noise_bytes = 0
+        recv_noise_packets = 0
+        sent_noise_bytes = 0
+        num_sent_packets = 0
+        for verbose_packet in verbose_out:
+            if verbose_packet.was_received and verbose_packet.port_id == self.recv_port:
+                if (
+                    verbose_packet.src_mac.lower()
+                    != self.topology.tg_port_egress.mac_address.lower()
+                    or verbose_packet.dst_mac.lower()
+                    != self.topology.sut_port_ingress.mac_address.lower()
+                    or verbose_packet.sw_ptype != (RtePTypes.L2_ETHER | RtePTypes.L3_IPV4)
+                ):
+                    recv_noise_bytes += verbose_packet.length
+                    recv_noise_packets += 1
+            elif not verbose_packet.was_received and verbose_packet.port_id == self.send_port:
+                if (
+                    verbose_packet.src_mac.lower()
+                    != self.topology.sut_port_egress.mac_address.lower()
+                    or verbose_packet.sw_ptype != (RtePTypes.L2_ETHER | RtePTypes.L3_IPV4)
+                ):
+                    sent_noise_bytes += verbose_packet.length
+                    num_sent_packets += 1
+
+        return recv_noise_bytes, recv_noise_packets, sent_noise_bytes, num_sent_packets
+
+    @func_test
+    def test_stats_updates(self) -> None:
+        """Send a packet with a fixed length and verify port stats updated properly.
+
+        Send a packet with a total length of `self.total_packet_len` and verify that the rx port
+        only received one packet and the number of rx_bytes increased by exactly
+        `self.total_packet_len`. Also verify that the tx port only sent one packet and that the
+        tx_bytes of the port increase by exactly `self.total_packet_len`.
+
+        Noise on the wire is ignored by extracting the total number of noise packets and the sum of
+        the lengths of those packets and subtracting them from the totals that are provided by the
+        testpmd command `show port info all`.
+
+        Steps:
+            Start testpmd in MAC forwarding mode and set verbose mode to 3 (RX and TX).
+            Start packet forwarding and then clear all port statistics.
+            Send a packet, then stop packet forwarding and collect the port stats.
+
+        Verify:
+            Parse verbose info from stopping packet forwarding and verify values in port stats.
+        """
+        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
+            testpmd.set_verbose(3)
+            testpmd.start()
+            testpmd.clear_port_stats_all()
+            self.send_packet_and_capture(self.send_pkt)
+            port_stats_all, forwarding_info = testpmd.show_port_stats_all()
+            verbose_information = TestPmdShell.extract_verbose_output(forwarding_info)
+
+        # Gather information from irrelevant packets sent/ received on the same port.
+        rx_irr_bytes, rx_irr_pakts, tx_irr_bytes, tx_irr_pakts = self.extract_noise_information(
+            verbose_information
+        )
+        recv_relevant_packets = port_stats_all[self.recv_port].rx_packets - rx_irr_pakts
+        sent_relevant_packets = port_stats_all[self.send_port].tx_packets - tx_irr_pakts
+        recv_relevant_bytes = port_stats_all[self.recv_port].rx_bytes - rx_irr_bytes
+        sent_relevant_bytes = port_stats_all[self.send_port].tx_bytes - tx_irr_bytes
+
+        self.verify(
+            recv_relevant_packets == 1,
+            f"Port {self.recv_port} received {recv_relevant_packets} packets but expected to only "
+            "receive 1.",
+        )
+        self.verify(
+            recv_relevant_bytes == self.total_packet_len,
+            f"Number of bytes received by port {self.recv_port} did not match the amount sent.",
+        )
+        self.verify(
+            sent_relevant_packets == 1,
+            f"Number was packets sent by port {self.send_port} was not equal to the number "
+            f"received by port {self.recv_port}.",
+        )
+        self.verify(
+            sent_relevant_bytes == self.total_packet_len,
+            f"Number of bytes sent by port {self.send_port} did not match the number of bytes "
+            f"received by port {self.recv_port}.",
+        )
-- 
2.47.0

