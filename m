Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD70C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 23:01:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41F224026A;
	Sat, 26 Apr 2025 01:01:33 +0200 (CEST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by mails.dpdk.org (Postfix) with ESMTP id E236F4025E
 for <dev@dpdk.org>; Sat, 26 Apr 2025 01:01:30 +0200 (CEST)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-52413efd0d3so1097061e0c.2
 for <dev@dpdk.org>; Fri, 25 Apr 2025 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745622090;
 x=1746226890; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=duiPyGOr457U1RskVnTtfEraWbmfvIsVGUyRLczmyn8=;
 b=xKu13na1oscG5fjcFFTl0CY2NwBDSJPEus2RsoVlctaHhOZya6ivcy6N9BluYFALkb
 eujXS+5/3jumZkBxnQ19kUgarTCdzMB08qz+Ez64uVjwznny04WO62rxHzajfufa0+fj
 WL2tlWD0Huyf+dt8Gd1jUDibZjA6ghQVOh5nS1sjXVVoF6EfFgCB8hVs1biLS+lBXFAq
 ymMKYvd3nlUn7tSKBe7dDiUjmojSAPvXh7bbGcC94OaYIb4/UL2Xoo9SbMaypk8uwAFP
 JKwGzKJzG9+WXPWV4ukIaPj8Ebv1pwS8YVvKLtnsCQvlNkKjNG2SO2DDdDviTikGkwF0
 MlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745622090; x=1746226890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=duiPyGOr457U1RskVnTtfEraWbmfvIsVGUyRLczmyn8=;
 b=wWKeT7eL36hUiu2vI86QbQeZIXdsNSI4GSPFILBOdnOtH/fXqIZfE6bDzM9HvpjHJG
 fr89S2zH58nydw+o+CLIIdxJR9t+oUd2o/mwo+huyyLUjId/byOiTGGIhYMygNE6ImdR
 hocFF0nsOHwlTVbd693zY80Urv4DwopcTNav1APvpB6ujv1RV6RITyF8TNREiihkW/jV
 PfYOMazjMYrEXJjJ0SFEXCMcQnQeJYOQnyvpaxNkcgAkyvdsx5nToMUdrWOVHWOlYjMd
 /0hRY85SlCi2XiGPQWF8ri37oghc4b78mee07OOp4qLErVxZn+2t/8+QsrXl1OkUFNz/
 esnQ==
X-Gm-Message-State: AOJu0YwBPUEiGMB750EVM3ztCrPmpoXCR520a8WMENx/T+PnqUEzNJfD
 vh/I+in+J2lsOCbzwRt1bAQm1QUEpTPIY/YeHkR0toGP9ZfIYJF3t9sNjUcZBX38THmwSEHDETP
 We5xQgzQCGy6xdX3GJgnZOASL93662Fx2KGzLYw==
X-Gm-Gg: ASbGncvl4bi2AxN++8+w/dZk3UVHMCgIvYvJflKXuzPRYYSWYftZY8WY8V9oh8cku1A
 /w61urqdG4QIJrVAWd0cWUtUv2c2C/vTWHBft20U/ecg3lOAB/Pet5+k2Qgc0ChGCgoKcMP9k+4
 OmYiOKwozjg7P2+PNBdnMbVmc=
X-Google-Smtp-Source: AGHT+IF0ByFuS7tc92xM4uOgV/iLUu+iS/VoeOny6EjsiT059nX0MSIEsek6QBxRhWVboTwmvezI/PVvTv50G4JCE58=
X-Received: by 2002:a05:6122:7c7:b0:527:67da:74ee with SMTP id
 71dfb90a1353d-52a9701ee8dmr1180847e0c.5.1745622089129; Fri, 25 Apr 2025
 16:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
In-Reply-To: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 25 Apr 2025 16:01:18 -0700
X-Gm-Features: ATxdqUH71iBccVOzE9SoNrcFjtdcuUFgQw1lv2tG8DZIkQwixhUIdykeh_CYtPM
Message-ID: <CAOaVG16Gt7O2+49bGhRjmsOtZCK5FWGUWMCqU=xveUzKGEHgOA@mail.gmail.com>
Subject: Re: Regarding Mellanox bifurcated driver on Azure
To: Prashant Upadhyaya <praupadhyaya@gmail.com>
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000890d5f0633a2504f"
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

--000000000000890d5f0633a2504f
Content-Type: text/plain; charset="UTF-8"

Short answer Accelerated networking on Azure is not designed to support
bifurcated VF usage

On Fri, Apr 25, 2025, 10:47 Prashant Upadhyaya <praupadhyaya@gmail.com>
wrote:

> Hi,
>
> I am having a VM on Azure where I have got two 'accelerated networking'
> interfaces of Mellanox
> # lspci -nn|grep -i ether
> 6561:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710
> Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> f08c:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710
> Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
>
> I have a DPDK application which needs to obtain 'all' packets from the NIC.
> I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), my app starts
> and is able to detect the NIC's.
> Everything looks good
> myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0
> EAL: Detected CPU lcores: 8
> EAL: Detected NUMA nodes: 1
> EAL: Detected shared linkage of DPDK
> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> EAL: Selected IOVA mode 'PA'
> EAL: VFIO support initialized
> mlx5_net: Default miss action is not supported.
> mlx5_net: Default miss action is not supported.
> All Ports initialized
> Port 0 is UP (50000 Mbps)
> Port 1 is UP (50000 Mbps)
>
> The trouble is that the ARP packets are not being picked up by my DPDK
> application, I see them being delivered to the kernel via the eth interface
> corresponding to the port (MLX is a bifurcated driver, you don't really
> bind to the NIC, so you still see the eth interfaces at linux level and can
> run tcpdump on those, I see ARP packets in the tcpdump there on the
> interface)
> I can receive UDP packets in my DPDK app though.
>
> My application is not setting any rte_flow rules etc. so I was expecting
> that by default my dpdk app would get all the packets as is normally the
> case with other NIC's
> Is there something I need to configure for Mellanox NIC somewhere such
> that I get 'all' the packets including ARP packets in my DPDK app ?
>
> Regards
> -Prashant
>
>

--000000000000890d5f0633a2504f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Short answer Accelerated networking on Azure is not desig=
ned to support bifurcated VF usage</div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 25, 202=
5, 10:47 Prashant Upadhyaya &lt;<a href=3D"mailto:praupadhyaya@gmail.com">p=
raupadhyaya@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>I am having a =
VM on Azure where I have got two &#39;accelerated networking&#39; interface=
s of Mellanox</div><div># lspci -nn|grep -i ether<br>
6561:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710 Fami=
ly [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)<br>f08c:00:02.0 Et=
hernet controller [0200]: Mellanox Technologies MT27710 Family [ConnectX-4 =
Lx Virtual Function] [15b3:1016] (rev 80)</div><div><br></div><div>I have a=
 DPDK application which needs to obtain &#39;all&#39; packets from the NIC.=
</div><div>I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), my ap=
p starts and is able to detect the NIC&#39;s.</div><div>Everything looks go=
od</div><div>myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0<br>
EAL: Detected CPU lcores: 8<br>
EAL: Detected NUMA nodes: 1<br>
EAL: Detected shared linkage of DPDK<br>
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket<br>
EAL: Selected IOVA mode &#39;PA&#39;<br>
EAL: VFIO support initialized<br>
mlx5_net: Default miss action is not supported.<br>
mlx5_net: Default miss action is not supported.<br>
All Ports initialized<br>
Port 0 is UP (50000 Mbps)<br>
Port 1 is UP (50000 Mbps)</div><div><br></div><div>The trouble is that the =
ARP packets are not being picked up by my DPDK application, I see them bein=
g delivered to the kernel via the eth interface corresponding to the port (=
MLX is a bifurcated driver, you don&#39;t really bind to the NIC, so you st=
ill see the eth interfaces at linux level and can run tcpdump on those, I s=
ee ARP packets in the tcpdump there on the interface)</div><div>I can recei=
ve UDP packets in my DPDK app though.</div><div><br></div><div>My applicati=
on is not setting any rte_flow rules etc. so I was expecting that by defaul=
t my dpdk app would get all the packets as is normally the case with other =
NIC&#39;s</div><div>Is there something I need to configure for Mellanox NIC=
 somewhere such that I get &#39;all&#39; the packets including ARP packets =
in my DPDK app ?</div><div><br></div><div>Regards</div><div>-Prashant</div>=
<div><br></div></div>
</blockquote></div>

--000000000000890d5f0633a2504f--
