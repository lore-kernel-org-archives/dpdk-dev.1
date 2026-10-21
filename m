Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1052606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VFLqqxOw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EE0C402B3;
	Wed, 21 Oct 2026 04:02:52 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 76CC64029E
 for <dev@dpdk.org>; Wed, 21 Oct 2026 04:02:51 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso1463415e9.2
 for <dev@dpdk.org>; Tue, 20 Oct 2026 19:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792548171; cv=none;
 d=google.com; s=arc-20260327;
 b=LFImHYCzjYE3jF408zm1CR/0+GfDhoACUDst2l2pZiK5NG6RO433EIGXAAYBYz1gg/
 LKgLjtJ8EtVdS0TG2VbfoJ7ghPFZtCtvGVGAcdQXjoDkPl3Npgii8/tHuJSXwW2Rvjx6
 K9b9cXWEiHzvyknqSMfWthj1bHqxRQNoETZD00rZNfK3vA3S72KXQtZ3i6pzBLMN2ubP
 L4XzVmJ+EsWDbZG2HHpfQXh12Ih648gTOa4Kk/sgERfEbTX0gPu6/Qk+DTzTN0Z3MffR
 6mdtCOm/5LNfEi6/5YmewgqI1nWYjMRXA5Tvo0WCeqPzjrM3pX5WU/NMLBKaY2w7oZUf
 xm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P/FcrzN81PE/YqQPkXqd1urZc36Pd+P8JsZpB1VRzyQ=;
 fh=kPuj/SyBBjNyluznlPO98uM1mge6pQYADO/rBl8ZMrE=;
 b=WDLRef0gkwDIOR9K6ScHbp7sN7trQqG7WKIkEtzxux8GetE0SAZIpp7Cb1mLyUKrhH
 wqxYj59ljNfnOvuYC4cpkODZPerZLAunQf0/pNyFeX320Hy2SUlUaPw31Y96h/3zEfFH
 ZZP8zKNvn6ERMb8VZCWkd0Q7oEuwErjqgGdkV9SFrsw2Xynx+n8KCrPWb5066wdNw7wl
 02epXehjpwjgbkx0h/DA+ag9nHz1fJLo8xTJPPcxXJsJgrMw0l9WxRrMWOxlY8VcVE/P
 H7Z6uu4qeSU7rmK6THvrEKRp2FeFzA+tsOh7egx512QmZJPsIGgBm6uxm0hNAYu3tYcH
 lHLQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792548171; x=1793152971; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P/FcrzN81PE/YqQPkXqd1urZc36Pd+P8JsZpB1VRzyQ=;
 b=VFLqqxOwaLAGkWcGQn4lf5dyKLWijeaBNtbwu8NijWzCIARxiJ0+DURIxlEscHDCvM
 eAY39xWdE2Fhp2uQr+Ca8K/oqqiZXREoaVZmGSf3+YVmlKMGmLMrsbqk48HAXlJEHADF
 KZkdd7mRdtXjf6/SlSliSy3JNCn/3IlymiFPVeR+JrH/PZZVKQYEEGM/CyehRsH1YHqx
 Q5qTvHL5AWTNvx/0QtsMBTvIopWx9aDrN4MlU7T2JrhvbOEBSxYkXXKKde4hX9K6rmhW
 POUhJY3kStnCBauMmTL7nbLIi16qlHWgy1cH+80yrIY1XFAfWZq/+VsCFkvz4lmhm+iw
 qgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792548171; x=1793152971;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P/FcrzN81PE/YqQPkXqd1urZc36Pd+P8JsZpB1VRzyQ=;
 b=hViMvXJ28pXs5YI8i4TYtXlNIOX8TqCf93EHGkgmDamXdROBbhbXtmJHcrSey2+feR
 FWeXzAbKsbkcvfEeyO2z4yEWjyzcXAoS1ZO97Q9vhad16Qv4zjViSUDRuxU1/SqaX6h7
 iJ+ZeWiRx6ld3vfo8bMzukV/iAa5Nd4fIaLOYzdd/4VdIuBY5vESLX4zHF1RRtWW1q5c
 5yC6p9qvwuFj4kY8ffQlfqvsYvIoxCYh8uymYOPw07GC58UmC5eDaQ5XbE5jfOhqsRYp
 4oWK1P8tuReIZac4b+1T35iTQbx7gu9KBZ1VnJKfx50BJgGiVIxqAUSmGaB2lShd+bvB
 eVlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFiP5yyhvDkHdAoz+1cIY5KNIPy6SAYStBQP97VyXgagcDq0yykYk3S8HlZZZT3+9OjYY=@dpdk.org
X-Gm-Message-State: AFq9FYJr2qtQSJ4JdqZOZfFinR8SPguTX2sYK+YjaDJAXGRQ0OYa0uYK
 ZqrT3lFoSDUhXmaDAqDDiAZzl8otdP+orojyDF6n/1wUbBI4f9wHw4s3tievlN43k/xnnZarVYs
 omlZTy6cuAfrdAcOGTcT5l15JDQd4zro=
X-Gm-Gg: AYBFou3lCBiUqbCxeYkz8bcC5Gj+AdQN2ZM4fc/OkKyEbfOX99tuKP2y+MkgXQgKYqA
 AcivbfIhVu4i4THZ8Vcu/M7h2ruToKjGbyFm8XcTCPL4gL+XiEG3WHSRS2AfJuP5IAZVoy2KwMS
 q/TFqPxJEwWQok/TePowTItFdHQLpNJzsnAWsjwQf9ukHa5WvrwLt42GvIVhrmMBJwlA+fGj1Oa
 lZbDZvdwZ7lXxA1YWGeM3wxqQj4q1GPTZVpjpAl1z2gq7mvx0shra8J1T+o+QSJS3N+5Jz8ah38
 d8tWCjCbeBLUJRtx8GjnklgUTtgrQGMT8/yw80DvlUwKKHIOAk6VHeVPu1wIqlJS1nFDBPtb45V
 5CiIYWxfBEk91lZjjTEASuCI58jue6eH2YFfRxwgD+IQ1+fLPzWtHbxBwjwQke5rhzOWn
X-Received: by 2002:a05:600c:8b43:b0:4a0:1c0e:b136 with SMTP id
 5b1f17b1804b1-4a1fdd3ba5bmr8584845e9.29.1792548170623; Tue, 20 Oct 2026
 19:02:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260805153658.345207-1-abailey@iol.unh.edu>
In-Reply-To: <20260805153658.345207-1-abailey@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Tue, 20 Oct 2026 22:02:39 -0400
X-Gm-Features: AclHuK8or0sBjORPnd6Ce5ByGVE9Ha6g9YWya8lVlTpfZgIlYv_B2GjJSBl0eZI
Message-ID: <CAK6Duxvscj4UFRBmHFzA_HQ4QxcXoPnOiOc05E85ykJDw1=7AQ@mail.gmail.com>
Subject: Re: [PATCH v1] dts: update configuration for performance test
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dladd@iol.unh.edu, dev@dpdk.org, luca.vizzarro@arm.com, 
 knimoji@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000f3f11c065e5024ce"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f3f11c065e5024ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:37=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> The single core forward performance test suite can run a variety of
> combinations of buffer sizes and number of descriptors. It is beneficial
>

"it would be"


> if any possible combination of these parameters could be tested against
> a specific delta tolerance; Rather than a globally defined tolerance for
>

is semi colon right here?


> all testing. Along with this, adjusting traffic duration and test
> repetitions helps users define a more accurate test run if they wish to
> get a more refined average. Furthermore, the cores allotted to TREX can
> vary among systems and should be defined by the user.


nit but can you call out the specific performance test in the commit title?


>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
>
>  #: A union type discriminating traffic generators by the `type` field.
> diff --git a/dts/framework/testbed_model/traffic_generator/trex.py
> b/dts/framework/testbed_model/traffic_generator/trex.py
> index d53791b0a6..2b52cfcbd1 100644
> --- a/dts/framework/testbed_model/traffic_generator/trex.py
> +++ b/dts/framework/testbed_model/traffic_generator/trex.py
> @@ -82,7 +82,7 @@ class TrexTrafficGenerator(PerformanceTrafficGenerator)=
:
>
>      _streaming_mode: TrexStatelessTXModes =3D TrexStatelessTXModes.STLTX=
Cont
>
> -    _tg_cores: int =3D 10
> +    _tg_cores: int
>

Why not keep the default of 10 but allow cores as an optional parameter in
test_run.yaml?

I don't feel strongly about the matter but in general I don't want "config
creep" when we can avoid it. Less config is better. But yes we can add
config when necessary.


>
>      _trex_app: BlockingApp
>
> @@ -102,6 +102,7 @@ def __init__(self, tg_node: Node, config:
> TrexTrafficGeneratorConfig) -> None:
>          super().__init__(tg_node=3Dtg_node, config=3Dconfig)
>          self._tg_node_config =3D tg_node.config
>          self._tg_config =3D config
> +        self._tg_cores =3D config.cores
>
>          self._os_session =3D create_session(self._tg_node.config, "TRex"=
,
> self._logger)
>
> diff --git a/dts/tests/TestSuite_single_core_forward_perf.py
> b/dts/tests/TestSuite_single_core_forward_perf.py
> index 57aecdf7a4..a966d44ebd 100644
> --- a/dts/tests/TestSuite_single_core_forward_perf.py
> +++ b/dts/tests/TestSuite_single_core_forward_perf.py
> @@ -32,14 +32,40 @@ class Config(BaseConfig):
>      """Performance test metrics."""
>
>      test_parameters: list[dict[str, int | float]] =3D [
> -        {"frame_size": 64, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> -        {"frame_size": 128, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> -        {"frame_size": 256, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> -        {"frame_size": 512, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> -        {"frame_size": 1024, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> -        {"frame_size": 1518, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 64, "num_descriptors": 1024, "expected_mpps":
> 1.00, "delta_tolerance": 0.05},
> +        {
> +            "frame_size": 128,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "delta_tolerance": 0.05,
> +        },
> +        {
> +            "frame_size": 256,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "delta_tolerance": 0.05,
> +        },
> +        {
> +            "frame_size": 512,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "delta_tolerance": 0.05,
> +        },
> +        {
> +            "frame_size": 1024,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "delta_tolerance": 0.05,
> +        },
> +        {
> +            "frame_size": 1518,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "delta_tolerance": 0.05,
> +        },
>      ]
> -    delta_tolerance: float =3D 0.05
>

So, with this patch applied one MUST set the delta_tolerance per param, as
opposed to optionally setting it per param or per testsuite? I'm not sure
if it's a big lift to support both, but given that 99% of people probably
want to just say "5% delta tolerance for single core forward perf
testsuite" it would make sense to preserve that existing config option.


> +    traffic_duration: int =3D 5
> +    test_repetitions: int =3D 5
>

Do you need to update tests_config.example.yaml? And explain which
parameters are optional vs required?


>
>
>  @requires_link_topology(LinkTopology.TWO_LINKS)
>
>
Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>

--000000000000f3f11c065e5024ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 5, =
2026 at 11:37=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.un=
h.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">The single core forward performance test suite ca=
n run a variety of<br>
combinations of buffer sizes and number of descriptors. It is beneficial<br=
></blockquote><div><br></div><div>&quot;it would be&quot;</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
if any possible combination of these parameters could be tested against<br>
a specific delta tolerance; Rather than a globally defined tolerance for<br=
></blockquote><div><br></div><div>is semi colon right here?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
all testing. Along with this, adjusting traffic duration and test<br>
repetitions helps users define a more accurate test run if they wish to<br>
get a more refined average. Furthermore, the cores allotted to TREX can<br>
vary among systems and should be defined by the user.</blockquote><div><br>=
</div><div>nit but can you call out the specific performance test in the co=
mmit title?=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br><br>
=C2=A0#: A union type discriminating traffic generators by the `type` field=
.<br>
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/fr=
amework/testbed_model/traffic_generator/trex.py<br>
index d53791b0a6..2b52cfcbd1 100644<br>
--- a/dts/framework/testbed_model/traffic_generator/trex.py<br>
+++ b/dts/framework/testbed_model/traffic_generator/trex.py<br>
@@ -82,7 +82,7 @@ class TrexTrafficGenerator(PerformanceTrafficGenerator):<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0_streaming_mode: TrexStatelessTXModes =3D TrexStateless=
TXModes.STLTXCont<br>
<br>
-=C2=A0 =C2=A0 _tg_cores: int =3D 10<br>
+=C2=A0 =C2=A0 _tg_cores: int<br></blockquote><div><br></div><div>Why not k=
eep the default of 10 but allow cores as an optional parameter in test_run.=
yaml?</div><div><br></div><div>I don&#39;t feel strongly about the matter b=
ut in general I don&#39;t want &quot;config creep&quot; when we can avoid i=
t. Less config is better. But yes we can add config when necessary.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0_trex_app: BlockingApp<br>
<br>
@@ -102,6 +102,7 @@ def __init__(self, tg_node: Node, config: TrexTrafficGe=
neratorConfig) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__(tg_node=3Dtg_node, confi=
g=3Dconfig)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._tg_node_config =3D tg_node.config<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._tg_config =3D config<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._tg_cores =3D config.cores<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._os_session =3D create_session(self.=
_tg_node.config, &quot;TRex&quot;, self._logger)<br>
<br>
diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/Te=
stSuite_single_core_forward_perf.py<br>
index 57aecdf7a4..a966d44ebd 100644<br>
--- a/dts/tests/TestSuite_single_core_forward_perf.py<br>
+++ b/dts/tests/TestSuite_single_core_forward_perf.py<br>
@@ -32,14 +32,40 @@ class Config(BaseConfig):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Performance test metrics.&quot;&quot;=
&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0test_parameters: list[dict[str, int | float]] =3D [<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 64, &quot;num_descrip=
tors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 128, &quot;num_descri=
ptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 256, &quot;num_descri=
ptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 512, &quot;num_descri=
ptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 1024, &quot;num_descr=
iptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 1518, &quot;num_descr=
iptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 64, &quot;num_descrip=
tors&quot;: 1024, &quot;expected_mpps&quot;: 1.00, &quot;delta_tolerance&qu=
ot;: 0.05},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;frame_size&quot;: 128,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;num_descriptors&quot;: 102=
4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;expected_mpps&quot;: 1.00,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;delta_tolerance&quot;: 0.0=
5,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;frame_size&quot;: 256,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;num_descriptors&quot;: 102=
4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;expected_mpps&quot;: 1.00,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;delta_tolerance&quot;: 0.0=
5,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;frame_size&quot;: 512,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;num_descriptors&quot;: 102=
4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;expected_mpps&quot;: 1.00,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;delta_tolerance&quot;: 0.0=
5,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;frame_size&quot;: 1024,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;num_descriptors&quot;: 102=
4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;expected_mpps&quot;: 1.00,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;delta_tolerance&quot;: 0.0=
5,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;frame_size&quot;: 1518,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;num_descriptors&quot;: 102=
4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;expected_mpps&quot;: 1.00,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;delta_tolerance&quot;: 0.0=
5,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0]<br>
-=C2=A0 =C2=A0 delta_tolerance: float =3D 0.05<br></blockquote><div><br></d=
iv><div>So, with this patch applied one MUST set the delta_tolerance per pa=
ram, as opposed to optionally setting it per param or per testsuite? I&#39;=
m not sure if it&#39;s a big lift to support both, but given that 99% of pe=
ople probably want to just say &quot;5% delta tolerance for single core for=
ward perf testsuite&quot; it would make sense to preserve that existing con=
fig option.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 traffic_duration: int =3D 5<br>
+=C2=A0 =C2=A0 test_repetitions: int =3D 5<br></blockquote><div><br></div><=
div>Do you need to update tests_config.example.yaml? And explain which para=
meters are optional vs required?</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br><br></blockquote><=
div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:patrickr=
obb1997@gmail.com">patrickrobb1997@gmail.com</a>&gt;=C2=A0</div></div></div=
>

--000000000000f3f11c065e5024ce--
