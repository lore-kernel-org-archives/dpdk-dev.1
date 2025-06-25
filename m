Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703DCC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 17:30:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A20440E03;
	Wed, 25 Jun 2025 19:30:31 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id D7AB840B90
 for <dev@dpdk.org>; Wed, 25 Jun 2025 19:30:29 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so143958a12.0
 for <dev@dpdk.org>; Wed, 25 Jun 2025 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750872629; x=1751477429; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tkl0Dd2y1LPKTlmO1vXFkU9fBfwkKdJt2yk4PtMS7vk=;
 b=QUk3eUDahFvyk70to6kwJpSE4uGebPnCI2+waq8dmqMrb0tjPBJ3pmCi65Y/EB3UPx
 CeIjNf5HppxZvJxLMZIGHqpRIg4Xz2x43zKI4+Zh8H9wonYqYpxOKfs9KUpGZn2d0YCx
 1j6O8kNbESUlrWoHXCoCgvhcRSzdEA0PhYzT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750872629; x=1751477429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tkl0Dd2y1LPKTlmO1vXFkU9fBfwkKdJt2yk4PtMS7vk=;
 b=SpWVwYKIqkN5qPxwAVJndn6WYf2y7u9AuwbZ+6dfpkawXWK/3KtasHolXHKhC9bg4N
 1qOpME/5kaij0W+b/pdXIFiMTQoLBj+3Z3RmEowbOpuJOaIoCke0PyHvU3tU88Zh1I32
 eyguGNnF/i74LLt+ztOJEyR0SCPx7dvo+T2zMnQUac/KaAiMLK9iSStuJzpCN4xBaepi
 ZE6TdFjus8FbqbSGR7Voxb5mPiMbh8hzrBhjEk+JwZ0+BDWKoAPw/7oMNd93Z4wGrg6p
 GxK0uxi/e+bxxNOOapui77JNdNz33hDlM2+baX10l9t7SSa+Pno1sbtATIMfWqPL1slv
 y/Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqOpzvf9W3qR3eezHOX8S8YdmNv7VVU9RdLJf2KukluVvnLcqV2JeQqsUnMrOJ1uenifE=@dpdk.org
X-Gm-Message-State: AOJu0YxG438s+HW3ui7/dpDFxsdU2w5Txv1Mz49LtqzbPy11g3goPi8y
 g2yDe7R8I8kmKNPINi+NCA0KT6zI/0C68i7GEaeZPGpLq5L/CnR3V67JBXEKaz8FKDcFlnao7pO
 IZTxz+pUwpJAT86wWNFVhwdcK3U70rlm/xDznapx2VA==
X-Gm-Gg: ASbGncvZAm5MyBKIEVZ42eHZnb5m4tnXwh0bIFzY73XKRkgWVMXyYcMLtRhCcrr4d3k
 i2ca875FhvmT1H+3Ctchpw+lMBETaa9N5jU3Gy5nrvrF+C1BPV7qRy6RjyLJzz8dG6WUNig2Erj
 LF4Ib6ffI+xXNMmj2dpixz6bqKLK4jucup8zG6pYxMZyq6NudiigHXZXI7CoOBxpzkxICh2nYNj
 UBR
X-Google-Smtp-Source: AGHT+IFjGglj0Y7yYXccFQNtqjgQb/0D84GzkAUpDGB/K2Z04VXHkI7TpS5FMDAfT1ojzwWLtwVeMUYv8CbZxnvelM4=
X-Received: by 2002:a17:90b:4fcb:b0:312:e279:9ccf with SMTP id
 98e67ed59e1d1-315f25caa70mr5253154a91.5.1750872628752; Wed, 25 Jun 2025
 10:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250519181957.228084-1-dmarx@iol.unh.edu>
 <20250521192629.294265-1-dmarx@iol.unh.edu>
 <20250521192629.294265-2-dmarx@iol.unh.edu>
In-Reply-To: <20250521192629.294265-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 25 Jun 2025 13:25:03 -0400
X-Gm-Features: AX0GCFvV4h3mW4Fc86w2Resf_1Gah_IJdwPYYbhwge89Ync_em3Vb0cnZIPu81U
Message-ID: <CAJvnSUB27wVvV-2YW1xVH6nniDRAC9whTPvKTinRJFeJAOgqfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dts: add jump and priority tests to flow suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000159003063868cd98"
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

--000000000000159003063868cd98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:26=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Add jump action verification method and test case to Flow API test suite,
> as well as a case for validating flows with different priority levels.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/tests/TestSuite_flow.py | 187 +++++++++++++++++++++++++++++++-----
>  1 file changed, 165 insertions(+), 22 deletions(-)
>
> diff --git a/dts/tests/TestSuite_flow.py b/dts/tests/TestSuite_flow.py
> index 15566205c9..06bd3bedc5 100644
> --- a/dts/tests/TestSuite_flow.py
> +++ b/dts/tests/TestSuite_flow.py
> @@ -29,7 +29,7 @@
>  class TestFlow(TestSuite):
>      """RTE Flow test suite.
>
>
> +
> +    @func_test
> +    def test_jump_action(self) -> None:
> +        """Validate flow rules with different group levels and jump
> actions.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd with the necessary configuration.
> +            Create each flow rule in testpmd.
> +            Send each packet in the list, check Rx queue ID.
> +
> +        Verify:
> +            Check that each packet is received on the appropriate Rx
> queue.
> +        """
> +        packet_list =3D [Ether() / IP(), Ether() / IP() / TCP(), Ether()=
 /
> IP() / UDP()]
> +        flow_list =3D [
> +            FlowRule(direction=3D"ingress", group_id=3D0, pattern=3D["et=
h"],
> actions=3D["jump group 1"]),
> +            FlowRule(direction=3D"ingress", group_id=3D0, pattern=3D["ip=
v4"],
> actions=3D["jump group 2"]),
> +            FlowRule(
> +                direction=3D"ingress", group_id=3D0, pattern=3D["eth / i=
pv4"],
> actions=3D["queue index 1"]
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                group_id=3D0,
> +                pattern=3D["eth / ipv4 / tcp"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                group_id=3D0,
> +                pattern=3D["eth / ipv4 / udp"],
> +                actions=3D["queue index 3"],
> +            ),
> +        ]
> +        expected_queue_list =3D [1, 2, 3]
> +        with TestPmdShell(rx_queues=3D4, tx_queues=3D4) as testpmd:
> +            self.send_packet_and_verify_jump(
> +                packets=3Dpacket_list,
> +                flow_rules=3Dflow_list,
> +                test_queues=3Dexpected_queue_list,
> +                testpmd=3Dtestpmd,
> +            )
>

It looks like the 2nd and 3rd flow rule need to be added to group_id 1 and
2 respectively, instead of 0 and 0, in order for the jumps to groups 1 and
2 to have the desired effect you are validating on.


> +
> +    @func_test
> +    def test_priority_attribute(self) -> None:
> +        """Validate flow rules with queue actions and ethernet patterns.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is received on the appropriate queue.
> +        """
> +        test_packet =3D Ether() / IP() / Raw()
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"ingress",
> +                priority_level=3D3,
> +                pattern=3D["eth / ipv4"],
> +                actions=3D["queue index 1"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                priority_level=3D2,
> +                pattern=3D["eth / ipv4"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                priority_level=3D1,
> +                pattern=3D["eth / ipv4"],
> +                actions=3D["queue index 3"],
> +            ),
> +        ]
> +        expected_queue_list =3D [1, 2, 3]
> +        with TestPmdShell(rx_queues=3D4, tx_queues=3D4) as testpmd:
> +            testpmd.set_verbose(level=3D1)
> +            for flow, expected_queue in zip(flow_list,
> expected_queue_list):
> +                testpmd.flow_create(flow_rule=3Dflow, port_id=3D0)
> +                testpmd.start()
> +                self.send_packet_and_capture(test_packet)
> +                verbose_output =3D
> testpmd.extract_verbose_output(testpmd.stop())
> +                received =3D False
> +                for testpmd_packet in verbose_output:
> +                    if testpmd_packet.queue_id =3D=3D expected_queue:
> +                        received =3D True
> +                self.verify(received, f"Packet was not received on queue
> {expected_queue}")
> --
> 2.49.0
>


Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000159003063868cd98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 21,=
 2025 at 3:26=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Add jump action verification method and test case to Flow=
 API test suite,<br>
as well as a case for validating flows with different priority levels.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/tests/TestSuite_flow.py | 187 +++++++++++++++++++++++++++++++----=
-<br>
=C2=A01 file changed, 165 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/dts/tests/TestSuite_flow.py b/dts/tests/TestSuite_flow.py<br>
index 15566205c9..06bd3bedc5 100644<br>
--- a/dts/tests/TestSuite_flow.py<br>
+++ b/dts/tests/TestSuite_flow.py<br>
@@ -29,7 +29,7 @@<br>
=C2=A0class TestFlow(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;RTE Flow test suite.<br>
<br><br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_jump_action(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with dif=
ferent group levels and jump actions.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd with the necessar=
y configuration.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create each flow rule in testpmd=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send each packet in the list, ch=
eck Rx queue ID.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is receiv=
ed on the appropriate Rx queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [Ether() / IP(), Ether() / IP(=
) / TCP(), Ether() / IP() / UDP()]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, group_id=3D0, pattern=3D[&quot;eth&quot;], actions=3D[&quot;jump =
group 1&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, group_id=3D0, pattern=3D[&quot;ipv4&quot;], actions=3D[&quot;jump=
 group 2&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, group_id=3D0, pattern=3D[&quot;eth / ipv4&quot;], actions=3D=
[&quot;queue index 1&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / tcp&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / udp&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 3&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_queue_list =3D [1, 2, 3]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(rx_queues=3D4, tx_queues=3D4=
) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_packet_and_verify_jump=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_l=
ist,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rules=3Dflow_=
list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queues=3Dexpe=
cted_queue_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd=3Dtestpmd,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br></blockquote><div><br></div=
><div>It looks like the 2nd and 3rd flow rule need to be added to group_id =
1 and 2 respectively, instead of 0 and 0, in order for the jumps to groups =
1 and 2 to have the desired effect you are validating on.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_priority_attribute(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with que=
ue actions and ethernet patterns.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is receiv=
ed on the appropriate queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_packet =3D Ether() / IP() / Raw()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priority_level=3D3=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 1&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priority_level=3D2=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priority_level=3D1=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 3&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_queue_list =3D [1, 2, 3]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(rx_queues=3D4, tx_queues=3D4=
) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_verbose(level=3D1)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for flow, expected_queue in zip(=
flow_list, expected_queue_list):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.flow_creat=
e(flow_rule=3Dflow, port_id=3D0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_packet_a=
nd_capture(test_packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose_output =3D=
 testpmd.extract_verbose_output(testpmd.stop())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D False=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for testpmd_packet=
 in verbose_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if t=
estpmd_packet.queue_id =3D=3D expected_queue:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 received =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(receiv=
ed, f&quot;Packet was not received on queue {expected_queue}&quot;)<br>
-- <br>
2.49.0<br></blockquote><div><br></div><div><br></div><div>Reviewed-by: Patr=
ick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=
=C2=A0</div></div></div>

--000000000000159003063868cd98--
