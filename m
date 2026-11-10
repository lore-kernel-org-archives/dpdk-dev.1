Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFC60A5BC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=S+YwH292
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62EE540285;
	Tue, 10 Nov 2026 16:41:26 +0100 (CET)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTPS id 4CBC440281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 16:41:25 +0100 (CET)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-536717a4d83so18278531cf.2
 for <dev@dpdk.org>; Tue, 10 Nov 2026 07:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325284; cv=none;
 d=google.com; s=arc-20260327;
 b=EKp1EtA1ZWDSY8MWFDwu8zkcVKHnrLB6oVeZ54Hk1MFnzhRV9T51b4sZjCPuTNiQp6
 +KCkFZsXeyJz/ZS+OFd4M4BBLqaVUrCrjeMaxT+QzZniKOXTkLZisPWp4RKzv+PtDqbP
 /ADueIW8j+xHwvYRBIk9u3t/Wc72GPcIgRl4fc5GRM8flIdQkV+7wJLVWG7W/0fP5C5H
 n83FoPSb6nZMG5LuHsWECvh2scIOoyrgZuu59Uh1EXFK/oSxdTVsxanBF57uzm8+Hr4T
 x0UTSKvKakH04DjQr+YAHC9DeHZTPRuCu6b9FGdp6I4lY3NostxQU2740e8wumu+IIMb
 Qkug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yuC0WyDRCE+dnVyN034MzRzWk+5WqsxLu0dRDsXJXM8=;
 fh=+0fmxhDOVPcHLntDs8nvs8u3uO4M0Hml3FJ1mCLGEik=;
 b=MH85SKMPGLZcFe++r/gRwu+nLcLmBm5xnIbzjykS/UPvjrbMnwQv2z3ZX9XMSTcJgM
 qCD1zAr4yYedYD3rLnU25MJiz1i0iNwdqGBofqBxzyGpUtU6BBeziphlK/8EYuZ/S1Sd
 PZpuXECkg2tJjiWFrMjcvPPxe+hM9SBliS8JZvagLyHtq881icAr/37HWJVb7GP+ilB8
 5HbkqjS+4cQWexl5xPXPmZzISK4OlLggT8q7fs2Bg6/UIysa6lzKlIVfgkoEm3+v06gQ
 VdjLtYisWXaOU8NEdnu47xbXAh+6Gj979cHRoCHpfrZ5LwTJzPThif8r/WvVQG1P68qU
 r2eg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1794325284; x=1794930084; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yuC0WyDRCE+dnVyN034MzRzWk+5WqsxLu0dRDsXJXM8=;
 b=S+YwH292OVZ6zJiv3LYwoxrheseH1cfT8R9vfUgQVB+L1M19jCiOwNIzg88ZUD/M9Q
 e4RTTvTu1Dah/XTzl0UUA4/wo7BkaiBwV1idcfvBwVA9zWps1f0O7GFFLmXkGcvtT6WO
 drZI9L1agzGBOV61328GwTFKTwwAzMok7e+Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794325284; x=1794930084;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yuC0WyDRCE+dnVyN034MzRzWk+5WqsxLu0dRDsXJXM8=;
 b=SIEb9Z5NaseKOZgc8+GcR2kvCerSwK3qDDeiuFqbhYwm/FEXWXQZY7JPbRclywnWgh
 yCL/2HkwlSpWAz6zGIsgfM5NEMmJJFhxlu/EmcvE4jaVE3V0B5ZuxT22x1JmAWHQg96a
 SatBNygXwOdpFz9zk9xQ0YEXRPEEOYr0wSAP0XNmA6YGWsQH1xOhSrYx3t7TRqAlrN+S
 ZCpM/U3SzgzJa6JhY3p7R/nw9LqPFuK0NdrT90o4+l2BrjVvauTI+HStUKcvrErO/1H/
 IQCIlXUpLlFfQuEYmLjujLZMCmmdY4PkjwRNdJ+IV/qMuUejJmLn4Tv8fNaOGG4DGUC/
 fDAw==
X-Forwarded-Encrypted: i=1;
 AL+hErEJZyEpdeHfREIFNp3kjHM3185aCdgYGipBkBv8JBUe6ccaX9Ttz+k5IzgbN1YxnNc0QQ0=@dpdk.org
X-Gm-Message-State: APuU4Z9HfVONs/JdKTu0flpIZ1kxV8sNSim4GrfXGcS1AylAwC+bXW1i
 jgt82B7T3gpJwuIWhoOeLh6JTKso75rsKMOIuSXr81kFkDx6wGFfojyup60X4JGT4y6DJneovC8
 wbOOAAU3XOWHeiSSdNPTHEFwIlDllu9awsDmEWUZybw==
X-Gm-Gg: AYBFou0J+/ZI4LrsMlQdr8p18im9vPc/Bwsj2wDafD39zN196eAtLs3xsWkzjBU4r8R
 w5mMLZkYHnrfT5A4xs9rM04KWo9Wgyc2O3MGmOEfcTWtl+MB03t9KtX7I4A63Xop6UckIv3prIZ
 MviN6hwCDxZAGUxuC/4MiR6J4d//X8AJ/G5xJ/8OhEmVXwmarNpzLh07yZIoicW0cukcwySEd+9
 VN+fZz5cZ2qpKfBQlQTo/ZJQuiULmFosQSBPqAndmdyjU1kfTwbcUQ5uWXaWj6r7NClPB9P9k9R
 A1XAwPoX1+IQ7dF40pHrKIRmYbxyIYxMTHb2yfMzzIpY6USJ3EvcnBBSKqsKz7JAHKmx1DxGfeo
 DPgDAxMpx4bblsf6lYLwrjLfcfWYCQtM08z/oJtuyIAh32Xqx3Km196E/8VtU0XpRRKqcUH3o2Z
 5BWPqZyh4Xv5+x8Ervnbr8x3RUsMSIurkW/dvrQUhJONq3dHSfNpX6baobw9wOs9VQaRqeszzyG
 PIEKv9mK14VpDgibQ+YrYkuPuzB
X-Received: by 2002:a05:622a:1ba7:b0:535:33a:c75d with SMTP id
 d75a77b69052e-55529a90ab0mr40981991cf.32.1794325283977; Tue, 10 Nov 2026
 07:41:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261103220218.902765-1-knimoji@iol.unh.edu>
 <9e507b8c-b106-4177-8ce2-e09fc630e4d4@arm.com>
In-Reply-To: <9e507b8c-b106-4177-8ce2-e09fc630e4d4@arm.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 10 Nov 2026 10:40:47 -0500
X-Gm-Features: AclHuK9xnY1lktVNGj8yz_pT41k0jUQG12jQpbxs73agrLTWculknC9wB19juIM
Message-ID: <CAKYPG+zSf_i6FDcUEutMgAuuYP_8MyGXCRXBtv_ADNxqM_ELuA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dts: add pvp multi paths vhost performance
 testsuite
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, dladd@iol.unh.edu, 
 abailey@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000029d186065fede966"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000029d186065fede966
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 7:50=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.co=
m> wrote:

> On 03/11/2026 22:02, Koushik Bhargav Nimoji wrote:
> > diff --git a/dts/api/testbed_model/virtual_device.py
> b/dts/api/testbed_model/virtual_device.py
> > index 1a4794e695..8ac9a625f5 100644
> > --- a/dts/api/testbed_model/virtual_device.py
> > +++ b/dts/api/testbed_model/virtual_device.py
> > @@ -6,6 +6,8 @@
> >   Alongside support for physical hardware, DPDK can create various
> virtual devices.
> >   """
> >
> > +from api.context import get_ctx
> > +
> >
> >   class VirtualDevice:
> >       """Base class for virtual devices used by DPDK.
> > @@ -27,3 +29,9 @@ def __init__(self, name: str) -> None:
> >       def __str__(self) -> str:
> >           """This corresponds to the name used for DPDK devices."""
> >           return self.name
> > +
> > +
> > +def clean_up_vhost() -> None:
> > +    """Deletes stale vhost-user Unix domain socket files."""
> > +    ctx =3D get_ctx()
> > +    ctx.sut_node.main_session.send_command("rm -rf /tmp/vhost-net*",
> privileged=3DTrue)
> I welcome this change but send_command is still something that should be
> called by the relevant OSSession class. In theory main_session can be a
> session for a host of any OS, be Linux, FreeBSD, Windows etc. Therefore
> the changes should be OS-independent.
>
> I've reviewed the usage better and the test suite shouldn't be able to
> arbitrarily create files out of arbitrary paths. We have the class
> Artifact to help abstract the remote filesystem away. On remote session
> this also takes care of cleanup.
>
> Instead of introducing this change which has no real ownership in the
> framework and api packages, I'd suggest letting the test suite create
> the vhost-net using the Artifact class instead.
>

After further digging, I've realized that the vhost socket files are
automatically deleted when testpmd quits, I've double checked this when
running DTS manually and ensured that even when I abruptly quit DTS the
vhost socket files are still deleted. I will remove all clean_up_vhost()
calls from my patch in the next version.

> +
> > +from typing import TypedDict, cast
> > +
> > +from scapy.layers.inet import IP
> > +from scapy.layers.l2 import Ether
> > +from scapy.packet import Raw
> > +from typing_extensions import NotRequired
> > +
> > +from api.capabilities import (
> > +    LinkTopology,
> > +    requires_link_topology,
> > +)
> > +from api.packet import assess_performance_by_packet
> > +from api.params.eal import VirtualDevice
> > +from api.params.types import LogicalCoreList, RSSSetting,
> TestPmdParamsDict
> > +from api.test import get_current_test_case_name, verify,
> write_performance_json
> > +from api.test_suite import BaseConfig, TestSuite, perf_suite, perf_tes=
t
> > +from api.testbed_model.virtual_device import clean_up_vhost
> > +from api.testpmd import TestPmd
> > +from api.testpmd.config import (
> > +    Params,
> > +    PortTopology,
> > +    RXRingParams,
> > +    SimpleForwardingModes,
> > +    TXRingParams,
> > +)
> > +
> > +
> > +class TestParameter(TypedDict):
> > +    """Performance test metrics."""
> > +
> > +    frame_size: int
> > +    num_descriptors: int
> > +    expected_mpps: float
> > +    performance_delta: NotRequired[float | None]
> > +    measured_mpps: NotRequired[float | None]
> > +    passing: NotRequired[float | None]
> I've noticed that this kind of configuration is ubiquitous across
> performance test suites. I'd propose to abstract the Config and this
> away as a generic PerfSuiteConfig and re-use it accordingly. In that
> case you can move away from using a TypedDict and use a Pydantic
> BaseConfig instead which will allow you to use more powerful constructs.
>
> You won't need to use NotRequired =E2=80=93 which I am assuming makes doi=
ng `|
> None` redundant, in that case. Moreover the fields should be documented
> appropriately similarly to what was done in the config package.


I agree, I will create a PerfSuiteConfig in my next version.

All other mentioned changes will be reflected in my next version as well,
thanks!

--00000000000029d186065fede966
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"backgroun=
d-color:transparent">On Tue, Nov 10, 2026 at 7:50=E2=80=AFAM Luca Vizzarro =
&lt;</span><a href=3D"mailto:Luca.Vizzarro@arm.com" target=3D"_blank" style=
=3D"background-color:transparent">Luca.Vizzarro@arm.com</a><span style=3D"b=
ackground-color:transparent">&gt; wrote:</span></div><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On 03/11/2026 22:02,=
 Koushik Bhargav Nimoji wrote:<br>
&gt; diff --git a/dts/api/testbed_model/virtual_device.py b/dts/api/testbed=
_model/virtual_device.py<br>
&gt; index 1a4794e695..8ac9a625f5 100644<br>
&gt; --- a/dts/api/testbed_model/virtual_device.py<br>
&gt; +++ b/dts/api/testbed_model/virtual_device.py<br>
&gt; @@ -6,6 +6,8 @@<br>
&gt;=C2=A0 =C2=A0Alongside support for physical hardware, DPDK can create v=
arious virtual devices.<br>
&gt;=C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +from api.context import get_ctx<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0class VirtualDevice:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Base class for virtual dev=
ices used by DPDK.<br>
&gt; @@ -27,3 +29,9 @@ def __init__(self, name: str) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def __str__(self) -&gt; str:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;This corresp=
onds to the name used for DPDK devices.&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return <a href=3D"http://self.=
name" rel=3D"noreferrer" target=3D"_blank">self.name</a><br>
&gt; +<br>
&gt; +<br>
&gt; +def clean_up_vhost() -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;Deletes stale vhost-user Unix domain =
socket files.&quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 ctx =3D get_ctx()<br>
&gt; +=C2=A0 =C2=A0 ctx.sut_node.main_session.send_command(&quot;rm -rf /tm=
p/vhost-net*&quot;, privileged=3DTrue)<br>
I welcome this change but send_command is still something that should be <b=
r>
called by the relevant OSSession class. In theory main_session can be a <br=
>
session for a host of any OS, be Linux, FreeBSD, Windows etc. Therefore <br=
>
the changes should be OS-independent.<br>
<br>
I&#39;ve reviewed the usage better and the test suite shouldn&#39;t be able=
 to <br>
arbitrarily create files out of arbitrary paths. We have the class <br>
Artifact to help abstract the remote filesystem away. On remote session <br=
>
this also takes care of cleanup.<br>
<br>
Instead of introducing this change which has no real ownership in the <br>
framework and api packages, I&#39;d suggest letting the test suite create <=
br>
the vhost-net using the Artifact class instead.<br></blockquote><div>=C2=A0=
</div><div>After further digging, I&#39;ve realized that the vhost socket f=
iles are automatically deleted when testpmd quits, I&#39;ve double checked =
this when running DTS manually and ensured that even when I abruptly quit D=
TS the vhost socket files are still deleted. I will remove all clean_up_vho=
st() calls from my patch in the next version.</div><div><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +from typing import TypedDict, cast<br>
&gt; +<br>
&gt; +from scapy.layers.inet import IP<br>
&gt; +from scapy.layers.l2 import Ether<br>
&gt; +from scapy.packet import Raw<br>
&gt; +from typing_extensions import NotRequired<br>
&gt; +<br>
&gt; +from api.capabilities import (<br>
&gt; +=C2=A0 =C2=A0 LinkTopology,<br>
&gt; +=C2=A0 =C2=A0 requires_link_topology,<br>
&gt; +)<br>
&gt; +from api.packet import assess_performance_by_packet<br>
&gt; +from api.params.eal import VirtualDevice<br>
&gt; +from api.params.types import LogicalCoreList, RSSSetting, TestPmdPara=
msDict<br>
&gt; +from api.test import get_current_test_case_name, verify, write_perfor=
mance_json<br>
&gt; +from api.test_suite import BaseConfig, TestSuite, perf_suite, perf_te=
st<br>
&gt; +from api.testbed_model.virtual_device import clean_up_vhost<br>
&gt; +from api.testpmd import TestPmd<br>
&gt; +from api.testpmd.config import (<br>
&gt; +=C2=A0 =C2=A0 Params,<br>
&gt; +=C2=A0 =C2=A0 PortTopology,<br>
&gt; +=C2=A0 =C2=A0 RXRingParams,<br>
&gt; +=C2=A0 =C2=A0 SimpleForwardingModes,<br>
&gt; +=C2=A0 =C2=A0 TXRingParams,<br>
&gt; +)<br>
&gt; +<br>
&gt; +<br>
&gt; +class TestParameter(TypedDict):<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;Performance test metrics.&quot;&quot;=
&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 frame_size: int<br>
&gt; +=C2=A0 =C2=A0 num_descriptors: int<br>
&gt; +=C2=A0 =C2=A0 expected_mpps: float<br>
&gt; +=C2=A0 =C2=A0 performance_delta: NotRequired[float | None]<br>
&gt; +=C2=A0 =C2=A0 measured_mpps: NotRequired[float | None]<br>
&gt; +=C2=A0 =C2=A0 passing: NotRequired[float | None]<br>
I&#39;ve noticed that this kind of configuration is ubiquitous across <br>
performance test suites. I&#39;d propose to abstract the Config and this <b=
r>
away as a generic PerfSuiteConfig and re-use it accordingly. In that <br>
case you can move away from using a TypedDict and use a Pydantic <br>
BaseConfig instead which will allow you to use more powerful constructs.<br=
>
<br>
You won&#39;t need to use NotRequired =E2=80=93 which I am assuming makes d=
oing `| <br>
None` redundant, in that case. Moreover the fields should be documented <br=
>
appropriately similarly to what was done in the config package.</blockquote=
><div><br></div><div>I agree, I will create a PerfSuiteConfig in my next ve=
rsion.</div><div><br></div><div>All other mentioned changes will be reflect=
ed in my next version as well, thanks!</div></div></div>
</div>

--00000000000029d186065fede966--
