Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F00CA0FE8
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 14:55:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D628640262;
	Sun, 31 Aug 2025 16:55:58 +0200 (CEST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id 8292C4021E
 for <dev@dpdk.org>; Sun, 31 Aug 2025 16:55:57 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b03fa5c5a89so137456866b.2
 for <dev@dpdk.org>; Sun, 31 Aug 2025 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756652157; x=1757256957; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6hfQ9T/uxspIa8/YYY1s43dmzDHZYcv4uIUkMxfyRGQ=;
 b=PkOLLw9EkUL2cQEFgWHwMenOp5eypvWvd37eBQjvjQM/ybYv49wVBqGH4CpoGQ3EjU
 EySrl+QePBEsU5xG1JfVS55xwI2wi5AYCtdEpXVk1akOoyVWGmW2XhftyH3LHV7gvUaj
 wZYAUxV4Svn8ccFmm7YRvpEjyE4AGD24KU5Gv4kTTC+PxS0DhNFDIWLS+PURWIKGYRXl
 bm24lVphGybJtu157CI2mMkmGVSpLSbX5J4wSY7RHTtt30AQ4ziC22Qv5VNoqukTEa8J
 rkDVaT7EhQ20Yp2bBPemxuzefFL/uP8HPNPDhzlSqIQLqUl0gRQl83F9jDHnPyI/6zGh
 vT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756652157; x=1757256957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6hfQ9T/uxspIa8/YYY1s43dmzDHZYcv4uIUkMxfyRGQ=;
 b=YRL6WYhEtqKShXZ73TSzPwE2lbcygUpfN9nZtoYLeXRDnW1504hb02It8gdeTZHINB
 MSdA2nHQjkghaq78JXtmZjlYHR78Bje+bgHq22n/k4B9d11zy1m8mOluVJsZD2NMwVGU
 fMxWI5Bm/JTJfCas1O9HMVQauAHrr1ozWBIK2NKXU7Xa+wCokGSDgCuK+2/lFhfFBBwG
 +wKz8Cxh559I84F19ILRH7yFLWP/uwqYR9zH3uOD8B5VvzgqK2xHTDi6vFFgSht0H19g
 h/5VuzWi2H2+qdu6gRkNvcFhcmRhJGhgCo/hqUMIiBsQb9q/KrHBU6Me9gsYavhSwgrb
 10vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7/e4aHpZx9pnCnNXU+g6zEMa+ErTLGvgUf5gNToZ1YllMeoX0M8j8J5a0SFI/zW0Fr7M=@dpdk.org
X-Gm-Message-State: AOJu0YxALObZGEy126Hrc0Y3vzLcbunNLuSm++VmyNhoZGfkPIrNqIi0
 w/Y5r8EAIbOOP1tDZq35Touvx9mkjcjfskQc/3KMeKtJQnbwnsr1UVvmMyI7XoSJMYoMEYHZKbT
 v3CupQcmC9DvsZz57G2P0fwNVNCjVPrQ=
X-Gm-Gg: ASbGncv8Y7NFn387FfRd34Z4R40HlVWNTsl4rl1Ji8i4zM4cnOJ6Rs+VnOs/NdvX9W0
 aICbAdTGF4tLIHe36Y5lCGD8rvoIR/JnESeOzB0rczWFwnMajGTrgIC2UpXVwVQFWDpRGYaVmEk
 ssectlnzwW4GuCMtVSTtM+nhsbynudpxXvMP5BKiF9527c7zV4MAXsvzgjtLmdrvhIzxRn3kh+A
 BEI
X-Google-Smtp-Source: AGHT+IGtlXoHBMZtrtMd2bEfEMtumsXETEPJmSfsAAZLndMfkgbek6WDlaWUqdB+6LWF/jNod23QVSAINBVOrvPFUkg=
X-Received: by 2002:a17:907:9287:b0:afe:f980:99cf with SMTP id
 a640c23a62f3a-b01d8c74bdbmr513779766b.23.1756652156608; Sun, 31 Aug 2025
 07:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <609e89f7-4bbc-3535-b924-832afed6d006@arknetworks.am>
In-Reply-To: <609e89f7-4bbc-3535-b924-832afed6d006@arknetworks.am>
From: Vladimir Medvedkin <medvedkinv@gmail.com>
Date: Sun, 31 Aug 2025 15:55:45 +0100
X-Gm-Features: Ac12FXytSf8kOm3n-FisZkw1QJPiisvs47_TH1Cuj6TADfk00Szu4L58EcKXQ-0
Message-ID: <CANDrEHkg1y_jRHvP_=Dx5V5R2JMFUO4ZXxtyYdnQxohjc-B-Xw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] ethdev: refactor and extend DCB configuration API
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org,
 bruce.richardson@intel.com, 
 anatoly.burakov@intel.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Content-Type: multipart/alternative; boundary="000000000000c9e47a063daa7366"
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

--000000000000c9e47a063daa7366
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ivan,

Thanks for your comments, please see my comments inline below.

=D1=81=D0=B1, 30 =D0=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=B3. =D0=B2 22:14, Iva=
n Malov <ivan.malov@arknetworks.am>:

> Hi Vladimir,
>
> On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:
>
> > Hi all,
> >
> > This series reworks the ethdev API related to advanced queueing
> configuration,
> > specifically Data Center Bridging (DCB) and Virtual Machine Device Queu=
es
> > (VMDq). The existing API was designed years ago around ixgbe hardware
> > assumptions, which makes it difficult to properly support modern NICs
> and their
> > more flexible capabilities.
> >
>
> I like this overall.
>
> The series seems to be a good rework, but the PMD changes are going to be
> vast.
> Also, given the fact it targets the same release cycle as some new driver=
s
> do,
> it can be problematic to apply 'rx_adv_conf.mq_mode' to, say, [1] on the
> go.
>
> [1] https://mails.dpdk.org/archives/dev/2025-August/323562.html


Yes, I see, some patches in the series may be postponed for later, if
necessary.


>
>
>
> Also, now we've touched on the topic of traffic classes and priorities, i=
f
> I may
> be so bold as to ask an unrelated question about [2]. Does the priority
> value
> have to come specifically from VLAN header? Or can it come, say, from ToS
> of
> IPv4, or Traffic Class of IPv6, or from some vendor-specific header?
>
> [2]
> https://doc.dpdk.org/api-25.07/structrte__eth__pfc__conf.html#a0ad043071c=
cc7a261d79a759dc9c6f0c
>
>
That's a good question. The short answer is yes, at the moment, but it won'=
t
be 100% true in the future.
For example, Intel E800 Series network adapters can operate in two modes,
depending on how HW classifies incoming packets into their respective
traffic classes. One of the modes uses a 3-bit PCP VLAN field, and this is
the default mode. Another mode is to use the 6-bit DSCP, which is supported
by E800 NICs, but is not currently enabled. In DSCP mode, HW maintains one
additional DSCP-to-UP mapping table to translate incoming packets to
intermediate UP, and then uses a usual UP-to-TC mapping table (ref. to the
E810 datasheet 8.2.1.3.1.2 Packet CoS Classification Flow in =E2=80=9CDSCP =
PFC=E2=80=9D Mode).
Also please note that the PFC PAUSE frames carry per-priority pause quanta
for 8 priorities, and those priorities usually correspond to VLAN PCP.
Regarding vendor-specific headers, I'm not aware of any vendor that support=
s
this. Although this is theoretically possible, keep in mind that the HW
block responsible for TC classification should usually be located somewhere
at the very beginning of the Rx pipeline, there are strict performance
limitations for it, so most likely its implementation will be as simple as
possible.



> Thank you.
>


--=20
Regards,
Vladimir

--000000000000c9e47a063daa7366
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Ivan,</div><div><br></div><div>Th=
anks for your comments,=C2=A0<span><span>please see my comments inline</spa=
n></span> below.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">=D1=81=D0=B1, 30 =D0=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=
=B3. =D0=B2 22:14, Ivan Malov &lt;<a href=3D"mailto:ivan.malov@arknetworks.=
am" target=3D"_blank">ivan.malov@arknetworks.am</a>&gt;:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Hi Vladimir,<br>
<br>
On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:<br>
<br>
&gt; Hi all,<br>
&gt;<br>
&gt; This series reworks the ethdev API related to advanced queueing config=
uration,<br>
&gt; specifically Data Center Bridging (DCB) and Virtual Machine Device Que=
ues<br>
&gt; (VMDq). The existing API was designed years ago around ixgbe hardware<=
br>
&gt; assumptions, which makes it difficult to properly support modern NICs =
and their<br>
&gt; more flexible capabilities.<br>
&gt;<br>
<br>
I like this overall.<br>
<br>
The series seems to be a good rework, but the PMD changes are going to be v=
ast.<br>
Also, given the fact it targets the same release cycle as some new drivers =
do,<br>
it can be problematic to apply &#39;rx_adv_conf.mq_mode&#39; to, say, [1] o=
n the go.<br>
<br>
[1] <a href=3D"https://mails.dpdk.org/archives/dev/2025-August/323562.html"=
 rel=3D"noreferrer" target=3D"_blank">https://mails.dpdk.org/archives/dev/2=
025-August/323562.html</a></blockquote><div><br></div><div>Yes, I see, some=
 patches=C2=A0<span style=3D"white-space:pre-wrap">in</span><span style=3D"=
white-space:pre-wrap"> the </span><span style=3D"white-space:pre-wrap">seri=
es</span><span style=3D"white-space:pre-wrap"> may</span><span style=3D"whi=
te-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">be</span><s=
pan style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-w=
rap">postponed</span><span style=3D"white-space:pre-wrap"> </span><span sty=
le=3D"white-space:pre-wrap">for</span><span style=3D"white-space:pre-wrap">=
 </span><span style=3D"white-space:pre-wrap">later</span><span style=3D"whi=
te-space:pre-wrap">,</span><span style=3D"white-space:pre-wrap"> </span><sp=
an style=3D"white-space:pre-wrap">if</span><span style=3D"white-space:pre-w=
rap"> </span><span style=3D"white-space:pre-wrap">necessary</span><span sty=
le=3D"white-space:pre-wrap">.</span></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><br>
<br>
<br>
Also, now we&#39;ve touched on the topic of traffic classes and priorities,=
 if I may<br>
be so bold as to ask an unrelated question about [2]. Does the priority val=
ue<br>
have to come specifically from VLAN header? Or can it come, say, from ToS o=
f<br>
IPv4, or Traffic Class of IPv6, or from some vendor-specific header?<br>
<br>
[2] <a href=3D"https://doc.dpdk.org/api-25.07/structrte__eth__pfc__conf.htm=
l#a0ad043071ccc7a261d79a759dc9c6f0c" rel=3D"noreferrer" target=3D"_blank">h=
ttps://doc.dpdk.org/api-25.07/structrte__eth__pfc__conf.html#a0ad043071ccc7=
a261d79a759dc9c6f0c</a><br>
<br></blockquote><div><br></div><span style=3D"white-space:pre-wrap">That</=
span><span style=3D"white-space:pre-wrap">&#39;s a </span><span style=3D"wh=
ite-space:pre-wrap">good</span><span style=3D"white-space:pre-wrap"> </span=
><span style=3D"white-space:pre-wrap">question</span><span style=3D"white-s=
pace:pre-wrap">.</span><span style=3D"white-space:pre-wrap"> The </span><sp=
an style=3D"white-space:pre-wrap">short</span><span style=3D"white-space:pr=
e-wrap"> </span><span style=3D"white-space:pre-wrap">answer</span><span sty=
le=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">is=
</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"white-sp=
ace:pre-wrap">yes</span><span style=3D"white-space:pre-wrap">,</span><span =
style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap"=
>at</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"white=
-space:pre-wrap">the</span><span style=3D"white-space:pre-wrap"> </span><sp=
an style=3D"white-space:pre-wrap">moment</span><span style=3D"white-space:p=
re-wrap">,</span><span style=3D"white-space:pre-wrap"> </span><span style=
=3D"white-space:pre-wrap">but</span><span style=3D"white-space:pre-wrap"> i=
t won</span><span style=3D"white-space:pre-wrap">&#39;t</span><span style=
=3D"white-space:pre-wrap"> be </span><span style=3D"white-space:pre-wrap">1=
00</span><span style=3D"white-space:pre-wrap">%</span><span style=3D"white-=
space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">true</span><sp=
an style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wr=
ap">in</span><span style=3D"white-space:pre-wrap"> the </span><span style=
=3D"white-space:pre-wrap">future</span><span style=3D"white-space:pre-wrap"=
>.</span><div><span style=3D"white-space:pre-wrap">For </span><span style=
=3D"white-space:pre-wrap">example</span><span style=3D"white-space:pre-wrap=
">,</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"white=
-space:pre-wrap">Intel</span><span style=3D"white-space:pre-wrap"> </span><=
span style=3D"white-space:pre-wrap">E800</span><span style=3D"white-space:p=
re-wrap"> </span><span style=3D"white-space:pre-wrap">Series</span><span st=
yle=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">n=
etwork</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"wh=
ite-space:pre-wrap">adapters</span><span style=3D"white-space:pre-wrap"> </=
span><span style=3D"white-space:pre-wrap">can</span><span style=3D"white-sp=
ace:pre-wrap"> </span><span style=3D"white-space:pre-wrap">operate</span><s=
pan style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-w=
rap">in</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"w=
hite-space:pre-wrap">two</span><span style=3D"white-space:pre-wrap"> </span=
><span style=3D"white-space:pre-wrap">modes</span><span style=3D"white-spac=
e:pre-wrap">, </span><span style=3D"white-space:pre-wrap">depending</span><=
span style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-=
wrap">on</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"=
white-space:pre-wrap">how</span><span style=3D"white-space:pre-wrap"> </spa=
n><span style=3D"white-space:pre-wrap">HW</span><span style=3D"white-space:=
pre-wrap"> </span><span style=3D"white-space:pre-wrap">classifies</span><sp=
an style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wr=
ap">incoming</span><span style=3D"white-space:pre-wrap"> </span><span style=
=3D"white-space:pre-wrap">packets</span><span style=3D"white-space:pre-wrap=
"> into their </span><span style=3D"white-space:pre-wrap">respective</span>=
<span style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre=
-wrap">traffic</span><span style=3D"white-space:pre-wrap"> </span><span sty=
le=3D"white-space:pre-wrap">classes</span><span style=3D"white-space:pre-wr=
ap">. </span><span style=3D"white-space:pre-wrap"></span><span style=3D"whi=
te-space:pre-wrap">One</span><span style=3D"white-space:pre-wrap"> </span><=
span style=3D"white-space:pre-wrap">of</span><span style=3D"white-space:pre=
-wrap"> the </span><span style=3D"white-space:pre-wrap">modes</span><span s=
tyle=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">=
uses</span><span style=3D"white-space:pre-wrap"> a </span><span style=3D"wh=
ite-space:pre-wrap">3</span><span style=3D"white-space:pre-wrap">-</span><s=
pan style=3D"white-space:pre-wrap">bit</span><span style=3D"white-space:pre=
-wrap"> </span><span style=3D"white-space:pre-wrap">PCP</span><span style=
=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">VLAN=
</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"white-sp=
ace:pre-wrap">field</span><span style=3D"white-space:pre-wrap">,</span><spa=
n style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wra=
p">and</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"wh=
ite-space:pre-wrap">this</span><span style=3D"white-space:pre-wrap"> is the=
 </span><span style=3D"white-space:pre-wrap">default</span><span style=3D"w=
hite-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">mode</spa=
n><span style=3D"white-space:pre-wrap">.</span><span style=3D"white-space:p=
re-wrap"> </span><span style=3D"white-space:pre-wrap">Another</span><span s=
tyle=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">=
mode</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"whit=
e-space:pre-wrap">is</span><span style=3D"white-space:pre-wrap"> to </span>=
<span style=3D"white-space:pre-wrap">use</span><span style=3D"white-space:p=
re-wrap"> the </span><span style=3D"white-space:pre-wrap">6</span><span sty=
le=3D"white-space:pre-wrap">-</span><span style=3D"white-space:pre-wrap">bi=
t</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"white-s=
pace:pre-wrap">DSCP</span><span style=3D"white-space:pre-wrap">,</span><spa=
n style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wra=
p">which</span><span style=3D"white-space:pre-wrap"> is </span><span style=
=3D"white-space:pre-wrap">supported</span><span style=3D"white-space:pre-wr=
ap"> by </span><span style=3D"white-space:pre-wrap">E800 NICs</span><span s=
tyle=3D"white-space:pre-wrap">,</span><span style=3D"white-space:pre-wrap">=
 </span><span style=3D"white-space:pre-wrap">but</span><span style=3D"white=
-space:pre-wrap"> is </span><span style=3D"white-space:pre-wrap">not</span>=
<span style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre=
-wrap">currently</span><span style=3D"white-space:pre-wrap"> </span><span s=
tyle=3D"white-space:pre-wrap">enabled</span><span style=3D"white-space:pre-=
wrap">.</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"w=
hite-space:pre-wrap"></span><span style=3D"white-space:pre-wrap">In</span><=
span style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-=
wrap">DSCP</span><span style=3D"white-space:pre-wrap"> </span><span style=
=3D"white-space:pre-wrap">mode</span><span style=3D"white-space:pre-wrap">,=
 </span><span style=3D"white-space:pre-wrap">HW</span><span style=3D"white-=
space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">maintains</spa=
n><span style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:p=
re-wrap">one</span><span style=3D"white-space:pre-wrap"> </span><span style=
=3D"white-space:pre-wrap">additional</span><span style=3D"white-space:pre-w=
rap"> </span><span style=3D"white-space:pre-wrap">DSCP</span><span style=3D=
"white-space:pre-wrap">-</span><span style=3D"white-space:pre-wrap">to</spa=
n><span style=3D"white-space:pre-wrap">-</span><span style=3D"white-space:p=
re-wrap">UP</span><span style=3D"white-space:pre-wrap"> </span><span style=
=3D"white-space:pre-wrap">mapping</span><span style=3D"white-space:pre-wrap=
"> </span><span style=3D"white-space:pre-wrap">table</span><span style=3D"w=
hite-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">to</span>=
<span style=3D"white-space:pre-wrap"> translate</span><span style=3D"white-=
space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">incoming</span=
><span style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pr=
e-wrap">packets</span><span style=3D"white-space:pre-wrap"> </span><span st=
yle=3D"white-space:pre-wrap">to</span><span style=3D"white-space:pre-wrap">=
 </span><span style=3D"white-space:pre-wrap">intermediate</span><span style=
=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">UP</=
span><span style=3D"white-space:pre-wrap">,</span><span style=3D"white-spac=
e:pre-wrap"> </span><span style=3D"white-space:pre-wrap">and</span><span st=
yle=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">t=
hen</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"white=
-space:pre-wrap">uses</span><span style=3D"white-space:pre-wrap"> a </span>=
<span style=3D"white-space:pre-wrap">usual</span><span style=3D"white-space=
:pre-wrap"> </span><span style=3D"white-space:pre-wrap">UP</span><span styl=
e=3D"white-space:pre-wrap">-</span><span style=3D"white-space:pre-wrap">to<=
/span><span style=3D"white-space:pre-wrap">-</span><span style=3D"white-spa=
ce:pre-wrap">TC</span><span style=3D"white-space:pre-wrap"> </span><span st=
yle=3D"white-space:pre-wrap">mapping</span><span style=3D"white-space:pre-w=
rap"> </span><span style=3D"white-space:pre-wrap">table </span><span style=
=3D"white-space:pre-wrap">(ref. to the E810 datasheet </span>8.2.1.3.1.2 Pa=
cket CoS Classification Flow in =E2=80=9CDSCP PFC=E2=80=9D Mode<span style=
=3D"white-space:pre-wrap">). Also please note that the PFC PAUSE frames car=
ry per-priority pause quanta for 8 priorities, and those priorities usually=
 correspond to VLAN PCP.</span></div><div><span style=3D"white-space:pre-wr=
ap">Regarding vendor-specific headers, </span><span style=3D"white-space:pr=
e-wrap">I</span><span style=3D"white-space:pre-wrap">&#39;m </span><span st=
yle=3D"white-space:pre-wrap">not</span><span style=3D"white-space:pre-wrap"=
> </span><span style=3D"white-space:pre-wrap">aware</span><span style=3D"wh=
ite-space:pre-wrap"> of </span><span style=3D"white-space:pre-wrap">any</sp=
an><span style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:=
pre-wrap">vendor</span><span style=3D"white-space:pre-wrap"> </span><span s=
tyle=3D"white-space:pre-wrap">that</span><span style=3D"white-space:pre-wra=
p"> </span><span style=3D"white-space:pre-wrap">supports</span><span style=
=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">this=
</span><span style=3D"white-space:pre-wrap">.</span> <span style=3D"white-s=
pace:pre-wrap">Although</span><span style=3D"white-space:pre-wrap"> this is=
 </span><span style=3D"white-space:pre-wrap">theoretically</span><span styl=
e=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">pos=
sible</span><span style=3D"white-space:pre-wrap">,</span><span style=3D"whi=
te-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">keep</span>=
<span style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre=
-wrap">in</span><span style=3D"white-space:pre-wrap"> </span><span style=3D=
"white-space:pre-wrap">mind</span><span style=3D"white-space:pre-wrap"> </s=
pan><span style=3D"white-space:pre-wrap">that</span><span style=3D"white-sp=
ace:pre-wrap"> the </span><span style=3D"white-space:pre-wrap">HW</span><sp=
an style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wr=
ap">block</span><span style=3D"white-space:pre-wrap"> </span><span style=3D=
"white-space:pre-wrap">responsible</span><span style=3D"white-space:pre-wra=
p"> </span><span style=3D"white-space:pre-wrap">for</span><span style=3D"wh=
ite-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">TC</span><=
span style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-=
wrap">classification</span><span style=3D"white-space:pre-wrap"> </span><sp=
an style=3D"white-space:pre-wrap">should</span><span style=3D"white-space:p=
re-wrap"> </span><span style=3D"white-space:pre-wrap">usually</span><span s=
tyle=3D"white-space:pre-wrap"> be </span><span style=3D"white-space:pre-wra=
p">located</span><span style=3D"white-space:pre-wrap"> </span><span style=
=3D"white-space:pre-wrap">somewhere</span><span style=3D"white-space:pre-wr=
ap"> </span><span style=3D"white-space:pre-wrap">at</span><span style=3D"wh=
ite-space:pre-wrap"> the </span><span style=3D"white-space:pre-wrap">very</=
span><span style=3D"white-space:pre-wrap"> </span><span style=3D"white-spac=
e:pre-wrap">beginning</span><span style=3D"white-space:pre-wrap"> of the </=
span><span style=3D"white-space:pre-wrap">Rx</span><span style=3D"white-spa=
ce:pre-wrap"> </span><span style=3D"white-space:pre-wrap">pipeline</span><s=
pan style=3D"white-space:pre-wrap">,</span><span style=3D"white-space:pre-w=
rap"> </span><span style=3D"white-space:pre-wrap">there</span><span style=
=3D"white-space:pre-wrap"> are </span><span style=3D"white-space:pre-wrap">=
strict performance</span><span style=3D"white-space:pre-wrap"> </span><span=
 style=3D"white-space:pre-wrap">limitations</span><span style=3D"white-spac=
e:pre-wrap"> </span><span style=3D"white-space:pre-wrap">for</span><span st=
yle=3D"white-space:pre-wrap"> it</span><span style=3D"white-space:pre-wrap"=
>,</span><span style=3D"white-space:pre-wrap"> </span><span style=3D"white-=
space:pre-wrap">so</span><span style=3D"white-space:pre-wrap"> most </span>=
<span style=3D"white-space:pre-wrap">likely</span><span style=3D"white-spac=
e:pre-wrap"> </span><span style=3D"white-space:pre-wrap">its</span><span st=
yle=3D"white-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">i=
mplementation</span><span style=3D"white-space:pre-wrap"> </span><span styl=
e=3D"white-space:pre-wrap">will</span><span style=3D"white-space:pre-wrap">=
 be </span><span style=3D"white-space:pre-wrap">as</span><span style=3D"whi=
te-space:pre-wrap"> </span><span style=3D"white-space:pre-wrap">simple</spa=
n><span style=3D"white-space:pre-wrap"> </span><span style=3D"white-space:p=
re-wrap">as</span><span style=3D"white-space:pre-wrap"> </span><span style=
=3D"white-space:pre-wrap">possible</span><span style=3D"white-space:pre-wra=
p">.</span></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
Thank you.<br>
</blockquote></div></div><div><br clear=3D"all"></div><br><span class=3D"gm=
ail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signatu=
re"><div dir=3D"ltr"><div>Regards,<br></div>Vladimir<br></div></div>

--000000000000c9e47a063daa7366--
