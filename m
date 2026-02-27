Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F1FEFB7C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 19:20:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D919B402E7;
	Fri, 27 Feb 2026 20:20:21 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id F1EC6402C6
 for <dev@dpdk.org>; Fri, 27 Feb 2026 20:20:19 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8cb3e0093e3so229225285a.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772220019; x=1772824819; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6s7wWiTvtsqsPGaCh1ajSbdI+uM5VXmTeRqYKu3Dmk=;
 b=D53JX/LM7Cy009XiTNB3M1wgZkFqrWNwIqbhX93HLyOF/YtRsZ06KqDlbAgf3opLXn
 dODIWeH8frEiW8gjjQOTcc4PjU4L0QU22jJFdKdSAelqOJ/9YFEWEiz1IFSTHHYMAdaS
 zWXi0Z603peS2BvlE7QzZMTFsdTFHI1e71kfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772220019; x=1772824819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f6s7wWiTvtsqsPGaCh1ajSbdI+uM5VXmTeRqYKu3Dmk=;
 b=MAdWLl017/viTSgEND2C7hg0M+aI7R+hToYnacV6jRfw0Ya2+slykE4wFtphgQKA4W
 /XHhSqQthYDr4QbKi4vfGnzYBHgz6sGNoptLNR/yzCp+bmC+v8Z6A6q7xK666sAiJZRi
 0fk91VpalZx4/56/umWretKXAvv8cQhcee++xBpNhfAmXS6nGD7K4imvAY+UmZB1ElpG
 QJlNR5on/qPKrJ9te442FUPQyJQeRFYuc+h3E5i3NbKa3zShRmGW4mEK2+ajlbeF9BPc
 6cHAD32Ce9FjCjgcju26sCk3GXfCapg1D3C2t5D9eYXzTq8vmt0esDHGqoI/GBERWeK+
 6+yg==
X-Gm-Message-State: AOJu0YyeGrBWxyBVSvPWkkl3sSGtKEHgmQuP5jJkFooTGGLD5TSHWdKs
 wirGrbnEyVDW/G/jOYcmQH2CL421GBNUfS/fGqF2XHikAa3/zQT5G1KMNyLe9tr7etg=
X-Gm-Gg: ATEYQzzO+54LQn2ubbVjo+JjI+qbaYDK2MJAHZF7FHZNmOBzi/q6RurtZZ/tWXy8b6d
 aBP1pLCz/FKN/ORdyANxuKeYp10XkHfxgxRWthD1ftgsxB+OL5VG6DtFujYzjvwN/slitPuyTSx
 ftuvzhu8cdg46r4BFcGsFadEw2wjU4Kqw/oo/sLzdKg2wTNYN7dLBGBwY5Gp9G2xj/dtvWWgb0R
 +0WmpfaS+XiUUY4GtBDqlktLl9SlNzvMC9kZjAiy8RxBfTCSdY8u7QTf3Gj5jpLljP/p3AeWBnK
 mNFt0rVL0/qkIhIxaiFBKhXJX42zoGfbfyZdql5FNz/ZV4NfT7/HYDad+eSWz7qf6HvGE+B1GRI
 eUgnRc+8j0DOw4BiNuqHB4/bRFFKxbLsdNwAGhqKQXRkIdu4ZxmV3ZpF1Bb9+FFgQ+XU/Qti7Me
 YmKuNJ1C7dgv7apAAHQbH0MC9Zf5y42facnLoCalZCaMA=
X-Received: by 2002:a05:620a:472a:b0:8c5:310d:3b2d with SMTP id
 af79cd13be357-8cbc8da9af5mr478866685a.33.1772220018615; 
 Fri, 27 Feb 2026 11:20:18 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf717301sm532151985a.36.2026.02.27.11.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 11:20:18 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2] dts: refactor flow suite with generator pattern
Date: Fri, 27 Feb 2026 14:20:16 -0500
Message-ID: <20260227192016.495703-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106213803.205934-1-dmarx@iol.unh.edu>
References: <20260106213803.205934-1-dmarx@iol.unh.edu>
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
 dts/tests/TestSuite_rte_flow.py | 1692 ++++++++++++++++++-------------
 1 file changed, 1012 insertions(+), 680 deletions(-)

diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 207cbce2d3..3e46f4a4f0 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -10,507 +10,885 @@
 
 """
 
-from collections.abc import Callable
-from itertools import zip_longest
-from typing import Any, Iterator, cast
+from dataclasses import dataclass
+from itertools import product
+from typing import Any, Callable
 
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
+from framework.exception import (
+    InteractiveCommandExecutionError,
+    SkippedTestException,
+    TestCaseVerifyError,
+)
 from framework.test_suite import TestSuite, func_test
 
 
-@requires_nic_capability(NicCapability.FLOW_CTRL)
-class TestRteFlow(TestSuite):
-    """RTE Flow test suite.
-
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
+@dataclass
+class PatternField:
+    """Specification for a single matchable field within a protocol layer."""
 
-    """
-
-    def _runner(
+    scapy_field: str
+    pattern_field: str
+    test_parameters: list[Any]
+
+
+@dataclass
+class Protocol:
+    """Complete specification for a protocol layer."""
+
+    name: str
+    scapy_class: type[Packet]
+    pattern_name: str
+    fields: list[PatternField]
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
+    sent_packet: Packet | None = None
+
+
+@dataclass
+class ModifyTestCase:
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
+class JumpTestCase:
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
+]
+
+MODIFY_TEST_CASES: list[ModifyTestCase] = [
+    ModifyTestCase(
+        description="ipv4[src=192.168.1.1] -> set_ipv4_dst",
+        pattern="eth / ipv4 src is 192.168.1.1",
+        action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+        packet=Ether() / IP(src="192.168.1.1", dst="10.0.0.1") / UDP() / Raw(load="X" * 5),
+        expected_ipv4_dst="192.168.2.1",
+    ),
+    ModifyTestCase(
+        description="ipv4[dst=192.168.1.2] -> set_ipv4_dst",
+        pattern="eth / ipv4 dst is 192.168.1.2",
+        action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+        packet=Ether() / IP(src="10.0.0.1", dst="192.168.1.2") / UDP() / Raw(load="X" * 5),
+        expected_ipv4_dst="192.168.2.1",
+    ),
+    ModifyTestCase(
+        description="ipv4[ttl=64] -> set_ipv4_dst",
+        pattern="eth / ipv4 ttl is 64",
+        action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+        packet=Ether() / IP(ttl=64) / UDP() / Raw(load="X" * 5),
+        expected_ipv4_dst="192.168.2.1",
+    ),
+    ModifyTestCase(
+        description="ipv4[ttl=128] -> set_ipv4_dst",
+        pattern="eth / ipv4 ttl is 128",
+        action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+        packet=Ether() / IP(ttl=128) / UDP() / Raw(load="X" * 5),
+        expected_ipv4_dst="192.168.2.1",
+    ),
+    ModifyTestCase(
+        description="ipv4[tos=0] -> set_ipv4_dst",
+        pattern="eth / ipv4 tos is 0",
+        action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+        packet=Ether() / IP(tos=0) / UDP() / Raw(load="X" * 5),
+        expected_ipv4_dst="192.168.2.1",
+    ),
+    ModifyTestCase(
+        description="ipv4[tos=4] -> set_ipv4_dst",
+        pattern="eth / ipv4 tos is 4",
+        action="set_ipv4_dst ipv4_addr 192.168.2.1 / queue index 0",
+        packet=Ether() / IP(tos=4) / UDP() / Raw(load="X" * 5),
+        expected_ipv4_dst="192.168.2.1",
+    ),
+    ModifyTestCase(
+        description="eth[src=02:00:00:00:00:00] -> set_mac_dst",
+        pattern="eth src is 02:00:00:00:00:00",
+        action="set_mac_dst mac_addr 02:00:00:00:00:02 / queue index 0",
+        packet=Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:01") / Raw(load="X" * 5),
+        expected_mac_dst="02:00:00:00:00:02",
+    ),
+    ModifyTestCase(
+        description="eth[dst=02:00:00:00:00:02] -> set_mac_dst",
+        pattern="eth dst is 02:00:00:00:00:02",
+        action="set_mac_dst mac_addr 02:00:00:00:00:02 / queue index 0",
+        packet=Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02") / Raw(load="X" * 5),
+        expected_mac_dst="02:00:00:00:00:02",
+    ),
+]
+
+JUMP_TEST_CASES: list[JumpTestCase] = [
+    JumpTestCase(
+        description="eth[src=02:00:00:00:00:00] -> jump -> ipv4[dst=192.168.1.2] -> queue 2",
+        group0_pattern="eth src is 02:00:00:00:00:00",
+        group1_pattern="ipv4 dst is 192.168.1.2",
+        group1_action="queue index 2",
+        matching_packet=(
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+            / IP(src="192.168.1.1", dst="192.168.1.2")
+            / UDP(sport=5000, dport=53)
+            / Raw(load="X" * 5)
+        ),
+        non_matching_packet=(
+            Ether(src="02:00:00:00:00:01", dst="02:00:00:00:00:02")
+            / IP(src="192.168.1.1", dst="192.168.1.2")
+            / UDP(sport=5000, dport=53)
+            / Raw(load="X" * 5)
+        ),
+        target_queue=2,
+    ),
+    JumpTestCase(
+        description="eth[dst=02:00:00:00:00:02] -> jump -> ipv4[src=192.168.1.1] -> queue 3",
+        group0_pattern="eth dst is 02:00:00:00:00:02",
+        group1_pattern="ipv4 src is 192.168.1.1",
+        group1_action="queue index 3",
+        matching_packet=(
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+            / IP(src="192.168.1.1", dst="192.168.1.2")
+            / UDP(sport=5000, dport=53)
+            / Raw(load="X" * 5)
+        ),
+        non_matching_packet=(
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:03")
+            / IP(src="192.168.1.1", dst="192.168.1.2")
+            / UDP(sport=5000, dport=53)
+            / Raw(load="X" * 5)
+        ),
+        target_queue=3,
+    ),
+    JumpTestCase(
+        description="ipv4[src=10.0.0.1] -> jump -> tcp[dst=443] -> queue 1",
+        group0_pattern="eth / ipv4 src is 10.0.0.1",
+        group1_pattern="ipv4 / tcp dst is 443",
+        group1_action="queue index 1",
+        matching_packet=(
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+            / IP(src="10.0.0.1", dst="10.0.0.2")
+            / TCP(sport=12345, dport=443)
+            / Raw(load="X" * 5)
+        ),
+        non_matching_packet=(
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+            / IP(src="10.0.0.99", dst="10.0.0.2")
+            / TCP(sport=12345, dport=443)
+            / Raw(load="X" * 5)
+        ),
+        target_queue=1,
+    ),
+    JumpTestCase(
+        description="ipv4[dst=172.16.0.1] -> jump -> udp[dst=123] -> queue 2",
+        group0_pattern="eth / ipv4 dst is 172.16.0.1",
+        group1_pattern="ipv4 / udp dst is 123",
+        group1_action="queue index 2",
+        matching_packet=(
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+            / IP(src="172.16.0.100", dst="172.16.0.1")
+            / UDP(sport=5000, dport=123)
+            / Raw(load="X" * 5)
+        ),
+        non_matching_packet=(
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+            / IP(src="172.16.0.100", dst="172.16.0.99")
+            / UDP(sport=5000, dport=123)
+            / Raw(load="X" * 5)
+        ),
+        target_queue=2,
+    ),
+    JumpTestCase(
+        description="eth[src=02:00:00:00:00:00] -> jump -> udp[dst=53] -> queue 3",
+        group0_pattern="eth src is 02:00:00:00:00:00",
+        group1_pattern="ipv4 / udp dst is 53",
+        group1_action="queue index 3",
+        matching_packet=(
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+            / IP(src="192.168.1.1", dst="192.168.1.2")
+            / UDP(sport=5000, dport=53)
+            / Raw(load="X" * 5)
+        ),
+        non_matching_packet=(
+            Ether(src="02:00:00:00:00:01", dst="02:00:00:00:00:02")
+            / IP(src="192.168.1.1", dst="192.168.1.2")
+            / UDP(sport=5000, dport=53)
+            / Raw(load="X" * 5)
+        ),
+        target_queue=3,
+    ),
+    JumpTestCase(
+        description="ipv4[tos=4] -> jump -> tcp[dst=80] -> queue 1",
+        group0_pattern="eth / ipv4 tos is 4",
+        group1_pattern="ipv4 / tcp dst is 80",
+        group1_action="queue index 1",
+        matching_packet=(
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+            / IP(src="10.0.0.1", dst="10.0.0.2", tos=4)
+            / TCP(sport=54321, dport=80)
+            / Raw(load="X" * 5)
+        ),
+        non_matching_packet=(
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:02")
+            / IP(src="10.0.0.1", dst="10.0.0.2", tos=0)
+            / TCP(sport=54321, dport=80)
+            / Raw(load="X" * 5)
+        ),
+        target_queue=1,
+    ),
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
-
-        Args:
-            verification_method: Callable that performs verification logic.
-            flows: List of flow rules to create and test.
-            packets: List of packets corresponding to each flow.
-            port_id: Number representing the port to create flows on.
-            expected_packets: List of packets to check sent packets against in modification cases.
-            *args: Additional positional arguments to pass to the verification method.
-            **kwargs: Additional keyword arguments to pass to the verification method.
+        protocol_stack: list[str],
+        all_field_values: dict[str, dict[str, Any]],
+        add_payload: bool = True,
+    ) -> Packet:
+        """Build a packet from multiple protocol layers.
+
+        Raises:
+            ValueError: If protocol_stack is empty.
         """
+        packet: Packet | None = None
 
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
+        for protocol_name in protocol_stack:
+            protocol_spec = self.protocols[protocol_name]
+            values = all_field_values.get(protocol_name, {})
+            layer = protocol_spec.build_scapy_layer(values)
 
-                try:
-                    flow_id = testpmd.flow_create(flow_rule=flow, port_id=port_id)
-                except InteractiveCommandExecutionError:
-                    log("Flow rule validation passed, but flow creation failed.")
-                    fail("Failed flow creation")
+            if packet is None:
+                packet = layer
+            else:
+                packet = packet / layer
 
-                if verification_method == self._send_packet_and_verify:
-                    verification_method(packet=packet, *args, **kwargs)
+        if add_payload:
+            packet = packet / Raw(load="X" * 5)
 
-                elif verification_method == self._send_packet_and_verify_queue:
-                    verification_method(
-                        packet=packet, test_queue=kwargs["test_queue"], testpmd=testpmd
-                    )
+        if packet is None:
+            raise ValueError("Protocol stack cannot be empty.")
 
-                elif verification_method == self._send_packet_and_verify_modification:
-                    verification_method(packet=packet, expected_packet=expected_packet)
+        return packet
 
-                testpmd.flow_delete(flow_id, port_id=port_id)
-
-    def _send_packet_and_verify(self, packet: Packet, should_receive: bool = True) -> None:
-        """Generate a packet, send to the DUT, and verify it is forwarded back.
+    def generate(
+        self,
+        protocol_stack: list[tuple[str, bool]],
+        action_name: str,
+        action_value: Any = None,
+        group_id: int = 0,
+    ) -> list[FlowTest]:
+        """Generate test cases for patterns matching fields across multiple protocols.
 
         Args:
-            packet: Scapy packet to send and verify.
-            should_receive: Indicate whether the packet should be received.
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
-        contains_packet = any(
-            packet.haslayer(Raw) and b"xxxxx" in packet.load for packet in received
-        )
-        verify(
-            should_receive == contains_packet,
-            f"Packet was {'dropped' if should_receive else 'received'}",
-        )
+        action_spec = self.actions[action_name]
 
-    def _send_packet_and_verify_queue(
-        self, packet: Packet, test_queue: int, testpmd: TestPmd
-    ) -> None:
-        """Send packet and verify queue stats show packet was received.
+        wildcard_protocols = [name for name, test_fields in protocol_stack if not test_fields]
+        field_test_protocols = [name for name, test_fields in protocol_stack if test_fields]
+        all_protocol_names = [name for name, _ in protocol_stack]
 
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
+        wildcard_pattern_parts = [self.protocols[name].pattern_name for name in wildcard_protocols]
 
-    def _send_packet_and_verify_modification(self, packet: Packet, expected_packet: Packet) -> None:
-        """Send packet and verify the expected modifications are present upon reception.
+        if not field_test_protocols:
+            pattern = " / ".join(wildcard_pattern_parts)
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
+                    description=" / ".join(wildcard_pattern_parts) + f" -> {action_spec.name}",
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
+                field_pattern_parts = []
+                all_field_values: dict[str, dict[str, Any]] = {}
+                desc_parts = []
+
+                for protocol_spec, field_spec in field_combo:
+                    val = field_spec.test_parameters[i % len(field_spec.test_parameters)]
+
+                    field_pattern_parts.append(
+                        f"{protocol_spec.pattern_name} {field_spec.pattern_field} is {val}"
+                    )
 
-        Args:
-            packet: Scapy packet to send to the SUT.
-            expected_packet: Scapy packet that should match the received packet.
-        """
-        received = send_packet_and_capture(packet)
+                    if protocol_spec.name not in all_field_values:
+                        all_field_values[protocol_spec.name] = {}
+                    all_field_values[protocol_spec.name][field_spec.scapy_field] = val
 
-        # verify reception
-        verify(received != [], "Packet was never received.")
+                    desc_parts.append(f"{protocol_spec.name}[{field_spec.scapy_field}={val}]")
 
-        log(f"SENT PACKET:     {packet.summary()}")
-        log(f"EXPECTED PACKET: {expected_packet.summary()}")
-        for packet in received:
-            log(f"RECEIVED PACKET: {packet.summary()}")
+                full_pattern = " / ".join(wildcard_pattern_parts + field_pattern_parts)
 
-        expected_ip_dst = expected_packet[IP].dst if IP in expected_packet else None
-        received_ip_dst = received[IP].dst if IP in received else None
+                flow_rule = FlowRule(
+                    direction="ingress",
+                    pattern=[full_pattern],
+                    actions=[action_spec.build_action_string(action_value)],
+                    group_id=group_id,
+                )
 
-        expected_mac_dst = expected_packet[Ether].dst if Ether in expected_packet else None
-        received_mac_dst = received[Ether].dst if Ether in received else None
+                packet = self._build_multi_layer_packet(
+                    all_protocol_names, all_field_values, add_payload=True
+                )
 
-        # verify modification
-        if expected_ip_dst is not None:
-            verify(
-                received_ip_dst == expected_ip_dst,
-                f"IPv4 dst mismatch: expected {expected_ip_dst}, got {received_ip_dst}",
-            )
+                wildcard_desc = " / ".join(wildcard_pattern_parts)
+                field_desc = " / ".join(desc_parts)
+                full_desc = f"{wildcard_desc} / {field_desc}" if wildcard_desc else field_desc
 
-        if expected_mac_dst is not None:
-            verify(
-                received_mac_dst == expected_mac_dst,
-                f"MAC dst mismatch: expected {expected_mac_dst}, got {received_mac_dst}",
-            )
+                test_cases.append(
+                    FlowTest(
+                        flow_rule=flow_rule,
+                        packet=packet,
+                        verification_type=action_spec.verification_type,
+                        verification_params=action_spec.build_verification_params(action_value),
+                        description=full_desc + f" -> {action_spec.name}",
+                    )
+                )
 
-    def _send_packet_and_verify_jump(
-        self,
-        packets: list[Packet],
-        flow_rules: list[FlowRule],
-        test_queues: list[int],
-        testpmd: TestPmd,
-    ) -> None:
-        """Create a testpmd session with every rule in the given list, verify jump behavior.
+        return test_cases
 
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
 
-    @func_test
-    def queue_action_ETH(self) -> None:
-        """Validate flow rules with queue actions and ethernet patterns.
+@requires_nic_capability(NicCapability.FLOW_CTRL)
+class TestRteFlow(TestSuite):
+    """RTE Flow test suite.
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+    This suite consists of 4 test cases:
+    1. Queue Action: Verifies queue actions with multi-protocol patterns
+    2. Drop Action: Verifies drop actions with multi-protocol patterns
+    3. Modify Field Action: Verifies modify_field actions with hardcoded patterns
+    4. Jump Action: Verifies jump action between flow groups
 
-        Verify:
-            * Each packet is received on the appropriate queue.
-        """
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
+    """
 
-    @func_test
-    def queue_action_IP(self) -> None:
-        """Validate flow rules with queue actions and IPv4/IPv6 patterns.
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
+    def _validate_and_create_flow(
+        self,
+        rule: FlowRule,
+        description: str,
+        testpmd: TestPmd,
+        port_id: int = 0,
+        sent_packet: Packet | None = None,
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
+        result = FlowTestResult(
+            description=description,
+            passed=False,
+            flow_rule_pattern=" / ".join(rule.pattern),
+            sent_packet=sent_packet,
         )
 
-    @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
-    @func_test
-    def queue_action_L4(self) -> None:
-        """Validate flow rules with queue actions and TCP/UDP patterns.
-
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
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
 
-        Verify:
-            * Each packet is received on the appropriate queue.
+        Args:
+            action_type: The action being tested ('drop', 'queue', 'modify').
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
+        non_matching_packet = (
+            Ether(src="02:00:00:00:00:00", dst="02:00:00:00:00:01")
+            / IP(src="192.168.100.1", dst="192.168.100.2")
+            / UDP(sport=9999, dport=9998)
+            / Raw(load="X" * 5)
         )
 
-    @func_test
-    def queue_action_VLAN(self) -> None:
-        """Validate flow rules with queue actions and VLAN patterns.
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
 
-    @func_test
-    def drop_action_ETH(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
+        log(f"Basic transmission check passed for '{action_type}' action")
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+    def _verify_queue(self, packet: Packet, queue_id: int, testpmd: TestPmd, **kwargs: Any) -> None:
+        """Verify packet is received on the expected queue."""
+        send_packet_and_capture(packet)
+        verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+        received_on_queue = any(p.queue_id == queue_id for p in verbose_output)
+        verify(received_on_queue, f"Packet not received on queue {queue_id}")
 
-        Verify:
-            * Packet is dropped.
+    def _verify_drop(self, packet: Packet, **kwargs: Any) -> None:
+        """Verify packet is dropped."""
+        received = send_packet_and_capture(packet)
+        contains_packet = any(p.haslayer(Raw) and b"XXXXX" in bytes(p[Raw].load) for p in received)
+        verify(not contains_packet, "Packet was not dropped")
 
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
 
-    @func_test
-    def drop_action_IP(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
+                try:
+                    verification_method = getattr(self, f"_verify_{test_case.verification_type}")
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+                    if test_case.verification_type == "queue":
+                        testpmd.set_verbose(level=8)
+                        testpmd.start()
 
-        Verify:
-            * Packet is dropped.
+                    verification_method(
+                        packet=test_case.packet,
+                        testpmd=testpmd,
+                        **test_case.verification_params,
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
+
+    # -------------------- Generator Test Cases --------------------
 
     @func_test
-    def drop_action_L4(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
+    def queue_action(self) -> None:
+        """Validate flow rules with queue actions and multi-protocol patterns.
 
         Steps:
+            * Run basic transmission check to verify baseline packet reception.
             * Create a list of packets to test, with a corresponding flow list.
             * Launch testpmd.
             * Create first flow rule in flow list.
@@ -518,50 +896,24 @@ def drop_action_L4(self) -> None:
             * Delete flow rule, repeat for all flows/packets.
 
         Verify:
-            * Packet is dropped.
-
-        One packet will be sent as a confidence check, to ensure packets are being
-        received under normal circumstances.
+            * Each packet is received on the appropriate queue.
         """
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
-    def drop_action_VLAN(self) -> None:
-        """Validate flow rules with drop actions and ethernet patterns.
+    def drop_action(self) -> None:
+        """Validate flow rules with drop actions and multi-protocol patterns.
 
         Steps:
+            * Run basic transmission check to verify packets are received without drop rules.
             * Create a list of packets to test, with a corresponding flow list.
             * Launch testpmd.
             * Create first flow rule in flow list.
@@ -570,228 +922,208 @@ def drop_action_VLAN(self) -> None:
 
         Verify:
             * Packet is dropped.
-
-        One packet will be sent as a confidence check, to ensure packets are being
-        received under normal circumstances.
         """
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
-    def modify_actions(self) -> None:
-        """Validate flow rules with actions that modify that packet during transmission.
+    def modify_field_action(self) -> None:
+        """Validate flow rules with modify_field actions and hardcoded patterns.
 
         Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+            * Run basic transmission check to verify packets arrive unmodified.
+            * For each test case in MODIFY_TEST_CASES, create the flow rule.
+            * Send the corresponding packet and capture the received packet.
+            * Verify the expected field was modified correctly.
+            * Delete the flow rule and repeat for all test cases.
 
         Verify:
-            * Verify packet is received with the new attributes.
+            * Each packet is modified correctly according to its action.
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
+        port_id = 0
+        self._verify_basic_transmission("modify")
 
-    @func_test
-    def egress_rules(self) -> None:
-        """Validate flow rules with egress directions.
+        with TestPmd(rx_queues=4, tx_queues=4) as testpmd:
+            for test_case in MODIFY_TEST_CASES:
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
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd.
-            * Create first flow rule in flow list.
-            * Send first packet in packet list, capture verbose output.
-            * Delete flow rule, repeat for all flows/packets.
+                try:
+                    testpmd.start()
+                    received = send_packet_and_capture(test_case.packet)
+                    testpmd.stop()
 
-        Verify:
-            * Packet is dropped.
+                    test_packet = next(
+                        (p for p in received if p.haslayer(Raw) and b"XXXXX" in bytes(p[Raw].load)),
+                        None,
+                    )
 
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
     def jump_action(self) -> None:
-        """Validate flow rules with different group levels and jump actions.
+        """Validate flow rules with jump action between groups.
 
-        Steps:
-            * Create a list of packets to test, with a corresponding flow list.
-            * Launch testpmd with the necessary configuration.
-            * Create each flow rule in testpmd.
-            * Send each packet in the list, check Rx queue ID.
-
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
-            )
+        The jump action redirects matched packets from one flow group to another.
+        Only flow rules in group 0 are guaranteed to be matched against initially;
+        subsequent groups can only be reached via jump actions.
 
-    @func_test
-    def priority_attribute(self) -> None:
-        """Validate flow rules with queue actions and ethernet patterns.
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
+            for test_case in JUMP_TEST_CASES:
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

