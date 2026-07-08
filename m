Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1984CC43602
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 07:11:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BDBC402CC;
	Wed,  8 Jul 2026 09:11:35 +0200 (CEST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49]) by mails.dpdk.org (Postfix) with ESMTP id 40F6540264
 for <dev@dpdk.org>; Wed,  8 Jul 2026 09:11:34 +0200 (CEST)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-738b39dad22so112641137.2
 for <dev@dpdk.org>; Wed, 08 Jul 2026 00:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783494693; cv=none;
 d=google.com; s=arc-20260327;
 b=suLHeA82pOpfnXeMsZIn6eHuscBQZxP0XJTycnp/jegapFOFOGuCcnrCISgH6tCL2m
 eHxTJDSxlVhJmcd3D8I7WZ9xAWJ9Z7yBEb1H1LecBUykp9tqab9d+eXZcw0nxZQSRalg
 8d9PecwCO7or1p9LSRp5F8lNSSmZ42uUIVPOS46UEzqtVfZlnI5SZSoKiDHBxWlgePJq
 8sVD1+D3zz2DY1PoXhiTCbvF/MziavRFoFtt+O7aXFVRG+DW2lPZZYt3514qdG8VNnbZ
 vmajtPiDVpA+BzkkNflTWO1A3fUGDboFlcdt/1G7lDNgmTrHTiAyIkMZNrvKaVv0Aa73
 HB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RpMk283tYlulIJGH+npK3CMjobENclzmNVuZ2rTrv4w=;
 fh=Hr65rgj3AUDBwXZZdijOVMq702xKO0Fd5I6HKKBVCdo=;
 b=VKUWbUDiYPS+E/uz10ewY0dW8Qp437oVkQMULCfLm0zhmoElaijaHwKmctgGFJxtue
 oO/iFHu35GCFE+NgTl8IOLrTeyhUtLTiukEtsh3q0ekUYd/g3kp4RgU22bvk4VKpOQz/
 AlkeKgY4Msv1VXRNygBRaBGhxgmdkETqpfGWKLQq4G+TmVwy891x7tlaBVR/1j5G62PS
 AQllTKqG+mZNQ3lEtrUBIp4Fxlo0O0ZZxaG9CU/93K99iGPAgA3OC1RHBzyUyChEgU/F
 ai+OrIIINDjvtauvy7yhL1yY33vtucQFaZAXk1P/2/KKZW+07AMuzCGNhyw7TmD/78q7
 yJRg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783494693;
 x=1784099493; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RpMk283tYlulIJGH+npK3CMjobENclzmNVuZ2rTrv4w=;
 b=IzJU45Avw4+k1ivsyouIEk6M6wbC7rCz2Ahy5C3JAFyBGU6/caZucky1Qwou0J5SLT
 jesXzXYcNRiiLKPLUWpS3gB2nTkgI1fd2654jpksCprkzXcZ1235B78kUXIEkIynT22d
 MoFZRnvTAQeEE3EHc9I0FOjDAa2LQmcgLsVKYMuJOAfmXhbV+XmHaiTXGIN3dvcWWE2Q
 XIcKDQ53zG0x26HAuAQuM5IRGXsHYLAkt5KK/HHRodL/yT/UsapsFLH+g7XJ+zpz2mO2
 1ucwzWMfiythAA4+kPIUPrY4K17lh/eXxTLuP6Bn03KrILHWmud1Sdf//k9/Euc5W92f
 qMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783494693; x=1784099493;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RpMk283tYlulIJGH+npK3CMjobENclzmNVuZ2rTrv4w=;
 b=d+EQKc4IrRX13NInXT05JmxJrrXZPILOHGoVMbXA/qSJyTMXN4zY83YAxP+CpEiLwc
 j8i9VP1ko2DgTcBKuTWRQ+l3K4UBxe1IVPp5vj3NNjYxV/ehmpbPmcDRlhiHw1Gu2cvN
 uRz+iBeR1AiTXsf3ceTI+6JmHV7yAJVPqfIMrYC1LWPlMSqsxQHE8yoAoygVEqiXoTKF
 3dmGuTqItxQ23BmQM/lKwcMe+dKRCUcVEIgjnOpOizTRPDYAATu3ifEv+7FuJYIwZRH0
 u3P15YFVeKYr3+EigDwLPxv/+TkoMS3FS/Q5aSX1ONPstf09yYF2kh24vU5Sns2qUace
 PSXg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9TL8XzibMcyGPQYyTar99glyVCH8pfbVjS6/TmMQNwPGgHCyBCV0FyK7YrZm6VB2qpUo=@dpdk.org
X-Gm-Message-State: AOJu0YzoDgjU8nHktSkU6/0SBvUNXWiFw7ZJ8khP12DQyhsNtXu+9pei
 lzrjR5A7UbVU7iDchY61LbHUzSU/SVoaNohAob5xjW1fBr0G7m+smekiWef2PSOGiEWH3ih9bsA
 vPSMQWzG9/eJSY4OTmpO/+Ucp3kDx7emOQXG01My9CA==
X-Gm-Gg: AfdE7cmdN4FwLHm8axikv+4KfvhEdf/NCKblJUXhNdO7vydz5mLFTiPZb6ho0JgV70y
 qYL8QLgxCnDjR5i5WYLl/caf6y3HQY39NjknN++zdU3iVodzPGptHTwrh5e8ejcrCr0Z+5A3pUY
 DR503bYsXC+n1jGsaLn8v1PM7VI1YM2MUbXZn22BOqPJwhKcADkOOZe+CUbeRt2lkM/ezf9lgcu
 VYVcoLaALNUqcwDF61Y35R3ncqTsFCLITMI2usBXr0DWo43WW/l64WD+ePRMwh1/sLSLy0yLRas
 d/yh7lw=
X-Received: by 2002:a05:6102:5e8c:b0:633:f2bf:7de4 with SMTP id
 ada2fe7eead31-744dffb3680mr572614137.10.1783494693385; Wed, 08 Jul 2026
 00:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260707133028.236546-1-mkashani@nvidia.com>
 <ak0KN_oZGU1WkPHm@bricha3-mobl1.ger.corp.intel.com>
 <MW6PR12MB70707673C99F020A595212EBB2FF2@MW6PR12MB7070.namprd12.prod.outlook.com>
In-Reply-To: <MW6PR12MB70707673C99F020A595212EBB2FF2@MW6PR12MB7070.namprd12.prod.outlook.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 8 Jul 2026 09:11:23 +0200
X-Gm-Features: AVVi8CfYBNvcn9RGMVWx3aZmyTp2RUUsfZhDVdan86qYZQzcvuA4VZhpL2Y73Yo
Message-ID: <CAOaVG14co-O8rB43VLkAzKNr7yynTnR1NzJyW_UMV9FCmUyzZg@mail.gmail.com>
Subject: Re: [PATCH] build: fix libpcap detection with unusable header
To: Maayan Kashani <mkashani@nvidia.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev <dev@dpdk.org>, 
 Raslan Darawsheh <rasland@nvidia.com>, stable <stable@dpdk.org>, 
 David Marchand <david.marchand@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a88222065614376e"
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

--000000000000a88222065614376e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Not sure. Working around busted packages in DPDK is a bad idea.

On Wed, Jul 8, 2026, 08:38 Maayan Kashani <mkashani@nvidia.com> wrote:

> Hi, Bruce,
> we encountered DPDK build issue on Tencent 4.6.
> It is not expected; the package/image appears corrupted.
> RPM verification confirms the headers differ from the packaged contents.
> The DPDK change is still valid because optional dependency detection
> should
> test for usable declarations, not just file existence and library
> presence.=E2=80=9D
>
> Regards,
> Maayan Kashani
>
> > -----Original Message-----
> > From: Bruce Richardson <bruce.richardson@intel.com>
> > Sent: Tuesday, 7 July 2026 17:16
> > To: Maayan Kashani <mkashani@nvidia.com>
> > Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>;
> > stable@dpdk.org; David Marchand <david.marchand@redhat.com>; Stephen
> > Hemminger <stephen@networkplumber.org>
> > Subject: Re: [PATCH] build: fix libpcap detection with unusable header
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Jul 07, 2026 at 04:30:28PM +0300, Maayan Kashani wrote:
> > > The libpcap detection only checked that the library was present, that
> > > <pcap.h> could be included, and that a trivial program links. None of
> > > these fail when a distribution ships a libpcap-devel package whose
> > > <pcap.h> is empty (present but declaring nothing) while libpcap.so is
> > > installed: has_header() passes on an empty file and the link test doe=
s
> > > not reference any pcap symbol. RTE_HAS_LIBPCAP was then set and the
> > > pcap-dependent code (bpf_convert.c, port source/sink, dumpcap) failed
> > > to build with errors such as:
> > >
> >
> > Why would a distribution ship a devel package with an empty header file
> for
> > pcap.h? Is that expected behaviour in some scenario that I'm unaware of=
,
> > because it seems strange to me?
> >
> > /Bruce
> >
> > >   bpf_convert.c: error: invalid use of undefined type
> > >                  'const struct bpf_insn'
> > >
> > > Require an actual pcap declaration (pcap_create) to be visible in the
> > > header before enabling libpcap support, so a broken or empty header
> > > disables the optional pcap features instead of breaking the build.
> > >
> > > Fixes: d6024c0a6757 ("build: cleanup libpcap dependent components")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> > > ---
> > >  config/meson.build | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/config/meson.build b/config/meson.build index
> > > d7f5e55c18f..4bfb8535781 100644
> > > --- a/config/meson.build
> > > +++ b/config/meson.build
> > > @@ -290,7 +290,10 @@ if not pcap_dep.found()
> > >      # pcap got a pkg-config file only in 1.9.0
> > >      pcap_dep =3D cc.find_library(pcap_lib, required: false)  endif -=
if
> > > (pcap_dep.found() and cc.has_header('pcap.h', dependencies: pcap_dep)
> > > +# has_header() passes even when pcap.h is empty; require a real
> > declaration.
> > > +if (pcap_dep.found()
> > > +        and cc.has_header_symbol('pcap.h', 'pcap_create',
> dependencies:
> > pcap_dep,
> > > +                args: '-D_GNU_SOURCE')
> > >          and cc.links(min_c_code, dependencies: pcap_dep))
> > >      dpdk_conf.set('RTE_HAS_LIBPCAP', 1)
> > >      dpdk_extra_ldflags +=3D '-l@0@'.format(pcap_lib)
> > > --
> > > 2.21.0
> > >
>

--000000000000a88222065614376e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Not sure. Working around busted packages in DPDK is a bad=
 idea.</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Jul 8, 2026, 08:38 Maayan Kashani &lt=
;<a href=3D"mailto:mkashani@nvidia.com">mkashani@nvidia.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi, Bruce, <br>
we encountered DPDK build issue on Tencent 4.6.<br>
It is not expected; the package/image appears corrupted. <br>
RPM verification confirms the headers differ from the packaged contents. <b=
r>
The DPDK change is still valid because optional dependency detection should=
 <br>
test for usable declarations, not just file existence and library presence.=
=E2=80=9D<br>
<br>
Regards,<br>
Maayan Kashani<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@intel.co=
m" target=3D"_blank" rel=3D"noreferrer">bruce.richardson@intel.com</a>&gt;<=
br>
&gt; Sent: Tuesday, 7 July 2026 17:16<br>
&gt; To: Maayan Kashani &lt;<a href=3D"mailto:mkashani@nvidia.com" target=
=3D"_blank" rel=3D"noreferrer">mkashani@nvidia.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:dev@dpdk.org" target=3D"_blank" rel=3D"noreferre=
r">dev@dpdk.org</a>; Raslan Darawsheh &lt;<a href=3D"mailto:rasland@nvidia.=
com" target=3D"_blank" rel=3D"noreferrer">rasland@nvidia.com</a>&gt;;<br>
&gt; <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"noreferrer=
">stable@dpdk.org</a>; David Marchand &lt;<a href=3D"mailto:david.marchand@=
redhat.com" target=3D"_blank" rel=3D"noreferrer">david.marchand@redhat.com<=
/a>&gt;; Stephen<br>
&gt; Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"=
_blank" rel=3D"noreferrer">stephen@networkplumber.org</a>&gt;<br>
&gt; Subject: Re: [PATCH] build: fix libpcap detection with unusable header=
<br>
&gt; <br>
&gt; External email: Use caution opening links or attachments<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Jul 07, 2026 at 04:30:28PM +0300, Maayan Kashani wrote:<br>
&gt; &gt; The libpcap detection only checked that the library was present, =
that<br>
&gt; &gt; &lt;pcap.h&gt; could be included, and that a trivial program link=
s. None of<br>
&gt; &gt; these fail when a distribution ships a libpcap-devel package whos=
e<br>
&gt; &gt; &lt;pcap.h&gt; is empty (present but declaring nothing) while lib=
pcap.so is<br>
&gt; &gt; installed: has_header() passes on an empty file and the link test=
 does<br>
&gt; &gt; not reference any pcap symbol. RTE_HAS_LIBPCAP was then set and t=
he<br>
&gt; &gt; pcap-dependent code (bpf_convert.c, port source/sink, dumpcap) fa=
iled<br>
&gt; &gt; to build with errors such as:<br>
&gt; &gt;<br>
&gt; <br>
&gt; Why would a distribution ship a devel package with an empty header fil=
e for<br>
&gt; pcap.h? Is that expected behaviour in some scenario that I&#39;m unawa=
re of,<br>
&gt; because it seems strange to me?<br>
&gt; <br>
&gt; /Bruce<br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0bpf_convert.c: error: invalid use of undefined type<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#3=
9;const struct bpf_insn&#39;<br>
&gt; &gt;<br>
&gt; &gt; Require an actual pcap declaration (pcap_create) to be visible in=
 the<br>
&gt; &gt; header before enabling libpcap support, so a broken or empty head=
er<br>
&gt; &gt; disables the optional pcap features instead of breaking the build=
.<br>
&gt; &gt;<br>
&gt; &gt; Fixes: d6024c0a6757 (&quot;build: cleanup libpcap dependent compo=
nents&quot;)<br>
&gt; &gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"n=
oreferrer">stable@dpdk.org</a><br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Maayan Kashani &lt;<a href=3D"mailto:mkashani@nvid=
ia.com" target=3D"_blank" rel=3D"noreferrer">mkashani@nvidia.com</a>&gt;<br=
>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 config/meson.build | 5 ++++-<br>
&gt; &gt;=C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/config/meson.build b/config/meson.build index<br>
&gt; &gt; d7f5e55c18f..4bfb8535781 100644<br>
&gt; &gt; --- a/config/meson.build<br>
&gt; &gt; +++ b/config/meson.build<br>
&gt; &gt; @@ -290,7 +290,10 @@ if not pcap_dep.found()<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 # pcap got a pkg-config file only in 1.9.0<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pcap_dep =3D cc.find_library(pcap_lib, requir=
ed: false)=C2=A0 endif -if<br>
&gt; &gt; (pcap_dep.found() and cc.has_header(&#39;pcap.h&#39;, dependencie=
s: pcap_dep)<br>
&gt; &gt; +# has_header() passes even when pcap.h is empty; require a real<=
br>
&gt; declaration.<br>
&gt; &gt; +if (pcap_dep.found()<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 and cc.has_header_symbol(&#39;pcap.h=
&#39;, &#39;pcap_create&#39;, dependencies:<br>
&gt; pcap_dep,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args: &#=
39;-D_GNU_SOURCE&#39;)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and cc.links(min_c_code, depend=
encies: pcap_dep))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 dpdk_conf.set(&#39;RTE_HAS_LIBPCAP&#39;, 1)<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 dpdk_extra_ldflags +=3D &#39;-l@0@&#39;.forma=
t(pcap_lib)<br>
&gt; &gt; --<br>
&gt; &gt; 2.21.0<br>
&gt; &gt;<br>
</blockquote></div>

--000000000000a88222065614376e--
