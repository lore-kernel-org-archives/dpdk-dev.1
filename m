Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A62DC369DC
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 15:37:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DD65402A9;
	Mon, 28 Apr 2025 17:37:17 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 972B94021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 17:37:16 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7c560c55bc1so603488785a.1
 for <dev@dpdk.org>; Mon, 28 Apr 2025 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745854636;
 x=1746459436; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjzpgOIm6DfldE37JpvdrRfb/ARM/L6UEqqx4pQkMpQ=;
 b=Jnlsww3gIy5qHVjuORiuU/TWpso3Ffa/y1fDJDaIp1MQsEREcmUqF3C3B4ZtPHZQfb
 rPK5cerp2mHXKUGxUibBQg+nWd9mfjlv9g4BEg3Y9xguoBj+FvxddriEKCtIuiW+0m+F
 7QGKCZf5QWWhRaB7WXRppmH0oERSQ4vrO6KCmLgV4Uh/+T6dXhtoA7z1qyUzuyet3vO/
 BLrmhkD1IZKPUXgMe7/KQTTs08nRAWcS5UefD/q/OTeYO02+xq0VgZSTbOIIZfvbke3p
 bocein5ROgvOoCaPg+1OfIUGB6gNyd9j0Mgm+XbqsExiR0TyGQSEOgq7oaBTiGqxU2Gn
 SG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745854636; x=1746459436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PjzpgOIm6DfldE37JpvdrRfb/ARM/L6UEqqx4pQkMpQ=;
 b=NdWxiUw2Yqd2tZQJw25SBfL20PLZgsOURcthE6fv4kZefPGKMBCs26o4VkMXOPPG//
 VYebItIJ6MTaDQ0RUKlh0rJNorOwIHWjMyoDfyLLDOsFiBI5+sgvKyd40EUJGQICbW0R
 DsKbpSKOQtqeqskDrxwcqkdAhiYnlboxl1lDydmYwGYz2uXxMafoJeg/Kh2UXmr8csWi
 tT8L72lpYiJCWB/pBV6s6cqrx+VNmvbxDr/a+dKkgg6yIeosTvvyNa+FloJw9lHYiqAq
 2En+xUVrsSPaIPvxP7dE8d1MYBO3WHQ/z9Hjx2H6MJsPJTtRa7Naz8xJL3hIB8G1djAt
 Gpaw==
X-Gm-Message-State: AOJu0YyyI6W4fWxn9CGveDE3Tb0q8n3Devfck5U0EVb9M2QbBV/EAy9b
 kokCJ3zDY7lKHxYFHNavFoWuTvSTGvN2dtJaK63mc+OiNrnznYU/sxnfS/kG0dE=
X-Gm-Gg: ASbGncvOA7GdhZY3UOsSEJDuEUtAPk9e+XBM/vGQf5OI29QSkyTpSXclrBQLVEq/4VP
 hzefIhC3UkNh8LQ0ELDNh+35DWe3UJ2XBjMs/qB0Qerh7cryPlBK8ywwuLv31j/bQkHjClbQcbr
 OvWQQWBKWKw35J9IBNk8j7BvCOKxjCh3+dZU7b/YrjDfLgQ/aELUNoPLMni1vxF9jFC2k+2I9D2
 0lMLe2RwHSPZLxDNIHYEztljKN/7Hot4y8zFo1tDDOWvCn/yj+vGM7OT3/kMVM3E4x8lPZrf5Aq
 NLlPQTJs3i/fs3YhAu3ZJB0THTgLGvdrkoT5MkRpmK7h8pbk1WseWzzVb2aXKtHEpt+PrrMUHQh
 8OyJiddmRGIaZLv7AaH1h0Shsq2s=
X-Google-Smtp-Source: AGHT+IHhwzMCccAItT8OvdRWXaJI3kAxp5q/D99Ncm+uIcDG14Vo9c5zj3HdBhuVf9UTUSek4z/DVw==
X-Received: by 2002:a05:620a:294e:b0:7c7:739d:5cea with SMTP id
 af79cd13be357-7c9619e8342mr1896019085a.35.1745854635693; 
 Mon, 28 Apr 2025 08:37:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958ea37ddsm636243685a.110.2025.04.28.08.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 08:37:15 -0700 (PDT)
Date: Mon, 28 Apr 2025 08:37:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Upadhyaya <praupadhyaya@gmail.com>
Cc: dev@dpdk.org
Subject: Re: Regarding Mellanox bifurcated driver on Azure
Message-ID: <20250428083712.50b2e7ce@hermes.local>
In-Reply-To: <CAPBAu3WOq6_77mBvd=B8x2tso9hWpjFTyUuEeJgZazSm_y_GHQ@mail.gmail.com>
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
 <20250426082843.736964ba@hermes.local>
 <CAPBAu3WOq6_77mBvd=B8x2tso9hWpjFTyUuEeJgZazSm_y_GHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 28 Apr 2025 11:31:10 +0530
Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:

> On Sat, 26 Apr 2025 at 20:58, Stephen Hemminger <stephen@networkplumber.org>
> wrote:
> 
> > On Fri, 25 Apr 2025 23:17:30 +0530
> > Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
> >  
> > > Hi,
> > >
> > > I am having a VM on Azure where I have got two 'accelerated networking'
> > > interfaces of Mellanox
> > > # lspci -nn|grep -i ether
> > > 6561:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710
> > > Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> > > f08c:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710
> > > Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> > >
> > > I have a DPDK application which needs to obtain 'all' packets from the  
> > NIC.  
> > > I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), my app starts
> > > and is able to detect the NIC's.
> > > Everything looks good
> > > myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0
> > > EAL: Detected CPU lcores: 8
> > > EAL: Detected NUMA nodes: 1
> > > EAL: Detected shared linkage of DPDK
> > > EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> > > EAL: Selected IOVA mode 'PA'
> > > EAL: VFIO support initialized
> > > mlx5_net: Default miss action is not supported.
> > > mlx5_net: Default miss action is not supported.
> > > All Ports initialized
> > > Port 0 is UP (50000 Mbps)
> > > Port 1 is UP (50000 Mbps)
> > >
> > > The trouble is that the ARP packets are not being picked up by my DPDK
> > > application, I see them being delivered to the kernel via the eth  
> > interface  
> > > corresponding to the port (MLX is a bifurcated driver, you don't really
> > > bind to the NIC, so you still see the eth interfaces at linux level and  
> > can  
> > > run tcpdump on those, I see ARP packets in the tcpdump there on the
> > > interface)
> > > I can receive UDP packets in my DPDK app though.
> > >
> > > My application is not setting any rte_flow rules etc. so I was expecting
> > > that by default my dpdk app would get all the packets as is normally the
> > > case with other NIC's
> > > Is there something I need to configure for Mellanox NIC somewhere such  
> > that  
> > > I get 'all' the packets including ARP packets in my DPDK app ?
> > >
> > > Regards
> > > -Prashant  
> >
> > The Mellanox device in Azure networking cards is only used as a VF switch.
> > You can go back to earlier DPDK presentations for more detail.
> >
> > Three reason bifurcation won't work.
> >  1. Only some of the packets arrive on the VF. All non-IP show up on
> >     the synthetic device. The VF is only used after the TCP three way
> >     handshake.
> >  2. The Netvsc PMD doesn't handle flow rules.
> >  3. The VF can be removed and restored any time (by hypervisor)
> >     it is not a stable entity.
> >
> >  
>  Thanks Stephen, so are we concluding that DPDK apps are unusable in Azure
> as per my requirements, is there no work around or any other possibility to
> use DPDK in Azure VM ? Please do send me a link to the correct presentation
> I should refer to.
> 
> Regards
> -Prashant

Remember in the cloud network interfaces are free, there really is no need
for bifurication just create two interfaces to VM, one for DPDK, and one for
non DPDK.
