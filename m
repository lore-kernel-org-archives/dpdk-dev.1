Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3494C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 16:27:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04785402C4;
	Wed, 19 Mar 2025 17:27:58 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 352604026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 17:27:56 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-22409077c06so179652125ad.1
 for <dev@dpdk.org>; Wed, 19 Mar 2025 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742401675;
 x=1743006475; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XI7k87Ywyv/GKV17AUov2suYQHUpFSvx5+I5L91qb0=;
 b=iuL6Wv9vl6K0JY5eknoztAh+RsJyxTEOiQ6cCYk8FG9ZMGgOjL/F+++T8upkvOjmTa
 YJQNh2SNKRZuxLMP9CQhVUalv/qM24GxXJCd+5FueYBc6w23hi2KWRspd3JpLC/ybwar
 8ARCD4l/pLqKwQdmzo62tRT0KMYuP4dErxqtygnvAHj0lEg1gRTKyCZmApY+TGuipjbc
 OLA+t7BScDrSmeG5MvnmEmaoEPoZXiOvG45Cv9F6dHHdtIeIQNQRwnVOheN8UrthgXjh
 +T+qii8rA9c8Vkm20OIDrjW00Lrh48qZEUBOyGV73vwHNKd7jdjjQhDoKDRavrfW0Bge
 /Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401675; x=1743006475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XI7k87Ywyv/GKV17AUov2suYQHUpFSvx5+I5L91qb0=;
 b=VvhjpO+qmjneOTUrUQ7oZix9dRg7PON8zh/ag6Cl7r4GjsyAlXoSl7L2Rm7E7ojhG7
 Lg4+cPjRRlVogB2OQy2nKjzYRvDocggxsCxpfL6v+NXgjDq/2+QHIuh328N0antGSBDZ
 HyanRclL3YK93tVIA7X127aOnylamZxiQqpG57bOTpdGcze50obQNJJPmLW7ayZSX84G
 wZrdkXv9NQE96QTvO/ppL+GFITC42KQhFNES+7vQDptRJxh7YZcatw2qnovW9mgiN6a7
 1otNDAhvJW5LJTRmpWmlNO0i06G/gxMfvNLq7GlVkK6u2tEVkF65sr21JSNsWzC4KJDX
 eVWw==
X-Gm-Message-State: AOJu0Yyhygm1lQ+YZHZkbsK/U6RCTekcExe6rbl6MVsQge6HvJ/RcVTw
 tJh7n4PfMotecNpG2gJ+OUwjIMFhbN0jMdBzECw49HYQtuS4Aal2CUMwoG0dLqQ=
X-Gm-Gg: ASbGncsuGTkWKbRv7jVfcaHi+I+fum9hMeUSeFjj9oF5RsuWP7yA3fr4cSu746/cdgg
 AkM50lkag1Uwo7ByvfaZZ3m1vKmVYRgAE8yDcWpRIaRuUWzY/XEsHIzabd+yBvegNFVIEHXB79/
 RtpJSaNqt6y1Dw2O9sMV6EtkfRqrs0aQQywcMbmxjkCm0/8KIGdNmlibx3l5GtWgmgSr3P7ENAX
 W4elVhT6qgig2g98FNu5/o/3S+pl712WvG/u28S8/pMN4dFV16XVUQ3wDFmJ5xnVKAm5MaeHOuR
 ATPNnGoFfyOYIPpRJkw6qCB5VBh2GmcINbdvsvdHc99SDO6v+xlnN1auH72NRci1FPAoQlc4Kw7
 xHTCVrSSJ6ht8jYw1dUKPNw==
X-Google-Smtp-Source: AGHT+IFA5gt9Pv6cNu6x9+BBqXanNIxPkEdUwsU9iLvuXPadqXpEX7Jk0s3QSpuWchkzWZ3eGt41LA==
X-Received: by 2002:a05:6a00:9a4:b0:736:3768:6d74 with SMTP id
 d2e1a72fcca58-7376d61120dmr5137317b3a.7.1742401674942; 
 Wed, 19 Mar 2025 09:27:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b6bsm12243185b3a.148.2025.03.19.09.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 09:27:54 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:27:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Rajesh Goel (rajegoel)" <rajegoel@cisco.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: Dpdk-pdump not capturing packet for vmxnet3 device
Message-ID: <20250319092753.210e92df@hermes.local>
In-Reply-To: <BN9PR11MB53545D51138B2F27A402659EDDD92@BN9PR11MB5354.namprd11.prod.outlook.com>
References: <BN9PR11MB53545D51138B2F27A402659EDDD92@BN9PR11MB5354.namprd11.prod.outlook.com>
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

On Wed, 19 Mar 2025 07:21:30 +0000
"Rajesh Goel (rajegoel)" <rajegoel@cisco.com> wrote:

> Hi DPDK community,
> 
> I need some urgent help.
> 
> 1)      Iam running my dpdk application on a VMware based VM. Iam using 20.11.9 dpdk version
> Iam directly connected to the PCI device to receive pkts on my application.
> 
>       :
>       EAL: Detected 16 lcore(s)
>       EAL: Detected 1 NUMA nodes
>       EAL: Detected shared linkage of DPDK
>       EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
>       EAL: Selected IOVA mode 'PA'
>       EAL: No available hugepages reported in hugepages-1048576kB
>       EAL: Probing VFIO support...
>       EAL: VFIO support initialized
>       EAL: Probe PCI driver: net_vmxnet3 (15ad:7b0) device: 0000:04:00.0 (socket 0)
>       EAL: No legacy callbacks, legacy socket not created
>       :
> 
> 2)      Iam trying to use dpdk-pdump application to capture packets.
> 
>       dpdk-pdump -l 3 -- --pdump 'device_id=0000:04:00.0,queue=*,rx-dev=/tmp/rx.pcap,total-num-mbufs=8192,ring-size=128'
> 
>       EAL: Detected 16 lcore(s)
>       EAL: Detected 1 NUMA nodes
>       EAL: Detected static linkage of DPDK
>       EAL: Multi-process socket /var/run/dpdk/rte/mp_socket_644376_50d5dc20612f8
>       EAL: Selected IOVA mode 'PA'
>       EAL: Probing VFIO support...
>       EAL: VFIO support initialized
>       EAL: Probe PCI driver: net_vmxnet3 (15ad:7b0) device: 0000:04:00.0 (socket 0)
>       Port 1 MAC: 02 70 63 61 70 00
>        core (3), capture for (1) tuples
>        - port 0 device (0000:04:00.0) queue 65535
>       ^C
> 
>       Signal 2 received, preparing to exit...
>       ##### PDUMP DEBUG STATS #####
>        -packets dequeued:                                       0
>        -packets transmitted to vdev:            0
>        -packets freed:                                  0
> 
> This is the mempool and ring which got created in app side
> 
>             ring <MP_pdump_pool_0>@0x10045db00
>               flags=0
>               size=16384
>               capacity=16383
>               ct=0
>               ch=0
>               pt=8192
>               ph=8192
>               used=8192
>               avail=8191
>             ring <rx_ring_0>@0x102802680
>               flags=0
>               size=128
>               capacity=127
>               ct=0
>               ch=0
>               pt=0
>               ph=0
>               used=0
>               avail=127
> 
> This is the port output, port 0 is application and port 1 is created by pdump and no pkt is seen to be captured.
> 
> Port 0 stats:
>  - link status: 1
>  - Pkts in:   50
>  - Pkts out:  0
>  - total ibytes: 4024
>  - total obytes: 0
>  - rx miss: 0
>  - In Errs:   0
>  - Out Errs:  0
>  - Mbuf Errs: 0
>  - Q Rx Packets:
> 
> Port 1 stats:
>  - link status: 1
>  - Pkts in:   0
>  - Pkts out:  0
>  - total ibytes: 0
>  - total obytes: 0
>  - rx miss: 0
>  - In Errs:   0
>  - Out Errs:  0
>  - Mbuf Errs: 0
>  - Q Rx Packets:
> 
> 3)      I see the same result while using dpdk-testpmd on the APP side.
> 
> 4)      As per this page, https://doc.dpdk.org/guides/tools/pdump.html.
>       Is this applicable to vmxnet3 device here ??
> 
> *       As of now the dpdk-pdump tool cannot capture the packets of virtual devices in the primary process due to a bug in the ethdev library. Due to this bug, in a multi process context, when the primary and secondary have different ports set, then the secondary process (here the dpdk-pdump tool) overwrites the rte_eth_devices[] entries of the primary process.
> 
> Thanks
> Rajesh
> 
> 

Try dpdk-dumpcap instead. Pdump is limited and will not get any new features.
I am going to propose deprecating pdump in 25.11.
