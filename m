Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A300C5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:04:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2C7A4026F;
	Tue, 11 Aug 2026 19:04:42 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 68EED4021E
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:04:41 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-52d58d7aad6so954441cf.2
 for <dev@dpdk.org>; Tue, 11 Aug 2026 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786467881; x=1787072681; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i8go8JxZxmWl2guyxhaPOQPZrEE/S6XV7mxeplDAM3Q=;
 b=cRH1/efjjJkWlqdz/9zRYlIrGs4B2nwGlAPmxwpDnoX7kxClaF8dyHgIIZp6C1BmIo
 8oytxydEmyCRuSOBNBhMayu5Nb+wwb/7AAQSKlZ2OmFuEXbD+uUuNTn6e3hwLnW7eo4q
 nMt5IoFo9B5eSYRK1mOy48BURielVqrxSPDKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786467881; x=1787072681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i8go8JxZxmWl2guyxhaPOQPZrEE/S6XV7mxeplDAM3Q=;
 b=KoTU2hHuWSDehMTTl/GKr8w/cF3VKtZN77AvIAypatzx5vWjanjFmJRiz3lOx7T9HO
 qOmb93t90mrqZGoD/8k+6JaI3LDkwYwFeIqmLsiPV5j5H+CtpqUMlfYqTTa4LXewB4HJ
 J3SJtBjDyyx1U3PgbAO+z5ucvoGEANGSnSvVoqlslpLOj5whllyLC1S8ZWS9COsaHqr/
 ghPMhAdWKKqof1t6YVEqBaYepdvaalPll8+rttoDkGq6+No2lXqGYkXFk3WEiWtAg00u
 Cc38A+gWeOg7EADYqueLz8C/0I4NqkqfG8txe2VijJNt9SQRquM51z+qdeYoHEq+auOT
 h8GA==
X-Gm-Message-State: AOJu0YwRvQx8ouHhJ3mtxOjDfgubJ3YnPNipy1qgkJBTxMrrnPTFQmrN
 GAQpXauR5W2ghzxtmOGU0a7TRapxt9zig/APQs51Y6ACrxZx2TmokrmoudRRr5FollhtFly+eLp
 QA/7AY4ndk5xNNNe7utDr5HFwN9aVZuuRnlh+YSjXaoIMIvPJPtnSyeXw2i3HVExhG2mygJDQGA
 lesaYW8tOUKua/WuHDaFPvwJxF0to=
X-Gm-Gg: AR+sD10mwaYEpl83uhNjSXvy43YYwGF4iYwwWFtOUcKcHj1M7lVkB2bRg63vpW2d4NS
 80edW1lR50sdfG9HHZ7VBOP9HnhZm+fOhIeHxGdK06c6mwIDw+qnzam37pt0DFXf6HfKBe35Xlk
 K+da3zzDKhZ/QzPk1qMWAUBk11/vdtm4ETCOFrzH6dj7ZwOcrk6kxu5cZHBL5N/SFE1IZh9y/uj
 VnHrPeLAwVai+za6eDNiwfW2p0+TYa6pqhM36O+FiUPIo2HO6oM+2/M2AJ+MrzWu9wUS2ueTNdr
 sbtUtbxFuMA07hFhNPL4tiEyBFIYY6D0n2PiotGf3ehYHIuwxkL6jkGTrCRq7zVnDqS9QazExHL
 h+gxPzPLc04X6w7f9Gqk8RYN8Tz494Ch/sRLxhnpDrtLARR42BEhoVoHNjqdmailkih8LHn3o/3
 g9NxeX4MVHILIX8dbSOKepndX7kKZNvC0tym74drZ5QaIldCeWWZnaBK6ArJp631mJJyy+JwL3N
 ObaqEGFZqhek/xx
X-Received: by 2002:a05:622a:2281:b0:51c:b6d:740b with SMTP id
 d75a77b69052e-52d6024a01cmr18739171cf.34.1786467880571; 
 Tue, 11 Aug 2026 10:04:40 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c2cf030sm3399446d6.22.2026.08.11.10.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:04:39 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v7] dts: refactor flow suite with generator pattern
Date: Tue, 11 Aug 2026 13:04:33 -0400
Message-ID: <20260811170433.517663-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
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

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---

v7:
 * Resolve merge conflicts.
 dts/tests/TestSuite_flow_offload.py | 206 ++++++++++++++++++++++++----
 1 file changed, 182 insertions(+), 24 deletions(-)

diff --git a/dts/tests/TestSuite_flow_offload.py b/dts/tests/TestSuite_flow_offload.py
index be11d09875..d1a6c2fa74 100644
--- a/dts/tests/TestSuite_flow_offload.py
+++ b/dts/tests/TestSuite_flow_offload.py
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2025 University of New Hampshire

-"""RTE Flow testing suite.
+"""Flow offload testing suite.

 This suite verifies a range of flow rules built using patterns
 and actions from the RTE Flow API. It would be impossible to cover
@@ -10,7 +10,7 @@

 """

-from dataclasses import dataclass
+from dataclasses import dataclass, field
 from itertools import product
 from typing import Any, Callable, Optional

@@ -18,6 +18,7 @@
 from scapy.layers.inet6 import IPv6
 from scapy.layers.l2 import ARP, Dot1Q, Ether
 from scapy.layers.sctp import SCTP
+from scapy.layers.vxlan import VXLAN
 from scapy.packet import Packet, Raw

 from api.capabilities import NicCapability, requires_nic_capability
@@ -50,10 +51,16 @@ class Protocol:
     scapy_class: type[Packet]
     pattern_name: str
     fields: list[PatternField]
+    default_values: dict[str, Any] = field(default_factory=dict)

     def build_scapy_layer(self, field_values: dict[str, Any]) -> Packet:
-        """Construct a Scapy layer with the given field values."""
-        return self.scapy_class(**field_values)
+        """Construct a Scapy layer with the given field values.
+
+        Default values are applied first, then overridden by any
+        explicit field values so test parameters always win.
+        """
+        merged = {**self.default_values, **field_values}
+        return self.scapy_class(**merged)


 @dataclass
@@ -125,6 +132,7 @@ class JumpTest:


 PROTOCOLS: dict[str, Protocol] = {
+    # -------------------- Base Protocols --------------------
     "eth": Protocol(
         name="eth",
         scapy_class=Ether,
@@ -215,6 +223,89 @@ class JumpTest:
             PatternField("op", "opcode", [1, 2]),
         ],
     ),
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
 }


@@ -234,6 +325,7 @@ class JumpTest:
 }

 PROTOCOL_STACKS = [
+    # -------------------- Non-tunnel stacks --------------------
     [("eth", True)],
     [("eth", False), ("ipv4", True)],
     [("eth", False), ("ipv4", True), ("tcp", True)],
@@ -253,6 +345,66 @@ class JumpTest:
     [("eth", False), ("vlan", False), ("ipv6", True), ("tcp", True)],
     [("eth", False), ("vlan", False), ("ipv6", True), ("udp", True)],
     [("eth", False), ("arp", True)],
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
 ]


@@ -304,6 +456,10 @@ def generate(
     ) -> list[FlowTest]:
         """Generate test cases for patterns matching fields across multiple protocols.

+        Pattern parts are assembled in stack order to preserve positional
+        correctness, which is required for tunnel encapsulations where
+        inner and outer layers share the same pattern_name.
+
         Args:
             protocol_stack: List of (protocol_name, test_fields) tuples.
                 If test_fields is True, iterate through field combinations.
@@ -316,15 +472,12 @@ def generate(
             List of FlowTest objects ready for execution.
         """
         action_spec = self.actions[action_name]
-
-        wildcard_protocols = [name for name, test_fields in protocol_stack if not test_fields]
-        field_test_protocols = [name for name, test_fields in protocol_stack if test_fields]
         all_protocol_names = [name for name, _ in protocol_stack]
-
-        wildcard_pattern_parts = [self.protocols[name].pattern_name for name in wildcard_protocols]
+        field_test_protocols = [name for name, test_fields in protocol_stack if test_fields]

         if not field_test_protocols:
-            pattern = " / ".join(wildcard_pattern_parts)
+            pattern_parts = [self.protocols[name].pattern_name for name, _ in protocol_stack]
+            pattern = " / ".join(pattern_parts)
             flow_rule = FlowRule(
                 direction="ingress",
                 pattern=[pattern],
@@ -339,7 +492,7 @@ def generate(
                     packet=packet,
                     verification_type=action_spec.verification_type,
                     verification_params=action_spec.build_verification_params(action_value),
-                    description=" / ".join(wildcard_pattern_parts) + f" -> {action_spec.name}",
+                    description=pattern + f" -> {action_spec.name}",
                 )
             ]

@@ -354,24 +507,32 @@ def generate(
             max_vals = max(len(f_spec.test_parameters) for _, f_spec in field_combo)

             for i in range(max_vals):
-                field_pattern_parts = []
+                field_value_map: dict[str, tuple[Protocol, PatternField, Any]] = {}
                 all_field_values: dict[str, dict[str, Any]] = {}
-                desc_parts = []

                 for protocol_spec, field_spec in field_combo:
                     val = field_spec.test_parameters[i % len(field_spec.test_parameters)]
-
-                    field_pattern_parts.append(
-                        f"{protocol_spec.pattern_name} {field_spec.pattern_field} is {val}"
-                    )
+                    field_value_map[protocol_spec.name] = (protocol_spec, field_spec, val)

                     if protocol_spec.name not in all_field_values:
                         all_field_values[protocol_spec.name] = {}
                     all_field_values[protocol_spec.name][field_spec.scapy_field] = val

-                    desc_parts.append(f"{protocol_spec.name}[{field_spec.scapy_field}={val}]")
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

-                full_pattern = " / ".join(wildcard_pattern_parts + field_pattern_parts)
+                full_pattern = " / ".join(pattern_parts)

                 flow_rule = FlowRule(
                     direction="ingress",
@@ -384,10 +545,7 @@ def generate(
                     all_protocol_names, all_field_values, add_payload=True
                 )

-                wildcard_desc = " / ".join(wildcard_pattern_parts)
-                field_desc = " / ".join(desc_parts)
-                full_desc = f"{wildcard_desc} / {field_desc}" if wildcard_desc else field_desc
-
+                full_desc = " / ".join(desc_parts)
                 test_cases.append(
                     FlowTest(
                         flow_rule=flow_rule,
@@ -403,7 +561,7 @@ def generate(

 @requires_nic_capability(NicCapability.FLOW_CTRL)
 class TestFlowOffload(TestSuite):
-    """Flow offload test suite.
+    """Flow Offload test suite.

     This suite consists of 4 test cases:
     1. Queue Action: Verifies queue actions with multi-protocol patterns
--
2.55.0

