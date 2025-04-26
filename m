Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD644C369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 15:28:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B18040156;
	Sat, 26 Apr 2025 17:28:49 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3534D400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 17:28:47 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-224100e9a5cso40056395ad.2
 for <dev@dpdk.org>; Sat, 26 Apr 2025 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745681326;
 x=1746286126; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjRcZhw8z13uU+pnbg2ur2H0YVBsEJrLjOniAm6hBNU=;
 b=MQ8OnCJHw2VnJifJ9DbHg+3ksb/KBmV3aodAYQqDFtQhEGzlUhXXYbEhv84zdFoJb7
 RNkSRP6llnVzxdB5DY+PUZWdP/Hsrll7Xo1lLHHb5qEj5ZfO17+DPX05w+yQBitCAgwB
 bfMxBJwskQqVaKIzP7pALlZcavprF0qP8HBtjwl/rdSsW0Z7WsMfYi6OK5w76LZgikIN
 HrujVx9PxSlt3+/JrhP6trqOKGe6oSyuwG0Okx80Pv6+Q4qJ0Hll6rZjj7wyzhZW3vZk
 DTv4lRQcV0o/B1f88c+mgbl4xb4eLmwp39tupGtIXQhLAdjYa1vsXOfiAL5oeaMbvLa8
 nWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745681326; x=1746286126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjRcZhw8z13uU+pnbg2ur2H0YVBsEJrLjOniAm6hBNU=;
 b=S4ILCD0OppuEZghkQoVRQayHERxqFIzGvv0/g1Gk4XOfnVtOF8FWLYuIuJooUvhNw3
 efLcleshb+iUEbVW+oS7E+EqiodT8v/H4P478ZYqmXpbZfR/42HlCY2VUHK3CdNEr+WZ
 inhsu+R9XzkT05GmoGMg9/zHM3ouWTH4QabV3saMk5zCQfry/lENqfRROX52DymZ0Ex+
 VCZfsO0ms0TTh1vFWi/okrpfL2TxLTlAqX/C32nOb78mtWV7G+ZXzAHmPbrCB94RGAgO
 YKwYKEnlI6LW7qx8k5DCXuPQoL/4Z3w2ou5VtdWh4m8v1zWqP2ChExZZJYH8VaIWXAag
 Q8Fg==
X-Gm-Message-State: AOJu0Yx5b0VYFvJATDGP2GAFNCe4unLITTH96HoCz93J/Rqe0935j59G
 gy0YJxbKsJT3W8IweqVLiQU7roMLIeXX8dPFPo0HyJ8JUmth4JrE1DxjWQW9uZc=
X-Gm-Gg: ASbGnctqRvn3A4pFvrO8E2TDMOMBTx+iymAzryv7THX9ghgHApSieQY+OwROpUbzNhl
 iCyXcHyXTJw3/2QW05EchuaayRW6Fb/BPi7/RMmBXtzH1rOlR89lAHwj7ix6t0GIq70x80/9V62
 q1bxBCcfEZa960/IzT4z/zesxcwAo9mv5i/k2OLb/M2ljJV+0WOZMEtG0howeCZ0TZDUGCP//Ik
 2vsVhXQob999uae7JNXEEv7lmz3qABvFhYdJWyljNO0SBCIiazKwwhAwqEsuwJC3/Xf/FJx+8MA
 BMFrk5Pts+8u9RKNUhmFS5z6by6iPKDi1L4KVaqymItLZHsvqFD7fKW+Ray236N4v05mwXMUE06
 VPLC97oLh+LukxXY1
X-Google-Smtp-Source: AGHT+IFL9pp/ysoDASc5kr5GT/xJpzEheGOr2DEa+Tw+8XcaynOaYP0eTnJt+eeNhJoWdGTFvMfqEA==
X-Received: by 2002:a17:902:d492:b0:226:5dbf:373f with SMTP id
 d9443c01a7336-22dbf5d31a6mr93460115ad.10.1745681326206; 
 Sat, 26 Apr 2025 08:28:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76d07sm51079025ad.37.2025.04.26.08.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 08:28:46 -0700 (PDT)
Date: Sat, 26 Apr 2025 08:28:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Upadhyaya <praupadhyaya@gmail.com>
Cc: dev@dpdk.org
Subject: Re: Regarding Mellanox bifurcated driver on Azure
Message-ID: <20250426082843.736964ba@hermes.local>
In-Reply-To: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
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

On Fri, 25 Apr 2025 23:17:30 +0530
Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:

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
> Is there something I need to configure for Mellanox NIC somewhere such that
> I get 'all' the packets including ARP packets in my DPDK app ?
> 
> Regards
> -Prashant

The Mellanox device in Azure networking cards is only used as a VF switch.
You can go back to earlier DPDK presentations for more detail.

Three reason bifurcation won't work.
 1. Only some of the packets arrive on the VF. All non-IP show up on
    the synthetic device. The VF is only used after the TCP three way
    handshake.
 2. The Netvsc PMD doesn't handle flow rules.
 3. The VF can be removed and restored any time (by hypervisor)
    it is not a stable entity.


