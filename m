Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF21C0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 19:04:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FE1840608;
	Mon, 10 Feb 2025 20:04:16 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 6EA91402E5
 for <dev@dpdk.org>; Mon, 10 Feb 2025 20:04:15 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f92258aa6so37600205ad.3
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739214254;
 x=1739819054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zl1v4aPMTF1EYqaB0LzbyYCsASYx6Tmo/cK+X01HWhU=;
 b=W2wwSi8hxXo72cmU62tkP2O965jKrcScyYs8b6wVHvejY3gloKSOSetpVo03yYBMg+
 VEbrNJXg10wOzRpf2DurcKNh9YEXxQQ5zuFffMISWAz7H6PNDbEg9FBnvzFzXUetqXAZ
 BdWzHDA7LRZT91Uu3ju6JaWEH2tMKVNU5KSFuQn1YCvNMglcpsVrWSNykU2rU6KNTlzQ
 el1SshvgCPeXNFuYR17mZe3mCfg9DvGyBP1xidYkId3VkUbIZvjCkgsIBnbu1M4bsagz
 9Vg8dJ8D9ZTXyjhCRSv7J+YZbfyr8nSzyZIU3kPP70s81p3BlxRmXntZR7SorzI/Eo9G
 /EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739214254; x=1739819054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zl1v4aPMTF1EYqaB0LzbyYCsASYx6Tmo/cK+X01HWhU=;
 b=oja7Dgl0fao8qoNhZh7TRxtSbewHgd3sMdDRp2jUsOaaVserCFD/a9vx6oOzcP0N6j
 3xFmDJJFEAGuAOL1jzCjpCt0is287F4pbZFp1QlQg2GCtsg0l0U+FNSOMOQIY7TjM31T
 UEK+XJSIWU4buPZFGFX36E9RgyN6FGOCI1fZCiZWSrRUjbkNhswZutLy3YBeXZrYbdtv
 JfgSmiZsJsv1+YD2IwY/wbq2tcs0l2SMqGEgLaG/F3TMy0zBjV03CPKvvvMcJGKywYoE
 LCWmTZJbFyYBEyXyXQ+Rk17l3LpcdbVPPPBdc5Bsg8biftfCjbRyw55tjmTFBZ+1msYH
 ejyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRFE3JzdgsGci2CRt0WbJgnIER0o1YQ9g1d95oCnELA2GS3G5g431pQUEomAdeXcY1sD4=@dpdk.org
X-Gm-Message-State: AOJu0YzzfXIVJiuKWtcy5QFEcDSaDpuqHPtgFVO1GkLLQMSh2oovWX6K
 /IbYWREkHO1paa8osvLahO58vx/RdOzOp56H0B7kokE9/T4UbOCENeaTL3/fSqw=
X-Gm-Gg: ASbGncuHBsxyd8vKnDzVYTkKt3RRGlHT4TmMLJNX+G0QBmu1bIUoJxo4vfD/ZGE5sFh
 HGF47U3C3/CNRK4b269SjR2SBrHEhUd9rd+Za9mjvuBvoynpqlths4/64m6PfXnH9EkO9eyMOa7
 icxtcrjDDU5bGoDArDYqW3Z1IoQPKszVpQNMHZlNqf/QC5s0En5oNor/9lpTrCXzRwZvQGwX6FR
 Wt4f+Y5TXfamqn0tFGXYJxgEPtMD2hqvjgzz1yZsLeUvf5VtJcclvc2VxVbPabeWFY5jQObvbWm
 xwbx4VmVSCSYRnRCl7SNNQHX0jBTm5lppG+XuDbcUtsTZy9HA9nljzDWcLxbkRsZDBlb
X-Google-Smtp-Source: AGHT+IECHHwggmkDGXXiFUXyHPypISbvviTHc3ky1LjyfavliSAoGpemtRuFJKYXiI6MsMLUkUJxjw==
X-Received: by 2002:a05:6a21:670b:b0:1ea:ddd1:2fb6 with SMTP id
 adf61e73a8af0-1ee03b42927mr29400702637.30.1739214253357; 
 Mon, 10 Feb 2025 11:04:13 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73077975f05sm4511914b3a.14.2025.02.10.11.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 11:04:12 -0800 (PST)
Date: Mon, 10 Feb 2025 11:00:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v8 00/28] [v8]drivers/net Add Support mucse N10 Pmd Driver
Message-ID: <20250210110029.292b3865@hermes.local>
In-Reply-To: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
References: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
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

On Mon, 10 Feb 2025 15:26:27 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> For This patchset just to support the basic chip init work
> and user can just found the eth_dev, but can't control more.
> For Now just support 2*10g nic,the chip can support
> 2*10g,4*10g,4*1g,8*1g,8*10g.
> The Feature rx side can support rx-cksum-offload,rss,vlan-filter
> flow_clow,uncast_filter,mcast_filter,1588,Jumbo-frame
> The Feature tx side can support tx-cksum-offload,tso,vxlan-tso 
> flow director base on ntuple pattern of tcp/udp/ip/ eth_hdr->type
> for sriov is also support.
> 
> Because of the chip design defect, for multiple-port mode
> one pci-bdf will have multiple-port (max can have four ports)
> so this code must be care of one bdf init multiple-port.
> 
> v8:
>   * fixed codespell issue.
>   * fixed MAINTAINERS file
> 
> v7:
>   * add support nic basic feature such as rss vlan strip/filter,
>   * mtu-change recv/send scater-recv/mutltiple-send.
>   * fixed code rationality, advised by Ferruh Yigit.
> 
> v6:
>   * fixed the doc(rst) format problem advise by Thomas Monjalon
> 
> v5:
>   * fixed the symbol name require by the style documentation
> 
> v4:
>   * one patch has been forgot to upload :(
> 
> v3:
>   * fixed http://dpdk.org/patch/129830 FreeBSD 13 compile Issue
>   * change iobar type to void suggest by Stephen Hemminger
>   * add KMOD_DEP support for vfio-pci
>   * change run-cmd argument parse check for invalid extra_args
> 
> v2:
>   * fixed MAINTAIN maillist fullname format
>   * fixed driver/net/meson the order issue of new driver to driver list
>   * improve virtual point function usage suggest by Stephen Hemminger
> 
> Wenbo Cao (28):
>   net/rnp: add skeleton
>   net/rnp: add ethdev probe and remove
>   net/rnp: add log
>   net/rnp: support mailbox basic operate
>   net/rnp: add device init and uninit
>   net/rnp: add get device information operation
>   net/rnp: add support mac promisc mode
>   net/rnp: add queue setup and release operations
>   net/rnp: add queue stop and start operations
>   net/rnp: add support device start stop operations
>   net/rnp: add RSS support operations
>   net/rnp: add support link update operations.
>   net/rnp: add support link setup operations
>   net/rnp: add Rx burst simple support
>   net/rnp: add Tx burst simple support
>   net/rnp: add MTU set operation
>   net/rnp: add Rx scatter segment version
>   net/rnp: add Tx multiple segment version
>   net/rnp: add support basic stats operation
>   net/rnp: add support xstats operation
>   net/rnp: add unicast MAC filter operation
>   net/rnp: add supported packet types
>   net/rnp: add support Rx checksum offload
>   net/rnp: add support Tx TSO offload
>   net/rnp: support VLAN offloads.
>   net/rnp: add support VLAN filters operations.
>   net/rnp: add queue info operation.
>   net/rnp: support Rx/Tx burst mode info
> 
>  MAINTAINERS                         |    6 +
>  doc/guides/nics/features/rnp.ini    |   33 +
>  doc/guides/nics/index.rst           |    1 +
>  doc/guides/nics/rnp.rst             |  100 ++
>  drivers/net/meson.build             |    1 +
>  drivers/net/rnp/base/meson.build    |   28 +
>  drivers/net/rnp/base/rnp_bdq_if.c   |  398 ++++++
>  drivers/net/rnp/base/rnp_bdq_if.h   |  154 +++
>  drivers/net/rnp/base/rnp_bitrev.h   |   64 +
>  drivers/net/rnp/base/rnp_common.c   |  103 ++
>  drivers/net/rnp/base/rnp_common.h   |   17 +
>  drivers/net/rnp/base/rnp_crc32.c    |   37 +
>  drivers/net/rnp/base/rnp_crc32.h    |   10 +
>  drivers/net/rnp/base/rnp_dma_regs.h |   68 +
>  drivers/net/rnp/base/rnp_eth_regs.h |   90 ++
>  drivers/net/rnp/base/rnp_fw_cmd.c   |  162 +++
>  drivers/net/rnp/base/rnp_fw_cmd.h   |  358 ++++++
>  drivers/net/rnp/base/rnp_hw.h       |  136 ++
>  drivers/net/rnp/base/rnp_mac.c      |  367 ++++++
>  drivers/net/rnp/base/rnp_mac.h      |   34 +
>  drivers/net/rnp/base/rnp_mac_regs.h |  207 +++
>  drivers/net/rnp/base/rnp_mbx.c      |  512 ++++++++
>  drivers/net/rnp/base/rnp_mbx.h      |   58 +
>  drivers/net/rnp/base/rnp_mbx_fw.c   |  499 ++++++++
>  drivers/net/rnp/base/rnp_mbx_fw.h   |   24 +
>  drivers/net/rnp/base/rnp_osdep.h    |  175 +++
>  drivers/net/rnp/meson.build         |   20 +
>  drivers/net/rnp/rnp.h               |  258 ++++
>  drivers/net/rnp/rnp_ethdev.c        | 1829 +++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_link.c          |  439 +++++++
>  drivers/net/rnp/rnp_link.h          |   38 +
>  drivers/net/rnp/rnp_logs.h          |   36 +
>  drivers/net/rnp/rnp_rss.c           |  367 ++++++
>  drivers/net/rnp/rnp_rss.h           |   43 +
>  drivers/net/rnp/rnp_rxtx.c          | 1820 ++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_rxtx.h          |  162 +++
>  36 files changed, 8654 insertions(+)
>  create mode 100644 doc/guides/nics/features/rnp.ini
>  create mode 100644 doc/guides/nics/rnp.rst
>  create mode 100644 drivers/net/rnp/base/meson.build
>  create mode 100644 drivers/net/rnp/base/rnp_bdq_if.c
>  create mode 100644 drivers/net/rnp/base/rnp_bdq_if.h
>  create mode 100644 drivers/net/rnp/base/rnp_bitrev.h
>  create mode 100644 drivers/net/rnp/base/rnp_common.c
>  create mode 100644 drivers/net/rnp/base/rnp_common.h
>  create mode 100644 drivers/net/rnp/base/rnp_crc32.c
>  create mode 100644 drivers/net/rnp/base/rnp_crc32.h
>  create mode 100644 drivers/net/rnp/base/rnp_dma_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_eth_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.c
>  create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.h
>  create mode 100644 drivers/net/rnp/base/rnp_hw.h
>  create mode 100644 drivers/net/rnp/base/rnp_mac.c
>  create mode 100644 drivers/net/rnp/base/rnp_mac.h
>  create mode 100644 drivers/net/rnp/base/rnp_mac_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_mbx.c
>  create mode 100644 drivers/net/rnp/base/rnp_mbx.h
>  create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.c
>  create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.h
>  create mode 100644 drivers/net/rnp/base/rnp_osdep.h
>  create mode 100644 drivers/net/rnp/meson.build
>  create mode 100644 drivers/net/rnp/rnp.h
>  create mode 100644 drivers/net/rnp/rnp_ethdev.c
>  create mode 100644 drivers/net/rnp/rnp_link.c
>  create mode 100644 drivers/net/rnp/rnp_link.h
>  create mode 100644 drivers/net/rnp/rnp_logs.h
>  create mode 100644 drivers/net/rnp/rnp_rss.c
>  create mode 100644 drivers/net/rnp/rnp_rss.h
>  create mode 100644 drivers/net/rnp/rnp_rxtx.c
>  create mode 100644 drivers/net/rnp/rnp_rxtx.h
> 

Clang build finds other errors.

[1520/3266] Compiling C object drivers/libtmp_rte_net_rnp.a.p/net_rnp_rnp_rxtx.c.o
../drivers/net/rnp/rnp_rxtx.c:1576:28: warning: use of logical '||' with constant operand [-Wconstant-logical-operand]
 1576 |                                 (RTE_MBUF_F_TX_L4_MASK || RTE_MBUF_F_TX_TCP_SEG))) {
      |                                                        ^  ~~~~~~~~~~~~~~~~~~~~~
../drivers/net/rnp/rnp_rxtx.c:1576:28: note: use '|' for a bitwise operation
 1576 |                                 (RTE_MBUF_F_TX_L4_MASK || RTE_MBUF_F_TX_TCP_SEG))) {
      |                                                        ^~
      |                                                        |
../drivers/net/rnp/rnp_rxtx.c:1576:6: warning: converting the result of '<<' to a boolean always evaluates to true [-Wtautological-constant-compare]
 1576 |                                 (RTE_MBUF_F_TX_L4_MASK || RTE_MBUF_F_TX_TCP_SEG))) {
      |                                  ^
../lib/mbuf/rte_mbuf_core.h:312:43: note: expanded from macro 'RTE_MBUF_F_TX_L4_MASK'
  312 | #define RTE_MBUF_F_TX_L4_MASK       (3ULL << 52)
      |                                           ^
../drivers/net/rnp/rnp_rxtx.c:1576:31: warning: converting the result of '<<' to a boolean always evaluates to true [-Wtautological-constant-compare]
 1576 |                                 (RTE_MBUF_F_TX_L4_MASK || RTE_MBUF_F_TX_TCP_SEG))) {
      |                                                           ^
../lib/mbuf/rte_mbuf_core.h:284:43: note: expanded from macro 'RTE_MBUF_F_TX_TCP_SEG'
  284 | #define RTE_MBUF_F_TX_TCP_SEG       (1ULL << 50)
      |                     
