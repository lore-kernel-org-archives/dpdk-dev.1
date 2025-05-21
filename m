Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC718C54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 19:26:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B2E042E3A;
	Wed, 21 May 2025 21:26:37 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 274DB42DE4
 for <dev@dpdk.org>; Wed, 21 May 2025 21:26:35 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7cadc92771dso701102285a.1
 for <dev@dpdk.org>; Wed, 21 May 2025 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747855594; x=1748460394; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PU3NIAz4b82CnjjxwMapawE0Yfsr9GAA3l11qdNPmI=;
 b=Z77+b1kcy4b5YI+ePVHv9uTL4rXwaXVDVVyWRUq1/2Gm0X1QWWO4ufgjGqxeXnU/OM
 wRX+l6/mVHBz5IOL4ebXVmxRhtuw+vmEUgmuW1rPdyIjvjuMqpfE2MoWfyhtFgesiiLN
 W36mbbr0ezWGfUjhZiNZ35uLP6yoqt5TECzRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747855594; x=1748460394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+PU3NIAz4b82CnjjxwMapawE0Yfsr9GAA3l11qdNPmI=;
 b=jOOsx62Oh/FUpnqBEMUlowr9HCAjOUBALrb37P9GhKPbYVdb5C8JX+AuzyTvd/g5a/
 aofklYFKpRpNzQkRTP/bV7H0WmCQ9Sq3o0U3ks6RCT2RJ868TFctHwPjInNylnvNixCS
 oWgeo4aRZLlxI7cTYt4Cm9C1T69I6b/zOjrPe3zZLWWEHtFR2IFJ1qBc0AfJYqm3qtY5
 YbTYy3/JEzhjQ/QpBLWoffmPGxtp6C2FUMzuoCbIDTE2hV+A7duyeulTLubmlzhTcWB3
 7nRO1DWeRrqr+O2i3lWFH6VMX1elyWpGK1vwdCL16hW9eSzsqLS4Farq3X6rMX1SuK47
 1q8Q==
X-Gm-Message-State: AOJu0YxX41QLnnNqh3+IH0XYwzJhWHdjMt7kH83HvxjbmhsoYUoeyj82
 kCE/9F4iBfSlxtUl1+5bXfmRB8KwWws9uQh7MveIUgTL25FxasNqwnuAlVrBUDU0T8I=
X-Gm-Gg: ASbGncvJ/Zd2drTutYB4xCy5R9ZtVJwJtg4aZwqJcH9IZW6BA7mqtIPF1xZifL9fcm3
 4KMYFfpDK3NUoe3Xj8xCaW3n9auravm1RZs4Ia5MFxx3xIW68bWKJjBbKvMqW8pL/3Vxd4Z494D
 ly/jtiogxfknnkWhxKmUNLUiLTQ2mXpcQF+EvAAl1Ov4BMYvn97Mw29LojDjM2cfRrdsIJ/CZ7S
 9ObVsprAFVa+5bOeQiEe/g7xqHvj0rBZKhS99qxUal5VFt0+fmT9Rl/K7kVfEpIRBQdmAd5d+MP
 i/h3+NCfGhqAsjCpyk62OoHujFngAw0y2cGNT0BMANSEzltZo7qfVPtrI4qW/GwIJ7KpLode
X-Google-Smtp-Source: AGHT+IHlVaE7Z9YkzkmRgHq/jarwP2EQ3skGo56C2O8oBzICl8o0kzH9oCmjvE5C/gxBftyKWu4/Gw==
X-Received: by 2002:a05:620a:9176:b0:7cd:53d7:4f9f with SMTP id
 af79cd13be357-7cd53d7516bmr2522902785a.1.1747855594326; 
 Wed, 21 May 2025 12:26:34 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd468d8e68sm911456385a.112.2025.05.21.12.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 12:26:33 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 3/3] dts: add flow validation
Date: Wed, 21 May 2025 15:26:29 -0400
Message-ID: <20250521192629.294265-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521192629.294265-1-dmarx@iol.unh.edu>
References: <20250519181957.228084-1-dmarx@iol.unh.edu>
 <20250521192629.294265-1-dmarx@iol.unh.edu>
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

Add a method for validating flow rules to the testpmd shell class.
Implement test case skipping for flow rules that do not pass
validation.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 15 ++++
 dts/framework/test_run.py                     |  3 +
 dts/framework/test_suite.py                   | 21 ++++-
 dts/tests/TestSuite_flow.py                   | 90 +++++++++++++------
 4 files changed, 102 insertions(+), 27 deletions(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index bd5f2659bd..c2c7ade60a 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1961,6 +1961,21 @@ def flow_create(self, flow_rule: FlowRule, port_id: int) -> int:
             self._logger.debug(f"Failed to create flow rule:\n{flow_output}")
             raise InteractiveCommandExecutionError(f"Failed to create flow rule:\n{flow_output}")
 
+    def flow_validate(self, flow_rule: FlowRule, port_id: int) -> bool:
+        """Validates a flow rule in the testpmd session.
+
+        Args:
+            flow_rule: :class:`FlowRule` object used for validating testpmd flow rule.
+            port_id: Integer representing the port to use.
+
+        Returns:
+            Boolean representing whether rule is valid or not.
+        """
+        flow_output = self.send_command(f"flow validate {port_id} {flow_rule}")
+        if "Flow rule validated" in flow_output:
+            return True
+        return False
+
     def flow_delete(self, flow_id: int, port_id: int, verify: bool = True) -> None:
         """Deletes the specified flow rule from the testpmd session.
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 0fdc57ea9c..cf4af19e8f 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -644,6 +644,9 @@ def next(self) -> State | None:
                 return self
 
             self.result.update(Result.FAIL, e)
+        except SkippedTestException as e:
+            self.logger.info(f"Test case execution SKIPPED: {e}")
+            self.result.update(Result.SKIP, e)
         else:
             self.result.update(Result.PASS)
             self.logger.info(f"{self.description.capitalize()} PASSED.")
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index e07c327b77..34e9eb54ea 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -39,7 +39,7 @@
     PacketFilteringConfig,
 )
 
-from .exception import ConfigurationError, InternalError, TestCaseVerifyError
+from .exception import ConfigurationError, InternalError, SkippedTestException, TestCaseVerifyError
 from .logger import DTSLogger, get_dts_logger
 from .utils import get_packet_summaries, to_pascal_case
 
@@ -411,6 +411,25 @@ def _fail_test_case_verify(self, failure_description: str) -> None:
             self._logger.debug(command_res.command)
         raise TestCaseVerifyError(failure_description)
 
+    def verify_skip(self, condition: bool, skip_reason: str) -> None:
+        """Verify `condition` and handle skips.
+
+        When `condition` is :data:`False`, raise a skip exception.
+
+        Args:
+            condition: The condition to check.
+            skip_reason: Description of the reason for skipping.
+
+        Raises:
+            SkippedTestException: `condition` is :data:`False`.
+        """
+        if not condition:
+            self._skip_test_case_verify(skip_reason)
+
+    def _skip_test_case_verify(self, skip_description: str) -> None:
+        self._logger.debug(f"Test case skipped: {skip_description}")
+        raise SkippedTestException(skip_description)
+
     def verify_packets(self, expected_packet: Packet, received_packets: list[Packet]) -> None:
         """Verify that `expected_packet` has been received.
 
diff --git a/dts/tests/TestSuite_flow.py b/dts/tests/TestSuite_flow.py
index 06bd3bedc5..6c5f9b0e8e 100644
--- a/dts/tests/TestSuite_flow.py
+++ b/dts/tests/TestSuite_flow.py
@@ -19,6 +19,7 @@
 from scapy.layers.l2 import Dot1Q, Ether
 from scapy.packet import Packet, Raw
 
+from framework.exception import InteractiveCommandExecutionError
 from framework.remote_session.testpmd_shell import FlowRule, TestPmdShell
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.capability import NicCapability, TopologyType, requires
@@ -84,10 +85,17 @@ def zip_lists(
 
         with TestPmdShell(rx_queues=4, tx_queues=4) as testpmd:
             for flow, packet, expected_packet in zip_lists(flows, packets, expected_packets):
-                flow_id = testpmd.flow_create(flow_rule=flow, port_id=0)
+                is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
+                self.verify_skip(is_valid, "flow rule failed validation.")
+
+                try:
+                    flow_id = testpmd.flow_create(flow_rule=flow, port_id=0)
+                except InteractiveCommandExecutionError:
+                    self.log("Flow rule validation passed, but flow creation failed.")
+                    self.verify(False, "Failed flow creation")
 
                 if verification_method == self.send_packet_and_verify:
-                    verification_method(*args, **kwargs)
+                    verification_method(packet=packet, *args, **kwargs)
 
                 elif verification_method == self.send_packet_and_verify_queue:
                     verification_method(
@@ -125,7 +133,7 @@ def send_packet_and_verify_queue(
             test_queue: Represents the queue the test packet is being sent to.
             testpmd: TestPmdShell instance being used to send test packet.
         """
-        testpmd.set_verbose(level=1)
+        testpmd.set_verbose(level=8)
         testpmd.start()
         self.send_packet_and_capture(packet=packet)
         verbose_output = testpmd.extract_verbose_output(testpmd.stop())
@@ -186,9 +194,16 @@ def send_packet_and_verify_jump(
             test_queues: List of Rx queue IDs each packet should be received on.
             testpmd: TestPmdShell instance to create flows on.
         """
-        testpmd.set_verbose(level=1)
+        testpmd.set_verbose(level=8)
         for flow in flow_rules:
-            testpmd.flow_create(flow_rule=flow, port_id=0)
+            is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
+            self.verify_skip(is_valid, "flow rule failed validation.")
+
+            try:
+                testpmd.flow_create(flow_rule=flow, port_id=0)
+            except InteractiveCommandExecutionError:
+                self.log("Flow validation passed, but flow creation failed.")
+                self.verify(False, "Failed flow creation")
 
         for packet, test_queue in zip(packets, test_queues):
             testpmd.start()
@@ -397,12 +412,9 @@ def test_drop_action_ETH(self) -> None:
         received under normal circumstances.
         """
         packet_list = [
-            Ether(src="02:00:00:00:00:00"),
-            Raw(load="xxxxx"),
-            Ether(dst="02:00:00:00:00:00"),
-            Raw(load="xxxxx"),
-            Ether(type=0x0800),
-            Raw(load="xxxxx"),
+            Ether(src="02:00:00:00:00:00") / Raw(load="xxxxx"),
+            Ether(dst="02:00:00:00:00:00") / Raw(load="xxxxx"),
+            Ether(type=0x0800) / Raw(load="xxxxx"),
         ]
         flow_list = [
             FlowRule(
@@ -413,8 +425,12 @@ def test_drop_action_ETH(self) -> None:
             ),
             FlowRule(direction="ingress", pattern=["eth type is 0x0800"], actions=["drop"]),
         ]
-        # Verify packet reception without flow rule
-        self.send_packet_and_verify(packet=Raw(load="xxxxx"), should_receive=True)
+        # verify reception with test packet
+        packet = Ether() / IP() / Raw(load="xxxxx")
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received = self.send_packet_and_capture(packet)
+            self.verify(received != [], "Test packet was never received.")
         self.runner(
             verification_method=self.send_packet_and_verify,
             flows=flow_list,
@@ -463,8 +479,12 @@ def test_drop_action_IP(self) -> None:
             ),
             FlowRule(direction="ingress", pattern=["eth / ipv6 proto is 17"], actions=["drop"]),
         ]
-        # Verify packet reception without flow rule
-        self.send_packet_and_verify(packet=Raw(load="xxxxx"), should_receive=True)
+        # verify reception with test packet
+        packet = Ether() / IP() / Raw(load="xxxxx")
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received = self.send_packet_and_capture(packet)
+            self.verify(received != [], "Test packet was never received.")
         self.runner(
             verification_method=self.send_packet_and_verify,
             flows=flow_list,
@@ -509,8 +529,12 @@ def test_drop_action_L4(self) -> None:
             ),
             FlowRule(direction="ingress", pattern=["eth / ipv4 / udp dst is 53"], actions=["drop"]),
         ]
-        # Verify packet reception without flow rule
-        self.send_packet_and_verify(packet=Raw(load="xxxxx"), should_receive=True)
+        # verify reception with test packet
+        packet = Ether() / IP() / Raw(load="xxxxx")
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received = self.send_packet_and_capture(packet)
+            self.verify(received != [], "Test packet was never received.")
         self.runner(
             verification_method=self.send_packet_and_verify,
             flows=flow_list,
@@ -543,8 +567,12 @@ def test_drop_action_VLAN(self) -> None:
             FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["drop"]),
             FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["drop"]),
         ]
-        # Verify packet reception without flow rule
-        self.send_packet_and_verify(packet=Raw(load="xxxxx"), should_receive=True)
+        # verify reception with test packet
+        packet = Ether() / IP() / Raw(load="xxxxx")
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received = self.send_packet_and_capture(packet)
+            self.verify(received != [], "Test packet was never received.")
         self.runner(
             verification_method=self.send_packet_and_verify,
             flows=flow_list,
@@ -615,9 +643,9 @@ def test_egress_rules(self) -> None:
         """
         packet_list = [
             Ether(src="02:00:00:00:00:00"),
-            IP(src="192.168.1.1"),
-            TCP(sport=1234),
-            UDP(sport=5000),
+            Ether() / IP(src="192.168.1.1"),
+            IP() / TCP(sport=1234),
+            IP() / UDP(sport=5000),
         ]
         flow_list = [
             FlowRule(
@@ -627,8 +655,12 @@ def test_egress_rules(self) -> None:
             FlowRule(direction="egress", pattern=["tcp src is 1234"], actions=["drop"]),
             FlowRule(direction="egress", pattern=["udp src is 5000"], actions=["drop"]),
         ]
-        # Verify packet reception without flow rule
-        self.send_packet_and_verify(packet=Raw(load="xxxxx"), should_receive=True)
+        # verify reception with test packet
+        packet = Ether() / IP() / Raw(load="xxxxx")
+        with TestPmdShell() as testpmd:
+            testpmd.start()
+            received = self.send_packet_and_capture(packet)
+            self.verify(received != [], "Test packet was never received.")
         self.runner(
             verification_method=self.send_packet_and_verify,
             flows=flow_list,
@@ -715,9 +747,15 @@ def test_priority_attribute(self) -> None:
         ]
         expected_queue_list = [1, 2, 3]
         with TestPmdShell(rx_queues=4, tx_queues=4) as testpmd:
-            testpmd.set_verbose(level=1)
+            testpmd.set_verbose(level=8)
             for flow, expected_queue in zip(flow_list, expected_queue_list):
-                testpmd.flow_create(flow_rule=flow, port_id=0)
+                is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
+                self.verify_skip(is_valid, "flow rule failed validation.")
+                try:
+                    testpmd.flow_create(flow_rule=flow, port_id=0)
+                except InteractiveCommandExecutionError:
+                    self.log("Flow rule validation passed, but flow creation failed.")
+                    self.verify(False, "Failed flow creation")
                 testpmd.start()
                 self.send_packet_and_capture(test_packet)
                 verbose_output = testpmd.extract_verbose_output(testpmd.stop())
-- 
2.49.0

