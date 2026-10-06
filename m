Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11541CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 19:55:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A9A440268;
	Tue,  6 Oct 2026 21:55:59 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 7140A40151
 for <dev@dpdk.org>; Tue,  6 Oct 2026 21:55:58 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-487048857f6so901703f8f.3
 for <dev@dpdk.org>; Tue, 06 Oct 2026 12:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791316558; cv=none;
 d=google.com; s=arc-20260327;
 b=b6gKhcbdRtrCqs3ZmmEm0A6DCy27QnGZfFIDf9cnvFmRNvLHhXl+riBjFzCsXCutgU
 A5/WsI+CJOVsf/jms4CeJgcdfCi37n1StCnXit+ys0LijFaPFw3CDup/zDdA0F+9rYin
 3du+UDj3ppXUHT8APwBVw5QHRQ+9TxNdtStGwLl+53bUSF5256RpJZtzXwleQtwckacY
 a9T74t9HHEthBxExZy6HSFpRtHiS3vHbCdE1Y8vSapt0PIqcsLfkBX8yY/ujRvrdpAZN
 BWyua5A18o3waLUSLAA21ePkuKvJ5T+vumzWZvtM/LImY0e/mv/XdMfCJ6PM19RJOBQ6
 MgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O9/swGFWNCCpuvfv0laBFH+u5+1pWITbDOHSEmKPivY=;
 fh=GHjdUFcx1RHQATejb8mVRJu/d5ZArzXlhSrB6v3uHjg=;
 b=skOXAJsNEYPHBN7wSC/Jjc8e80ysI27yvMzrHPwQPzMoI/upJpR0rVj8I6LcvOUiru
 WcBnphl/cG7N9gZNlqTPtch6+hXJUdgXevhjJzsHwnNTpx5PonS8uKD8Eevp2SrHFC/o
 1jXBNPm/peOzstMrg8uOG/HiaPEXlZkEYQlM3BfGC1ZK5vSiNfi5ghcytSlS1CiBgDTG
 Q/xSkdc7HLhns6F8Dfqf4aFMs104IabI0yAhXFtsK8y6NXOrzbVKYBaAOgFMb4+BTQeA
 blmmUnMkAStFaRznDJ2dYzBsf/x3rFp2PYbJwv37rT1vg2iP1BD6N1ETscV7cR0M+Mg8
 H4Dw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791316558; x=1791921358; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O9/swGFWNCCpuvfv0laBFH+u5+1pWITbDOHSEmKPivY=;
 b=q+nffLHyxgP/y1iDMnBFjrB8S5msvSjZr+wIvZ1Uj6f+gRe92eGA3m7P3u6E71qoyf
 cr/xJ01hNGpxmFfW3J7MREDXXK/KLv1BhJlWwyFRqcT3nZFKiLCQ3zVkdW+wcfeFTwaj
 RX1EDf0NzWp2eUnnFLYdcTHs10D8anCn1zsHYEWPBI7L2OplaB7yHQPK/cGtSMXEopLB
 tBQezOHny0UYqr8d0H3rHGX1y7sk9Vpah803LWwCZLx+QXnuLK3K13IiKY63Wl/JuY1o
 h+W66IeOT+Q4JGtWd/OKurVCJ0Skxt5jtfznEEjBLJosUnYNcClsTqx9vrkVvBHe5MY0
 9l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791316558; x=1791921358;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O9/swGFWNCCpuvfv0laBFH+u5+1pWITbDOHSEmKPivY=;
 b=gwYLm+BpvHvYoliLy1TaLs98edVcuyyNF6/xOR/AIfRIG98NOBWIia99BI/ee3HqGl
 fNJ8OLfTUoQVAS+0UGOsR1tLGaPltYAKJEM2ew7ZAmeqBDFs9laFpLwhIvfRF+8zHg+6
 i/8HhGqJBYMfNVOQw6cUHydS4xyseZ4eyNAmFyfsQD23A1xwQfeJbgD0rLdTMZ4MQ0f/
 Im8kau0wwl1RmSWwiSBx9GJIUrCKmuoh0Qnmpv0wQ8Gflr4FCFUFrePWdleIqFljVPPX
 NCXknzyvervivobjrL7dGK+3MJf38L5SXR6IpXfMfTXzg4zdycq78rUw20QyyY2hXfs1
 WjEg==
X-Gm-Message-State: AFq9FYIN2TiiX0xJ+XbPuJOgdp57inFo7hhmejehYtV3PybB1olvQR4D
 HOKWL0fGxgdh6XuzYvV9vxtU0gfkEfkaMIrm3Iy0FR5SSabW7/UBpAY5A4XVozKlgyJ4W1ZGHnf
 blkxYmGF9x1dWswOrCqG3L3rYmoulzKU=
X-Gm-Gg: AYBFou0tc8zGxBquxO8pyb3GZJNEotNhl1/w92WS/d0bT1gnAw3G0OBMfUhmxoO1fTP
 8hWm0mclLPqTfm4G1G8Yos8pfhpUiWxgZeM8pTpjOhsQnfHKuCL8OIygFzFw5FipE7xSpR/ar5L
 9dKvvlZKWmiFSzWH4HlMxdIMtVckzFB8ibQ5Z58TC4VgoObey21ye1TdCnzgcAA3345PqRQHBEl
 Vlmp1fcaKEY/0N7NorXrlX4BJvqMlFOUQqbM9V32oLaTfLFnJU+UM2PZjLM8fJ9SlfRrArEZqBq
 BahiOeCldLzCtXviGc+SZLiH2PdgrNSj5KvY8/QkpRh7oVD9W3fSbFmHNq1FQJQlvfw/FbSsua9
 +inn6xlblflsNHW/6Wopd13pgr5W1OLUSpHlSkr/5Rq3f5VI=
X-Received: by 2002:a05:6000:61e:b0:48c:4d74:d7d2 with SMTP id
 ffacd0b85a97d-48c727797b7mr771088f8f.12.1791316557781; Tue, 06 Oct 2026
 12:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260811170433.517663-1-abailey@iol.unh.edu>
In-Reply-To: <20260811170433.517663-1-abailey@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Tue, 6 Oct 2026 15:55:44 -0400
X-Gm-Features: AclHuK9xo-_DNwgeOCZOC8gyVNnOxb8xyR785z1UDrrZgPq27UD4mG93QCJ_X0U
Message-ID: <CAK6DuxtfZ_Rv-Rxavd9GtpOpDvayV_sYS0K3g5qd6XE4V0zQKQ@mail.gmail.com>
Subject: Re: [PATCH v7] dts: refactor flow suite with generator pattern
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, knimoji@iol.unh.edu, 
 lylavoie@iol.unh.edu, dladd@iol.unh.edu, Dean Marx <dmarx@iol.unh.edu>, 
 Patrick Robb <probb@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000001b6115065d316348"
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

--0000000000001b6115065d316348
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will test this tonight.

What do we have right now in terms of DTS dev systems and NICs for non-iol
people like me. Is it still:

iol-dts-tester

And

iol-dts-dut

With mlnx cx5 and intel xl710?

Just checking in.

On Tue, Aug 11, 2026 at 1:04=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Refactor current flow test suite to utilize a generator
> method, which dynamically creates flow rules from a
> dictionary of pattern and action fields during runtime.
> This allows for much more extensive testing of the flow
> API without exponential code growth.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> ---
>
> v7:
>  * Resolve merge conflicts.
>  dts/tests/TestSuite_flow_offload.py | 206 ++++++++++++++++++++++++----
>  1 file changed, 182 insertions(+), 24 deletions(-)
>
> diff --git a/dts/tests/TestSuite_flow_offload.py
> b/dts/tests/TestSuite_flow_offload.py
> index be11d09875..d1a6c2fa74 100644
> --- a/dts/tests/TestSuite_flow_offload.py
> +++ b/dts/tests/TestSuite_flow_offload.py
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2025 University of New Hampshire
>
> -"""RTE Flow testing suite.
> +"""Flow offload testing suite.
>
>  This suite verifies a range of flow rules built using patterns
>  and actions from the RTE Flow API. It would be impossible to cover
> @@ -10,7 +10,7 @@
>
>  """
>
> -from dataclasses import dataclass
> +from dataclasses import dataclass, field
>  from itertools import product
>  from typing import Any, Callable, Optional
>
> @@ -18,6 +18,7 @@
>  from scapy.layers.inet6 import IPv6
>  from scapy.layers.l2 import ARP, Dot1Q, Ether
>  from scapy.layers.sctp import SCTP
> +from scapy.layers.vxlan import VXLAN
>  from scapy.packet import Packet, Raw
>
>  from api.capabilities import NicCapability, requires_nic_capability
> @@ -50,10 +51,16 @@ class Protocol:
>      scapy_class: type[Packet]
>      pattern_name: str
>      fields: list[PatternField]
> +    default_values: dict[str, Any] =3D field(default_factory=3Ddict)
>
>      def build_scapy_layer(self, field_values: dict[str, Any]) -> Packet:
> -        """Construct a Scapy layer with the given field values."""
> -        return self.scapy_class(**field_values)
> +        """Construct a Scapy layer with the given field values.
> +
> +        Default values are applied first, then overridden by any
> +        explicit field values so test parameters always win.
> +        """
> +        merged =3D {**self.default_values, **field_values}
> +        return self.scapy_class(**merged)
>
>
>  @dataclass
> @@ -125,6 +132,7 @@ class JumpTest:
>
>
>  PROTOCOLS: dict[str, Protocol] =3D {
> +    # -------------------- Base Protocols --------------------
>      "eth": Protocol(
>          name=3D"eth",
>          scapy_class=3DEther,
> @@ -215,6 +223,89 @@ class JumpTest:
>              PatternField("op", "opcode", [1, 2]),
>          ],
>      ),
> +    # -------------------- VXLAN Outer Protocols --------------------
> +    "eth_outer": Protocol(
> +        name=3D"eth_outer",
> +        scapy_class=3DEther,
> +        pattern_name=3D"eth",
> +        fields=3D[
> +            PatternField("src", "src", ["02:00:00:00:00:00"]),
> +            PatternField("dst", "dst", ["02:00:00:00:00:02"]),
> +        ],
> +    ),
> +    "ipv4_outer": Protocol(
> +        name=3D"ipv4_outer",
> +        scapy_class=3DIP,
> +        pattern_name=3D"ipv4",
> +        fields=3D[
> +            PatternField("src", "src", ["10.0.0.1"]),
> +            PatternField("dst", "dst", ["10.0.0.2"]),
> +            PatternField("ttl", "ttl", [64, 128]),
> +            PatternField("tos", "tos", [0, 4]),
> +        ],
> +    ),
> +    "udp_outer": Protocol(
> +        name=3D"udp_outer",
> +        scapy_class=3DUDP,
> +        pattern_name=3D"udp",
> +        fields=3D[],
> +        default_values=3D{"dport": 4789},
> +    ),
> +    # -------------------- VXLAN Tunnel Header --------------------
> +    "vxlan": Protocol(
> +        name=3D"vxlan",
> +        scapy_class=3DVXLAN,
> +        pattern_name=3D"vxlan",
> +        fields=3D[
> +            PatternField("vni", "vni", [42, 100]),
> +        ],
> +    ),
> +    # -------------------- VXLAN Inner Protocols --------------------
> +    "eth_inner": Protocol(
> +        name=3D"eth_inner",
> +        scapy_class=3DEther,
> +        pattern_name=3D"eth",
> +        fields=3D[
> +            PatternField("src", "src", ["02:00:00:00:00:00"]),
> +            PatternField("dst", "dst", ["02:00:00:00:00:02"]),
> +        ],
> +    ),
> +    "ipv4_inner": Protocol(
> +        name=3D"ipv4_inner",
> +        scapy_class=3DIP,
> +        pattern_name=3D"ipv4",
> +        fields=3D[
> +            PatternField("src", "src", ["192.168.1.1"]),
> +            PatternField("dst", "dst", ["192.168.1.2"]),
> +        ],
> +    ),
> +    "ipv6_inner": Protocol(
> +        name=3D"ipv6_inner",
> +        scapy_class=3DIPv6,
> +        pattern_name=3D"ipv6",
> +        fields=3D[
> +            PatternField("src", "src", ["2001:db8::1"]),
> +            PatternField("dst", "dst", ["2001:db8::2"]),
> +        ],
> +    ),
> +    "tcp_inner": Protocol(
> +        name=3D"tcp_inner",
> +        scapy_class=3DTCP,
> +        pattern_name=3D"tcp",
> +        fields=3D[
> +            PatternField("sport", "src", [1234]),
> +            PatternField("dport", "dst", [80]),
> +        ],
> +    ),
> +    "udp_inner": Protocol(
> +        name=3D"udp_inner",
> +        scapy_class=3DUDP,
> +        pattern_name=3D"udp",
> +        fields=3D[
> +            PatternField("sport", "src", [5000]),
> +            PatternField("dport", "dst", [53]),
> +        ],
> +    ),
>  }
>
>
> @@ -234,6 +325,7 @@ class JumpTest:
>  }
>
>  PROTOCOL_STACKS =3D [
> +    # -------------------- Non-tunnel stacks --------------------
>      [("eth", True)],
>      [("eth", False), ("ipv4", True)],
>      [("eth", False), ("ipv4", True), ("tcp", True)],
> @@ -253,6 +345,66 @@ class JumpTest:
>      [("eth", False), ("vlan", False), ("ipv6", True), ("tcp", True)],
>      [("eth", False), ("vlan", False), ("ipv6", True), ("udp", True)],
>      [("eth", False), ("arp", True)],
> +    # -------------------- VXLAN tunnel stacks --------------------
> +    [
> +        ("eth_outer", False),
> +        ("ipv4_outer", True),
> +        ("udp_outer", False),
> +        ("vxlan", True),
> +        ("eth_inner", False),
> +        ("ipv4_inner", False),
> +    ],
> +    [
> +        ("eth_outer", False),
> +        ("ipv4_outer", True),
> +        ("udp_outer", False),
> +        ("vxlan", True),
> +        ("eth_inner", False),
> +        ("ipv4_inner", False),
> +        ("tcp_inner", False),
> +    ],
> +    [
> +        ("eth_outer", False),
> +        ("ipv4_outer", True),
> +        ("udp_outer", False),
> +        ("vxlan", True),
> +        ("eth_inner", False),
> +        ("ipv4_inner", False),
> +        ("udp_inner", False),
> +    ],
> +    [
> +        ("eth_outer", False),
> +        ("ipv4_outer", True),
> +        ("udp_outer", False),
> +        ("vxlan", True),
> +        ("eth_inner", False),
> +        ("ipv6_inner", False),
> +    ],
> +    [
> +        ("eth_outer", False),
> +        ("ipv4_outer", True),
> +        ("udp_outer", False),
> +        ("vxlan", True),
> +        ("eth_inner", False),
> +        ("ipv6_inner", False),
> +        ("tcp_inner", False),
> +    ],
> +    [
> +        ("eth_outer", False),
> +        ("ipv4_outer", True),
> +        ("udp_outer", False),
> +        ("vxlan", True),
> +        ("eth_inner", False),
> +        ("ipv6_inner", False),
> +        ("udp_inner", False),
> +    ],
> +    [
> +        ("eth_outer", False),
> +        ("ipv4_outer", True),
> +        ("udp_outer", False),
> +        ("vxlan", True),
> +        ("eth_inner", False),
> +    ],
>  ]
>
>
> @@ -304,6 +456,10 @@ def generate(
>      ) -> list[FlowTest]:
>          """Generate test cases for patterns matching fields across
> multiple protocols.
>
> +        Pattern parts are assembled in stack order to preserve positiona=
l
> +        correctness, which is required for tunnel encapsulations where
> +        inner and outer layers share the same pattern_name.
> +
>          Args:
>              protocol_stack: List of (protocol_name, test_fields) tuples.
>                  If test_fields is True, iterate through field
> combinations.
> @@ -316,15 +472,12 @@ def generate(
>              List of FlowTest objects ready for execution.
>          """
>          action_spec =3D self.actions[action_name]
> -
> -        wildcard_protocols =3D [name for name, test_fields in
> protocol_stack if not test_fields]
> -        field_test_protocols =3D [name for name, test_fields in
> protocol_stack if test_fields]
>          all_protocol_names =3D [name for name, _ in protocol_stack]
> -
> -        wildcard_pattern_parts =3D [self.protocols[name].pattern_name fo=
r
> name in wildcard_protocols]
> +        field_test_protocols =3D [name for name, test_fields in
> protocol_stack if test_fields]
>
>          if not field_test_protocols:
> -            pattern =3D " / ".join(wildcard_pattern_parts)
> +            pattern_parts =3D [self.protocols[name].pattern_name for nam=
e,
> _ in protocol_stack]
> +            pattern =3D " / ".join(pattern_parts)
>              flow_rule =3D FlowRule(
>                  direction=3D"ingress",
>                  pattern=3D[pattern],
> @@ -339,7 +492,7 @@ def generate(
>                      packet=3Dpacket,
>                      verification_type=3Daction_spec.verification_type,
>
>  verification_params=3Daction_spec.build_verification_params(action_value=
),
> -                    description=3D" / ".join(wildcard_pattern_parts) + f=
"
> -> {action_spec.name}",
> +                    description=3Dpattern + f" -> {action_spec.name}",
>                  )
>              ]
>
> @@ -354,24 +507,32 @@ def generate(
>              max_vals =3D max(len(f_spec.test_parameters) for _, f_spec i=
n
> field_combo)
>
>              for i in range(max_vals):
> -                field_pattern_parts =3D []
> +                field_value_map: dict[str, tuple[Protocol, PatternField,
> Any]] =3D {}
>                  all_field_values: dict[str, dict[str, Any]] =3D {}
> -                desc_parts =3D []
>
>                  for protocol_spec, field_spec in field_combo:
>                      val =3D field_spec.test_parameters[i %
> len(field_spec.test_parameters)]
> -
> -                    field_pattern_parts.append(
> -                        f"{protocol_spec.pattern_name}
> {field_spec.pattern_field} is {val}"
> -                    )
> +                    field_value_map[protocol_spec.name] =3D
> (protocol_spec, field_spec, val)
>
>                      if protocol_spec.name not in all_field_values:
>                          all_field_values[protocol_spec.name] =3D {}
>                      all_field_values[protocol_spec.name][field_spec.scap=
y_field]
> =3D val
>
> -                    desc_parts.append(f"{protocol_spec.name
> }[{field_spec.scapy_field}=3D{val}]")
> +                pattern_parts =3D []
> +                desc_parts =3D []
> +
> +                for proto_name, test_fields in protocol_stack:
> +                    proto_spec =3D self.protocols[proto_name]
> +                    if test_fields and proto_name in field_value_map:
> +                        _, f_spec, val =3D field_value_map[proto_name]
> +                        pattern_parts.append(
> +                            f"{proto_spec.pattern_name}
> {f_spec.pattern_field} is {val}"
> +                        )
> +                        desc_parts.append(f"{proto_spec.name
> }[{f_spec.scapy_field}=3D{val}]")
> +                    else:
> +                        pattern_parts.append(proto_spec.pattern_name)
>
> -                full_pattern =3D " / ".join(wildcard_pattern_parts +
> field_pattern_parts)
> +                full_pattern =3D " / ".join(pattern_parts)
>
>                  flow_rule =3D FlowRule(
>                      direction=3D"ingress",
> @@ -384,10 +545,7 @@ def generate(
>                      all_protocol_names, all_field_values, add_payload=3D=
True
>                  )
>
> -                wildcard_desc =3D " / ".join(wildcard_pattern_parts)
> -                field_desc =3D " / ".join(desc_parts)
> -                full_desc =3D f"{wildcard_desc} / {field_desc}" if
> wildcard_desc else field_desc
> -
> +                full_desc =3D " / ".join(desc_parts)
>                  test_cases.append(
>                      FlowTest(
>                          flow_rule=3Dflow_rule,
> @@ -403,7 +561,7 @@ def generate(
>
>  @requires_nic_capability(NicCapability.FLOW_CTRL)
>  class TestFlowOffload(TestSuite):
> -    """Flow offload test suite.
> +    """Flow Offload test suite.
>
>      This suite consists of 4 test cases:
>      1. Queue Action: Verifies queue actions with multi-protocol patterns
> --
> 2.55.0
>
>

--0000000000001b6115065d316348
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I will test this tonight.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">What do we have right now in terms of DTS dev systems a=
nd NICs for non-iol people like me. Is it still:</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">iol-dts-tester</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">And=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">iol-dts-dut</div><div dir=3D"auto"><br></div><div dir=3D"auto">With mlnx =
cx5 and intel xl710?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Jus=
t checking in.=C2=A0</div><div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 11, 2026 at 1:04=
=E2=80=AFPM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">abaile=
y@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Refact=
or current flow test suite to utilize a generator<br>
method, which dynamically creates flow rules from a<br>
dictionary of pattern and action fields during runtime.<br>
This allows for much more extensive testing of the flow<br>
API without exponential code growth.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
<br>
v7:<br>
=C2=A0* Resolve merge conflicts.<br>
=C2=A0dts/tests/TestSuite_flow_offload.py | 206 ++++++++++++++++++++++++---=
-<br>
=C2=A01 file changed, 182 insertions(+), 24 deletions(-)<br>
<br>
diff --git a/dts/tests/TestSuite_flow_offload.py b/dts/tests/TestSuite_flow=
_offload.py<br>
index be11d09875..d1a6c2fa74 100644<br>
--- a/dts/tests/TestSuite_flow_offload.py<br>
+++ b/dts/tests/TestSuite_flow_offload.py<br>
@@ -1,7 +1,7 @@<br>
=C2=A0# SPDX-License-Identifier: BSD-3-Clause<br>
=C2=A0# Copyright(c) 2025 University of New Hampshire<br>
<br>
-&quot;&quot;&quot;RTE Flow testing suite.<br>
+&quot;&quot;&quot;Flow offload testing suite.<br>
<br>
=C2=A0This suite verifies a range of flow rules built using patterns<br>
=C2=A0and actions from the RTE Flow API. It would be impossible to cover<br=
>
@@ -10,7 +10,7 @@<br>
<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
-from dataclasses import dataclass<br>
+from dataclasses import dataclass, field<br>
=C2=A0from itertools import product<br>
=C2=A0from typing import Any, Callable, Optional<br>
<br>
@@ -18,6 +18,7 @@<br>
=C2=A0from scapy.layers.inet6 import IPv6<br>
=C2=A0from scapy.layers.l2 import ARP, Dot1Q, Ether<br>
=C2=A0from scapy.layers.sctp import SCTP<br>
+from scapy.layers.vxlan import VXLAN<br>
=C2=A0from scapy.packet import Packet, Raw<br>
<br>
=C2=A0from api.capabilities import NicCapability, requires_nic_capability<b=
r>
@@ -50,10 +51,16 @@ class Protocol:<br>
=C2=A0 =C2=A0 =C2=A0scapy_class: type[Packet]<br>
=C2=A0 =C2=A0 =C2=A0pattern_name: str<br>
=C2=A0 =C2=A0 =C2=A0fields: list[PatternField]<br>
+=C2=A0 =C2=A0 default_values: dict[str, Any] =3D field(default_factory=3Dd=
ict)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def build_scapy_layer(self, field_values: dict[str, Any=
]) -&gt; Packet:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Construct a Scapy layer with=
 the given field values.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.scapy_class(**field_values)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Construct a Scapy layer with=
 the given field values.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Default values are applied first, then overrid=
den by any<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 explicit field values so test parameters alway=
s win.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 merged =3D {**self.default_values, **field_val=
ues}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.scapy_class(**merged)<br>
<br>
<br>
=C2=A0@dataclass<br>
@@ -125,6 +132,7 @@ class JumpTest:<br>
<br>
<br>
=C2=A0PROTOCOLS: dict[str, Protocol] =3D {<br>
+=C2=A0 =C2=A0 # -------------------- Base Protocols --------------------<b=
r>
=C2=A0 =C2=A0 =C2=A0&quot;eth&quot;: Protocol(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name=3D&quot;eth&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scapy_class=3DEther,<br>
@@ -215,6 +223,89 @@ class JumpTest:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PatternField(&quot;op&quot;=
, &quot;opcode&quot;, [1, 2]),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0],<br>
=C2=A0 =C2=A0 =C2=A0),<br>
+=C2=A0 =C2=A0 # -------------------- VXLAN Outer Protocols ---------------=
-----<br>
+=C2=A0 =C2=A0 &quot;eth_outer&quot;: Protocol(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;eth_outer&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DEther,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;eth&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;src&quot;, &q=
uot;src&quot;, [&quot;02:00:00:00:00:00&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dst&quot;, &q=
uot;dst&quot;, [&quot;02:00:00:00:00:02&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;ipv4_outer&quot;: Protocol(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;ipv4_outer&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DIP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;ipv4&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;src&quot;, &q=
uot;src&quot;, [&quot;10.0.0.1&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dst&quot;, &q=
uot;dst&quot;, [&quot;10.0.0.2&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;ttl&quot;, &q=
uot;ttl&quot;, [64, 128]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;tos&quot;, &q=
uot;tos&quot;, [0, 4]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;udp_outer&quot;: Protocol(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;udp_outer&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DUDP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;udp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default_values=3D{&quot;dport&quot;: 4789},<br=
>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 # -------------------- VXLAN Tunnel Header -----------------=
---<br>
+=C2=A0 =C2=A0 &quot;vxlan&quot;: Protocol(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;vxlan&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DVXLAN,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;vxlan&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;vni&quot;, &q=
uot;vni&quot;, [42, 100]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 # -------------------- VXLAN Inner Protocols ---------------=
-----<br>
+=C2=A0 =C2=A0 &quot;eth_inner&quot;: Protocol(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;eth_inner&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DEther,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;eth&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;src&quot;, &q=
uot;src&quot;, [&quot;02:00:00:00:00:00&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dst&quot;, &q=
uot;dst&quot;, [&quot;02:00:00:00:00:02&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;ipv4_inner&quot;: Protocol(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;ipv4_inner&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DIP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;ipv4&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;src&quot;, &q=
uot;src&quot;, [&quot;192.168.1.1&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dst&quot;, &q=
uot;dst&quot;, [&quot;192.168.1.2&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;ipv6_inner&quot;: Protocol(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;ipv6_inner&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DIPv6,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;ipv6&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;src&quot;, &q=
uot;src&quot;, [&quot;2001:db8::1&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dst&quot;, &q=
uot;dst&quot;, [&quot;2001:db8::2&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;tcp_inner&quot;: Protocol(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;tcp_inner&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DTCP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;tcp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;sport&quot;, =
&quot;src&quot;, [1234]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dport&quot;, =
&quot;dst&quot;, [80]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;udp_inner&quot;: Protocol(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;udp_inner&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DUDP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;udp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;sport&quot;, =
&quot;src&quot;, [5000]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dport&quot;, =
&quot;dst&quot;, [53]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 ),<br>
=C2=A0}<br>
<br>
<br>
@@ -234,6 +325,7 @@ class JumpTest:<br>
=C2=A0}<br>
<br>
=C2=A0PROTOCOL_STACKS =3D [<br>
+=C2=A0 =C2=A0 # -------------------- Non-tunnel stacks -------------------=
-<br>
=C2=A0 =C2=A0 =C2=A0[(&quot;eth&quot;, True)],<br>
=C2=A0 =C2=A0 =C2=A0[(&quot;eth&quot;, False), (&quot;ipv4&quot;, True)],<b=
r>
=C2=A0 =C2=A0 =C2=A0[(&quot;eth&quot;, False), (&quot;ipv4&quot;, True), (&=
quot;tcp&quot;, True)],<br>
@@ -253,6 +345,66 @@ class JumpTest:<br>
=C2=A0 =C2=A0 =C2=A0[(&quot;eth&quot;, False), (&quot;vlan&quot;, False), (=
&quot;ipv6&quot;, True), (&quot;tcp&quot;, True)],<br>
=C2=A0 =C2=A0 =C2=A0[(&quot;eth&quot;, False), (&quot;vlan&quot;, False), (=
&quot;ipv6&quot;, True), (&quot;udp&quot;, True)],<br>
=C2=A0 =C2=A0 =C2=A0[(&quot;eth&quot;, False), (&quot;arp&quot;, True)],<br=
>
+=C2=A0 =C2=A0 # -------------------- VXLAN tunnel stacks -----------------=
---<br>
+=C2=A0 =C2=A0 [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv4_outer&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;udp_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;vxlan&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_inner&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv4_inner&quot;, False),<br>
+=C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv4_outer&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;udp_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;vxlan&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_inner&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv4_inner&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;tcp_inner&quot;, False),<br>
+=C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv4_outer&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;udp_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;vxlan&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_inner&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv4_inner&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;udp_inner&quot;, False),<br>
+=C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv4_outer&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;udp_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;vxlan&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_inner&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv6_inner&quot;, False),<br>
+=C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv4_outer&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;udp_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;vxlan&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_inner&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv6_inner&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;tcp_inner&quot;, False),<br>
+=C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv4_outer&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;udp_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;vxlan&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_inner&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv6_inner&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;udp_inner&quot;, False),<br>
+=C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;ipv4_outer&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;udp_outer&quot;, False),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;vxlan&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;eth_inner&quot;, False),<br>
+=C2=A0 =C2=A0 ],<br>
=C2=A0]<br>
<br>
<br>
@@ -304,6 +456,10 @@ def generate(<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; list[FlowTest]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Generate test cases for=
 patterns matching fields across multiple protocols.<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Pattern parts are assembled in stack order to =
preserve positional<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 correctness, which is required for tunnel enca=
psulations where<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 inner and outer layers share the same pattern_=
name.<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0protocol_stack: List of (pr=
otocol_name, test_fields) tuples.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If test_field=
s is True, iterate through field combinations.<br>
@@ -316,15 +472,12 @@ def generate(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0List of FlowTest objects re=
ady for execution.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0action_spec =3D self.actions[action_name]=
<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 wildcard_protocols =3D [name for name, test_fi=
elds in protocol_stack if not test_fields]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 field_test_protocols =3D [name for name, test_=
fields in protocol_stack if test_fields]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all_protocol_names =3D [name for name, _ =
in protocol_stack]<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 wildcard_pattern_parts =3D [self.protocols[nam=
e].pattern_name for name in wildcard_protocols]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 field_test_protocols =3D [name for name, test_=
fields in protocol_stack if test_fields]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not field_test_protocols:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern =3D &quot; / &quot;.join=
(wildcard_pattern_parts)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_parts =3D [self.protocol=
s[name].pattern_name for name, _ in protocol_stack]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern =3D &quot; / &quot;.join=
(pattern_parts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flow_rule =3D FlowRule(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0direction=3D&=
quot;ingress&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pattern=3D[pa=
ttern],<br>
@@ -339,7 +492,7 @@ def generate(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0packet=3Dpacket,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0verification_type=3Daction_spec.verification_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0verification_params=3Daction_spec.build_verification_params(action_value=
),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc=
ription=3D&quot; / &quot;.join(wildcard_pattern_parts) + f&quot; -&gt; {<a =
href=3D"http://action_spec.name" rel=3D"noreferrer" target=3D"_blank">actio=
n_spec.name</a>}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc=
ription=3Dpattern + f&quot; -&gt; {<a href=3D"http://action_spec.name" rel=
=3D"noreferrer" target=3D"_blank">action_spec.name</a>}&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
<br>
@@ -354,24 +507,32 @@ def generate(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max_vals =3D max(len(f_spec=
.test_parameters) for _, f_spec in field_combo)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for i in range(max_vals):<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 field_pattern_part=
s =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 field_value_map: d=
ict[str, tuple[Protocol, PatternField, Any]] =3D {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all_field_val=
ues: dict[str, dict[str, Any]] =3D {}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_parts =3D []<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for protocol_=
spec, field_spec in field_combo:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0val =3D field_spec.test_parameters[i % len(field_spec.test_parameters)]<=
br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fiel=
d_pattern_parts.append(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;{protocol_spec.pattern_name} {field_spec.pattern_field} i=
s {val}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fiel=
d_value_map[<a href=3D"http://protocol_spec.name" rel=3D"noreferrer" target=
=3D"_blank">protocol_spec.name</a>] =3D (protocol_spec, field_spec, val)<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if <a href=3D"http://protocol_spec.name" rel=3D"noreferrer" target=3D"_b=
lank">protocol_spec.name</a> not in all_field_values:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0all_field_values[<a href=3D"http://protocol_spec.name" rel=
=3D"noreferrer" target=3D"_blank">protocol_spec.name</a>] =3D {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0all_field_values[<a href=3D"http://protocol_spec.name" rel=3D"noreferrer=
" target=3D"_blank">protocol_spec.name</a>][field_spec.scapy_field] =3D val=
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc=
_parts.append(f&quot;{<a href=3D"http://protocol_spec.name" rel=3D"noreferr=
er" target=3D"_blank">protocol_spec.name</a>}[{field_spec.scapy_field}=3D{v=
al}]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_parts =3D =
[]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_parts =3D []<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for proto_name, te=
st_fields in protocol_stack:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot=
o_spec =3D self.protocols[proto_name]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if t=
est_fields and proto_name in field_value_map:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 _, f_spec, val =3D field_value_map[proto_name]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pattern_parts.append(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{proto_spec.pattern_name} {f_spec.pattern_f=
ield} is {val}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 desc_parts.append(f&quot;{<a href=3D"http://proto_spec.name" rel=
=3D"noreferrer" target=3D"_blank">proto_spec.name</a>}[{f_spec.scapy_field}=
=3D{val}]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pattern_parts.append(proto_spec.pattern_name)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 full_pattern =3D &=
quot; / &quot;.join(wildcard_pattern_parts + field_pattern_parts)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 full_pattern =3D &=
quot; / &quot;.join(pattern_parts)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flow_rule =3D=
 FlowRule(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0direction=3D&quot;ingress&quot;,<br>
@@ -384,10 +545,7 @@ def generate(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0all_protocol_names, all_field_values, add_payload=3DTrue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wildcard_desc =3D =
&quot; / &quot;.join(wildcard_pattern_parts)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 field_desc =3D &qu=
ot; / &quot;.join(desc_parts)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 full_desc =3D f&qu=
ot;{wildcard_desc} / {field_desc}&quot; if wildcard_desc else field_desc<br=
>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 full_desc =3D &quo=
t; / &quot;.join(desc_parts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cases.ap=
pend(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0FlowTest(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0flow_rule=3Dflow_rule,<br>
@@ -403,7 +561,7 @@ def generate(<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.FLOW_CTRL)<br>
=C2=A0class TestFlowOffload(TestSuite):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Flow offload test suite.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Flow Offload test suite.<br>
<br>
=C2=A0 =C2=A0 =C2=A0This suite consists of 4 test cases:<br>
=C2=A0 =C2=A0 =C2=A01. Queue Action: Verifies queue actions with multi-prot=
ocol patterns<br>
--<br>
2.55.0<br>
<br>
</blockquote></div></div>

--0000000000001b6115065d316348--
