Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFC9C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 19:26:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 148BF4060F;
	Wed, 21 May 2025 21:26:35 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id B3BC6402CD
 for <dev@dpdk.org>; Wed, 21 May 2025 21:26:32 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7c5ba363f1aso1011324585a.0
 for <dev@dpdk.org>; Wed, 21 May 2025 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747855592; x=1748460392; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrDDmo0EGfh+7roTOK6eTssoAL6XOReF5VBvtjTSe0w=;
 b=INBpvuvVoA8mr2Vi5ubG02os+UpIfh0sWDpHHlTsf1Iy17wv090a23Z+Urb14t2Zq6
 /ZtiOS2lLQgTTkOXQOIjrqgNwa5hEzuVhnNGLosLUmpaa6A6hPhKB9NYG9/tqLlgnqh2
 AulJvtkAlEJKib48S3/mVXy4PMZPYwD/5KJBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747855592; x=1748460392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HrDDmo0EGfh+7roTOK6eTssoAL6XOReF5VBvtjTSe0w=;
 b=qwQJb0IvbjQETk6ajX2MhjUa7dJxS5nWJdOh+RTPZpPbm0pL1SZxuTrbTytM14hgKJ
 byptMZhxcvKqAvFojp1Lf00EvxsawfEJTcEdpfvfJxpbOA/utvXS6rZSWkk38Q4ZLn26
 w7FXygNLqHLxmkNRLDUTq7j0c/QJovfvtILhvejH7bHyFx3K3xQr57C5FLniIsNkg7x2
 h8kIKcaOJAM2aJ9MDPmIcUG8puKZBBYgcTxpAqV7uZZi4JrmJeGK40E+p1gb+st776jI
 Q2s1affUXWQ8DomVvPfPGH193avkiD9TphoOjP4/BGB9Kj4jVKhN0xW9ahWqUHrNncab
 BzNQ==
X-Gm-Message-State: AOJu0Yz9yTBo6tNQrDo4CMSk9HoygY1awSV3FxJyWZK6dCU9xakpemsn
 9DaS/x4lT+P5XY+EYY+xZKbxkusNJOifrxi5PV3qM28EQVXg5KakiI80u9LuKSsxHK4=
X-Gm-Gg: ASbGnctGzIvR3uPAxl5eOqdp4KWJTvWCvXvnbPyyLnNkz8M8ppH5k+8kVUDYgG/GoRw
 OwCVwtGvLy0hxWOcPcKwJYDXu0A3xnQTmOsujyPzWgX+VWRR7EwS7T1R3bbmVbFhq1E5eO/V89T
 YPpTovxc6jiLwKYjfQ578U7suTKGznmz6QKDIdFkM160R9GvDKemdUh67JdjYECKs1yjicRtH0M
 TXGJIZanfIkKWDHsyst6pcK9uCTkMAn3Jb9uUwRkYZ4y5o7O1Uc06OF9sUxtgBgqVCKn472rQQt
 xI+GMHgQ5iqrwgRzyuufgf/datPo7ASwUwZcAAu9sXqqS1x9MaKrcntbD0sfxA==
X-Google-Smtp-Source: AGHT+IEZKGUYacis44n1slWq8EViTiwz1IflbU3VSRxDcJnyD8eV6WBstb4QWm0xo2Eh9zB0EJ71hA==
X-Received: by 2002:a05:620a:40cf:b0:7cd:1d11:cc16 with SMTP id
 af79cd13be357-7cd47f10ff7mr2782810485a.14.1747855591771; 
 Wed, 21 May 2025 12:26:31 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd468d8e68sm911456385a.112.2025.05.21.12.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 12:26:31 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 1/3] dts: add rte flow test suite
Date: Wed, 21 May 2025 15:26:27 -0400
Message-ID: <20250521192629.294265-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519181957.228084-1-dmarx@iol.unh.edu>
References: <20250519181957.228084-1-dmarx@iol.unh.edu>
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

Add an RTE Flow API testing suite, which covers some basic
synchronous Flow API rules that should be supported across PMDs.
This suite will be added to over time, as the Flow API is too large
to cover all in one suite, and sending one monolithic series
would be impossible.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_flow.py | 585 ++++++++++++++++++++++++++++++++++++
 1 file changed, 585 insertions(+)
 create mode 100644 dts/tests/TestSuite_flow.py

diff --git a/dts/tests/TestSuite_flow.py b/dts/tests/TestSuite_flow.py
new file mode 100644
index 0000000000..15566205c9
--- /dev/null
+++ b/dts/tests/TestSuite_flow.py
@@ -0,0 +1,585 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""RTE Flow testing suite.
+
+This suite verifies a range of flow rules built using patterns
+and actions from the RTE Flow API. It would be impossible to cover
+every valid flow rule, but this suite aims to test the most
+important and common functionalities across PMDs.
+
+"""
+
+from collections.abc import Callable
+from itertools import zip_longest
+from typing import Any, Iterator, cast
+
+from scapy.layers.inet import IP, TCP, UDP
+from scapy.layers.inet6 import IPv6
+from scapy.layers.l2 import Dot1Q, Ether
+from scapy.packet import Packet, Raw
+
+from framework.remote_session.testpmd_shell import FlowRule, TestPmdShell
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import NicCapability, TopologyType, requires
+
+
+@requires(topology_type=TopologyType.two_links)
+@requires(NicCapability.FLOW_CTRL)
+class TestFlow(TestSuite):
+    """RTE Flow test suite.
+
+    This suite consists of 10 test cases:
+    1. Queue Action Ethernet: Verifies queue actions with ethernet patterns
+    2. Queue Action IP: Verifies queue actions with IPv4 and IPv6 patterns
+    3. Queue Action L4: Verifies queue actions with TCP and UDP patterns
+    4. Queue Action VLAN: Verifies queue actions with VLAN patterns
+    5. Drop Action Eth: Verifies drop action with ethernet patterns
+    6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 patterns
+    7. Drop Action L4: Verifies drop actions with TCP and UDP patterns
+    8. Drop Action VLAN: Verifies drop actions with VLAN patterns
+    9. Modify Field Action: Verifies packet modification patterns
+    10. Egress Rules: Verifies previously covered rules are still valid as egress.
+
+    """
+
+    def runner(
+        self,
+        verification_method: Callable[..., Any],
+        flows: list[FlowRule],
+        packets: list[Packet],
+        expected_packets: list[Packet] | None = None,
+        *args: Any,
+        **kwargs: Any,
+    ) -> None:
+        """Runner method that validates each flow using the corresponding verification method.
+
+        Args:
+            verification_method: Callable that performs verification logic.
+            flows: List of flow rules to create and test.
+            packets: List of packets corresponding to each flow.
+            expected_packets: List of packets to check sent packets against in modification cases.
+            *args: Additional positional arguments to pass to the verification method.
+            **kwargs: Additional keyword arguments to pass to the verification method.
+        """
+
+        def zip_lists(
+            rules: list[FlowRule],
+            packets1: list[Packet],
+            packets2: list[Packet] | None,
+        ) -> Iterator[tuple[FlowRule, Packet, Packet | None]]:
+            """Method that creates an iterable zip containing lists used in runner.
+
+            Args:
+                rules: List of flow rules.
+                packets1: List of packets.
+                packets2: Optional list of packets, excluded from zip if not passed to runner.
+            """
+            return cast(
+                Iterator[tuple[FlowRule, Packet, Packet | None]],
+                zip_longest(rules, packets1, packets2 or [], fillvalue=None),
+            )
+
+        with TestPmdShell(rx_queues=4, tx_queues=4) as testpmd:
+            for flow, packet, expected_packet in zip_lists(flows, packets, expected_packets):
+                flow_id = testpmd.flow_create(flow_rule=flow, port_id=0)
+
+                if verification_method == self.send_packet_and_verify:
+                    verification_method(*args, **kwargs)
+
+                elif verification_method == self.send_packet_and_verify_queue:
+                    verification_method(
+                        packet=packet, test_queue=kwargs["test_queue"], testpmd=testpmd
+                    )
+
+                elif verification_method == self.send_packet_and_verify_modification:
+                    verification_method(packet=packet, expected_packet=expected_packet)
+
+                testpmd.flow_delete(flow_id, port_id=0)
+
+    def send_packet_and_verify(self, packet: Packet, should_receive: bool = True) -> None:
+        """Generate a packet, send to the DUT, and verify it is forwarded back.
+
+        Args:
+            packet: Scapy packet to send and verify.
+            should_receive: Indicate whether the packet should be received.
+        """
+        received = self.send_packet_and_capture(packet)
+        contains_packet = any(
+            packet.haslayer(Raw) and b"xxxxx" in packet.load for packet in received
+        )
+        self.verify(
+            should_receive == contains_packet,
+            f"Packet was {'dropped' if should_receive else 'received'}",
+        )
+
+    def send_packet_and_verify_queue(
+        self, packet: Packet, test_queue: int, testpmd: TestPmdShell
+    ) -> None:
+        """Send packet and verify queue stats show packet was received.
+
+        Args:
+            packet: Scapy packet to send to the SUT.
+            test_queue: Represents the queue the test packet is being sent to.
+            testpmd: TestPmdShell instance being used to send test packet.
+        """
+        testpmd.set_verbose(level=1)
+        testpmd.start()
+        self.send_packet_and_capture(packet=packet)
+        verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+        received = False
+        for testpmd_packet in verbose_output:
+            if testpmd_packet.queue_id == test_queue:
+                received = True
+        self.verify(received, f"Expected packet was not received on queue {test_queue}")
+
+    def send_packet_and_verify_modification(self, packet: Packet, expected_packet: Packet) -> None:
+        """Send packet and verify the expected modifications are present upon reception.
+
+        Args:
+            packet: Scapy packet to send to the SUT.
+            expected_packet: Scapy packet that should match the received packet.
+        """
+        received = self.send_packet_and_capture(packet)
+
+        # verify reception
+        self.verify(received != [], "Packet was never received.")
+
+        self.log(f"SENT PACKET:     {packet.summary()}")
+        self.log(f"EXPECTED PACKET: {expected_packet.summary()}")
+        for packet in received:
+            self.log(f"RECEIVED PACKET: {packet.summary()}")
+
+        expected_ip_dst = expected_packet[IP].dst if IP in expected_packet else None
+        received_ip_dst = received[IP].dst if IP in received else None
+
+        expected_mac_dst = expected_packet[Ether].dst if Ether in expected_packet else None
+        received_mac_dst = received[Ether].dst if Ether in received else None
+
+        # verify modification
+        if expected_ip_dst is not None:
+            self.verify(
+                received_ip_dst == expected_ip_dst,
+                f"IPv4 dst mismatch: expected {expected_ip_dst}, got {received_ip_dst}",
+            )
+
+        if expected_mac_dst is not None:
+            self.verify(
+                received_mac_dst == expected_mac_dst,
+                f"MAC dst mismatch: expected {expected_mac_dst}, got {received_mac_dst}",
+            )
+
+    @func_test
+    def test_queue_action_ETH(self) -> None:
+        """Validate flow rules with queue actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Send each packet in the list, capture testpmd verbose output.
+
+        Verify:
+            Check that each packet is received on the appropriate queue.
+        """
+        packet_list = [
+            Ether(src="02:00:00:00:00:00"),
+            Ether(dst="02:00:00:00:00:00"),
+            Ether(type=0x0800) / IP(),
+        ]
+        flow_list = [
+            FlowRule(
+                direction="ingress",
+                pattern=["eth src is 02:00:00:00:00:00"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                pattern=["eth dst is 02:00:00:00:00:00"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress", pattern=["eth type is 0x0800"], actions=["queue index 2"]
+            ),
+        ]
+        self.runner(
+            verification_method=self.send_packet_and_verify_queue,
+            flows=flow_list,
+            packets=packet_list,
+            test_queue=2,
+        )
+
+    @func_test
+    def test_queue_action_IP(self) -> None:
+        """Validate flow rules with queue actions and IPv4/IPv6 patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Send each packet in the list, capture testpmd verbose output.
+
+        Verify:
+            Check that each packet is received on the appropriate queue.
+        """
+        packet_list = [
+            Ether() / IP(src="192.168.1.1"),
+            Ether() / IP(dst="192.168.1.1"),
+            Ether() / IP(ttl=64),
+            Ether() / IPv6(src="2001:db8::1"),
+            Ether() / IPv6(dst="2001:db8::2"),
+            Ether() / IPv6() / UDP(),
+        ]
+        flow_list = [
+            FlowRule(
+                direction="ingress",
+                pattern=["eth / ipv4 src is 192.168.1.1"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                pattern=["eth / ipv4 dst is 192.168.1.1"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress", pattern=["eth / ipv4 ttl is 64"], actions=["queue index 2"]
+            ),
+            FlowRule(
+                direction="ingress",
+                pattern=["eth / ipv6 src is 2001:db8::1"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                pattern=["eth / ipv6 dst is 2001:db8::2"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress", pattern=["eth / ipv6 proto is 17"], actions=["queue index 2"]
+            ),
+        ]
+        self.runner(
+            verification_method=self.send_packet_and_verify_queue,
+            flows=flow_list,
+            packets=packet_list,
+            test_queue=2,
+        )
+
+    @func_test
+    def test_queue_action_L4(self) -> None:
+        """Validate flow rules with queue actions and TCP/UDP patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Send each packet in the list, capture testpmd verbose output.
+
+        Verify:
+            Check that each packet is received on the appropriate queue.
+        """
+        packet_list = [
+            Ether() / IP() / TCP(sport=1234),
+            Ether() / IP() / TCP(dport=80),
+            Ether() / IP() / TCP(flags=0x02),
+            Ether() / IP() / UDP(sport=5000),
+            Ether() / IP() / UDP(dport=53),
+        ]
+        flow_list = [
+            FlowRule(
+                direction="ingress",
+                pattern=["eth / ipv4 / tcp src is 1234"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                pattern=["eth / ipv4 / tcp dst is 80"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                pattern=["eth / ipv4 / tcp flags is 0x02"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                pattern=["eth / ipv4 / udp src is 5000"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                pattern=["eth / ipv4 / udp dst is 53"],
+                actions=["queue index 2"],
+            ),
+        ]
+        self.runner(
+            verification_method=self.send_packet_and_verify_queue,
+            flows=flow_list,
+            packets=packet_list,
+            test_queue=2,
+        )
+
+    @func_test
+    def test_queue_action_VLAN(self) -> None:
+        """Validate flow rules with queue actions and VLAN patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Send each packet in the list, capture testpmd verbose output.
+
+        Verify:
+            Check that each packet is received on the appropriate queue.
+        """
+        packet_list = [Ether() / Dot1Q(vlan=100), Ether() / Dot1Q(type=0x0800)]
+        flow_list = [
+            FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["queue index 2"]),
+            FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["queue index 2"]),
+        ]
+        self.runner(
+            verification_method=self.send_packet_and_verify_queue,
+            flows=flow_list,
+            packets=packet_list,
+            test_queue=2,
+        )
+
+    @func_test
+    def test_drop_action_ETH(self) -> None:
+        """Validate flow rules with drop actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Send each packet in the list, check reception status.
+
+        Verify:
+            Check that each packet is dropped.
+
+        One packet will be sent as a confidence check, to ensure packets are being
+        received under normal circumstances.
+        """
+        packet_list = [
+            Ether(src="02:00:00:00:00:00"),
+            Raw(load="xxxxx"),
+            Ether(dst="02:00:00:00:00:00"),
+            Raw(load="xxxxx"),
+            Ether(type=0x0800),
+            Raw(load="xxxxx"),
+        ]
+        flow_list = [
+            FlowRule(
+                direction="ingress", pattern=["eth src is 02:00:00:00:00:00"], actions=["drop"]
+            ),
+            FlowRule(
+                direction="ingress", pattern=["eth dst is 02:00:00:00:00:00"], actions=["drop"]
+            ),
+            FlowRule(direction="ingress", pattern=["eth type is 0x0800"], actions=["drop"]),
+        ]
+        # Verify packet reception without flow rule
+        self.send_packet_and_verify(packet=Raw(load="xxxxx"), should_receive=True)
+        self.runner(
+            verification_method=self.send_packet_and_verify,
+            flows=flow_list,
+            packets=packet_list,
+            should_receive=False,
+        )
+
+    @func_test
+    def test_drop_action_IP(self) -> None:
+        """Validate flow rules with drop actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Send each packet in the list, check reception status.
+
+        Verify:
+            Check that each packet is dropped.
+
+        One packet will be sent as a confidence check, to ensure packets are being
+        received under normal circumstances.
+        """
+        packet_list = [
+            Ether() / IP(src="192.168.1.1") / Raw(load="xxxxx"),
+            Ether() / IP(dst="192.168.1.1") / Raw(load="xxxxx"),
+            Ether() / IP(ttl=64) / Raw(load="xxxxx"),
+            Ether() / IPv6(src="2001:db8::1") / Raw(load="xxxxx"),
+            Ether() / IPv6(dst="2001:db8::1") / Raw(load="xxxxx"),
+            Ether() / IPv6() / UDP() / Raw(load="xxxxx"),
+        ]
+        flow_list = [
+            FlowRule(
+                direction="ingress", pattern=["eth / ipv4 src is 192.168.1.1"], actions=["drop"]
+            ),
+            FlowRule(
+                direction="ingress", pattern=["eth / ipv4 dst is 192.168.1.1"], actions=["drop"]
+            ),
+            FlowRule(direction="ingress", pattern=["eth / ipv4 ttl is 64"], actions=["drop"]),
+            FlowRule(
+                direction="ingress", pattern=["eth / ipv6 src is 2001:db8::1"], actions=["drop"]
+            ),
+            FlowRule(
+                direction="ingress", pattern=["eth / ipv6 dst is 2001:db8::2"], actions=["drop"]
+            ),
+            FlowRule(direction="ingress", pattern=["eth / ipv6 proto is 17"], actions=["drop"]),
+        ]
+        # Verify packet reception without flow rule
+        self.send_packet_and_verify(packet=Raw(load="xxxxx"), should_receive=True)
+        self.runner(
+            verification_method=self.send_packet_and_verify,
+            flows=flow_list,
+            packets=packet_list,
+            should_receive=False,
+        )
+
+    @func_test
+    def test_drop_action_L4(self) -> None:
+        """Validate flow rules with drop actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Send each packet in the list, check reception status.
+
+        Verify:
+            Check that each packet is dropped.
+
+        One packet will be sent as a confidence check, to ensure packets are being
+        received under normal circumstances.
+        """
+        packet_list = [
+            Ether() / IP() / TCP(sport=1234) / Raw(load="xxxxx"),
+            Ether() / IP() / TCP(dport=80) / Raw(load="xxxxx"),
+            Ether() / IP() / TCP(flags=0x02) / Raw(load="xxxxx"),
+            Ether() / IP() / UDP(sport=5000) / Raw(load="xxxxx"),
+            Ether() / IP() / UDP(dport=53) / Raw(load="xxxxx"),
+        ]
+        flow_list = [
+            FlowRule(
+                direction="ingress", pattern=["eth / ipv4 / tcp src is 1234"], actions=["drop"]
+            ),
+            FlowRule(direction="ingress", pattern=["eth / ipv4 / tcp dst is 80"], actions=["drop"]),
+            FlowRule(
+                direction="ingress", pattern=["eth / ipv4 / tcp flags is 0x02"], actions=["drop"]
+            ),
+            FlowRule(
+                direction="ingress", pattern=["eth / ipv4 / udp src is 5000"], actions=["drop"]
+            ),
+            FlowRule(direction="ingress", pattern=["eth / ipv4 / udp dst is 53"], actions=["drop"]),
+        ]
+        # Verify packet reception without flow rule
+        self.send_packet_and_verify(packet=Raw(load="xxxxx"), should_receive=True)
+        self.runner(
+            verification_method=self.send_packet_and_verify,
+            flows=flow_list,
+            packets=packet_list,
+            should_receive=False,
+        )
+
+    @func_test
+    def test_drop_action_VLAN(self) -> None:
+        """Validate flow rules with drop actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Send each packet in the list, check reception status.
+
+        Verify:
+            Check that each packet is dropped.
+
+        One packet will be sent as a confidence check, to ensure packets are being
+        received under normal circumstances.
+        """
+        packet_list = [
+            Ether() / Dot1Q(vlan=100) / Raw(load="xxxxx"),
+            Ether() / Dot1Q(type=0x0800) / Raw(load="xxxxx"),
+        ]
+        flow_list = [
+            FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["drop"]),
+            FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["drop"]),
+        ]
+        # Verify packet reception without flow rule
+        self.send_packet_and_verify(packet=Raw(load="xxxxx"), should_receive=True)
+        self.runner(
+            verification_method=self.send_packet_and_verify,
+            flows=flow_list,
+            packets=packet_list,
+            should_receive=False,
+        )
+
+    @func_test
+    def test_modify_actions(self) -> None:
+        """Validate flow rules with actions that modify that packet during transmission.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Send each packet in the list, check attributes.
+        Verify:
+            Verify packet is received with the new attributes.
+        """
+        packet_list = [Ether() / IP(src="192.68.1.1"), Ether(src="02:00:00:00:00:00")]
+        flow_list = [
+            # rule to copy IPv4 src to IPv4 dst
+            FlowRule(
+                direction="ingress",
+                group_id=1,
+                pattern=["eth"],
+                actions=[
+                    "modify_field op set dst_type ipv4_dst src_type ipv4_src width 32"
+                    " / queue index 0"
+                ],
+            ),
+            # rule to copy src MAC to dst MAC
+            FlowRule(
+                direction="ingress",
+                group_id=1,
+                pattern=["eth"],
+                actions=[
+                    "modify_field op set dst_type mac_dst src_type mac_src width 48 / queue index 0"
+                ],
+            ),
+        ]
+        expected_packet_list = [Ether() / IP(dst="192.68.1.1"), Ether(dst="02:00:00:00:00:00")]
+        self.runner(
+            verification_method=self.send_packet_and_verify_modification,
+            flows=flow_list,
+            packets=packet_list,
+            expected_packets=expected_packet_list,
+        )
+
+    @func_test
+    def test_egress_rules(self) -> None:
+        """Validate flow rules with egress directions.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Send each packet in the list, check reception status.
+
+        Verify:
+            Check that each packet is dropped.
+
+        One packet will be sent as a confidence check, to ensure packets are being
+        received under normal circumstances.
+        """
+        packet_list = [
+            Ether(src="02:00:00:00:00:00"),
+            IP(src="192.168.1.1"),
+            TCP(sport=1234),
+            UDP(sport=5000),
+        ]
+        flow_list = [
+            FlowRule(
+                direction="egress", pattern=["eth src is 02:00:00:00:00:00"], actions=["drop"]
+            ),
+            FlowRule(direction="egress", pattern=["ipv4 src is 192.168.1.1"], actions=["drop"]),
+            FlowRule(direction="egress", pattern=["tcp src is 1234"], actions=["drop"]),
+            FlowRule(direction="egress", pattern=["udp src is 5000"], actions=["drop"]),
+        ]
+        # Verify packet reception without flow rule
+        self.send_packet_and_verify(packet=Raw(load="xxxxx"), should_receive=True)
+        self.runner(
+            verification_method=self.send_packet_and_verify,
+            flows=flow_list,
+            packets=packet_list,
+            should_receive=False,
+        )
-- 
2.49.0

