Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1488BCCD1BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 16:32:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 359BB40262;
	Wed, 22 Oct 2025 18:32:04 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 902F64025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:32:03 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-33226dc4fc9so6662052a91.1
 for <dev@dpdk.org>; Wed, 22 Oct 2025 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761150722;
 x=1761755522; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mPPovL4zSb/RrMGiuZ4rLn5P3Anp7Nbp4sLx8PNn68=;
 b=bGRaD0Kcok49BfzR3HLrhBnqgGf6adLn0wsEUY5EjZWjvgeftPjqYaiCaHyIoYsmf0
 kQ9DYevV4Vwd16COFDuEodMzsmUdLN419NKZcJKvWvs4Ufn9YYu54eT+fBK0o0gV5s3U
 cRNVKu3VijfHFdlmeOQR7Y1Kb/wqd71eyMRC6Dhecqs+PQ0a+DEjqULrvbbkG2JJSxV0
 u5wfJ12Ir7fyFs7ak48NB7eG4ziMwdB66YJ3ZMJe1RZFFQiyEgmy5S57mxZgEumQV3Uv
 toDOz6w/+xjGOaLR9LVyYkSdVK2lyzC1vGiEa9/T14slfguexGSWCDWJF8PpOJYj+yzB
 eXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761150722; x=1761755522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mPPovL4zSb/RrMGiuZ4rLn5P3Anp7Nbp4sLx8PNn68=;
 b=Gy3rIrlJzogyi9HcQqAifm4Gjj8Ujo8J/ZVik/PCjXLfbDjYmnEl2dQbdFF8ZvTkGv
 +vvPVHyQnaOExWDPJJcWUnh7SO7iWkUNd6kT7pLUw+qUoEDQ05lRone9gCLq/C6Hm5Ic
 U8XpAUzyoVCxNmhreryR3UNOmkB3DFyExQW3ZPAxrwIMdEmXRTWPF9qywnXczm3OPAF9
 hjsTvDmKZ741euMgA8zZaNmlre+3HNC9oFRNgpyr5uM62wWPKQf7wLtwM1LsqAnBhUiy
 z6j30LHmvJPQZIclfvDmDxQnkuTh1CCnVRkZb8/AX1eIwIiPRk9GvTFjNCPFOpHAOUCZ
 V4MA==
X-Gm-Message-State: AOJu0Yw7kj3puzYnvnuofM7NXc1TmqE7+iGbiDlq1K5KuVK4fKLWLOh8
 Fi7gvUGubwVcOYuJOVZXi5vagO8QDp3pJurbVheyVdNPkoh7vL9fguqUkVCLvrjRywo=
X-Gm-Gg: ASbGncuoLhGmkpQPwagzVcc+j5KBqndgIpbUlfeD7HnhZ43Ae8GgVu5tVyxqZzGkl8m
 LvciFqBwPIxRsJ9w29ChRlTGR9dDv4Rhi7NXo3RStOjoJT8LJYBR45anxTTX5l8NUulaYDNmVsM
 Eo/N8Rwfh2L3QtZ8izYylrqvGo6PMVlsLM4JGLoYxWvLtCZhoYURC1FbQaQwTtGyt5/0x3Ge0Bn
 ScZQYqQhqenITTmVpm9ArhSeE4dPqNG9yccjalGcxLpSiFqipqNyhaqgN0p0Ykhy23ZRWzPlLiG
 jNLMN5HOyUukKw962jE8OEvuiCidnSnpLLhZV4gqu+AhMOby6tK74Tb5aTfzkMVayaY9Ka34OiP
 vzZA+Z98Jor9KJRW6Hd3gu54kvdFN0AESx4Rfcgx1PRYXQMvlH72fzYA819wn2+z9PFO1r/1Rdj
 eqWg9G5poJcLRrm1E+R5Eui4WeI8TNrQZ7e8sHTIvdBtGBmTGZYfm3S+9x+wpL
X-Google-Smtp-Source: AGHT+IEqKpjVVEz7kvexRzSaArlZu21KMz/DHpWm+rKqMiLPtimpUN3NTnDdbR+q3hme7HfDzJmBMA==
X-Received: by 2002:a17:90b:180a:b0:329:7285:6941 with SMTP id
 98e67ed59e1d1-33bcf8e4e35mr29928432a91.19.1761150722279; 
 Wed, 22 Oct 2025 09:32:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33e224a2640sm2989639a91.16.2025.10.22.09.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:32:02 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:32:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net
Subject: Re: [PATCH v3 0/7] remove deprecated queue stats
Message-ID: <20251022093200.6525fb91@phoenix.lan>
In-Reply-To: <20251003110201.1541183-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
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

On Fri,  3 Oct 2025 12:01:54 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> NOTE: as called out below, on apply patches 3-6 should be squashed. They
>       are separated out here for easier review!
> 
> Since DPDK 20.11 release, the use of queue stats inside the rte_eth_stats
> structure has been deprecated with the intention to remove them. Sadly,
> despite 5 years passing that has still not been done. This patchset
> finally attempts to fix that situation and remove the queue stats fields.
> 
> The biggest complication here is the fact that, as part of the deprecation,
> a new driver flag was added which caused ethdev to automatically add the
> queue stats into xstats. While this was good, in that it allowed quick use
> of xstats for getting queue statistics, it now causes lots of problems
> because we have 35 drivers (by a rough count using grep) which rely on this
> functionality to export their queue stats via xstats. This means that if we
> drop the queue stats fields from the regular stats structure, then 35
> drivers will lose *all* queue stats reporting functionality! This is not an
> acceptable situation IMHO. [And in one patchset trying to change all 35
> drivers to directly export via xstats is not feasible either, since adding
> extra xstats can be very complicated at times.]
> 
> Therefore, we need to make changes that a) removes the queue fields from
> the regular stats structure, while also b) continuing to allow the
> individual driver stats_get functions return those stats to ethdev for
> filling in. I tried a number of approaches here to find one that was most
> feasible to implement for large numbers of drivers, so that either scripts
> or AI assistants could automate a lot of the changes. The most feasible
> approach I found was to define a DPDK-internal queue-stats-only structure,
> which would be passed as a 3rd parameter to the drivers' stats_get
> functions. When calling stats_get from ethdev, this third parameter would
> be NULL, but for gathering xstats, it would be non-NULL for drivers which
> have the RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS flag set.
> 
> For this set, I've separated out the driver changes from the ethdev changes
> and the app changes, since the driver changes are so numerous, making the
> rest hard to review. In order to ensure clean compilation and git history,
> patches 3 through 6 should be squashed into a single one on apply.
> 
> Beyond these patches, more cleanup should/could be done:
> * ensure that any drivers which don't set the AUTOFILL flag have the qstats
>   parameter set as __rte_unused.
> * For those that do use the AUTOFILL flag, we should ensure that they
>   actually do fill in the stats, and not just set them to zero. (First two
>   patches here fix that for a couple of Intel drivers)
> * then work to reduce the number of drivers which use the flag to set the
>   xstats, with a view to completely removing the queue stats from regular
>   stats functions.
> 
> ---
> 
> V3:
> * added deprecation of the queue stats mapping functions at as final
>   patch at the end.
> 
> Bruce Richardson (7):
>   net/ice: don't report empty queue xstats
>   net/ipn3ke: drop unsupported per-queue xstats
>   ethdev: remove queue stats from ethdev stats structure
>   drivers/net: update to remove queue stats from eth stats
>   app: remove queue stats from eth stats
>   doc: update docs for ethdev changes
>   ethdev: deprecate queue stats mapping functions
> 
>  app/proc-info/main.c                          |  16 ---
>  app/test-pmd/cmdline.c                        |  57 --------
>  app/test-pmd/config.c                         |  36 -----
>  app/test/virtual_pmd.c                        |   3 +-
>  config/rte_config.h                           |   1 -
>  doc/guides/rel_notes/deprecation.rst          |  13 +-
>  doc/guides/rel_notes/release_25_11.rst        |   6 +
>  drivers/net/af_packet/rte_eth_af_packet.c     |  13 +-
>  drivers/net/af_xdp/rte_eth_af_xdp.c           |  35 +++--
>  drivers/net/ark/ark_ethdev.c                  |  36 +++--
>  drivers/net/ark/ark_ethdev_rx.c               |  14 +-
>  drivers/net/ark/ark_ethdev_rx.h               |   3 +-
>  drivers/net/ark/ark_ethdev_tx.c               |  12 +-
>  drivers/net/ark/ark_ethdev_tx.h               |   3 +-
>  drivers/net/atlantic/atl_ethdev.c             |  19 +--
>  drivers/net/atlantic/atl_types.h              |   1 +
>  drivers/net/avp/avp_ethdev.c                  |  20 ++-
>  drivers/net/axgbe/axgbe_ethdev.c              |  22 +--
>  drivers/net/axgbe/axgbe_ethdev.h              |   1 +
>  drivers/net/bnx2x/bnx2x_ethdev.c              |   3 +-
>  drivers/net/bnxt/bnxt_reps.c                  |  14 +-
>  drivers/net/bnxt/bnxt_reps.h                  |   2 +-
>  drivers/net/bnxt/bnxt_stats.c                 | 133 ++++++++++--------
>  drivers/net/bnxt/bnxt_stats.h                 |   2 +-
>  drivers/net/bonding/rte_eth_bond_pmd.c        |  14 +-
>  drivers/net/cnxk/cnxk_ethdev.h                |   3 +-
>  drivers/net/cnxk/cnxk_rep.h                   |   3 +-
>  drivers/net/cnxk/cnxk_rep_ops.c               |  15 +-
>  drivers/net/cnxk/cnxk_stats.c                 |  49 ++++---
>  drivers/net/cxgbe/cxgbe_ethdev.c              |   3 +-
>  drivers/net/cxgbe/cxgbevf_ethdev.c            |   3 +-
>  drivers/net/dpaa/dpaa_ethdev.c                |   3 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c              |  28 ++--
>  drivers/net/ena/ena_ethdev.c                  |  46 +++---
>  drivers/net/enetc/enetc_ethdev.c              |   4 +-
>  drivers/net/enetfec/enet_ethdev.c             |   3 +-
>  drivers/net/enic/enic.h                       |   3 +-
>  drivers/net/enic/enic_ethdev.c                |   4 +-
>  drivers/net/enic/enic_main.c                  |   3 +-
>  drivers/net/enic/enic_vf_representor.c        |   3 +-
>  drivers/net/failsafe/failsafe_ether.c         |   9 --
>  drivers/net/failsafe/failsafe_ops.c           |   3 +-
>  drivers/net/gve/gve_ethdev.c                  |   4 +-
>  drivers/net/hinic/hinic_pmd_ethdev.c          |  64 ++++++---
>  drivers/net/hns3/hns3_stats.c                 |   4 +-
>  drivers/net/hns3/hns3_stats.h                 |   3 +-
>  drivers/net/intel/cpfl/cpfl_ethdev.c          |   3 +-
>  drivers/net/intel/e1000/em_ethdev.c           |   7 +-
>  drivers/net/intel/e1000/igb_ethdev.c          |  14 +-
>  drivers/net/intel/e1000/igc_ethdev.c          |  33 +++--
>  drivers/net/intel/fm10k/fm10k_ethdev.c        |  27 ++--
>  drivers/net/intel/i40e/i40e_ethdev.c          |   5 +-
>  drivers/net/intel/i40e/i40e_vf_representor.c  |   2 +-
>  drivers/net/intel/iavf/iavf_ethdev.c          |   5 +-
>  drivers/net/intel/ice/ice_dcf_ethdev.c        |   3 +-
>  drivers/net/intel/ice/ice_ethdev.c            |   7 +-
>  drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
>  drivers/net/intel/ipn3ke/ipn3ke_representor.c |  14 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  29 ++--
>  drivers/net/ionic/ionic_ethdev.c              |   6 +-
>  drivers/net/ionic/ionic_lif.c                 |  35 +++--
>  drivers/net/ionic/ionic_lif.h                 |   3 +-
>  drivers/net/mana/mana.c                       |  15 +-
>  drivers/net/memif/rte_eth_memif.c             |  15 +-
>  drivers/net/mlx4/mlx4.h                       |   3 +-
>  drivers/net/mlx4/mlx4_ethdev.c                |  17 +--
>  drivers/net/mlx5/mlx5.h                       |   3 +-
>  drivers/net/mlx5/mlx5_stats.c                 |  17 +--
>  drivers/net/mvneta/mvneta_ethdev.c            |   5 +-
>  drivers/net/mvpp2/mrvl_ethdev.c               |  23 +--
>  drivers/net/netvsc/hn_ethdev.c                |  17 +--
>  drivers/net/netvsc/hn_var.h                   |   3 +-
>  drivers/net/netvsc/hn_vf.c                    |   3 +-
>  drivers/net/nfp/flower/nfp_flower.c           |   8 +-
>  .../net/nfp/flower/nfp_flower_representor.c   |  19 +--
>  .../net/nfp/flower/nfp_flower_representor.h   |   3 +
>  drivers/net/nfp/nfp_net_common.c              |  46 +++---
>  drivers/net/nfp/nfp_net_common.h              |   4 +-
>  drivers/net/ngbe/ngbe_ethdev.c                |  53 +++----
>  drivers/net/ngbe/ngbe_ethdev_vf.c             |   5 +-
>  drivers/net/ntnic/ntnic_ethdev.c              |  22 +--
>  drivers/net/null/rte_eth_null.c               |  15 +-
>  drivers/net/octeon_ep/otx_ep_ethdev.c         |  17 ++-
>  drivers/net/octeontx/octeontx_ethdev.c        |   3 +-
>  drivers/net/pcap/pcap_ethdev.c                |  23 +--
>  drivers/net/pfe/pfe_ethdev.c                  |   3 +-
>  drivers/net/qede/qede_ethdev.c                |  23 ++-
>  drivers/net/r8169/r8169_ethdev.c              |   6 +-
>  drivers/net/ring/rte_eth_ring.c               |  13 +-
>  drivers/net/rnp/rnp_ethdev.c                  |  15 +-
>  drivers/net/sfc/sfc_ethdev.c                  |   3 +-
>  drivers/net/sfc/sfc_repr.c                    |   3 +-
>  drivers/net/tap/rte_eth_tap.c                 |  23 +--
>  drivers/net/thunderx/nicvf_ethdev.c           |  27 ++--
>  drivers/net/txgbe/txgbe_ethdev.c              |  53 +++----
>  drivers/net/txgbe/txgbe_ethdev_vf.c           |   5 +-
>  drivers/net/vhost/rte_eth_vhost.c             |  26 ++--
>  drivers/net/virtio/virtio_ethdev.c            |  23 +--
>  drivers/net/vmxnet3/vmxnet3_ethdev.c          |  20 +--
>  drivers/net/xsc/xsc_ethdev.c                  |  19 +--
>  drivers/net/zxdh/zxdh_ethdev_ops.c            |  39 ++---
>  drivers/net/zxdh/zxdh_ethdev_ops.h            |   3 +-
>  lib/ethdev/ethdev_driver.h                    |  35 ++++-
>  lib/ethdev/ethdev_private.c                   |  27 ++++
>  lib/ethdev/ethdev_private.h                   |   5 +
>  lib/ethdev/rte_ethdev.c                       |  37 ++---
>  lib/ethdev/rte_ethdev.h                       |  13 +-
>  lib/ethdev/rte_ethdev_telemetry.c             |  20 +--
>  108 files changed, 921 insertions(+), 794 deletions(-)
> 

Added to next-net. Fixed the newer drivers and squashed a couple commits
so that each commit builds.
