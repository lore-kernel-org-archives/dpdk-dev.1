Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC325E87859
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 19:37:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85DE5402EE;
	Tue,  3 Feb 2026 20:37:24 +0100 (CET)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mails.dpdk.org (Postfix) with ESMTP id 4892C4029D
 for <dev@dpdk.org>; Tue,  3 Feb 2026 20:37:23 +0100 (CET)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-794fe698e36so3004297b3.2
 for <dev@dpdk.org>; Tue, 03 Feb 2026 11:37:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770147442; cv=none;
 d=google.com; s=arc-20240605;
 b=Dxd0zifsyHnQvKbL+SYT+1BhWitdbtwQJQCaf1fbPjlBF7sCTWjxvxGLnc4Lhv6v4d
 0QhsV2YqP/ZSrrApHTuVB11BFpShL869b6Q8bPhohUdiuFYpWnAdfZ7CiIlHqdMLYNSU
 tJuHza8uShPzo8EVrq/gOh5aWdQmP2sDmW1hd1rqVQMzK7dOFXG8NAXHQTsE6o7bB9lb
 NdxT98LzAbfwYHdswC+uSbBKQhJ+v87kBfHuuAaKS7/eRzWzuJvSmeshDNM7qEpG4d6S
 yRXM2/N0XDScJxAMqmboniVgPwk43PFJa4zMISjGvlfXCOuI7IJz1R6NVUYleeoS+lxP
 /Q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iLEsVddrJo8CPX3PXB2m1xT2hNyX9hexkG5oJC28jD0=;
 fh=3mRu1+tn66MI7TffUSI71G8AVYccaTaAJPec0Y7o39k=;
 b=CilTyHBXK7AXgXv6JiSvlKcwZt8//diPJXYMH0wIVK0yyPGvGz+HC508Pct9mz5Y3l
 LB1bBlBQRedVjaHEnvJaS1fQ1Fr+2DiDflkuZZDQfy94X2OEzgjwq28SNL91hjkURT5b
 tTXEoLCayO2uZP2YTmjp/U3L0FWmMRK7hM7clCXmhVXdtjjHCJdSDxXOo4cT0MU97qbT
 Hy93tyspjt+CjoDGsQhCCccimIZvHJX8ADpn1/dnmY8rcr+10bE75nrNWmbtrqc8HZeH
 SnnyuGESHlGTz3jaBw9welgq/MIRrjDPtJ9vH9tNGFvhZ3yd01ZfLVGc3Lp53JHMJwAA
 aTDw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770147442; x=1770752242; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLEsVddrJo8CPX3PXB2m1xT2hNyX9hexkG5oJC28jD0=;
 b=X3h5PFdJa8nBunNq6NCl+HzxGyFpbRZzaNnf0mMnrIgsEVDwB25i7QIEf9ZT/8xmVh
 zf6R9HlM0XnYDJQHiGJGNWPl8D5bJI4kHD/sCy92C5zWV7ZlkZ/VK2uS5ixX/EWRr0oz
 bgf0a7Tpzo6COlvsrvA5YZ+/gr6toWuYP4Y4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770147442; x=1770752242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iLEsVddrJo8CPX3PXB2m1xT2hNyX9hexkG5oJC28jD0=;
 b=nZUFqEdZUJxDin2Za9mC9VuMfkHw2pf+sAY2uoIzwotlT2kDycLgY10dDgFbb7GQBU
 LWUodpWcb8DyetT50jqU0B8cv5LF85fkXh2947fiRfZQT2TIjhpTVj+NyClPxo12Vn+T
 HTiKwzi64kFy+yugWKe8YS+kvpqrd1WgqNxZ7rV/sQifg5leqsyJDHrBPpqHhAAjEtc4
 gQo+y+ebbDUPnHyi+H/zmCM9SxjZEfs/XRMGDnfRC5MTcbghYtac0Kvo7mFQrM3JcSIj
 +SjC+syccdymrMjDlm2mfsrCW2fOVve/RZnR6advrL8Vaja7agNA5lcwgw1+QyXUU46V
 K2hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXEhdqynzuv6+KvY4aiaa2EYG7qAEEH29YAKRMWcBx8dt70shaeNxxqlPix8tEHQ120Ds=@dpdk.org
X-Gm-Message-State: AOJu0YzTTfehDCjoMhF9/UiImDqhH+ZYyFBiiabdN9g6tKeo+pghBNxt
 WJ8hzUtU/V0ny8aNliw7ihOcsUKYmBYDPmNKE3bX0GiOQgcrG0V9uZZAZjTjLaLa6jZ+h34dUK0
 AbwY89wKP8um4iTWXGv5Q9rSks5QtOO3g6jW30OV4kQ==
X-Gm-Gg: AZuq6aLd2qKtuTce8b8/ElPok7bRQfz1GDv1pdxhrD1KtVYsrq5OlSymy1DljKrKkZa
 9i20dxyIL3zifaDdAW05vqWfhY0Ond1nP5ldVX4sxTk+VSKDpMaYL2nQvx6604GYNMAO9JUT9Jl
 4xhFP7pEiQnfdM4mxVIPGJMFnwXwAX1LL6Q+Jn1CqoraDZrkVHYD7hdMNSZ2yjwGlHF4FADQBxM
 +CY7SPwXozDvmFaLhVwG7F1qwXYWGI3iXg8CeiFytDOPB8b5gF012bmF9ZL9nMvM6Bdn56PPv4L
 O3pkVuoP2XUG8P5QwzCUpzMiQLFoIA==
X-Received: by 2002:a05:690c:b87:b0:793:db81:f1dd with SMTP id
 00721157ae682-794fe6ca360mr7058347b3.4.1770147441965; Tue, 03 Feb 2026
 11:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20260106213803.205934-1-dmarx@iol.unh.edu>
 <CAJvnSUAoT4BhfHG83Zc9E-pJN11Nrjj3OAk232ziWETNVORz7A@mail.gmail.com>
In-Reply-To: <CAJvnSUAoT4BhfHG83Zc9E-pJN11Nrjj3OAk232ziWETNVORz7A@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 3 Feb 2026 14:37:11 -0500
X-Gm-Features: AZwV_QgI681Zu5a1aFEocggNCcccFy_EQeudJsZZnAagABYe-R2o6oKYXoGFHuk
Message-ID: <CABD7UXNajy1y0P1LjFc5ExiBEBCYk_dOzqNGrJudjk=dQ_0xiA@mail.gmail.com>
Subject: Re: [PATCH v1] dts: refactor flow suite with generator pattern
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jan 28, 2026 at 4:43=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:
>
>
>
> On Tue, Jan 6, 2026 at 4:38=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrot=
e:
>>
>>
>>
>> -@requires_nic_capability(NicCapability.FLOW_CTRL)
>> -class TestRteFlow(TestSuite):
>> -    """RTE Flow test suite.
>> +@dataclass
>> +class PatternField:
>> +    """Specification for a single matchable field within a protocol lay=
er."""
>> +
>> +    scapy_field: str
>> +    pattern_field: str
>> +    test_values: list[Any]
>
>
> rename to test_parameters? Or another word more indicative of what these =
values are?

I think that's reasonable, I'll update it in the next version

>
>>
>> +
>> +
>> +@dataclass
>> +class Layer:
>> +    """Complete specification for a protocol layer."""
>> +
>> +    name: str
>> +    scapy_class: type
>
>
> Can scapy_class be type hinted more specifically/clearly? I.e. if Ether, =
ipv6, etc. all have the Packet superclass, can it be type hinted as type[Pa=
cket]?

Yes good catch

>
>>
>> +    pattern_name: str
>> +    fields: list[PatternField]
>> +    requires: list[str] =3D field(default_factory=3Dlist)
>> +
>> +    def build_scapy_layer(self, field_values: dict[str, Any]) -> Packet=
:
>> +        """Construct a Scapy layer with the given field values."""
>> +        return self.scapy_class(**field_values)
>> +
>> +
>> +@dataclass
>> +class Action:
>> +    """Specification for a flow action."""
>> +
>> +    name: str
>> +    action_format: str
>> +    verification_type: str
>> +    param_builder: Callable[[Any], dict[str, Any]]
>> +    expected_packet_builder: Callable[[Packet], Packet] | None =3D None
>> +
>> +    def build_action_string(self, value: Any =3D None) -> str:
>> +        """Generate the action string for a flow rule."""
>> +        if value is not None and "{value}" in self.action_format:
>> +            return self.action_format.format(value=3Dvalue)
>> +        return self.action_format
>> +
>> +    def build_verification_params(self, value: Any =3D None) -> dict[st=
r, Any]:
>> +        """Generate verification parameters for this action."""
>> +        return self.param_builder(value)
>> +
>> +    def build_expected_packet(self, original_packet: Packet) -> Packet =
| None:
>> +        """Build expected packet for modification actions."""
>> +        if self.expected_packet_builder:
>> +            return self.expected_packet_builder(original_packet)
>> +        return None
>> +
>> +
>> +@dataclass
>> +class FlowTestCase:
>> +    """A complete test case ready for execution."""
>
>
> There is already such a thing as a testcase in DTS and this is not one an=
d is not integrated into the framework as a testcase, so call it something =
different for clarity. The naming makes it seem like it's a testcase subcla=
ss or something but it is totally unrelated. I do see how this is "like a t=
estcase" so I get the choice - I just think it is overlapping with what we =
already have name wise. :) Maybe just change to "FlowTest"?

Makes sense, I'll update the docstring to clarify as well

>
>>
>> +
>> +    flow_rule: FlowRule
>> +    packet: Packet
>> +    verification_type: str
>> +    verification_params: dict[str, Any]
>> +    description: str =3D ""
>> +    expected_packet: Packet | None =3D None
>> +
>> +
>> +@dataclass
>> +class FlowTestResult:
>> +    """Result of a single test case execution."""
>> +
>> +    description: str
>> +    passed: bool
>> +    failure_reason: str =3D ""
>> +    flow_rule_pattern: str =3D ""
>> +    skipped: bool =3D False
>> +    sent_packet: Packet | None =3D None
>> +
>> +
>> +LAYERS: dict[str, Layer] =3D {
>
>
> I realize the purpose of this system is to create dependencies between di=
fferent protocols (because they are at different network layers) but this i=
s a list of protocols and I think it should be renamed as such. And I would=
 rename the layer class to protocol unless you see an issue.

Okay that's fair

>
>>
>> +    "eth": Layer(
>> +        name=3D"eth",
>> +        scapy_class=3DEther,
>> +        pattern_name=3D"eth",
>> +        fields=3D[
>> +            PatternField("src", "src", ["02:00:00:00:00:00"]),
>> +            PatternField("dst", "dst", ["02:00:00:00:00:02"]),
>> +        ],
>> +    ),
>> +    "ipv4": Layer(
>> +        name=3D"ipv4",
>> +        scapy_class=3DIP,
>> +        pattern_name=3D"ipv4",
>> +        fields=3D[
>> +            PatternField("src", "src", ["192.168.1.1"]),
>> +            PatternField("dst", "dst", ["192.168.1.2"]),
>>
>> +            PatternField("ttl", "ttl", [64, 128]),
>> +            PatternField("tos", "tos", [0, 4]),
>> +        ],
>> +        requires=3D["eth"],
>
>
> Is this "requires" field actually used in the business logic? I don't see=
 that right now.

Ah, I think I may have left that in from a previous version before
adding the LAYER_STACKS list. I'll remove these fields and run the
suite to make sure the behavior is the same.

>
>>
>> +    ),
>>
>> +    "ipv6": Layer(
>> +        name=3D"ipv6",
>> +        scapy_class=3DIPv6,
>> +        pattern_name=3D"ipv6",
>> +        fields=3D[
>> +            PatternField("src", "src", ["2001:db8::1"]),
>> +            PatternField("dst", "dst", ["2001:db8::2"]),
>> +            PatternField("tc", "tc", [0, 4]),
>> +            PatternField("hlim", "hop", [64, 128]),
>
>
> How did you decide which patternfields to include vs which to omit? For i=
nstance see 4.12.19.4 here https://doc.dpdk.org/guides/testpmd_app_ug/testp=
md_funcs.html#enqueueing-creation-of-flow-rules
>
> Why omit the possible patternfield "proto." Is it because it will not int=
egrate with your generator because you don't know what the next proto is fo=
r the validation step, or some other reason?

It's exactly that, the issue with fields like proto and nh is that
they're dependent on the next protocol in the stack. The generator
selects field values independently, so for example if proto were a
pattern field with test parameters [6, 17], it would generate a rule
like "ipv4 proto is 17" but still build a TCP packet (proto 6) which
would cause a mismatch. I could try adding some additional logic to
the generator to handle these fields, but I removed them for now to
keep it simpler.

>
>>
>> +        ],
>> +        requires=3D["eth"],
>> +    ),
>> +    "tcp": Layer(
>> +        name=3D"tcp",
>> +        scapy_class=3DTCP,
>> +        pattern_name=3D"tcp",
>> +        fields=3D[
>> +            PatternField("sport", "src", [1234, 8080]),
>> +            PatternField("dport", "dst", [80, 443]),
>> +            PatternField("flags", "flags", [2, 16]),
>>
>> +        ],
>> +        requires=3D["eth", "ipv4"],
>> +    ),
>> +    "udp": Layer(
>> +        name=3D"udp",
>> +        scapy_class=3DUDP,
>> +        pattern_name=3D"udp",
>> +        fields=3D[
>> +            PatternField("sport", "src", [5000]),
>> +            PatternField("dport", "dst", [53, 123]),
>> +        ],
>> +        requires=3D["eth", "ipv4"],
>> +    ),
>> +    "vlan": Layer(
>> +        name=3D"vlan",
>> +        scapy_class=3DDot1Q,
>> +        pattern_name=3D"vlan",
>> +        fields=3D[
>> +            PatternField("vlan", "vid", [100, 200]),
>> +            PatternField("prio", "pcp", [0, 7]),
>> +        ],
>> +        requires=3D["eth"],
>> +    ),
>> +    "icmp": Layer(
>> +        name=3D"icmp",
>> +        scapy_class=3DICMP,
>> +        pattern_name=3D"icmp",
>> +        fields=3D[
>> +            PatternField("type", "type", [8, 0]),
>> +            PatternField("code", "code", [0]),
>> +            PatternField("id", "ident", [0, 1234]),
>> +            PatternField("seq", "seq", [0, 1]),
>> +        ],
>> +        requires=3D["eth", "ipv4"],
>> +    ),
>> +    "sctp": Layer(
>> +        name=3D"sctp",
>> +        scapy_class=3DSCTP,
>> +        pattern_name=3D"sctp",
>> +        fields=3D[
>> +            PatternField("sport", "src", [2905, 3868]),
>> +            PatternField("dport", "dst", [2905, 3868]),
>> +            PatternField("tag", "tag", [1, 12346]),
>> +        ],
>> +        requires=3D["eth", "ipv4"],
>> +    ),
>> +    "arp": Layer(
>> +        name=3D"arp",
>> +        scapy_class=3DARP,
>> +        pattern_name=3D"arp_eth_ipv4",
>> +        fields=3D[
>> +            PatternField("psrc", "spa", ["192.168.1.1"]),
>> +            PatternField("pdst", "tpa", ["192.168.1.2"]),
>> +            PatternField("op", "opcode", [1, 2]),
>> +        ],
>> +        requires=3D["eth"],
>> +    ),
>
>
> From looking at the rte_flow docs, I think it would make sense to test fl=
ow offload of a VXLAN packet. Is it possible to add some VXLAN type packets=
 to your LAYER_STACKS list like:
>
> ["eth", "ipv6", "tcp", "vxlan", "eth", "ipv6", "udp"]
>
> or is there an implementation difficulty associated with testing the abov=
e?
>
> Or, what about testing INVERT item? https://doc.dpdk.org/guides-24.07/pro=
g_guide/rte_flow.html#meta-item-types
>
> It seems like your system is creating a large portion of possible rules, =
but some patternfields or items are missing (not sure if this is because of=
 implementation difficulty, a decision regarding what is pertinent test cov=
erage, or something else). One possible way forward is to extend the minima=
l rule matrix testsuite (from last year) adding stuff like vxlan, invert, a=
nd other missing pattern/item/actions which are in the DPDK rte flow docs, =
and then maintain this generator based large rule matrix as a separate test=
suite. Or, we can drive everything through this testsuite and continue to e=
xtend the coverage within it. Let me know your thoughts.

It's essentially due to implementation difficulty. For example, with
VXLAN I would need to add distinctions between inner and outer layers
for protocols that appear twice in the packet. The current generator
assumes a linear stack, so nested layers aren't really feasible as of
right now. I figured this could be something that is added on later
once a more minimal version is merged, same with INVERT. I think the
best approach would be to expand the minimal rule matrix later on with
these items, which we could separate into its own suite like you
suggested.

>
>>
>> +}
>> +
>> +
>> +def _build_ipv4_src_to_dst_expected(packet: Packet) -> Packet:
>> +    """Build expected packet for IPV4 src to dst copy."""
>> +    expected =3D cast(Packet, packet.copy())
>> +    if IP in expected:
>> +        expected[IP].dst =3D packet[IP].src
>> +    return expected
>> +
>> +
>> +def _build_mac_src_to_dst_expected(packet: Packet) -> Packet:
>> +    """Build expected packet for MAC src to dst copy."""
>> +    expected =3D cast(Packet, packet.copy())
>> +    if Ether in expected:
>> +        expected[Ether].dst =3D packet[Ether].src
>> +    return expected
>> +
>> +
>> +ACTIONS: dict[str, Action] =3D {
>> +    "queue": Action(
>> +        name=3D"queue",
>> +        action_format=3D"queue index {value}",
>> +        verification_type=3D"queue",
>> +        param_builder=3Dlambda queue_id: {"queue_id": queue_id},
>> +    ),
>> +    "drop": Action(
>> +        name=3D"drop",
>> +        action_format=3D"drop",
>> +        verification_type=3D"drop",
>> +        param_builder=3Dlambda _: {"should_receive": False},
>> +    ),
>> +    "modify_ipv4_src_to_dst": Action(
>> +        name=3D"modify_ipv4_src_to_dst",
>> +        action_format=3D"modify_field op set dst_type "
>> +        "ipv4_dst src_type ipv4_src width 32 / queue index 0",
>> +        verification_type=3D"modify",
>> +        param_builder=3Dlambda _: {},
>> +        expected_packet_builder=3D_build_ipv4_src_to_dst_expected,
>> +    ),
>> +    "modify_mac_src_to_dst": Action(
>> +        name=3D"modify_mac_src_to_dst",
>> +        action_format=3D"modify_field op set dst_type "
>> +        "mac_dst src_type mac_src width 48 / queue index 0",
>> +        verification_type=3D"modify",
>> +        param_builder=3Dlambda _: {},
>> +        expected_packet_builder=3D_build_mac_src_to_dst_expected,
>> +    ),
>> +}
>
>
> It is worth thinking about how we can get coverage for other actions, lik=
e "count." Again, maybe this is where we need to split out between the gene=
rator system producing a high number of rules for the most standard protoco=
ls and actions, and an (extended) explicit list of patterns/actions which a=
re tested, that allows us to also get some coverage for the less common act=
ions like "count."

Agreed. I actually think I could work the count action into the
generator, since verification would just look at the flow counter and
check if it incremented. But there are definitely other actions with
more complex verifications that wouldn't fit the current design, in
which case the split into two suites would be practical. Right now,
I'm thinking of having the next version include the minimal test
matrix, and separating them later after this suite is merged, but let
me know what you think, or if I should split them earlier.

>
>>
>> +
>> +LAYER_STACKS =3D [
>> +    ["eth"],
>> +    ["eth", "ipv4"],
>> +    ["eth", "ipv4", "tcp"],
>> +    ["eth", "ipv4", "udp"],
>> +    ["eth", "ipv4", "icmp"],
>> +    ["eth", "ipv4", "sctp"],
>> +    ["eth", "ipv6"],
>> +    ["eth", "ipv6", "tcp"],
>> +    ["eth", "ipv6", "udp"],
>> +    ["eth", "ipv6", "sctp"],
>> +    ["eth", "vlan"],
>> +    ["eth", "vlan", "ipv4"],
>> +    ["eth", "vlan", "ipv4", "tcp"],
>> +    ["eth", "vlan", "ipv4", "udp"],
>> +    ["eth", "vlan", "ipv4", "sctp"],
>> +    ["eth", "vlan", "ipv6"],
>> +    ["eth", "vlan", "ipv6", "tcp"],
>> +    ["eth", "vlan", "ipv6", "udp"],
>> +    ["eth", "arp"],
>> +]
>
>
> See comment above about VXLAN.
>
>>
>> +
>> +
>> +class FlowTestGenerator:
>> +    """Generates test cases by combining patterns and actions."""
>
>
> One thing I wonder about here is whether this should be written into the =
testsuite or should be testsuite API code (to be used by other testsuites i=
n the future). You clearly at thinking the former is good - what is your pe=
rspective on whether there may be any need for usage of this class in other=
 testsuites in the future? I don't necessarily think so but want to ask the=
 question.

I think keeping it in the suite makes the most sense for now, since it
has verification methods and dataclasses built in that are directly
related to the test cases. If another suite needs it in the future
(cryptodev?) I could take out the reusable pieces and put it in the
API, but I feel like moving the whole class now might be premature. If
you disagree though, I'm open to suggestions.

>
>>
>> +
>> +    def __init__(self, layers: dict[str, Layer], actions: dict[str, Act=
ion]):
>> +        """Initialize the generator with layer and action specification=
s."""
>> +        self.layers =3D layers
>> +        self.actions =3D actions
>> +
>> +    def _build_multi_layer_packet(
>> +        self,
>> +        layer_stack: list[str],
>> +        all_field_values: dict[str, dict[str, Any]],
>> +        add_payload: bool =3D True,
>> +    ) -> Packet:
>> +        """Build a packet from multiple protocol layers."""
>> +        packet: Packet =3D Ether()
>> +        prev_layer_name =3D None
>>
>> -    This suite consists of 12 test cases:
>> -    1. Queue Action Ethernet: Verifies queue actions with ethernet patt=
erns
>> -    2. Queue Action IP: Verifies queue actions with IPv4 and IPv6 patte=
rns
>> -    3. Queue Action L4: Verifies queue actions with TCP and UDP pattern=
s
>> -    4. Queue Action VLAN: Verifies queue actions with VLAN patterns
>> -    5. Drop Action Eth: Verifies drop action with ethernet patterns
>> -    6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 pattern=
s
>> -    7. Drop Action L4: Verifies drop actions with TCP and UDP patterns
>> -    8. Drop Action VLAN: Verifies drop actions with VLAN patterns
>> -    9. Modify Field Action: Verifies packet modification patterns
>> -    10. Egress Rules: Verifies previously covered rules are still valid=
 as egress
>> -    11. Jump Action: Verifies packet behavior given grouped flows
>> -    12. Priority Attribute: Verifies packet behavior given flows with d=
ifferent priorities
>> +        for layer_name in layer_stack:
>> +            layer_spec =3D self.layers[layer_name]
>> +            values =3D all_field_values.get(layer_name, {})
>> +            layer =3D layer_spec.build_scapy_layer(values)
>>
>> -    """
>> +            if layer_name =3D=3D "eth":
>> +                packet =3D layer
>> +            else:
>> +                if prev_layer_name =3D=3D "ipv6" and layer_name in ["tc=
p", "udp", "sctp"]:
>> +                    nh_map =3D {"tcp": 6, "udp": 17, "sctp": 132}
>> +                    packet[IPv6].nh =3D nh_map[layer_name]
>> +
>> +                packet =3D packet / layer
>>
>> -    def _runner(
>> +            prev_layer_name =3D layer_name
>> +
>> +        if add_payload:
>> +            packet =3D packet / Raw(load=3D"X" * 32)
>> +
>> +        return packet
>> +
>> +    def generate(
>>          self,
>> -        verification_method: Callable[..., Any],
>> -        flows: list[FlowRule],
>> -        packets: list[Packet],
>> -        port_id: int,
>> -        expected_packets: list[Packet] | None =3D None,
>> -        *args: Any,
>> -        **kwargs: Any,
>> -    ) -> None:
>> -        """Runner method that validates each flow using the correspondi=
ng verification method.
>> +        layer_names: list[str],
>> +        action_name: str,
>> +        action_value: Any =3D None,
>> +        group_id: int =3D 0,
>> +    ) -> list[FlowTestCase]:
>> +        """Generate test cases for patterns matching fields across mult=
iple layers.
>> +
>> +        This method identifies every possible combination of one field =
per layer.
>> +        For each field combination, it iterates through the available t=
est values.
>> +        If fields have an unequal number of test values, it cycles thro=
ugh the
>> +        shorter lists to ensure every specific value in every field is =
tested.
>>
>>          Args:
>> -            verification_method: Callable that performs verification lo=
gic.
>> -            flows: List of flow rules to create and test.
>> -            packets: List of packets corresponding to each flow.
>> -            port_id: Number representing the port to create flows on.
>> -            expected_packets: List of packets to check sent packets aga=
inst in modification cases.
>> -            *args: Additional positional arguments to pass to the verif=
ication method.
>> -            **kwargs: Additional keyword arguments to pass to the verif=
ication method.
>> +            layer_names: List of layer names to match.
>> +            action_name: Name of the action to apply.
>> +            action_value: Optional value for parameterized actions.
>> +            group_id: Flow group ID.
>> +
>> +        Returns:
>> +            List of FlowTestCase objects ready for execution.
>>          """
>> +        action_spec =3D self.actions[action_name]
>> +
>> +        # Organize layers into lists of matchable fields
>> +        layer_field_specs =3D []
>> +        for layer_name in layer_names:
>> +            layer_spec =3D self.layers[layer_name]
>> +            # Capture the layer spec and the field spec for each field =
in the layer
>> +            layer_field_specs.append([(layer_spec, f) for f in layer_sp=
ec.fields])
>> +
>> +        test_cases =3D []
>> +
>> +        # Iterate through every combination of fields across the reques=
ted layers
>> +        # For ['eth', 'ipv4'], this produces: (eth_src, ipv4_src), (eth=
_src, ipv4_dst), etc.
>> +        for field_combo in product(*layer_field_specs):
>> +            # Determine how many test cases are needed to cover all val=
ues in this combo
>> +            max_vals =3D max(len(f_spec.test_values) for _, f_spec in f=
ield_combo)
>> +
>> +            # Cycle through the test values for these fields
>> +            for i in range(max_vals):
>> +                pattern_parts =3D []
>> +                all_field_values: dict[str, dict[str, Any]] =3D {}
>> +                desc_parts =3D []
>> +
>> +                for layer_spec, field_spec in field_combo:
>> +                    # Select value by index
>> +                    val =3D field_spec.test_values[i % len(field_spec.t=
est_values)]
>> +
>> +                    pattern_parts.append(
>> +                        f"{layer_spec.pattern_name} {field_spec.pattern=
_field} is {val}"
>> +                    )
>> +                    # Store value for Scapy packet building
>> +                    if layer_spec.name not in all_field_values:
>> +                        all_field_values[layer_spec.name] =3D {}
>> +                    all_field_values[layer_spec.name][field_spec.scapy_=
field] =3D val
>> +
>> +                    desc_parts.append(f"{layer_spec.name}[{field_spec.s=
capy_field}=3D{val}]")
>> +
>> +                full_pattern =3D " / ".join(pattern_parts)
>> +                flow_rule =3D FlowRule(
>> +                    direction=3D"ingress",
>> +                    pattern=3D[full_pattern],
>> +                    actions=3D[action_spec.build_action_string(action_v=
alue)],
>> +                    group_id=3Dgroup_id,
>> +                )
>> +
>> +                add_payload =3D action_spec.verification_type in ["drop=
", "modify"]
>> +                packet =3D self._build_multi_layer_packet(layer_names, =
all_field_values, add_payload)
>> +
>> +                expected_packet =3D None
>> +                if action_spec.verification_type =3D=3D "modify":
>> +                    expected_packet =3D action_spec.build_expected_pack=
et(packet)
>> +
>> +                test_cases.append(
>> +                    FlowTestCase(
>> +                        flow_rule=3Dflow_rule,
>> +                        packet=3Dpacket,
>> +                        verification_type=3Daction_spec.verification_ty=
pe,
>> +                        verification_params=3Daction_spec.build_verific=
ation_params(action_value),
>> +                        description=3D" / ".join(desc_parts) + f" -> {a=
ction_spec.name}",
>> +                        expected_packet=3Dexpected_packet,
>> +                    )
>> +                )
>>
>> -        def zip_lists(
>> -            rules: list[FlowRule],
>> -            packets1: list[Packet],
>> -            packets2: list[Packet] | None,
>> -        ) -> Iterator[tuple[FlowRule, Packet, Packet | None]]:
>> -            """Method that creates an iterable zip containing lists use=
d in runner.
>> -
>> -            Args:
>> -                rules: List of flow rules.
>> -                packets1: List of packets.
>> -                packets2: Optional list of packets, excluded from zip i=
f not passed to runner.
>> -            """
>> -            return cast(
>> -                Iterator[tuple[FlowRule, Packet, Packet | None]],
>> -                zip_longest(rules, packets1, packets2 or [], fillvalue=
=3DNone),
>> -            )
>> +        return test_cases
>>
>> -        with TestPmd(rx_queues=3D4, tx_queues=3D4) as testpmd:
>> -            for flow, packet, expected_packet in zip_lists(flows, packe=
ts, expected_packets):
>> -                is_valid =3D testpmd.flow_validate(flow_rule=3Dflow, po=
rt_id=3Dport_id)
>> -                verify_else_skip(is_valid, "flow rule failed validation=
.")
>>
>> -                try:
>> -                    flow_id =3D testpmd.flow_create(flow_rule=3Dflow, p=
ort_id=3Dport_id)
>> -                except InteractiveCommandExecutionError:
>> -                    log("Flow rule validation passed, but flow creation=
 failed.")
>> -                    fail("Failed flow creation")
>> +@requires_nic_capability(NicCapability.FLOW_CTRL)
>> +class TestRteFlow(TestSuite):
>> +    """RTE Flow test suite.
>>
>> -                if verification_method =3D=3D self._send_packet_and_ver=
ify:
>> -                    verification_method(packet=3Dpacket, *args, **kwarg=
s)
>> +    This suite consists of 4 test cases:
>> +    1. Queue Action: Verifies queue actions with multi-layer patterns
>> +    2. Drop Action: Verifies drop actions with multi-layer patterns
>> +    3. Modify Field Action: Verifies modify_field actions with multi-la=
yer patterns
>> +    4. Jump Action: Verifies jump action between flow groups
>>
>> -                elif verification_method =3D=3D self._send_packet_and_v=
erify_queue:
>> -                    verification_method(
>> -                        packet=3Dpacket, test_queue=3Dkwargs["test_queu=
e"], testpmd=3Dtestpmd
>> -                    )
>> +    """
>>
>> -                elif verification_method =3D=3D self._send_packet_and_v=
erify_modification:
>> -                    verification_method(packet=3Dpacket, expected_packe=
t=3Dexpected_packet)
>> +    def set_up_suite(self) -> None:
>> +        """Initialize the test generator and result tracking."""
>> +        self.generator =3D FlowTestGenerator(LAYERS, ACTIONS)
>> +        self.test_suite_results: list[FlowTestResult] =3D []
>> +        self.test_case_results: list[FlowTestResult] =3D []
>>
>> -                testpmd.flow_delete(flow_id, port_id=3Dport_id)
>> +    def _run_confidence_check(self, action_type: str) -> None:
>
>
>  Where is the handling for when action_type=3D=3D"queue"?

The queue case is handled in the elif statement if you're referring to
the confidence check method? Unless you're talking about something
else

>
> Also, should be called _verify_basic_transmission or something more descr=
iptive. I know we said confidence check at the team meeting but let's make =
it clear what the function is doing.

Fair point, I'll rename it

>
>>
>> +        """Verify that non-matching packets are unaffected by flow rule=
s.
>>
>> -    def _send_packet_and_verify(self, packet: Packet, should_receive: b=
ool =3D True) -> None:
>> -        """Generate a packet, send to the DUT, and verify it is forward=
ed back.
>> +        Creates a flow rule for the specified action, then sends a pack=
et that
>> +        should NOT match the rule to confirm:
>> +        - For 'drop': non-matching packets ARE received (not dropped)
>> +        - For 'queue': non-matching packets are NOT steered to the targ=
et queue
>> +        - For 'modify': non-matching packets arrive unmodified
>> +
>> +        This ensures flow rules only affect matching traffic before
>> +        running the actual action tests.
>>
>>          Args:
>> -            packet: Scapy packet to send and verify.
>> -            should_receive: Indicate whether the packet should be recei=
ved.
>> +            action_type: The action being tested ('drop', 'queue', 'mod=
ify').
>>          """
>> -        received =3D send_packet_and_capture(packet)
>> -        contains_packet =3D any(
>> -            packet.haslayer(Raw) and b"xxxxx" in packet.load for packet=
 in received
>
>
> I see that this will work, but if we want to verify with xxxxx do you wan=
t to just pack x*5 earlier in the file when you build a packet? Just trying=
 to keep things 1:1.

Good catch I missed that, I'll refactor to make it more consistent.

>
>>
>> -        )
>> -        verify(
>> -            should_receive =3D=3D contains_packet,
>> -            f"Packet was {'dropped' if should_receive else 'received'}"=
,
>> +        non_matching_packet =3D (
>> +            Ether(src=3D"02:00:00:00:00:00", dst=3D"02:00:00:00:00:01")
>> +            / IP(src=3D"192.168.100.1", dst=3D"192.168.100.2")
>> +            / UDP(sport=3D9999, dport=3D9998)
>> +            / Raw(load=3D"CONFIDENCE" + "X" * 22)
>>          )
>>
>> -    def _send_packet_and_verify_queue(
>> -        self, packet: Packet, test_queue: int, testpmd: TestPmd
>> -    ) -> None:
>> -        """Send packet and verify queue stats show packet was received.
>> +        with TestPmd(rx_queues=3D4, tx_queues=3D4) as testpmd:
>> +            if action_type =3D=3D "drop":
>> +                drop_rule =3D FlowRule(
>> +                    direction=3D"ingress",
>> +                    pattern=3D["eth / ipv4 src is 192.168.1.1 / udp dst=
 is 53"],
>> +                    actions=3D["drop"],
>> +                )
>> +                flow_id =3D testpmd.flow_create(flow_rule=3Ddrop_rule, =
port_id=3D0)
>
>
> I see it's a basic flow rule, but do we need to run flow_validate() first=
 anyways?

I probably should, now that I'm looking over it I might add a helper
method for validating and creating flow rules so I can reduce the
amount of redundant verification logic throughout the test suite
(which I'll add to this method as well)

>
>>
>>
>> -        Args:
>> -            packet: Scapy packet to send to the SUT.
>> -            test_queue: Represents the queue the test packet is being s=
ent to.
>> -            testpmd: TestPmd instance being used to send test packet.
>> -        """
>> -        testpmd.set_verbose(level=3D8)
>> -        testpmd.start()
>> -        send_packet_and_capture(packet=3Dpacket)
>> +                testpmd.start()
>> +                received =3D send_packet_and_capture(non_matching_packe=
t)
>> +                testpmd.stop()
>> +                contains_packet =3D any(
>> +                    p.haslayer(Raw) and b"CONFIDENCE" in bytes(p[Raw].l=
oad) for p in received
>> +                )
>> +                testpmd.flow_delete(flow_id, port_id=3D0)
>> +                verify(
>> +                    contains_packet,
>> +                    "Confidence check failed: non-matching packet dropp=
ed by drop rule",
>> +                )
>> +
>> +            elif action_type =3D=3D "queue":
>> +                queue_rule =3D FlowRule(
>> +                    direction=3D"ingress",
>> +                    pattern=3D[
>> +                        "eth src is aa:bb:cc:dd:ee:ff / ipv4 src is 10.=
255.255.254 "
>> +                        "dst is 10.255.255.253 / udp src is 12345 dst i=
s 54321"
>> +                    ],
>> +                    actions=3D["queue index 3"],
>> +                )
>> +                flow_id =3D testpmd.flow_create(flow_rule=3Dqueue_rule,=
 port_id=3D0)
>> +
>> +                testpmd.set_verbose(level=3D8)
>> +                testpmd.start()
>> +                send_packet_and_capture(non_matching_packet)
>> +                verbose_output =3D testpmd.extract_verbose_output(testp=
md.stop())
>> +                received_on_target =3D any(p.queue_id =3D=3D 3 for p in=
 verbose_output)
>> +                testpmd.flow_delete(flow_id, port_id=3D0)
>> +                verify(
>> +                    not received_on_target,
>> +                    "Confidence check failed: non-matching packet steer=
ed to queue 3",
>
>
> I guess there is a baked in assumption here that a packet which does not =
match this rule cannot be rx in queue 3. Is this true? Is it guaranteed to =
be rx in another queue, and if so which one?

My understanding is that unless a flow rule or some other traffic
redirection tool is being used, the rx queue is 0 by default for all
packets. I haven't seen packets being received on any other queue when
this is the case

>
>>
>> +                )
>> +
>> +        log(f"Confidence check passed for '{action_type}' action")
>> +
>> +    def _verify_queue(self, packet: Packet, queue_id: int, testpmd: Tes=
tPmd, **kwargs: Any) -> None:
>> +        """Verify packet is received on the expected queue."""
>> +        send_packet_and_capture(packet)
>>          verbose_output =3D testpmd.extract_verbose_output(testpmd.stop(=
))
>> -        received =3D False
>> -        for testpmd_packet in verbose_output:
>> -            if testpmd_packet.queue_id =3D=3D test_queue:
>> -                received =3D True
>> -        verify(received, f"Expected packet was not received on queue {t=
est_queue}")
>> +        received_on_queue =3D any(p.queue_id =3D=3D queue_id for p in v=
erbose_output)
>> +        verify(received_on_queue, f"Packet not received on queue {queue=
_id}")
>>
>> -    def _send_packet_and_verify_modification(self, packet: Packet, expe=
cted_packet: Packet) -> None:
>> -        """Send packet and verify the expected modifications are presen=
t upon reception.
>> -
>> -        Args:
>> -            packet: Scapy packet to send to the SUT.
>> -            expected_packet: Scapy packet that should match the receive=
d packet.
>> -        """
>> +    def _verify_drop(self, packet: Packet, **kwargs: Any) -> None:
>> +        """Verify packet is dropped."""
>>          received =3D send_packet_and_capture(packet)
>> +        contains_packet =3D any(p.haslayer(Raw) and b"XXXXX" in p.load =
for p in received)
>> +        verify(not contains_packet, "Packet was not dropped")
>>
>> -        # verify reception
>> -        verify(received !=3D [], "Packet was never received.")
>> -
>> -        log(f"SENT PACKET:     {packet.summary()}")
>> -        log(f"EXPECTED PACKET: {expected_packet.summary()}")
>> -        for packet in received:
>> -            log(f"RECEIVED PACKET: {packet.summary()}")
>> +    def _verify_modify(
>
>
> More naming complaints. :) If this method ONLY checks dst address modific=
ations, can you rename to _verify_modify_dst_address or similar?

Sure, I'll rename it to _verify_dts_modification

>
>>
>> +        self, packet: Packet, expected_packet: Packet, testpmd: TestPmd=
, **kwargs: Any
>> +    ) -> None:
>> +        """Verify packet modifications."""
>> +        testpmd.start()
>> +        received =3D send_packet_and_capture(packet)
>> +        testpmd.stop()
>>
>> -        expected_ip_dst =3D expected_packet[IP].dst if IP in expected_p=
acket else None
>> -        received_ip_dst =3D received[IP].dst if IP in received else Non=
e
>> +        verify(
>> +            any(p.haslayer(Raw) and b"XXXXX" in p.load for p in receive=
d),
>> +            "Test packet with payload marker not found",
>> +        )
>>
>> -        expected_mac_dst =3D expected_packet[Ether].dst if Ether in exp=
ected_packet else None
>> -        received_mac_dst =3D received[Ether].dst if Ether in received e=
lse None
>> +        test_packet =3D None
>> +        for pkt in received:
>> +            if pkt.haslayer(Raw) and b"XXXXX" in pkt.load:
>> +                test_packet =3D pkt
>> +                break
>>
>> -        # verify modification
>> -        if expected_ip_dst is not None:
>> +        if IP in expected_packet and test_packet is not None:
>>              verify(
>> -                received_ip_dst =3D=3D expected_ip_dst,
>> -                f"IPv4 dst mismatch: expected {expected_ip_dst}, got {r=
eceived_ip_dst}",
>> +                test_packet[IP].dst =3D=3D expected_packet[IP].dst,
>> +                f"IPv4 dst mismatch: expected {expected_packet[IP].dst}=
, got {test_packet[IP].dst}",
>>              )
>>
>> -        if expected_mac_dst is not None:
>> +        if Ether in expected_packet and test_packet is not None:
>>              verify(
>> -                received_mac_dst =3D=3D expected_mac_dst,
>> -                f"MAC dst mismatch: expected {expected_mac_dst}, got {r=
eceived_mac_dst}",
>> +                test_packet[Ether].dst =3D=3D expected_packet[Ether].ds=
t,
>> +                f"MAC dst mismatch: expected {expected_packet[Ether].ds=
t}, "
>> +                f"got {test_packet[Ether].dst}",
>>              )
>>
>> -    def _send_packet_and_verify_jump(
>> +    def _run_tests(
>>          self,
>> -        packets: list[Packet],
>> -        flow_rules: list[FlowRule],
>> -        test_queues: list[int],
>> -        testpmd: TestPmd,
>> +        test_cases: list[FlowTestCase],
>> +        port_id: int =3D 0,
>>      ) -> None:
>> -        """Create a testpmd session with every rule in the given list, =
verify jump behavior.
>> -
>> -        Args:
>> -            packets: List of packets to send.
>> -            flow_rules: List of flow rules to create in the same sessio=
n.
>> -            test_queues: List of Rx queue IDs each packet should be rec=
eived on.
>> -            testpmd: TestPmd instance to create flows on.
>> -        """
>> -        testpmd.set_verbose(level=3D8)
>> -        for flow in flow_rules:
>> -            is_valid =3D testpmd.flow_validate(flow_rule=3Dflow, port_i=
d=3D0)
>> -            verify_else_skip(is_valid, "flow rule failed validation.")
>> +        """Execute a sequence of test cases."""
>> +        with TestPmd(rx_queues=3D4, tx_queues=3D4) as testpmd:
>> +            for test_case in test_cases:
>> +                log(f"Testing: {test_case.description}")
>>
>> -            try:
>> -                testpmd.flow_create(flow_rule=3Dflow, port_id=3D0)
>> -            except InteractiveCommandExecutionError:
>> -                log("Flow validation passed, but flow creation failed."=
)
>> -                fail("Failed flow creation")
>> +                result =3D FlowTestResult(
>> +                    description=3Dtest_case.description,
>> +                    passed=3DFalse,
>> +                    flow_rule_pattern=3D" / ".join(test_case.flow_rule.=
pattern),
>> +                    sent_packet=3Dtest_case.packet,
>> +                )
>>
>> -        for packet, test_queue in zip(packets, test_queues):
>> -            testpmd.start()
>> -            send_packet_and_capture(packet=3Dpacket)
>> -            verbose_output =3D testpmd.extract_verbose_output(testpmd.s=
top())
>> -            received =3D False
>> -            for testpmd_packet in verbose_output:
>> -                if testpmd_packet.queue_id =3D=3D test_queue:
>> -                    received =3D True
>> -            verify(received, f"Expected packet was not received on queu=
e {test_queue}")
>> +                try:
>> +                    is_valid =3D testpmd.flow_validate(flow_rule=3Dtest=
_case.flow_rule, port_id=3Dport_id)
>> +                    if not is_valid:
>> +                        result.skipped =3D True
>> +                        result.failure_reason =3D "Flow rule failed val=
idation"
>> +                        self.test_suite_results.append(result)
>> +                        self.test_case_results.append(result)
>
>
> I think there is a logical issue - if not is_valid, then we need to throw=
 an exception or continue to the next iteration, not proceed to flow_create=
 (what is happening now).

You're right, I can add the helper method for flow validation in here
instead of the current implementation. This should reduce the amount
of redundant code as well

>
>>
>> +
>> +                    try:
>> +                        flow_id =3D testpmd.flow_create(
>> +                            flow_rule=3Dtest_case.flow_rule, port_id=3D=
port_id
>> +                        )
>> +                    except InteractiveCommandExecutionError:
>> +                        result.failure_reason =3D "Hardware validated b=
ut failed to create flow rule"
>> +                        self.test_suite_results.append(result)
>> +                        self.test_case_results.append(result)
>> +                        continue
>> +
>> +                    verification_method =3D getattr(self, f"_verify_{te=
st_case.verification_type}")
>> +
>> +                    if test_case.verification_type =3D=3D "queue":
>> +                        testpmd.set_verbose(level=3D8)
>> +                        testpmd.start()
>> +                        verification_method(
>> +                            packet=3Dtest_case.packet,
>> +                            testpmd=3Dtestpmd,
>> +                            **test_case.verification_params,
>> +                        )
>> +                    elif test_case.verification_type =3D=3D "modify":
>> +                        verification_method(
>> +                            packet=3Dtest_case.packet,
>> +                            expected_packet=3Dtest_case.expected_packet=
,
>> +                            testpmd=3Dtestpmd,
>> +                            **test_case.verification_params,
>> +                        )
>> +                    else:
>> +                        verification_method(
>> +                            packet=3Dtest_case.packet,
>> +                            testpmd=3Dtestpmd,
>> +                            **test_case.verification_params,
>> +                        )
>> +
>> +                    testpmd.flow_delete(flow_id, port_id=3Dport_id)
>> +                    result.passed =3D True
>> +                    self.test_suite_results.append(result)
>> +                    self.test_case_results.append(result)
>> +
>> +                except SkippedTestException as e:
>> +                    result.skipped =3D True
>> +                    result.failure_reason =3D f"Skipped: {str(e)}"
>> +                    self.test_suite_results.append(result)
>> +                    self.test_case_results.append(result)
>> +
>> +    def _log_test_suite_summary(self) -> None:
>
>
> I'm struggling with what is the value of the _log_test_suite_summary and =
also _log_test_cast_failures.
>
> Overall, for each flowtest, we need to track:
>
> 1. pass/fail/skip
> 2. reason for pass/fail/skip
> 3. Flow rule string
> 4. Scapy packet
>
> And this needs to be conspicuously logged, and clear (so, clear reason fo=
r failure given with each flowtest).
>
> I see that the test suite summary is included in the log file, but I had =
to scroll through a lot of logs in order to get to the summary. I wonder if=
 there is a better solution (like including more info in results_summary.tx=
t). Can discuss tomorrow.

That's fair, my thinking was that by doing this, you would see the
full summary at the end of the test run along with the results table.
But I think adding this to results_summary.txt would also be helpful,
I'll likely add that to the next version

>
>>
>> +        """Log a summary of all test results."""
>> +        if not self.test_suite_results:
>> +            return
>> +
>> +        passed_tests =3D [r for r in self.test_suite_results if r.passe=
d]
>> +        skipped_tests =3D [r for r in self.test_suite_results if r.skip=
ped]
>> +        failed_tests =3D [r for r in self.test_suite_results if not r.p=
assed and not r.skipped]
>> +
>> +        log(f"Total tests run: {len(self.test_suite_results)}")
>> +        log(f"Passed: {len(passed_tests)}")
>> +        log(f"Skipped: {len(skipped_tests)}")
>> +        log(f"Failed: {len(failed_tests)}")
>> +
>> +        if passed_tests:
>> +            log("\nPASSED TESTS:")
>> +            for result in passed_tests:
>> +                log(f"  {result.description}")
>> +                log(f"    Sent Packet: {result.sent_packet}")
>> +
>> +        if skipped_tests:
>> +            log("\nSKIPPED TESTS:")
>
>
> Change to skipped rules, passed rules, failed rules, etc.

Okay will do

>
>>
>> +            for result in skipped_tests:
>> +                log(f"  {result.description}")
>> +                log(f"    Pattern: {result.flow_rule_pattern}")
>> +                log(f"    Reason: {result.failure_reason}")
>> +                log(f"    Sent Packet: {result.sent_packet}")
>> +
>> +        if failed_tests:
>> +            log("\nFAILED TESTS:")
>> +            for result in failed_tests:
>> +                log(f"  {result.description}")
>> +                log(f"    Pattern: {result.flow_rule_pattern}")
>> +                log(f"    Reason: {result.failure_reason}")
>> +                log(f"    Sent Packet: {result.sent_packet}")
>> +
>> +    def _log_test_case_failures(self) -> None:
>> +        """Log each pattern that failed for a given test case."""
>> +        failures =3D [r for r in self.test_case_results if not r.passed=
 and not r.skipped]
>> +
>> +        if failures:
>> +            patterns =3D "\n".join(f"\t  - {r.flow_rule_pattern}" for r=
 in failures)
>> +
>> +            self.test_case_results =3D []
>> +
>> +            fail(
>> +                "Flow rule passed validation but failed creation.\n"
>> +                "\tFailing flow rule patterns:\n"
>> +                f"{patterns}"
>
>
> See my full comment at the end, but split out patterns to flow_create fai=
lures and failure coming from devices not implementing a rule correctly (i.=
e. the behavior doesn't align with what the testsuite expects).

Okay, I'll add a failure_type field to FlowTestResult so I can
distinguish these in the summary

>
>>
>>
>> -
>> -    @func_test
>> -    def drop_action_IP(self) -> None:
>> -        """Validate flow rules with drop actions and ethernet patterns.
>> +        This test creates a two-stage pipeline:
>> +        - Group 0: Match on Ethernet src, jump to group 1
>> +        - Group 1: Match on IPv4 dst, forward to specific queue
>>
>>          Steps:
>> -            * Create a list of packets to test, with a corresponding fl=
ow list.
>> -            * Launch testpmd.
>> -            * Create first flow rule in flow list.
>> -            * Send first packet in packet list, capture verbose output.
>> -            * Delete flow rule, repeat for all flows/packets.
>> +            * Launch testpmd with multiple queues.
>> +            * Create flow rule in group 0 that matches eth src and jump=
s to group 1.
>> +            * Create flow rule in group 1 that matches ipv4 dst and que=
ues to queue 2.
>> +            * Send matching packet and verify it arrives on queue 2.
>> +            * Send non-matching packet (wrong eth src) and verify it do=
esn't hit queue 2.
>
>
> Same question as earlier (how do we know the packet wont be rx on queue 2=
 for another reason other than the flow rule). Maybe we do know this based =
on established DPDK behavior (I don't know) but if you want to sidestep thi=
s question you can do a different action.

I don't believe it is the case that packets will be rx'd on queue 2
without a flow rule

>
>>
>>
>>
>>
>
>
> Here are the results I just got for a connectx-5. Can you take a closer l=
ook at these to see if you find anything suspicious? For instance, I see on=
 jump_action, there is a failure from not being able to create rule with pa=
ttern "eth src is 02:00:00:00:00:00." That looks like a very standard and m=
inimal pattern, so this is worth checking.

That is strange, I'll run some manual testpmd sessions to see what's
causing this

>
> Also, I see there are all these failing flow rules below. How do I know w=
hether these are failing due to flow_validate and flow_create giving differ=
ent responses, vs flow_create working and the rule not working correctly? B=
oth of those checks should add rules to separate sections on the summary be=
low.

I'm adding some logic to distinguish between the two in the next version

>
>   rte_flow: FAIL
>     drop_action: FAIL
>       reason: Flow rule passed validation but failed creation.
>         Failing flow rule patterns:
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 type is 8
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 type is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 code is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 ident is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 ident is 1234
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 seq is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 seq is 1
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 type is 8
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 type is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 code is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 ident is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 ident is 1234
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 seq is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 seq is 1
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp type is =
8
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp type is=
 0
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp code is =
0
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp code is=
 0
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp ident is=
 0
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp ident i=
s 1234
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp seq is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp seq is =
1
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp type is 8
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp type is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp code is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp code is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp ident is =
0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp ident is =
1234
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp seq is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp seq is 1
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 type is 8
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 type is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 code is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 ident is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 ident is 1234
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 seq is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 seq is 1
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 type is 8
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 type is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 code is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 ident is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 ident is 1234
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 seq is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 seq is 1
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp type is =
8
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp type is=
 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp code is =
0
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp code is=
 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp ident is=
 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp ident i=
s 1234
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp seq is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp seq is =
1
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp type is 8
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp type is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp code is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp code is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp ident is =
0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp ident is =
1234
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp seq is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp seq is 1
>     jump_action: FAIL
>       reason: Flow rule passed validation but failed creation.
>         Failing flow rule patterns:
>           - eth src is 02:00:00:00:00:00
>     modify_field_action: FAIL
>       reason: Flow rule passed validation but failed creation.
>         Failing flow rule patterns:
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp =
src is 1234
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp =
src is 8080
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp =
dst is 80
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp =
dst is 443
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp =
flags is 2
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / tcp =
flags is 16
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp =
src is 1234
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp =
src is 8080
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp =
dst is 80
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp =
dst is 443
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp =
flags is 2
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / tcp =
flags is 16
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / tcp src is 12=
34
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / tcp src is 8=
080
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / tcp dst is 80
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / tcp dst is 4=
43
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / tcp flags is =
2
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / tcp flags is=
 16
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / tcp src is 123=
4
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / tcp src is 808=
0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / tcp dst is 80
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / tcp dst is 443
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / tcp flags is 2
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / tcp flags is 1=
6
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp =
src is 1234
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp =
src is 8080
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp =
dst is 80
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp =
dst is 443
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp =
flags is 2
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / tcp =
flags is 16
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp =
src is 1234
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp =
src is 8080
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp =
dst is 80
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp =
dst is 443
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp =
flags is 2
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / tcp =
flags is 16
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / tcp src is 12=
34
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / tcp src is 8=
080
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / tcp dst is 80
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / tcp dst is 4=
43
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / tcp flags is =
2
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / tcp flags is=
 16
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / tcp src is 123=
4
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / tcp src is 808=
0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / tcp dst is 80
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / tcp dst is 443
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / tcp flags is 2
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / tcp flags is 1=
6
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / udp =
src is 5000
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / udp =
dst is 53
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / udp =
dst is 123
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / udp =
src is 5000
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / udp =
dst is 53
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / udp =
dst is 123
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / udp src is 50=
00
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / udp src is 5=
000
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / udp dst is 53
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / udp dst is 1=
23
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / udp src is 500=
0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / udp src is 500=
0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / udp dst is 53
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / udp dst is 123
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / udp =
src is 5000
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / udp =
dst is 53
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / udp =
dst is 123
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / udp =
src is 5000
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / udp =
dst is 53
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / udp =
dst is 123
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / udp src is 50=
00
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / udp src is 5=
000
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / udp dst is 53
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / udp dst is 1=
23
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / udp src is 500=
0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / udp src is 500=
0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / udp dst is 53
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / udp dst is 123
>           - eth src is 02:00:00:00:00:00
>           - eth dst is 02:00:00:00:00:02
>           - eth src is 02:00:00:00:00:00 / vlan vid is 100
>           - eth src is 02:00:00:00:00:00 / vlan vid is 200
>           - eth src is 02:00:00:00:00:00 / vlan pcp is 0
>           - eth src is 02:00:00:00:00:00 / vlan pcp is 7
>           - eth dst is 02:00:00:00:00:02 / vlan vid is 100
>           - eth dst is 02:00:00:00:00:02 / vlan vid is 200
>           - eth dst is 02:00:00:00:00:02 / vlan pcp is 0
>           - eth dst is 02:00:00:00:00:02 / vlan pcp is 7
>     queue_action: FAIL
>       reason: Flow rule passed validation but failed creation.
>         Failing flow rule patterns:
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 type is 8
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 type is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 code is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 ident is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 ident is 1234
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 seq is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 src is 192.168.1.1 / icmp=
 seq is 1
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 type is 8
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 type is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 code is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 ident is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 ident is 1234
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 seq is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 dst is 192.168.1.2 / icmp=
 seq is 1
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp type is =
8
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp type is=
 0
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp code is =
0
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp code is=
 0
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp ident is=
 0
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp ident i=
s 1234
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 64 / icmp seq is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 ttl is 128 / icmp seq is =
1
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp type is 8
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp type is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp code is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp code is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp ident is =
0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp ident is =
1234
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 0 / icmp seq is 0
>           - eth src is 02:00:00:00:00:00 / ipv4 tos is 4 / icmp seq is 1
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 type is 8
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 type is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 code is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 ident is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 ident is 1234
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 seq is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 src is 192.168.1.1 / icmp=
 seq is 1
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 type is 8
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 type is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 code is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 ident is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 ident is 1234
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 seq is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 dst is 192.168.1.2 / icmp=
 seq is 1
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp type is =
8
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp type is=
 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp code is =
0
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp code is=
 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp ident is=
 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp ident i=
s 1234
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 64 / icmp seq is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 ttl is 128 / icmp seq is =
1
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp type is 8
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp type is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp code is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp code is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp ident is =
0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp ident is =
1234
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 0 / icmp seq is 0
>           - eth dst is 02:00:00:00:00:02 / ipv4 tos is 4 / icmp seq is 1
>  '
>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
