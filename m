Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04A2C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 16:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABE2441153;
	Wed, 19 Feb 2025 17:14:40 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 946D741141
 for <dev@dpdk.org>; Wed, 19 Feb 2025 17:14:39 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-220c8f38febso130845955ad.2
 for <dev@dpdk.org>; Wed, 19 Feb 2025 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739981678;
 x=1740586478; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7z0QqpUPStN9eP7Z+VqJqi58dTgMGn6pTjH1iwyZ5k=;
 b=Sx0/EAmPLVIZQJcIXzW9Hp2F+KKCwHZUxlagjiS/j3NebjSHAugjGDwEfuHd5HBoMW
 ULxbFmw178fHdrFp4mSPGPpz54uxgqnuHbUcS1ExCTGWk6QzG/jXCY2yw5mve3icl+qs
 ED9RoWrB0i+Jdl9i8nc2QEclnhECxg9A6O11PsUtKuOBq//UEAspbOMizCLci2wo/lSV
 RhP5jH3YdmlnF6YVrzSa4CMj7npAcwTsR4rJn2J3EkfZQ7LHDNx2hEO8vgNiDfGXBC6J
 hMSpyCZLTg3/mxv3aguxqg4LUYfiDFvi4kUYDQw2WN3cKovVfqaXgsMj78S1/HEoeXrp
 OEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739981678; x=1740586478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7z0QqpUPStN9eP7Z+VqJqi58dTgMGn6pTjH1iwyZ5k=;
 b=X0Ba/XvfJdjTHb3HBPqRIPoBEBYvKGLzXbzvZ3NV/q0wwuXmBzAgQC0k1RYBnN15o0
 uzLiCQgQJCS3NLmSULSZbG+x29kHL82d0r1Y8CyDp0EiZSg2XfEXP0LgcH5jgNC3xNi8
 GsDah4siDMDQsLD0PIuqe8Z5ysL2+awhKl7HhBpazVayG/Bag/hyjq5N5wwQTvEUTQC7
 4g8J6hOrt8fhHWmSdgCAb2s+oLsW0jEZVOuAJNsllrkS4lInHRiiusW9AMsxQLvbJDki
 OvpKEJZcm1LuvAAp9ORuYrdQ7VRe4kBzCh24kfm0siUKw3WDMlR9RpMxJXvzcHucUo+w
 6H1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjX2XgN1du7ImbA7I18TuM0+4eI91MLYJBffJeyDqrpE80FSMdPWQTUtw8GSN5Bz8u3kQ=@dpdk.org
X-Gm-Message-State: AOJu0YxoXMD1IJl2z1zmsXLg0z2NYukuhLtXIOHriJ1EuGc6xB/Me+05
 x5TXgv8I+0GxoQy9Deww2Yp4d96+GndtPU1fNJGYvn1RexcIlppLBf9IwcGUlF0VasXVaFYdOiE
 kHbs=
X-Gm-Gg: ASbGncvdqhb5K/ZctRPCMWRESKD+B4EfPIynrJEs8g1UoJ21RZPZdt6T6Ou2QwVNfIQ
 uQg+YlnVZy9O443UJutPMxvqS8F/F0gSVyzmODnVJHbS5jv6a8CqU2f0DWhGKWmwEot+J62OhVK
 +//m1/KmxiibRFzz385nG8c9Z2NVPkuuWrhYhdciSRbMEOF9eQ+LF+fInfnGejNkO4UV2yJd5rw
 JOtVELsKN3s1xHUYAOHd7kATasE2vj2dJTCBVHsXtBPrvSd1XULno7dynE6y5LiwITj10NgCeoP
 1+1u9pHEL76QTMwZr4sv0tG+vaTeakWBghXNzFNgojHmmX8fn4XgHzuKoAUZdbDp5dcD
X-Google-Smtp-Source: AGHT+IGRUeELFuCfb0NixjPlbSQX2bta/ML8H3h+fQieHPB1Uia5eNmmuUZtSHgXiCcYvWxh4muIKg==
X-Received: by 2002:a05:6a00:2351:b0:732:564e:1ec6 with SMTP id
 d2e1a72fcca58-7326193a7e0mr26223018b3a.22.1739981678255; 
 Wed, 19 Feb 2025 08:14:38 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732581df0bbsm9850367b3a.156.2025.02.19.08.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 08:14:37 -0800 (PST)
Date: Wed, 19 Feb 2025 08:14:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v13 00/28] [v13]drivers/net Add Support mucse N10 Pmd
 Driver
Message-ID: <20250219081435.3c780063@hermes.local>
In-Reply-To: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
References: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
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

On Wed, 19 Feb 2025 15:57:01 +0800
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
> v13:
>   * Supplementary document about n10 network card characteristics.
>   * update release_25_03.rst.
>   * fixed the code style advisea Stephen Hemminger.
>   * fixed the code issue check PVS-stdio for Static compilation error.
> 
> v12:
>   * fixed __rte_packed __deprecated__ compile issue.
> 
> v11:
>   * fixed array-bounds issue when used rte_memcpy src addr is
>   * not enough to hold align dst.
>   * improve efficient_code advised by Stephen
> 
> v10:
>   * fixed mingw windows meson issue
>   * rnp not support windows for now.
> 
> v9:
>   * fixed commit log format check by devtools.
>   * fixed code compile issue.
> 
> v8:
>   * fixed codespell issue.
>   * fixed MAINTAINERS file
> 
> v7:
>   * add support nic basic feature such as rss vlan strip/filter,
>   * mtu-change recv/send scater-recv/mutltiple-send.
>   * fixed code rationality, advised by Ferruh Yigit.
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
>   net/rnp: add support MAC promisc mode
>   net/rnp: add queue setup and release operations
>   net/rnp: add queue stop and start operations
>   net/rnp: add support device start stop operations
>   net/rnp: add RSS support operations
>   net/rnp: add support link update operations
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
>   net/rnp: support VLAN offloads
>   net/rnp: add support VLAN filters operations
>   net/rnp: add queue info operation
>   net/rnp: support Rx/Tx burst mode info
> 
>  .mailmap                               |    1 +
>  MAINTAINERS                            |    6 +
>  doc/guides/nics/features/rnp.ini       |   33 +
>  doc/guides/nics/img/mucse_nic_port.svg | 4023 ++++++++++++++++++++++++
>  doc/guides/nics/index.rst              |    1 +
>  doc/guides/nics/rnp.rst                |  124 +
>  doc/guides/rel_notes/release_25_03.rst |    5 +
>  drivers/net/meson.build                |    1 +
>  drivers/net/rnp/base/meson.build       |   17 +
>  drivers/net/rnp/base/rnp_bdq_if.c      |  398 +++
>  drivers/net/rnp/base/rnp_bdq_if.h      |  154 +
>  drivers/net/rnp/base/rnp_bitrev.h      |   64 +
>  drivers/net/rnp/base/rnp_common.c      |  103 +
>  drivers/net/rnp/base/rnp_common.h      |   17 +
>  drivers/net/rnp/base/rnp_crc32.c       |   37 +
>  drivers/net/rnp/base/rnp_crc32.h       |   10 +
>  drivers/net/rnp/base/rnp_dma_regs.h    |   68 +
>  drivers/net/rnp/base/rnp_eth_regs.h    |   91 +
>  drivers/net/rnp/base/rnp_fw_cmd.c      |  162 +
>  drivers/net/rnp/base/rnp_fw_cmd.h      |  357 +++
>  drivers/net/rnp/base/rnp_hw.h          |  136 +
>  drivers/net/rnp/base/rnp_mac.c         |  358 +++
>  drivers/net/rnp/base/rnp_mac.h         |   34 +
>  drivers/net/rnp/base/rnp_mac_regs.h    |  208 ++
>  drivers/net/rnp/base/rnp_mbx.c         |  510 +++
>  drivers/net/rnp/base/rnp_mbx.h         |   58 +
>  drivers/net/rnp/base/rnp_mbx_fw.c      |  493 +++
>  drivers/net/rnp/base/rnp_mbx_fw.h      |   24 +
>  drivers/net/rnp/base/rnp_osdep.h       |  172 +
>  drivers/net/rnp/meson.build            |   27 +
>  drivers/net/rnp/rnp.h                  |  258 ++
>  drivers/net/rnp/rnp_ethdev.c           | 1845 +++++++++++
>  drivers/net/rnp/rnp_link.c             |  439 +++
>  drivers/net/rnp/rnp_link.h             |   52 +
>  drivers/net/rnp/rnp_logs.h             |   36 +
>  drivers/net/rnp/rnp_rss.c              |  367 +++
>  drivers/net/rnp/rnp_rss.h              |   44 +
>  drivers/net/rnp/rnp_rxtx.c             | 1818 +++++++++++
>  drivers/net/rnp/rnp_rxtx.h             |  162 +
>  39 files changed, 12713 insertions(+)
>  create mode 100644 doc/guides/nics/features/rnp.ini
>  create mode 100644 doc/guides/nics/img/mucse_nic_port.svg
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

Thank you for the update, due to release timing it is unlikely this
will be able to be in 25.03 release.

