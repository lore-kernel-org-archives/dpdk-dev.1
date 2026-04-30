Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2DBFF8873
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 17:10:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77F1640395;
	Thu, 30 Apr 2026 19:10:23 +0200 (CEST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9E77E400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 19:10:22 +0200 (CEST)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-464bba3a9easo653637b6e.0
 for <dev@dpdk.org>; Thu, 30 Apr 2026 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777569022;
 x=1778173822; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=ypCsDvH4RkTha81/QWqbZPtt9p2MTt6+LPXuBNNgHiM=;
 b=bRTBQoJRep3emwnTmdw+r2OJGMEsnT1AIVA+b6bDmCrjw6h6ncHXHVLXaswlaBbk/N
 6pwL71aGwiT0oPenlIRhLvH8cj5aSYjs2SHQhd00BQSybMTUsg3E9cl8Ir6kvKl5My72
 rRv8DRH2U2bGUV9tihZVt5v9/yCZWvSwtYQ6PLxyB2qlBPekOS679te553b+e56Gdpzj
 zfe7nzQeLPdHyeWIsvHRxcQc+o1Mei6g24hDB1vW5YUtrYawphKh9eSP9t8OL+q7lS78
 AWCV2LUKGsMF1EEV7F/T3Jm7u1TocsajOPLP9BQYnaknoXJd0ZrXzGpypyaIucVd33/2
 +5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569022; x=1778173822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ypCsDvH4RkTha81/QWqbZPtt9p2MTt6+LPXuBNNgHiM=;
 b=g5NYHEZIgM4bfeXh1xIJ2SuSPFeA7N0BgKqhv9CEUsJAP2LN0fFAMrfHNvfqx/XyCi
 qYaV/0fDZ6mwo4WFQc8UTYmaqzq1xWEMBe++IIAawF3jpMTkyBkvqhIm7X54KslNuINj
 JY/6BtrRbUp+uzX+M3VvBTduUC87ZV8LdvMoVEhCWG78ukRsQDEXxZSbJmYVKr97YvEc
 ph0bk1mXhqiYVM5P+qVoacX9uhCHrhLXIBkmFoRxP9TUo5H73XHr1Kf3+JNVVPBQjZv7
 yCijDJ0tiYy6Pen4l1/zfWJmgsfUTFZcRkc3wRZ1CLJE3ZPhO9OQOPues9a9S/8AUDJx
 rORg==
X-Gm-Message-State: AOJu0Yw/N6eWf8Vwn8x4B+RKPGU2awuo38vONcByd4cxgRV+bfY2Aj/7
 r/E/rCTv1wzbsSWpjMd0LbtNkt4tOOmFjOzqeo6Xv0rujhdRYrSkgWAHr94ZyxHb1PGnSg+0x8v
 twa+c
X-Gm-Gg: AeBDievcPIKKAlpxm5f0STzDauDslfyRZ40Cu6cN1BuCo79CEO2JL8VHNIdmulx/eb/
 GFdRQFYTqVf0Ja/uEgZ+VtkPndreuHBVmPF4rxXoK50hM4rCbHNzRFMyt7rSmcHIYu1g/lWzgfp
 BlFqmNhNdzU+V/ebgi+QixbmttFU929zMgaAliFUH6r4Uyra5lUGwawzUdS+XBwW67VLep+fXSU
 c99RB+9d45q2lFU/p7wtWI8eE8loljrP7bpzIgMFBGeP855moTmwlci2awMkRPx8Y0vwqFrTiLW
 TQ47VRn6vEpjlUTgJvFAMCMNEA0SzGbz3b6lBMgr7PeR+h3c3KmPkYf1XO2Hop4ooiHLggSVdOh
 //mKBrw5wpb/xIAyO1k81YL4ecgJRWR6MlFvO0F1PIIbBrvLeKPXvWdv3zNV9XP2HZ3hQB3/CvN
 YMxNJWSX41Qbs5x3IW5wjJ85BvrXYC2ZjROuWB36DByKllrg==
X-Received: by 2002:a05:6808:4487:b0:47a:14bd:6a11 with SMTP id
 5614622812f47-47c5fbc4fcemr2229054b6e.13.1777569021637; 
 Thu, 30 Apr 2026 10:10:21 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c43e6aec9sm3065874b6e.2.2026.04.30.10.10.20
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:10:21 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:10:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v25 00/24] net/pcap: bug fixes and new features
Message-ID: <20260430101018.1dfc3489@phoenix.local>
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

On Sun, 19 Apr 2026 09:09:33 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This series contains improvements to the PCAP PMD including new
> features, bug fixes, code cleanup, and a comprehensive test suite.
> 
> New features:
>   - Nanosecond precision timestamps (when libpcap supports it)
>   - VLAN tag support
>   - Link state reporting in interface mode
>   - Link status change (LSC) interrupt support in interface mode
>   - EOF notification via link status change for rx_pcap mode
>   - Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS capability
>   - Configurable snapshot length via snaplen devarg
>   - Rx scatter offload support with mbuf pool validation
> 
> Bug fixes:
>   - Fix build on Windows from RTE_LOG_LINE changes.
>   - Fix multi-segment transmit to dynamically allocate instead of
>     silently truncating packets larger than 9K stack buffer
>   - Fix Tx burst error handling: distinguish malformed mbufs (counted
>     as errors) from pcap_sendpacket backpressure (break and retry)
>   - Reject non-Ethernet interfaces to prevent malformed packets
>     and kernel warnings on FreeBSD/macOS loopback
> 
> Code cleanup:
>   - Convert internal flags from int to bool
>   - Remove unnecessary casts of void* from rte_zmalloc
>   - Replace rte_malloc/rte_memcpy with libc equivalents in osdep code
>   - Include headers explicitly rather than relying on indirect includes
>   - Reduce scope of file-level variables
> 
> Testing:
>   - Add comprehensive unit test suite
>   - Make test suite packet generator handle larger packets
> 
> v25 - fix build on one intermediate step for bisectability
> 
> v24 - fix format string warning in test code.
> 
> Stephen Hemminger (24):
>   maintainers: update for pcap driver
>   net/pcap: fix build on Windows
>   doc: update features for PCAP PMD
>   net/pcap: include used headers
>   net/pcap: remove unnecessary casts
>   net/pcap: avoid using rte_malloc and rte_memcpy
>   net/pcap: advertise Tx multi segment
>   net/pcap: replace stack bounce buffer
>   net/pcap: fix error accounting and backpressure on transmit
>   net/pcap: clean up TX dumper return value and types
>   net/pcap: add datapath debug logging
>   net/pcap: consolidate boolean flag handling
>   net/pcap: support VLAN strip and insert offloads
>   net/pcap: add link status for interface mode
>   net/pcap: support nanosecond timestamp precision
>   net/pcap: reject non-Ethernet interfaces
>   net/pcap: reduce scope of file-level variables
>   net/pcap: clarify maximum received packet
>   eal/windows: add wrapper for access function
>   net/pcap: add snapshot length devarg
>   net/pcap: add Rx scatter offload
>   net/pcap: add link status change support for iface mode
>   net/pcap: add EOF notification via link status change
>   test: add comprehensive test suite for pcap PMD
> 
>  MAINTAINERS                            |    1 +
>  app/test/meson.build                   |    2 +
>  app/test/test_pmd_pcap.c               | 3452 ++++++++++++++++++++++++
>  doc/guides/nics/features/pcap.ini      |    9 +
>  doc/guides/nics/pcap.rst               |   47 +
>  doc/guides/rel_notes/release_26_07.rst |   12 +
>  drivers/net/pcap/pcap_ethdev.c         |  859 ++++--
>  drivers/net/pcap/pcap_osdep.h          |   27 +
>  drivers/net/pcap/pcap_osdep_freebsd.c  |   43 +-
>  drivers/net/pcap/pcap_osdep_linux.c    |   33 +-
>  drivers/net/pcap/pcap_osdep_windows.c  |   76 +-
>  lib/eal/windows/include/rte_os_shim.h  |    1 +
>  lib/eal/windows/include/unistd.h       |    7 +
>  13 files changed, 4354 insertions(+), 215 deletions(-)
>  create mode 100644 app/test/test_pmd_pcap.c
> 


Applied to next-net with one addition to MAINTAINERS to catch the new test.
