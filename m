Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFBDC369D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 06:01:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ABA240263;
	Mon, 28 Apr 2025 08:01:22 +0200 (CEST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id E7C464021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 08:01:20 +0200 (CEST)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-acb78975cb9so70287466b.3
 for <dev@dpdk.org>; Sun, 27 Apr 2025 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745820080; x=1746424880; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jhb0b0RAU+yU05Qgahil7J327FExmLZiWl/B9xGJ6pc=;
 b=DpYj6BVRGNV8tN0Tt4ZqNmN/Qlfnzu5fu0clDAwP7qYI9+Juh5p56Xw1vrAoV+q8Oy
 vhh3zvZKOSeJWU6vfyUdrx1fQMrjU3vAV5L6KQEispDDei3xmoSg9eIgW5FERQUIb26K
 1n0m+eP5+QWWhJswvRtioF1XDA36YztqFG7PbeYlO9Fk781oB7rM/mYwKbxuqzi8RN6T
 YfmxtAlK4nVUtqOhqyRYnkk4G92896JUZ/GNufRetPjpLiSoLjf0MbNaUvNqAMOowTrp
 AAzS+Bnva6RuR1Mkof+0Hx6Ra69xkIVR3h7YnVXgPLf+LgVWVrof1WrBiAlDMgunKLZV
 JqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745820080; x=1746424880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jhb0b0RAU+yU05Qgahil7J327FExmLZiWl/B9xGJ6pc=;
 b=qcmPXUYY/Uj+AoMWQi1hP7KVLpjfMRWFAMUV8FSUmFtS8S5qGKlzAncUd2Z3UuAOPG
 assjUyDF0LqCaMEh8Rl5q528v83ZLAVXFDYMzpNnMk2UE1vOpHVEBRHzw6DS/WYO7gD9
 egYm+g0qCWQJRmta5PS9fq1Lsg1sdtbjfgClqm+4lxmMTRV9LO7dZCiEGCALyxK3KxFh
 S+FUaWKii6t+Bp9UEvNxCboXxTiDCgp1qlZ8NA5/pKGks6TnG5q5pNEDvcA/Ty3/+P32
 zuUE4MKWeVUcI6xy8Zfsag/X9SgSBhTSqC4eHLsfEOFi0tjO07lnMS8w8g0Gtmiy/yjL
 bwRQ==
X-Gm-Message-State: AOJu0Yz3UBZ/rxUP4WZQJq5NvhjPv429x9vg37DO0FaiXr9LexepjEyE
 YnsNtGHYSS16JBMg1swgrmcuSEMbGg5q6Q0hVW4r8raG9D7uLijbgJVn5N8m8fTDA05sWxAe+GD
 +WOy3dRmVSBOyfAIjrzcK5xZqFnI=
X-Gm-Gg: ASbGncvSzBP5khmAfedGzVUIj8Yb58Wg22t2t07RYjUW4i2BW/Dse67u62v/AXPmPyP
 hmOppjjqL3eRMiIbxXk5yjDsJLknIILO7sqC+DYyTrOlmq7+aaBGjOPPOsn754rt4eTsQEIeIUu
 QOXjefj1WMGzlFOPD5OrewMWcXVx59clt+zg==
X-Google-Smtp-Source: AGHT+IHwYdGy8ojSwRihhvgqVPX5Kv7bDjW9I/C0/DG3JB/47gp9yr8IcB53ePUp8HDryO3QQqkkgHFtapRGCvon2/0=
X-Received: by 2002:a17:906:1402:b0:ace:ad8b:ab45 with SMTP id
 a640c23a62f3a-acead8bad1bmr66371066b.5.1745820080063; Sun, 27 Apr 2025
 23:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
 <20250426082843.736964ba@hermes.local>
In-Reply-To: <20250426082843.736964ba@hermes.local>
From: Prashant Upadhyaya <praupadhyaya@gmail.com>
Date: Mon, 28 Apr 2025 11:31:10 +0530
X-Gm-Features: ATxdqUHUdhNAoGdKSWTdan_p9BLU6gW9uTb8hNpA8zb-67kdCjn2WC2hRm_GCrs
Message-ID: <CAPBAu3WOq6_77mBvd=B8x2tso9hWpjFTyUuEeJgZazSm_y_GHQ@mail.gmail.com>
Subject: Re: Regarding Mellanox bifurcated driver on Azure
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b6c8620633d06964"
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

--000000000000b6c8620633d06964
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Apr 2025 at 20:58, Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Fri, 25 Apr 2025 23:17:30 +0530
> Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
>
> > Hi,
> >
> > I am having a VM on Azure where I have got two 'accelerated networking'
> > interfaces of Mellanox
> > # lspci -nn|grep -i ether
> > 6561:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710
> > Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> > f08c:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710
> > Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> >
> > I have a DPDK application which needs to obtain 'all' packets from the
> NIC.
> > I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), my app starts
> > and is able to detect the NIC's.
> > Everything looks good
> > myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0
> > EAL: Detected CPU lcores: 8
> > EAL: Detected NUMA nodes: 1
> > EAL: Detected shared linkage of DPDK
> > EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> > EAL: Selected IOVA mode 'PA'
> > EAL: VFIO support initialized
> > mlx5_net: Default miss action is not supported.
> > mlx5_net: Default miss action is not supported.
> > All Ports initialized
> > Port 0 is UP (50000 Mbps)
> > Port 1 is UP (50000 Mbps)
> >
> > The trouble is that the ARP packets are not being picked up by my DPDK
> > application, I see them being delivered to the kernel via the eth
> interface
> > corresponding to the port (MLX is a bifurcated driver, you don't really
> > bind to the NIC, so you still see the eth interfaces at linux level and
> can
> > run tcpdump on those, I see ARP packets in the tcpdump there on the
> > interface)
> > I can receive UDP packets in my DPDK app though.
> >
> > My application is not setting any rte_flow rules etc. so I was expecting
> > that by default my dpdk app would get all the packets as is normally the
> > case with other NIC's
> > Is there something I need to configure for Mellanox NIC somewhere such
> that
> > I get 'all' the packets including ARP packets in my DPDK app ?
> >
> > Regards
> > -Prashant
>
> The Mellanox device in Azure networking cards is only used as a VF switch.
> You can go back to earlier DPDK presentations for more detail.
>
> Three reason bifurcation won't work.
>  1. Only some of the packets arrive on the VF. All non-IP show up on
>     the synthetic device. The VF is only used after the TCP three way
>     handshake.
>  2. The Netvsc PMD doesn't handle flow rules.
>  3. The VF can be removed and restored any time (by hypervisor)
>     it is not a stable entity.
>
>
 Thanks Stephen, so are we concluding that DPDK apps are unusable in Azure
as per my requirements, is there no work around or any other possibility to
use DPDK in Azure VM ? Please do send me a link to the correct presentation
I should refer to.

Regards
-Prashant

--000000000000b6c8620633d06964
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 26 Apr =
2025 at 20:58, Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumb=
er.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Fri, 25 Apr 2025 23:17:30 +0530<br>
Prashant Upadhyaya &lt;<a href=3D"mailto:praupadhyaya@gmail.com" target=3D"=
_blank">praupadhyaya@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Hi,<br>
&gt; <br>
&gt; I am having a VM on Azure where I have got two &#39;accelerated networ=
king&#39;<br>
&gt; interfaces of Mellanox<br>
&gt; # lspci -nn|grep -i ether<br>
&gt; 6561:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710=
<br>
&gt; Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)<br>
&gt; f08c:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710=
<br>
&gt; Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)<br>
&gt; <br>
&gt; I have a DPDK application which needs to obtain &#39;all&#39; packets =
from the NIC.<br>
&gt; I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), my app star=
ts<br>
&gt; and is able to detect the NIC&#39;s.<br>
&gt; Everything looks good<br>
&gt; myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0<br>
&gt; EAL: Detected CPU lcores: 8<br>
&gt; EAL: Detected NUMA nodes: 1<br>
&gt; EAL: Detected shared linkage of DPDK<br>
&gt; EAL: Multi-process socket /var/run/dpdk/rte/mp_socket<br>
&gt; EAL: Selected IOVA mode &#39;PA&#39;<br>
&gt; EAL: VFIO support initialized<br>
&gt; mlx5_net: Default miss action is not supported.<br>
&gt; mlx5_net: Default miss action is not supported.<br>
&gt; All Ports initialized<br>
&gt; Port 0 is UP (50000 Mbps)<br>
&gt; Port 1 is UP (50000 Mbps)<br>
&gt; <br>
&gt; The trouble is that the ARP packets are not being picked up by my DPDK=
<br>
&gt; application, I see them being delivered to the kernel via the eth inte=
rface<br>
&gt; corresponding to the port (MLX is a bifurcated driver, you don&#39;t r=
eally<br>
&gt; bind to the NIC, so you still see the eth interfaces at linux level an=
d can<br>
&gt; run tcpdump on those, I see ARP packets in the tcpdump there on the<br=
>
&gt; interface)<br>
&gt; I can receive UDP packets in my DPDK app though.<br>
&gt; <br>
&gt; My application is not setting any rte_flow rules etc. so I was expecti=
ng<br>
&gt; that by default my dpdk app would get all the packets as is normally t=
he<br>
&gt; case with other NIC&#39;s<br>
&gt; Is there something I need to configure for Mellanox NIC somewhere such=
 that<br>
&gt; I get &#39;all&#39; the packets including ARP packets in my DPDK app ?=
<br>
&gt; <br>
&gt; Regards<br>
&gt; -Prashant<br>
<br>
The Mellanox device in Azure networking cards is only used as a VF switch.<=
br>
You can go back to earlier DPDK presentations for more detail.<br>
<br>
Three reason bifurcation won&#39;t work.<br>
=C2=A01. Only some of the packets arrive on the VF. All non-IP show up on<b=
r>
=C2=A0 =C2=A0 the synthetic device. The VF is only used after the TCP three=
 way<br>
=C2=A0 =C2=A0 handshake.<br>
=C2=A02. The Netvsc PMD doesn&#39;t handle flow rules.<br>
=C2=A03. The VF can be removed and restored any time (by hypervisor)<br>
=C2=A0 =C2=A0 it is not a stable entity.<br><br></blockquote><div><br></div=
><div>=C2=A0Thanks Stephen, so are we concluding that DPDK apps are unusabl=
e in Azure as per my requirements, is there no work around or any other pos=
sibility to use DPDK in Azure VM ? Please do send me a link to the correct =
presentation I should refer to.</div><div><br></div><div>Regards</div><div>=
-Prashant</div><div><br></div></div></div>

--000000000000b6c8620633d06964--
