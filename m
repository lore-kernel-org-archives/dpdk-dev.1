Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A737CC83030
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 20:10:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A31C40287;
	Mon,  7 Jul 2025 22:10:19 +0200 (CEST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id E03264025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 22:10:17 +0200 (CEST)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-ae0c571f137so689034666b.0
 for <dev@dpdk.org>; Mon, 07 Jul 2025 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751919017; x=1752523817; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g49Jl7KlZC1b44hxylr6JHdhqvnj2qOoJiZ8Ls/F2+k=;
 b=YyjSvuDV+ndKgDNqt9SZgzsjdQykh565gr1Mi4E5qHG4v5UEvYA1jZmS9qeCzzISC/
 si8z0i3Fs5OPeLQ4Eujdg2czEaxevJbPVDqJONYURc5XZzsITOFMhFhVTekgtPtRMMHH
 tG8aiW45XSPLkCpiTri422c46sfi1DA2F0QNd65XE3mhqtTN3HJBWwl7pVEvjoC1Isyc
 e1/ssKbSouxKtyVUV9bf+hu4dpF6carf0Xbr+oRSf8F8aQzmGHntL7NO4bJsiAjuMtJv
 rdo5j4GP39/gkoix2ktewqOJ2YV5uh8uLp+kd0jOV+4rd8BXBbp9Vf6ddpYvq31BZRIN
 +dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919017; x=1752523817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g49Jl7KlZC1b44hxylr6JHdhqvnj2qOoJiZ8Ls/F2+k=;
 b=fTdWyC2Jyjipxjqodkxk43luSy/feImZzA436en6Rmngi3QBg2AMVCgGGtTJAO1eer
 RmV4IVPaCO8KuZDx1QwhxqN6FoW9aWRjnviD9simlKy3qCzv8g6SY9VYsBuJwEq08Ifg
 z1VC0hP0u1rq/ZuUIXrzgobeLez/eifGuxYOa52+2lxNTysRfrm4zrObao8vQV0ZA2yB
 UkqTDODdNprNUQoAmReGySNdW+ibuUUlXbxFrJvXJq4SqbIgxlonS5Oz/0yTso4XLjvk
 iJJrTD0HaCVVJA1LTwHY9qtDxLaIVc0JvHSjZ6+2sxcGrRKMg2D9zqKoKr2jNFDWsCIK
 ttUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhgO7V8Bjsvn/aZsVB2bWIsVdvQFfXK8HuvMkj96aukA23d7BQxuy9pFeLdqGhvgpFXJE=@dpdk.org
X-Gm-Message-State: AOJu0Ywl5PXZEdIHsAyoqrnXZ/03rqsCKnlhKDjEBvZwyRvS7DWN1tSc
 RW9TQzQuqb9PGnI51F/90k93DRY9HLgw8AWEnRWZxx2SyFVwEF3NwE0UgKbjt5dZCxNZ5k4072f
 HjjnG0HlnbrSSdvXntD2sDOqxLhe2aDU=
X-Gm-Gg: ASbGnctFD9UKRGQ3+1Hw4BCMh++yE4L/cz4ythBhsaalcpHc2/gBJG15V2pMqFHwm4O
 mChmeTughCq0bVZvxb3bQJwOme3+6v68CN3jbStUi68Jz5RBAcgSgUDR43u7BlfFg5Vg1qrV1+9
 0VoB0lxCXe3HsP/2dWM9070w5wY3aV2idiurZn1HJtpcFD
X-Google-Smtp-Source: AGHT+IGvr+GWK2jlJm4g33FBbMI2MSEUh/yFScQ709nsT9M9dJapMTPpVOy9r5Nmbcz9kUXXhTQrtPX/5rxSySU9u4M=
X-Received: by 2002:a17:907:9404:b0:ae3:ed39:89ba with SMTP id
 a640c23a62f3a-ae6b0b1e8dcmr36345066b.11.1751919016873; Mon, 07 Jul 2025
 13:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250703093027.1259459-1-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
 <aGe7uxORe1V817a2@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD98@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD98@smartserver.smartshare.dk>
From: Vladimir Medvedkin <medvedkinv@gmail.com>
Date: Mon, 7 Jul 2025 21:10:03 +0100
X-Gm-Features: Ac12FXwoMPblClXyYIjXveUQOcXipb8CbmLL4w9rb3Hnrznna3Vy9qeybgdKZJg
Message-ID: <CANDrEH=NEpj8X-8e6JXGVAMGXuykp1bgOMKyLFm1TPBEovdx-Q@mail.gmail.com>
Subject: Re: [PATCH] net: support VLAN stacking packet type parsing
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Dengdui Huang <huangdengdui@huawei.com>, dev@dpdk.org, 
 stephen@networkplumber.org, jasvinder.singh@intel.com, thomas@monjalon.net, 
 aman.deep.singh@intel.com, lihuisong@huawei.com, fengchengwen@huawei.com, 
 liuyonglong@huawei.com
Content-Type: multipart/alternative; boundary="000000000000ad128006395c6e83"
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

--000000000000ad128006395c6e83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Morten, all,


=D0=BF=D0=BD, 7 =D0=B8=D1=8E=D0=BB. 2025=E2=80=AF=D0=B3. =D0=B2 19:09, Mort=
en Br=C3=B8rup <mb@smartsharesystems.com>:

> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Friday, 4 July 2025 13.32
>
> > Hi all,
> >
> > this email discussion comes at a bit of a fortunate time for me, as I'm
> > currently looking at our vlan tag/qinq stripping behaviour in our Intel
> > NIC
> > drivers, and there is some discussion internally as to what our driver
> > behaviour should be compared to what it has historically been. :-)
> >
> > The documentation - both in the NIC guide [1] and the testpmd guide [2]
> > -
> > is rather short on detail as to what exactly the behaviour should be
> > when
> > vlan strip or qinq strip is implemented. Therefore, I'd hope that those
> > more familiar with networking than me would be able to help clarify
> > things
> > so we can document the correct behaviour precisely - and hopefully test
> > our
> > drivers against it in future!
> >
> > The simple cases are obvious (looking only at stripping behaviour here)=
:
> > * no vlan stripping - nothing done to packet
> > * no vlan tag in pkg - nothing to do, irrespective of offload
> > * Vlan strip enabled and single vlan tag present - HW should strip the
> > tag and
> >   place it in descriptor for placing in mbuf.
> >
> > Now the questions I have:
> > * To handle questions with 2 vlan tags, the QinQ case - do we need to
> >   enable both vlan-strip and QinQ strip, or does QinQ strip imply
> > stripping
> >   both?
> >   - one suggested interpretation here, was that QinQ implies stripping
> > the
> >     tag with id EtherType 0x88a8, and vlan stripping implies taking off
> > the
> >     tag with 0x8100
> >   - another interpretation is vlan strip means just to take off one tag
> > (if
> >     present), and qinq strip means to take off both tags (if present).
> >
>
> First off, consider VLAN stripping...
> It strips the VLAN tag if present, but also allows (and parses) untagged
> packets.
> A link with a mix of tagged and untagged packets is called a "hybrid
> link", so this scenario is perfectly valid and common.
> Referring to this behavior, I would expect something similar for QinQ
> stripping, i.e. with QinQ stripping enabled, two, one or zero tags are
> allowed (and parsed).
> This makes the VLAN strip flag superfluous when the QinQ strip flag is se=
t.
>
> You could have a QinQ trunk carrying only QinQ tagged packets and untagge=
d
> Layer 2 Control Protocol packets (LACP etc.).
> In this case you might want the ability to drop VLAN tagged packets, whic=
h
> should not occur on the link.
>

That's not quite correct.
There are 2 valid usecases, that may bring some ambiguity:
    1. Some vendors may support mixing dual/single tagged packets on a
physical port, (for example refer to the JunOS flexible-vlan-tagging)
    2. Service provider(SP) provides L2 connectivity to a customer, and
customer is able to send non tagged frames via SP infrastructure.

Thus, upon receive single tagged packet at the SP exit node (the switch
customer is connected to) how does it distinguish (w/o reading local
configuration, i.e. VLAN A - QinQ outer tag, vlans B and C - regular VLANs)
whether the packet is non tagged encapsulated into SP's QinQ, or a regular
VLAN packet belonging to the internal SP infrastructure?
In each case, NIC has to place the VLAN tag in different places of the
descriptor/mbuf.


However, since we don't have such a feature for VLAN trunks, I wouldn't
> expect it for QinQ trunks either.
>
> Another important detail...
> Formally, QinQ is EtherType 0x88a8 with two VLAN tags.
> However, I think double-tagging with EtherType 0x8100 is still broadly in
> use (in old networks, where it is difficult to upgrade to the official Qi=
nQ
> EtherType), so I would also treat packets with two VLAN tags (of EtherTyp=
e
> 0x8100) as QinQ.
> There was also an intermediate unofficial EtherType 0x9100 for QinQ
> tagging, before EtherType 0x88a8 was standardized... but I think we can
> ignore that.
>
> > The question above leads to other consequences:
> > * if we enable qinq strip, but get a single-vlan tagged frame, what is
> > the
> >   behaviour?
> > * if we get a qinq packet, but regular vlan strip is enabled, which tag=
,
> > if
> >   any, is stripped?
> > * should it be an error to enable both qinq strip and vlan strip at the
> >   same time? Should it be an error to enable qinq strip without vlan
> > strip?
> > * in the mbuf, we have a "vlan_tci" field, and an "vlan_tci_outer"
> > field.
> >   For single vlan strip, presumably only the vlan_tci field should be
> > used,
> >   and for qinq traffic stripped, it's obvious which field goes where.
> >   However, what if we have QinQ strip and we only receive a single vlan
> >   tag, where should that be put? Should it go in inner or outer?
>
> From a protocol parsing perspective, a single VLAN tagged packet has no
> "outer" tag.
>
> Also: Consider the link being configured as a "super-hybrid link"
> (probably not an official name for such a link, but expanding on the comm=
on
> term "hybrid link"), carrying a mix of untagged, VLAN tagged and QinQ
> tagged packets. In this case, a single VLAN tagged packet is just a norma=
l
> VLAN tagged packet, with the VLAN ID obviously going to the ordinary
> vlan_tci field.
>
> >
> > Feedback welcome, and suggested doc updates welcome too.
> >
> > Thanks,
> > /Bruce
> >
> >
> > [1] https://doc.dpdk.org/guides/nics/features.html#vlan-offload
> > [2] https://doc.dpdk.org/guides/testpmd_app_ug/run_app.html
>


--=20
Regards,
Vladimir

--000000000000ad128006395c6e83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Morten, all,</di=
v><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">=D0=BF=D0=BD, 7 =D0=B8=D1=8E=D0=BB. 2025=E2=80=AF=D0=B3. =
=D0=B2 19:09, Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smartsharesystems=
.com" target=3D"_blank">mb@smartsharesystems.com</a>&gt;:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">&gt; From: Bruce Richardson [mail=
to:<a href=3D"mailto:bruce.richardson@intel.com" target=3D"_blank">bruce.ri=
chardson@intel.com</a>]<br>
&gt; Sent: Friday, 4 July 2025 13.32<br>
<br>
&gt; Hi all,<br>
&gt; <br>
&gt; this email discussion comes at a bit of a fortunate time for me, as I&=
#39;m<br>
&gt; currently looking at our vlan tag/qinq stripping behaviour in our Inte=
l<br>
&gt; NIC<br>
&gt; drivers, and there is some discussion internally as to what our driver=
<br>
&gt; behaviour should be compared to what it has historically been. :-)<br>
&gt; <br>
&gt; The documentation - both in the NIC guide [1] and the testpmd guide [2=
]<br>
&gt; -<br>
&gt; is rather short on detail as to what exactly the behaviour should be<b=
r>
&gt; when<br>
&gt; vlan strip or qinq strip is implemented. Therefore, I&#39;d hope that =
those<br>
&gt; more familiar with networking than me would be able to help clarify<br=
>
&gt; things<br>
&gt; so we can document the correct behaviour precisely - and hopefully tes=
t<br>
&gt; our<br>
&gt; drivers against it in future!<br>
&gt; <br>
&gt; The simple cases are obvious (looking only at stripping behaviour here=
):<br>
&gt; * no vlan stripping - nothing done to packet<br>
&gt; * no vlan tag in pkg - nothing to do, irrespective of offload<br>
&gt; * Vlan strip enabled and single vlan tag present - HW should strip the=
<br>
&gt; tag and<br>
&gt;=C2=A0 =C2=A0place it in descriptor for placing in mbuf.<br>
&gt; <br>
&gt; Now the questions I have:<br>
&gt; * To handle questions with 2 vlan tags, the QinQ case - do we need to<=
br>
&gt;=C2=A0 =C2=A0enable both vlan-strip and QinQ strip, or does QinQ strip =
imply<br>
&gt; stripping<br>
&gt;=C2=A0 =C2=A0both?<br>
&gt;=C2=A0 =C2=A0- one suggested interpretation here, was that QinQ implies=
 stripping<br>
&gt; the<br>
&gt;=C2=A0 =C2=A0 =C2=A0tag with id EtherType 0x88a8, and vlan stripping im=
plies taking off<br>
&gt; the<br>
&gt;=C2=A0 =C2=A0 =C2=A0tag with 0x8100<br>
&gt;=C2=A0 =C2=A0- another interpretation is vlan strip means just to take =
off one tag<br>
&gt; (if<br>
&gt;=C2=A0 =C2=A0 =C2=A0present), and qinq strip means to take off both tag=
s (if present).<br>
&gt; <br>
<br>
First off, consider VLAN stripping...<br>
It strips the VLAN tag if present, but also allows (and parses) untagged pa=
ckets.<br>
A link with a mix of tagged and untagged packets is called a &quot;hybrid l=
ink&quot;, so this scenario is perfectly valid and common.<br>
Referring to this behavior, I would expect something similar for QinQ strip=
ping, i.e. with QinQ stripping enabled, two, one or zero tags are allowed (=
and parsed).<br>
This makes the VLAN strip flag superfluous when the QinQ strip flag is set.=
<br>
<br>
You could have a QinQ trunk carrying only QinQ tagged packets and untagged =
Layer 2 Control Protocol packets (LACP etc.).<br>
In this case you might want the ability to drop VLAN tagged packets, which =
should not occur on the link.<br></blockquote><div><br></div><div>That&#39;=
s not quite correct.</div><div>There are 2 valid=C2=A0usecases, that may br=
ing some ambiguity:</div><div>=C2=A0 =C2=A0 1.=C2=A0Some vendors may suppor=
t mixing dual/single tagged packets on a physical port,=C2=A0(for example r=
efer to the JunOS=C2=A0flexible-vlan-tagging)</div><div>=C2=A0 =C2=A0 2. Se=
rvice provider(SP) provides L2 connectivity to a customer, and customer is =
able to send non tagged frames via SP infrastructure.</div><div><br></div><=
div>Thus, upon=C2=A0receive single tagged packet at the SP exit node (the s=
witch customer is connected to) how does it distinguish (w/o reading local =
configuration, i.e. VLAN A - QinQ outer tag, vlans B and C - regular VLANs)=
=C2=A0<span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-w=
rap">whether</span>=C2=A0the packet is non tagged encapsulated into SP&#39;=
s QinQ, or a regular VLAN packet belonging to the internal SP infrastructur=
e?</div><div><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-spac=
e:pre-wrap">In</span><span style=3D"white-space:pre-wrap"> </span><span cla=
ss=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap">each</span=
><span style=3D"white-space:pre-wrap"> </span><span class=3D"gmail-aNeGP0gI=
0B9AV8JaHPyH" style=3D"white-space:pre-wrap">case</span><span style=3D"whit=
e-space:pre-wrap">, NIC has</span><span style=3D"white-space:pre-wrap"> to =
</span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-=
wrap">place</span><span style=3D"white-space:pre-wrap"> the </span><span cl=
ass=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap">VLAN</spa=
n><span style=3D"white-space:pre-wrap"> </span><span class=3D"gmail-aNeGP0g=
I0B9AV8JaHPyH" style=3D"white-space:pre-wrap">tag</span><span style=3D"whit=
e-space:pre-wrap"> </span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=
=3D"white-space:pre-wrap">in</span><span style=3D"white-space:pre-wrap"> </=
span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wr=
ap">different</span><span style=3D"white-space:pre-wrap"> </span><span clas=
s=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap">places</spa=
n><span style=3D"white-space:pre-wrap"> of the </span><span style=3D"white-=
space:pre-wrap"></span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"=
white-space:pre-wrap">descriptor</span><span style=3D"white-space:pre-wrap"=
></span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre=
-wrap">/</span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-sp=
ace:pre-wrap">mbuf</span><span style=3D"white-space:pre-wrap">.</span></div=
><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
However, since we don&#39;t have such a feature for VLAN trunks, I wouldn&#=
39;t expect it for QinQ trunks either.<br>
<br>
Another important detail...<br>
Formally, QinQ is EtherType 0x88a8 with two VLAN tags.<br>
However, I think double-tagging with EtherType 0x8100 is still broadly in u=
se (in old networks, where it is difficult to upgrade to the official QinQ =
EtherType), so I would also treat packets with two VLAN tags (of EtherType =
0x8100) as QinQ.<br>
There was also an intermediate unofficial EtherType 0x9100 for QinQ tagging=
, before EtherType 0x88a8 was standardized... but I think we can ignore tha=
t.<br>
<br>
&gt; The question above leads to other consequences:<br>
&gt; * if we enable qinq strip, but get a single-vlan tagged frame, what is=
<br>
&gt; the<br>
&gt;=C2=A0 =C2=A0behaviour?<br>
&gt; * if we get a qinq packet, but regular vlan strip is enabled, which ta=
g,<br>
&gt; if<br>
&gt;=C2=A0 =C2=A0any, is stripped?<br>
&gt; * should it be an error to enable both qinq strip and vlan strip at th=
e<br>
&gt;=C2=A0 =C2=A0same time? Should it be an error to enable qinq strip with=
out vlan<br>
&gt; strip?<br>
&gt; * in the mbuf, we have a &quot;vlan_tci&quot; field, and an &quot;vlan=
_tci_outer&quot;<br>
&gt; field.<br>
&gt;=C2=A0 =C2=A0For single vlan strip, presumably only the vlan_tci field =
should be<br>
&gt; used,<br>
&gt;=C2=A0 =C2=A0and for qinq traffic stripped, it&#39;s obvious which fiel=
d goes where.<br>
&gt;=C2=A0 =C2=A0However, what if we have QinQ strip and we only receive a =
single vlan<br>
&gt;=C2=A0 =C2=A0tag, where should that be put? Should it go in inner or ou=
ter?<br>
<br>
From a protocol parsing perspective, a single VLAN tagged packet has no &qu=
ot;outer&quot; tag.<br>
<br>
Also: Consider the link being configured as a &quot;super-hybrid link&quot;=
 (probably not an official name for such a link, but expanding on the commo=
n term &quot;hybrid link&quot;), carrying a mix of untagged, VLAN tagged an=
d QinQ tagged packets. In this case, a single VLAN tagged packet is just a =
normal VLAN tagged packet, with the VLAN ID obviously going to the ordinary=
 vlan_tci field.<br>
<br>
&gt; <br>
&gt; Feedback welcome, and suggested doc updates welcome too.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; /Bruce<br>
&gt; <br>
&gt; <br>
&gt; [1] <a href=3D"https://doc.dpdk.org/guides/nics/features.html#vlan-off=
load" rel=3D"noreferrer" target=3D"_blank">https://doc.dpdk.org/guides/nics=
/features.html#vlan-offload</a><br>
&gt; [2] <a href=3D"https://doc.dpdk.org/guides/testpmd_app_ug/run_app.html=
" rel=3D"noreferrer" target=3D"_blank">https://doc.dpdk.org/guides/testpmd_=
app_ug/run_app.html</a><br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Regards,<br></div>Vladimir<br></div></div></div>
</div>

--000000000000ad128006395c6e83--
