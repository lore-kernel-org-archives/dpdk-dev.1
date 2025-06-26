Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C9C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 19:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 352ED4026F;
	Thu, 26 Jun 2025 21:56:22 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 912E54026C
 for <dev@dpdk.org>; Thu, 26 Jun 2025 21:56:20 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6fd0a3cd326so18832686d6.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750967780; x=1751572580; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vgsl04bTnGQqYREhm3yTX34YlL7IPx2TRF0ICU9uczM=;
 b=FDb/ofOVIltZXAg8XBj2dDfSjonJcJpjBnMbw5CX9hu63YQTT7BsTNz0Spff7wl4F0
 m1y2IkGNadDtrM4o7s6mwxYP2O3wB8r8sbf/8NFFjskU3fDRgmWDhwOq/pfD3xeIFLqC
 f64m2RhYo9GAEJj5iFed/4Li1b897E+OFdGE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750967780; x=1751572580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vgsl04bTnGQqYREhm3yTX34YlL7IPx2TRF0ICU9uczM=;
 b=cjdABfZtW+EzHcv/iZX3d81c8CHUMVshtEsHRl1qankgc0q8aGDH+S4P5W518KlP3w
 65Ojuh7pKyY4voTOxo3vS9kdHL+qFZQ6LM15FNrXNxOD9Cm4ij8yWIyWb14NlfRnQtPe
 GKCJFSuJ8gfT9AMpBWlY/XrChAZZRt5AFXavcSMy2FsfU8BYH5SrC0sNkpRST+ebjBld
 B2vlevVlzqQ2W6K1M2b+394AvLzO5Zw0qNC17y10SQF2F2+4lo9TPw7g4xNCSgeNbeo4
 D58kwvhRZTdwkQ58XugHMBF9hYrJgsTk5n+SgcgvJ7ijJh0MfFPIQwjlvb/dlMs9otMu
 agdQ==
X-Gm-Message-State: AOJu0Yxu/r0snAFguxXkBK04LI/hnIz8EToHslDJDqhaQfJhZAqiX5bM
 7NZ28JlPH5IXR5j4dVR/haIhHOZ+J1eaWC9suR2CouiYUDPB2QUH/h/XoMbxRbanNrs=
X-Gm-Gg: ASbGncvH19fT/OUUFWEmmHONIddKkGqBIr2D08L45Mj3X14YoRO0kdRDt0maDmXI5/b
 8n/LD83Mj/TWbIs6ulAtAuSX6Ljwkna2FkKxv5fCA8vzugsIDTUBGgeXx1MGMjNuygQbZ+OwMmk
 33d+VgB/eS/sPkxcjiGVXfLxlovi9EEobN3WY2R1oWhxVaAHDuYZfKWt6EcRr+61kuhQIufmGBp
 EoYkR+vtu0S3tJr5dVfpg+XFnNInLP7tTpQyg9Ts1165t3+XNsE4sxkIs8VHYPaM1RUYhW38ckm
 9IHmHZs0Bq8oPRW1rjfKNkd2SteeVAPbZGOFA+XbW+G0g1cIeCAyYFvIqk0UhK7LcTyEzx5RYUm
 eF/DfTbU=
X-Google-Smtp-Source: AGHT+IHva2Wm/IfMjbDdS4pypfRfAJ7n9aEK1NxTi7MEO14T8ZSaatx2wXt2gTiRoUZY3cO+NcwW8g==
X-Received: by 2002:a05:6214:300c:b0:6fd:ace:4cfb with SMTP id
 6a1803df08f44-7000214f5fcmr16109226d6.27.1750967779273; 
 Thu, 26 Jun 2025 12:56:19 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772fd163sm10991006d6.94.2025.06.26.12.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 12:56:18 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 1/2] dts: add rte flow test suite
Date: Thu, 26 Jun 2025 15:56:16 -0400
Message-ID: <20250626195617.219395-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521192629.294265-3-dmarx@iol.unh.edu>
References: <20250521192629.294265-3-dmarx@iol.unh.edu>
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
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_rte_flow.rst |   8 +
 dts/tests/TestSuite_rte_flow.py          | 790 +++++++++++++++++++++++
 2 files changed, 798 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_rte_flow.rst
 create mode 100644 dts/tests/TestSuite_rte_flow.py

diff --git a/doc/api/dts/tests.TestSuite_rte_flow.rst b/doc/api/dts/tests.TestSuite_rte_flow.rst
new file mode 100644
index 0000000000..cad96b2530
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_rte_flow.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+checksum_offload Test Suite
+===========================
+
+.. automodule:: tests.TestSuite_rte_flow
+   :members:
+   :show-inheritance:
\ No newline at end of file
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
new file mode 100644
index 0000000000..e70f7ea8d1
--- /dev/null
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -0,0 +1,790 @@
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
+from framework.exception import InteractiveCommandExecutionError
+from framework.remote_session.testpmd_shell import FlowRule, TestPmdShell
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import NicCapability, requires
+
+
+@requires(NicCapability.FLOW_CTRL)
+class TestRteFlow(TestSuite):
+    """RTE Flow test suite.
+
+    This suite consists of 12 test cases:
+    1. Queue Action Ethernet: Verifies queue actions with ethernet patterns
+    2. Queue Action IP: Verifies queue actions with IPv4 and IPv6 patterns
+    3. Queue Action L4: Verifies queue actions with TCP and UDP patterns
+    4. Queue Action VLAN: Verifies queue actions with VLAN patterns
+    5. Drop Action Eth: Verifies drop action with ethernet patterns
+    6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 patterns
+    7. Drop Action L4: Verifies drop actions with TCP and UDP patterns
+    8. Drop Action VLAN: Verifies drop actions with VLAN patterns
+    9. Modify Field Action: Verifies packet modification patterns
+    10. Egress Rules: Verifies previously covered rules are still valid as egress
+    11. Jump Action: Verifies packet behavior given grouped flows
+    12. Priority Attribute: Verifies packet behavior given flows with different priorities
+
+    """
+
+    def runner(
+        self,
+        verification_method: Callable[..., Any],
+        flows: list[FlowRule],
+        packets: list[Packet],
+        port_id: int,
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
+            port_id: Number representing the port to create flows on.
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
+                is_valid = testpmd.flow_validate(flow_rule=flow, port_id=port_id)
+                self.verify_else_skip(is_valid, "flow rule failed validation.")
+
+                try:
+                    flow_id = testpmd.flow_create(flow_rule=flow, port_id=port_id)
+                except InteractiveCommandExecutionError:
+                    self.log("Flow rule validation passed, but flow creation failed.")
+                    self.verify(False, "Failed flow creation")
+
+                if verification_method == self.send_packet_and_verify:
+                    verification_method(packet=packet, *args, **kwargs)
+
+                elif verification_method == self.send_packet_and_verify_queue:
+                    verification_method(
+                        packet=packet, test_queue=kwargs["test_queue"], testpmd=testpmd
+                    )
+
+                elif verification_method == self.send_packet_and_verify_modification:
+                    verification_method(packet=packet, expected_packet=expected_packet)
+
+                testpmd.flow_delete(flow_id, port_id=port_id)
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
+        testpmd.set_verbose(level=8)
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
+    def send_packet_and_verify_jump(
+        self,
+        packets: list[Packet],
+        flow_rules: list[FlowRule],
+        test_queues: list[int],
+        testpmd: TestPmdShell,
+    ) -> None:
+        """Create a testpmd session with every rule in the given list, verify jump behavior.
+
+        Args:
+            packets: List of packets to send.
+            flow_rules: List of flow rules to create in the same session.
+            test_queues: List of Rx queue IDs each packet should be received on.
+            testpmd: TestPmdShell instance to create flows on.
+        """
+        testpmd.set_verbose(level=8)
+        for flow in flow_rules:
+            is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
+            self.verify_else_skip(is_valid, "flow rule failed validation.")
+
+            try:
+                testpmd.flow_create(flow_rule=flow, port_id=0)
+            except InteractiveCommandExecutionError:
+                self.log("Flow validation passed, but flow creation failed.")
+                self.verify(False, "Failed flow creation")
+
+        for packet, test_queue in zip(packets, test_queues):
+            testpmd.start()
+            self.send_packet_and_capture(packet=packet)
+            verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+            received = False
+            for testpmd_packet in verbose_output:
+                if testpmd_packet.queue_id == test_queue:
+                    received = True
+            self.verify(received, f"Expected packet was not received on queue {test_queue}")
+
+    @func_test
+    def test_queue_action_ETH(self) -> None:
+        """Validate flow rules with queue actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
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
+            port_id=0,
+            test_queue=2,
+        )
+
+    @func_test
+    def test_queue_action_IP(self) -> None:
+        """Validate flow rules with queue actions and IPv4/IPv6 patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
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
+            port_id=0,
+            test_queue=2,
+        )
+
+    @func_test
+    def test_queue_action_L4(self) -> None:
+        """Validate flow rules with queue actions and TCP/UDP patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
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
+            port_id=0,
+            test_queue=2,
+        )
+
+    @func_test
+    def test_queue_action_VLAN(self) -> None:
+        """Validate flow rules with queue actions and VLAN patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
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
+            port_id=0,
+            test_queue=2,
+        )
+
+    @func_test
+    def test_drop_action_ETH(self) -> None:
+        """Validate flow rules with drop actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
+
+        Verify:
+            Check that each packet is dropped.
+
+        One packet will be sent as a confidence check, to ensure packets are being
+        received under normal circumstances.
+        """
+        packet_list = [
+            Ether(src="02:00:00:00:00:00") / Raw(load="xxxxx"),
+            Ether(dst="02:00:00:00:00:00") / Raw(load="xxxxx"),
+            Ether(type=0x0800) / Raw(load="xxxxx"),
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
+        # verify reception with test packet
+        packet = Ether() / IP() / Raw(load="xxxxx")
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received = self.send_packet_and_capture(packet)
+            self.verify(received != [], "Test packet was never received.")
+        self.runner(
+            verification_method=self.send_packet_and_verify,
+            flows=flow_list,
+            packets=packet_list,
+            port_id=0,
+            should_receive=False,
+        )
+
+    @func_test
+    def test_drop_action_IP(self) -> None:
+        """Validate flow rules with drop actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
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
+        # verify reception with test packet
+        packet = Ether() / IP() / Raw(load="xxxxx")
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received = self.send_packet_and_capture(packet)
+            self.verify(received != [], "Test packet was never received.")
+        self.runner(
+            verification_method=self.send_packet_and_verify,
+            flows=flow_list,
+            packets=packet_list,
+            port_id=0,
+            should_receive=False,
+        )
+
+    @func_test
+    def test_drop_action_L4(self) -> None:
+        """Validate flow rules with drop actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
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
+        # verify reception with test packet
+        packet = Ether() / IP() / Raw(load="xxxxx")
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received = self.send_packet_and_capture(packet)
+            self.verify(received != [], "Test packet was never received.")
+        self.runner(
+            verification_method=self.send_packet_and_verify,
+            flows=flow_list,
+            packets=packet_list,
+            port_id=0,
+            should_receive=False,
+        )
+
+    @func_test
+    def test_drop_action_VLAN(self) -> None:
+        """Validate flow rules with drop actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
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
+        # verify reception with test packet
+        packet = Ether() / IP() / Raw(load="xxxxx")
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received = self.send_packet_and_capture(packet)
+            self.verify(received != [], "Test packet was never received.")
+        self.runner(
+            verification_method=self.send_packet_and_verify,
+            flows=flow_list,
+            packets=packet_list,
+            port_id=0,
+            should_receive=False,
+        )
+
+    @func_test
+    def test_modify_actions(self) -> None:
+        """Validate flow rules with actions that modify that packet during transmission.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
+
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
+            port_id=0,
+            expected_packets=expected_packet_list,
+        )
+
+    @func_test
+    def test_egress_rules(self) -> None:
+        """Validate flow rules with egress directions.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
+
+        Verify:
+            Check that each packet is dropped.
+
+        One packet will be sent as a confidence check, to ensure packets are being
+        received under normal circumstances.
+        """
+        packet_list = [
+            Ether(src="02:00:00:00:00:00"),
+            Ether() / IP(src="192.168.1.1"),
+            IP() / TCP(sport=1234),
+            IP() / UDP(sport=5000),
+        ]
+        flow_list = [
+            FlowRule(
+                direction="egress", pattern=["eth src is 02:00:00:00:00:00"], actions=["drop"]
+            ),
+            FlowRule(direction="egress", pattern=["ipv4 src is 192.168.1.1"], actions=["drop"]),
+            FlowRule(direction="egress", pattern=["tcp src is 1234"], actions=["drop"]),
+            FlowRule(direction="egress", pattern=["udp src is 5000"], actions=["drop"]),
+        ]
+        # verify reception with test packet
+        packet = Ether() / IP() / Raw(load="xxxxx")
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received = self.send_packet_and_capture(packet)
+            self.verify(received != [], "Test packet was never received.")
+        self.runner(
+            verification_method=self.send_packet_and_verify,
+            flows=flow_list,
+            packets=packet_list,
+            port_id=1,
+            should_receive=False,
+        )
+
+    @func_test
+    def test_jump_action(self) -> None:
+        """Validate flow rules with different group levels and jump actions.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd with the necessary configuration.
+            Create each flow rule in testpmd.
+            Send each packet in the list, check Rx queue ID.
+
+        Verify:
+            Check that each packet is received on the appropriate Rx queue.
+        """
+        packet_list = [Ether() / IP(), Ether() / IP() / TCP(), Ether() / IP() / UDP()]
+        flow_list = [
+            FlowRule(
+                direction="ingress",
+                group_id=0,
+                pattern=["eth / ipv4 / tcp"],
+                actions=["jump group 1"],
+            ),
+            FlowRule(
+                direction="ingress",
+                group_id=0,
+                pattern=["eth / ipv4 / udp"],
+                actions=["jump group 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                group_id=1,
+                pattern=["eth / ipv4 / tcp"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                group_id=2,
+                pattern=["eth / ipv4 / udp"],
+                actions=["queue index 3"],
+            ),
+            FlowRule(
+                direction="ingress",
+                group_id=0,
+                pattern=["eth / ipv4"],
+                actions=["queue index 1"],
+            ),
+        ]
+        expected_queue_list = [1, 2, 3]
+        with TestPmdShell(rx_queues=4, tx_queues=4) as testpmd:
+            self.send_packet_and_verify_jump(
+                packets=packet_list,
+                flow_rules=flow_list,
+                test_queues=expected_queue_list,
+                testpmd=testpmd,
+            )
+
+    @func_test
+    def test_priority_attribute(self) -> None:
+        """Validate flow rules with queue actions and ethernet patterns.
+
+        Steps:
+            Create a list of packets to test, with a corresponding flow list.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
+
+        Verify:
+            Check that each packet is received on the appropriate queue.
+        """
+        test_packet = Ether() / IP() / Raw()
+        flow_list = [
+            FlowRule(
+                direction="ingress",
+                priority_level=3,
+                pattern=["eth / ipv4"],
+                actions=["queue index 1"],
+            ),
+            FlowRule(
+                direction="ingress",
+                priority_level=2,
+                pattern=["eth / ipv4"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                priority_level=1,
+                pattern=["eth / ipv4"],
+                actions=["queue index 3"],
+            ),
+        ]
+        expected_queue_list = [1, 2, 3]
+        with TestPmdShell(rx_queues=4, tx_queues=4) as testpmd:
+            testpmd.set_verbose(level=8)
+            for flow, expected_queue in zip(flow_list, expected_queue_list):
+                is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
+                self.verify_else_skip(is_valid, "flow rule failed validation.")
+                try:
+                    testpmd.flow_create(flow_rule=flow, port_id=0)
+                except InteractiveCommandExecutionError:
+                    self.log("Flow rule validation passed, but flow creation failed.")
+                    self.verify(False, "Failed flow creation")
+                testpmd.start()
+                self.send_packet_and_capture(test_packet)
+                verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+                received = False
+                for testpmd_packet in verbose_output:
+                    if testpmd_packet.queue_id == expected_queue:
+                        received = True
+                self.verify(received, f"Packet was not received on queue {expected_queue}")
-- 
2.49.0

