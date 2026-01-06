Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32797CEFD11
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 21:38:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01F6C400EF;
	Tue,  6 Jan 2026 22:38:09 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 44754400D7
 for <dev@dpdk.org>; Tue,  6 Jan 2026 22:38:07 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8804f1bd6a7so12385366d6.2
 for <dev@dpdk.org>; Tue, 06 Jan 2026 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1767735486; x=1768340286; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XrlpDcCFIWwHRXTB7k+VWM9ZEnQBqfPWZC5fRkivdQc=;
 b=JKxt4JrSogpd2OkJQMMNodpbOnx3vZuhqyHFWcGUvOfI3edOtiAMJLMy+41CnnJK1i
 90LWL3FYALyqZ6a5hKRHOqtc55VUkyZg+cTTvZVG1xLoyGh8jBDE9UsFDHHRVuXHF9vm
 lQkY/K4HzOHSd7MzTT4NIpeq2mpIT4HKTzfps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767735486; x=1768340286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XrlpDcCFIWwHRXTB7k+VWM9ZEnQBqfPWZC5fRkivdQc=;
 b=LTTBbFFVWOzLOP3sKWqPnCz7S13nT7MghRzyDKQ9qobbh7lokiyRKHcDCmSQ92R4lK
 rwTuVAkPtKJYhwJcKy0KVz+B82y/lKf2oKjJBU2o8N965/oyylDgatzAEH/gPVLLQ/34
 ZWqF7yu8yIBA7hWqyzwCeHE5LCem9SVQ7A2iPnrDM+pOkM344ssy+EOfY9D/wMDtoM/z
 U1+/Zeo6jiBWaX9GDD9x4I0DjvjjJlCfhz+/UfVlPdje1h3YUJNFms4imbOsTwg2R1dc
 RT2j16knFpXMlNNLi4HKC5W0iKd+NZTuOMbkGVeCbk//BJ5CoX3y8JrzrY5iW/KODNDD
 LQsg==
X-Gm-Message-State: AOJu0YyIJoqAZBU6uiMKWSAmeAAfJaUzqbSrgnispxWvS76Qil6FXbq8
 YmA9C1Srod3AilG8Snm1okUa3D1rVe+t1XIf8se7NloVc8IBC1AKgkO8fnaVek4+IP4=
X-Gm-Gg: AY/fxX7Cv1saAJj+Ez8+0qlopit6axXGJLQKJ/HwSG1sc6fabdim2pKDpLEonX/sMAQ
 +rfuhEQII0SO0S1It8GUex/29Xi2HWp7YNfVORUPRkpS3DHDMJdFa1brvKabdkJ+loPqEmPQDGk
 5NqCbuHIZrXvXVjXypVelcYxT38zDRwU0lniNARK34zICAd+XzG8EAlo74xy7XOtYVUv8z1P/58
 Sgrcg8HRqSTCzYRDX6ce/yFIG3HkBv0z+iGVGjs6NPzcuLBdNTp4KyI5qqWGUphxTnAY7+92x2s
 zfV0xf9jX4XkLOK5AFaYtwrAPZVI4bWhEz1fITf7DWwo2+YIakOg8R83ROXh891j+yc5dwatcR+
 HORI6yfz57hzAuu0ciOQtRfSq5houxpxOYcUJTjR4ut6UdU9ojGyxs7Nun1a7PjEzYHqOzYDvr7
 9mGnE44LOiR/famKcAmFIHjTtXh6lYumdk7a+yzCgplisrcqtmoxY=
X-Google-Smtp-Source: AGHT+IHg8G98j8t9BhlPMn2PcpfRtCGsqreWRLRX6uXgD72ieY8CTH7zbz3jE+exi2movrP9+IabXw==
X-Received: by 2002:a05:6214:390e:b0:80b:11b7:210b with SMTP id
 6a1803df08f44-89084235947mr5936226d6.43.1767735486077; 
 Tue, 06 Jan 2026 13:38:06 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8c00acesm18955621cf.0.2026.01.06.13.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 13:38:05 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1] dts: refactor flow suite with generator pattern
Date: Tue,  6 Jan 2026 16:38:03 -0500
Message-ID: <20260106213803.205934-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
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

Refactor current flow test suite to utilize a generator
method, which dynamically creates flow rules from a
dictionary of pattern and action fields during runtime.
This allows for much more extensive testing of the flow
API without exponential code growth.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_rte_flow.py | 1435 ++++++++++++++++---------------
 1 file changed, 764 insertions(+), 671 deletions(-)

diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 207cbce2d3..24d50e603c 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -10,223 +10,657 @@
 
 """
 
-from collections.abc import Callable
-from itertools import zip_longest
-from typing import Any, Iterator, cast
+from dataclasses import dataclass, field
+from itertools import product
+from typing import Any, Callable, cast
 
-from scapy.layers.inet import IP, TCP, UDP
+from scapy.layers.inet import ICMP, IP, TCP, UDP
 from scapy.layers.inet6 import IPv6
-from scapy.layers.l2 import Dot1Q, Ether
+from scapy.layers.l2 import ARP, Dot1Q, Ether
+from scapy.layers.sctp import SCTP
 from scapy.packet import Packet, Raw
 
-from api.capabilities import (
-    NicCapability,
-    requires_nic_capability,
-)
+from api.capabilities import NicCapability, requires_nic_capability
 from api.packet import send_packet_and_capture
-from api.test import fail, log, verify, verify_else_skip
+from api.test import fail, log, verify
 from api.testpmd import TestPmd
 from api.testpmd.types import FlowRule
-from framework.exception import InteractiveCommandExecutionError
+from framework.exception import InteractiveCommandExecutionError, SkippedTestException
 from framework.test_suite import TestSuite, func_test
 
 
-@requires_nic_capability(NicCapability.FLOW_CTRL)
-class TestRteFlow(TestSuite):
-    """RTE Flow test suite.
+@dataclass
+class PatternField:
+    """Specification for a single matchable field within a protocol layer."""
+
+    scapy_field: str
+    pattern_field: str
+    test_values: list[Any]
+
+
+@dataclass
+class Layer:
+    """Complete specification for a protocol layer."""
+
+    name: str
+    scapy_class: type
+    pattern_name: str
+    fields: list[PatternField]
+    requires: list[str] = field(default_factory=list)
+
+    def build_scapy_layer(self, field_values: dict[str, Any]) -> Packet:
+        """Construct a Scapy layer with the given field values."""
+        return self.scapy_class(**field_values)
+
+
+@dataclass
+class Action:
+    """Specification for a flow action."""
+
+    name: str
+    action_format: str
+    verification_type: str
+    param_builder: Callable[[Any], dict[str, Any]]
+    expected_packet_builder: Callable[[Packet], Packet] | None = None
+
+    def build_action_string(self, value: Any = None) -> str:
+        """Generate the action string for a flow rule."""
+        if value is not None and "{value}" in self.action_format:
+            return self.action_format.format(value=value)
+        return self.action_format
+
+    def build_verification_params(self, value: Any = None) -> dict[str, Any]:
+        """Generate verification parameters for this action."""
+        return self.param_builder(value)
+
+    def build_expected_packet(self, original_packet: Packet) -> Packet | None:
+        """Build expected packet for modification actions."""
+        if self.expected_packet_builder:
+            return self.expected_packet_builder(original_packet)
+        return None
+
+
+@dataclass
+class FlowTestCase:
+    """A complete test case ready for execution."""
+
+    flow_rule: FlowRule
+    packet: Packet
+    verification_type: str
+    verification_params: dict[str, Any]
+    description: str = ""
+    expected_packet: Packet | None = None
+
+
+@dataclass
+class FlowTestResult:
+    """Result of a single test case execution."""
+
+    description: str
+    passed: bool
+    failure_reason: str = ""
+    flow_rule_pattern: str = ""
+    skipped: bool = False
+    sent_packet: Packet | None = None
+
+
+LAYERS: dict[str, Layer] = {
+    "eth": Layer(
+        name="eth",
+        scapy_class=Ether,
+        pattern_name="eth",
+        fields=[
+            PatternField("src", "src", ["02:00:00:00:00:00"]),
+            PatternField("dst", "dst", ["02:00:00:00:00:02"]),
+        ],
+    ),
+    "ipv4": Layer(
+        name="ipv4",
+        scapy_class=IP,
+        pattern_name="ipv4",
+        fields=[
+            PatternField("src", "src", ["192.168.1.1"]),
+            PatternField("dst", "dst", ["192.168.1.2"]),
+            PatternField("ttl", "ttl", [64, 128]),
+            PatternField("tos", "tos", [0, 4]),
+        ],
+        requires=["eth"],
+    ),
+    "ipv6": Layer(
+        name="ipv6",
+        scapy_class=IPv6,
+        pattern_name="ipv6",
+        fields=[
+            PatternField("src", "src", ["2001:db8::1"]),
+            PatternField("dst", "dst", ["2001:db8::2"]),
+            PatternField("tc", "tc", [0, 4]),
+            PatternField("hlim", "hop", [64, 128]),
+        ],
+        requires=["eth"],
+    ),
+    "tcp": Layer(
+        name="tcp",
+        scapy_class=TCP,
+        pattern_name="tcp",
+        fields=[
+            PatternField("sport", "src", [1234, 8080]),
+            PatternField("dport", "dst", [80, 443]),
+            PatternField("flags", "flags", [2, 16]),
+        ],
+        requires=["eth", "ipv4"],
+    ),
+    "udp": Layer(
+        name="udp",
+        scapy_class=UDP,
+        pattern_name="udp",
+        fields=[
+            PatternField("sport", "src", [5000]),
+            PatternField("dport", "dst", [53, 123]),
+        ],
+        requires=["eth", "ipv4"],
+    ),
+    "vlan": Layer(
+        name="vlan",
+        scapy_class=Dot1Q,
+        pattern_name="vlan",
+        fields=[
+            PatternField("vlan", "vid", [100, 200]),
+            PatternField("prio", "pcp", [0, 7]),
+        ],
+        requires=["eth"],
+    ),
+    "icmp": Layer(
+        name="icmp",
+        scapy_class=ICMP,
+        pattern_name="icmp",
+        fields=[
+            PatternField("type", "type", [8, 0]),
+            PatternField("code", "code", [0]),
+            PatternField("id", "ident", [0, 1234]),
+            PatternField("seq", "seq", [0, 1]),
+        ],
+        requires=["eth", "ipv4"],
+    ),
+    "sctp": Layer(
+        name="sctp",
+        scapy_class=SCTP,
+        pattern_name="sctp",
+        fields=[
+            PatternField("sport", "src", [2905, 3868]),
+            PatternField("dport", "dst", [2905, 3868]),
+            PatternField("tag", "tag", [1, 12346]),
+        ],
+        requires=["eth", "ipv4"],
+    ),
+    "arp": Layer(
+        name="arp",
+        scapy_class=ARP,
+        pattern_name="arp_eth_ipv4",
+        fields=[
+            PatternField("psrc", "spa", ["192.168.1.1"]),
+            PatternField("pdst", "tpa", ["192.168.1.2"]),
+            PatternField("op", "opcode", [1, 2]),
+        ],
+        requires=["eth"],
+    ),
+}
+
+
+def _build_ipv4_src_to_dst_expected(packet: Packet) -> Packet:
+    """Build expected packet for IPV4 src to dst copy."""
+    expected = cast(Packet, packet.copy())
+    if IP in expected:
+        expected[IP].dst = packet[IP].src
+    return expected
+
+
+def _build_mac_src_to_dst_expected(packet: Packet) -> Packet:
+    """Build expected packet for MAC src to dst copy."""
+    expected = cast(Packet, packet.copy())
+    if Ether in expected:
+        expected[Ether].dst = packet[Ether].src
+    return expected
+
+
+ACTIONS: dict[str, Action] = {
+    "queue": Action(
+        name="queue",
+        action_format="queue index {value}",
+        verification_type="queue",
+        param_builder=lambda queue_id: {"queue_id": queue_id},
+    ),
+    "drop": Action(
+        name="drop",
+        action_format="drop",
+        verification_type="drop",
+        param_builder=lambda _: {"should_receive": False},
+    ),
+    "modify_ipv4_src_to_dst": Action(
+        name="modify_ipv4_src_to_dst",
+        action_format="modify_field op set dst_type "
+        "ipv4_dst src_type ipv4_src width 32 / queue index 0",
+        verification_type="modify",
+        param_builder=lambda _: {},
+        expected_packet_builder=_build_ipv4_src_to_dst_expected,
+    ),
+    "modify_mac_src_to_dst": Action(
+        name="modify_mac_src_to_dst",
+        action_format="modify_field op set dst_type "
+        "mac_dst src_type mac_src width 48 / queue index 0",
+        verification_type="modify",
+        param_builder=lambda _: {},
+        expected_packet_builder=_build_mac_src_to_dst_expected,
+    ),
+}
+
+LAYER_STACKS = [
+    ["eth"],
+    ["eth", "ipv4"],
+    ["eth", "ipv4", "tcp"],
+    ["eth", "ipv4", "udp"],
+    ["eth", "ipv4", "icmp"],
+    ["eth", "ipv4", "sctp"],
+    ["eth", "ipv6"],
+    ["eth", "ipv6", "tcp"],
+    ["eth", "ipv6", "udp"],
+    ["eth", "ipv6", "sctp"],
+    ["eth", "vlan"],
+    ["eth", "vlan", "ipv4"],
+    ["eth", "vlan", "ipv4", "tcp"],
+    ["eth", "vlan", "ipv4", "udp"],
+    ["eth", "vlan", "ipv4", "sctp"],
+    ["eth", "vlan", "ipv6"],
+    ["eth", "vlan", "ipv6", "tcp"],
+    ["eth", "vlan", "ipv6", "udp"],
+    ["eth", "arp"],
+]
+
+
+class FlowTestGenerator:
+    """Generates test cases by combining patterns and actions."""
+
+    def __init__(self, layers: dict[str, Layer], actions: dict[str, Action]):
+        """Initialize the generator with layer and action specifications."""
+        self.layers = layers
+        self.actions = actions
+
+    def _build_multi_layer_packet(
+        self,
+        layer_stack: list[str],
+        all_field_values: dict[str, dict[str, Any]],
+        add_payload: bool = True,
+    ) -> Packet:
+        """Build a packet from multiple protocol layers."""
+        packet: Packet = Ether()
+        prev_layer_name = None
 
-    This suite consists of 12 test cases:
-    1. Queue Action Ethernet: Verifies queue actions with ethernet patterns
-    2. Queue Action IP: Verifies queue actions with IPv4 and IPv6 patterns
-    3. Queue Action L4: Verifies queue actions with TCP and UDP patterns
-    4. Queue Action VLAN: Verifies queue actions with VLAN patterns
-    5. Drop Action Eth: Verifies drop action with ethernet patterns
-    6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 patterns
-    7. Drop Action L4: Verifies drop actions with TCP and UDP patterns
-    8. Drop Action VLAN: Verifies drop actions with VLAN patterns
-    9. Modify Field Action: Verifies packet modification patterns
-    10. Egress Rules: Verifies previously covered rules are still valid as egress
-    11. Jump Action: Verifies packet behavior given grouped flows
-    12. Priority Attribute: Verifies packet behavior given flows with different priorities
+        for layer_name in layer_stack:
+            layer_spec = self.layers[layer_name]
+            values = all_field_values.get(layer_name, {})
+            layer = layer_spec.build_scapy_layer(values)
 
-    """
+            if layer_name == "eth":
+                packet = layer
+            else:
+                if prev_layer_name == "ipv6" and layer_name in ["tcp", "udp", "sctp"]:
+                    nh_map = {"tcp": 6, "udp": 17, "sctp": 132}
+                    packet[IPv6].nh = nh_map[layer_name]
+
+                packet = packet / layer
 
-    def _runner(
+            prev_layer_name = layer_name
+
+        if add_payload:
+            packet = packet / Raw(load="X" * 32)
+
+        return packet
+
+    def generate(
         self,
-        verification_method: Callable[..., Any],
-        flows: list[FlowRule],
-        packets: list[Packet],
-        port_id: int,
-        expected_packets: list[Packet] | None = None,
-        *args: Any,
-        **kwargs: Any,
-    ) -> None:
-        """Runner method that validates each flow using the corresponding verification method.
+        layer_names: list[str],
+        action_name: str,
+        action_value: Any = None,
+        group_id: int = 0,
+    ) -> list[FlowTestCase]:
+        """Generate test cases for patterns matching fields across multiple layers.
+
+        This method identifies every possible combination of one field per layer.
+        For each field combination, it iterates through the available test values.
+        If fields have an unequal number of test values, it cycles through the
+        shorter lists to ensure every specific value in every field is tested.
 
         Args:
-            verification_method: Callable that performs verification logic.
-            flows: List of flow rules to create and test.
-            packets: List of packets corresponding to each flow.
-            port_id: Number representing the port to create flows on.
-            expected_packets: List of packets to check sent packets against in modification cases.
-            *args: Additional positional arguments to pass to the verification method.
-            **kwargs: Additional keyword arguments to pass to the verification method.
+            layer_names: List of layer names to match.
+            action_name: Name of the action to apply.
+            action_value: Optional value for parameterized actions.
+            group_id: Flow group ID.
+
+        Returns:
+            List of FlowTestCase objects ready for execution.
         """
+        action_spec = self.actions[action_name]
+
+        # Organize layers into lists of matchable fields
+        layer_field_specs = []
+        for layer_name in layer_names:
+            layer_spec = self.layers[layer_name]
+            # Capture the layer spec and the field spec for each field in the layer
+            layer_field_specs.append([(layer_spec, f) for f in layer_spec.fields])
+
+        test_cases = []
+
+        # Iterate through every combination of fields across the requested layers
+        # For ['eth', 'ipv4'], this produces: (eth_src, ipv4_src), (eth_src, ipv4_dst), etc.
+        for field_combo in product(*layer_field_specs):
+            # Determine how many test cases are needed to cover all values in this combo
+            max_vals = max(len(f_spec.test_values) for _, f_spec in field_combo)
+
+            # Cycle through the test values for these fields
+            for i in range(max_vals):
+                pattern_parts = []
+                all_field_values: dict[str, dict[str, Any]] = {}
+                desc_parts = []
+
+                for layer_spec, field_spec in field_combo:
+                    # Select value by index
+                    val = field_spec.test_values[i % len(field_spec.test_values)]
+
+                    pattern_parts.append(
+                        f"{layer_spec.pattern_name} {field_spec.pattern_field} is {val}"
+                    )
+                    # Store value for Scapy packet building
+                    if layer_spec.name not in all_field_values:
+                        all_field_values[layer_spec.name] = {}
+                    all_field_values[layer_spec.name][field_spec.scapy_field] = val
+
+                    desc_parts.append(f"{layer_spec.name}[{field_spec.scapy_field}={val}]")
+
+                full_pattern = " / ".join(pattern_parts)
+                flow_rule = FlowRule(
+                    direction="ingress",
+                    pattern=[full_pattern],
+                    actions=[action_spec.build_action_string(action_value)],
+                    group_id=group_id,
+                )
+
+                add_payload = action_spec.verification_type in ["drop", "modify"]
+                packet = self._build_multi_layer_packet(layer_names, all_field_values, add_payload)
+
+                expected_packet = None
+                if action_spec.verification_type == "modify":
+                    expected_packet = action_spec.build_expected_packet(packet)
+
+                test_cases.append(
+                    FlowTestCase(
+                        flow_rule=flow_rule,
+                        packet=packet,
+                        verification_type=action_spec.verification_type,
+                        verification_params=action_spec.build_verification_params(action_value),
+                        description=" / ".join(desc_parts) + f" -> {action_spec.name}",
+                        expected_packet=expected_packet,
+                    )
+                )
 
-        def zip_lists(
-            rules: list[FlowRule],
-            packets1: list[Packet],
-            packets2: list[Packet] | None,
-        ) -> Iterator[tuple[FlowRule, Packet, Packet | None]]:
-            """Method that creates an iterable zip containing lists used in runner.
-
-            Args:
-                rules: List of flow rules.
-                packets1: List of packets.
-                packets2: Optional list of packets, excluded from zip if not passed to runner.
-            """
-            return cast(
-                Iterator[tuple[FlowRule, Packet, Packet | None]],
-                zip_longest(rules, packets1, packets2 or [], fillvalue=None),
-            )
+        return test_cases
 
-        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
-            for flow, packet, expected_packet in zip_lists(flows, packets, expected_packets):
-                is_valid = testpmd.flow_validate(flow_rule=flow, port_id=port_id)
-                verify_else_skip(is_valid, "flow rule failed validation.")
 
-                try:
-                    flow_id = testpmd.flow_create(flow_rule=flow, port_id=port_id)
-                except InteractiveCommandExecutionError:
-                    log("Flow rule validation passed, but flow creation failed.")
-                    fail("Failed flow creation")
+@requires_nic_capability(NicCapability.FLOW_CTRL)
+class TestRteFlow(TestSuite):
+    """RTE Flow test suite.
 
-                if verification_method == self._send_packet_and_verify:
-                    verification_method(packet=packet, *args, **kwargs)
+    This suite consists of 4 test cases:
+    1. Queue Action: Verifies queue actions with multi-layer patterns
+    2. Drop Action: Verifies drop actions with multi-layer patterns
+    3. Modify Field Action: Verifies modify_field actions with multi-layer patterns
+    4. Jump Action: Verifies jump action between flow groups
 
-                elif verification_method == self._send_packet_and_verify_queue:
-                    verification_method(
-                        packet=packet, test_queue=kwargs["test_queue"], testpmd=testpmd
-                    )
+    """
 
-                elif verification_method == self._send_packet_and_verify_modification:
-                    verification_method(packet=packet, expected_packet=expected_packet)
+    def set_up_suite(self) -> None:
+        """Initialize the test generator and result tracking."""
+        self.generator = FlowTestGenerator(LAYERS, ACTIONS)
+        self.test_suite_results: list[FlowTestResult] = []
+        self.test_case_results: list[FlowTestResult] = []
 
-                testpmd.flow_delete(flow_id, port_id=port_id)
+    def _run_confidence_check(self, action_type: str) -> None:
+        """Verify that non-matching packets are unaffected by flow rules.
 
-    def _send_packet_and_verify(self, packet: Packet, should_receive: bool = True) -> None:
-        """Generate a packet, send to the DUT, and verify it is forwarded back.
+        Creates a flow rule for the specified action, then sends a packet that
+        should NOT match the rule to confirm:
+        - For 'drop': non-matching packets ARE received (not dropped)
+        - For 'queue': non-matching packets are NOT steered to the target queue
+        - For 'modify': non-matching packets arrive unmodified
+
+        This ensures flow rules only affect matching traffic before
+        running the actual action tests.
 
         Args:
-            packet: Scapy packet to send and verify.
-            should_receive: Indicate whether the packet should be received.
+            action_type: The action being tested ('drop', 'queue', 'modify').
         """
-        received = send_packet_and_capture(packet)
-        contains_packet = any(
-            packet.haslayer(Raw) and b"xxxxx" in packet.load for packet in received
-        )
-        verify(
-            should_receive == contains_packet,
-            f"Packet was {'dropped' if should_receive else 'received'}",
+        non_matching_packet = (
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:01")
+            / IP(src="192.168.100.1", dst="192.168.100.2")
+            / UDP(sport=9999, dport=9998)
+            / Raw(load="CONFIDENCE" + "X" * 22)
         )
 
-    def _send_packet_and_verify_queue(
-        self, packet: Packet, test_queue: int, testpmd: TestPmd
-    ) -> None:
-        """Send packet and verify queue stats show packet was received.
+        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
+            if action_type == "drop":
+                drop_rule = FlowRule(
+                    direction="ingress",
+                    pattern=["eth / ipv4 src is 192.168.1.1 / udp dst is 53"],
+                    actions=["drop"],
+                )
+                flow_id = testpmd.flow_create(flow_rule=drop_rule, port_id=0)
 
-        Args:
-            packet: Scapy packet to send to the SUT.
-            test_queue: Represents the queue the test packet is being sent to.
-            testpmd: TestPmd instance being used to send test packet.
-        """
-        testpmd.set_verbose(level=8)
-        testpmd.start()
-        send_packet_and_capture(packet=packet)
+                testpmd.start()
+                received = send_packet_and_capture(non_matching_packet)
+                testpmd.stop()
+                contains_packet = any(
+                    p.haslayer(Raw) and b"CONFIDENCE" in bytes(p[Raw].load) for p in received
+                )
+                testpmd.flow_delete(flow_id, port_id=0)
+                verify(
+                    contains_packet,
+                    "Confidence check failed: non-matching packet dropped by drop rule",
+                )
+
+            elif action_type == "queue":
+                queue_rule = FlowRule(
+                    direction="ingress",
+                    pattern=[
+                        "eth src is aa:bb:cc:dd:ee:ff / ipv4 src is 10.255.255.254 "
+                        "dst is 10.255.255.253 / udp src is 12345 dst is 54321"
+                    ],
+                    actions=["queue index 3"],
+                )
+                flow_id = testpmd.flow_create(flow_rule=queue_rule, port_id=0)
+
+                testpmd.set_verbose(level=8)
+                testpmd.start()
+                send_packet_and_capture(non_matching_packet)
+                verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+                received_on_target = any(p.queue_id == 3 for p in verbose_output)
+                testpmd.flow_delete(flow_id, port_id=0)
+                verify(
+                    not received_on_target,
+                    "Confidence check failed: non-matching packet steered to queue 3",
+                )
+
+        log(f"Confidence check passed for '{action_type}' action")
+
+    def _verify_queue(self, packet: Packet, queue_id: int, testpmd: TestPmd, **kwargs: Any) -> None:
+        """Verify packet is received on the expected queue."""
+        send_packet_and_capture(packet)
         verbose_output = testpmd.extract_verbose_output(testpmd.stop())
-        received = False
-        for testpmd_packet in verbose_output:
-            if testpmd_packet.queue_id == test_queue:
-                received = True
-        verify(received, f"Expected packet was not received on queue {test_queue}")
+        received_on_queue = any(p.queue_id == queue_id for p in verbose_output)
+        verify(received_on_queue, f"Packet not received on queue {queue_id}")
 
-    def _send_packet_and_verify_modification(self, packet: Packet, expected_packet: Packet) -> None:
-        """Send packet and verify the expected modifications are present upon reception.
-
-        Args:
-            packet: Scapy packet to send to the SUT.
-            expected_packet: Scapy packet that should match the received packet.
-        """
+    def _verify_drop(self, packet: Packet, **kwargs: Any) -> None:
+        """Verify packet is dropped."""
         received = send_packet_and_capture(packet)
+        contains_packet = any(p.haslayer(Raw) and b"XXXXX" in p.load for p in received)
+        verify(not contains_packet, "Packet was not dropped")
 
-        # verify reception
-        verify(received != [], "Packet was never received.")
-
-        log(f"SENT PACKET:     {packet.summary()}")
-        log(f"EXPECTED PACKET: {expected_packet.summary()}")
-        for packet in received:
-            log(f"RECEIVED PACKET: {packet.summary()}")
+    def _verify_modify(
+        self, packet: Packet, expected_packet: Packet, testpmd: TestPmd, **kwargs: Any
+    ) -> None:
+        """Verify packet modifications."""
+        testpmd.start()
+        received = send_packet_and_capture(packet)
+        testpmd.stop()
 
-        expected_ip_dst = expected_packet[IP].dst if IP in expected_packet else None
-        received_ip_dst = received[IP].dst if IP in received else None
+        verify(
+            any(p.haslayer(Raw) and b"XXXXX" in p.load for p in received),
+            "Test packet with payload marker not found",
+        )
 
-        expected_mac_dst = expected_packet[Ether].dst if Ether in expected_packet else None
-        received_mac_dst = received[Ether].dst if Ether in received else None
+        test_packet = None
+        for pkt in received:
+            if pkt.haslayer(Raw) and b"XXXXX" in pkt.load:
+                test_packet = pkt
+                break
 
-        # verify modification
-        if expected_ip_dst is not None:
+        if IP in expected_packet and test_packet is not None:
             verify(
-                received_ip_dst == expected_ip_dst,
-                f"IPv4 dst mismatch: expected {expected_ip_dst}, got {received_ip_dst}",
+                test_packet[IP].dst == expected_packet[IP].dst,
+                f"IPv4 dst mismatch: expected {expected_packet[IP].dst}, got {test_packet[IP].dst}",
             )
 
-        if expected_mac_dst is not None:
+        if Ether in expected_packet and test_packet is not None:
             verify(
-                received_mac_dst == expected_mac_dst,
-                f"MAC dst mismatch: expected {expected_mac_dst}, got {received_mac_dst}",
+                test_packet[Ether].dst == expected_packet[Ether].dst,
+                f"MAC dst mismatch: expected {expected_packet[Ether].dst}, "
+                f"got {test_packet[Ether].dst}",
             )
 
-    def _send_packet_and_verify_jump(
+    def _run_tests(
         self,
-        packets: list[Packet],
-        flow_rules: list[FlowRule],
-        test_queues: list[int],
-        testpmd: TestPmd,
+        test_cases: list[FlowTestCase],
+        port_id: int = 0,
     ) -> None:
-        """Create a testpmd session with every rule in the given list, verify jump behavior.
-
-        Args:
-            packets: List of packets to send.
-            flow_rules: List of flow rules to create in the same session.
-            test_queues: List of Rx queue IDs each packet should be received on.
-            testpmd: TestPmd instance to create flows on.
-        """
-        testpmd.set_verbose(level=8)
-        for flow in flow_rules:
-            is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
-            verify_else_skip(is_valid, "flow rule failed validation.")
+        """Execute a sequence of test cases."""
+        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
+            for test_case in test_cases:
+                log(f"Testing: {test_case.description}")
 
-            try:
-                testpmd.flow_create(flow_rule=flow, port_id=0)
-            except InteractiveCommandExecutionError:
-                log("Flow validation passed, but flow creation failed.")
-                fail("Failed flow creation")
+                result = FlowTestResult(
+                    description=test_case.description,
+                    passed=False,
+                    flow_rule_pattern=" / ".join(test_case.flow_rule.pattern),
+                    sent_packet=test_case.packet,
+                )
 
-        for packet, test_queue in zip(packets, test_queues):
-            testpmd.start()
-            send_packet_and_capture(packet=packet)
-            verbose_output = testpmd.extract_verbose_output(testpmd.stop())
-            received = False
-            for testpmd_packet in verbose_output:
-                if testpmd_packet.queue_id == test_queue:
-                    received = True
-            verify(received, f"Expected packet was not received on queue {test_queue}")
+                try:
+                    is_valid = testpmd.flow_validate(flow_rule=test_case.flow_rule, port_id=port_id)
+                    if not is_valid:
+                        result.skipped = True
+                        result.failure_reason = "Flow rule failed validation"
+                        self.test_suite_results.append(result)
+                        self.test_case_results.append(result)
+
+                    try:
+                        flow_id = testpmd.flow_create(
+                            flow_rule=test_case.flow_rule, port_id=port_id
+                        )
+                    except InteractiveCommandExecutionError:
+                        result.failure_reason = "Hardware validated but failed to create flow rule"
+                        self.test_suite_results.append(result)
+                        self.test_case_results.append(result)
+                        continue
+
+                    verification_method = getattr(self, f"_verify_{test_case.verification_type}")
+
+                    if test_case.verification_type == "queue":
+                        testpmd.set_verbose(level=8)
+                        testpmd.start()
+                        verification_method(
+                            packet=test_case.packet,
+                            testpmd=testpmd,
+                            **test_case.verification_params,
+                        )
+                    elif test_case.verification_type == "modify":
+                        verification_method(
+                            packet=test_case.packet,
+                            expected_packet=test_case.expected_packet,
+                            testpmd=testpmd,
+                            **test_case.verification_params,
+                        )
+                    else:
+                        verification_method(
+                            packet=test_case.packet,
+                            testpmd=testpmd,
+                            **test_case.verification_params,
+                        )
+
+                    testpmd.flow_delete(flow_id, port_id=port_id)
+                    result.passed = True
+                    self.test_suite_results.append(result)
+                    self.test_case_results.append(result)
+
+                except SkippedTestException as e:
+                    result.skipped = True
+                    result.failure_reason = f"Skipped: {str(e)}"
+                    self.test_suite_results.append(result)
+                    self.test_case_results.append(result)
+
+    def _log_test_suite_summary(self) -> None:
+        """Log a summary of all test results."""
+        if not self.test_suite_results:
+            return
+
+        passed_tests = [r for r in self.test_suite_results if r.passed]
+        skipped_tests = [r for r in self.test_suite_results if r.skipped]
+        failed_tests = [r for r in self.test_suite_results if not r.passed and not r.skipped]
+
+        log(f"Total tests run: {len(self.test_suite_results)}")
+        log(f"Passed: {len(passed_tests)}")
+        log(f"Skipped: {len(skipped_tests)}")
+        log(f"Failed: {len(failed_tests)}")
+
+        if passed_tests:
+            log("\nPASSED TESTS:")
+            for result in passed_tests:
+                log(f"  {result.description}")
+                log(f"    Sent Packet: {result.sent_packet}")
+
+        if skipped_tests:
+            log("\nSKIPPED TESTS:")
+            for result in skipped_tests:
+                log(f"  {result.description}")
+                log(f"    Pattern: {result.flow_rule_pattern}")
+                log(f"    Reason: {result.failure_reason}")
+                log(f"    Sent Packet: {result.sent_packet}")
+
+        if failed_tests:
+            log("\nFAILED TESTS:")
+            for result in failed_tests:
+                log(f"  {result.description}")
+                log(f"    Pattern: {result.flow_rule_pattern}")
+                log(f"    Reason: {result.failure_reason}")
+                log(f"    Sent Packet: {result.sent_packet}")
+
+    def _log_test_case_failures(self) -> None:
+        """Log each pattern that failed for a given test case."""
+        failures = [r for r in self.test_case_results if not r.passed and not r.skipped]
+
+        if failures:
+            patterns = "\n".join(f"\t  - {r.flow_rule_pattern}" for r in failures)
+
+            self.test_case_results = []
+
+            fail(
+                "Flow rule passed validation but failed creation.\n"
+                "\tFailing flow rule patterns:\n"
+                f"{patterns}"
+            )
 
     @func_test
-    def queue_action_ETH(self) -> None:
-        """Validate flow rules with queue actions and ethernet patterns.
+    def queue_action(self) -> None:
+        """Validate flow rules with queue actions and multi-layer patterns.
 
         Steps:
+            * Run confidence check to verify baseline packet reception.
             * Create a list of packets to test, with a corresponding flow list.
             * Launch testpmd.
             * Create first flow rule in flow list.
@@ -236,39 +670,22 @@ def queue_action_ETH(self) -> None:
         Verify:
             * Each packet is received on the appropriate queue.
         """
-        packet_list = [
-            Ether(src="02:00:00:00:00:00"),
-            Ether(dst="02:00:00:00:00:00"),
-            Ether(type=0x0800) / IP(),
-        ]
-        flow_list = [
-            FlowRule(
-                direction="ingress",
-                pattern=["eth src is 02:00:00:00:00:00"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth dst is 02:00:00:00:00:00"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress", pattern=["eth type is 0x0800"], actions=["queue index 2"]
-            ),
-        ]
-        self._runner(
-            verification_method=self._send_packet_and_verify_queue,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=0,
-            test_queue=2,
-        )
+        self._run_confidence_check("queue")
+        for stack in LAYER_STACKS:
+            test_cases = self.generator.generate(
+                layer_names=stack,
+                action_name="queue",
+                action_value=2,
+            )
+            self._run_tests(test_cases)
+        self._log_test_case_failures()
 
     @func_test
-    def queue_action_IP(self) -> None:
-        """Validate flow rules with queue actions and IPv4/IPv6 patterns.
+    def drop_action(self) -> None:
+        """Validate flow rules with drop actions and multi-layer patterns.
 
         Steps:
+            * Run confidence check to verify packets are received without drop rules.
             * Create a list of packets to test, with a corresponding flow list.
             * Launch testpmd.
             * Create first flow rule in flow list.
@@ -276,522 +693,198 @@ def queue_action_IP(self) -> None:
             * Delete flow rule, repeat for all flows/packets.
 
         Verify:
-            * Each packet is received on the appropriate queue.
+            * Packet is dropped.
         """
-        packet_list = [
-            Ether() / IP(src="192.168.1.1"),
-            Ether() / IP(dst="192.168.1.1"),
-            Ether() / IP(ttl=64),
-            Ether() / IPv6(src="2001:db8::1"),
-            Ether() / IPv6(dst="2001:db8::2"),
-            Ether() / IPv6() / UDP(),
-        ]
-        flow_list = [
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 src is 192.168.1.1"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 dst is 192.168.1.1"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv4 ttl is 64"], actions=["queue index 2"]
-            ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv6 src is 2001:db8::1"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv6 dst is 2001:db8::2"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv6 proto is 17"], actions=["queue index 2"]
-            ),
-        ]
-        self._runner(
-            verification_method=self._send_packet_and_verify_queue,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=0,
-            test_queue=2,
-        )
+        self._run_confidence_check("drop")
+        for stack in LAYER_STACKS:
+            test_cases = self.generator.generate(
+                layer_names=stack,
+                action_name="drop",
+            )
+            self._run_tests(test_cases)
+        self._log_test_case_failures()
 
-    @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
     @func_test
-    def queue_action_L4(self) -> None:
-        """Validate flow rules with queue actions and TCP/UDP patterns.
+    def modify_field_action(self) -> None:
+        """Validate flow rules with modify_field actions and various patterns.
 
         Steps:
+            * Run confidence check to verify packets arrive unmodified.
             * Create a list of packets to test, with a corresponding flow list.
             * Launch testpmd.
             * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
+            * Send first packet in packet list, capture received packet.
             * Delete flow rule, repeat for all flows/packets.
 
         Verify:
-            * Each packet is received on the appropriate queue.
+            * Packet is modified correctly according to the action.
         """
-        packet_list = [
-            Ether() / IP() / TCP(sport=1234),
-            Ether() / IP() / TCP(dport=80),
-            Ether() / IP() / TCP(flags=0x02),
-            Ether() / IP() / UDP(sport=5000),
-            Ether() / IP() / UDP(dport=53),
-        ]
-        flow_list = [
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 / tcp src is 1234"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 / tcp dst is 80"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 / tcp flags is 0x02"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 / udp src is 5000"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 / udp dst is 53"],
-                actions=["queue index 2"],
-            ),
-        ]
-        self._runner(
-            verification_method=self._send_packet_and_verify_queue,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=0,
-            test_queue=2,
-        )
-
-    @func_test
-    def queue_action_VLAN(self) -> None:
-        """Validate flow rules with queue actions and VLAN patterns.
-
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+        self._run_confidence_check("modify")
+        for stack in [
+            ["eth", "ipv4"],
+            ["eth", "ipv4", "tcp"],
+            ["eth", "ipv4", "udp"],
+        ]:
+            test_cases = self.generator.generate(
+                layer_names=stack,
+                action_name="modify_ipv4_src_to_dst",
+                group_id=1,
+            )
+            self._run_tests(test_cases)
 
-        Verify:
-            * Each packet is received on the appropriate queue.
-        """
-        packet_list = [Ether() / Dot1Q(vlan=100), Ether() / Dot1Q(type=0x0800)]
-        flow_list = [
-            FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["queue index 2"]),
-            FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["queue index 2"]),
-        ]
-        self._runner(
-            verification_method=self._send_packet_and_verify_queue,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=0,
-            test_queue=2,
-        )
+        for stack in [["eth"], ["eth", "vlan"]]:
+            test_cases = self.generator.generate(
+                layer_names=stack,
+                action_name="modify_mac_src_to_dst",
+                group_id=1,
+            )
+            self._run_tests(test_cases)
+        self._log_test_case_failures()
 
     @func_test
-    def drop_action_ETH(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
-
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+    def jump_action(self) -> None:
+        """Validate flow rules with jump action between groups.
 
-        Verify:
-            * Packet is dropped.
+        The jump action redirects matched packets from one flow group to another.
+        Only flow rules in group 0 are guaranteed to be matched against initially;
+        subsequent groups can only be reached via jump actions.
 
-        One packet will be sent as a confidence check, to ensure packets are being
-        received under normal circumstances.
-        """
-        packet_list = [
-            Ether(src="02:00:00:00:00:00") / Raw(load="xxxxx"),
-            Ether(dst="02:00:00:00:00:00") / Raw(load="xxxxx"),
-            Ether(type=0x0800) / Raw(load="xxxxx"),
-        ]
-        flow_list = [
-            FlowRule(
-                direction="ingress", pattern=["eth src is 02:00:00:00:00:00"], actions=["drop"]
-            ),
-            FlowRule(
-                direction="ingress", pattern=["eth dst is 02:00:00:00:00:00"], actions=["drop"]
-            ),
-            FlowRule(direction="ingress", pattern=["eth type is 0x0800"], actions=["drop"]),
-        ]
-        # verify reception with test packet
-        packet = Ether() / IP() / Raw(load="xxxxx")
-        with TestPmd() as testpmd:
-            testpmd.start()
-            received = send_packet_and_capture(packet)
-            verify(received != [], "Test packet was never received.")
-        self._runner(
-            verification_method=self._send_packet_and_verify,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=0,
-            should_receive=False,
-        )
-
-    @func_test
-    def drop_action_IP(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
+        This test creates a two-stage pipeline:
+        - Group 0: Match on Ethernet src, jump to group 1
+        - Group 1: Match on IPv4 dst, forward to specific queue
 
         Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+            * Launch testpmd with multiple queues.
+            * Create flow rule in group 0 that matches eth src and jumps to group 1.
+            * Create flow rule in group 1 that matches ipv4 dst and queues to queue 2.
+            * Send matching packet and verify it arrives on queue 2.
+            * Send non-matching packet (wrong eth src) and verify it doesn't hit queue 2.
 
         Verify:
-            * Packet is dropped.
-
-        One packet will be sent as a confidence check, to ensure packets are being
-        received under normal circumstances.
+            * Packet matching both rules is received on the target queue.
+            * Packet not matching group 0 rule does not reach target queue.
         """
-        packet_list = [
-            Ether() / IP(src="192.168.1.1") / Raw(load="xxxxx"),
-            Ether() / IP(dst="192.168.1.1") / Raw(load="xxxxx"),
-            Ether() / IP(ttl=64) / Raw(load="xxxxx"),
-            Ether() / IPv6(src="2001:db8::1") / Raw(load="xxxxx"),
-            Ether() / IPv6(dst="2001:db8::1") / Raw(load="xxxxx"),
-            Ether() / IPv6() / UDP() / Raw(load="xxxxx"),
-        ]
-        flow_list = [
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv4 src is 192.168.1.1"], actions=["drop"]
-            ),
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv4 dst is 192.168.1.1"], actions=["drop"]
-            ),
-            FlowRule(direction="ingress", pattern=["eth / ipv4 ttl is 64"], actions=["drop"]),
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv6 src is 2001:db8::1"], actions=["drop"]
-            ),
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv6 dst is 2001:db8::2"], actions=["drop"]
-            ),
-            FlowRule(direction="ingress", pattern=["eth / ipv6 proto is 17"], actions=["drop"]),
-        ]
-        # verify reception with test packet
-        packet = Ether() / IP() / Raw(load="xxxxx")
-        with TestPmd() as testpmd:
-            testpmd.start()
-            received = send_packet_and_capture(packet)
-            verify(received != [], "Test packet was never received.")
-        self._runner(
-            verification_method=self._send_packet_and_verify,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=0,
-            should_receive=False,
+        port_id = 0
+        target_queue = 2
+
+        test_eth_src = "02:00:00:00:00:00"
+        non_matching_eth_src = "02:00:00:00:00:01"
+        test_ipv4_dst = "192.168.1.2"
+        test_ipv4_src = "192.168.1.1"
+        dst_mac = "02:00:00:00:00:02"
+
+        jump_rule = FlowRule(
+            direction="ingress",
+            group_id=0,
+            pattern=[f"eth src is {test_eth_src}"],
+            actions=["jump group 1"],
         )
 
-    @func_test
-    def drop_action_L4(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
-
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
-
-        Verify:
-            * Packet is dropped.
-
-        One packet will be sent as a confidence check, to ensure packets are being
-        received under normal circumstances.
-        """
-        packet_list = [
-            Ether() / IP() / TCP(sport=1234) / Raw(load="xxxxx"),
-            Ether() / IP() / TCP(dport=80) / Raw(load="xxxxx"),
-            Ether() / IP() / TCP(flags=0x02) / Raw(load="xxxxx"),
-            Ether() / IP() / UDP(sport=5000) / Raw(load="xxxxx"),
-            Ether() / IP() / UDP(dport=53) / Raw(load="xxxxx"),
-        ]
-        flow_list = [
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv4 / tcp src is 1234"], actions=["drop"]
-            ),
-            FlowRule(direction="ingress", pattern=["eth / ipv4 / tcp dst is 80"], actions=["drop"]),
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv4 / tcp flags is 0x02"], actions=["drop"]
-            ),
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv4 / udp src is 5000"], actions=["drop"]
-            ),
-            FlowRule(direction="ingress", pattern=["eth / ipv4 / udp dst is 53"], actions=["drop"]),
-        ]
-        # verify reception with test packet
-        packet = Ether() / IP() / Raw(load="xxxxx")
-        with TestPmd() as testpmd:
-            testpmd.start()
-            received = send_packet_and_capture(packet)
-            verify(received != [], "Test packet was never received.")
-        self._runner(
-            verification_method=self._send_packet_and_verify,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=0,
-            should_receive=False,
+        queue_rule = FlowRule(
+            direction="ingress",
+            group_id=1,
+            pattern=[f"ipv4 dst is {test_ipv4_dst}"],
+            actions=[f"queue index {target_queue}"],
         )
 
-    @func_test
-    def drop_action_VLAN(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
-
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
-
-        Verify:
-            * Packet is dropped.
-
-        One packet will be sent as a confidence check, to ensure packets are being
-        received under normal circumstances.
-        """
-        packet_list = [
-            Ether() / Dot1Q(vlan=100) / Raw(load="xxxxx"),
-            Ether() / Dot1Q(type=0x0800) / Raw(load="xxxxx"),
-        ]
-        flow_list = [
-            FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["drop"]),
-            FlowRule(direction="ingress", pattern=["eth / vlan"], actions=["drop"]),
-        ]
-        # verify reception with test packet
-        packet = Ether() / IP() / Raw(load="xxxxx")
-        with TestPmd() as testpmd:
-            testpmd.start()
-            received = send_packet_and_capture(packet)
-            verify(received != [], "Test packet was never received.")
-        self._runner(
-            verification_method=self._send_packet_and_verify,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=0,
-            should_receive=False,
+        matching_packet = (
+            Ether(src=test_eth_src, dst=dst_mac)
+            / IP(src=test_ipv4_src, dst=test_ipv4_dst)
+            / UDP(sport=5000, dport=53)
+            / Raw(load="X" * 32)
         )
 
-    @func_test
-    def modify_actions(self) -> None:
-        """Validate flow rules with actions that modify that packet during transmission.
+        non_matching_packet = (
+            Ether(src=non_matching_eth_src, dst=dst_mac)
+            / IP(src=test_ipv4_src, dst=test_ipv4_dst)
+            / UDP(sport=5000, dport=53)
+            / Raw(load="X" * 32)
+        )
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+        jump_result = FlowTestResult(
+            description="eth src -> jump group 1",
+            passed=False,
+            flow_rule_pattern=" / ".join(jump_rule.pattern),
+        )
 
-        Verify:
-            * Verify packet is received with the new attributes.
-        """
-        packet_list = [Ether() / IP(src="192.68.1.1"), Ether(src="02:00:00:00:00:00")]
-        flow_list = [
-            # rule to copy IPv4 src to IPv4 dst
-            FlowRule(
-                direction="ingress",
-                group_id=1,
-                pattern=["eth"],
-                actions=[
-                    "modify_field op set dst_type ipv4_dst src_type ipv4_src width 32"
-                    " / queue index 0"
-                ],
-            ),
-            # rule to copy src MAC to dst MAC
-            FlowRule(
-                direction="ingress",
-                group_id=1,
-                pattern=["eth"],
-                actions=[
-                    "modify_field op set dst_type mac_dst src_type mac_src width 48 / queue index 0"
-                ],
-            ),
-        ]
-        expected_packet_list = [Ether() / IP(dst="192.68.1.1"), Ether(dst="02:00:00:00:00:00")]
-        self._runner(
-            verification_method=self._send_packet_and_verify_modification,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=0,
-            expected_packets=expected_packet_list,
+        queue_result = FlowTestResult(
+            description="ipv4 dst -> queue (group 1)",
+            passed=False,
+            flow_rule_pattern=" / ".join(queue_rule.pattern),
         )
 
-    @func_test
-    def egress_rules(self) -> None:
-        """Validate flow rules with egress directions.
+        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
+            is_valid = testpmd.flow_validate(flow_rule=jump_rule, port_id=port_id)
+            if not is_valid:
+                jump_result.skipped = True
+                jump_result.failure_reason = "Flow rule failed validation"
+                self.test_suite_results.append(jump_result)
+                self.test_case_results.append(jump_result)
+                self._log_test_case_failures()
+                return
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+            try:
+                jump_flow_id = testpmd.flow_create(flow_rule=jump_rule, port_id=port_id)
+            except InteractiveCommandExecutionError:
+                jump_result.failure_reason = "Hardware validated but failed to create flow rule"
+                self.test_suite_results.append(jump_result)
+                self.test_case_results.append(jump_result)
+                self._log_test_case_failures()
+                return
+
+            jump_result.passed = True
+            self.test_suite_results.append(jump_result)
+            self.test_case_results.append(jump_result)
+
+            is_valid = testpmd.flow_validate(flow_rule=queue_rule, port_id=port_id)
+            if not is_valid:
+                queue_result.skipped = True
+                queue_result.failure_reason = "Flow rule failed validation"
+                self.test_suite_results.append(queue_result)
+                self.test_case_results.append(queue_result)
+                testpmd.flow_delete(jump_flow_id, port_id=port_id)
+                self._log_test_case_failures()
+                return
 
-        Verify:
-            * Packet is dropped.
+            try:
+                queue_flow_id = testpmd.flow_create(flow_rule=queue_rule, port_id=port_id)
+            except InteractiveCommandExecutionError:
+                queue_result.failure_reason = "Hardware validated but failed to create flow rule"
+                self.test_suite_results.append(queue_result)
+                self.test_case_results.append(queue_result)
+                testpmd.flow_delete(jump_flow_id, port_id=port_id)
+                self._log_test_case_failures()
+                return
 
-        One packet will be sent as a confidence check, to ensure packets are being
-        received under normal circumstances.
-        """
-        packet_list = [
-            Ether(src="02:00:00:00:00:00"),
-            Ether() / IP(src="192.168.1.1"),
-            IP() / TCP(sport=1234),
-            IP() / UDP(sport=5000),
-        ]
-        flow_list = [
-            FlowRule(
-                direction="egress", pattern=["eth src is 02:00:00:00:00:00"], actions=["drop"]
-            ),
-            FlowRule(direction="egress", pattern=["ipv4 src is 192.168.1.1"], actions=["drop"]),
-            FlowRule(direction="egress", pattern=["tcp src is 1234"], actions=["drop"]),
-            FlowRule(direction="egress", pattern=["udp src is 5000"], actions=["drop"]),
-        ]
-        # verify reception with test packet
-        packet = Ether() / IP() / Raw(load="xxxxx")
-        with TestPmd() as testpmd:
-            testpmd.start()
-            received = send_packet_and_capture(packet)
-            verify(received != [], "Test packet was never received.")
-        self._runner(
-            verification_method=self._send_packet_and_verify,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=1,
-            should_receive=False,
-        )
+            queue_result.passed = True
+            self.test_suite_results.append(queue_result)
+            self.test_case_results.append(queue_result)
 
-    @func_test
-    def jump_action(self) -> None:
-        """Validate flow rules with different group levels and jump actions.
+            testpmd.set_verbose(level=8)
+            testpmd.start()
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd with the necessary configuration.
-            * Create each flow rule in testpmd.
-            * Send each packet in the list, check Rx queue ID.
+            send_packet_and_capture(matching_packet)
+            verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+            received = any(p.queue_id == target_queue for p in verbose_output)
+            verify(
+                received,
+                f"Matching packet not received on queue {target_queue} after jump",
+            )
 
-        Verify:
-            * Check that each packet is received on the appropriate Rx queue.
-        """
-        packet_list = [Ether() / IP(), Ether() / IP() / TCP(), Ether() / IP() / UDP()]
-        flow_list = [
-            FlowRule(
-                direction="ingress",
-                group_id=0,
-                pattern=["eth / ipv4 / tcp"],
-                actions=["jump group 1"],
-            ),
-            FlowRule(
-                direction="ingress",
-                group_id=0,
-                pattern=["eth / ipv4 / udp"],
-                actions=["jump group 2"],
-            ),
-            FlowRule(
-                direction="ingress",
-                group_id=1,
-                pattern=["eth / ipv4 / tcp"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress",
-                group_id=2,
-                pattern=["eth / ipv4 / udp"],
-                actions=["queue index 3"],
-            ),
-            FlowRule(
-                direction="ingress",
-                group_id=0,
-                pattern=["eth / ipv4"],
-                actions=["queue index 1"],
-            ),
-        ]
-        expected_queue_list = [1, 2, 3]
-        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
-            self._send_packet_and_verify_jump(
-                packets=packet_list,
-                flow_rules=flow_list,
-                test_queues=expected_queue_list,
-                testpmd=testpmd,
+            testpmd.start()
+            send_packet_and_capture(non_matching_packet)
+            verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+            received = any(p.queue_id == target_queue for p in verbose_output)
+            verify(
+                not received,
+                f"Non-matching packet incorrectly received on queue {target_queue}",
             )
 
-    @func_test
-    def priority_attribute(self) -> None:
-        """Validate flow rules with queue actions and ethernet patterns.
+            testpmd.flow_delete(queue_flow_id, port_id=port_id)
+            testpmd.flow_delete(jump_flow_id, port_id=port_id)
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+        self._log_test_case_failures()
 
-        Verify:
-            * Each packet is received on the appropriate queue.
-        """
-        test_packet = Ether() / IP() / Raw()
-        flow_list = [
-            FlowRule(
-                direction="ingress",
-                priority_level=3,
-                pattern=["eth / ipv4"],
-                actions=["queue index 1"],
-            ),
-            FlowRule(
-                direction="ingress",
-                priority_level=2,
-                pattern=["eth / ipv4"],
-                actions=["queue index 2"],
-            ),
-            FlowRule(
-                direction="ingress",
-                priority_level=1,
-                pattern=["eth / ipv4"],
-                actions=["queue index 3"],
-            ),
-        ]
-        expected_queue_list = [1, 2, 3]
-        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
-            testpmd.set_verbose(level=8)
-            for flow, expected_queue in zip(flow_list, expected_queue_list):
-                is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
-                verify_else_skip(is_valid, "flow rule failed validation.")
-                try:
-                    testpmd.flow_create(flow_rule=flow, port_id=0)
-                except InteractiveCommandExecutionError:
-                    log("Flow rule validation passed, but flow creation failed.")
-                    fail("Failed flow creation")
-                testpmd.start()
-                send_packet_and_capture(test_packet)
-                verbose_output = testpmd.extract_verbose_output(testpmd.stop())
-                received = False
-                for testpmd_packet in verbose_output:
-                    if testpmd_packet.queue_id == expected_queue:
-                        received = True
-                verify(received, f"Packet was not received on queue {expected_queue}")
+    def tear_down_suite(self) -> None:
+        """Log test summary at the end of the suite."""
+        self._log_test_suite_summary()
-- 
2.52.0

