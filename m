Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1896FC77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 17:20:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF9CD40BA6;
	Wed, 25 Jun 2025 19:20:56 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id CB38640B90
 for <dev@dpdk.org>; Wed, 25 Jun 2025 19:20:54 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b321bd36a41so71574a12.2
 for <dev@dpdk.org>; Wed, 25 Jun 2025 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750872054; x=1751476854; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S7nBCQjcaSTyY0970msBmCQvISNLL1FrtlzwiEiIbmo=;
 b=D7vYo+u0o3xhCRHS/YYGEo2InD73FTq7UjRFExk92iDMVMGwK+t9LTWBGTUCGqAvB1
 iMl5loG+PBM82HJ8U5Z42RGrQWRZmo9aAGA+HA10ps7KjiV09fdMKz3Macg0Uq1N1awF
 +LeQ3FpQSUcbBVN/UbzMOCopTUTVAntTlSTOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750872054; x=1751476854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S7nBCQjcaSTyY0970msBmCQvISNLL1FrtlzwiEiIbmo=;
 b=otyxfWDDg+Qyw6E4SiBwoHKgWTL1Pr4wJyGuNTBTv/ACbznriU3CWucLDuGj4Fe2g1
 BeZ2AVKCFhLnPxecNFdT/nLHlxjMR8Ay+FYR3icz7CNu4tPuWmViM+d3PUmyCVs671PT
 9Fx1fD4+Q4L0/A+D9FBgV92JRAtv3b+RMbpz592gxm+n71/vp/4u0WHY6rTQ1i6hIBM6
 RFTs9AKx2JbSnQu/b+/XWb+QCTNepMvbjKO3vD/v9i3Y3V6N+9p/+IVMsNb5EKHjYEqn
 P6RSPm/UDslieEpOdm5xMI4ovrwb8a+aVwqdasVYZ19KKcZUjMgNGELQ8Qu67JjS6773
 Eg6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHBr44BexxntkU3eUDjjXAIOOGc5/33ZtUq6hImSOTMAVVK5kl7gIwqNkXkoB+Ihm8Ck8=@dpdk.org
X-Gm-Message-State: AOJu0Yy6XU7h+EuJgQcqL3zUkwtdG1rA//FNPOg/t31XUHouoadt7dA+
 lDiu0wX7gSVAeIRhMSIy1Cn3f5TRQ6RFiKd19M4wmu6z8u8KZ2yz2IZreXxEVL2dACB37r0END9
 171CDXFku/FmaOOKTAE4HFbIZ1fg0KypI18nSeUaDvA==
X-Gm-Gg: ASbGnctobAPW5a6VvjGqDfk99hgyk7j+lz2vOvy/Wo0T5CvLL7VYN5frqAQSpa9Hve5
 4VQtnFUxHeyYzV9brwLfJOR6e8DxcqNGU/24gOUPJYxJD3/oldvpEktSyAn6yOXbs1LnW4wjBjO
 O2NlAyyA68+/sdJZgDNfEKwML+qEvM6kFdbaDxj9jNG4Aizvg025NW2yxd2uzi37s3nSMpY1ugu
 VsZ
X-Google-Smtp-Source: AGHT+IHrZL8L90rr2LBxQZp/nMJ5PyX79QTcfyPK1PadeNKYzG23OXKpO6bL/CmoISR/26zflIp+sS8mtRNJJAIahLI=
X-Received: by 2002:a17:90b:5610:b0:311:e731:523a with SMTP id
 98e67ed59e1d1-315f2613891mr6146495a91.11.1750872053630; Wed, 25 Jun 2025
 10:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250519181957.228084-1-dmarx@iol.unh.edu>
 <20250521192629.294265-1-dmarx@iol.unh.edu>
In-Reply-To: <20250521192629.294265-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 25 Jun 2025 13:15:28 -0400
X-Gm-Features: AX0GCFspyn4qRE6HHUaGm4rHq4ITAVxXm3yb0YpixmXgXWcTgE81Nv10hv8KoeI
Message-ID: <CAJvnSUANro_BV+VkrD5s_ArOEcC-0qN3qhWSBwT38ZuMrOMk_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dts: add rte flow test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000cde667063868aa0b"
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

--000000000000cde667063868aa0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:26=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Add an RTE Flow API testing suite, which covers some basic
> synchronous Flow API rules that should be supported across PMDs.
> This suite will be added to over time, as the Flow API is too large
> to cover all in one suite, and sending one monolithic series
> would be impossible.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/tests/TestSuite_flow.py | 585 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 585 insertions(+)
>  create mode 100644 dts/tests/TestSuite_flow.py
>
> diff --git a/dts/tests/TestSuite_flow.py b/dts/tests/TestSuite_flow.py
> new file mode 100644
> index 0000000000..15566205c9
> --- /dev/null
> +++ b/dts/tests/TestSuite_flow.py
> @@ -0,0 +1,585 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""RTE Flow testing suite.
> +
> +This suite verifies a range of flow rules built using patterns
> +and actions from the RTE Flow API. It would be impossible to cover
> +every valid flow rule, but this suite aims to test the most
> +important and common functionalities across PMDs.
> +
> +"""
> +
> +from collections.abc import Callable
> +from itertools import zip_longest
> +from typing import Any, Iterator, cast
> +
> +from scapy.layers.inet import IP, TCP, UDP
> +from scapy.layers.inet6 import IPv6
> +from scapy.layers.l2 import Dot1Q, Ether
> +from scapy.packet import Packet, Raw
> +
> +from framework.remote_session.testpmd_shell import FlowRule, TestPmdShel=
l
> +from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import NicCapability,
> TopologyType, requires
> +
> +
> +@requires(topology_type=3DTopologyType.two_links)
>

I am thinking this testsuite might be valid for 1 link instead of requiring
2 links.


> +@requires(NicCapability.FLOW_CTRL)
> +class TestFlow(TestSuite):
> +    """RTE Flow test suite.
> +
> +    This suite consists of 10 test cases:
> +    1. Queue Action Ethernet: Verifies queue actions with ethernet
> patterns
> +    2. Queue Action IP: Verifies queue actions with IPv4 and IPv6 patter=
ns
> +    3. Queue Action L4: Verifies queue actions with TCP and UDP patterns
> +    4. Queue Action VLAN: Verifies queue actions with VLAN patterns
> +    5. Drop Action Eth: Verifies drop action with ethernet patterns
>

You are using both Ethernet and Eth - choose 1


> +    6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 patterns
> +    7. Drop Action L4: Verifies drop actions with TCP and UDP patterns
> +    8. Drop Action VLAN: Verifies drop actions with VLAN patterns
> +    9. Modify Field Action: Verifies packet modification patterns
> +    10. Egress Rules: Verifies previously covered rules are still valid
> as egress.
> +
> +    """
> +
> +    def runner(
> +        self,
> +        verification_method: Callable[..., Any],
> +        flows: list[FlowRule],
> +        packets: list[Packet],
> +        expected_packets: list[Packet] | None =3D None,
> +        *args: Any,
> +        **kwargs: Any,
> +    ) -> None:
> +        """Runner method that validates each flow using the correspondin=
g
> verification method.
> +
> +        Args:
> +            verification_method: Callable that performs verification
> logic.
> +            flows: List of flow rules to create and test.
> +            packets: List of packets corresponding to each flow.
> +            expected_packets: List of packets to check sent packets
> against in modification cases.
> +            *args: Additional positional arguments to pass to the
> verification method.
> +            **kwargs: Additional keyword arguments to pass to the
> verification method.
> +        """
> +
> +        def zip_lists(
> +            rules: list[FlowRule],
> +            packets1: list[Packet],
> +            packets2: list[Packet] | None,
> +        ) -> Iterator[tuple[FlowRule, Packet, Packet | None]]:
> +            """Method that creates an iterable zip containing lists used
> in runner.
> +
> +            Args:
> +                rules: List of flow rules.
> +                packets1: List of packets.
> +                packets2: Optional list of packets, excluded from zip if
> not passed to runner.
> +            """
> +            return cast(
> +                Iterator[tuple[FlowRule, Packet, Packet | None]],
> +                zip_longest(rules, packets1, packets2 or [],
> fillvalue=3DNone),
> +            )
> +
> +        with TestPmdShell(rx_queues=3D4, tx_queues=3D4) as testpmd:
> +            for flow, packet, expected_packet in zip_lists(flows,
> packets, expected_packets):
> +                flow_id =3D testpmd.flow_create(flow_rule=3Dflow, port_i=
d=3D0)
> +
> +                if verification_method =3D=3D self.send_packet_and_verif=
y:
> +                    verification_method(*args, **kwargs)
> +
> +                elif verification_method =3D=3D
> self.send_packet_and_verify_queue:
> +                    verification_method(
> +                        packet=3Dpacket, test_queue=3Dkwargs["test_queue=
"],
> testpmd=3Dtestpmd
> +                    )
> +
> +                elif verification_method =3D=3D
> self.send_packet_and_verify_modification:
> +                    verification_method(packet=3Dpacket,
> expected_packet=3Dexpected_packet)
> +
> +                testpmd.flow_delete(flow_id, port_id=3D0)
> +
>
>

> +    @func_test
> +    def test_egress_rules(self) -> None:
> +        """Validate flow rules with egress directions.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd with the necessary configuration.
> +            Send each packet in the list, check reception status.
> +
> +        Verify:
> +            Check that each packet is dropped.
> +
> +        One packet will be sent as a confidence check, to ensure packets
> are being
> +        received under normal circumstances.
> +        """
> +        packet_list =3D [
> +            Ether(src=3D"02:00:00:00:00:00"),
> +            IP(src=3D"192.168.1.1"),
> +            TCP(sport=3D1234),
> +            UDP(sport=3D5000),
> +        ]
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"egress", pattern=3D["eth src is
> 02:00:00:00:00:00"], actions=3D["drop"]
> +            ),
> +            FlowRule(direction=3D"egress", pattern=3D["ipv4 src is
> 192.168.1.1"], actions=3D["drop"]),
> +            FlowRule(direction=3D"egress", pattern=3D["tcp src is 1234"]=
,
> actions=3D["drop"]),
> +            FlowRule(direction=3D"egress", pattern=3D["udp src is 5000"]=
,
> actions=3D["drop"]),
> +        ]
> +        # Verify packet reception without flow rule
> +        self.send_packet_and_verify(packet=3DRaw(load=3D"xxxxx"),
> should_receive=3DTrue)
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            should_receive=3DFalse,
> +        )
>

It looks like for testing these egress rules you are adding the egress flow
rule on port 0, but we are actually egressing on port 1 (if 2 link topology
is enforced as you decorate this testsuite with). So, if my understanding
is correct, then you need to egress on port 1, or on ctx.topology egress
port (same thing).


> --
> 2.49.0
>
>
Remember to include a testsuite rst like
https://git.dpdk.org/dpdk/commit/?id=3Dd23083df08114975987753a887f1d1deed38=
7ce2


Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000cde667063868aa0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 21,=
 2025 at 3:26=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Add an RTE Flow API testing suite, which covers some basi=
c<br>
synchronous Flow API rules that should be supported across PMDs.<br>
This suite will be added to over time, as the Flow API is too large<br>
to cover all in one suite, and sending one monolithic series<br>
would be impossible.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/tests/TestSuite_flow.py | 585 +++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 585 insertions(+)<br>
=C2=A0create mode 100644 dts/tests/TestSuite_flow.py<br>
<br>
diff --git a/dts/tests/TestSuite_flow.py b/dts/tests/TestSuite_flow.py<br>
new file mode 100644<br>
index 0000000000..15566205c9<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_flow.py<br>
@@ -0,0 +1,585 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;RTE Flow testing suite.<br>
+<br>
+This suite verifies a range of flow rules built using patterns<br>
+and actions from the RTE Flow API. It would be impossible to cover<br>
+every valid flow rule, but this suite aims to test the most<br>
+important and common functionalities across PMDs.<br>
+<br>
+&quot;&quot;&quot;<br>
+<br>
+from collections.abc import Callable<br>
+from itertools import zip_longest<br>
+from typing import Any, Iterator, cast<br>
+<br>
+from scapy.layers.inet import IP, TCP, UDP<br>
+from scapy.layers.inet6 import IPv6<br>
+from scapy.layers.l2 import Dot1Q, Ether<br>
+from scapy.packet import Packet, Raw<br>
+<br>
+from framework.remote_session.testpmd_shell import FlowRule, TestPmdShell<=
br>
+from framework.test_suite import TestSuite, func_test<br>
+from framework.testbed_model.capability import NicCapability, TopologyType=
, requires<br>
+<br>
+<br>
+@requires(topology_type=3DTopologyType.two_links)<br></blockquote><div><br=
></div><div>I am thinking this testsuite might be valid for 1 link instead =
of requiring 2 links.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
+@requires(NicCapability.FLOW_CTRL)<br>
+class TestFlow(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;RTE Flow test suite.<br>
+<br>
+=C2=A0 =C2=A0 This suite consists of 10 test cases:<br>
+=C2=A0 =C2=A0 1. Queue Action Ethernet: Verifies queue actions with ethern=
et patterns<br>
+=C2=A0 =C2=A0 2. Queue Action IP: Verifies queue actions with IPv4 and IPv=
6 patterns<br>
+=C2=A0 =C2=A0 3. Queue Action L4: Verifies queue actions with TCP and UDP =
patterns<br>
+=C2=A0 =C2=A0 4. Queue Action VLAN: Verifies queue actions with VLAN patte=
rns<br>
+=C2=A0 =C2=A0 5. Drop Action Eth: Verifies drop action with ethernet patte=
rns<br></blockquote><div><br></div><div>You are using both Ethernet and Eth=
 - choose 1</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 =
patterns<br>
+=C2=A0 =C2=A0 7. Drop Action L4: Verifies drop actions with TCP and UDP pa=
tterns<br>
+=C2=A0 =C2=A0 8. Drop Action VLAN: Verifies drop actions with VLAN pattern=
s<br>
+=C2=A0 =C2=A0 9. Modify Field Action: Verifies packet modification pattern=
s<br>
+=C2=A0 =C2=A0 10. Egress Rules: Verifies previously covered rules are stil=
l valid as egress.<br>
+<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 def runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method: Callable[..., Any],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flows: list[FlowRule],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: list[Packet],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packets: list[Packet] | None =3D None=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *args: Any,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 **kwargs: Any,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Runner method that validates=
 each flow using the corresponding verification method.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method: Callable th=
at performs verification logic.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows: List of flow rules to cre=
ate and test.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: List of packets corresp=
onding to each flow.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packets: List of packet=
s to check sent packets against in modification cases.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *args: Additional positional arg=
uments to pass to the verification method.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **kwargs: Additional keyword arg=
uments to pass to the verification method.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def zip_lists(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rules: list[FlowRule],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets1: list[Packet],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets2: list[Packet] | None,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) -&gt; Iterator[tuple[FlowRule, Packet, Packe=
t | None]]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Method that cr=
eates an iterable zip containing lists used in runner.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rules: List of flo=
w rules.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets1: List of =
packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets2: Optional=
 list of packets, excluded from zip if not passed to runner.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return cast(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Iterator[tuple[Flo=
wRule, Packet, Packet | None]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zip_longest(rules,=
 packets1, packets2 or [], fillvalue=3DNone),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(rx_queues=3D4, tx_queues=3D4=
) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for flow, packet, expected_packe=
t in zip_lists(flows, packets, expected_packets):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_id =3D testpm=
d.flow_create(flow_rule=3Dflow, port_id=3D0)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verification_me=
thod =3D=3D self.send_packet_and_verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fication_method(*args, **kwargs)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif verification_=
method =3D=3D self.send_packet_and_verify_queue:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fication_method(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 packet=3Dpacket, test_queue=3Dkwargs[&quot;test_queue&quot;], te=
stpmd=3Dtestpmd<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif verification_=
method =3D=3D self.send_packet_and_verify_modification:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fication_method(packet=3Dpacket, expected_packet=3Dexpected_packet)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.flow_delet=
e(flow_id, port_id=3D0)<br>
+<br><br></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_egress_rules(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with egr=
ess directions.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd with the necessar=
y configuration.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send each packet in the list, ch=
eck reception status.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is droppe=
d.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 One packet will be sent as a confidence check,=
 to ensure packets are being<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received under normal circumstances.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(src=3D&quot;02:00:00:00:00=
:00&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IP(src=3D&quot;192.168.1.1&quot;=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCP(sport=3D1234),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 UDP(sport=3D5000),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
egress&quot;, pattern=3D[&quot;eth src is 02:00:00:00:00:00&quot;], actions=
=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;egres=
s&quot;, pattern=3D[&quot;ipv4 src is 192.168.1.1&quot;], actions=3D[&quot;=
drop&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;egres=
s&quot;, pattern=3D[&quot;tcp src is 1234&quot;], actions=3D[&quot;drop&quo=
t;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;egres=
s&quot;, pattern=3D[&quot;udp src is 5000&quot;], actions=3D[&quot;drop&quo=
t;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Verify packet reception without flow rule<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_packet_and_verify(packet=3DRaw(load=
=3D&quot;xxxxx&quot;), should_receive=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 should_receive=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br></blockquote><div><br></div><div>It looks=
 like for testing these egress rules you are adding the egress flow rule on=
 port 0, but we are actually egressing on port 1 (if 2 link topology is enf=
orced as you decorate this testsuite with). So, if my understanding is corr=
ect, then you need to egress on port 1, or on ctx.topology egress port (sam=
e thing).</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
-- <br>
2.49.0<br>
<br></blockquote><div><br></div><div>Remember to include a testsuite rst li=
ke=C2=A0<a href=3D"https://git.dpdk.org/dpdk/commit/?id=3Dd23083df081149759=
87753a887f1d1deed387ce2">https://git.dpdk.org/dpdk/commit/?id=3Dd23083df081=
14975987753a887f1d1deed387ce2</a>=C2=A0</div><div><br></div><div>Reviewed-b=
y: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu<=
/a>&gt;</div></div></div>

--000000000000cde667063868aa0b--
