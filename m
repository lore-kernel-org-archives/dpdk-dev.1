Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7475FD46C08
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 21:43:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 809AA402B6;
	Wed, 28 Jan 2026 22:43:58 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 0A313402A7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 22:43:57 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-124566b6693so771522c88.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:43:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769636636; cv=none;
 d=google.com; s=arc-20240605;
 b=V4JC5tTD23ByOITAgUPigionu0AOJCwSDXxz4hMNrE6Lk4czWgO6RJU9v3CH96pMxD
 8CqLJvx7MpHuMP3ttu4siHHrqdna7+zIaG6GjAXuYR/i+/ri/Yur3g98x0halq6b9SQo
 d92Wa7OgV5VNrVHbOsRGnIvBfGiuGaHydk2AAXerJz4DgKKTi2FrwIRxDI54X2qkv2n6
 bTn6I0iE8BxZ/7oOUdxV+b6LfL6sPjhaQixP4QWRWaKuKKAoG6tKPQrhBWMZgk3Bi8y6
 hHQnDrpuZwYXdmZTx+QnXoDCxxSV4ZDGNZxLevE1N/xz3/flwApEzGP4X00GZHg1Udrl
 +02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IAJqpp/WfnnvaEWPTGzrM7fIHALTJuUDDCUYplLJuVA=;
 fh=EYzOZ03uwQQVdtGdB8klFC0B2U3Esuwsb1z9svhdK5A=;
 b=QNbvqtbWc9iJTeALG+mrCDlmVlovpdivBEo3jl6717FXhnbipV+TYJTEnB+mwVSpz5
 djnzrdnZ+xIW9rByIr/ZY5Q7sSn44fYZZuJCYfZKz3bYQ+dxY+dXLmLJ03IxPUHEAxyF
 Vm47syoOT26a9eXggJI5Fcf1JzdSUe50jdEhUnts91HHDsaMFC1op7OTOcjT0iqDqk9C
 iKH3hzTUDlXFCWIFf4gvBj5MZxo9r19vpSkUwsn/oxGNfNJggXfO7dmvFalzlS22aj7q
 zUq8jP7rhl5/9j7O3+7KLiicgNjxb2Q7JIAzDYiX2vaMQol8F6NuNZ4/4esDykgFFkio
 62JA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769636636; x=1770241436; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IAJqpp/WfnnvaEWPTGzrM7fIHALTJuUDDCUYplLJuVA=;
 b=WxUzlgnuGRmWabq7mr88PQRVZK3skQfAYyfmK4gELWzoWwFGNwM4hVr0W35B0LHfDm
 WmLrA4RYDv2NK4R+8C+0g0R388q07yL5NV3DP3oTgwRebjDLg7vGATIqcY7rsjPcmPiX
 C737ruOHNxbYYrx03aK0DdKqGEUpTDqlWLP70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769636636; x=1770241436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAJqpp/WfnnvaEWPTGzrM7fIHALTJuUDDCUYplLJuVA=;
 b=mmgubx2tVjgDjzFzQniZj0/je+Bifv2ZUPDRnervJ1P9grUrpKsaEAUrWTW/GFqC2l
 f5cf9CwkmIoAdkIQRm6x9/8qmmC8wlB9qu6VGU5QP2oHpp1v6d5PqkRtvOJsSKWcQnfG
 lz5R11L8UmsXDlye+hIgCCY7HahllzaAXJEyOHRQkSC/QU5vZH22b5O0A31ka7Eyqrpy
 pFkYXVhDkabF1eOupAHOYG2BZHpKl5VUJcAOxk9/Ruv7ZuQJiKX9IKXqEgijuMZkajGO
 6RXVXVZQQsDXbPxUu2HY1zjtSaKe6lzYZlybIzzaPteke/efAzatwq99N5y9PN/qEavS
 M49w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Wmcp6CnHyVWaIneTLUuh8b3OTHXju5POxJgdydVoiKtF/KlAUMvkvbbYorJ24AuBE8Y=@dpdk.org
X-Gm-Message-State: AOJu0YzAw/2J6eqrZ5tajmlaMFHSRBsq8Ou+XjciJKI6pcCMLZg0FYnG
 ifndMFVyvFfk2CXe99B33F92rVo7KLRi0qYpGxqluXUPhjDsjAKWokwgSoYILmRU9+nG3MC2XX+
 BuEcFWHWWIcaMajC1hg/dhX8YXKPc5i6oKU0Q0UMJK8TYlJhfG8DHEPg=
X-Gm-Gg: AZuq6aKpfhsc+/C82Bd9hmj9He6zXtBuG7ylqvfBMk6QjpZH2IA6/p8VEjPvnzmTh+S
 Ct3ss9DtmTUHMQ7TgU1DakLBYDb729hxJM0BAhcxl2JM49ROLtRqJxWTYsUMKaSRCEPiudPAEef
 0HkAGel5bmlVvsGRiDs7n1Pz2Wgu8Ch3j8gYXvlMEKcJQsFeOJqXKidoXZuiBFTkH2T8Gr0P9CG
 t3dVtt4XHMoNK31cet7APwReoJKYZM8n8NAf8W7u9p0pmz+Zu2oSadN8bsyIdHe0bL2SCZVNCpG
 zMqVwz/6nQ9GteSWgG9rIoSP7YKs17E8/yWYkyOJ4kBaUhmSytnS2JvUYdV5
X-Received: by 2002:a05:7022:660f:b0:123:3584:de40 with SMTP id
 a92af1059eb24-124a0139a1cmr3614339c88.50.1769636635413; Wed, 28 Jan 2026
 13:43:55 -0800 (PST)
MIME-Version: 1.0
References: <20260106213803.205934-1-dmarx@iol.unh.edu>
In-Reply-To: <20260106213803.205934-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 28 Jan 2026 16:41:30 -0500
X-Gm-Features: AZwV_QhNLAZy8uNPUkJmaVaFK1V_D-r6JSWqKCnKAMW3QIt92zuCW-j9C3aSiEY
Message-ID: <CAJvnSUAoT4BhfHG83Zc9E-pJN11Nrjj3OAk232ziWETNVORz7A@mail.gmail.com>
Subject: Re: [PATCH v1] dts: refactor flow suite with generator pattern
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000091e82064979a37a"
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

--000000000000091e82064979a37a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 4:38=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote:

>
>
> -@requires_nic_capability(NicCapability.FLOW_CTRL)
> -class TestRteFlow(TestSuite):
> -    """RTE Flow test suite.
> +@dataclass
> +class PatternField:
> +    """Specification for a single matchable field within a protocol
> layer."""
> +
> +    scapy_field: str
> +    pattern_field: str
> +    test_values: list[Any]
>

rename to test_parameters? Or another word more indicative of what these
values are?


> +
> +
> +@dataclass
> +class Layer:
> +    """Complete specification for a protocol layer."""
> +
> +    name: str
> +    scapy_class: type
>

Can scapy_class be type hinted more specifically/clearly? I.e. if Ether,
ipv6, etc. all have the Packet superclass, can it be type hinted as
type[Packet]?


> +    pattern_name: str
> +    fields: list[PatternField]
> +    requires: list[str] =3D field(default_factory=3Dlist)
> +
> +    def build_scapy_layer(self, field_values: dict[str, Any]) -> Packet:
> +        """Construct a Scapy layer with the given field values."""
> +        return self.scapy_class(**field_values)
> +
> +
> +@dataclass
> +class Action:
> +    """Specification for a flow action."""
> +
> +    name: str
> +    action_format: str
> +    verification_type: str
> +    param_builder: Callable[[Any], dict[str, Any]]
> +    expected_packet_builder: Callable[[Packet], Packet] | None =3D None
> +
> +    def build_action_string(self, value: Any =3D None) -> str:
> +        """Generate the action string for a flow rule."""
> +        if value is not None and "{value}" in self.action_format:
> +            return self.action_format.format(value=3Dvalue)
> +        return self.action_format
> +
> +    def build_verification_params(self, value: Any =3D None) -> dict[str=
,
> Any]:
> +        """Generate verification parameters for this action."""
> +        return self.param_builder(value)
> +
> +    def build_expected_packet(self, original_packet: Packet) -> Packet |
> None:
> +        """Build expected packet for modification actions."""
> +        if self.expected_packet_builder:
> +            return self.expected_packet_builder(original_packet)
> +        return None
> +
> +
> +@dataclass
> +class FlowTestCase:
> +    """A complete test case ready for execution."""
>

There is already such a thing as a testcase in DTS and this is not one and
is not integrated into the framework as a testcase, so call it something
different for clarity. The naming makes it seem like it's a testcase
subclass or something but it is totally unrelated. I do see how this is
"like a testcase" so I get the choice - I just think it is overlapping with
what we already have name wise. :) Maybe just change to "FlowTest"?


> +
> +    flow_rule: FlowRule
> +    packet: Packet
> +    verification_type: str
> +    verification_params: dict[str, Any]
> +    description: str =3D ""
> +    expected_packet: Packet | None =3D None
> +
> +
> +@dataclass
> +class FlowTestResult:
> +    """Result of a single test case execution."""
> +
> +    description: str
> +    passed: bool
> +    failure_reason: str =3D ""
> +    flow_rule_pattern: str =3D ""
> +    skipped: bool =3D False
> +    sent_packet: Packet | None =3D None
> +
> +
> +LAYERS: dict[str, Layer] =3D {
>

I realize the purpose of this system is to create dependencies between
different protocols (because they are at different network layers) but this
is a list of protocols and I think it should be renamed as such. And I
would rename the layer class to protocol unless you see an issue.


> +    "eth": Layer(
> +        name=3D"eth",
> +        scapy_class=3DEther,
> +        pattern_name=3D"eth",
> +        fields=3D[
> +            PatternField("src", "src", ["02:00:00:00:00:00"]),
> +            PatternField("dst", "dst", ["02:00:00:00:00:02"]),
> +        ],
> +    ),
> +    "ipv4": Layer(
> +        name=3D"ipv4",
> +        scapy_class=3DIP,
> +        pattern_name=3D"ipv4",
> +        fields=3D[
> +            PatternField("src", "src", ["192.168.1.1"]),
> +            PatternField("dst", "dst", ["192.168.1.2"]),

+            PatternField("ttl", "ttl", [64, 128]),
> +            PatternField("tos", "tos", [0, 4]),
> +        ],
> +        requires=3D["eth"],
>

Is this "requires" field actually used in the business logic? I don't see
that right now.


> +    ),

+    "ipv6": Layer(
> +        name=3D"ipv6",
> +        scapy_class=3DIPv6,
> +        pattern_name=3D"ipv6",
> +        fields=3D[
> +            PatternField("src", "src", ["2001:db8::1"]),
> +            PatternField("dst", "dst", ["2001:db8::2"]),
> +            PatternField("tc", "tc", [0, 4]),
> +            PatternField("hlim", "hop", [64, 128]),
>

How did you decide which patternfields to include vs which to omit? For
instance see 4.12.19.4 here
https://doc.dpdk.org/guides/testpmd_app_ug/testpmd_funcs.html#enqueueing-cr=
eation-of-flow-rules

Why omit the possible patternfield "proto." Is it because it will not
integrate with your generator because you don't know what the next proto is
for the validation step, or some other reason?


> +        ],
> +        requires=3D["eth"],
> +    ),
> +    "tcp": Layer(
> +        name=3D"tcp",
> +        scapy_class=3DTCP,
> +        pattern_name=3D"tcp",
> +        fields=3D[
> +            PatternField("sport", "src", [1234, 8080]),
> +            PatternField("dport", "dst", [80, 443]),
> +            PatternField("flags", "flags", [2, 16]),

+        ],
> +        requires=3D["eth", "ipv4"],
> +    ),
> +    "udp": Layer(
> +        name=3D"udp",
> +        scapy_class=3DUDP,
> +        pattern_name=3D"udp",
> +        fields=3D[
> +            PatternField("sport", "src", [5000]),
> +            PatternField("dport", "dst", [53, 123]),
> +        ],
> +        requires=3D["eth", "ipv4"],
> +    ),
> +    "vlan": Layer(
> +        name=3D"vlan",
> +        scapy_class=3DDot1Q,
> +        pattern_name=3D"vlan",
> +        fields=3D[
> +            PatternField("vlan", "vid", [100, 200]),
> +            PatternField("prio", "pcp", [0, 7]),
> +        ],
> +        requires=3D["eth"],
> +    ),
> +    "icmp": Layer(
> +        name=3D"icmp",
> +        scapy_class=3DICMP,
> +        pattern_name=3D"icmp",
> +        fields=3D[
> +            PatternField("type", "type", [8, 0]),
> +            PatternField("code", "code", [0]),
> +            PatternField("id", "ident", [0, 1234]),
> +            PatternField("seq", "seq", [0, 1]),
> +        ],
> +        requires=3D["eth", "ipv4"],
> +    ),
> +    "sctp": Layer(
> +        name=3D"sctp",
> +        scapy_class=3DSCTP,
> +        pattern_name=3D"sctp",
> +        fields=3D[
> +            PatternField("sport", "src", [2905, 3868]),
> +            PatternField("dport", "dst", [2905, 3868]),
> +            PatternField("tag", "tag", [1, 12346]),
> +        ],
> +        requires=3D["eth", "ipv4"],
> +    ),
> +    "arp": Layer(
> +        name=3D"arp",
> +        scapy_class=3DARP,
> +        pattern_name=3D"arp_eth_ipv4",
> +        fields=3D[
> +            PatternField("psrc", "spa", ["192.168.1.1"]),
> +            PatternField("pdst", "tpa", ["192.168.1.2"]),
> +            PatternField("op", "opcode", [1, 2]),
> +        ],
> +        requires=3D["eth"],
> +    ),
>

From looking at the rte_flow docs, I think it would make sense to test flow
offload of a VXLAN packet. Is it possible to add some VXLAN type packets to
your LAYER_STACKS list like:

["eth", "ipv6", "tcp", "vxlan", "eth", "ipv6", "udp"]

or is there an implementation difficulty associated with testing the above?

Or, what about testing INVERT item?
https://doc.dpdk.org/guides-24.07/prog_guide/rte_flow.html#meta-item-types

It seems like your system is creating a large portion of possible rules,
but some patternfields or items are missing (not sure if this is because of
implementation difficulty, a decision regarding what is pertinent test
coverage, or something else). One possible way forward is to extend the
minimal rule matrix testsuite (from last year) adding stuff like vxlan,
invert, and other missing pattern/item/actions which are in the DPDK rte
flow docs, and then maintain this generator based large rule matrix as a
separate testsuite. Or, we can drive everything through this testsuite and
continue to extend the coverage within it. Let me know your thoughts.


> +}
> +
> +
> +def _build_ipv4_src_to_dst_expected(packet: Packet) -> Packet:
> +    """Build expected packet for IPV4 src to dst copy."""
> +    expected =3D cast(Packet, packet.copy())
> +    if IP in expected:
> +        expected[IP].dst =3D packet[IP].src
> +    return expected
> +
> +
> +def _build_mac_src_to_dst_expected(packet: Packet) -> Packet:
> +    """Build expected packet for MAC src to dst copy."""
> +    expected =3D cast(Packet, packet.copy())
> +    if Ether in expected:
> +        expected[Ether].dst =3D packet[Ether].src
> +    return expected
> +
> +
> +ACTIONS: dict[str, Action] =3D {
> +    "queue": Action(
> +        name=3D"queue",
> +        action_format=3D"queue index {value}",
> +        verification_type=3D"queue",
> +        param_builder=3Dlambda queue_id: {"queue_id": queue_id},
> +    ),
> +    "drop": Action(
> +        name=3D"drop",
> +        action_format=3D"drop",
> +        verification_type=3D"drop",
> +        param_builder=3Dlambda _: {"should_receive": False},
> +    ),
> +    "modify_ipv4_src_to_dst": Action(
> +        name=3D"modify_ipv4_src_to_dst",
> +        action_format=3D"modify_field op set dst_type "
> +        "ipv4_dst src_type ipv4_src width 32 / queue index 0",
> +        verification_type=3D"modify",
> +        param_builder=3Dlambda _: {},
> +        expected_packet_builder=3D_build_ipv4_src_to_dst_expected,
> +    ),
> +    "modify_mac_src_to_dst": Action(
> +        name=3D"modify_mac_src_to_dst",
> +        action_format=3D"modify_field op set dst_type "
> +        "mac_dst src_type mac_src width 48 / queue index 0",
> +        verification_type=3D"modify",
> +        param_builder=3Dlambda _: {},
> +        expected_packet_builder=3D_build_mac_src_to_dst_expected,
> +    ),
> +}
>

It is worth thinking about how we can get coverage for other actions, like
"count." Again, maybe this is where we need to split out between the
generator system producing a high number of rules for the most standard
protocols and actions, and an (extended) explicit list of patterns/actions
which are tested, that allows us to also get some coverage for the less
common actions like "count."


> +
> +LAYER_STACKS =3D [
> +    ["eth"],
> +    ["eth", "ipv4"],
> +    ["eth", "ipv4", "tcp"],
> +    ["eth", "ipv4", "udp"],
> +    ["eth", "ipv4", "icmp"],
> +    ["eth", "ipv4", "sctp"],
> +    ["eth", "ipv6"],
> +    ["eth", "ipv6", "tcp"],
> +    ["eth", "ipv6", "udp"],
> +    ["eth", "ipv6", "sctp"],
> +    ["eth", "vlan"],
> +    ["eth", "vlan", "ipv4"],
> +    ["eth", "vlan", "ipv4", "tcp"],
> +    ["eth", "vlan", "ipv4", "udp"],
> +    ["eth", "vlan", "ipv4", "sctp"],
> +    ["eth", "vlan", "ipv6"],
> +    ["eth", "vlan", "ipv6", "tcp"],
> +    ["eth", "vlan", "ipv6", "udp"],
> +    ["eth", "arp"],
> +]
>

See comment above about VXLAN.


> +
> +
> +class FlowTestGenerator:
> +    """Generates test cases by combining patterns and actions."""
>

One thing I wonder about here is whether this should be written into the
testsuite or should be testsuite API code (to be used by other testsuites
in the future). You clearly at thinking the former is good - what is your
perspective on whether there may be any need for usage of this class in
other testsuites in the future? I don't necessarily think so but want to
ask the question.


> +
> +    def __init__(self, layers: dict[str, Layer], actions: dict[str,
> Action]):
> +        """Initialize the generator with layer and action
> specifications."""
> +        self.layers =3D layers
> +        self.actions =3D actions
> +
> +    def _build_multi_layer_packet(
> +        self,
> +        layer_stack: list[str],
> +        all_field_values: dict[str, dict[str, Any]],
> +        add_payload: bool =3D True,
> +    ) -> Packet:
> +        """Build a packet from multiple protocol layers."""
> +        packet: Packet =3D Ether()
> +        prev_layer_name =3D None
>
> -    This suite consists of 12 test cases:
> -    1. Queue Action Ethernet: Verifies queue actions with ethernet
> patterns
> -    2. Queue Action IP: Verifies queue actions with IPv4 and IPv6 patter=
ns
> -    3. Queue Action L4: Verifies queue actions with TCP and UDP patterns
> -    4. Queue Action VLAN: Verifies queue actions with VLAN patterns
> -    5. Drop Action Eth: Verifies drop action with ethernet patterns
> -    6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 patterns
> -    7. Drop Action L4: Verifies drop actions with TCP and UDP patterns
> -    8. Drop Action VLAN: Verifies drop actions with VLAN patterns
> -    9. Modify Field Action: Verifies packet modification patterns
> -    10. Egress Rules: Verifies previously covered rules are still valid
> as egress
> -    11. Jump Action: Verifies packet behavior given grouped flows
> -    12. Priority Attribute: Verifies packet behavior given flows with
> different priorities
> +        for layer_name in layer_stack:
> +            layer_spec =3D self.layers[layer_name]
> +            values =3D all_field_values.get(layer_name, {})
> +            layer =3D layer_spec.build_scapy_layer(values)
>
> -    """
> +            if layer_name =3D=3D "eth":
> +                packet =3D layer
> +            else:
> +                if prev_layer_name =3D=3D "ipv6" and layer_name in ["tcp=
",
> "udp", "sctp"]:
> +                    nh_map =3D {"tcp": 6, "udp": 17, "sctp": 132}
> +                    packet[IPv6].nh =3D nh_map[layer_name]
> +
> +                packet =3D packet / layer
>
> -    def _runner(
> +            prev_layer_name =3D layer_name
> +
> +        if add_payload:
> +            packet =3D packet / Raw(load=3D"X" * 32)
> +
> +        return packet
> +
> +    def generate(
>          self,
> -        verification_method: Callable[..., Any],
> -        flows: list[FlowRule],
> -        packets: list[Packet],
> -        port_id: int,
> -        expected_packets: list[Packet] | None =3D None,
> -        *args: Any,
> -        **kwargs: Any,
> -    ) -> None:
> -        """Runner method that validates each flow using the correspondin=
g
> verification method.
> +        layer_names: list[str],
> +        action_name: str,
> +        action_value: Any =3D None,
> +        group_id: int =3D 0,
> +    ) -> list[FlowTestCase]:
> +        """Generate test cases for patterns matching fields across
> multiple layers.
> +
> +        This method identifies every possible combination of one field
> per layer.
> +        For each field combination, it iterates through the available
> test values.
> +        If fields have an unequal number of test values, it cycles
> through the
> +        shorter lists to ensure every specific value in every field is
> tested.
>
>          Args:
> -            verification_method: Callable that performs verification
> logic.
> -            flows: List of flow rules to create and test.
> -            packets: List of packets corresponding to each flow.
> -            port_id: Number representing the port to create flows on.
> -            expected_packets: List of packets to check sent packets
> against in modification cases.
> -            *args: Additional positional arguments to pass to the
> verification method.
> -            **kwargs: Additional keyword arguments to pass to the
> verification method.
> +            layer_names: List of layer names to match.
> +            action_name: Name of the action to apply.
> +            action_value: Optional value for parameterized actions.
> +            group_id: Flow group ID.
> +
> +        Returns:
> +            List of FlowTestCase objects ready for execution.
>          """
> +        action_spec =3D self.actions[action_name]
> +
> +        # Organize layers into lists of matchable fields
> +        layer_field_specs =3D []
> +        for layer_name in layer_names:
> +            layer_spec =3D self.layers[layer_name]
> +            # Capture the layer spec and the field spec for each field i=
n
> the layer
> +            layer_field_specs.append([(layer_spec, f) for f in
> layer_spec.fields])
> +
> +        test_cases =3D []
> +
> +        # Iterate through every combination of fields across the
> requested layers
> +        # For ['eth', 'ipv4'], this produces: (eth_src, ipv4_src),
> (eth_src, ipv4_dst), etc.
> +        for field_combo in product(*layer_field_specs):
> +            # Determine how many test cases are needed to cover all
> values in this combo
> +            max_vals =3D max(len(f_spec.test_values) for _, f_spec in
> field_combo)
> +
> +            # Cycle through the test values for these fields
> +            for i in range(max_vals):
> +                pattern_parts =3D []
> +                all_field_values: dict[str, dict[str, Any]] =3D {}
> +                desc_parts =3D []
> +
> +                for layer_spec, field_spec in field_combo:
> +                    # Select value by index
> +                    val =3D field_spec.test_values[i %
> len(field_spec.test_values)]
> +
> +                    pattern_parts.append(
> +                        f"{layer_spec.pattern_name}
> {field_spec.pattern_field} is {val}"
> +                    )
> +                    # Store value for Scapy packet building
> +                    if layer_spec.name not in all_field_values:
> +                        all_field_values[layer_spec.name] =3D {}
> +                    all_field_values[layer_spec.name][field_spec.scapy_f=
ield]
> =3D val
> +
> +                    desc_parts.append(f"{layer_spec.name
> }[{field_spec.scapy_field}=3D{val}]")
> +
> +                full_pattern =3D " / ".join(pattern_parts)
> +                flow_rule =3D FlowRule(
> +                    direction=3D"ingress",
> +                    pattern=3D[full_pattern],
> +
> actions=3D[action_spec.build_action_string(action_value)],
> +                    group_id=3Dgroup_id,
> +                )
> +
> +                add_payload =3D action_spec.verification_type in ["drop"=
,
> "modify"]
> +                packet =3D self._build_multi_layer_packet(layer_names,
> all_field_values, add_payload)
> +
> +                expected_packet =3D None
> +                if action_spec.verification_type =3D=3D "modify":
> +                    expected_packet =3D
> action_spec.build_expected_packet(packet)
> +
> +                test_cases.append(
> +                    FlowTestCase(
> +                        flow_rule=3Dflow_rule,
> +                        packet=3Dpacket,
> +                        verification_type=3Daction_spec.verification_typ=
e,
> +
> verification_params=3Daction_spec.build_verification_params(action_value)=
,
> +                        description=3D" / ".join(desc_parts) + f" -> {
> action_spec.name}",
> +                        expected_packet=3Dexpected_packet,
> +                    )
> +                )
>
> -        def zip_lists(
> -            rules: list[FlowRule],
> -            packets1: list[Packet],
> -            packets2: list[Packet] | None,
> -        ) -> Iterator[tuple[FlowRule, Packet, Packet | None]]:
> -            """Method that creates an iterable zip containing lists used
> in runner.
> -
> -            Args:
> -                rules: List of flow rules.
> -                packets1: List of packets.
> -                packets2: Optional list of packets, excluded from zip if
> not passed to runner.
> -            """
> -            return cast(
> -                Iterator[tuple[FlowRule, Packet, Packet | None]],
> -                zip_longest(rules, packets1, packets2 or [],
> fillvalue=3DNone),
> -            )
> +        return test_cases
>
> -        with TestPmd(rx_queues=3D4, tx_queues=3D4) as testpmd:
> -            for flow, packet, expected_packet in zip_lists(flows,
> packets, expected_packets):
> -                is_valid =3D testpmd.flow_validate(flow_rule=3Dflow,
> port_id=3Dport_id)
> -                verify_else_skip(is_valid, "flow rule failed validation.=
")
>
> -                try:
> -                    flow_id =3D testpmd.flow_create(flow_rule=3Dflow,
> port_id=3Dport_id)
> -                except InteractiveCommandExecutionError:
> -                    log("Flow rule validation passed, but flow creation
> failed.")
> -                    fail("Failed flow creation")
> +@requires_nic_capability(NicCapability.FLOW_CTRL)
> +class TestRteFlow(TestSuite):
> +    """RTE Flow test suite.
>
> -                if verification_method =3D=3D self._send_packet_and_veri=
fy:
> -                    verification_method(packet=3Dpacket, *args, **kwargs=
)
> +    This suite consists of 4 test cases:
> +    1. Queue Action: Verifies queue actions with multi-layer patterns
> +    2. Drop Action: Verifies drop actions with multi-layer patterns
> +    3. Modify Field Action: Verifies modify_field actions with
> multi-layer patterns
> +    4. Jump Action: Verifies jump action between flow groups
>
> -                elif verification_method =3D=3D
> self._send_packet_and_verify_queue:
> -                    verification_method(
> -                        packet=3Dpacket, test_queue=3Dkwargs["test_queue=
"],
> testpmd=3Dtestpmd
> -                    )
> +    """
>
> -                elif verification_method =3D=3D
> self._send_packet_and_verify_modification:
> -                    verification_method(packet=3Dpacket,
> expected_packet=3Dexpected_packet)
> +    def set_up_suite(self) -> None:
> +        """Initialize the test generator and result tracking."""
> +        self.generator =3D FlowTestGenerator(LAYERS, ACTIONS)
> +        self.test_suite_results: list[FlowTestResult] =3D []
> +        self.test_case_results: list[FlowTestResult] =3D []
>
> -                testpmd.flow_delete(flow_id, port_id=3Dport_id)
> +    def _run_confidence_check(self, action_type: str) -> None:
>

 Where is the handling for when action_type=3D=3D"queue"?

Also, should be called _verify_basic_transmission or something more
descriptive. I know we said confidence check at the team meeting but let's
make it clear what the function is doing.


> +        """Verify that non-matching packets are unaffected by flow rules=
.
>
> -    def _send_packet_and_verify(self, packet: Packet, should_receive:
> bool =3D True) -> None:
> -        """Generate a packet, send to the DUT, and verify it is forwarde=
d
> back.
> +        Creates a flow rule for the specified action, then sends a packe=
t
> that
> +        should NOT match the rule to confirm:
> +        - For 'drop': non-matching packets ARE received (not dropped)
> +        - For 'queue': non-matching packets are NOT steered to the targe=
t
> queue
> +        - For 'modify': non-matching packets arrive unmodified
> +
> +        This ensures flow rules only affect matching traffic before
> +        running the actual action tests.
>
>          Args:
> -            packet: Scapy packet to send and verify.
> -            should_receive: Indicate whether the packet should be
> received.
> +            action_type: The action being tested ('drop', 'queue',
> 'modify').
>          """
> -        received =3D send_packet_and_capture(packet)
> -        contains_packet =3D any(
> -            packet.haslayer(Raw) and b"xxxxx" in packet.load for packet
> in received
>

I see that this will work, but if we want to verify with xxxxx do you want
to just pack x*5 earlier in the file when you build a packet? Just trying
to keep things 1:1.


> -        )
> -        verify(
> -            should_receive =3D=3D contains_packet,
> -            f"Packet was {'dropped' if should_receive else 'received'}",
> +        non_matching_packet =3D (
> +            Ether(src=3D"02:00:00:00:00:00", dst=3D"02:00:00:00:00:01")
> +            / IP(src=3D"192.168.100.1", dst=3D"192.168.100.2")
> +            / UDP(sport=3D9999, dport=3D9998)
> +            / Raw(load=3D"CONFIDENCE" + "X" * 22)
>          )
>
> -    def _send_packet_and_verify_queue(
> -        self, packet: Packet, test_queue: int, testpmd: TestPmd
> -    ) -> None:
> -        """Send packet and verify queue stats show packet was received.
> +        with TestPmd(rx_queues=3D4, tx_queues=3D4) as testpmd:
> +            if action_type =3D=3D "drop":
> +                drop_rule =3D FlowRule(
> +                    direction=3D"ingress",
> +                    pattern=3D["eth / ipv4 src is 192.168.1.1 / udp dst =
is
> 53"],
> +                    actions=3D["drop"],
> +                )
> +                flow_id =3D testpmd.flow_create(flow_rule=3Ddrop_rule,
> port_id=3D0)
>

I see it's a basic flow rule, but do we need to run flow_validate() first
anyways?


>
> -        Args:
> -            packet: Scapy packet to send to the SUT.
> -            test_queue: Represents the queue the test packet is being
> sent to.
> -            testpmd: TestPmd instance being used to send test packet.
> -        """
> -        testpmd.set_verbose(level=3D8)
> -        testpmd.start()
> -        send_packet_and_capture(packet=3Dpacket)
> +                testpmd.start()
> +                received =3D send_packet_and_capture(non_matching_packet=
)
> +                testpmd.stop()
> +                contains_packet =3D any(
> +                    p.haslayer(Raw) and b"CONFIDENCE" in
> bytes(p[Raw].load) for p in received
> +                )
> +                testpmd.flow_delete(flow_id, port_id=3D0)
> +                verify(
> +                    contains_packet,
> +                    "Confidence check failed: non-matching packet droppe=
d
> by drop rule",
> +                )
> +
> +            elif action_type =3D=3D "queue":
> +                queue_rule =3D FlowRule(
> +                    direction=3D"ingress",
> +                    pattern=3D[
> +                        "eth src is aa:bb:cc:dd:ee:ff / ipv4 src is
> 10.255.255.254 "
> +                        "dst is 10.255.255.253 / udp src is 12345 dst is
> 54321"
> +                    ],
> +                    actions=3D["queue index 3"],
> +                )
> +                flow_id =3D testpmd.flow_create(flow_rule=3Dqueue_rule,
> port_id=3D0)
> +
> +                testpmd.set_verbose(level=3D8)
> +                testpmd.start()
> +                send_packet_and_capture(non_matching_packet)
> +                verbose_output =3D
> testpmd.extract_verbose_output(testpmd.stop())
> +                received_on_target =3D any(p.queue_id =3D=3D 3 for p in
> verbose_output)
> +                testpmd.flow_delete(flow_id, port_id=3D0)
> +                verify(
> +                    not received_on_target,
> +                    "Confidence check failed: non-matching packet steere=
d
> to queue 3",
>

I guess there is a baked in assumption here that a packet which does not
match this rule cannot be rx in queue 3. Is this true? Is it guaranteed to
be rx in another queue, and if so which one?


> +                )
> +
> +        log(f"Confidence check passed for '{action_type}' action")
> +
> +    def _verify_queue(self, packet: Packet, queue_id: int, testpmd:
> TestPmd, **kwargs: Any) -> None:
> +        """Verify packet is received on the expected queue."""
> +        send_packet_and_capture(packet)
>          verbose_output =3D testpmd.extract_verbose_output(testpmd.stop()=
)
> -        received =3D False
> -        for testpmd_packet in verbose_output:
> -            if testpmd_packet.queue_id =3D=3D test_queue:
> -                received =3D True
> -        verify(received, f"Expected packet was not received on queue
> {test_queue}")
> +        received_on_queue =3D any(p.queue_id =3D=3D queue_id for p in
> verbose_output)
> +        verify(received_on_queue, f"Packet not received on queue
> {queue_id}")
>
> -    def _send_packet_and_verify_modification(self, packet: Packet,
> expected_packet: Packet) -> None:
> -        """Send packet and verify the expected modifications are present
> upon reception.
> -
> -        Args:
> -            packet: Scapy packet to send to the SUT.
> -            expected_packet: Scapy packet that should match the received
> packet.
> -        """
> +    def _verify_drop(self, packet: Packet, **kwargs: Any) -> None:
> +        """Verify packet is dropped."""
>          received =3D send_packet_and_capture(packet)
> +        contains_packet =3D any(p.haslayer(Raw) and b"XXXXX" in p.load f=
or
> p in received)
> +        verify(not contains_packet, "Packet was not dropped")
>
> -        # verify reception
> -        verify(received !=3D [], "Packet was never received.")
> -
> -        log(f"SENT PACKET:     {packet.summary()}")
> -        log(f"EXPECTED PACKET: {expected_packet.summary()}")
> -        for packet in received:
> -            log(f"RECEIVED PACKET: {packet.summary()}")
> +    def _verify_modify(
>

More naming complaints. :) If this method ONLY checks dst address
modifications, can you rename to _verify_modify_dst_address or similar?


> +        self, packet: Packet, expected_packet: Packet, testpmd: TestPmd,
> **kwargs: Any
> +    ) -> None:
> +        """Verify packet modifications."""
> +        testpmd.start()
> +        received =3D send_packet_and_capture(packet)
> +        testpmd.stop()
>
> -        expected_ip_dst =3D expected_packet[IP].dst if IP in
> expected_packet else None
> -        received_ip_dst =3D received[IP].dst if IP in received else None
> +        verify(
> +            any(p.haslayer(Raw) and b"XXXXX" in p.load for p in received=
),
> +            "Test packet with payload marker not found",
> +        )
>
> -        expected_mac_dst =3D expected_packet[Ether].dst if Ether in
> expected_packet else None
> -        received_mac_dst =3D received[Ether].dst if Ether in received el=
se
> None
> +        test_packet =3D None
> +        for pkt in received:
> +            if pkt.haslayer(Raw) and b"XXXXX" in pkt.load:
> +                test_packet =3D pkt
> +                break
>
> -        # verify modification
> -        if expected_ip_dst is not None:
> +        if IP in expected_packet and test_packet is not None:
>              verify(
> -                received_ip_dst =3D=3D expected_ip_dst,
> -                f"IPv4 dst mismatch: expected {expected_ip_dst}, got
> {received_ip_dst}",
> +                test_packet[IP].dst =3D=3D expected_packet[IP].dst,
> +                f"IPv4 dst mismatch: expected {expected_packet[IP].dst},
> got {test_packet[IP].dst}",
>              )
>
> -        if expected_mac_dst is not None:
> +        if Ether in expected_packet and test_packet is not None:
>              verify(
> -                received_mac_dst =3D=3D expected_mac_dst,
> -                f"MAC dst mismatch: expected {expected_mac_dst}, got
> {received_mac_dst}",
> +                test_packet[Ether].dst =3D=3D expected_packet[Ether].dst=
,
> +                f"MAC dst mismatch: expected
> {expected_packet[Ether].dst}, "
> +                f"got {test_packet[Ether].dst}",
>              )
>
> -    def _send_packet_and_verify_jump(
> +    def _run_tests(
>          self,
> -        packets: list[Packet],
> -        flow_rules: list[FlowRule],
> -        test_queues: list[int],
> -        testpmd: TestPmd,
> +        test_cases: list[FlowTestCase],
> +        port_id: int =3D 0,
>      ) -> None:
> -        """Create a testpmd session with every rule in the given list,
> verify jump behavior.
> -
> -        Args:
> -            packets: List of packets to send.
> -            flow_rules: List of flow rules to create in the same session=
.
> -            test_queues: List of Rx queue IDs each packet should be
> received on.
> -            testpmd: TestPmd instance to create flows on.
> -        """
> -        testpmd.set_verbose(level=3D8)
> -        for flow in flow_rules:
> -            is_valid =3D testpmd.flow_validate(flow_rule=3Dflow, port_id=
=3D0)
> -            verify_else_skip(is_valid, "flow rule failed validation.")
> +        """Execute a sequence of test cases."""
> +        with TestPmd(rx_queues=3D4, tx_queues=3D4) as testpmd:
> +            for test_case in test_cases:
> +                log(f"Testing: {test_case.description}")
>
> -            try:
> -                testpmd.flow_create(flow_rule=3Dflow, port_id=3D0)
> -            except InteractiveCommandExecutionError:
> -                log("Flow validation passed, but flow creation failed.")
> -                fail("Failed flow creation")
> +                result =3D FlowTestResult(
> +                    description=3Dtest_case.description,
> +                    passed=3DFalse,
> +                    flow_rule_pattern=3D" /
> ".join(test_case.flow_rule.pattern),
> +                    sent_packet=3Dtest_case.packet,
> +                )
>
> -        for packet, test_queue in zip(packets, test_queues):
> -            testpmd.start()
> -            send_packet_and_capture(packet=3Dpacket)
> -            verbose_output =3D
> testpmd.extract_verbose_output(testpmd.stop())
> -            received =3D False
> -            for testpmd_packet in verbose_output:
> -                if testpmd_packet.queue_id =3D=3D test_queue:
> -                    received =3D True
> -            verify(received, f"Expected packet was not received on queue
> {test_queue}")
> +                try:
> +                    is_valid =3D
> testpmd.flow_validate(flow_rule=3Dtest_case.flow_rule, port_id=3Dport_id)
> +                    if not is_valid:
> +                        result.skipped =3D True
> +                        result.failure_reason =3D "Flow rule failed
> validation"
> +                        self.test_suite_results.append(result)
> +                        self.test_case_results.append(result)
>

I think there is a logical issue - if not is_valid, then we need to throw
an exception or continue to the next iteration, not proceed to flow_create
(what is happening now).


> +
> +                    try:
> +                        flow_id =3D testpmd.flow_create(
> +                            flow_rule=3Dtest_case.flow_rule, port_id=3Dp=
ort_id
> +                        )
> +                    except InteractiveCommandExecutionError:
> +                        result.failure_reason =3D "Hardware validated bu=
t
> failed to create flow rule"
> +                        self.test_suite_results.append(result)
> +                        self.test_case_results.append(result)
> +                        continue
> +
> +                    verification_method =3D getattr(self,
> f"_verify_{test_case.verification_type}")
> +
> +                    if test_case.verification_type =3D=3D "queue":
> +                        testpmd.set_verbose(level=3D8)
> +                        testpmd.start()
> +                        verification_method(
> +                            packet=3Dtest_case.packet,
> +                            testpmd=3Dtestpmd,
> +                            **test_case.verification_params,
> +                        )
> +                    elif test_case.verification_type =3D=3D "modify":
> +                        verification_method(
> +                            packet=3Dtest_case.packet,
> +                            expected_packet=3Dtest_case.expected_packet,
> +                            testpmd=3Dtestpmd,
> +                            **test_case.verification_params,
> +                        )
> +                    else:
> +                        verification_method(
> +                            packet=3Dtest_case.packet,
> +                            testpmd=3Dtestpmd,
> +                            **test_case.verification_params,
> +                        )
> +
> +                    testpmd.flow_delete(flow_id, port_id=3Dport_id)
> +                    result.passed =3D True
> +                    self.test_suite_results.append(result)
> +                    self.test_case_results.append(result)
> +
> +                except SkippedTestException as e:
> +                    result.skipped =3D True
> +                    result.failure_reason =3D f"Skipped: {str(e)}"
> +                    self.test_suite_results.append(result)
> +                    self.test_case_results.append(result)
> +
> +    def _log_test_suite_summary(self) -> None:
>

I'm struggling with what is the value of the _log_test_suite_summary and
also _log_test_cast_failures.

Overall, for each flowtest, we need to track:

1. pass/fail/skip
2. reason for pass/fail/skip
3. Flow rule string
4. Scapy packet

And this needs to be conspicuously logged, and clear (so, clear reason for
failure given with each flowtest).

I see that the test suite summary is included in the log file, but I had to
scroll through a lot of logs in order to get to the summary. I wonder if
there is a better solution (like including more info in
results_summary.txt). Can discuss tomorrow.


> +        """Log a summary of all test results."""
> +        if not self.test_suite_results:
> +            return
> +
> +        passed_tests =3D [r for r in self.test_suite_results if r.passed=
]
> +        skipped_tests =3D [r for r in self.test_suite_results if r.skipp=
ed]
> +        failed_tests =3D [r for r in self.test_suite_results if not
> r.passed and not r.skipped]
> +
> +        log(f"Total tests run: {len(self.test_suite_results)}")
> +        log(f"Passed: {len(passed_tests)}")
> +        log(f"Skipped: {len(skipped_tests)}")
> +        log(f"Failed: {len(failed_tests)}")
> +
> +        if passed_tests:
> +            log("\nPASSED TESTS:")
> +            for result in passed_tests:
> +                log(f"  {result.description}")
> +                log(f"    Sent Packet: {result.sent_packet}")
> +
> +        if skipped_tests:
> +            log("\nSKIPPED TESTS:")
>

Change to skipped rules, passed rules, failed rules, etc.


> +            for result in skipped_tests:
> +                log(f"  {result.description}")
> +                log(f"    Pattern: {result.flow_rule_pattern}")
> +                log(f"    Reason: {result.failure_reason}")
> +                log(f"    Sent Packet: {result.sent_packet}")
> +
> +        if failed_tests:
> +            log("\nFAILED TESTS:")
> +            for result in failed_tests:
> +                log(f"  {result.description}")
> +                log(f"    Pattern: {result.flow_rule_pattern}")
> +                log(f"    Reason: {result.failure_reason}")
> +                log(f"    Sent Packet: {result.sent_packet}")
> +
> +    def _log_test_case_failures(self) -> None:
> +        """Log each pattern that failed for a given test case."""
> +        failures =3D [r for r in self.test_case_results if not r.passed =
and
> not r.skipped]
> +
> +        if failures:
> +            patterns =3D "\n".join(f"\t  - {r.flow_rule_pattern}" for r =
in
> failures)
> +
> +            self.test_case_results =3D []
> +
> +            fail(
> +                "Flow rule passed validation but failed creation.\n"
> +                "\tFailing flow rule patterns:\n"
> +                f"{patterns}"
>

See my full comment at the end, but split out patterns to flow_create
failures and failure coming from devices not implementing a rule correctly
(i.e. the behavior doesn't align with what the testsuite expects).


>
> -
> -    @func_test
> -    def drop_action_IP(self) -> None:
> -        """Validate flow rules with drop actions and ethernet patterns.
> +        This test creates a two-stage pipeline:
> +        - Group 0: Match on Ethernet src, jump to group 1
> +        - Group 1: Match on IPv4 dst, forward to specific queue
>
>          Steps:
> -            * Create a list of packets to test, with a corresponding flo=
w
> list.
> -            * Launch testpmd.
> -            * Create first flow rule in flow list.
> -            * Send first packet in packet list, capture verbose output.
> -            * Delete flow rule, repeat for all flows/packets.
> +            * Launch testpmd with multiple queues.
> +            * Create flow rule in group 0 that matches eth src and jumps
> to group 1.
> +            * Create flow rule in group 1 that matches ipv4 dst and
> queues to queue 2.
> +            * Send matching packet and verify it arrives on queue 2.
> +            * Send non-matching packet (wrong eth src) and verify it
> doesn't hit queue 2.
>

Same question as earlier (how do we know the packet wont be rx on queue 2
for another reason other than the flow rule). Maybe we do know this based
on established DPDK behavior (I don't know) but if you want to sidestep
this question you can do a different action.


>
>
>
>

Here are the results I just got for a connectx-5. Can you take a closer
look at these to see if you find anything suspicious? For instance, I see
on jump_action, there is a failure from not being able to create rule with
pattern "eth src is 02:00:00:00:00:00." That looks like a very standard and
minimal pattern, so this is worth checking.

Also, I see there are all these failing flow rules below. How do I know
whether these are failing due to flow_validate and flow_create giving
different responses, vs flow_create working and the rule not working
correctly? Both of those checks should add rules to separate sections on
the summary below.

  rte_flow: FAIL
    drop_action: FAIL
      reason: Flow rule passed validation but failed creation.
        Failing flow rule patterns:
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
type is 8
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
type is 0
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
ident is 0
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
ident is 1234
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
seq is 0
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
seq is 1
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
type is 8
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
type is 0
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
ident is 0
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
ident is 1234
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
seq is 0
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
seq is 1
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp type is 8
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp type is 0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp ident is 0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp ident is
1234
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp seq is 0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp seq is 1
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp type is 8
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp type is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp ident is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp ident is
1234
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp seq is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp seq is 1
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
type is 8
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
type is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
ident is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
ident is 1234
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
seq is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
seq is 1
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
type is 8
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
type is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
ident is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
ident is 1234
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
seq is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
seq is 1
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp type is 8
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp type is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp ident is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp ident is
1234
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp seq is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp seq is 1
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp type is 8
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp type is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp ident is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp ident is
1234
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp seq is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp seq is 1
    jump_action: FAIL
      reason: Flow rule passed validation but failed creation.
        Failing flow rule patterns:
          - eth src is 02:00:00:00:00:00
    modify_field_action: FAIL
      reason: Flow rule passed validation but failed creation.
        Failing flow rule patterns:
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp
src is 1234
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp
src is 8080
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp
dst is 80
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp
dst is 443
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp
flags is 2
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp
flags is 16
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp
src is 1234
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp
src is 8080
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp
dst is 80
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp
dst is 443
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp
flags is 2
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp
flags is 16
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / tcp src is 1234
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / tcp src is 808=
0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / tcp dst is 80
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / tcp dst is 443
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / tcp flags is 2
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / tcp flags is 1=
6
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / tcp src is 1234
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / tcp src is 8080
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / tcp dst is 80
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / tcp dst is 443
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / tcp flags is 2
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / tcp flags is 16
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp
src is 1234
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp
src is 8080
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp
dst is 80
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp
dst is 443
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp
flags is 2
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp
flags is 16
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp
src is 1234
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp
src is 8080
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp
dst is 80
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp
dst is 443
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp
flags is 2
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp
flags is 16
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / tcp src is 1234
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / tcp src is 808=
0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / tcp dst is 80
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / tcp dst is 443
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / tcp flags is 2
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / tcp flags is 1=
6
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / tcp src is 1234
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / tcp src is 8080
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / tcp dst is 80
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / tcp dst is 443
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / tcp flags is 2
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / tcp flags is 16
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / udp
src is 5000
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / udp
dst is 53
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / udp
dst is 123
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / udp
src is 5000
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / udp
dst is 53
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / udp
dst is 123
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / udp src is 5000
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / udp src is 500=
0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / udp dst is 53
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / udp dst is 123
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / udp src is 5000
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / udp src is 5000
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / udp dst is 53
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / udp dst is 123
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / udp
src is 5000
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / udp
dst is 53
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / udp
dst is 123
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / udp
src is 5000
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / udp
dst is 53
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / udp
dst is 123
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / udp src is 5000
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / udp src is 500=
0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / udp dst is 53
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / udp dst is 123
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / udp src is 5000
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / udp src is 5000
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / udp dst is 53
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / udp dst is 123
          - eth src is 02:00:00:00:00:00
          - eth dst is 02:00:00:00:00:02
          - eth src is 02:00:00:00:00:00 / vlan vid is 100
          - eth src is 02:00:00:00:00:00 / vlan vid is 200
          - eth src is 02:00:00:00:00:00 / vlan pcp is 0
          - eth src is 02:00:00:00:00:00 / vlan pcp is 7
          - eth dst is 02:00:00:00:00:02 / vlan vid is 100
          - eth dst is 02:00:00:00:00:02 / vlan vid is 200
          - eth dst is 02:00:00:00:00:02 / vlan pcp is 0
          - eth dst is 02:00:00:00:00:02 / vlan pcp is 7
    queue_action: FAIL
      reason: Flow rule passed validation but failed creation.
        Failing flow rule patterns:
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
type is 8
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
type is 0
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
ident is 0
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
ident is 1234
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
seq is 0
          - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp
seq is 1
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
type is 8
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
type is 0
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
ident is 0
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
ident is 1234
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
seq is 0
          - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp
seq is 1
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp type is 8
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp type is 0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp ident is 0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp ident is
1234
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp seq is 0
          - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp seq is 1
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp type is 8
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp type is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp code is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp ident is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp ident is
1234
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp seq is 0
          - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp seq is 1
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
type is 8
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
type is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
ident is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
ident is 1234
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
seq is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp
seq is 1
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
type is 8
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
type is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
ident is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
ident is 1234
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
seq is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp
seq is 1
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp type is 8
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp type is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp ident is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp ident is
1234
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp seq is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp seq is 1
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp type is 8
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp type is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp code is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp ident is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp ident is
1234
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp seq is 0
          - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp seq is 1
 '

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000091e82064979a37a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div><br></div><div dir=3D"ltr"><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 6, 2026 at 4:38=E2=80=AFPM =
Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D"_blank">dmarx@=
iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
<br>
-@requires_nic_capability(NicCapability.FLOW_CTRL)<br>
-class TestRteFlow(TestSuite):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;RTE Flow test suite.<br>
+@dataclass<br>
+class PatternField:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Specification for a single matchable field=
 within a protocol layer.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 scapy_field: str<br>
+=C2=A0 =C2=A0 pattern_field: str<br>
+=C2=A0 =C2=A0 test_values: list[Any]<br></blockquote><div><br></div><div>r=
ename to test_parameters? Or another word more indicative of what these val=
ues are?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
+<br>
+<br>
+@dataclass<br>
+class Layer:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Complete specification for a protocol laye=
r.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 name: str<br>
+=C2=A0 =C2=A0 scapy_class: type<br></blockquote><div><br></div><div>Can sc=
apy_class=C2=A0be type hinted more specifically/clearly? I.e. if Ether, ipv=
6, etc. all have the Packet superclass, can it be type hinted as type[Packe=
t]?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
+=C2=A0 =C2=A0 pattern_name: str<br>
+=C2=A0 =C2=A0 fields: list[PatternField]<br>
+=C2=A0 =C2=A0 requires: list[str] =3D field(default_factory=3Dlist)<br>
+<br>
+=C2=A0 =C2=A0 def build_scapy_layer(self, field_values: dict[str, Any]) -&=
gt; Packet:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Construct a Scapy layer with=
 the given field values.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.scapy_class(**field_values)<br>
+<br>
+<br>
+@dataclass<br>
+class Action:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Specification for a flow action.&quot;&quo=
t;&quot;<br>
+<br>
+=C2=A0 =C2=A0 name: str<br>
+=C2=A0 =C2=A0 action_format: str<br>
+=C2=A0 =C2=A0 verification_type: str<br>
+=C2=A0 =C2=A0 param_builder: Callable[[Any], dict[str, Any]]<br>
+=C2=A0 =C2=A0 expected_packet_builder: Callable[[Packet], Packet] | None =
=3D None<br>
+<br>
+=C2=A0 =C2=A0 def build_action_string(self, value: Any =3D None) -&gt; str=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Generate the action string f=
or a flow rule.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if value is not None and &quot;{value}&quot; i=
n self.action_format:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.action_format.format=
(value=3Dvalue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.action_format<br>
+<br>
+=C2=A0 =C2=A0 def build_verification_params(self, value: Any =3D None) -&g=
t; dict[str, Any]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Generate verification parame=
ters for this action.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.param_builder(value)<br>
+<br>
+=C2=A0 =C2=A0 def build_expected_packet(self, original_packet: Packet) -&g=
t; Packet | None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Build expected packet for mo=
dification actions.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.expected_packet_builder:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.expected_packet_buil=
der(original_packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
+<br>
+<br>
+@dataclass<br>
+class FlowTestCase:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;A complete test case ready for execution.&=
quot;&quot;&quot;<br></blockquote><div><br></div><div>There is already such=
 a thing as a testcase in DTS and this is not one and is not integrated int=
o the framework as a testcase, so call it something different for clarity. =
The naming makes it seem like it&#39;s a testcase subclass or something but=
 it is totally unrelated. I do see how this is &quot;like a testcase&quot; =
so I get the choice - I just think it is overlapping with what we already h=
ave name wise. :) Maybe just change to &quot;FlowTest&quot;?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 flow_rule: FlowRule<br>
+=C2=A0 =C2=A0 packet: Packet<br>
+=C2=A0 =C2=A0 verification_type: str<br>
+=C2=A0 =C2=A0 verification_params: dict[str, Any]<br>
+=C2=A0 =C2=A0 description: str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 expected_packet: Packet | None =3D None<br>
+<br>
+<br>
+@dataclass<br>
+class FlowTestResult:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Result of a single test case execution.&qu=
ot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 description: str<br>
+=C2=A0 =C2=A0 passed: bool<br>
+=C2=A0 =C2=A0 failure_reason: str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 flow_rule_pattern: str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 skipped: bool =3D False<br>
+=C2=A0 =C2=A0 sent_packet: Packet | None =3D None<br>
+<br>
+<br>
+LAYERS: dict[str, Layer] =3D {<br></blockquote><div><br></div><div>I reali=
ze the purpose of this system is to create dependencies between different p=
rotocols (because they are at different network layers) but this is a list =
of protocols and I think it should be renamed as such. And I would rename t=
he layer class to protocol unless you see an issue.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 &quot;eth&quot;: Layer(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;eth&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DEther,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;eth&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;src&quot;, &q=
uot;src&quot;, [&quot;02:00:00:00:00:00&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dst&quot;, &q=
uot;dst&quot;, [&quot;02:00:00:00:00:02&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;ipv4&quot;: Layer(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;ipv4&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DIP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;ipv4&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;src&quot;, &q=
uot;src&quot;, [&quot;192.168.1.1&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dst&quot;, &q=
uot;dst&quot;, [&quot;192.168.1.2&quot;]),</blockquote><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;ttl&quot;, &q=
uot;ttl&quot;, [64, 128]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;tos&quot;, &q=
uot;tos&quot;, [0, 4]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 requires=3D[&quot;eth&quot;],<br></blockquote>=
<div><br></div><div>Is this &quot;requires&quot; field actually used in the=
 business logic? I don&#39;t see that right now.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 ),</blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
+=C2=A0 =C2=A0 &quot;ipv6&quot;: Layer(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;ipv6&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DIPv6,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;ipv6&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;src&quot;, &q=
uot;src&quot;, [&quot;2001:db8::1&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dst&quot;, &q=
uot;dst&quot;, [&quot;2001:db8::2&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;tc&quot;, &qu=
ot;tc&quot;, [0, 4]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;hlim&quot;, &=
quot;hop&quot;, [64, 128]),<br></blockquote><div><br></div><div>How did you=
 decide which patternfields to include vs which to omit? For instance see 4=
.12.19.4 here=C2=A0<a href=3D"https://doc.dpdk.org/guides/testpmd_app_ug/te=
stpmd_funcs.html#enqueueing-creation-of-flow-rules" target=3D"_blank">https=
://doc.dpdk.org/guides/testpmd_app_ug/testpmd_funcs.html#enqueueing-creatio=
n-of-flow-rules</a></div><div><br></div><div>Why omit the possible patternf=
ield=C2=A0&quot;proto.&quot; Is it because it will not integrate with your =
generator because you don&#39;t know what the next proto is for the validat=
ion step, or some other reason?</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 requires=3D[&quot;eth&quot;],<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;tcp&quot;: Layer(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;tcp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DTCP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;tcp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;sport&quot;, =
&quot;src&quot;, [1234, 8080]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dport&quot;, =
&quot;dst&quot;, [80, 443]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;flags&quot;, =
&quot;flags&quot;, [2, 16]),</blockquote><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 requires=3D[&quot;eth&quot;, &quot;ipv4&quot;]=
,<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;udp&quot;: Layer(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;udp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DUDP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;udp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;sport&quot;, =
&quot;src&quot;, [5000]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dport&quot;, =
&quot;dst&quot;, [53, 123]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 requires=3D[&quot;eth&quot;, &quot;ipv4&quot;]=
,<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;vlan&quot;: Layer(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;vlan&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DDot1Q,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;vlan&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;vlan&quot;, &=
quot;vid&quot;, [100, 200]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;prio&quot;, &=
quot;pcp&quot;, [0, 7]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 requires=3D[&quot;eth&quot;],<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;icmp&quot;: Layer(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;icmp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DICMP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;icmp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;type&quot;, &=
quot;type&quot;, [8, 0]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;code&quot;, &=
quot;code&quot;, [0]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;id&quot;, &qu=
ot;ident&quot;, [0, 1234]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;seq&quot;, &q=
uot;seq&quot;, [0, 1]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 requires=3D[&quot;eth&quot;, &quot;ipv4&quot;]=
,<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;sctp&quot;: Layer(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;sctp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DSCTP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;sctp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;sport&quot;, =
&quot;src&quot;, [2905, 3868]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;dport&quot;, =
&quot;dst&quot;, [2905, 3868]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;tag&quot;, &q=
uot;tag&quot;, [1, 12346]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 requires=3D[&quot;eth&quot;, &quot;ipv4&quot;]=
,<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;arp&quot;: Layer(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;arp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scapy_class=3DARP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_name=3D&quot;arp_eth_ipv4&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;psrc&quot;, &=
quot;spa&quot;, [&quot;192.168.1.1&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;pdst&quot;, &=
quot;tpa&quot;, [&quot;192.168.1.2&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatternField(&quot;op&quot;, &qu=
ot;opcode&quot;, [1, 2]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 requires=3D[&quot;eth&quot;],<br>
+=C2=A0 =C2=A0 ),<br></blockquote><div><br></div><div>From looking at the r=
te_flow docs, I think it would make sense to test flow offload of a VXLAN p=
acket. Is it possible to add some VXLAN type packets to your LAYER_STACKS l=
ist like:</div><div><br></div><div>[&quot;eth&quot;, &quot;ipv6&quot;, &quo=
t;tcp&quot;, &quot;vxlan&quot;, &quot;eth&quot;, &quot;ipv6&quot;, &quot;ud=
p&quot;]</div><div><br></div><div>or is there an implementation difficulty =
associated with testing the above?</div><div><br></div><div>Or, what about =
testing INVERT item?=C2=A0<a href=3D"https://doc.dpdk.org/guides-24.07/prog=
_guide/rte_flow.html#meta-item-types" target=3D"_blank">https://doc.dpdk.or=
g/guides-24.07/prog_guide/rte_flow.html#meta-item-types</a></div><div><br><=
/div><div>It seems like your system is creating a large portion of possible=
 rules, but some patternfields=C2=A0or items are missing (not sure if this =
is because of implementation difficulty, a decision regarding what is perti=
nent test coverage, or something else). One possible way forward is to exte=
nd the minimal rule matrix testsuite (from last year) adding stuff like vxl=
an, invert, and other missing pattern/item/actions which are in the DPDK rt=
e flow docs, and then maintain this generator based large rule matrix as a =
separate testsuite. Or, we can drive everything through this testsuite and =
continue to extend the coverage within it. Let me know your thoughts.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+<br>
+def _build_ipv4_src_to_dst_expected(packet: Packet) -&gt; Packet:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Build expected packet for IPV4 src to dst =
copy.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 expected =3D cast(Packet, packet.copy())<br>
+=C2=A0 =C2=A0 if IP in expected:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected[IP].dst =3D packet[IP].src<br>
+=C2=A0 =C2=A0 return expected<br>
+<br>
+<br>
+def _build_mac_src_to_dst_expected(packet: Packet) -&gt; Packet:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Build expected packet for MAC src to dst c=
opy.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 expected =3D cast(Packet, packet.copy())<br>
+=C2=A0 =C2=A0 if Ether in expected:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected[Ether].dst =3D packet[Ether].src<br>
+=C2=A0 =C2=A0 return expected<br>
+<br>
+<br>
+ACTIONS: dict[str, Action] =3D {<br>
+=C2=A0 =C2=A0 &quot;queue&quot;: Action(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;queue&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action_format=3D&quot;queue index {value}&quot=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_type=3D&quot;queue&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 param_builder=3Dlambda queue_id: {&quot;queue_=
id&quot;: queue_id},<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;drop&quot;: Action(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;drop&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action_format=3D&quot;drop&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_type=3D&quot;drop&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 param_builder=3Dlambda _: {&quot;should_receiv=
e&quot;: False},<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;modify_ipv4_src_to_dst&quot;: Action(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;modify_ipv4_src_to_dst&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action_format=3D&quot;modify_field op set dst_=
type &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ipv4_dst src_type ipv4_src width 32 / qu=
eue index 0&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_type=3D&quot;modify&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 param_builder=3Dlambda _: {},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packet_builder=3D_build_ipv4_src_to_d=
st_expected,<br>
+=C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 &quot;modify_mac_src_to_dst&quot;: Action(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;modify_mac_src_to_dst&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action_format=3D&quot;modify_field op set dst_=
type &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mac_dst src_type mac_src width 48 / queu=
e index 0&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_type=3D&quot;modify&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 param_builder=3Dlambda _: {},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packet_builder=3D_build_mac_src_to_ds=
t_expected,<br>
+=C2=A0 =C2=A0 ),<br>
+}<br></blockquote><div><br></div><div>It is worth thinking about how we ca=
n get coverage for other actions, like &quot;count.&quot; Again, maybe this=
 is where we need to split out between the generator system producing a hig=
h number of rules for the most standard protocols and actions, and an (exte=
nded) explicit list of patterns/actions which are tested, that allows us to=
 also get some coverage for the less common actions like &quot;count.&quot;=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+LAYER_STACKS =3D [<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;ipv4&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;ipv4&quot;, &quot;tcp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;ipv4&quot;, &quot;udp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;ipv4&quot;, &quot;icmp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;ipv4&quot;, &quot;sctp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;ipv6&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;ipv6&quot;, &quot;tcp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;ipv6&quot;, &quot;udp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;ipv6&quot;, &quot;sctp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;vlan&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;vlan&quot;, &quot;ipv4&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;vlan&quot;, &quot;ipv4&quot;, &quot;=
tcp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;vlan&quot;, &quot;ipv4&quot;, &quot;=
udp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;vlan&quot;, &quot;ipv4&quot;, &quot;=
sctp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;vlan&quot;, &quot;ipv6&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;vlan&quot;, &quot;ipv6&quot;, &quot;=
tcp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;vlan&quot;, &quot;ipv6&quot;, &quot;=
udp&quot;],<br>
+=C2=A0 =C2=A0 [&quot;eth&quot;, &quot;arp&quot;],<br>
+]<br></blockquote><div><br></div><div>See comment above about VXLAN.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+<br>
+class FlowTestGenerator:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Generates test cases by combining patterns=
 and actions.&quot;&quot;&quot;<br></blockquote><div><br></div><div>One thi=
ng I wonder about here is whether this should be written into the testsuite=
 or should be testsuite API code (to be used by other testsuites in the fut=
ure). You clearly at thinking the former is good - what is your perspective=
 on whether there may be any need for usage of this class in other testsuit=
es in the future? I don&#39;t necessarily think so but want to ask the ques=
tion.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
+<br>
+=C2=A0 =C2=A0 def __init__(self, layers: dict[str, Layer], actions: dict[s=
tr, Action]):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Initialize the generator wit=
h layer and action specifications.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.layers =3D layers<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.actions =3D actions<br>
+<br>
+=C2=A0 =C2=A0 def _build_multi_layer_packet(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_stack: list[str],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 all_field_values: dict[str, dict[str, Any]],<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_payload: bool =3D True,<br>
+=C2=A0 =C2=A0 ) -&gt; Packet:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Build a packet from multiple=
 protocol layers.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: Packet =3D Ether()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_layer_name =3D None<br>
<br>
-=C2=A0 =C2=A0 This suite consists of 12 test cases:<br>
-=C2=A0 =C2=A0 1. Queue Action Ethernet: Verifies queue actions with ethern=
et patterns<br>
-=C2=A0 =C2=A0 2. Queue Action IP: Verifies queue actions with IPv4 and IPv=
6 patterns<br>
-=C2=A0 =C2=A0 3. Queue Action L4: Verifies queue actions with TCP and UDP =
patterns<br>
-=C2=A0 =C2=A0 4. Queue Action VLAN: Verifies queue actions with VLAN patte=
rns<br>
-=C2=A0 =C2=A0 5. Drop Action Eth: Verifies drop action with ethernet patte=
rns<br>
-=C2=A0 =C2=A0 6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 =
patterns<br>
-=C2=A0 =C2=A0 7. Drop Action L4: Verifies drop actions with TCP and UDP pa=
tterns<br>
-=C2=A0 =C2=A0 8. Drop Action VLAN: Verifies drop actions with VLAN pattern=
s<br>
-=C2=A0 =C2=A0 9. Modify Field Action: Verifies packet modification pattern=
s<br>
-=C2=A0 =C2=A0 10. Egress Rules: Verifies previously covered rules are stil=
l valid as egress<br>
-=C2=A0 =C2=A0 11. Jump Action: Verifies packet behavior given grouped flow=
s<br>
-=C2=A0 =C2=A0 12. Priority Attribute: Verifies packet behavior given flows=
 with different priorities<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for layer_name in layer_stack:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_spec =3D self.layers[layer=
_name]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 values =3D all_field_values.get(=
layer_name, {})<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer =3D layer_spec.build_scapy=
_layer(values)<br>
<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if layer_name =3D=3D &quot;eth&q=
uot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D layer<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if prev_layer_name=
 =3D=3D &quot;ipv6&quot; and layer_name in [&quot;tcp&quot;, &quot;udp&quot=
;, &quot;sctp&quot;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nh_m=
ap =3D {&quot;tcp&quot;: 6, &quot;udp&quot;: 17, &quot;sctp&quot;: 132}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pack=
et[IPv6].nh =3D nh_map[layer_name]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D packet =
/ layer<br>
<br>
-=C2=A0 =C2=A0 def _runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_layer_name =3D layer_name<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if add_payload:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D packet / Raw(load=3D&=
quot;X&quot; * 32)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return packet<br>
+<br>
+=C2=A0 =C2=A0 def generate(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method: Callable[..., Any],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flows: list[FlowRule],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: list[Packet],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packets: list[Packet] | None =3D None=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *args: Any,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 **kwargs: Any,<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Runner method that validates=
 each flow using the corresponding verification method.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_names: list[str],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action_name: str,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action_value: Any =3D None,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id: int =3D 0,<br>
+=C2=A0 =C2=A0 ) -&gt; list[FlowTestCase]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Generate test cases for patt=
erns matching fields across multiple layers.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 This method identifies every possible combinat=
ion of one field per layer.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 For each field combination, it iterates throug=
h the available test values.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 If fields have an unequal number of test value=
s, it cycles through the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shorter lists to ensure every specific value i=
n every field is tested.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method: Callable th=
at performs verification logic.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows: List of flow rules to cre=
ate and test.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: List of packets corresp=
onding to each flow.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Number representing the=
 port to create flows on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packets: List of packet=
s to check sent packets against in modification cases.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *args: Additional positional arg=
uments to pass to the verification method.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **kwargs: Additional keyword arg=
uments to pass to the verification method.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_names: List of layer names=
 to match.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action_name: Name of the action =
to apply.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action_value: Optional value for=
 parameterized actions.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id: Flow group ID.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 List of FlowTestCase objects rea=
dy for execution.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action_spec =3D self.actions[action_name]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Organize layers into lists of matchable fiel=
ds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_field_specs =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for layer_name in layer_names:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_spec =3D self.layers[layer=
_name]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Capture the layer spec and the=
 field spec for each field in the layer<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_field_specs.append([(layer=
_spec, f) for f in layer_spec.fields])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases =3D []<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Iterate through every combination of fields =
across the requested layers<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # For [&#39;eth&#39;, &#39;ipv4&#39;], this pr=
oduces: (eth_src, ipv4_src), (eth_src, ipv4_dst), etc.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for field_combo in product(*layer_field_specs)=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Determine how many test cases =
are needed to cover all values in this combo<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_vals =3D max(len(f_spec.test=
_values) for _, f_spec in field_combo)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Cycle through the test values =
for these fields<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in range(max_vals):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern_parts =3D =
[]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 all_field_values: =
dict[str, dict[str, Any]] =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_parts =3D []<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for layer_spec, fi=
eld_spec in field_combo:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Se=
lect value by index<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =
=3D field_spec.test_values[i % len(field_spec.test_values)]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 patt=
ern_parts.append(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;{layer_spec.pattern_name} {field_spec.pattern_field} is {=
val}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # St=
ore value for Scapy packet building<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <=
a href=3D"http://layer_spec.name" rel=3D"noreferrer" target=3D"_blank">laye=
r_spec.name</a> not in all_field_values:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 all_field_values[<a href=3D"http://layer_spec.name" rel=3D"noref=
errer" target=3D"_blank">layer_spec.name</a>] =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 all_=
field_values[<a href=3D"http://layer_spec.name" rel=3D"noreferrer" target=
=3D"_blank">layer_spec.name</a>][field_spec.scapy_field] =3D val<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc=
_parts.append(f&quot;{<a href=3D"http://layer_spec.name" rel=3D"noreferrer"=
 target=3D"_blank">layer_spec.name</a>}[{field_spec.scapy_field}=3D{val}]&q=
uot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 full_pattern =3D &=
quot; / &quot;.join(pattern_parts)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule =3D Flow=
Rule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dire=
ction=3D&quot;ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 patt=
ern=3D[full_pattern],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acti=
ons=3D[action_spec.build_action_string(action_value)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grou=
p_id=3Dgroup_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_payload =3D ac=
tion_spec.verification_type in [&quot;drop&quot;, &quot;modify&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D self._b=
uild_multi_layer_packet(layer_names, all_field_values, add_payload)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packet =
=3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if action_spec.ver=
ification_type =3D=3D &quot;modify&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expe=
cted_packet =3D action_spec.build_expected_packet(packet)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases.append(=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flow=
TestCase(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 flow_rule=3Dflow_rule,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 packet=3Dpacket,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 verification_type=3Daction_spec.verification_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 verification_params=3Daction_spec.build_verification_params(acti=
on_value),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 description=3D&quot; / &quot;.join(desc_parts) + f&quot; -&gt; {=
<a href=3D"http://action_spec.name" rel=3D"noreferrer" target=3D"_blank">ac=
tion_spec.name</a>}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 expected_packet=3Dexpected_packet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def zip_lists(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rules: list[FlowRule],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets1: list[Packet],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets2: list[Packet] | None,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) -&gt; Iterator[tuple[FlowRule, Packet, Packe=
t | None]]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Method that cr=
eates an iterable zip containing lists used in runner.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rules: List of flo=
w rules.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets1: List of =
packets.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets2: Optional=
 list of packets, excluded from zip if not passed to runner.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return cast(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Iterator[tuple[Flo=
wRule, Packet, Packet | None]],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zip_longest(rules,=
 packets1, packets2 or [], fillvalue=3DNone),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return test_cases<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd(rx_queues=3D4, tx_queues=3D4) as =
testpmd:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for flow, packet, expected_packe=
t in zip_lists(flows, packets, expected_packets):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_valid =3D testp=
md.flow_validate(flow_rule=3Dflow, port_id=3Dport_id)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify_else_skip(i=
s_valid, &quot;flow rule failed validation.&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow=
_id =3D testpmd.flow_create(flow_rule=3Dflow, port_id=3Dport_id)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except Interactive=
CommandExecutionError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(=
&quot;Flow rule validation passed, but flow creation failed.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail=
(&quot;Failed flow creation&quot;)<br>
+@requires_nic_capability(NicCapability.FLOW_CTRL)<br>
+class TestRteFlow(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;RTE Flow test suite.<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verification_me=
thod =3D=3D self._send_packet_and_verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fication_method(packet=3Dpacket, *args, **kwargs)<br>
+=C2=A0 =C2=A0 This suite consists of 4 test cases:<br>
+=C2=A0 =C2=A0 1. Queue Action: Verifies queue actions with multi-layer pat=
terns<br>
+=C2=A0 =C2=A0 2. Drop Action: Verifies drop actions with multi-layer patte=
rns<br>
+=C2=A0 =C2=A0 3. Modify Field Action: Verifies modify_field actions with m=
ulti-layer patterns<br>
+=C2=A0 =C2=A0 4. Jump Action: Verifies jump action between flow groups<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif verification_=
method =3D=3D self._send_packet_and_verify_queue:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fication_method(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 packet=3Dpacket, test_queue=3Dkwargs[&quot;test_queue&quot;], te=
stpmd=3Dtestpmd<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif verification_=
method =3D=3D self._send_packet_and_verify_modification:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fication_method(packet=3Dpacket, expected_packet=3Dexpected_packet)<br>
+=C2=A0 =C2=A0 def set_up_suite(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Initialize the test generato=
r and result tracking.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.generator =3D FlowTestGenerator(LAYERS, A=
CTIONS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_suite_results: list[FlowTestResult] =
=3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_case_results: list[FlowTestResult] =
=3D []<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.flow_delet=
e(flow_id, port_id=3Dport_id)<br>
+=C2=A0 =C2=A0 def _run_confidence_check(self, action_type: str) -&gt; None=
:<br></blockquote><div><br></div><div>=C2=A0Where is the handling for when =
action_type=3D=3D&quot;queue&quot;?</div><div><br></div><div>Also, should b=
e called _verify_basic_transmission or something more descriptive. I know w=
e said confidence check at the team meeting but let&#39;s make it clear wha=
t the function is doing.</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Verify that non-matching pac=
kets are unaffected by flow rules.<br>
<br>
-=C2=A0 =C2=A0 def _send_packet_and_verify(self, packet: Packet, should_rec=
eive: bool =3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Generate a packet, send to t=
he DUT, and verify it is forwarded back.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Creates a flow rule for the specified action, =
then sends a packet that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 should NOT match the rule to confirm:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - For &#39;drop&#39;: non-matching packets ARE=
 received (not dropped)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - For &#39;queue&#39;: non-matching packets ar=
e NOT steered to the target queue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - For &#39;modify&#39;: non-matching packets a=
rrive unmodified<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 This ensures flow rules only affect matching t=
raffic before<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 running the actual action tests.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: Scapy packet to send and=
 verify.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 should_receive: Indicate whether=
 the packet should be received.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action_type: The action being te=
sted (&#39;drop&#39;, &#39;queue&#39;, &#39;modify&#39;).<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D send_packet_and_capture(packet)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 contains_packet =3D any(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet.haslayer(Raw) and b&quot;=
xxxxx&quot; in packet.load for packet in received<br></blockquote><div><br>=
</div><div>I see that this will work, but if we want to verify with=C2=A0xx=
xxx do you want to just pack x*5 earlier in the file when you build a packe=
t? Just trying to keep things 1:1.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 should_receive =3D=3D contains_p=
acket,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Packet was {&#39;dropped&=
#39; if should_receive else &#39;received&#39;}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 non_matching_packet =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(src=3D&quot;02:00:00:00:00=
:00&quot;, dst=3D&quot;02:00:00:00:00:01&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / IP(src=3D&quot;192.168.100.1&q=
uot;, dst=3D&quot;192.168.100.2&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / UDP(sport=3D9999, dport=3D9998=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Raw(load=3D&quot;CONFIDENCE&qu=
ot; + &quot;X&quot; * 22)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 def _send_packet_and_verify_queue(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, packet: Packet, test_queue: int, testpmd=
: TestPmd<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send packet and verify queue=
 stats show packet was received.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd(rx_queues=3D4, tx_queues=3D4) as =
testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if action_type =3D=3D &quot;drop=
&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_rule =3D Flow=
Rule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dire=
ction=3D&quot;ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 patt=
ern=3D[&quot;eth / ipv4 src is 192.168.1.1 / udp dst is 53&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acti=
ons=3D[&quot;drop&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_id =3D testpm=
d.flow_create(flow_rule=3Ddrop_rule, port_id=3D0)<br></blockquote><div><br>=
</div><div>I see it&#39;s a basic flow rule, but do we need to run flow_val=
idate() first anyways?</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: Scapy packet to send to =
the SUT.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queue: Represents the queue=
 the test packet is being sent to.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmd instance being =
used to send test packet.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_verbose(level=3D8)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 send_packet_and_capture(packet=3Dpacket)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D send_=
packet_and_capture(non_matching_packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.stop()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 contains_packet =
=3D any(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p.ha=
slayer(Raw) and b&quot;CONFIDENCE&quot; in bytes(p[Raw].load) for p in rece=
ived<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.flow_delet=
e(flow_id, port_id=3D0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cont=
ains_packet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Confidence check failed: non-matching packet dropped by drop rule&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif action_type =3D=3D &quot;qu=
eue&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_rule =3D Flo=
wRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dire=
ction=3D&quot;ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 patt=
ern=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;eth src is aa:bb:cc:dd:ee:ff / ipv4 src is 10.255.255.254 =
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;dst is 10.255.255.253 / udp src is 12345 dst is 54321&quot=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acti=
ons=3D[&quot;queue index 3&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_id =3D testpm=
d.flow_create(flow_rule=3Dqueue_rule, port_id=3D0)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_verbos=
e(level=3D8)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_packet_and_ca=
pture(non_matching_packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose_output =3D=
 testpmd.extract_verbose_output(testpmd.stop())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_on_target=
 =3D any(p.queue_id =3D=3D 3 for p in verbose_output)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.flow_delet=
e(flow_id, port_id=3D0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 not =
received_on_target,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Confidence check failed: non-matching packet steered to queue 3&quot;,<br=
></blockquote><div><br></div><div>I guess there is a baked in assumption he=
re that a packet which does not match this rule cannot be rx in queue 3. Is=
 this true? Is it guaranteed to be rx in another queue, and if so which one=
?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;Confidence check passed for &#39;{a=
ction_type}&#39; action&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def _verify_queue(self, packet: Packet, queue_id: int, testp=
md: TestPmd, **kwargs: Any) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Verify packet is received on=
 the expected queue.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 send_packet_and_capture(packet)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verbose_output =3D testpmd.extract_verbos=
e_output(testpmd.stop())<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D False<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for testpmd_packet in verbose_output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if testpmd_packet.queue_id =3D=
=3D test_queue:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D True<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(received, f&quot;Expected packet was no=
t received on queue {test_queue}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received_on_queue =3D any(p.queue_id =3D=3D qu=
eue_id for p in verbose_output)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(received_on_queue, f&quot;Packet not re=
ceived on queue {queue_id}&quot;)<br>
<br>
-=C2=A0 =C2=A0 def _send_packet_and_verify_modification(self, packet: Packe=
t, expected_packet: Packet) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send packet and verify the e=
xpected modifications are present upon reception.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: Scapy packet to send to =
the SUT.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packet: Scapy packet th=
at should match the received packet.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 def _verify_drop(self, packet: Packet, **kwargs: Any) -&gt; =
None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Verify packet is dropped.&qu=
ot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0received =3D send_packet_and_capture(pack=
et)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 contains_packet =3D any(p.haslayer(Raw) and b&=
quot;XXXXX&quot; in p.load for p in received)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(not contains_packet, &quot;Packet was n=
ot dropped&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify reception<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(received !=3D [], &quot;Packet was neve=
r received.&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;SENT PACKET:=C2=A0 =C2=A0 =C2=A0{pa=
cket.summary()}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;EXPECTED PACKET: {expected_packet.s=
ummary()}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for packet in received:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;RECEIVED PACKET: {pac=
ket.summary()}&quot;)<br>
+=C2=A0 =C2=A0 def _verify_modify(<br></blockquote><div><br></div><div>More=
 naming complaints. :) If this method ONLY checks dst address modifications=
, can you rename to _verify_modify_dst_address or similar?</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, packet: Packet, expected_packet: Packet,=
 testpmd: TestPmd, **kwargs: Any<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Verify packet modifications.=
&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D send_packet_and_capture(packet)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.stop()<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_ip_dst =3D expected_packet[IP].dst if=
 IP in expected_packet else None<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 received_ip_dst =3D received[IP].dst if IP in =
received else None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 any(p.haslayer(Raw) and b&quot;X=
XXXX&quot; in p.load for p in received),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Test packet with payload m=
arker not found&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_mac_dst =3D expected_packet[Ether].ds=
t if Ether in expected_packet else None<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 received_mac_dst =3D received[Ether].dst if Et=
her in received else None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_packet =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for pkt in received:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if pkt.haslayer(Raw) and b&quot;=
XXXXX&quot; in pkt.load:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_packet =3D pk=
t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify modification<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if expected_ip_dst is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if IP in expected_packet and test_packet is no=
t None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verify(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_ip_dst =
=3D=3D expected_ip_dst,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;IPv4 dst mi=
smatch: expected {expected_ip_dst}, got {received_ip_dst}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_packet[IP].ds=
t =3D=3D expected_packet[IP].dst,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;IPv4 dst mi=
smatch: expected {expected_packet[IP].dst}, got {test_packet[IP].dst}&quot;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if expected_mac_dst is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if Ether in expected_packet and test_packet is=
 not None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verify(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_mac_dst =
=3D=3D expected_mac_dst,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;MAC dst mis=
match: expected {expected_mac_dst}, got {received_mac_dst}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_packet[Ether]=
.dst =3D=3D expected_packet[Ether].dst,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;MAC dst mis=
match: expected {expected_packet[Ether].dst}, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;got {test_p=
acket[Ether].dst}&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 def _send_packet_and_verify_jump(<br>
+=C2=A0 =C2=A0 def _run_tests(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: list[Packet],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rules: list[FlowRule],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queues: list[int],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases: list[FlowTestCase],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int =3D 0,<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create a testpmd session wit=
h every rule in the given list, verify jump behavior.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: List of packets to send=
.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rules: List of flow rules t=
o create in the same session.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queues: List of Rx queue ID=
s each packet should be received on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmd instance to cre=
ate flows on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_verbose(level=3D8)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for flow in flow_rules:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_valid =3D testpmd.flow_valida=
te(flow_rule=3Dflow, port_id=3D0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify_else_skip(is_valid, &quot=
;flow rule failed validation.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Execute a sequence of test c=
ases.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd(rx_queues=3D4, tx_queues=3D4) as =
testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for test_case in test_cases:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;Testing=
: {test_case.description}&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.flow_creat=
e(flow_rule=3Dflow, port_id=3D0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except InteractiveCommandExecuti=
onError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(&quot;Flow val=
idation passed, but flow creation failed.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail(&quot;Failed =
flow creation&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D FlowTes=
tResult(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc=
ription=3Dtest_case.description,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass=
ed=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow=
_rule_pattern=3D&quot; / &quot;.join(test_case.flow_rule.pattern),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sent=
_packet=3Dtest_case.packet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for packet, test_queue in zip(packets, test_qu=
eues):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_packet_and_capture(packet=
=3Dpacket)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose_output =3D testpmd.extra=
ct_verbose_output(testpmd.stop())<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D False<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for testpmd_packet in verbose_ou=
tput:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if testpmd_packet.=
queue_id =3D=3D test_queue:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rece=
ived =3D True<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(received, f&quot;Expected=
 packet was not received on queue {test_queue}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_v=
alid =3D testpmd.flow_validate(flow_rule=3Dtest_case.flow_rule, port_id=3Dp=
ort_id)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if n=
ot is_valid:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 result.skipped =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 result.failure_reason =3D &quot;Flow rule failed validation&quot=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 self.test_suite_results.append(result)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 self.test_case_results.append(result)<br></blockquote><div><br><=
/div><div>I think there is a logical issue - if not is_valid, then we need =
to throw an exception or continue to the next iteration, not proceed to flo=
w_create (what is happening now).</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 flow_id =3D testpmd.flow_create(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule=3Dtest_case.flow_rule, port_id=3Dport_id=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
pt InteractiveCommandExecutionError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 result.failure_reason =3D &quot;Hardware validated but failed to=
 create flow rule&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 self.test_suite_results.append(result)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 self.test_case_results.append(result)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fication_method =3D getattr(self, f&quot;_verify_{test_case.verification_ty=
pe}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if t=
est_case.verification_type =3D=3D &quot;queue&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 testpmd.set_verbose(level=3D8)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 verification_method(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 packet=3Dtest_case.packet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 testpmd=3Dtestpmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 **test_case.verification_params,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif=
 test_case.verification_type =3D=3D &quot;modify&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 verification_method(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 packet=3Dtest_case.packet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 expected_packet=3Dtest_case.expected_packet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 testpmd=3Dtestpmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 **test_case.verification_params,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 verification_method(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 packet=3Dtest_case.packet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 testpmd=3Dtestpmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 **test_case.verification_params,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
pmd.flow_delete(flow_id, port_id=3Dport_id)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resu=
lt.passed =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.test_suite_results.append(result)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.test_case_results.append(result)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except SkippedTest=
Exception as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resu=
lt.skipped =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resu=
lt.failure_reason =3D f&quot;Skipped: {str(e)}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.test_suite_results.append(result)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.test_case_results.append(result)<br>
+<br>
+=C2=A0 =C2=A0 def _log_test_suite_summary(self) -&gt; None:<br></blockquot=
e><div><br></div><div>I&#39;m struggling with what is the value of the _log=
_test_suite_summary and also _log_test_cast_failures.</div><div><br></div><=
div>Overall, for each flowtest, we need to track:</div><div><br></div><div>=
1. pass/fail/skip</div><div>2. reason for pass/fail/skip</div><div>3. Flow =
rule string</div><div>4. Scapy packet</div><div><br></div><div>And this nee=
ds to be conspicuously logged, and clear (so, clear reason for failure give=
n with each flowtest).</div><div><br></div><div>I see that the test suite s=
ummary is included in the log file, but I had to scroll through a lot of lo=
gs in order to get to the summary. I wonder if there is a better solution (=
like including more info in results_summary.txt). Can discuss tomorrow.</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Log a summary of all test re=
sults.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.test_suite_results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 passed_tests =3D [r for r in self.test_suite_r=
esults if r.passed]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 skipped_tests =3D [r for r in self.test_suite_=
results if r.skipped]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 failed_tests =3D [r for r in self.test_suite_r=
esults if not r.passed and not r.skipped]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;Total tests run: {len(self.test_sui=
te_results)}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;Passed: {len(passed_tests)}&quot;)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;Skipped: {len(skipped_tests)}&quot;=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;Failed: {len(failed_tests)}&quot;)<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if passed_tests:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(&quot;\nPASSED TESTS:&quot;)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in passed_tests:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;=C2=A0 =
{result.description}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;=C2=A0 =
=C2=A0 Sent Packet: {result.sent_packet}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if skipped_tests:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(&quot;\nSKIPPED TESTS:&quot;=
)<br></blockquote><div><br></div><div>Change to skipped rules, passed rules=
, failed rules, etc.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in skipped_tests:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;=C2=A0 =
{result.description}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;=C2=A0 =
=C2=A0 Pattern: {result.flow_rule_pattern}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;=C2=A0 =
=C2=A0 Reason: {result.failure_reason}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;=C2=A0 =
=C2=A0 Sent Packet: {result.sent_packet}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if failed_tests:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(&quot;\nFAILED TESTS:&quot;)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in failed_tests:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;=C2=A0 =
{result.description}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;=C2=A0 =
=C2=A0 Pattern: {result.flow_rule_pattern}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;=C2=A0 =
=C2=A0 Reason: {result.failure_reason}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;=C2=A0 =
=C2=A0 Sent Packet: {result.sent_packet}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def _log_test_case_failures(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Log each pattern that failed=
 for a given test case.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 failures =3D [r for r in self.test_case_result=
s if not r.passed and not r.skipped]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if failures:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 patterns =3D &quot;\n&quot;.join=
(f&quot;\t=C2=A0 - {r.flow_rule_pattern}&quot; for r in failures)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_case_results =3D []<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Flow rule pa=
ssed validation but failed creation.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;\tFailing fl=
ow rule patterns:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{patterns}&=
quot;<br></blockquote><div><br></div><div>See my full comment at the end, b=
ut split out patterns to flow_create failures and failure coming from devic=
es not implementing a rule correctly (i.e. the behavior doesn&#39;t align w=
ith what the testsuite expects).</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><br>
-<br>
-=C2=A0 =C2=A0 @func_test<br>
-=C2=A0 =C2=A0 def drop_action_IP(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with dro=
p actions and ethernet patterns.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 This test creates a two-stage pipeline:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Group 0: Match on Ethernet src, jump to grou=
p 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Group 1: Match on IPv4 dst, forward to speci=
fic queue<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a list of packets to te=
st, with a corresponding flow list.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch testpmd.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create first flow rule in flow=
 list.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Send first packet in packet li=
st, capture verbose output.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Delete flow rule, repeat for a=
ll flows/packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch testpmd with multiple q=
ueues.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create flow rule in group 0 th=
at matches eth src and jumps to group 1.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create flow rule in group 1 th=
at matches ipv4 dst and queues to queue 2.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Send matching packet and verif=
y it arrives on queue 2.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Send non-matching packet (wron=
g eth src) and verify it doesn&#39;t hit queue 2.<br></blockquote><div><br>=
</div><div>Same question as earlier (how do we know the packet wont be rx o=
n queue 2 for another reason other than the flow rule). Maybe we do know th=
is based on established DPDK behavior (I don&#39;t know) but if you want to=
 sidestep this question you can do a different action.</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br>
<br></blockquote><div><br></div><div><br></div><div>Here are the results I =
just got for a connectx-5. Can you take a closer look at these to see if yo=
u find anything suspicious? For instance, I see on jump_action, there is a =
failure from not being able to create rule with pattern &quot;eth src is 02=
:00:00:00:00:00.&quot; That looks like a very standard and minimal pattern,=
 so this is worth checking.</div><div><br></div><div>Also, I see there are =
all these failing flow rules below. How do I know whether these are failing=
 due to flow_validate and flow_create giving different responses, vs flow_c=
reate working and the rule not working correctly? Both of those checks shou=
ld add rules to separate sections on the summary below.</div><div><br></div=
>=C2=A0 rte_flow: FAIL<br>=C2=A0 =C2=A0 drop_action: FAIL<br>=C2=A0 =C2=A0 =
=C2=A0 reason: Flow rule passed validation but failed creation.<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Failing flow rule patterns:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / ic=
mp type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00=
:00:00 / ipv4 src is 192.168.1.1 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / ic=
mp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00=
:00:00 / ipv4 src is 192.168.1.1 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / ic=
mp ident is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:0=
0:00:00:00 / ipv4 src is 192.168.1.1 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 =
/ icmp seq is 1<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00=
:00:00:00 / ipv4 dst is 192.168.1.2 / icmp type is 8<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 =
/ icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:0=
0:00:00:00 / ipv4 dst is 192.168.1.2 / icmp code is 0<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 =
/ icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:=
00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp ident is 1234<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.=
1.2 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:0=
0:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp seq is 1<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp=
 type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:0=
0:00 / ipv4 ttl is 128 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp code is 0<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl i=
s 128 / icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 0=
2:00:00:00:00:00 / ipv4 ttl is 64 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp iden=
t is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00=
:00 / ipv4 ttl is 64 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
- eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp seq is 1<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 =
/ icmp type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:0=
0:00:00:00 / ipv4 tos is 4 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp code is 0<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 to=
s is 4 / icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is =
02:00:00:00:00:00 / ipv4 tos is 0 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp ident =
is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:0=
0 / ipv4 tos is 0 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - e=
th src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp seq is 1<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.1=
68.1.1 / icmp type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is =
02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp type is 0<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.1=
68.1.1 / icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is =
02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp ident is 0<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.1=
68.1.1 / icmp ident is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst=
 is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp seq is 0<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 19=
2.168.1.1 / icmp seq is 1<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst i=
s 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp type is 8<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst is 19=
2.168.1.2 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst =
is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp code is 0<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst is 19=
2.168.1.2 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst=
 is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp ident is 1234<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst i=
s 192.168.1.2 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth d=
st is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp seq is 1<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 6=
4 / icmp type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00=
:00:00:00:02 / ipv4 ttl is 128 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp code is 0=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv=
4 ttl is 128 / icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth d=
st is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp ident is 0<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / ic=
mp ident is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:0=
0:00:00:02 / ipv4 ttl is 64 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp seq is 1<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 to=
s is 0 / icmp type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is =
02:00:00:00:00:02 / ipv4 tos is 4 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp code is=
 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / i=
pv4 tos is 4 / icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth d=
st is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp ident is 0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp =
ident is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:0=
0:00:02 / ipv4 tos is 0 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp seq is 1<br>=C2=
=A0 =C2=A0 jump_action: FAIL<br>=C2=A0 =C2=A0 =C2=A0 reason: Flow rule pass=
ed validation but failed creation.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Failing f=
low rule patterns:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00=
:00:00:00:00<br>=C2=A0 =C2=A0 modify_field_action: FAIL<br>=C2=A0 =C2=A0 =
=C2=A0 reason: Flow rule passed validation but failed creation.<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Failing flow rule patterns:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ds=
t is 192.168.1.2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:0=
0:00:00:00 / ipv4 ttl is 64<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src=
 is 02:00:00:00:00:00 / ipv4 ttl is 128<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 4<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.1=
68.1.1<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02=
 / ipv4 dst is 192.168.1.2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst =
is 02:00:00:00:00:02 / ipv4 ttl is 64<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 sr=
c is 192.168.1.1 / tcp src is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - =
eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp src is 8080<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 s=
rc is 192.168.1.1 / tcp dst is 80<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - e=
th src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp dst is 443<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 sr=
c is 192.168.1.1 / tcp flags is 2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - e=
th src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp flags is 16<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ds=
t is 192.168.1.2 / tcp src is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - =
eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp src is 8080<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 d=
st is 192.168.1.2 / tcp dst is 80<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - e=
th src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp dst is 443<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ds=
t is 192.168.1.2 / tcp flags is 2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - e=
th src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp flags is 16<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tt=
l is 64 / tcp src is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src i=
s 02:00:00:00:00:00 / ipv4 ttl is 128 / tcp src is 8080<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / tcp =
dst is 80<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00=
:00 / ipv4 ttl is 128 / tcp dst is 443<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / tcp flags is 2<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl i=
s 128 / tcp flags is 16<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is =
02:00:00:00:00:00 / ipv4 tos is 0 / tcp src is 1234<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / tcp src is =
8080<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 /=
 ipv4 tos is 0 / tcp dst is 80<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth =
src is 02:00:00:00:00:00 / ipv4 tos is 4 / tcp dst is 443<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / tcp f=
lags is 2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00=
:00 / ipv4 tos is 4 / tcp flags is 16<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp src is 1234=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv=
4 src is 192.168.1.1 / tcp src is 8080<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp dst is 8=
0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ip=
v4 src is 192.168.1.1 / tcp dst is 443<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp flags is=
 2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / i=
pv4 src is 192.168.1.1 / tcp flags is 16<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp src is 1=
234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / =
ipv4 dst is 192.168.1.2 / tcp src is 8080<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp dst i=
s 80<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 /=
 ipv4 dst is 192.168.1.2 / tcp dst is 443<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp flags=
 is 2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 =
/ ipv4 dst is 192.168.1.2 / tcp flags is 16<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / tcp src is 1234<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 t=
tl is 128 / tcp src is 8080<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst=
 is 02:00:00:00:00:02 / ipv4 ttl is 64 / tcp dst is 80<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / tcp ds=
t is 443<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:=
02 / ipv4 ttl is 64 / tcp flags is 2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
- eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / tcp flags is 16<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos i=
s 0 / tcp src is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02=
:00:00:00:00:02 / ipv4 tos is 4 / tcp src is 8080<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / tcp dst is 8=
0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ip=
v4 tos is 4 / tcp dst is 443<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth ds=
t is 02:00:00:00:00:02 / ipv4 tos is 0 / tcp flags is 2<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / tcp f=
lags is 16<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:0=
0:00 / ipv4 src is 192.168.1.1 / udp src is 5000<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / ud=
p dst is 53<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:=
00:00 / ipv4 src is 192.168.1.1 / udp dst is 123<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / ud=
p src is 5000<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:0=
0:00:00 / ipv4 dst is 192.168.1.2 / udp dst is 53<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / ud=
p dst is 123<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00=
:00:00 / ipv4 ttl is 64 / udp src is 5000<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / udp src is 5000<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 =
ttl is 64 / udp dst is 53<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src i=
s 02:00:00:00:00:00 / ipv4 ttl is 128 / udp dst is 123<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / udp src =
is 5000<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:0=
0 / ipv4 tos is 4 / udp src is 5000<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -=
 eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / udp dst is 53<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / u=
dp dst is 123<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:0=
0:00:02 / ipv4 src is 192.168.1.1 / udp src is 5000<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / u=
dp dst is 53<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00=
:00:02 / ipv4 src is 192.168.1.1 / udp dst is 123<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / ud=
p src is 5000<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:0=
0:00:02 / ipv4 dst is 192.168.1.2 / udp dst is 53<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / ud=
p dst is 123<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00=
:00:02 / ipv4 ttl is 64 / udp src is 5000<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / udp src is 5000<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 =
ttl is 64 / udp dst is 53<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst i=
s 02:00:00:00:00:02 / ipv4 ttl is 128 / udp dst is 123<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / udp src =
is 5000<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:0=
2 / ipv4 tos is 4 / udp src is 5000<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -=
 eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / udp dst is 53<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / u=
dp dst is 123<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:0=
0:00:00<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:0=
2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / vl=
an vid is 100<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:0=
0:00:00 / vlan vid is 200<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src i=
s 02:00:00:00:00:00 / vlan pcp is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -=
 eth src is 02:00:00:00:00:00 / vlan pcp is 7<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / vlan vid is 100<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / vlan vid is 200<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / vlan =
pcp is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:=
02 / vlan pcp is 7<br>=C2=A0 =C2=A0 queue_action: FAIL<br>=C2=A0 =C2=A0 =C2=
=A0 reason: Flow rule passed validation but failed creation.<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Failing flow rule patterns:<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp =
type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00=
:00 / ipv4 src is 192.168.1.1 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp =
code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00=
:00 / ipv4 src is 192.168.1.1 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp =
ident is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:0=
0:00:00 / ipv4 src is 192.168.1.1 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / ic=
mp seq is 1<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:=
00:00 / ipv4 dst is 192.168.1.2 / icmp type is 8<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / ic=
mp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00=
:00:00 / ipv4 dst is 192.168.1.2 / icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / ic=
mp ident is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:0=
0:00:00 / ipv4 dst is 192.168.1.2 / icmp ident is 1234<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 =
/ icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00=
:00:00:00 / ipv4 dst is 192.168.1.2 / icmp seq is 1<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp type =
is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 /=
 ipv4 ttl is 128 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - e=
th src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp code is 0<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 /=
 icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00=
:00:00:00 / ipv4 ttl is 64 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp ident is 12=
34<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / i=
pv4 ttl is 64 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth s=
rc is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp seq is 1<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp =
type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00=
:00 / ipv4 tos is 4 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
- eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp code is 0<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 =
/ icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:0=
0:00:00:00 / ipv4 tos is 0 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp ident is 1234=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src is 02:00:00:00:00:00 / ipv=
4 tos is 0 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth src =
is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp seq is 1<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 =
/ icmp type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:0=
0:00:00:02 / ipv4 src is 192.168.1.1 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 =
/ icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:0=
0:00:00:02 / ipv4 src is 192.168.1.1 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 =
/ icmp ident is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:=
00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp seq is 0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1=
.1 / icmp seq is 1<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00=
:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp type is 8<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1=
.2 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:0=
0:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp code is 0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1=
.2 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:=
00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp ident is 1234<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.1=
68.1.2 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 0=
2:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp seq is 1<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icm=
p type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:=
00:02 / ipv4 ttl is 128 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp code is 0<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl i=
s 128 / icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 0=
2:00:00:00:00:02 / ipv4 ttl is 64 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp iden=
t is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00=
:02 / ipv4 ttl is 64 / icmp seq is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
- eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp seq is 1<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 =
/ icmp type is 8<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:0=
0:00:00:02 / ipv4 tos is 4 / icmp type is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp code is 0<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 to=
s is 4 / icmp code is 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is =
02:00:00:00:00:02 / ipv4 tos is 0 / icmp ident is 0<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp ident =
is 1234<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - eth dst is 02:00:00:00:00:0=
2 / ipv4 tos is 0 / icmp seq is 0<br><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp seq is 1</div><di=
v>=C2=A0&#39;</div><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a hre=
f=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div></div>
</div>
</div>
</div>
</div>
</div>

--000000000000091e82064979a37a--
