Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F95C3ABA9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 07:31:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8532E402A3;
	Wed, 30 Apr 2025 09:31:08 +0200 (CEST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id C0BC54026C
 for <dev@dpdk.org>; Wed, 30 Apr 2025 09:31:07 +0200 (CEST)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-acb94bf784aso88498266b.0
 for <dev@dpdk.org>; Wed, 30 Apr 2025 00:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745998267; x=1746603067; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yxK5hm/dtKyWjbpfb14JMDQjy+pkONDCifED5p3k0m8=;
 b=ZLMmugEpTBlR3S9o+LI8V2eFZbXFfZyLvawNKl04MqjBq6hyciYscVxePHAH9dBjqG
 oC6NXk7FGP/wq5sdyl80q6I4DJnFgeGohsWw+GkvyqO1xNvFL0a1mrJmOef/dyOOwPfC
 o/7xNM9TaWyBg/kxyNJyfC3DzHe5/pQ+Bk/zjdrpP6NwsUIRF48PFVlE8hXpI55D658/
 vY3S9rGp2obb62B8QDo8LQv3HZaALpq+tzoOiBiSKLRSJGd/HW0u+52rsuwUwtHPvRME
 bE9pt3jbjgVtfpRQqOlPFq6V/+MmeQwiwcQvl1uTcZworQYAaKhXTuA/YHYpzmvYKl7q
 5kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745998267; x=1746603067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yxK5hm/dtKyWjbpfb14JMDQjy+pkONDCifED5p3k0m8=;
 b=kWsIahaxFcuYpI+mKqrtnpluRXF87HKGvNvlnojdlaxg984eHL46uDNHk9Lhz96SdX
 9vVRLGwbtc5zwNTz+0FuRC/jvz9g8bnDsrTQiOerI4SpgR8qLaxysf5fW6JP6/n59Pce
 K9UAM84uaRYap1JNAmthPBXDd0Dzz+nzTI9aFsapUucHc2GVqwOP4qmIEOM8ApbROOVV
 03cRUwHrVhWXoq8/IOEW5MGKMAhBlYE97UjIiFFEJVRFJhmgBjJ7cEuukGgqMZ/2EnPJ
 S0fCJVUaRPBT4Ka3NOOG5P/6MPOTvezdvwZJKuz4xapyvQ/+jVgtrv02FqCb67ZFvnbJ
 rifQ==
X-Gm-Message-State: AOJu0Yyj751DZ91aKioLHFbIZtQnNkFQEg17FGeh2TVOzab3sH++WAkP
 aBHsh3aLFjTXthHA5CnzkoMFYYmnYzlSpI3cCg0vpuoMcuw8WFmj9/9H2pijfsn62e7TaNHBibK
 rpRb4+cuF7e0HyUbpu4Lzy38yzAxITyco
X-Gm-Gg: ASbGncssHUifWxPnYdrGxSXodj6y5S9L8YChoBjlad3UVyDh/Lwys/KCBIFHX/QoRWU
 6gBh4wg28IfTyHZm6IZCN9TmH03oktUEdCkJvJFgJEszUDptKgguQ32JFJ5z3lqIfaeJfi6fHlU
 rcLzK43gmJs+FlFKNrwE6TNig=
X-Google-Smtp-Source: AGHT+IGIdpSmbaG2ttS0xpQ+x8C2hwdEluOWNRsXz3L6EsJTulTcd1Zc2voZIa/kg+YBL/d3vu+qFTvOZQ7GtTqbBhk=
X-Received: by 2002:a17:907:2da4:b0:acb:6337:4923 with SMTP id
 a640c23a62f3a-acee25ce245mr51422266b.11.1745998267010; Wed, 30 Apr 2025
 00:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
 <20250426082843.736964ba@hermes.local>
 <CAPBAu3WOq6_77mBvd=B8x2tso9hWpjFTyUuEeJgZazSm_y_GHQ@mail.gmail.com>
 <20250428083712.50b2e7ce@hermes.local>
 <CAPBAu3UDao48OmcnEMQw9-W3pesM1W2ftQsEG3EtHDxxOXCc=Q@mail.gmail.com>
 <20250429092415.2a37c090@hermes.local>
In-Reply-To: <20250429092415.2a37c090@hermes.local>
From: Prashant Upadhyaya <praupadhyaya@gmail.com>
Date: Wed, 30 Apr 2025 13:00:53 +0530
X-Gm-Features: ATxdqUF_fX9q6K9DpjoQCD7rluhNX9DifrUPg3HIOGP3BrY74rGb-_zIjnmmECA
Message-ID: <CAPBAu3XDwr82ghjdhK=QXO53OPH3MgUtkP7r3TLEwOnHe_St5w@mail.gmail.com>
Subject: Re: Regarding Mellanox bifurcated driver on Azure
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000007bd3670633f9e635"
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

--0000000000007bd3670633f9e635
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Apr 2025 at 21:54, Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Tue, 29 Apr 2025 21:45:36 +0530
> Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
>
> > On Mon, 28 Apr 2025 at 21:07, Stephen Hemminger <
> stephen@networkplumber.org>
> > wrote:
> >
> > > On Mon, 28 Apr 2025 11:31:10 +0530
> > > Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
> > >
> > > > On Sat, 26 Apr 2025 at 20:58, Stephen Hemminger <
> > > stephen@networkplumber.org>
> > > > wrote:
> > > >
> > > > > On Fri, 25 Apr 2025 23:17:30 +0530
> > > > > Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
> > > > >
> > > > > > Hi,
> > > > > >
> > > > > > I am having a VM on Azure where I have got two 'accelerated
> > > networking'
> > > > > > interfaces of Mellanox
> > > > > > # lspci -nn|grep -i ether
> > > > > > 6561:00:02.0 Ethernet controller [0200]: Mellanox Technologies
> > > MT27710
> > > > > > Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> > > > > > f08c:00:02.0 Ethernet controller [0200]: Mellanox Technologies
> > > MT27710
> > > > > > Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> > > > > >
> > > > > > I have a DPDK application which needs to obtain 'all' packets
> from
> > > the
> > > > > NIC.
> > > > > > I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), my
> app
> > > starts
> > > > > > and is able to detect the NIC's.
> > > > > > Everything looks good
> > > > > > myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0
> > > > > > EAL: Detected CPU lcores: 8
> > > > > > EAL: Detected NUMA nodes: 1
> > > > > > EAL: Detected shared linkage of DPDK
> > > > > > EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> > > > > > EAL: Selected IOVA mode 'PA'
> > > > > > EAL: VFIO support initialized
> > > > > > mlx5_net: Default miss action is not supported.
> > > > > > mlx5_net: Default miss action is not supported.
> > > > > > All Ports initialized
> > > > > > Port 0 is UP (50000 Mbps)
> > > > > > Port 1 is UP (50000 Mbps)
> > > > > >
> > > > > > The trouble is that the ARP packets are not being picked up by
> my
> > > DPDK
> > > > > > application, I see them being delivered to the kernel via the
> eth
> > > > > interface
> > > > > > corresponding to the port (MLX is a bifurcated driver, you
> don't
> > > really
> > > > > > bind to the NIC, so you still see the eth interfaces at linux
> level
> > > and
> > > > > can
> > > > > > run tcpdump on those, I see ARP packets in the tcpdump there on
> the
> > > > > > interface)
> > > > > > I can receive UDP packets in my DPDK app though.
> > > > > >
> > > > > > My application is not setting any rte_flow rules etc. so I was
> > > expecting
> > > > > > that by default my dpdk app would get all the packets as is
> normally
> > > the
> > > > > > case with other NIC's
> > > > > > Is there something I need to configure for Mellanox NIC
> somewhere
> > > such
> > > > > that
> > > > > > I get 'all' the packets including ARP packets in my DPDK app ?
> > > > > >
> > > > > > Regards
> > > > > > -Prashant
> > > > >
> > > > > The Mellanox device in Azure networking cards is only used as a
> VF
> > > switch.
> > > > > You can go back to earlier DPDK presentations for more detail.
> > > > >
> > > > > Three reason bifurcation won't work.
> > > > >  1. Only some of the packets arrive on the VF. All non-IP show up
> on
> > > > >     the synthetic device. The VF is only used after the TCP three
> way
> > > > >     handshake.
> > > > >  2. The Netvsc PMD doesn't handle flow rules.
> > > > >  3. The VF can be removed and restored any time (by hypervisor)
> > > > >     it is not a stable entity.
> > > > >
> > > > >
> > > >  Thanks Stephen, so are we concluding that DPDK apps are unusable
> in
> > > Azure
> > > > as per my requirements, is there no work around or any other
> possibility
> > > to
> > > > use DPDK in Azure VM ? Please do send me a link to the correct
> > > presentation
> > > > I should refer to.
> > > >
> > > > Regards
> > > > -Prashant
> > >
> > > Remember in the cloud network interfaces are free, there really is no
> need
> > > for bifurication just create two interfaces to VM, one for DPDK, and
> one
> > > for
> > > non DPDK.
> > >
> >
> > I am afraid Stephen, I am not entirely clear about your suggestion.
> > When I create an Accelerated Networking interface on Azure (with the
> > intention of my DPDK app fully controlling it), it is automatically
> giving
> > one eth interface (representing slowpath) and one enp interface
> (presumably
> > the fast path and which my dpdk app detects and operates upon). It is
> this
> > pair that is created automatically for a single packet interface by
> Azure.
> > The trouble is the above bifurcation because I don't get to see all the
> > packets from the NIC on DPDK controlled interface -- my DPDK app wants to
> > see all the packets.
> >
> > Regards
> > -Prashant
>
> With DPDK on Azure, an application should never use the VF directly.
> It needs to use either netvsc PMD which handles both the vmbus (slow path)
> and VF (fast path) combined. Or use the older vdev_netvsc/failsafe/tap
> combination.
> The latter uses a virtual device to make a failsafe PMD which then does
> a combination of TAP (via kernel slow path) and MLX5 VF.  The failsafe PMD
> is what is exposed for application usage.
>
> The limitations are not explicitly mentioned in the documentation but:
>   - don't use VF directly in application
>   - there is no support for bifurcation where some packets go to kernel
>     and some to DPDK
>   - there is only very limited support for rte_flow; that is with failsafe
> PMD
>     (not netvsc PMD) and the limitations are that the emulation of rte_flow
>     in the TAP device only supports a few things.
>

Thanks Stephen, the above information was very instructive.
If I do use the Netvsc PMD with the latest DPDK, will my DPDK app get the
non IP packets like ARP, please confirm.
I quickly tried the Netvsc PMD but don't seem to be getting the ARP packets
in still.
When you mention "The failsafe PMD is what is exposed for application
usage", what is the meaning of this, are the apps expected to use failsafe
PMD, please suggest.

Regards
-Prashant

--0000000000007bd3670633f9e635
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 29 Apr =
2025 at 21:54, Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumb=
er.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Tue, 29 Apr 2025 21:45:36 +0530<br>
Prashant Upadhyaya &lt;<a href=3D"mailto:praupadhyaya@gmail.com" target=3D"=
_blank">praupadhyaya@gmail.com</a>&gt; wrote:<br>
<br>
&gt; On Mon, 28 Apr 2025 at 21:07, Stephen Hemminger &lt;<a href=3D"mailto:=
stephen@networkplumber.org" target=3D"_blank">stephen@networkplumber.org</a=
>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, 28 Apr 2025 11:31:10 +0530<br>
&gt; &gt; Prashant Upadhyaya &lt;<a href=3D"mailto:praupadhyaya@gmail.com" =
target=3D"_blank">praupadhyaya@gmail.com</a>&gt; wrote:<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; On Sat, 26 Apr 2025 at 20:58, Stephen Hemminger &lt;<br>
&gt; &gt; <a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank">s=
tephen@networkplumber.org</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; &gt; On Fri, 25 Apr 2025 23:17:30 +0530<br>
&gt; &gt; &gt; &gt; Prashant Upadhyaya &lt;<a href=3D"mailto:praupadhyaya@g=
mail.com" target=3D"_blank">praupadhyaya@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I am having a VM on Azure where I have got two &#3=
9;accelerated=C2=A0 <br>
&gt; &gt; networking&#39;=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; interfaces of Mellanox<br>
&gt; &gt; &gt; &gt; &gt; # lspci -nn|grep -i ether<br>
&gt; &gt; &gt; &gt; &gt; 6561:00:02.0 Ethernet controller [0200]: Mellanox =
Technologies=C2=A0 <br>
&gt; &gt; MT27710=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; Family [ConnectX-4 Lx Virtual Function] [15b3:1016=
] (rev 80)<br>
&gt; &gt; &gt; &gt; &gt; f08c:00:02.0 Ethernet controller [0200]: Mellanox =
Technologies=C2=A0 <br>
&gt; &gt; MT27710=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; Family [ConnectX-4 Lx Virtual Function] [15b3:1016=
] (rev 80)<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I have a DPDK application which needs to obtain &#=
39;all&#39; packets from=C2=A0 <br>
&gt; &gt; the=C2=A0 <br>
&gt; &gt; &gt; &gt; NIC.=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; I installed the drivers, compiled DPDK24.11 (Ubunt=
u20.04), my app=C2=A0 <br>
&gt; &gt; starts=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; and is able to detect the NIC&#39;s.<br>
&gt; &gt; &gt; &gt; &gt; Everything looks good<br>
&gt; &gt; &gt; &gt; &gt; myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0<=
br>
&gt; &gt; &gt; &gt; &gt; EAL: Detected CPU lcores: 8<br>
&gt; &gt; &gt; &gt; &gt; EAL: Detected NUMA nodes: 1<br>
&gt; &gt; &gt; &gt; &gt; EAL: Detected shared linkage of DPDK<br>
&gt; &gt; &gt; &gt; &gt; EAL: Multi-process socket /var/run/dpdk/rte/mp_soc=
ket<br>
&gt; &gt; &gt; &gt; &gt; EAL: Selected IOVA mode &#39;PA&#39;<br>
&gt; &gt; &gt; &gt; &gt; EAL: VFIO support initialized<br>
&gt; &gt; &gt; &gt; &gt; mlx5_net: Default miss action is not supported.<br=
>
&gt; &gt; &gt; &gt; &gt; mlx5_net: Default miss action is not supported.<br=
>
&gt; &gt; &gt; &gt; &gt; All Ports initialized<br>
&gt; &gt; &gt; &gt; &gt; Port 0 is UP (50000 Mbps)<br>
&gt; &gt; &gt; &gt; &gt; Port 1 is UP (50000 Mbps)<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; The trouble is that the ARP packets are not being =
picked up by my=C2=A0 <br>
&gt; &gt; DPDK=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; application, I see them being delivered to the ker=
nel via the eth=C2=A0 <br>
&gt; &gt; &gt; &gt; interface=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; corresponding to the port (MLX is a bifurcated dri=
ver, you don&#39;t=C2=A0 <br>
&gt; &gt; really=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; bind to the NIC, so you still see the eth interfac=
es at linux level=C2=A0 <br>
&gt; &gt; and=C2=A0 <br>
&gt; &gt; &gt; &gt; can=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; run tcpdump on those, I see ARP packets in the tcp=
dump there on the<br>
&gt; &gt; &gt; &gt; &gt; interface)<br>
&gt; &gt; &gt; &gt; &gt; I can receive UDP packets in my DPDK app though.<b=
r>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; My application is not setting any rte_flow rules e=
tc. so I was=C2=A0 <br>
&gt; &gt; expecting=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; that by default my dpdk app would get all the pack=
ets as is normally=C2=A0 <br>
&gt; &gt; the=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; case with other NIC&#39;s<br>
&gt; &gt; &gt; &gt; &gt; Is there something I need to configure for Mellano=
x NIC somewhere=C2=A0 <br>
&gt; &gt; such=C2=A0 <br>
&gt; &gt; &gt; &gt; that=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; I get &#39;all&#39; the packets including ARP pack=
ets in my DPDK app ?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Regards<br>
&gt; &gt; &gt; &gt; &gt; -Prashant=C2=A0 <br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The Mellanox device in Azure networking cards is only u=
sed as a VF=C2=A0 <br>
&gt; &gt; switch.=C2=A0 <br>
&gt; &gt; &gt; &gt; You can go back to earlier DPDK presentations for more =
detail.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Three reason bifurcation won&#39;t work.<br>
&gt; &gt; &gt; &gt;=C2=A0 1. Only some of the packets arrive on the VF. All=
 non-IP show up on<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0the synthetic device. The VF is only=
 used after the TCP three way<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0handshake.<br>
&gt; &gt; &gt; &gt;=C2=A0 2. The Netvsc PMD doesn&#39;t handle flow rules.<=
br>
&gt; &gt; &gt; &gt;=C2=A0 3. The VF can be removed and restored any time (b=
y hypervisor)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0it is not a stable entity.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 Thanks Stephen, so are we concluding that DPDK apps ar=
e unusable in=C2=A0 <br>
&gt; &gt; Azure=C2=A0 <br>
&gt; &gt; &gt; as per my requirements, is there no work around or any other=
 possibility=C2=A0 <br>
&gt; &gt; to=C2=A0 <br>
&gt; &gt; &gt; use DPDK in Azure VM ? Please do send me a link to the corre=
ct=C2=A0 <br>
&gt; &gt; presentation=C2=A0 <br>
&gt; &gt; &gt; I should refer to.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards<br>
&gt; &gt; &gt; -Prashant=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt; Remember in the cloud network interfaces are free, there really i=
s no need<br>
&gt; &gt; for bifurication just create two interfaces to VM, one for DPDK, =
and one<br>
&gt; &gt; for<br>
&gt; &gt; non DPDK.<br>
&gt; &gt;=C2=A0 <br>
&gt; <br>
&gt; I am afraid Stephen, I am not entirely clear about your suggestion.<br=
>
&gt; When I create an Accelerated Networking interface on Azure (with the<b=
r>
&gt; intention of my DPDK app fully controlling it), it is automatically gi=
ving<br>
&gt; one eth interface (representing slowpath) and one enp interface (presu=
mably<br>
&gt; the fast path and which my dpdk app detects and operates upon). It is =
this<br>
&gt; pair that is created automatically for a single packet interface by Az=
ure.<br>
&gt; The trouble is the above bifurcation because I don&#39;t get to see al=
l the<br>
&gt; packets from the NIC on DPDK controlled interface -- my DPDK app wants=
 to<br>
&gt; see all the packets.<br>
&gt; <br>
&gt; Regards<br>
&gt; -Prashant<br>
<br>
With DPDK on Azure, an application should never use the VF directly.<br>
It needs to use either netvsc PMD which handles both the vmbus (slow path)<=
br>
and VF (fast path) combined. Or use the older vdev_netvsc/failsafe/tap comb=
ination.<br>
The latter uses a virtual device to make a failsafe PMD which then does<br>
a combination of TAP (via kernel slow path) and MLX5 VF.=C2=A0 The failsafe=
 PMD<br>
is what is exposed for application usage.<br>
<br>
The limitations are not explicitly mentioned in the documentation but:<br>
=C2=A0 - don&#39;t use VF directly in application<br>
=C2=A0 - there is no support for bifurcation where some packets go to kerne=
l<br>
=C2=A0 =C2=A0 and some to DPDK<br>
=C2=A0 - there is only very limited support for rte_flow; that is with fail=
safe PMD<br>
=C2=A0 =C2=A0 (not netvsc PMD) and the limitations are that the emulation o=
f rte_flow<br>
=C2=A0 =C2=A0 in the TAP device only supports a few things.<br></blockquote=
><div><br></div><div>Thanks Stephen, the above information was very instruc=
tive.</div><div>If I do use the Netvsc PMD with the latest DPDK, will my DP=
DK app get the non IP packets like ARP, please confirm.</div><div>I quickly=
 tried the Netvsc PMD but don&#39;t seem to be getting the ARP packets in s=
till.</div><div>When you mention &quot;The failsafe PMD is what is exposed =
for application usage&quot;, what is the meaning of this, are the apps expe=
cted to use failsafe PMD, please suggest.</div><div><br></div><div>Regards<=
/div><div>-Prashant</div><div><br></div></div></div>

--0000000000007bd3670633f9e635--
