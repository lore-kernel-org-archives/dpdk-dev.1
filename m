Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E6C369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 16:24:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75CC4402A3;
	Tue, 29 Apr 2025 18:24:20 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id F28B840277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 18:24:18 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso5404073b3a.3
 for <dev@dpdk.org>; Tue, 29 Apr 2025 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745943858;
 x=1746548658; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsE1+cspAbkQjxNLBSkTgjpxCD+Pcst/YGT821EhGxw=;
 b=v0jYmLq9zPcmzkN45J3/aSdlD7SP9jTzJlJxlkuav1aQTnhaoNBI9C9RfTinaMvUQ2
 N0TvoyElW4Ude7WCsvOUAAlnXfinP14fCmeWk34tWvONp1ZMyQG9wS8T1pcjjJH7SIZG
 JZt/QNRHlITx9u/sWag5akPmsId1kIoaxk0kI11XG2EWMi6Ls2cowvWW4sFx7esPaHvB
 ucDV2gwf3SFKpz1BE7YYw9FwgS3pauPVTrwFMmvKJXNrnq+6GRMD+aSJMXlwZl3cWLTo
 zgDvpjefXfYv+pN3hD3vyv7U9+H7rryxLfnmZi1Qu0dHcP7amh1fjNtnkQxTQKiwtkeO
 jOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745943858; x=1746548658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IsE1+cspAbkQjxNLBSkTgjpxCD+Pcst/YGT821EhGxw=;
 b=JwUWvril/1CZNmJeZ7d+6JXrdcNxCqxTZ6B1X4Jp0zDJQhb97rHm9KDV+0HfEv5Heg
 w40B4IqIozLJQnOaxlm1EIH53hgI/USdW7e3g56Jr7RelmI2w1yb5DehiL5R+gKtVIwX
 vtrWoQIiWMAgwmRprNNqyQH1yCjoDEyj/tw15O5SRqQfrF4JtIaPWOQcE+XVTCD0jZtg
 kfjcg0gSpx6S/4AERJQzyV0tVrlc8lOM431L2p+KVDZX62p4+lTXU8H6NZg4Og+MIsNV
 8U5/Aot0E7OTXgblgbCtJo6O+dOn/7a9HJ7+J+LOH2T4DrdF8Frwub+P6NWlk6oeCAXC
 tVsg==
X-Gm-Message-State: AOJu0Yy+y49v/G2BeDqZZF2OrAOdw7t4rWSqBSZbvrYRoo26Kkb/MjtJ
 t//JL2CrT8Xktc6KplAV5exYtbMep3tS4WXGhtsmgmO6BrVZUmb75JfGNIuKukQ=
X-Gm-Gg: ASbGnct7iEaFGdx2f+Ay+12L2aSaVOvmU+nmLaYI5pfooPI3f6S+gbqt7qpGD6JxFSm
 +OsjSVomknyp8b6n3hSg+dRFpch37Xq3EYS2FjvuBPpGmN7ASvJ21vSCYPZf3mnxyZmEanY+MkA
 iriZlmjRXh3m2Y8m5DQLU9d2fBnQ1anRgZp6aV/60L1Kbbd//x7om+MHZrdS2QD0qMKvvS2pnti
 RnvhVrJXryf29NOBto1CDyKrsszcE83n06iplSHECwif9YInoDhL10GvD4tWJWbZFxMkbdQZD8S
 /uc3/OzKiE5xQ1kX+fAN2iVBiw1hm36wlLcWaGgm7YhH4nLV2/ix6zFc+6ozyljr5Y8Ly6zaBzw
 /aKgkrHzrHmWK8H7H
X-Google-Smtp-Source: AGHT+IEAsKCTIGsc1GT0oljdUJFLKogpNc1UpzQ0P8ndVJtHhv5jLAJ7gfWSC+ifG3QHr9rCYGDgUw==
X-Received: by 2002:a05:6a00:8c8c:b0:740:34cd:498f with SMTP id
 d2e1a72fcca58-74034cd4af6mr1050903b3a.5.1745943857634; 
 Tue, 29 Apr 2025 09:24:17 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6ab27sm10117807b3a.110.2025.04.29.09.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 09:24:17 -0700 (PDT)
Date: Tue, 29 Apr 2025 09:24:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Upadhyaya <praupadhyaya@gmail.com>
Cc: dev@dpdk.org
Subject: Re: Regarding Mellanox bifurcated driver on Azure
Message-ID: <20250429092415.2a37c090@hermes.local>
In-Reply-To: <CAPBAu3UDao48OmcnEMQw9-W3pesM1W2ftQsEG3EtHDxxOXCc=Q@mail.gmail.com>
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
 <20250426082843.736964ba@hermes.local>
 <CAPBAu3WOq6_77mBvd=B8x2tso9hWpjFTyUuEeJgZazSm_y_GHQ@mail.gmail.com>
 <20250428083712.50b2e7ce@hermes.local>
 <CAPBAu3UDao48OmcnEMQw9-W3pesM1W2ftQsEG3EtHDxxOXCc=Q@mail.gmail.com>
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

On Tue, 29 Apr 2025 21:45:36 +0530
Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:

> On Mon, 28 Apr 2025 at 21:07, Stephen Hemminger <stephen@networkplumber.org>
> wrote:
> 
> > On Mon, 28 Apr 2025 11:31:10 +0530
> > Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
> >  
> > > On Sat, 26 Apr 2025 at 20:58, Stephen Hemminger <
> > stephen@networkplumber.org>
> > > wrote:
> > >  
> > > > On Fri, 25 Apr 2025 23:17:30 +0530
> > > > Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
> > > >  
> > > > > Hi,
> > > > >
> > > > > I am having a VM on Azure where I have got two 'accelerated  
> > networking'  
> > > > > interfaces of Mellanox
> > > > > # lspci -nn|grep -i ether
> > > > > 6561:00:02.0 Ethernet controller [0200]: Mellanox Technologies  
> > MT27710  
> > > > > Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> > > > > f08c:00:02.0 Ethernet controller [0200]: Mellanox Technologies  
> > MT27710  
> > > > > Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
> > > > >
> > > > > I have a DPDK application which needs to obtain 'all' packets from  
> > the  
> > > > NIC.  
> > > > > I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), my app  
> > starts  
> > > > > and is able to detect the NIC's.
> > > > > Everything looks good
> > > > > myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0
> > > > > EAL: Detected CPU lcores: 8
> > > > > EAL: Detected NUMA nodes: 1
> > > > > EAL: Detected shared linkage of DPDK
> > > > > EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> > > > > EAL: Selected IOVA mode 'PA'
> > > > > EAL: VFIO support initialized
> > > > > mlx5_net: Default miss action is not supported.
> > > > > mlx5_net: Default miss action is not supported.
> > > > > All Ports initialized
> > > > > Port 0 is UP (50000 Mbps)
> > > > > Port 1 is UP (50000 Mbps)
> > > > >
> > > > > The trouble is that the ARP packets are not being picked up by my  
> > DPDK  
> > > > > application, I see them being delivered to the kernel via the eth  
> > > > interface  
> > > > > corresponding to the port (MLX is a bifurcated driver, you don't  
> > really  
> > > > > bind to the NIC, so you still see the eth interfaces at linux level  
> > and  
> > > > can  
> > > > > run tcpdump on those, I see ARP packets in the tcpdump there on the
> > > > > interface)
> > > > > I can receive UDP packets in my DPDK app though.
> > > > >
> > > > > My application is not setting any rte_flow rules etc. so I was  
> > expecting  
> > > > > that by default my dpdk app would get all the packets as is normally  
> > the  
> > > > > case with other NIC's
> > > > > Is there something I need to configure for Mellanox NIC somewhere  
> > such  
> > > > that  
> > > > > I get 'all' the packets including ARP packets in my DPDK app ?
> > > > >
> > > > > Regards
> > > > > -Prashant  
> > > >
> > > > The Mellanox device in Azure networking cards is only used as a VF  
> > switch.  
> > > > You can go back to earlier DPDK presentations for more detail.
> > > >
> > > > Three reason bifurcation won't work.
> > > >  1. Only some of the packets arrive on the VF. All non-IP show up on
> > > >     the synthetic device. The VF is only used after the TCP three way
> > > >     handshake.
> > > >  2. The Netvsc PMD doesn't handle flow rules.
> > > >  3. The VF can be removed and restored any time (by hypervisor)
> > > >     it is not a stable entity.
> > > >
> > > >  
> > >  Thanks Stephen, so are we concluding that DPDK apps are unusable in  
> > Azure  
> > > as per my requirements, is there no work around or any other possibility  
> > to  
> > > use DPDK in Azure VM ? Please do send me a link to the correct  
> > presentation  
> > > I should refer to.
> > >
> > > Regards
> > > -Prashant  
> >
> > Remember in the cloud network interfaces are free, there really is no need
> > for bifurication just create two interfaces to VM, one for DPDK, and one
> > for
> > non DPDK.
> >  
> 
> I am afraid Stephen, I am not entirely clear about your suggestion.
> When I create an Accelerated Networking interface on Azure (with the
> intention of my DPDK app fully controlling it), it is automatically giving
> one eth interface (representing slowpath) and one enp interface (presumably
> the fast path and which my dpdk app detects and operates upon). It is this
> pair that is created automatically for a single packet interface by Azure.
> The trouble is the above bifurcation because I don't get to see all the
> packets from the NIC on DPDK controlled interface -- my DPDK app wants to
> see all the packets.
> 
> Regards
> -Prashant

With DPDK on Azure, an application should never use the VF directly.
It needs to use either netvsc PMD which handles both the vmbus (slow path)
and VF (fast path) combined. Or use the older vdev_netvsc/failsafe/tap combination.
The latter uses a virtual device to make a failsafe PMD which then does
a combination of TAP (via kernel slow path) and MLX5 VF.  The failsafe PMD
is what is exposed for application usage.

The limitations are not explicitly mentioned in the documentation but:
  - don't use VF directly in application
  - there is no support for bifurcation where some packets go to kernel
    and some to DPDK
  - there is only very limited support for rte_flow; that is with failsafe PMD
    (not netvsc PMD) and the limitations are that the emulation of rte_flow
    in the TAP device only supports a few things.
