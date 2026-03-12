Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BFB106ACE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 20:35:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E50444060B;
	Thu, 12 Mar 2026 21:35:53 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 55617402DF
 for <dev@dpdk.org>; Thu, 12 Mar 2026 21:35:53 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8cd8d97aa2eso185230885a.3
 for <dev@dpdk.org>; Thu, 12 Mar 2026 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773347752; x=1773952552; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfRa+3TpGOgEMiDr6TtmRe0jvvb2DFahGo393ta/BAM=;
 b=jDmYoTo2tr6+8zrZAQE2iIF8LqXnDlV/MtTHRSWzTUdWlirSkyfnkhgVqtY0692PdN
 ZMBmZWExM+Xru2zapRY4YCat2TeT2lrj71cb3tt8dMv7vrzeHDbYSrvt6P3DCkcyDg++
 N2ZmkBP/rkWr5VpVQmXIe/ig2k5pksGO8Lkqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773347752; x=1773952552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zfRa+3TpGOgEMiDr6TtmRe0jvvb2DFahGo393ta/BAM=;
 b=w1/o4ucOSnJFWNSb3RZ2zDk+aspSm84kfkLC+A1DmOqWs6A2+4//PN7DH5HOgl0Qwk
 dYUbMxQ7bTdMdzOURqzEQOYSPtmbNbipJn8Yz7PCmdhXSE8XLU47mi49aSQHXQGnEtQW
 VnFhXYqdgjWPn5AaDQGXprTK9Iq2s2nZmHKcnLwV6QuEsvnOZyA0z7OgPrELqbWa8Pez
 97BRSS5tRYz81I86oGqt/SKobJ/ePfsG1Eef4HqJy2696osek1HBfu1jwJHozHzOCuAP
 CpbzEQXfqIeaCV/3VXa5LsJYnEGxbWU60zssnV4v21VYIRKadBY1l4IQWVTLVTfq7art
 rKtA==
X-Gm-Message-State: AOJu0Yy19HtJV1k+X1KSKDEoYPRIV7tOcQcrTkrR37DpvFFQSLVU9xPy
 HnO68unRwz2rf68DSY+t6+8wMXNC3tGIEUTfHlBmswKuWmxuKEcU7phLsUbaOYRtzc8wxHH1kzm
 o4BBK
X-Gm-Gg: ATEYQzxsUMY1TJkTkJQtrioKY51nnLm6kloAjrH4tyQblI6Au/gCm0CagFc5NggXCSi
 GSITX6863GpIv5JCAHSXAD3rHLod8ZOgqY7zqfoIC3SXVMtJmigL+x5R9gfJT0tXinGKvjAJGI4
 JNJJTtPHBP7W1Ab7Z9YHVnqbQpAiQrsHlNi5DemTnZQyERNKEVbXRhOn3gF/Fvt30SlPTIDcfV+
 KRYUk2iWc7i/t56COVuZDqcsZsVNkh5H0svdEscak3gReVcp4aJ9jHUFx8b+OieHrnwqN6qBJbv
 fA0cLQahiuTHRR5vMA+OUbL57nUesR7JMiHDkXEhGR0sndnqFiOQLq2U+23+eUljL+jv72NsJgw
 0PjZBY771hIaWrgVK3Z07ui9BMISygQWA8gYmvSQXXKUadg/TrWisqU306/IuPrInsXGg+805dY
 K8CUig/mdQ4jidssOgrbG5NKV7mG9ukyJy7iH9YcYIQdy96/d/tBhTstt2h3YURw==
X-Received: by 2002:a05:620a:4005:b0:8cd:942e:82e6 with SMTP id
 af79cd13be357-8cdb5a7b3edmr167650785a.18.1773347752593; 
 Thu, 12 Mar 2026 13:35:52 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda1fddfe8sm406560685a.12.2026.03.12.13.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 13:35:52 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v7 2/2] dts: add VXLAN protocols to flow test suite
Date: Thu, 12 Mar 2026 16:35:48 -0400
Message-ID: <20260312203548.96081-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312203548.96081-1-dmarx@iol.unh.edu>
References: <20260312203548.96081-1-dmarx@iol.unh.edu>
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

Add VXLAN protocol stacks to the list of test stacks
in the rte_flow test suite. Refactor the generator
to properly construct VXLAN flows and packets.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_rte_flow.py | 202 ++++++++++++++++++++++++++++----
 1 file changed, 180 insertions(+), 22 deletions(-)

diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 6255e4c36d..eef804e9d2 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
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
-- 
2.52.0

