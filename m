Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73B5FCC056
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 18:37:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA7834066B;
	Fri,  6 Mar 2026 19:37:13 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 3E56A402E3
 for <dev@dpdk.org>; Fri,  6 Mar 2026 19:37:12 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-89a14be4733so53928246d6.2
 for <dev@dpdk.org>; Fri, 06 Mar 2026 10:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772822231; x=1773427031; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hn14OdhkNOb9yRP9w2jmI7rkMCWAfqT2hhSXjdvfYYc=;
 b=PMBUtTJM0i2w8RUKto2pw1gcJ82j2caBQIRDJq+o45HRWW8B4CTk18Ec1eLE7l60gh
 Sf06me3AYFRHD7KBVzxYG06FzwN6O0v9CPbeIrWw7uCo56c7f9U8nvIxKDQmj6JvZUHc
 WRWxlfbD60HG37MWKKIDx/98tMdLECOB85UrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772822231; x=1773427031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hn14OdhkNOb9yRP9w2jmI7rkMCWAfqT2hhSXjdvfYYc=;
 b=Rotvt9ce8Dn51zvJ7aOnLhcWMg7AcqRQh5RSsegNykQg+mQriks9tGMBbpi7gcZIYN
 8c05bqGM3jb/sQxXLEG+Rd/Rg4NuZS9KwGjByiIKPPpA7ts8O2G4WVDlpLgZBZ34pR59
 YvDouF3za6HtCZIr5+npXFeKu5SPqMU2AIBbxKQiH0U/qCGsVdhtDieOrn82RMQINYGN
 g51a5+Dezelpg8DDB3aMtE9gNLqyTIpUkrdps1wzjKY1jaF50ca6sNdlpRRMiC24o+jg
 pZbqj087hQu8rN2SAnW0TKk/gEwFSvjkvaPZXoaD7tJ3VZHob2Je3aSNNKkB77NSyIAb
 +e1g==
X-Gm-Message-State: AOJu0Yy0UTdl8O+hzy9cfqQCYWDBEk/bPLG+reTIMPeOuZwf38mfZkNY
 1RcDa/PTvEJeCVlbneSWKxoSMKNDuT2dTBha2eJIlkVwiaAmGmBpvXhjbFZLiuUBOBo=
X-Gm-Gg: ATEYQzwfegNCTqfgIk0osCyRgtG3mQ8eH3Ix5rG/GqU92556fZSnkkdFGDlfOm2dDf+
 Pi0YrC1iuvi5p/8Uzrv02QoMjhUyrlIygYa8i63kQJrYHeCnsFok3d3bOg4jXoNxZjJ+/TOkGBI
 al7zIH+2IzaI9EUNavvX4WeUelGIE1c6bg/SEeBkkV/hWuMLAmE1XyEIGjjRbLS5+EPjuDVQXJR
 kHWywhRjbd0VAQG9QqtTbJlqmD+Ce+ZWUrgJcqs5V32sLTAnqO4XdRleuvCIHfvU32SCu+yYy5t
 ymEw/vkQ+3zoywEj1sZZ/C2M2Z6EzIlZS6TIrOZnf/Ibxmx3yI8c3MR7c9Pu89ni6sRLbAfc8Dk
 FprA69fm/Cxb7o4yZa7ZZit9DG5PVscdRruGXP0zmszCN8wDe+15FRvRSQyT0fUwJOIL2cFlV09
 XKLT0/bwmNny5YdUdVCW1E8VDGpxX0nsPwWdsAGfhNlWVI6lgLUxr36p992bTmJDw=
X-Received: by 2002:ad4:5dca:0:b0:89a:171f:63df with SMTP id
 6a1803df08f44-89a30a2a099mr45952666d6.10.1772822230752; 
 Fri, 06 Mar 2026 10:37:10 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a3145e97fsm16416466d6.20.2026.03.06.10.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:37:10 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6] dts: refactor flow suite with generator pattern
Date: Fri,  6 Mar 2026 13:37:08 -0500
Message-ID: <20260306183708.28803-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305181818.23058-1-dmarx@iol.unh.edu>
References: <20260305181818.23058-1-dmarx@iol.unh.edu>
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
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/tests/TestSuite_rte_flow.py | 1856 ++++++++++++++++++++-----------
 1 file changed, 1186 insertions(+), 670 deletions(-)

diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 207cbce2d3..eef804e9d2 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -10,597 +10,1069 @@
 
 """
 
-from collections.abc import Callable
-from itertools import zip_longest
-from typing import Any, Iterator, cast
+from dataclasses import dataclass, field
+from itertools import product
+from typing import Any, Callable, Optional
 
-from scapy.layers.inet import IP, TCP, UDP
+from scapy.layers.inet import ICMP, IP, TCP, UDP
 from scapy.layers.inet6 import IPv6
-from scapy.layers.l2 import Dot1Q, Ether
+from scapy.layers.l2 import ARP, Dot1Q, Ether
+from scapy.layers.sctp import SCTP
+from scapy.layers.vxlan import VXLAN
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
+from framework.exception import (
+    InteractiveCommandExecutionError,
+    SkippedTestException,
+    TestCaseVerifyError,
+)
 from framework.test_suite import TestSuite, func_test
 
 
-@requires_nic_capability(NicCapability.FLOW_CTRL)
-class TestRteFlow(TestSuite):
-    """RTE Flow test suite.
+@dataclass
+class PatternField:
+    """Specification for a single matchable field within a protocol layer."""
 
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
+    scapy_field: str
+    pattern_field: str
+    test_parameters: list[Any]
 
-    """
 
-    def _runner(
-        self,
-        verification_method: Callable[..., Any],
-        flows: list[FlowRule],
-        packets: list[Packet],
-        port_id: int,
-        expected_packets: list[Packet] | None = None,
-        *args: Any,
-        **kwargs: Any,
-    ) -> None:
-        """Runner method that validates each flow using the corresponding verification method.
+@dataclass
+class Protocol:
+    """Complete specification for a protocol layer."""
 
-        Args:
-            verification_method: Callable that performs verification logic.
-            flows: List of flow rules to create and test.
-            packets: List of packets corresponding to each flow.
-            port_id: Number representing the port to create flows on.
-            expected_packets: List of packets to check sent packets against in modification cases.
-            *args: Additional positional arguments to pass to the verification method.
-            **kwargs: Additional keyword arguments to pass to the verification method.
-        """
-
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
-
-        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
-            for flow, packet, expected_packet in zip_lists(flows, packets, expected_packets):
-                is_valid = testpmd.flow_validate(flow_rule=flow, port_id=port_id)
-                verify_else_skip(is_valid, "flow rule failed validation.")
-
-                try:
-                    flow_id = testpmd.flow_create(flow_rule=flow, port_id=port_id)
-                except InteractiveCommandExecutionError:
-                    log("Flow rule validation passed, but flow creation failed.")
-                    fail("Failed flow creation")
+    name: str
+    scapy_class: type[Packet]
+    pattern_name: str
+    fields: list[PatternField]
+    default_values: dict[str, Any] = field(default_factory=dict)
 
-                if verification_method == self._send_packet_and_verify:
-                    verification_method(packet=packet, *args, **kwargs)
+    def build_scapy_layer(self, field_values: dict[str, Any]) -> Packet:
+        """Construct a Scapy layer with the given field values.
 
-                elif verification_method == self._send_packet_and_verify_queue:
-                    verification_method(
-                        packet=packet, test_queue=kwargs["test_queue"], testpmd=testpmd
-                    )
+        Default values are applied first, then overridden by any
+        explicit field values so test parameters always win.
+        """
+        merged = {**self.default_values, **field_values}
+        return self.scapy_class(**merged)
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
+
+@dataclass
+class FlowTest:
+    """A complete flow test ready for execution."""
+
+    flow_rule: FlowRule
+    packet: Packet
+    verification_type: str
+    verification_params: dict[str, Any]
+    description: str = ""
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
+    sent_packet: Optional["Packet"] = None
+
+
+@dataclass
+class ModifyTest:
+    """A single hardcoded modify action test case."""
+
+    description: str
+    pattern: str
+    action: str
+    packet: Packet
+    expected_ipv4_dst: str | None = None
+    expected_mac_dst: str | None = None
+
+
+@dataclass
+class JumpTest:
+    """A single hardcoded jump action test case."""
+
+    description: str
+    group0_pattern: str
+    group1_pattern: str
+    group1_action: str
+    matching_packet: Packet
+    non_matching_packet: Packet
+    target_queue: int
+
+
+PROTOCOLS: dict[str, Protocol] = {
+    # -------------------- Base Protocols --------------------
+    "eth": Protocol(
+        name="eth",
+        scapy_class=Ether,
+        pattern_name="eth",
+        fields=[
+            PatternField("src", "src", ["02:00:00:00:00:00"]),
+            PatternField("dst", "dst", ["02:00:00:00:00:02"]),
+        ],
+    ),
+    "ipv4": Protocol(
+        name="ipv4",
+        scapy_class=IP,
+        pattern_name="ipv4",
+        fields=[
+            PatternField("src", "src", ["192.168.1.1"]),
+            PatternField("dst", "dst", ["192.168.1.2"]),
+            PatternField("ttl", "ttl", [64, 128]),
+            PatternField("tos", "tos", [0, 4]),
+        ],
+    ),
+    "ipv6": Protocol(
+        name="ipv6",
+        scapy_class=IPv6,
+        pattern_name="ipv6",
+        fields=[
+            PatternField("src", "src", ["2001:db8::1"]),
+            PatternField("dst", "dst", ["2001:db8::2"]),
+            PatternField("tc", "tc", [0, 4]),
+            PatternField("hlim", "hop", [64, 128]),
+        ],
+    ),
+    "tcp": Protocol(
+        name="tcp",
+        scapy_class=TCP,
+        pattern_name="tcp",
+        fields=[
+            PatternField("sport", "src", [1234, 8080]),
+            PatternField("dport", "dst", [80, 443]),
+            PatternField("flags", "flags", [2, 16]),
+        ],
+    ),
+    "udp": Protocol(
+        name="udp",
+        scapy_class=UDP,
+        pattern_name="udp",
+        fields=[
+            PatternField("sport", "src", [5000]),
+            PatternField("dport", "dst", [53, 123]),
+        ],
+    ),
+    "vlan": Protocol(
+        name="vlan",
+        scapy_class=Dot1Q,
+        pattern_name="vlan",
+        fields=[
+            PatternField("vlan", "vid", [100, 200]),
+            PatternField("prio", "pcp", [0, 7]),
+        ],
+    ),
+    "icmp": Protocol(
+        name="icmp",
+        scapy_class=ICMP,
+        pattern_name="icmp",
+        fields=[
+            PatternField("type", "type", [8, 0]),
+            PatternField("code", "code", [0]),
+            PatternField("id", "ident", [0, 1234]),
+            PatternField("seq", "seq", [0, 1]),
+        ],
+    ),
+    "sctp": Protocol(
+        name="sctp",
+        scapy_class=SCTP,
+        pattern_name="sctp",
+        fields=[
+            PatternField("sport", "src", [2905, 3868]),
+            PatternField("dport", "dst", [2905, 3868]),
+            PatternField("tag", "tag", [1, 12346]),
+        ],
+    ),
+    "arp": Protocol(
+        name="arp",
+        scapy_class=ARP,
+        pattern_name="arp_eth_ipv4",
+        fields=[
+            PatternField("psrc", "spa", ["192.168.1.1"]),
+            PatternField("pdst", "tpa", ["192.168.1.2"]),
+            PatternField("op", "opcode", [1, 2]),
+        ],
+    ),
+    # -------------------- VXLAN Outer Protocols --------------------
+    "eth_outer": Protocol(
+        name="eth_outer",
+        scapy_class=Ether,
+        pattern_name="eth",
+        fields=[
+            PatternField("src", "src", ["02:00:00:00:00:00"]),
+            PatternField("dst", "dst", ["02:00:00:00:00:02"]),
+        ],
+    ),
+    "ipv4_outer": Protocol(
+        name="ipv4_outer",
+        scapy_class=IP,
+        pattern_name="ipv4",
+        fields=[
+            PatternField("src", "src", ["10.0.0.1"]),
+            PatternField("dst", "dst", ["10.0.0.2"]),
+            PatternField("ttl", "ttl", [64, 128]),
+            PatternField("tos", "tos", [0, 4]),
+        ],
+    ),
+    "udp_outer": Protocol(
+        name="udp_outer",
+        scapy_class=UDP,
+        pattern_name="udp",
+        fields=[],
+        default_values={"dport": 4789},
+    ),
+    # -------------------- VXLAN Tunnel Header --------------------
+    "vxlan": Protocol(
+        name="vxlan",
+        scapy_class=VXLAN,
+        pattern_name="vxlan",
+        fields=[
+            PatternField("vni", "vni", [42, 100]),
+        ],
+    ),
+    # -------------------- VXLAN Inner Protocols --------------------
+    "eth_inner": Protocol(
+        name="eth_inner",
+        scapy_class=Ether,
+        pattern_name="eth",
+        fields=[
+            PatternField("src", "src", ["02:00:00:00:00:00"]),
+            PatternField("dst", "dst", ["02:00:00:00:00:02"]),
+        ],
+    ),
+    "ipv4_inner": Protocol(
+        name="ipv4_inner",
+        scapy_class=IP,
+        pattern_name="ipv4",
+        fields=[
+            PatternField("src", "src", ["192.168.1.1"]),
+            PatternField("dst", "dst", ["192.168.1.2"]),
+        ],
+    ),
+    "ipv6_inner": Protocol(
+        name="ipv6_inner",
+        scapy_class=IPv6,
+        pattern_name="ipv6",
+        fields=[
+            PatternField("src", "src", ["2001:db8::1"]),
+            PatternField("dst", "dst", ["2001:db8::2"]),
+        ],
+    ),
+    "tcp_inner": Protocol(
+        name="tcp_inner",
+        scapy_class=TCP,
+        pattern_name="tcp",
+        fields=[
+            PatternField("sport", "src", [1234]),
+            PatternField("dport", "dst", [80]),
+        ],
+    ),
+    "udp_inner": Protocol(
+        name="udp_inner",
+        scapy_class=UDP,
+        pattern_name="udp",
+        fields=[
+            PatternField("sport", "src", [5000]),
+            PatternField("dport", "dst", [53]),
+        ],
+    ),
+}
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
+        param_builder=lambda _: {},
+    ),
+}
+
+PROTOCOL_STACKS = [
+    # -------------------- Non-tunnel stacks --------------------
+    [("eth", True)],
+    [("eth", False), ("ipv4", True)],
+    [("eth", False), ("ipv4", True), ("tcp", True)],
+    [("eth", False), ("ipv4", True), ("udp", True)],
+    [("eth", False), ("ipv4", True), ("icmp", True)],
+    [("eth", False), ("ipv4", True), ("sctp", True)],
+    [("eth", False), ("ipv6", True)],
+    [("eth", False), ("ipv6", True), ("tcp", True)],
+    [("eth", False), ("ipv6", True), ("udp", True)],
+    [("eth", False), ("ipv6", True), ("sctp", True)],
+    [("eth", False), ("vlan", True)],
+    [("eth", False), ("vlan", True), ("ipv4", True)],
+    [("eth", False), ("vlan", False), ("ipv4", True), ("tcp", True)],
+    [("eth", False), ("vlan", False), ("ipv4", True), ("udp", True)],
+    [("eth", False), ("vlan", False), ("ipv4", True), ("sctp", True)],
+    [("eth", False), ("vlan", True), ("ipv6", True)],
+    [("eth", False), ("vlan", False), ("ipv6", True), ("tcp", True)],
+    [("eth", False), ("vlan", False), ("ipv6", True), ("udp", True)],
+    [("eth", False), ("arp", True)],
+    # -------------------- VXLAN tunnel stacks --------------------
+    [
+        ("eth_outer", False),
+        ("ipv4_outer", True),
+        ("udp_outer", False),
+        ("vxlan", True),
+        ("eth_inner", False),
+        ("ipv4_inner", False),
+    ],
+    [
+        ("eth_outer", False),
+        ("ipv4_outer", True),
+        ("udp_outer", False),
+        ("vxlan", True),
+        ("eth_inner", False),
+        ("ipv4_inner", False),
+        ("tcp_inner", False),
+    ],
+    [
+        ("eth_outer", False),
+        ("ipv4_outer", True),
+        ("udp_outer", False),
+        ("vxlan", True),
+        ("eth_inner", False),
+        ("ipv4_inner", False),
+        ("udp_inner", False),
+    ],
+    [
+        ("eth_outer", False),
+        ("ipv4_outer", True),
+        ("udp_outer", False),
+        ("vxlan", True),
+        ("eth_inner", False),
+        ("ipv6_inner", False),
+    ],
+    [
+        ("eth_outer", False),
+        ("ipv4_outer", True),
+        ("udp_outer", False),
+        ("vxlan", True),
+        ("eth_inner", False),
+        ("ipv6_inner", False),
+        ("tcp_inner", False),
+    ],
+    [
+        ("eth_outer", False),
+        ("ipv4_outer", True),
+        ("udp_outer", False),
+        ("vxlan", True),
+        ("eth_inner", False),
+        ("ipv6_inner", False),
+        ("udp_inner", False),
+    ],
+    [
+        ("eth_outer", False),
+        ("ipv4_outer", True),
+        ("udp_outer", False),
+        ("vxlan", True),
+        ("eth_inner", False),
+    ],
+]
+
+
+class FlowTestGenerator:
+    """Generates test cases by combining patterns and actions."""
+
+    def __init__(self, protocols: dict[str, Protocol], actions: dict[str, Action]):
+        """Initialize the generator with protocol and action specifications."""
+        self.protocols = protocols
+        self.actions = actions
+
+    def _build_multi_layer_packet(
+        self,
+        protocol_stack: list[str],
+        all_field_values: dict[str, dict[str, Any]],
+        add_payload: bool = True,
+    ) -> Packet:
+        """Build a packet from multiple protocol layers.
+
+        Raises:
+            ValueError: If protocol_stack is empty.
+        """
+        packet: Optional["Packet"] = None
 
-                elif verification_method == self._send_packet_and_verify_modification:
-                    verification_method(packet=packet, expected_packet=expected_packet)
+        for protocol_name in protocol_stack:
+            protocol_spec = self.protocols[protocol_name]
+            values = all_field_values.get(protocol_name, {})
+            layer = protocol_spec.build_scapy_layer(values)
 
-                testpmd.flow_delete(flow_id, port_id=port_id)
+            if packet is None:
+                packet = layer
+            else:
+                packet = packet / layer
 
-    def _send_packet_and_verify(self, packet: Packet, should_receive: bool = True) -> None:
-        """Generate a packet, send to the DUT, and verify it is forwarded back.
+        if add_payload:
+            packet = packet / Raw(load="X" * 5)
 
-        Args:
-            packet: Scapy packet to send and verify.
-            should_receive: Indicate whether the packet should be received.
-        """
-        received = send_packet_and_capture(packet)
-        contains_packet = any(
-            packet.haslayer(Raw) and b"xxxxx" in packet.load for packet in received
-        )
-        verify(
-            should_receive == contains_packet,
-            f"Packet was {'dropped' if should_receive else 'received'}",
-        )
+        if packet is None:
+            raise ValueError("Protocol stack cannot be empty.")
 
-    def _send_packet_and_verify_queue(
-        self, packet: Packet, test_queue: int, testpmd: TestPmd
-    ) -> None:
-        """Send packet and verify queue stats show packet was received.
+        return packet
 
-        Args:
-            packet: Scapy packet to send to the SUT.
-            test_queue: Represents the queue the test packet is being sent to.
-            testpmd: TestPmd instance being used to send test packet.
-        """
-        testpmd.set_verbose(level=8)
-        testpmd.start()
-        send_packet_and_capture(packet=packet)
-        verbose_output = testpmd.extract_verbose_output(testpmd.stop())
-        received = False
-        for testpmd_packet in verbose_output:
-            if testpmd_packet.queue_id == test_queue:
-                received = True
-        verify(received, f"Expected packet was not received on queue {test_queue}")
+    def generate(
+        self,
+        protocol_stack: list[tuple[str, bool]],
+        action_name: str,
+        action_value: Any = None,
+        group_id: int = 0,
+    ) -> list[FlowTest]:
+        """Generate test cases for patterns matching fields across multiple protocols.
 
-    def _send_packet_and_verify_modification(self, packet: Packet, expected_packet: Packet) -> None:
-        """Send packet and verify the expected modifications are present upon reception.
+        Pattern parts are assembled in stack order to preserve positional
+        correctness, which is required for tunnel encapsulations where
+        inner and outer layers share the same pattern_name.
 
         Args:
-            packet: Scapy packet to send to the SUT.
-            expected_packet: Scapy packet that should match the received packet.
+            protocol_stack: List of (protocol_name, test_fields) tuples.
+                If test_fields is True, iterate through field combinations.
+                If False, include protocol in pattern as wildcard match only.
+            action_name: Name of the action to apply.
+            action_value: Optional value for parameterized actions.
+            group_id: Flow group ID.
+
+        Returns:
+            List of FlowTest objects ready for execution.
         """
-        received = send_packet_and_capture(packet)
-
-        # verify reception
-        verify(received != [], "Packet was never received.")
-
-        log(f"SENT PACKET:     {packet.summary()}")
-        log(f"EXPECTED PACKET: {expected_packet.summary()}")
-        for packet in received:
-            log(f"RECEIVED PACKET: {packet.summary()}")
-
-        expected_ip_dst = expected_packet[IP].dst if IP in expected_packet else None
-        received_ip_dst = received[IP].dst if IP in received else None
+        action_spec = self.actions[action_name]
+        all_protocol_names = [name for name, _ in protocol_stack]
+        field_test_protocols = [name for name, test_fields in protocol_stack if test_fields]
+
+        if not field_test_protocols:
+            pattern_parts = [self.protocols[name].pattern_name for name, _ in protocol_stack]
+            pattern = " / ".join(pattern_parts)
+            flow_rule = FlowRule(
+                direction="ingress",
+                pattern=[pattern],
+                actions=[action_spec.build_action_string(action_value)],
+                group_id=group_id,
+            )
+            packet = self._build_multi_layer_packet(all_protocol_names, {}, add_payload=True)
+
+            return [
+                FlowTest(
+                    flow_rule=flow_rule,
+                    packet=packet,
+                    verification_type=action_spec.verification_type,
+                    verification_params=action_spec.build_verification_params(action_value),
+                    description=pattern + f" -> {action_spec.name}",
+                )
+            ]
+
+        protocol_field_specs = []
+        for protocol_name in field_test_protocols:
+            protocol_spec = self.protocols[protocol_name]
+            protocol_field_specs.append([(protocol_spec, f) for f in protocol_spec.fields])
+
+        test_cases = []
+
+        for field_combo in product(*protocol_field_specs):
+            max_vals = max(len(f_spec.test_parameters) for _, f_spec in field_combo)
+
+            for i in range(max_vals):
+                field_value_map: dict[str, tuple[Protocol, PatternField, Any]] = {}
+                all_field_values: dict[str, dict[str, Any]] = {}
+
+                for protocol_spec, field_spec in field_combo:
+                    val = field_spec.test_parameters[i % len(field_spec.test_parameters)]
+                    field_value_map[protocol_spec.name] = (protocol_spec, field_spec, val)
+
+                    if protocol_spec.name not in all_field_values:
+                        all_field_values[protocol_spec.name] = {}
+                    all_field_values[protocol_spec.name][field_spec.scapy_field] = val
+
+                pattern_parts = []
+                desc_parts = []
+
+                for proto_name, test_fields in protocol_stack:
+                    proto_spec = self.protocols[proto_name]
+                    if test_fields and proto_name in field_value_map:
+                        _, f_spec, val = field_value_map[proto_name]
+                        pattern_parts.append(
+                            f"{proto_spec.pattern_name} {f_spec.pattern_field} is {val}"
+                        )
+                        desc_parts.append(f"{proto_spec.name}[{f_spec.scapy_field}={val}]")
+                    else:
+                        pattern_parts.append(proto_spec.pattern_name)
+
+                full_pattern = " / ".join(pattern_parts)
+
+                flow_rule = FlowRule(
+                    direction="ingress",
+                    pattern=[full_pattern],
+                    actions=[action_spec.build_action_string(action_value)],
+                    group_id=group_id,
+                )
+
+                packet = self._build_multi_layer_packet(
+                    all_protocol_names, all_field_values, add_payload=True
+                )
+
+                full_desc = " / ".join(desc_parts)
+                test_cases.append(
+                    FlowTest(
+                        flow_rule=flow_rule,
+                        packet=packet,
+                        verification_type=action_spec.verification_type,
+                        verification_params=action_spec.build_verification_params(action_value),
+                        description=full_desc + f" -> {action_spec.name}",
+                    )
+                )
 
-        expected_mac_dst = expected_packet[Ether].dst if Ether in expected_packet else None
-        received_mac_dst = received[Ether].dst if Ether in received else None
+        return test_cases
 
-        # verify modification
-        if expected_ip_dst is not None:
-            verify(
-                received_ip_dst == expected_ip_dst,
-                f"IPv4 dst mismatch: expected {expected_ip_dst}, got {received_ip_dst}",
-            )
 
-        if expected_mac_dst is not None:
-            verify(
-                received_mac_dst == expected_mac_dst,
-                f"MAC dst mismatch: expected {expected_mac_dst}, got {received_mac_dst}",
-            )
+@requires_nic_capability(NicCapability.FLOW_CTRL)
+class TestRteFlow(TestSuite):
+    """RTE Flow test suite.
 
-    def _send_packet_and_verify_jump(
-        self,
-        packets: list[Packet],
-        flow_rules: list[FlowRule],
-        test_queues: list[int],
-        testpmd: TestPmd,
-    ) -> None:
-        """Create a testpmd session with every rule in the given list, verify jump behavior.
+    This suite consists of 4 test cases:
+    1. Queue Action: Verifies queue actions with multi-protocol patterns
+    2. Drop Action: Verifies drop actions with multi-protocol patterns
+    3. Modify Field Action: Verifies modify_field actions with hardcoded patterns
+    4. Jump Action: Verifies jump action between flow groups
 
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
-
-            try:
-                testpmd.flow_create(flow_rule=flow, port_id=0)
-            except InteractiveCommandExecutionError:
-                log("Flow validation passed, but flow creation failed.")
-                fail("Failed flow creation")
-
-        for packet, test_queue in zip(packets, test_queues):
-            testpmd.start()
-            send_packet_and_capture(packet=packet)
-            verbose_output = testpmd.extract_verbose_output(testpmd.stop())
-            received = False
-            for testpmd_packet in verbose_output:
-                if testpmd_packet.queue_id == test_queue:
-                    received = True
-            verify(received, f"Expected packet was not received on queue {test_queue}")
+    """
 
-    @func_test
-    def queue_action_ETH(self) -> None:
-        """Validate flow rules with queue actions and ethernet patterns.
+    def set_up_suite(self) -> None:
+        """Initialize the test generator and result tracking."""
+        self.generator = FlowTestGenerator(PROTOCOLS, ACTIONS)
+        self.test_suite_results: list[FlowTestResult] = []
+        self.test_case_results: list[FlowTestResult] = []
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+    def _get_modify_test_cases(self) -> list[ModifyTest]:
+        """Build and return the hardcoded modify action test cases.
 
-        Verify:
-            * Each packet is received on the appropriate queue.
+        Constructed at call time rather than module level to avoid
+        Scapy packet construction during doc generation imports.
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
+        return [
+            ModifyTest(
+                description="ipv4[src=192.168.1.1] -> set_ipv4_dst",
+                pattern="eth / ipv4 src is 192.168.1.1",
+                action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+                packet=(
+                    Ether() / IP(src="192.168.1.1", dst="10.0.0.1") / UDP() / Raw(load="X" * 5)
+                ),
+                expected_ipv4_dst="192.168.2.1",
             ),
-            FlowRule(
-                direction="ingress", pattern=["eth type is 0x0800"], actions=["queue index 2"]
+            ModifyTest(
+                description="ipv4[dst=192.168.1.2] -> set_ipv4_dst",
+                pattern="eth / ipv4 dst is 192.168.1.2",
+                action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+                packet=(
+                    Ether() / IP(src="10.0.0.1", dst="192.168.1.2") / UDP() / Raw(load="X" * 5)
+                ),
+                expected_ipv4_dst="192.168.2.1",
             ),
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
-    def queue_action_IP(self) -> None:
-        """Validate flow rules with queue actions and IPv4/IPv6 patterns.
-
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
-
-        Verify:
-            * Each packet is received on the appropriate queue.
-        """
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
+            ModifyTest(
+                description="ipv4[ttl=64] -> set_ipv4_dst",
+                pattern="eth / ipv4 ttl is 64",
+                action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+                packet=Ether() / IP(ttl=64) / UDP() / Raw(load="X" * 5),
+                expected_ipv4_dst="192.168.2.1",
             ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 dst is 192.168.1.1"],
-                actions=["queue index 2"],
+            ModifyTest(
+                description="ipv4[ttl=128] -> set_ipv4_dst",
+                pattern="eth / ipv4 ttl is 128",
+                action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+                packet=Ether() / IP(ttl=128) / UDP() / Raw(load="X" * 5),
+                expected_ipv4_dst="192.168.2.1",
             ),
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv4 ttl is 64"], actions=["queue index 2"]
+            ModifyTest(
+                description="ipv4[tos=0] -> set_ipv4_dst",
+                pattern="eth / ipv4 tos is 0",
+                action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+                packet=Ether() / IP(tos=0) / UDP() / Raw(load="X" * 5),
+                expected_ipv4_dst="192.168.2.1",
             ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv6 src is 2001:db8::1"],
-                actions=["queue index 2"],
+            ModifyTest(
+                description="ipv4[tos=4] -> set_ipv4_dst",
+                pattern="eth / ipv4 tos is 4",
+                action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+                packet=Ether() / IP(tos=4) / UDP() / Raw(load="X" * 5),
+                expected_ipv4_dst="192.168.2.1",
             ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv6 dst is 2001:db8::2"],
-                actions=["queue index 2"],
+            ModifyTest(
+                description="eth[src=02:00:00:00:00:00] -> set_mac_dst",
+                pattern="eth src is 02:00:00:00:00:00",
+                action="set_mac_dst mac_addr 02:00:00:00:00:02 / queue index 0",
+                packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:01") / Raw(load="X" * 5)
+                ),
+                expected_mac_dst="02:00:00:00:00:02",
             ),
-            FlowRule(
-                direction="ingress", pattern=["eth / ipv6 proto is 17"], actions=["queue index 2"]
+            ModifyTest(
+                description="eth[dst=02:00:00:00:00:02] -> set_mac_dst",
+                pattern="eth dst is 02:00:00:00:00:02",
+                action="set_mac_dst mac_addr 02:00:00:00:00:02 / queue index 0",
+                packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02") / Raw(load="X" * 5)
+                ),
+                expected_mac_dst="02:00:00:00:00:02",
             ),
         ]
-        self._runner(
-            verification_method=self._send_packet_and_verify_queue,
-            flows=flow_list,
-            packets=packet_list,
-            port_id=0,
-            test_queue=2,
-        )
-
-    @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
-    @func_test
-    def queue_action_L4(self) -> None:
-        """Validate flow rules with queue actions and TCP/UDP patterns.
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+    def _get_jump_test_cases(self) -> list[JumpTest]:
+        """Build and return the hardcoded jump action test cases.
 
-        Verify:
-            * Each packet is received on the appropriate queue.
+        Constructed at call time rather than module level to avoid
+        Scapy packet construction during doc generation imports.
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
+        return [
+            JumpTest(
+                description=(
+                    "eth[src=02:00:00:00:00:00] -> jump -> ipv4[dst=192.168.1.2] -> queue 2"
+                ),
+                group0_pattern="eth src is 02:00:00:00:00:00",
+                group1_pattern="ipv4 dst is 192.168.1.2",
+                group1_action="queue index 2",
+                matching_packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+                    / IP(src="192.168.1.1", dst="192.168.1.2")
+                    / UDP(sport=5000, dport=53)
+                    / Raw(load="X" * 5)
+                ),
+                non_matching_packet=(
+                    Ether(src="02:00:00:00:00:01", dst="02:00:00:00:00:02")
+                    / IP(src="192.168.1.1", dst="192.168.1.2")
+                    / UDP(sport=5000, dport=53)
+                    / Raw(load="X" * 5)
+                ),
+                target_queue=2,
             ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 / tcp dst is 80"],
-                actions=["queue index 2"],
+            JumpTest(
+                description=(
+                    "eth[dst=02:00:00:00:00:02] -> jump -> ipv4[src=192.168.1.1] -> queue 3"
+                ),
+                group0_pattern="eth dst is 02:00:00:00:00:02",
+                group1_pattern="ipv4 src is 192.168.1.1",
+                group1_action="queue index 3",
+                matching_packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+                    / IP(src="192.168.1.1", dst="192.168.1.2")
+                    / UDP(sport=5000, dport=53)
+                    / Raw(load="X" * 5)
+                ),
+                non_matching_packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:03")
+                    / IP(src="192.168.1.1", dst="192.168.1.2")
+                    / UDP(sport=5000, dport=53)
+                    / Raw(load="X" * 5)
+                ),
+                target_queue=3,
             ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 / tcp flags is 0x02"],
-                actions=["queue index 2"],
+            JumpTest(
+                description="ipv4[src=10.0.0.1] -> jump -> tcp[dst=443] -> queue 1",
+                group0_pattern="eth / ipv4 src is 10.0.0.1",
+                group1_pattern="ipv4 / tcp dst is 443",
+                group1_action="queue index 1",
+                matching_packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+                    / IP(src="10.0.0.1", dst="10.0.0.2")
+                    / TCP(sport=12345, dport=443)
+                    / Raw(load="X" * 5)
+                ),
+                non_matching_packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+                    / IP(src="10.0.0.99", dst="10.0.0.2")
+                    / TCP(sport=12345, dport=443)
+                    / Raw(load="X" * 5)
+                ),
+                target_queue=1,
             ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 / udp src is 5000"],
-                actions=["queue index 2"],
+            JumpTest(
+                description="ipv4[dst=172.16.0.1] -> jump -> udp[dst=123] -> queue 2",
+                group0_pattern="eth / ipv4 dst is 172.16.0.1",
+                group1_pattern="ipv4 / udp dst is 123",
+                group1_action="queue index 2",
+                matching_packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+                    / IP(src="172.16.0.100", dst="172.16.0.1")
+                    / UDP(sport=5000, dport=123)
+                    / Raw(load="X" * 5)
+                ),
+                non_matching_packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+                    / IP(src="172.16.0.100", dst="172.16.0.99")
+                    / UDP(sport=5000, dport=123)
+                    / Raw(load="X" * 5)
+                ),
+                target_queue=2,
             ),
-            FlowRule(
-                direction="ingress",
-                pattern=["eth / ipv4 / udp dst is 53"],
-                actions=["queue index 2"],
+            JumpTest(
+                description="eth[src=02:00:00:00:00:00] -> jump -> udp[dst=53] -> queue 3",
+                group0_pattern="eth src is 02:00:00:00:00:00",
+                group1_pattern="ipv4 / udp dst is 53",
+                group1_action="queue index 3",
+                matching_packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+                    / IP(src="192.168.1.1", dst="192.168.1.2")
+                    / UDP(sport=5000, dport=53)
+                    / Raw(load="X" * 5)
+                ),
+                non_matching_packet=(
+                    Ether(src="02:00:00:00:00:01", dst="02:00:00:00:00:02")
+                    / IP(src="192.168.1.1", dst="192.168.1.2")
+                    / UDP(sport=5000, dport=53)
+                    / Raw(load="X" * 5)
+                ),
+                target_queue=3,
+            ),
+            JumpTest(
+                description="ipv4[tos=4] -> jump -> tcp[dst=80] -> queue 1",
+                group0_pattern="eth / ipv4 tos is 4",
+                group1_pattern="ipv4 / tcp dst is 80",
+                group1_action="queue index 1",
+                matching_packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+                    / IP(src="10.0.0.1", dst="10.0.0.2", tos=4)
+                    / TCP(sport=54321, dport=80)
+                    / Raw(load="X" * 5)
+                ),
+                non_matching_packet=(
+                    Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+                    / IP(src="10.0.0.1", dst="10.0.0.2", tos=0)
+                    / TCP(sport=54321, dport=80)
+                    / Raw(load="X" * 5)
+                ),
+                target_queue=1,
             ),
         ]
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
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+    def _validate_and_create_flow(
+        self,
+        rule: FlowRule,
+        description: str,
+        testpmd: TestPmd,
+        port_id: int = 0,
+        sent_packet: Optional["Packet"] = None,
+    ) -> int | None:
+        """Validate and create a flow rule, recording results.
 
-        Verify:
-            * Each packet is received on the appropriate queue.
+        Args:
+            rule: The flow rule to validate and create.
+            description: Description for the test result.
+            testpmd: Active TestPmd session.
+            port_id: Port ID for flow operations.
+            sent_packet: Optional packet associated with this test.
+
+        Returns:
+            Flow ID if successful, None if validation or creation failed.
         """
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
+        result = FlowTestResult(
+            description=description,
+            passed=False,
+            flow_rule_pattern=" / ".join(rule.pattern),
+            sent_packet=sent_packet,
         )
 
-    @func_test
-    def drop_action_ETH(self) -> None:
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
+        is_valid = testpmd.flow_validate(flow_rule=rule, port_id=port_id)
+        if not is_valid:
+            result.skipped = True
+            result.failure_reason = "Flow rule failed validation"
+            self.test_suite_results.append(result)
+            self.test_case_results.append(result)
+            return None
+
+        try:
+            flow_id = testpmd.flow_create(flow_rule=rule, port_id=port_id)
+        except InteractiveCommandExecutionError:
+            result.failure_reason = "Hardware validated but failed to create flow rule"
+            self.test_suite_results.append(result)
+            self.test_case_results.append(result)
+            return None
+
+        result.passed = True
+        self.test_suite_results.append(result)
+        self.test_case_results.append(result)
+        return flow_id
+
+    def _record_failure(self, reason: str) -> None:
+        """Record a verification failure in both result lists."""
+        self.test_suite_results[-1].passed = False
+        self.test_suite_results[-1].failure_reason = reason
+        self.test_case_results[-1].passed = False
+        self.test_case_results[-1].failure_reason = reason
+
+    def _record_skip(self, reason: str) -> None:
+        """Record a skipped test in both result lists."""
+        self.test_suite_results[-1].passed = False
+        self.test_suite_results[-1].skipped = True
+        self.test_suite_results[-1].failure_reason = f"Skipped: {reason}"
+        self.test_case_results[-1].passed = False
+        self.test_case_results[-1].skipped = True
+        self.test_case_results[-1].failure_reason = f"Skipped: {reason}"
+
+    def _verify_basic_transmission(self, action_type: str) -> None:
+        """Verify that non-matching packets are unaffected by flow rules.
+
+        Creates a flow rule for the specified action, then sends a packet that
+        should NOT match the rule to confirm:
+        - For 'drop': non-matching packets ARE received (not dropped)
+        - For 'queue': non-matching packets are NOT steered to the target queue
+        - For 'modify': non-matching packets arrive unmodified
+
+        This ensures flow rules only affect matching traffic before
+        running the actual action tests.
 
-        One packet will be sent as a confidence check, to ensure packets are being
-        received under normal circumstances.
+        Args:
+            action_type: The action being tested ('drop', 'queue', 'modify').
         """
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
+        non_matching_packet = (
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:01")
+            / IP(src="192.168.100.1", dst="192.168.100.2")
+            / UDP(sport=9999, dport=9998)
+            / Raw(load="X" * 5)
         )
 
-    @func_test
-    def drop_action_IP(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
+        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
+            if action_type == "drop":
+                rule = FlowRule(
+                    direction="ingress",
+                    pattern=["eth / ipv4 src is 192.168.1.1 / udp dst is 53"],
+                    actions=["drop"],
+                )
+                flow_id = self._validate_and_create_flow(
+                    rule,
+                    f"Basic transmission check ({action_type})",
+                    testpmd,
+                    sent_packet=non_matching_packet,
+                )
+                if flow_id is None:
+                    return
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+                testpmd.start()
+                received = send_packet_and_capture(non_matching_packet)
+                testpmd.stop()
+                contains_packet = any(
+                    p.haslayer(Raw) and b"XXXXX" in bytes(p[Raw].load) for p in received
+                )
+                testpmd.flow_delete(flow_id, port_id=0)
+                verify(
+                    contains_packet,
+                    "Basic transmission check failed: non-matching packet dropped",
+                )
+
+            elif action_type == "queue":
+                rule = FlowRule(
+                    direction="ingress",
+                    pattern=[
+                        "eth src is aa:bb:cc:dd:ee:ff / ipv4 src is 10.255.255.254 "
+                        "dst is 10.255.255.253 / udp src is 12345 dst is 54321"
+                    ],
+                    actions=["queue index 3"],
+                )
+                flow_id = self._validate_and_create_flow(
+                    rule,
+                    f"Basic transmission check ({action_type})",
+                    testpmd,
+                    sent_packet=non_matching_packet,
+                )
+                if flow_id is None:
+                    return
+
+                testpmd.set_verbose(level=8)
+                testpmd.start()
+                send_packet_and_capture(non_matching_packet)
+                verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+                received_on_target = any(p.queue_id == 3 for p in verbose_output)
+                testpmd.flow_delete(flow_id, port_id=0)
+                verify(
+                    not received_on_target,
+                    "Basic transmission check failed: non-matching packet steered to queue 3",
+                )
+
+            elif action_type == "modify":
+                rule = FlowRule(
+                    direction="ingress",
+                    pattern=["eth / ipv4 src is 192.168.1.1 / udp dst is 53"],
+                    actions=["set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0"],
+                )
+                flow_id = self._validate_and_create_flow(
+                    rule,
+                    f"Basic transmission check ({action_type})",
+                    testpmd,
+                    sent_packet=non_matching_packet,
+                )
+                if flow_id is None:
+                    return
 
-        Verify:
-            * Packet is dropped.
+                testpmd.start()
+                received = send_packet_and_capture(non_matching_packet)
+                testpmd.stop()
+                testpmd.flow_delete(flow_id, port_id=0)
+
+                test_packet = next(
+                    (p for p in received if p.haslayer(Raw) and b"XXXXX" in bytes(p[Raw].load)),
+                    None,
+                )
+                if (
+                    test_packet is not None
+                    and non_matching_packet is not None
+                    and IP in test_packet
+                    and IP in non_matching_packet
+                ):
+                    verify(
+                        test_packet[IP].dst == non_matching_packet[IP].dst,
+                        "Basic transmission check failed: non-matching packet was modified",
+                    )
 
-        One packet will be sent as a confidence check, to ensure packets are being
-        received under normal circumstances.
-        """
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
-        )
+        log(f"Basic transmission check passed for '{action_type}' action")
 
-    @func_test
-    def drop_action_L4(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
+    def _verify_queue(self, packet: Packet, queue_id: int, testpmd: TestPmd, **kwargs: Any) -> None:
+        """Verify packet is received on the expected queue."""
+        send_packet_and_capture(packet)
+        verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+        received_on_queue = any(p.queue_id == queue_id for p in verbose_output)
+        verify(received_on_queue, f"Packet not received on queue {queue_id}")
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+    def _verify_drop(self, packet: Packet, **kwargs: Any) -> None:
+        """Verify packet is dropped."""
+        received = send_packet_and_capture(packet)
+        contains_packet = any(p.haslayer(Raw) and b"XXXXX" in bytes(p[Raw].load) for p in received)
+        verify(not contains_packet, "Packet was not dropped")
 
-        Verify:
-            * Packet is dropped.
+    def _run_tests(
+        self,
+        test_cases: list[FlowTest],
+        port_id: int = 0,
+    ) -> None:
+        """Execute a sequence of generated test cases."""
+        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
+            for test_case in test_cases:
+                log(f"Testing: {test_case.description}")
+
+                flow_id = self._validate_and_create_flow(
+                    test_case.flow_rule,
+                    test_case.description,
+                    testpmd,
+                    port_id,
+                    sent_packet=test_case.packet,
+                )
+                if flow_id is None:
+                    continue
 
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
-        )
+                try:
+                    if test_case.verification_type == "queue":
+                        testpmd.set_verbose(level=8)
 
-    @func_test
-    def drop_action_VLAN(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
+                    testpmd.start()
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+                    verification_method = getattr(self, f"_verify_{test_case.verification_type}")
+                    verification_method(
+                        packet=test_case.packet,
+                        testpmd=testpmd,
+                        **test_case.verification_params,
+                    )
 
-        Verify:
-            * Packet is dropped.
+                    testpmd.stop()
+
+                except SkippedTestException as e:
+                    self._record_skip(str(e))
+
+                except TestCaseVerifyError as e:
+                    self._record_failure(str(e))
+
+                finally:
+                    testpmd.flow_delete(flow_id, port_id=port_id)
+
+    def _log_test_suite_summary(self) -> None:
+        """Log a summary of all test results."""
+        if not self.test_suite_results:
+            return
+
+        passed_rules = [r for r in self.test_suite_results if r.passed]
+        skipped_rules = [r for r in self.test_suite_results if r.skipped]
+        failed_rules = [r for r in self.test_suite_results if not r.passed and not r.skipped]
+
+        log(f"Total tests run: {len(self.test_suite_results)}")
+        log(f"Passed: {len(passed_rules)}")
+        log(f"Skipped: {len(skipped_rules)}")
+        log(f"Failed: {len(failed_rules)}")
+
+        if passed_rules:
+            log("\nPASSED RULES:")
+            for result in passed_rules:
+                log(f"  {result.description}")
+                log(f"    Sent Packet: {result.sent_packet}")
+
+        if skipped_rules:
+            log("\nSKIPPED RULES:")
+            for result in skipped_rules:
+                log(f"  {result.description}")
+                log(f"    Pattern: {result.flow_rule_pattern}")
+                log(f"    Reason: {result.failure_reason}")
+                log(f"    Sent Packet: {result.sent_packet}")
+
+        if failed_rules:
+            log("\nFAILED RULES:")
+            for result in failed_rules:
+                log(f"  {result.description}")
+                log(f"    Pattern: {result.flow_rule_pattern}")
+                log(f"    Reason: {result.failure_reason}")
+                log(f"    Sent Packet: {result.sent_packet}")
+
+    def _check_test_case_failures(self) -> None:
+        """Fail the test case if any flow rules failed creation or verification."""
+        failures = [r for r in self.test_case_results if not r.passed and not r.skipped]
+        self.test_case_results = []
+
+        if failures:
+            details = "\n".join(
+                f"\t{r.description}\n"
+                f"\t  Pattern: {r.flow_rule_pattern}\n"
+                f"\t  Reason: {r.failure_reason}\n"
+                f"\t  Sent Packet: {r.sent_packet}"
+                for r in failures
+            )
+            fail(f"Flow rules failed:\n{details}")
 
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
-        )
+    # -------------------- Generator Test Cases --------------------
 
     @func_test
-    def modify_actions(self) -> None:
-        """Validate flow rules with actions that modify that packet during transmission.
+    def queue_action(self) -> None:
+        """Validate flow rules with queue actions and multi-protocol patterns.
 
         Steps:
+            * Run basic transmission check to verify baseline packet reception.
             * Create a list of packets to test, with a corresponding flow list.
             * Launch testpmd.
             * Create first flow rule in flow list.
@@ -608,44 +1080,24 @@ def modify_actions(self) -> None:
             * Delete flow rule, repeat for all flows/packets.
 
         Verify:
-            * Verify packet is received with the new attributes.
+            * Each packet is received on the appropriate queue.
         """
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
-        )
+        self._verify_basic_transmission("queue")
+        for stack in PROTOCOL_STACKS:
+            test_cases = self.generator.generate(
+                protocol_stack=stack,
+                action_name="queue",
+                action_value=2,
+            )
+            self._run_tests(test_cases)
+        self._check_test_case_failures()
 
     @func_test
-    def egress_rules(self) -> None:
-        """Validate flow rules with egress directions.
+    def drop_action(self) -> None:
+        """Validate flow rules with drop actions and multi-protocol patterns.
 
         Steps:
+            * Run basic transmission check to verify packets are received without drop rules.
             * Create a list of packets to test, with a corresponding flow list.
             * Launch testpmd.
             * Create first flow rule in flow list.
@@ -654,144 +1106,208 @@ def egress_rules(self) -> None:
 
         Verify:
             * Packet is dropped.
-
-        One packet will be sent as a confidence check, to ensure packets are being
-        received under normal circumstances.
         """
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
+        self._verify_basic_transmission("drop")
+        for stack in PROTOCOL_STACKS:
+            test_cases = self.generator.generate(
+                protocol_stack=stack,
+                action_name="drop",
+            )
+            self._run_tests(test_cases)
+        self._check_test_case_failures()
+
+    # -------------------- Hard Coded Test Cases --------------------
 
     @func_test
-    def jump_action(self) -> None:
-        """Validate flow rules with different group levels and jump actions.
+    def modify_field_action(self) -> None:
+        """Validate flow rules with modify_field actions and hardcoded patterns.
 
         Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd with the necessary configuration.
-            * Create each flow rule in testpmd.
-            * Send each packet in the list, check Rx queue ID.
+            * Run basic transmission check to verify packets arrive unmodified.
+            * For each test case in MODIFY_TEST_CASES, create the flow rule.
+            * Send the corresponding packet and capture the received packet.
+            * Verify the expected field was modified correctly.
+            * Delete the flow rule and repeat for all test cases.
 
         Verify:
-            * Check that each packet is received on the appropriate Rx queue.
+            * Each packet is modified correctly according to its action.
         """
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
+        port_id = 0
+        self._verify_basic_transmission("modify")
+
         with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
-            self._send_packet_and_verify_jump(
-                packets=packet_list,
-                flow_rules=flow_list,
-                test_queues=expected_queue_list,
-                testpmd=testpmd,
-            )
+            for test_case in self._get_modify_test_cases():
+                log(f"Testing: {test_case.description}")
+
+                rule = FlowRule(
+                    direction="ingress",
+                    pattern=[test_case.pattern],
+                    actions=[test_case.action],
+                )
+
+                flow_id = self._validate_and_create_flow(
+                    rule,
+                    test_case.description,
+                    testpmd,
+                    port_id,
+                    sent_packet=test_case.packet,
+                )
+                if flow_id is None:
+                    continue
+
+                try:
+                    testpmd.start()
+                    received = send_packet_and_capture(test_case.packet)
+                    testpmd.stop()
+
+                    test_packet = next(
+                        (p for p in received if p.haslayer(Raw) and b"XXXXX" in bytes(p[Raw].load)),
+                        None,
+                    )
+
+                    verify(
+                        test_packet is not None,
+                        f"{test_case.description}: Packet not received",
+                    )
+
+                    if (
+                        test_packet
+                        and test_case.expected_ipv4_dst is not None
+                        and IP in test_packet
+                    ):
+                        verify(
+                            test_packet[IP].dst == test_case.expected_ipv4_dst,
+                            f"{test_case.description}: IPv4 dst mismatch: "
+                            f"expected {test_case.expected_ipv4_dst}, "
+                            f"got {test_packet[IP].dst}",
+                        )
+                    if (
+                        test_packet
+                        and test_case.expected_mac_dst is not None
+                        and Ether in test_packet
+                    ):
+                        verify(
+                            test_packet[Ether].dst == test_case.expected_mac_dst,
+                            f"{test_case.description}: MAC dst mismatch: "
+                            f"expected {test_case.expected_mac_dst}, "
+                            f"got {test_packet[Ether].dst}",
+                        )
+
+                except SkippedTestException as e:
+                    self._record_skip(str(e))
+
+                except TestCaseVerifyError as e:
+                    self._record_failure(str(e))
+
+                finally:
+                    testpmd.flow_delete(flow_id, port_id=port_id)
+
+        self._check_test_case_failures()
 
     @func_test
-    def priority_attribute(self) -> None:
-        """Validate flow rules with queue actions and ethernet patterns.
+    def jump_action(self) -> None:
+        """Validate flow rules with jump action between groups.
+
+        The jump action redirects matched packets from one flow group to another.
+        Only flow rules in group 0 are guaranteed to be matched against initially;
+        subsequent groups can only be reached via jump actions.
+
+        For each test case in JUMP_TEST_CASES, this creates a two-stage pipeline:
+        - Group 0: Match on a pattern, jump to group 1
+        - Group 1: Match on a second pattern, forward to a specific queue
 
         Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+            * Launch testpmd with multiple queues.
+            * For each test case, create group 0 rule (match + jump) and group 1 rule
+              (match + queue).
+            * Send matching packet and verify it arrives on the target queue.
+            * Send non-matching packet and verify it does not reach the target queue.
+            * Delete both flow rules and repeat for all test cases.
 
         Verify:
-            * Each packet is received on the appropriate queue.
+            * Packet matching both rules is received on the target queue.
+            * Packet not matching group 0 rule does not reach the target queue.
         """
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
+        port_id = 0
+
         with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
-            testpmd.set_verbose(level=8)
-            for flow, expected_queue in zip(flow_list, expected_queue_list):
-                is_valid = testpmd.flow_validate(flow_rule=flow, port_id=0)
-                verify_else_skip(is_valid, "flow rule failed validation.")
+            for test_case in self._get_jump_test_cases():
+                log(f"Testing: {test_case.description}")
+
+                jump_rule = FlowRule(
+                    direction="ingress",
+                    group_id=0,
+                    pattern=[test_case.group0_pattern],
+                    actions=["jump group 1"],
+                )
+
+                queue_rule = FlowRule(
+                    direction="ingress",
+                    group_id=1,
+                    pattern=[test_case.group1_pattern],
+                    actions=[test_case.group1_action],
+                )
+
+                jump_flow_id = self._validate_and_create_flow(
+                    jump_rule,
+                    f"{test_case.description} (group 0 -> jump)",
+                    testpmd,
+                    port_id,
+                    sent_packet=test_case.matching_packet,
+                )
+                if jump_flow_id is None:
+                    continue
+
+                queue_flow_id = self._validate_and_create_flow(
+                    queue_rule,
+                    f"{test_case.description} (group 1 -> queue)",
+                    testpmd,
+                    port_id,
+                    sent_packet=test_case.matching_packet,
+                )
+                if queue_flow_id is None:
+                    testpmd.flow_delete(jump_flow_id, port_id=port_id)
+                    continue
+
                 try:
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
+                    testpmd.set_verbose(level=8)
+                    testpmd.start()
+
+                    send_packet_and_capture(test_case.matching_packet)
+                    verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+                    received_on_target = any(
+                        p.queue_id == test_case.target_queue for p in verbose_output
+                    )
+                    verify(
+                        received_on_target,
+                        f"{test_case.description}: Matching packet not received on "
+                        f"queue {test_case.target_queue} after jump",
+                    )
+
+                    testpmd.start()
+                    send_packet_and_capture(test_case.non_matching_packet)
+                    verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+                    non_matching_on_target = any(
+                        p.queue_id == test_case.target_queue for p in verbose_output
+                    )
+                    verify(
+                        not non_matching_on_target,
+                        f"{test_case.description}: Non-matching packet incorrectly "
+                        f"received on queue {test_case.target_queue}",
+                    )
+
+                except SkippedTestException as e:
+                    self._record_skip(str(e))
+
+                except TestCaseVerifyError as e:
+                    self._record_failure(str(e))
+
+                finally:
+                    testpmd.flow_delete(queue_flow_id, port_id=port_id)
+                    testpmd.flow_delete(jump_flow_id, port_id=port_id)
+
+        self._check_test_case_failures()
+
+    def tear_down_suite(self) -> None:
+        """Log test summary at the end of the suite."""
+        self._log_test_suite_summary()
-- 
2.52.0

