Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA0606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=F7AOmD+s
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62D9340283;
	Tue, 20 Oct 2026 18:06:39 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id C56E24025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 18:06:37 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-5363c8de563so29691751cf.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 09:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792512397; cv=none;
 d=google.com; s=arc-20260327;
 b=S4o9SdVqxQhF2qkuK/x2gL0qAeB/CUWQFMlERgjmP8SAJOwGBCS7DGgTnrmUsIRoyL
 FlfrUHImxkgkDQtAs8afW8NYjHLSI988u+ulp6dVAm8kJMBItHB6H3I0P9O9NfWpsv3j
 6lZFiadwF0NcDEvEhzvX4ndETEaZlFoHMueoDlvMrFkDsMNpl5BDLIAVzTmGxB3PBeY3
 VDSRC/ceBRDgEEPOM4frs8K5phJXNGyrB34eUhYvwKXGXsUhv1mxaLbs4uZe9EsN1Q1F
 MzHL9UWwRwYCt4SuKdEZWLik/M7GkM6bkhubvjkg0REdjAdoLXl8YOgRtyXCnFRwZhfO
 McFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=md8SBC/3k8cblG1eboSyxeUCwsqzF528oAnhNICYo5E=;
 fh=UjwYeoOcObmgzkjIlgMtBkklno5Lh0OeYju9/iBXZt4=;
 b=BBqxZKoPIoWXZ38HKuDZuPV0Klbp79S/IZFkVptMvDPYmhxauCHbyLUKoKxSzMQrDu
 DrW0zMqBMiR7T901GbToNm7aZM4T4or805C9OnMYnvrQn7PHYQCWiLM2ff+ycuyT7Os9
 nZL4IlhqCrZGQfyv1HBSCDxnyj5Z+H4Vk8Z2wkAwBOCHHUKLWrBagMVGH8N0hBc8kYnQ
 eRyh8i1ELFBUToWvXTHtbcbRF1Ts5QsDf4gHlflmVkt9s5Hl3CC/EeO8sw8cP8gkjtqE
 kAhFcfRrzAP6k2ZxltbwlTaR9JJljokxJE+uxy3m11rI0QybFQvsz+sV10FRKeDCvZTD
 knhg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792512397; x=1793117197; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=md8SBC/3k8cblG1eboSyxeUCwsqzF528oAnhNICYo5E=;
 b=F7AOmD+sUhgsLe0/qxOj5LXVE0P79k83/FGpzCaBNuwe20xkaRGAbBOGx4z9D/gHsx
 qlSoB6D8wbI9SvO7sab/tf27EE+ovWp65lxyNvenfhCrsE6ZzP2QAkqWzU3yI4qVPTgY
 XXy0I/f8QTnIY4hfdWSfKk6x0XFMnFRXzpVr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792512397; x=1793117197;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=md8SBC/3k8cblG1eboSyxeUCwsqzF528oAnhNICYo5E=;
 b=QDvRaadgW068OS13h2+3111cYdS0nVOc/bJiuUD4HM14ymqluzjEutcl6f+V4rzNKZ
 +ME4cInfiNTgzesexjvbq8PDa/sLoJ17ef6kfEUbyTINH5XbKh9hHgBcUNRdVCYA4bvU
 S5M0Tp7D/ZYk7qlEGnxOhqIns58VY+LFvxWWgPhcUnFI4qjySc76A+tAaCobOfth5Xjs
 hbvJhSbjK/d2z/jpXs1D09Q1Fe1e30TyiPqoSD/ayBRyDzqAyTeMLrSx1mKQL4iQaV43
 86k6JKWnji3NK2x+jMzf5L6uz1bfPlGJ8d4AwNha1wCammQp0gi1ZHlINr+fgkOACtMu
 5QSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFs4G14BWggk+IILQE3v9JR8mKzMPPHJI1DXMA4ywCn/g2mxe+5KwiES0hxLvMkI6JGAY=@dpdk.org
X-Gm-Message-State: AFq9FYKv/rczsjyDMUVZ4CzfYE+hYNxUqnNxZCkQ7fcnl7ghdUi3xciW
 7AY1mL+py06dFqVMQQXziDSGd/059x/3PeBK0gxunOEmJenu5knq+5kk/uC98y9r+mlWmUMEfNJ
 Vfq3UrhIbZe2y9qTQr15o6EDweRpgL7SLEsinFNK60A==
X-Gm-Gg: AYBFou2IGc+tmiZtGvh/XXyHtJPgpaadxvC7IdEcvuG+tB49ZImsXeInpOt24RR0S5b
 yUoHwgf6QMRK8bn/gPh82gT03cuVnH2r688lC3e8IQbPGft90fkDr1JW/zifapMsWIu8jimywNf
 xX/Q4wcR4uAaKCxB9Wf58+/bAKpud+bdYiJZQF5bOoC5umnNBEQOI3WiYVuS/l5uJnv3NkGaqb8
 Cxhy97Wm3z0nYYA2LUpwMl/v1qQPPa36qTI1CrIJ4p+r5aZGxag+DOtwOYFqHSj4zTpTh7HwOWm
 Z/b3GbaSb5UYP9jnft9gwleHPlZTsnfxVL1rRJwKjqH4G3XYX8KD0Rb7nzTLMh1eCx4giu4UCb8
 fT4Pv7+DawS9mAGuPSKOGk9qO2h/fBkrB6NAkXvsgOyG+MPakwyyhpkUYubzdftUeFZM4tnVnoo
 7JclN+pemy+LgD/Jwi8lYY1DogAnm7adpOMSBNMPFabLfJ0rtmIiMQNg==
X-Received: by 2002:a05:622b:107:10b0:530:dc5e:27c6 with SMTP id
 d75a77b69052e-53645feb2efmr121801211cf.41.1792512396774; Tue, 20 Oct 2026
 09:06:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260811185509.1650102-1-knimoji@iol.unh.edu>
 <8811b276-3f46-484a-bffa-33accfe740b1@arm.com>
In-Reply-To: <8811b276-3f46-484a-bffa-33accfe740b1@arm.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 20 Oct 2026 12:06:00 -0400
X-Gm-Features: AclHuK_QQyhXE0FatmmG7s0WOG2Q5dkD9N0Eby5uejX54FTgYeanWXA9ukynVXw
Message-ID: <CAKYPG+wJOvzq0mUQ+R5MNuydaj_ROwHHgOqyF6K4nP_ewkO5_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] dts: resolve trex driver binding issue
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, dladd@iol.unh.edu, 
 abailey@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000aa6834065e47d0c5"
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

--000000000000aa6834065e47d0c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca,
Thanks for the review. I will send a new version that addresses
the comments shortly.

On Fri, Oct 16, 2026 at 12:28=E2=80=AFPM Luca Vizzarro <Luca.Vizzarro@arm.c=
om>
wrote:

> Hi Koushik,
>
> Apologies for the long wait. To start off, could you please address the
> AI Code Review as it raised a few concerns:
>
> http://mails.dpdk.org/archives/test-report/2026-August/1029040.html
>
>
In terms of the 'del self._lshw_net_Info' section, i added the 'if
self._lshw_net_Info'
to check if the attribute exists before deleting, as it's done in other
sections of the file
For the error checking and TG resource teardown, this is already handled by
DTS.


> The patch will also require rebasing.
>
> On 11/08/2026 19:55, Koushik Bhargav Nimoji wrote:
> > diff --git a/dts/framework/test_result.py b/dts/framework/test_result.p=
y
> > index 21faa55dc1..13ed8f671c 100644
> > --- a/dts/framework/test_result.py
> > +++ b/dts/framework/test_result.py
> > @@ -117,6 +117,7 @@ class ResultNode(BaseModel):
> >       label: str
> >       children: list[Union["ResultNode", ResultLeaf]] =3D
> Field(default_factory=3Dlist)
> >       parent: Union["ResultNode", None] =3D None
> > +    ports: list[dict[str, str]] | None =3D None
>
> This attribute lacks the appropriate documentation. Also unless I missed
> something, I am not sure how this belongs to this patch. Can you please
> clarify?
>

This shouldn't be here, will be removed.


> >
> >       def add_child(self, label: str) -> "ResultNode":
> >           """Creates and append a child node to the model.
> > diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> > index c20a0fa885..b23930b953 100644
> > --- a/dts/framework/test_run.py
> > +++ b/dts/framework/test_run.py
> > @@ -115,7 +115,7 @@
> >   from framework.remote_session.dpdk import DPDKBuildEnvironment,
> DPDKRuntimeEnvironment
> >   from framework.settings import SETTINGS
> >   from framework.test_result import Result, ResultNode, TestRunResult
> > -from framework.test_suite import BaseConfig, TestCase, TestCaseType,
> TestSuite
> > +from framework.test_suite import BaseConfig, TestCase, TestCaseType,
> TestSuite, TestSuiteType
> >   from framework.testbed_model.capability import (
> >       Capability,
> >       get_supported_capabilities,
> > @@ -375,11 +375,6 @@ def next(self) -> State | None:
> >               ctx.topology.bind_cryptodevs("dpdk")
> >
> >           ctx.topology.configure_ports("sut", "dpdk")
> > -        if ctx.func_tg and ctx.topology.type is not
> LinkTopology.NO_LINK:
> > -            ctx.func_tg.setup(ctx.topology)
> > -        if ctx.perf_tg and ctx.topology.type is not
> LinkTopology.NO_LINK:
> > -            ctx.perf_tg.setup(ctx.topology)
> > -
> >           self.result.ports =3D [
> >               port.to_dict() for port in ctx.topology.sut_ports +
> ctx.topology.tg_ports
> >           ]
> > @@ -506,12 +501,34 @@ class TestSuiteSetup(TestSuiteState):
> >       """Test suite setup."""
> >
> >       logger_name: ClassVar[str] =3D "test_suite_setup"
> > +    test_run: TestRun
>
> Unsure why this is necessary, given it's already inherited by
> TestSuiteState.
>
>
I kept it this way as it is the same style as TestRunSetup. TestRunSetup
inherits from State, which has a 'test_run: TestRun' attribute, but also
has its own test_run attribute. I will have it inherit test_run in my
upcoming version. as that's a better approach.


> > +        if (
> > +            ctx.topology.type is not LinkTopology.NO_LINK
> > +            and testsuite_type is not TestSuiteType.CRYPTO
> > +        ):
> > +            if testsuite_type =3D=3D TestSuiteType.FUNC:
> > +                required_tg, other_tg =3D ctx.func_tg, ctx.perf_tg
> > +            else:
> > +                required_tg, other_tg =3D ctx.perf_tg, ctx.func_tg
> > +
> > +            if other_tg and other_tg.is_setup:
> > +                other_tg.teardown()
> > +
> > +                if testsuite_type =3D=3D TestSuiteType.FUNC and ctx.tg=
_node:
> > +                    for port in ctx.topology.tg_ports:
> > +
> ctx.tg_node.main_session.bind_ports_to_driver([port], port.config.os_driv=
er)
>
> I am a bit confused why this happens here. The driver to be bound to
> should be governed by the TG that uses such ports. Could be os_driver,
> could be dpdk_driver, regardless of Scapy and TRex.
>
> This section exists because of how scapy and TRex handle port driver
bindings. TRex automatically binds ports to the required driver when setup,
but scapy requires it to be done manually. That's why if the next test
suite to be tested is a functional test suite, the TG ports are rebound to
the os_driver manually here.

--000000000000aa6834065e47d0c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Luca,</div><div>Thanks for the review. I will send=
 a new version that addresses the=C2=A0comments shortly.</div><br><div clas=
s=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_att=
r">On Fri, Oct 16, 2026 at 12:28=E2=80=AFPM Luca Vizzarro &lt;<a href=3D"ma=
ilto:Luca.Vizzarro@arm.com">Luca.Vizzarro@arm.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi Koushik,<br>
<br>
Apologies for the long wait. To start off, could you please address the <br=
>
AI Code Review as it raised a few concerns:<br>
<br>
<a href=3D"http://mails.dpdk.org/archives/test-report/2026-August/1029040.h=
tml" rel=3D"noreferrer" target=3D"_blank">http://mails.dpdk.org/archives/te=
st-report/2026-August/1029040.html</a><br>
<br></blockquote><div><br></div><div>In terms of the &#39;del self._lshw_ne=
t_Info&#39; section, i added the &#39;if=C2=A0<span style=3D"background-col=
or:transparent">self._lshw_net_Info&#39; to check if the attribute exists b=
efore deleting, as it&#39;s done in other sections of the file</span></div>=
<div><span style=3D"background-color:transparent">For the error checking an=
d TG resource teardown, this is already handled by DTS.</span></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
The patch will also require rebasing.<br>
<br>
On 11/08/2026 19:55, Koushik Bhargav Nimoji wrote:<br>
&gt; diff --git a/dts/framework/test_result.py b/dts/framework/test_result.=
py<br>
&gt; index 21faa55dc1..13ed8f671c 100644<br>
&gt; --- a/dts/framework/test_result.py<br>
&gt; +++ b/dts/framework/test_result.py<br>
&gt; @@ -117,6 +117,7 @@ class ResultNode(BaseModel):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0label: str<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0children: list[Union[&quot;ResultNode&quot;,=
 ResultLeaf]] =3D Field(default_factory=3Dlist)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0parent: Union[&quot;ResultNode&quot;, None] =
=3D None<br>
&gt; +=C2=A0 =C2=A0 ports: list[dict[str, str]] | None =3D None<br>
<br>
This attribute lacks the appropriate documentation. Also unless I missed <b=
r>
something, I am not sure how this belongs to this patch. Can you please <br=
>
clarify?<br></blockquote><div><span style=3D"background-color:transparent">=
<br></span></div><div><span style=3D"background-color:transparent">This sho=
uldn&#39;t=C2=A0be here, will be removed.</span></div><div><span style=3D"b=
ackground-color:transparent">=C2=A0</span></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def add_child(self, label: str) -&gt; &quot;=
ResultNode&quot;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Creates and =
append a child node to the model.<br>
&gt; diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py<br>
&gt; index c20a0fa885..b23930b953 100644<br>
&gt; --- a/dts/framework/test_run.py<br>
&gt; +++ b/dts/framework/test_run.py<br>
&gt; @@ -115,7 +115,7 @@<br>
&gt;=C2=A0 =C2=A0from framework.remote_session.dpdk import DPDKBuildEnviron=
ment, DPDKRuntimeEnvironment<br>
&gt;=C2=A0 =C2=A0from framework.settings import SETTINGS<br>
&gt;=C2=A0 =C2=A0from framework.test_result import Result, ResultNode, Test=
RunResult<br>
&gt; -from framework.test_suite import BaseConfig, TestCase, TestCaseType, =
TestSuite<br>
&gt; +from framework.test_suite import BaseConfig, TestCase, TestCaseType, =
TestSuite, TestSuiteType<br>
&gt;=C2=A0 =C2=A0from framework.testbed_model.capability import (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Capability,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0get_supported_capabilities,<br>
&gt; @@ -375,11 +375,6 @@ def next(self) -&gt; State | None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx.topology.bin=
d_cryptodevs(&quot;dpdk&quot;)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx.topology.configure_ports(&=
quot;sut&quot;, &quot;dpdk&quot;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ctx.func_tg and ctx.topology.type is n=
ot LinkTopology.NO_LINK:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.func_tg.setup(ctx.topol=
ogy)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ctx.perf_tg and ctx.topology.type is n=
ot LinkTopology.NO_LINK:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.perf_tg.setup(ctx.topol=
ogy)<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.ports =3D [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port.to_dict() f=
or port in ctx.topology.sut_ports + ctx.topology.tg_ports<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt; @@ -506,12 +501,34 @@ class TestSuiteSetup(TestSuiteState):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Test suite setup.&quot;&qu=
ot;&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0logger_name: ClassVar[str] =3D &quot;test_su=
ite_setup&quot;<br>
&gt; +=C2=A0 =C2=A0 test_run: TestRun<br>
<br>
Unsure why this is necessary, given it&#39;s already inherited by <br>
TestSuiteState.<br><br></blockquote><div><br></div><div>I kept it this way =
as it is the same style as TestRunSetup. TestRunSetup inherits from State, =
which has a &#39;test_run: TestRun&#39; attribute, but also has its own tes=
t_run attribute. I will have it inherit test_run in my upcoming version. as=
 that&#39;s a better approach.</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.topology.type is not Li=
nkTopology.NO_LINK<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and testsuite_type is not T=
estSuiteType.CRYPTO<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if testsuite_type =3D=3D Te=
stSuiteType.FUNC:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required_tg, =
other_tg =3D ctx.func_tg, ctx.perf_tg<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required_tg, =
other_tg =3D ctx.perf_tg, ctx.func_tg<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if other_tg and other_tg.is=
_setup:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 other_tg.tear=
down()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if testsuite_=
type =3D=3D TestSuiteType.FUNC and ctx.tg_node:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 for port in ctx.topology.tg_ports:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ctx.tg_node.main_session.bind_ports_to_driver([port], port.c=
onfig.os_driver)<br>
<br>
I am a bit confused why this happens here. The driver to be bound to <br>
should be governed by the TG that uses such ports. Could be os_driver, <br>
could be dpdk_driver, regardless of Scapy and TRex.<br>
<br></blockquote><div>This section exists because of how scapy and TRex han=
dle port driver bindings. TRex automatically binds ports to the required dr=
iver when setup, but scapy requires it to be done manually. That&#39;s why =
if the next test suite to be tested is a functional test suite, the TG port=
s are rebound to the os_driver manually here.</div></div></div>

--000000000000aa6834065e47d0c5--
