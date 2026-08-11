Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC35EC5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 15:55:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53F9241153;
	Tue, 11 Aug 2026 17:55:13 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 0B46241140
 for <dev@dpdk.org>; Tue, 11 Aug 2026 17:55:11 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-9063b380982so34711026d6.0
 for <dev@dpdk.org>; Tue, 11 Aug 2026 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786463710; x=1787068510; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sTW4zfc7mTD4TrrMDczo6NgbMJqhdfRn20gSFq5Xct8=;
 b=ZvV/oTuIbbLUFVh7e9nGDLL8zFicnGuWD4FskBW0zwfXVHvYLoPxFAKO1Q7aNs4hwS
 j6t4Z0j7pji9WU7c/XXHNkfEPX82YlN6u51eNRUq0RVjPd1mXBHXfLgJ+mJ4QYrvW7eM
 uwXhYdmbp2/OYb6VkmkKrSorgDP5X1cl9RIug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463710; x=1787068510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sTW4zfc7mTD4TrrMDczo6NgbMJqhdfRn20gSFq5Xct8=;
 b=TTofZaqQYKvpdwG65zkgEbm7QZRqHlbHDcmGnnI1uOBohH8vNWhu+87Y4AxGgdmC4A
 ttvdEz2xqoiej8+uhq2PGmEQ8l9wpMvJK9DxcMWWfXvIjfbue+b+Qr4yfmNfPXmmCiVc
 wV7P75VvbH4BrB1eAs7iD//Rnu80+Iw2mbTXTI4J7Rg7GHvmtiBQS+YrdG1efk5ZKBD+
 APYDzmwV4QHafsuS9bBnaK5c/6CHwgrAqvTvpdTsCT+czy7yE1/DKwBwrYKCXVb0xABn
 0DDj73dptKO+Dpt0fOwUiZZio+qJ/eM0sIMQz5C+9mymjLKW2QmEbH2NvXyVC57Hox5n
 1VLw==
X-Gm-Message-State: AOJu0YzJOfPS2x7CvyINHW4FyKJGxxa1v+lV8KJ9CMTLdx6n4yXBG9zF
 Kxg/E/fwXLgUyb2INOg9fj/fc3Y5leozRIiXQwwz+xCzzPTodq+HjDluT/JksgTBk+Vw7Fyj1p6
 TaVurejyWIEbV4334+SPNmyBc4qN8YOnphzm9D6wUxl0TI7+ez8tjcd8AuiDRWhWe5DsCvedHoa
 BKi5HlxCQwea57Rx0fQaqLhH5IRBQ=
X-Gm-Gg: AR+sD11K8w0wbHs40jDJc8HDuVsUgJRUjL4CxTHkfQwIaEpSPU6gLU6oD6l+Oo1TKkp
 fmhQfEDSRpi1sLZjqG+tHMx7CKYzO2TBY//64aoH+iSwefOaQhjvKbv3QKwKQL4Pc4QNmIv53AN
 YSQBN8opUna1KltXkmbKS9oIgtjgdSy2+TjFinZpqDrv4hnn8SKdfpZnqldTxvhkjD0LoURkNOi
 rf+A0HbUDlrQjxmaNj8Jj7E6Mr4MqMIQbElEnlnSet5pUYAigKHLe5YZv8PJ+l+CKPsm212p4q9
 +3FD04ukqZ8+qTF6b+k5rKQ0qgwxfnre+02faGKDHS1kTvwzRvaZ6AnD+k9NssK3ARN2brpokqh
 REnbZZ81AI02EqgGGgBAg8iRkdQRZseqwd7SENMmGGXiazDgsSzeEfIYHNeG5SA+4jyV3gbiTib
 iR2zbO5pbuLCQmS+oVDmgcTA1XOLPzh4beL5c9z+p4V0IsBjLAQ8EL+ulFXIOi4emaf1bxZurYD
 fEPesOFAKnwjiYzFzNShQ==
X-Received: by 2002:a05:6214:c8d:b0:8e5:d7d1:7bf with SMTP id
 6a1803df08f44-90a669419aemr41472436d6.4.1786463710290; 
 Tue, 11 Aug 2026 08:55:10 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c29fe59sm2120326d6.15.2026.08.11.08.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:55:09 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dean Marx <dmarx@iol.unh.edu>, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: add VXLAN protocols to flow test suite
Date: Tue, 11 Aug 2026 11:54:50 -0400
Message-ID: <20260811155450.486646-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155450.486646-1-abailey@iol.unh.edu>
References: <20260811155450.486646-1-abailey@iol.unh.edu>
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

From: Dean Marx <dmarx@iol.unh.edu>

Add VXLAN protocol stacks to the list of test stacks
in the rte_flow test suite. Refactor the generator
to properly construct VXLAN flows and packets.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/tests/TestSuite_flow_offload.py | 202 +++++++++++++++++++++++++---
 1 file changed, 180 insertions(+), 22 deletions(-)

diff --git a/dts/tests/TestSuite_flow_offload.py b/dts/tests/TestSuite_flow_offload.py
index be11d09875..6fe45c9894 100644
--- a/dts/tests/TestSuite_flow_offload.py
+++ b/dts/tests/TestSuite_flow_offload.py
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
2.55.0

