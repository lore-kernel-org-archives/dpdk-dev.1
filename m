Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA6CC369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 16:15:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F978402A3;
	Tue, 29 Apr 2025 18:15:52 +0200 (CEST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 20F0440277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 18:15:50 +0200 (CEST)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-acb5cf13996so85173766b.1
 for <dev@dpdk.org>; Tue, 29 Apr 2025 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745943349; x=1746548149; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TfjUJDiyEbv79smmZdpzErOuCOe+NQILYIzwXVuAaO0=;
 b=j4unquYoh3flhQTEeWWB7cjQuDJcRGrLv82PmhTPoIlsHIOYYg8fnX/Gzm8YFMOpY1
 mBVLPb3UvO6ykxvVONGW2o4v9ojQh1oJ0mAyWGkXfBToaIfF03WxMuCWY6/1eZH+JgIZ
 zOG2E3ayyQVddLuUBQuGFaQWQlhBHGENieguLdIpYUjr1owKaFk0aN/2jNNrTqdkeplO
 RDGrkFHvXtkMhvd2YPg4fVYS895Pa18T/Ht4N1LEPef/YwLjp94WKf1H5BIyNBIiik7w
 y77KHSSdzHs3xkG493dck3s3W3cYKoOwrhPYsgiCjEIxd6hL9VHsWniZG4+ZR2RjHQ4P
 3fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745943349; x=1746548149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TfjUJDiyEbv79smmZdpzErOuCOe+NQILYIzwXVuAaO0=;
 b=rT2u1cDj7xObjTRrDObx4sFPrl1ojHtWXAxFa1gZGXJwbaAqK7ITLnobCQtXawTv26
 0njgAHvg8+cYbKYfTfGWckdSiNdMG9+Mqrl0WB10eRTQUg9SP8AS0ekzRPg5HxDq+BdU
 s5PvpYRiJjdt0dvQtU42pHLj1+tdLMRQkd1XtFL6TA3oJgXuXAC5Y6/IlylJaI+QWMNC
 ofXdeYK2Ad1AghwDw+/mZ8INWKCADFdmawGOMLY5NUlzj2Voh7HHvV7fodukRuAnZcwh
 n8wbOHtiRFuNMMhOV2XDhi9rmJqyr1yXrunPbGjjBJmxQsbm1D46c7EntJBs4SgxLqGO
 OxxQ==
X-Gm-Message-State: AOJu0YxOFCGbSl39YLHXKqxKkDacBaE0ArFfPxe6vnR08cQmmB1m0ktg
 sgOuqri629MZluWH2XcWcVbD+DxWL/kpcIE7xtmOloFMc7OmGpX+TVCRKTsTVrWaM9c9d4xvaF/
 1MHl6CiI77ltWwwAdKcZY/Y009mH65Z33
X-Gm-Gg: ASbGncvfmtsiC9ZYmCUugN6d4yQAsKKCWJJDXHxE4MklSRVvi1om+JZEb9hLLw2Q7+h
 nttH1ujDPyc+kL0tMD+YaVbspruNtEBiVMzDUpPm5IT+uBwibkTt6cGwTyhNJE3wPcqpJFQvuUJ
 EMWSDt++PLDVAck4O7uCmJ7HAN+ugrvMghV6Y/lkfgqkW0hFSCowYCZNUNV/Wa0xgPYbE=
X-Google-Smtp-Source: AGHT+IEBqFArzq6LuUGHzu/2nTXQ5HXUJ9UVLtPPcl89JzsFIo4ogxrVx4syHfJJ0bqmtmfS0XzGwAglDo8nSIciYvE=
X-Received: by 2002:a17:907:7e9a:b0:ac6:c179:1446 with SMTP id
 a640c23a62f3a-ace71038c8emr561687466b.2.1745943349354; Tue, 29 Apr 2025
 09:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
 <20250426082843.736964ba@hermes.local>
 <CAPBAu3WOq6_77mBvd=B8x2tso9hWpjFTyUuEeJgZazSm_y_GHQ@mail.gmail.com>
 <20250428083712.50b2e7ce@hermes.local>
In-Reply-To: <20250428083712.50b2e7ce@hermes.local>
From: Prashant Upadhyaya <praupadhyaya@gmail.com>
Date: Tue, 29 Apr 2025 21:45:36 +0530
X-Gm-Features: ATxdqUHmpMnwA8bSxtGKV-hxAUgtip9exO2Xb34LHVrBTuGMGHhld5gviOl7pu0
Message-ID: <CAPBAu3UDao48OmcnEMQw9-W3pesM1W2ftQsEG3EtHDxxOXCc=Q@mail.gmail.com>
Subject: Re: Regarding Mellanox bifurcated driver on Azure
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000022e8b40633ed1d3a"
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

--00000000000022e8b40633ed1d3a
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Apr 2025 at 21:07, Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Mon, 28 Apr 2025 11:31:10 +0530
> Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
>
> > On Sat, 26 Apr 2025 at 20:58, Stephen Hemminger <
> stephen@networkplumber.org>
> > wrote:
> >
> > > On Fri, 25 Apr 2025 23:17:30 +0530
> > > Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
> > >
> > > > Hi,
> > > >
> > > > I am having a VM on Azure where I have got two 'accelerated
> networking'
> > > > interfaces of Mellanox
> > > > # lspci -nn|grep -i ether
> > > > 6561:00:02.0 Ethernet controller [0200]: Mellanox Technologies
> MT27710
> > > > Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> > > > f08c:00:02.0 Ethernet controller [0200]: Mellanox Technologies
> MT27710
> > > > Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> > > >
> > > > I have a DPDK application which needs to obtain 'all' packets from
> the
> > > NIC.
> > > > I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), my app
> starts
> > > > and is able to detect the NIC's.
> > > > Everything looks good
> > > > myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0
> > > > EAL: Detected CPU lcores: 8
> > > > EAL: Detected NUMA nodes: 1
> > > > EAL: Detected shared linkage of DPDK
> > > > EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> > > > EAL: Selected IOVA mode 'PA'
> > > > EAL: VFIO support initialized
> > > > mlx5_net: Default miss action is not supported.
> > > > mlx5_net: Default miss action is not supported.
> > > > All Ports initialized
> > > > Port 0 is UP (50000 Mbps)
> > > > Port 1 is UP (50000 Mbps)
> > > >
> > > > The trouble is that the ARP packets are not being picked up by my
> DPDK
> > > > application, I see them being delivered to the kernel via the eth
> > > interface
> > > > corresponding to the port (MLX is a bifurcated driver, you don't
> really
> > > > bind to the NIC, so you still see the eth interfaces at linux level
> and
> > > can
> > > > run tcpdump on those, I see ARP packets in the tcpdump there on the
> > > > interface)
> > > > I can receive UDP packets in my DPDK app though.
> > > >
> > > > My application is not setting any rte_flow rules etc. so I was
> expecting
> > > > that by default my dpdk app would get all the packets as is normally
> the
> > > > case with other NIC's
> > > > Is there something I need to configure for Mellanox NIC somewhere
> such
> > > that
> > > > I get 'all' the packets including ARP packets in my DPDK app ?
> > > >
> > > > Regards
> > > > -Prashant
> > >
> > > The Mellanox device in Azure networking cards is only used as a VF
> switch.
> > > You can go back to earlier DPDK presentations for more detail.
> > >
> > > Three reason bifurcation won't work.
> > >  1. Only some of the packets arrive on the VF. All non-IP show up on
> > >     the synthetic device. The VF is only used after the TCP three way
> > >     handshake.
> > >  2. The Netvsc PMD doesn't handle flow rules.
> > >  3. The VF can be removed and restored any time (by hypervisor)
> > >     it is not a stable entity.
> > >
> > >
> >  Thanks Stephen, so are we concluding that DPDK apps are unusable in
> Azure
> > as per my requirements, is there no work around or any other possibility
> to
> > use DPDK in Azure VM ? Please do send me a link to the correct
> presentation
> > I should refer to.
> >
> > Regards
> > -Prashant
>
> Remember in the cloud network interfaces are free, there really is no need
> for bifurication just create two interfaces to VM, one for DPDK, and one
> for
> non DPDK.
>

I am afraid Stephen, I am not entirely clear about your suggestion.
When I create an Accelerated Networking interface on Azure (with the
intention of my DPDK app fully controlling it), it is automatically giving
one eth interface (representing slowpath) and one enp interface (presumably
the fast path and which my dpdk app detects and operates upon). It is this
pair that is created automatically for a single packet interface by Azure.
The trouble is the above bifurcation because I don't get to see all the
packets from the NIC on DPDK controlled interface -- my DPDK app wants to
see all the packets.

Regards
-Prashant

--00000000000022e8b40633ed1d3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 28 Apr =
2025 at 21:07, Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumb=
er.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Mon, 28 Apr 2025 11:31:10 +0530<br>
Prashant Upadhyaya &lt;<a href=3D"mailto:praupadhyaya@gmail.com" target=3D"=
_blank">praupadhyaya@gmail.com</a>&gt; wrote:<br>
<br>
&gt; On Sat, 26 Apr 2025 at 20:58, Stephen Hemminger &lt;<a href=3D"mailto:=
stephen@networkplumber.org" target=3D"_blank">stephen@networkplumber.org</a=
>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Fri, 25 Apr 2025 23:17:30 +0530<br>
&gt; &gt; Prashant Upadhyaya &lt;<a href=3D"mailto:praupadhyaya@gmail.com" =
target=3D"_blank">praupadhyaya@gmail.com</a>&gt; wrote:<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I am having a VM on Azure where I have got two &#39;accelera=
ted networking&#39;<br>
&gt; &gt; &gt; interfaces of Mellanox<br>
&gt; &gt; &gt; # lspci -nn|grep -i ether<br>
&gt; &gt; &gt; 6561:00:02.0 Ethernet controller [0200]: Mellanox Technologi=
es MT27710<br>
&gt; &gt; &gt; Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)=
<br>
&gt; &gt; &gt; f08c:00:02.0 Ethernet controller [0200]: Mellanox Technologi=
es MT27710<br>
&gt; &gt; &gt; Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I have a DPDK application which needs to obtain &#39;all&#39=
; packets from the=C2=A0 <br>
&gt; &gt; NIC.=C2=A0 <br>
&gt; &gt; &gt; I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), m=
y app starts<br>
&gt; &gt; &gt; and is able to detect the NIC&#39;s.<br>
&gt; &gt; &gt; Everything looks good<br>
&gt; &gt; &gt; myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0<br>
&gt; &gt; &gt; EAL: Detected CPU lcores: 8<br>
&gt; &gt; &gt; EAL: Detected NUMA nodes: 1<br>
&gt; &gt; &gt; EAL: Detected shared linkage of DPDK<br>
&gt; &gt; &gt; EAL: Multi-process socket /var/run/dpdk/rte/mp_socket<br>
&gt; &gt; &gt; EAL: Selected IOVA mode &#39;PA&#39;<br>
&gt; &gt; &gt; EAL: VFIO support initialized<br>
&gt; &gt; &gt; mlx5_net: Default miss action is not supported.<br>
&gt; &gt; &gt; mlx5_net: Default miss action is not supported.<br>
&gt; &gt; &gt; All Ports initialized<br>
&gt; &gt; &gt; Port 0 is UP (50000 Mbps)<br>
&gt; &gt; &gt; Port 1 is UP (50000 Mbps)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The trouble is that the ARP packets are not being picked up =
by my DPDK<br>
&gt; &gt; &gt; application, I see them being delivered to the kernel via th=
e eth=C2=A0 <br>
&gt; &gt; interface=C2=A0 <br>
&gt; &gt; &gt; corresponding to the port (MLX is a bifurcated driver, you d=
on&#39;t really<br>
&gt; &gt; &gt; bind to the NIC, so you still see the eth interfaces at linu=
x level and=C2=A0 <br>
&gt; &gt; can=C2=A0 <br>
&gt; &gt; &gt; run tcpdump on those, I see ARP packets in the tcpdump there=
 on the<br>
&gt; &gt; &gt; interface)<br>
&gt; &gt; &gt; I can receive UDP packets in my DPDK app though.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; My application is not setting any rte_flow rules etc. so I w=
as expecting<br>
&gt; &gt; &gt; that by default my dpdk app would get all the packets as is =
normally the<br>
&gt; &gt; &gt; case with other NIC&#39;s<br>
&gt; &gt; &gt; Is there something I need to configure for Mellanox NIC some=
where such=C2=A0 <br>
&gt; &gt; that=C2=A0 <br>
&gt; &gt; &gt; I get &#39;all&#39; the packets including ARP packets in my =
DPDK app ?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards<br>
&gt; &gt; &gt; -Prashant=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt; The Mellanox device in Azure networking cards is only used as a V=
F switch.<br>
&gt; &gt; You can go back to earlier DPDK presentations for more detail.<br=
>
&gt; &gt;<br>
&gt; &gt; Three reason bifurcation won&#39;t work.<br>
&gt; &gt;=C2=A0 1. Only some of the packets arrive on the VF. All non-IP sh=
ow up on<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0the synthetic device. The VF is only used afte=
r the TCP three way<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0handshake.<br>
&gt; &gt;=C2=A0 2. The Netvsc PMD doesn&#39;t handle flow rules.<br>
&gt; &gt;=C2=A0 3. The VF can be removed and restored any time (by hypervis=
or)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0it is not a stable entity.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 <br>
&gt;=C2=A0 Thanks Stephen, so are we concluding that DPDK apps are unusable=
 in Azure<br>
&gt; as per my requirements, is there no work around or any other possibili=
ty to<br>
&gt; use DPDK in Azure VM ? Please do send me a link to the correct present=
ation<br>
&gt; I should refer to.<br>
&gt; <br>
&gt; Regards<br>
&gt; -Prashant<br>
<br>
Remember in the cloud network interfaces are free, there really is no need<=
br>
for bifurication just create two interfaces to VM, one for DPDK, and one fo=
r<br>
non DPDK.<br></blockquote><div><br></div><div>I am afraid Stephen, I am not=
 entirely clear about your suggestion.</div><div>When I create an Accelerat=
ed Networking interface on Azure (with the intention of my DPDK app fully c=
ontrolling it), it is automatically giving one eth interface (representing =
slowpath) and one enp interface (presumably the fast path and which my dpdk=
 app detects and operates upon). It is this pair that is created automatica=
lly for a single packet interface by Azure.</div><div>The trouble is the ab=
ove bifurcation because I don&#39;t get to see all the packets from the NIC=
 on DPDK controlled interface -- my DPDK app wants to see all the packets.<=
/div><div><br></div><div>Regards</div><div>-Prashant</div><div><br></div><d=
iv><br></div><div>=C2=A0</div></div></div>

--00000000000022e8b40633ed1d3a--
