Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11386C3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 14:07:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F373840264;
	Mon,  5 May 2025 16:07:45 +0200 (CEST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 5EF0D4025D
 for <dev@dpdk.org>; Mon,  5 May 2025 16:07:45 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-5faa590dbb2so221579a12.1
 for <dev@dpdk.org>; Mon, 05 May 2025 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746454065; x=1747058865; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2xdHZozqS/TqYH+rjzgYbH8DSgPbQSFQBpbq/Is5rbs=;
 b=IakCXOz9+a6pUikyUwV9wEe08KqvNPc2Kb+1XygEI79/S4hRu9caguHCd1gYYU3leq
 DlUnbyhsZ3XokGG++vZfMY0qOBaYNuv258gEKn8VcYSYawVQetzAPysqTfxLgUfVMux+
 sfJTuUb+WPC2+sgJ0vJe1wUVx49+plpWGsnlI7iuyyevWw6eOrIvN6wwW9FGl7zm4TRl
 eCLiZvH0dZQAanmvyy0cWYPZNzZb2Qhn5UiOrDuuA8tLOmoQy1NBEMdgFDgbN9mmQ8Hf
 amjT96ACnfsrUEg0Q72MfhhwgAD0yrk6dqmAwaMckAwJBaV2Vmqx+MayG84zh+B+We4m
 MdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746454065; x=1747058865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2xdHZozqS/TqYH+rjzgYbH8DSgPbQSFQBpbq/Is5rbs=;
 b=HdmBd0f+8SBtLvKZU9hPVUQD4UKtzxhRr/p/0oVvCyn2DdGotgrkrJhC2lY4fB8MKa
 vBDnAGaVJrE+G0C+oltbVQzTNV1h03LrX/JG7mLP9MyXJ8E8DXSSF58AiB6Zg6IV38V1
 FHO0rVNOwGlcl6ACzTv4oh6e7+FlJNx637UokYvN8JAp3rkV5MjkjQeWGXeyX3FObaYE
 NtPnkSA/vfmcJDDLno+xorPjyAX+CMhW7iVCLmXPMFS9zd/+bTgW/oU0yevde2oSeyqs
 CBy4EyxtMg+aFUBzAWyYbCRGTVN9i5t5jp6IsopsJwDyfC10MxfzQnlhW42+K1atFJJK
 1ujg==
X-Gm-Message-State: AOJu0YxLUZjuvHBY+QHBeVfLr4kDbtSKdpyV41VwEy8GF4uXke+gpz23
 M9iCu6rrP1X864Vy20hrM2i0oDj+s1eOHRqfs5vV4IFrxDoNAoEpgvdXjJ77FYyQEbQsTVF/yi3
 KHLNi7hGr/MtemmPNXldP3pXO6lKheO97
X-Gm-Gg: ASbGnctXKM/0MyFzrdIBJ9Oa4aeOzVBw+byqvGIwbLQpLAoFDMRSEIsA2STZAIH4p19
 Rlnstw7SHH9pc+3JjnoNjqAMZnJeduK9n0knsvdEEcmDquQhcb0xPdaN1jUvY633EO8PB8BxS/2
 BohgRAhtJvGVVg5fI02H/M3x7RbfCCvz5JGnnbpj+n4hQsujHcBgDh9cIrXJ/yWRT58p8=
X-Google-Smtp-Source: AGHT+IHvcbLAhHSBo8fQBWC1dCrbHG7+WnJ+Z4JZH9Tt7vEImUU1Zaxkomc8jWvgkmusN62LvdVFFdUEKyXqFhLur0A=
X-Received: by 2002:a05:6402:3514:b0:5f8:e07c:7764 with SMTP id
 4fb4d7f45d1cf-5fa77d648a0mr3563529a12.0.1746454064430; Mon, 05 May 2025
 07:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
 <20250426082843.736964ba@hermes.local>
 <CAPBAu3WOq6_77mBvd=B8x2tso9hWpjFTyUuEeJgZazSm_y_GHQ@mail.gmail.com>
 <20250428083712.50b2e7ce@hermes.local>
 <CAPBAu3UDao48OmcnEMQw9-W3pesM1W2ftQsEG3EtHDxxOXCc=Q@mail.gmail.com>
 <20250429092415.2a37c090@hermes.local>
 <CAPBAu3XDwr82ghjdhK=QXO53OPH3MgUtkP7r3TLEwOnHe_St5w@mail.gmail.com>
 <20250430072825.13ceae3e@hermes.local>
 <CAPBAu3WPaMMErEfbVtKBsd7n-D5GGLGYARex_dURxWtrMmTtXQ@mail.gmail.com>
 <20250430095149.5c08e08e@hermes.local>
In-Reply-To: <20250430095149.5c08e08e@hermes.local>
From: Prashant Upadhyaya <praupadhyaya@gmail.com>
Date: Mon, 5 May 2025 19:37:33 +0530
X-Gm-Features: ATxdqUFlS4PbXRZ28ZBNG9m1w6zHJilQupnWKFlWXa4toioomlWf_ndUGvXuc-Q
Message-ID: <CAPBAu3VVqLmPTPAVUM0ahZ1k9UdmZiN_QgM8rCoqdKcXZWkmoA@mail.gmail.com>
Subject: Re: Regarding Mellanox bifurcated driver on Azure
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000002084fd06346406a3"
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

--0000000000002084fd06346406a3
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 22:21, Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Wed, 30 Apr 2025 22:00:29 +0530
> Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
>
> > On Wed, 30 Apr 2025 at 19:58, Stephen Hemminger <
> stephen@networkplumber.org>
> > wrote:
> >
> > > On Wed, 30 Apr 2025 13:00:53 +0530
> > > Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
> > >
> > > > > With DPDK on Azure, an application should never use the VF
> directly.
> > > > > It needs to use either netvsc PMD which handles both the vmbus
> (slow
> > > path)
> > > > > and VF (fast path) combined. Or use the older
> vdev_netvsc/failsafe/tap
> > > > > combination.
> > > > > The latter uses a virtual device to make a failsafe PMD which then
> does
> > > > > a combination of TAP (via kernel slow path) and MLX5 VF.  The
> failsafe
> > > PMD
> > > > > is what is exposed for application usage.
> > > > >
> > > > > The limitations are not explicitly mentioned in the documentation
> but:
> > > > >   - don't use VF directly in application
> > > > >   - there is no support for bifurcation where some packets go to
> kernel
> > > > >     and some to DPDK
> > > > >   - there is only very limited support for rte_flow; that is with
> > > failsafe
> > > > > PMD
> > > > >     (not netvsc PMD) and the limitations are that the emulation
> of
> > > rte_flow
> > > > >     in the TAP device only supports a few things.
> > > > >
> > > >
> > > > Thanks Stephen, the above information was very instructive.
> > > > If I do use the Netvsc PMD with the latest DPDK, will my DPDK app
> get the
> > > > non IP packets like ARP, please confirm.
> > > > I quickly tried the Netvsc PMD but don't seem to be getting the ARP
> > > packets
> > > > in still.
> > > > When you mention "The failsafe PMD is what is exposed for application
> > > > usage", what is the meaning of this, are the apps expected to use
> > > failsafe
> > > > PMD, please suggest.
> > > >
> > > > Regards
> > > > -Prashant
> > >
> > > ARP handled differently in virtual network environments. The ARP
> packets
> > > sent
> > > get consumed and replied to by the network infrastructure (in all
> virtual
> > > networks
> > > not just Azure). Non-IP packets always show up on the synthetic VMBus
> > > device.
> > >
> > > Current docs are here:
> > >
> > >
> https://learn.microsoft.com/en-us/azure/virtual-network/setup-dpdk?tabs=redhat
> > >
> > > See vdev_netvsc for picture.
> > > https://doc.dpdk.org/guides/nics/vdev_netvsc.html
> > >
> > >
> > > Thanks again Stephen. I finally was able to run the netvsc pmd and it
> is
> > detecting the ports.
> > However, for every accelerated networking interface of Azure, it detects
> > 'two' ports. This is presumably for controlling both the slow and fast
> path
> > ?
> > This poses an issue for my app as it wanted to see only 'one' interface
> in
> > its control as a lot of business logic is kind of tied to it.
> > So a question -- am I observing correctly that DPDK, in case of netvsc,
> > will enumerate two ports for each accelerated networking interface ?
> >
> > Regards
> > -Prashant
>
> The hidden VF interfaces are "owned" in DPDK.
> If you use the standard API's in ethdev it will skip the owned interfaces.
>
> /**
>  * Macro to iterate over all enabled and ownerless ethdev ports.
>  */
> #define RTE_ETH_FOREACH_DEV(p) \
>         RTE_ETH_FOREACH_DEV_OWNED_BY(p, RTE_ETH_DEV_NO_OWNER)
>
>
It seems that the owner is updated at the port only after the port is
'started' -- wanted to confirm if I should go through the normal motions of
rte_eth_dev_configure, rte_eth_rx_queue_setup, rte_eth_tx_queue_setup,
rte_eth_dev_start
for 'both' the ports and after the link is detected (and the owner is set
by DPDK), do I iterate like you have suggested, and call the tx/rx burst
api's only on the non-owned port numbers for I/O.

--0000000000002084fd06346406a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 30 Apr 2025 =
at 22:21, Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.or=
g" target=3D"_blank">stephen@networkplumber.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 30 Apr 2025 22:00:29=
 +0530<br>
Prashant Upadhyaya &lt;<a href=3D"mailto:praupadhyaya@gmail.com" target=3D"=
_blank">praupadhyaya@gmail.com</a>&gt; wrote:<br>
<br>
&gt; On Wed, 30 Apr 2025 at 19:58, Stephen Hemminger &lt;<a href=3D"mailto:=
stephen@networkplumber.org" target=3D"_blank">stephen@networkplumber.org</a=
>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Wed, 30 Apr 2025 13:00:53 +0530<br>
&gt; &gt; Prashant Upadhyaya &lt;<a href=3D"mailto:praupadhyaya@gmail.com" =
target=3D"_blank">praupadhyaya@gmail.com</a>&gt; wrote:<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; &gt; With DPDK on Azure, an application should never use the=
 VF directly.<br>
&gt; &gt; &gt; &gt; It needs to use either netvsc PMD which handles both th=
e vmbus (slow=C2=A0 <br>
&gt; &gt; path)=C2=A0 <br>
&gt; &gt; &gt; &gt; and VF (fast path) combined. Or use the older vdev_netv=
sc/failsafe/tap<br>
&gt; &gt; &gt; &gt; combination.<br>
&gt; &gt; &gt; &gt; The latter uses a virtual device to make a failsafe PMD=
 which then does<br>
&gt; &gt; &gt; &gt; a combination of TAP (via kernel slow path) and MLX5 VF=
.=C2=A0 The failsafe=C2=A0 <br>
&gt; &gt; PMD=C2=A0 <br>
&gt; &gt; &gt; &gt; is what is exposed for application usage.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The limitations are not explicitly mentioned in the doc=
umentation but:<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0- don&#39;t use VF directly in application<=
br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0- there is no support for bifurcation where=
 some packets go to kernel<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0and some to DPDK<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0- there is only very limited support for rt=
e_flow; that is with=C2=A0 <br>
&gt; &gt; failsafe=C2=A0 <br>
&gt; &gt; &gt; &gt; PMD<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0(not netvsc PMD) and the limitations=
 are that the emulation of=C2=A0 <br>
&gt; &gt; rte_flow=C2=A0 <br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0in the TAP device only supports a fe=
w things.<br>
&gt; &gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks Stephen, the above information was very instructive.<=
br>
&gt; &gt; &gt; If I do use the Netvsc PMD with the latest DPDK, will my DPD=
K app get the<br>
&gt; &gt; &gt; non IP packets like ARP, please confirm.<br>
&gt; &gt; &gt; I quickly tried the Netvsc PMD but don&#39;t seem to be gett=
ing the ARP=C2=A0 <br>
&gt; &gt; packets=C2=A0 <br>
&gt; &gt; &gt; in still.<br>
&gt; &gt; &gt; When you mention &quot;The failsafe PMD is what is exposed f=
or application<br>
&gt; &gt; &gt; usage&quot;, what is the meaning of this, are the apps expec=
ted to use=C2=A0 <br>
&gt; &gt; failsafe=C2=A0 <br>
&gt; &gt; &gt; PMD, please suggest.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards<br>
&gt; &gt; &gt; -Prashant=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt; ARP handled differently in virtual network environments. The ARP =
packets<br>
&gt; &gt; sent<br>
&gt; &gt; get consumed and replied to by the network infrastructure (in all=
 virtual<br>
&gt; &gt; networks<br>
&gt; &gt; not just Azure). Non-IP packets always show up on the synthetic V=
MBus<br>
&gt; &gt; device.<br>
&gt; &gt;<br>
&gt; &gt; Current docs are here:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://learn.microsoft.com/en-us/azure/virtual-networ=
k/setup-dpdk?tabs=3Dredhat" rel=3D"noreferrer" target=3D"_blank">https://le=
arn.microsoft.com/en-us/azure/virtual-network/setup-dpdk?tabs=3Dredhat</a><=
br>
&gt; &gt;<br>
&gt; &gt; See vdev_netvsc for picture.<br>
&gt; &gt; <a href=3D"https://doc.dpdk.org/guides/nics/vdev_netvsc.html" rel=
=3D"noreferrer" target=3D"_blank">https://doc.dpdk.org/guides/nics/vdev_net=
vsc.html</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks again Stephen. I finally was able to run the netvsc pmd an=
d it is=C2=A0 <br>
&gt; detecting the ports.<br>
&gt; However, for every accelerated networking interface of Azure, it detec=
ts<br>
&gt; &#39;two&#39; ports. This is presumably for controlling both the slow =
and fast path<br>
&gt; ?<br>
&gt; This poses an issue for my app as it wanted to see only &#39;one&#39; =
interface in<br>
&gt; its control as a lot of business logic is kind of tied to it.<br>
&gt; So a question -- am I observing correctly that DPDK, in case of netvsc=
,<br>
&gt; will enumerate two ports for each accelerated networking interface ?<b=
r>
&gt; <br>
&gt; Regards<br>
&gt; -Prashant<br>
<br>
The hidden VF interfaces are &quot;owned&quot; in DPDK.<br>
If you use the standard API&#39;s in ethdev it will skip the owned interfac=
es.<br>
<br>
/**<br>
=C2=A0* Macro to iterate over all enabled and ownerless ethdev ports.<br>
=C2=A0*/<br>
#define RTE_ETH_FOREACH_DEV(p) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_FOREACH_DEV_OWNED_BY(p, RTE_ETH_DEV_NO_=
OWNER)<br>
<br></blockquote><div><br></div><div>It seems that the owner is updated at =
the port only after the port is &#39;started&#39; -- wanted to confirm if I=
 should go through the normal motions of rte_eth_dev_configure,=C2=A0rte_et=
h_rx_queue_setup,=C2=A0rte_eth_tx_queue_setup,=C2=A0rte_eth_dev_start for &=
#39;both&#39; the ports and after the link is detected (and the owner is se=
t by DPDK), do I iterate like you have suggested, and call the tx/rx burst =
api&#39;s only on the non-owned port numbers for I/O.</div><div><br></div><=
/div></div>
</div>

--0000000000002084fd06346406a3--
