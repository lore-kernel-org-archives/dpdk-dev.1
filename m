Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE24C3ABA9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 16:30:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 387CD402B1;
	Wed, 30 Apr 2025 18:30:44 +0200 (CEST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id 883AC402A0
 for <dev@dpdk.org>; Wed, 30 Apr 2025 18:30:42 +0200 (CEST)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5f6f86580ecso10727a12.1
 for <dev@dpdk.org>; Wed, 30 Apr 2025 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746030642; x=1746635442; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n3bS8yf6DFNAHufLf+6Ly5fHIEELqRWHkhSXl6qhAtY=;
 b=EpG+C9aOps5gIfyG6+XKVWVsyULRYdVAuxISibe8BhOGpoAapgWF1+N09D4RibxRxf
 Se0wBtLHO0X1eKPzaanNuzd+Jhi/7HdsmhQ+3P+zbU12WNNi07X+mQPmQshzYhSDssvX
 e2YSyc4UhoIx11XHHhBPjw3aOX3N3COPmyOHqcfbFTJ9FVirotq0Q0OWOwxBHQIC4vjt
 4xJGpCDeBUwuGosXA8w5A+M6taX4DUSZR2SVSzP1+Y7RVFf5wew0iHMdzqUDo70TADKg
 XpbHKwajPyBPmHXpB5dcwBtlkio6FQoyXgtiy1sckR243Y8IcBWgSMo5fcl+LNBz1dJO
 2xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746030642; x=1746635442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n3bS8yf6DFNAHufLf+6Ly5fHIEELqRWHkhSXl6qhAtY=;
 b=avBd+bFkbG43ZHWphf/3R+2qJb/zJlEDn1Y9yR5kgh0dpMfT79o9dqqJdXgyuiT0m+
 tVE1g6G5oR2DeJfv1ksbOt6XCvBScVkoAtR+68wElgwqq7Aan7qZGGVG0iQ8JLQHvPZZ
 /o/TSJ8D83fajm5A58/oJwXnM3RdrKygrS35vN/9FP1/A6hPJziaRItauzws9He2rfHj
 hBxPGlgQZYG+K4+Zj2VBhWX6FleicOfT7KLscNrGlLQgesIWoflgdYGiqXTTzawyFTCL
 64LaFQUyDJLQ800EFtd3DWisoJAeJFLFCfjxIqJ8QxjmF9pchPOodpd8T911ucmsYJ/7
 hK6A==
X-Gm-Message-State: AOJu0YwubGkmxBFUfRpMn/MkvKjUxRHNz8/QiolCfRuecl+UeXYubJfT
 F7TSX7vAIo+ApvG2wYkh9Xsgj5nMxYtvPhQYlDbUDCEHa7RBhY53tBe4k1s3qHADFx6ONiY1VKH
 CNUsnIYfYE7O6aYEyy1Ddp8AKjVgV2A==
X-Gm-Gg: ASbGncvXrQeY0nKv5Lhbry+2BQTF6i/I8P86s5gD/QhH1+GPRBx3RjumH3p0u+lFwgd
 xaanoHlfRwWITL1widUez5QG3USTt59n6kFASLBZWNcsDdWQ7nP3PWBOHJxvVsZq9F8wTDPhhnR
 2omZEGXy4xsTqlSsW0V2LrjtyBnMbBH5td7fI1LULIUbq35rUq4aXpbH3X
X-Google-Smtp-Source: AGHT+IEuBLwFNgZeG1XFKz/Kg9oRqyk8QSFkqlVvBuIbNqaAJYttKd7YBslLJlDtdh8xJrWXbfrlOJv0hw4yWxLCx5I=
X-Received: by 2002:a17:906:dc89:b0:ac2:6bf9:e386 with SMTP id
 a640c23a62f3a-acee21f3ae5mr118386466b.8.1746030641652; Wed, 30 Apr 2025
 09:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
 <20250426082843.736964ba@hermes.local>
 <CAPBAu3WOq6_77mBvd=B8x2tso9hWpjFTyUuEeJgZazSm_y_GHQ@mail.gmail.com>
 <20250428083712.50b2e7ce@hermes.local>
 <CAPBAu3UDao48OmcnEMQw9-W3pesM1W2ftQsEG3EtHDxxOXCc=Q@mail.gmail.com>
 <20250429092415.2a37c090@hermes.local>
 <CAPBAu3XDwr82ghjdhK=QXO53OPH3MgUtkP7r3TLEwOnHe_St5w@mail.gmail.com>
 <20250430072825.13ceae3e@hermes.local>
In-Reply-To: <20250430072825.13ceae3e@hermes.local>
From: Prashant Upadhyaya <praupadhyaya@gmail.com>
Date: Wed, 30 Apr 2025 22:00:29 +0530
X-Gm-Features: ATxdqUHsdpKgGF3_eSuJingMVIXHA7l6SugDUDyYVkUygYRR7NmzEd1JuyUny0g
Message-ID: <CAPBAu3WPaMMErEfbVtKBsd7n-D5GGLGYARex_dURxWtrMmTtXQ@mail.gmail.com>
Subject: Re: Regarding Mellanox bifurcated driver on Azure
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000029a81906340170cc"
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

--00000000000029a81906340170cc
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 19:58, Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Wed, 30 Apr 2025 13:00:53 +0530
> Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
>
> > > With DPDK on Azure, an application should never use the VF directly.
> > > It needs to use either netvsc PMD which handles both the vmbus (slow
> path)
> > > and VF (fast path) combined. Or use the older vdev_netvsc/failsafe/tap
> > > combination.
> > > The latter uses a virtual device to make a failsafe PMD which then does
> > > a combination of TAP (via kernel slow path) and MLX5 VF.  The failsafe
> PMD
> > > is what is exposed for application usage.
> > >
> > > The limitations are not explicitly mentioned in the documentation but:
> > >   - don't use VF directly in application
> > >   - there is no support for bifurcation where some packets go to kernel
> > >     and some to DPDK
> > >   - there is only very limited support for rte_flow; that is with
> failsafe
> > > PMD
> > >     (not netvsc PMD) and the limitations are that the emulation of
> rte_flow
> > >     in the TAP device only supports a few things.
> > >
> >
> > Thanks Stephen, the above information was very instructive.
> > If I do use the Netvsc PMD with the latest DPDK, will my DPDK app get the
> > non IP packets like ARP, please confirm.
> > I quickly tried the Netvsc PMD but don't seem to be getting the ARP
> packets
> > in still.
> > When you mention "The failsafe PMD is what is exposed for application
> > usage", what is the meaning of this, are the apps expected to use
> failsafe
> > PMD, please suggest.
> >
> > Regards
> > -Prashant
>
> ARP handled differently in virtual network environments. The ARP packets
> sent
> get consumed and replied to by the network infrastructure (in all virtual
> networks
> not just Azure). Non-IP packets always show up on the synthetic VMBus
> device.
>
> Current docs are here:
>
> https://learn.microsoft.com/en-us/azure/virtual-network/setup-dpdk?tabs=redhat
>
> See vdev_netvsc for picture.
> https://doc.dpdk.org/guides/nics/vdev_netvsc.html
>
>
> Thanks again Stephen. I finally was able to run the netvsc pmd and it is
detecting the ports.
However, for every accelerated networking interface of Azure, it detects
'two' ports. This is presumably for controlling both the slow and fast path
?
This poses an issue for my app as it wanted to see only 'one' interface in
its control as a lot of business logic is kind of tied to it.
So a question -- am I observing correctly that DPDK, in case of netvsc,
will enumerate two ports for each accelerated networking interface ?

Regards
-Prashant

--00000000000029a81906340170cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 30 Apr =
2025 at 19:58, Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumb=
er.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Wed, 30 Apr 2025 13:00:53 +0530<br>
Prashant Upadhyaya &lt;<a href=3D"mailto:praupadhyaya@gmail.com" target=3D"=
_blank">praupadhyaya@gmail.com</a>&gt; wrote:<br>
<br>
&gt; &gt; With DPDK on Azure, an application should never use the VF direct=
ly.<br>
&gt; &gt; It needs to use either netvsc PMD which handles both the vmbus (s=
low path)<br>
&gt; &gt; and VF (fast path) combined. Or use the older vdev_netvsc/failsaf=
e/tap<br>
&gt; &gt; combination.<br>
&gt; &gt; The latter uses a virtual device to make a failsafe PMD which the=
n does<br>
&gt; &gt; a combination of TAP (via kernel slow path) and MLX5 VF.=C2=A0 Th=
e failsafe PMD<br>
&gt; &gt; is what is exposed for application usage.<br>
&gt; &gt;<br>
&gt; &gt; The limitations are not explicitly mentioned in the documentation=
 but:<br>
&gt; &gt;=C2=A0 =C2=A0- don&#39;t use VF directly in application<br>
&gt; &gt;=C2=A0 =C2=A0- there is no support for bifurcation where some pack=
ets go to kernel<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0and some to DPDK<br>
&gt; &gt;=C2=A0 =C2=A0- there is only very limited support for rte_flow; th=
at is with failsafe<br>
&gt; &gt; PMD<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0(not netvsc PMD) and the limitations are that =
the emulation of rte_flow<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0in the TAP device only supports a few things.<=
br>
&gt; &gt;=C2=A0 <br>
&gt; <br>
&gt; Thanks Stephen, the above information was very instructive.<br>
&gt; If I do use the Netvsc PMD with the latest DPDK, will my DPDK app get =
the<br>
&gt; non IP packets like ARP, please confirm.<br>
&gt; I quickly tried the Netvsc PMD but don&#39;t seem to be getting the AR=
P packets<br>
&gt; in still.<br>
&gt; When you mention &quot;The failsafe PMD is what is exposed for applica=
tion<br>
&gt; usage&quot;, what is the meaning of this, are the apps expected to use=
 failsafe<br>
&gt; PMD, please suggest.<br>
&gt; <br>
&gt; Regards<br>
&gt; -Prashant<br>
<br>
ARP handled differently in virtual network environments. The ARP packets se=
nt<br>
get consumed and replied to by the network infrastructure (in all virtual n=
etworks<br>
not just Azure). Non-IP packets always show up on the synthetic VMBus devic=
e.<br>
<br>
Current docs are here:<br>
<a href=3D"https://learn.microsoft.com/en-us/azure/virtual-network/setup-dp=
dk?tabs=3Dredhat" rel=3D"noreferrer" target=3D"_blank">https://learn.micros=
oft.com/en-us/azure/virtual-network/setup-dpdk?tabs=3Dredhat</a><br>
<br>
See vdev_netvsc for picture. <a href=3D"https://doc.dpdk.org/guides/nics/vd=
ev_netvsc.html" rel=3D"noreferrer" target=3D"_blank">https://doc.dpdk.org/g=
uides/nics/vdev_netvsc.html</a><br>
<br>
<br></blockquote><div>Thanks again Stephen. I finally was able to run the n=
etvsc pmd and it is detecting the ports.</div><div>However, for every accel=
erated networking interface of Azure, it detects &#39;two&#39; ports. This =
is presumably for controlling both the slow and fast path ?</div><div>This =
poses an issue for my app as it wanted to see only &#39;one&#39; interface =
in its control as a lot of business logic is kind of tied to it.</div><div>=
So a question -- am I observing correctly that DPDK,=C2=A0in case of netvsc=
, will enumerate two ports for each accelerated networking interface ?</div=
><div><br></div><div>Regards</div><div>-Prashant</div><div>=C2=A0</div></di=
v></div>

--00000000000029a81906340170cc--
