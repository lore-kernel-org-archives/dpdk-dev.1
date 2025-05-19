Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FBEC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 18:20:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E7EB40668;
	Mon, 19 May 2025 20:20:04 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7ADE24065F
 for <dev@dpdk.org>; Mon, 19 May 2025 20:20:02 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7c54f67db99so621952085a.1
 for <dev@dpdk.org>; Mon, 19 May 2025 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747678802; x=1748283602; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0YR4vcpHFCptTfKsbD8gB8FELdTI7P5Y8OYxmqeMW0=;
 b=TeUA7FUKJ5QCEUu614OvFHIpJIe+fUBV2w0sHMXluZlw+BIetbprCwLujtLdNKttjE
 mFCOUphXPC741CvadedIPu+2PUVLfgLWGoE8PZn629FjVJfirnhQ0L+0d8D2v9QzZrCX
 a0VVvNAzlHzgZIy5uqGRzAtOEKve86jYoywZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747678802; x=1748283602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0YR4vcpHFCptTfKsbD8gB8FELdTI7P5Y8OYxmqeMW0=;
 b=cMFm0yJmOGvpTyF1zfDEUdwXdkkGxm1oTbxZ26LJKqIHJJ0IEVbNHLmqwvCKCt7q5i
 vK7VYC6AxDrS/DRtEjT3jeDPdy6vdJHQ7WjwGfTUevkMPNK1OkwlY5ib/bg03zgUNFwb
 mVe9iod2bYhI5OLebt9PxOFbOkX5AYNpRGSZaHEyd3qKWrYdCBMWLM2KReR2gF/rlDZF
 tKulgWZ8MQfsRQBAsYNP5deFyxhl9+f3AT5vpMdRyVZI6H/vTZXNQxmn02Nf/4HSVhC8
 elyHI7p5in6LxYiffprVPxlc7+30y6yUr7YkGk+MJ8EOQORPakSevXzmoVv+7VZYPI25
 MUIw==
X-Gm-Message-State: AOJu0YxDR23nHddmvQLa/Ww2hTz3yIi1tYnzxZWk2EIijumFM75BiGaa
 kYf8n6EOQnV8GAFWWz0M1XGvEW2PonhOKkEoJXEol+2pmnmxfvgOgQrjl4Q8bzAfswY=
X-Gm-Gg: ASbGncut2FjxgFsk0kDCNy3srC6aZr2XmnJV/dUnv0TRdoIqj2ffW/x3nktDoKWgXfs
 Puk9A1iMZ2Fh39rCL/DRF3MZZQCOAOSbZ4kphlb6gyWpFXL0oWl6897JmBvIqnl9nNJw9MlQvHs
 n1+JSyIKXst39IZFUuZfRnrs1higIp1gqTUO/xcKeyfwyONtg1Ce8RD/k2zI27OBScelRYhDBWC
 rs+G1Ix2AB8Iyz2UmEqdu4DKn/LvtT/xwUPg9XmoV3iuzQqJu5UWfJz67EmzgPozEVx3/SxwvdX
 uTk7nY6ZkKjZt/ayl01NwtNrxaAQc4oflaBOcD86K00LZX60lybrthjJuJII05cqOkt61W5D
X-Google-Smtp-Source: AGHT+IGArNmXnfQSjVGGUHEoajZ2xdYqlwFEFTUBxdOSowuXLpD8j0em9PCyDAViPtKz3C5ZlmKMMw==
X-Received: by 2002:a05:620a:c4f:b0:7ce:c600:82c9 with SMTP id
 af79cd13be357-7cec6008341mr676685a.13.1747678801601; 
 Mon, 19 May 2025 11:20:01 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd468cd130sm614991285a.103.2025.05.19.11.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 11:20:01 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 2/2] dts: add jump and priority tests to flow suite
Date: Mon, 19 May 2025 14:19:57 -0400
Message-ID: <20250519181957.228084-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519181957.228084-1-dmarx@iol.unh.edu>
References: <20250515163809.184720-2-dmarx@iol.unh.edu>
 <20250519181957.228084-1-dmarx@iol.unh.edu>
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

Add jump action verification method and test case to Flow API test suite,
as well as a case for validating flows with different priority levels.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_flow.py | 187 +++++++++++++++++++++++++++++++-----
 1 file changed, 165 insertions(+), 22 deletions(-)

diff --git a/dts/tests/TestSuite_flow.py b/dts/tests/TestSuite_flow.py
index 15566205c9..06bd3bedc5 100644
--- a/dts/tests/TestSuite_flow.py
+++ b/dts/tests/TestSuite_flow.py
@@ -29,7 +29,7 @@
 class TestFlow(TestSuite):
     """RTE Flow test suite.
 
-    This suite consists of 10 test cases:
+    This suite consists of 12 test cases:
     1. Queue Action Ethernet: Verifies queue actions with ethernet patterns
     2. Queue Action IP: Verifies queue actions with IPv4 and IPv6 patterns
     3. Queue Action L4: Verifies queue actions with TCP and UDP patterns
@@ -39,7 +39,9 @@ class TestFlow(TestSuite):
     7. Drop Action L4: Verifies drop actions with TCP and UDP patterns
     8. Drop Action VLAN: Verifies drop actions with VLAN patterns
     9. Modify Field Action: Verifies packet modification patterns
-    10. Egress Rules: Verifies previously covered rules are still valid as egress.
+    10. Egress Rules: Verifies previously covered rules are still valid as egress
+    11. Jump Action: Verifies packet behavior given grouped flows
+    12. Priority Attribute: Verifies packet behavior given flows with different priorities
 
     """
 
@@ -169,14 +171,45 @@ def send_packet_and_verify_modification(self, packet: Packet, expected_packet: P
                 f"MAC dst mismatch: expected {expected_mac_dst}, got {received_mac_dst}",
             )
 
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
+        testpmd.set_verbose(level=1)
+        for flow in flow_rules:
+            testpmd.flow_create(flow_rule=flow, port_id=0)
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
     @func_test
     def test_queue_action_ETH(self) -> None:
         """Validate flow rules with queue actions and ethernet patterns.
 
         Steps:
             Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
 
         Verify:
             Check that each packet is received on the appropriate queue.
@@ -214,8 +247,10 @@ def test_queue_action_IP(self) -> None:
 
         Steps:
             Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
 
         Verify:
             Check that each packet is received on the appropriate queue.
@@ -269,8 +304,10 @@ def test_queue_action_L4(self) -> None:
 
         Steps:
             Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
 
         Verify:
             Check that each packet is received on the appropriate queue.
@@ -322,8 +359,10 @@ def test_queue_action_VLAN(self) -> None:
 
         Steps:
             Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, capture testpmd verbose output.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
 
         Verify:
             Check that each packet is received on the appropriate queue.
@@ -346,8 +385,10 @@ def test_drop_action_ETH(self) -> None:
 
         Steps:
             Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, check reception status.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
 
         Verify:
             Check that each packet is dropped.
@@ -387,8 +428,10 @@ def test_drop_action_IP(self) -> None:
 
         Steps:
             Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, check reception status.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
 
         Verify:
             Check that each packet is dropped.
@@ -435,8 +478,10 @@ def test_drop_action_L4(self) -> None:
 
         Steps:
             Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, check reception status.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
 
         Verify:
             Check that each packet is dropped.
@@ -479,8 +524,10 @@ def test_drop_action_VLAN(self) -> None:
 
         Steps:
             Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, check reception status.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
 
         Verify:
             Check that each packet is dropped.
@@ -511,8 +558,11 @@ def test_modify_actions(self) -> None:
 
         Steps:
             Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, check attributes.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
+
         Verify:
             Verify packet is received with the new attributes.
         """
@@ -552,8 +602,10 @@ def test_egress_rules(self) -> None:
 
         Steps:
             Create a list of packets to test, with a corresponding flow list.
-            Launch testpmd with the necessary configuration.
-            Send each packet in the list, check reception status.
+            Launch testpmd.
+            Create first flow rule in flow list.
+            Send first packet in packet list, capture verbose output.
+            Delete flow rule, repeat for all flows/packets.
 
         Verify:
             Check that each packet is dropped.
@@ -583,3 +635,94 @@ def test_egress_rules(self) -> None:
             packets=packet_list,
             should_receive=False,
         )
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
+            FlowRule(direction="ingress", group_id=0, pattern=["eth"], actions=["jump group 1"]),
+            FlowRule(direction="ingress", group_id=0, pattern=["ipv4"], actions=["jump group 2"]),
+            FlowRule(
+                direction="ingress", group_id=0, pattern=["eth / ipv4"], actions=["queue index 1"]
+            ),
+            FlowRule(
+                direction="ingress",
+                group_id=0,
+                pattern=["eth / ipv4 / tcp"],
+                actions=["queue index 2"],
+            ),
+            FlowRule(
+                direction="ingress",
+                group_id=0,
+                pattern=["eth / ipv4 / udp"],
+                actions=["queue index 3"],
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
+            testpmd.set_verbose(level=1)
+            for flow, expected_queue in zip(flow_list, expected_queue_list):
+                testpmd.flow_create(flow_rule=flow, port_id=0)
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

