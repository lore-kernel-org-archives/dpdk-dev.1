Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB0D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 07:58:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86BC5402C3;
	Tue, 20 Jan 2026 08:58:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C2BE040273
 for <dev@dpdk.org>; Tue, 20 Jan 2026 08:58:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768895914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mx/9OhzzwdI4wYEO8tHbrXzfdj5c6X5cb4Y3X9hK4oc=;
 b=DWwDSuGSnMG+9IvTADPEWBYj856cWx5jO+ib9L+yafYQ+WkfJ79goHb8w+P3toZEMxk1WE
 nuvQkqqXoTgoIjygvee7eHGD4etq9tE5dJ5eMoNmhnc9gz1WiW4NfZviAwlC6CFdNlFssK
 in78DuOUGSCccEGNx36oWRMd1w7ncSo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-wHXnEfMONR2V7ZNyKffe5A-1; Tue, 20 Jan 2026 02:58:32 -0500
X-MC-Unique: wHXnEfMONR2V7ZNyKffe5A-1
X-Mimecast-MFC-AGG-ID: wHXnEfMONR2V7ZNyKffe5A_1768895911
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59b6fb01675so6126882e87.2
 for <dev@dpdk.org>; Mon, 19 Jan 2026 23:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768895911; x=1769500711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mx/9OhzzwdI4wYEO8tHbrXzfdj5c6X5cb4Y3X9hK4oc=;
 b=Cl9DSkUZjtl+EKE0E/yJef8WiGx8bCz+lc/MtBQdNDmUQsvZ1v4cdxxZ8w+fsqYDpi
 L3YHCFSvMM13u1nbyYL75mtJaSgbnujIuf307PTXd/ZDAICU+NgdfsOrQ5A+QecmXk03
 pRM5NO9AVxkordj4hNxCTvw/VrxyXkpjEHxW3eTiWA3HkeBrEFPI3RnhNlXh35h6gg7I
 /V/HlmlbDE1e1QrNXBk56s6Isj/EdYhyci3tmPOF+syZ24Mi1s8PAhjMbsqy9BEiRsQc
 zskjmFODVeaGamrbEBMveHV7MXLlNS+czjd12cL7sDRo+8vFbKEsvMHDw4jlbIYGXqKI
 hQnA==
X-Gm-Message-State: AOJu0YywLBBx/2854qkvZ0+ih8886hajluirqrJd9hzGcn5Jn6w2Lqjs
 MuPStpFwptblekmmgaWcu6bccUXj0NGVwY659gx9DAkBstHA36+0pC4TlYK+4fY1Ei5fofMFGfG
 bRPhl0rnramV2xaCXWY295fDie8pEhLJGE/FC0rIA8C6hKGOgD04ItqLLQeHVaZuFURO33dT/zg
 4O49AU6E4CvNQt2zmdRgg=
X-Gm-Gg: AZuq6aJZnyr5yiViqFs1bSuhatzH6pfeG82alDv34AGDo+kRO6omJYAOljOWErG2x6q
 oiyK3jBm9yatLT0f8IuS9R+3xpwXV6YY1PIGsHI4s68T1YOeOLiCG9b8ojbK3bmIAnOG13tEJqp
 UjbeDCB7NgAryw1s+yXfP2dLFoZiDynD9JP/n5YbKoAIpTv0r+ivClajQDsnA1bf556l1y
X-Received: by 2002:a05:6512:3992:b0:59c:c064:742d with SMTP id
 2adb3069b0e04-59cc0647436mr1878591e87.11.1768895910859; 
 Mon, 19 Jan 2026 23:58:30 -0800 (PST)
X-Received: by 2002:a05:6512:3992:b0:59c:c064:742d with SMTP id
 2adb3069b0e04-59cc0647436mr1878576e87.11.1768895910380; Mon, 19 Jan 2026
 23:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 20 Jan 2026 08:58:18 +0100
X-Gm-Features: AZwV_Qi1JmBQ85DIz4T9cA5FMR-dP2evKyISVGfCVcq1jjf9hAsgt1rqVQ_NiXw
Message-ID: <CAJFAV8wmt5TnrDE_KV98kY9i2t6UbGXdgx1nF6GR5FjtixHqHg@mail.gmail.com>
Subject: Re: [PATCH v4 00/31] build DPDK with Wshadow flag
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lghsXUeRnlcXZ6hoxpxnM999mLslXSvbldVRRvkKzw8_1768895911
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello Bruce,

On Wed, 14 Jan 2026 at 16:45, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> As flagged in bugs #1742, #1743 and others, much of DPDK fails to build
> when -Wshadow flag is passed to the build. This patchset fixes many issues
> of this nature, but not all, in the hopes we can move towards enabling that
> warning flag for all components for DPDK in future. This patchset fixes the
> following components in DPDK:
>
> * all libraries
> * Intel net drivers
> * all apps in the "app" folder
>
> For the rest of the drivers and example applications, any component which
> does not build successfully with the shadow warning enabled has it
> explicitly disabled via cflags. Then the last patch adds -Wshadow to the
> global DPDK build, which should prevent any regressions in components which
> are already working.
>
> At that point, we should not have any regressions and we can, over time,
> reduce the number of components needing the -Wno-shadow flag.
>
> V4:
> * Updates follow AI review:
>   - improve variable naming in min/max fns
>   - remove extra blank line
> * rebase on latest main
>
> v3:
> * rebase on 25.11 release.
>
> RFC v2:
> * take patch from Stephen for RTE_MIN/MAX fixes
> * add additional fixes to clear clang warnings - it's a lot stricter than
>   gcc in this regard, and flags more issues.
> * extend app cleanup to all apps, not just testpmd
> * add per-component disabling, and add global enable flag at the end.
>
> Bruce Richardson (30):
>   eal: fix variable shadowing
>   ethdev: fix variable shadowing issues
>   eventdev: fix variable shadowing issues
>   net: remove shadowed variable
>   pipeline: fix variable shadowing
>   table: fix issues with variable shadowing
>   power: rename variable to eliminate shadowing
>   pcapng: rename variable to fix shadowing
>   bbdev: fix variable shadowing
>   bus/pci: remove shadowed variables
>   net/intel: rename function param to avoid shadow warnings
>   net/e1000: fix build with shadow warnings enabled
>   net/i40e: fix build with shadow warnings enabled
>   net/ice: fix build with shadow warnings enabled
>   net/cpfl: fix build with shadow warnings enabled
>   net/ixgbe: fix build with shadow warnings enabled
>   app/testpmd: fix build with shadow warnings enabled
>   app/graph: fix build with shadow warnings enabled
>   app/pdump: fix warning about shadowed variable
>   app/test-bbdev: remove shadow warning from next max calls
>   app/test-compress-perf: rename local vars to fix shadowing
>   app/test-crypto-perf: rename local vars to fix shadowing
>   app/test-eventdev: fix build with shadow warnings enabled
>   app/test-flow-perf: remove unneeded variable
>   app/test-security-perf: fix build with shadow warnings
>   app/test-pipeline: remove unnecessary variable
>   drivers: disable variable shadowing warnings for drivers
>   app/test: disable shadowing warnings for unit tests
>   examples: ignore variable shadowing warnings
>   build: enable shadowed variable warnings
>
> Stephen Hemminger (1):
>   eal: add more min/max helpers
>
>  app/graph/conn.c                              | 134 +++++++++---------
>  app/pdump/main.c                              |  12 +-
>  app/test-bbdev/test_bbdev_perf.c              |   7 +-
>  app/test-compress-perf/main.c                 | 122 ++++++++--------
>  .../cperf_test_pmd_cyclecount.c               |   6 +-
>  app/test-eventdev/evt_main.c                  |   6 +-
>  app/test-eventdev/test_atomic_queue.c         |   6 +-
>  app/test-eventdev/test_perf_common.c          |   4 +-
>  app/test-flow-perf/main.c                     |   1 -
>  app/test-pipeline/main.c                      |   1 -
>  app/test-pmd/cmdline_flow.c                   |  42 +++---
>  app/test-pmd/config.c                         |  15 +-
>  app/test-pmd/parameters.c                     |  38 +++--
>  app/test-pmd/testpmd.c                        |   2 +-
>  app/test-security-perf/test_security_perf.c   |  42 +++---
>  app/test/meson.build                          |   1 +
>  app/test/test_cryptodev_security_ipsec.c      |  13 +-
>  config/meson.build                            |   6 +
>  drivers/baseband/fpga_5gnr_fec/meson.build    |   2 +
>  drivers/bus/fslmc/meson.build                 |   2 +
>  drivers/bus/pci/linux/pci.c                   |   1 -
>  drivers/bus/pci/linux/pci_vfio.c              |   2 +-
>  drivers/bus/pci/windows/pci.c                 |   1 -
>  drivers/common/cnxk/meson.build               |   1 +
>  drivers/common/qat/meson.build                |   1 +
>  drivers/compress/nitrox/meson.build           |   2 +
>  drivers/crypto/cnxk/meson.build               |   1 +
>  drivers/crypto/octeontx/meson.build           |   1 +
>  drivers/crypto/openssl/meson.build            |   1 +
>  drivers/crypto/scheduler/meson.build          |   1 +
>  drivers/dma/dpaa2/meson.build                 |   2 +
>  drivers/event/cnxk/meson.build                |   1 +
>  drivers/event/dlb2/meson.build                |   2 +
>  drivers/event/sw/meson.build                  |   1 +
>  drivers/net/axgbe/meson.build                 |   2 +-
>  drivers/net/bnxt/meson.build                  |   1 +
>  drivers/net/bonding/meson.build               |   1 +
>  drivers/net/cnxk/meson.build                  |   1 +
>  drivers/net/cxgbe/meson.build                 |   1 +
>  drivers/net/dpaa/meson.build                  |   1 +
>  drivers/net/dpaa2/meson.build                 |   1 +
>  drivers/net/ena/meson.build                   |   2 +
>  drivers/net/enetfec/meson.build               |   2 +
>  drivers/net/enic/meson.build                  |   2 +
>  drivers/net/failsafe/meson.build              |   1 +
>  drivers/net/intel/common/rx.h                 |   6 +-
>  drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |   2 -
>  drivers/net/intel/cpfl/cpfl_flow_parser.c     |   6 +-
>  drivers/net/intel/cpfl/cpfl_fxp_rule.h        |   2 -
>  drivers/net/intel/cpfl/cpfl_representor.h     |   2 +-
>  drivers/net/intel/e1000/igc_ethdev.c          |   6 +-
>  drivers/net/intel/i40e/i40e_ethdev.h          |  10 +-
>  drivers/net/intel/ice/ice_ethdev.c            |   6 +-
>  drivers/net/intel/ixgbe/ixgbe_fdir.c          |   7 +-
>  drivers/net/mlx5/meson.build                  |   1 +
>  drivers/net/ntnic/meson.build                 |   3 +
>  drivers/net/pfe/meson.build                   |   3 +
>  drivers/net/qede/meson.build                  |   3 +
>  drivers/net/txgbe/meson.build                 |   1 +
>  drivers/net/zxdh/meson.build                  |   3 +
>  drivers/raw/ifpga/meson.build                 |   2 +
>  drivers/vdpa/mlx5/meson.build                 |   1 +
>  examples/bbdev_app/meson.build                |   1 +
>  examples/bond/meson.build                     |   1 +
>  examples/dma/meson.build                      |   1 +
>  examples/ethtool/meson.build                  |   1 +
>  examples/eventdev_pipeline/meson.build        |   1 +
>  examples/flow_filtering/meson.build           |   1 +
>  examples/ip_pipeline/meson.build              |   1 +
>  examples/ipsec-secgw/meson.build              |   1 +
>  examples/l2fwd-crypto/meson.build             |   1 +
>  examples/l2fwd-event/meson.build              |   1 +
>  examples/l2fwd-jobstats/meson.build           |   1 +
>  examples/l2fwd-keepalive/meson.build          |   1 +
>  examples/l3fwd-graph/meson.build              |   1 +
>  examples/l3fwd-power/meson.build              |   1 +
>  examples/l3fwd/meson.build                    |   1 +
>  .../client_server_mp/mp_server/meson.build    |   1 +
>  examples/packet_ordering/meson.build          |   1 +
>  examples/ptpclient/meson.build                |   1 +
>  examples/qos_sched/meson.build                |   1 +
>  .../server_node_efd/efd_server/meson.build    |   1 +
>  examples/vhost/meson.build                    |   1 +
>  .../vm_power_manager/guest_cli/meson.build    |   1 +
>  examples/vm_power_manager/meson.build         |   1 +
>  examples/vmdq/meson.build                     |   1 +
>  lib/bbdev/rte_bbdev.c                         |   2 +-
>  lib/eal/common/eal_common_options.c           |  22 +--
>  lib/eal/common/eal_common_trace.c             |  89 ++++++------
>  lib/eal/common/malloc_heap.c                  |   2 +-
>  lib/eal/include/rte_common.h                  |  38 ++++-
>  lib/ethdev/ethdev_driver.c                    |   6 +-
>  lib/ethdev/rte_ethdev.c                       |   1 -
>  lib/eventdev/rte_event_eth_rx_adapter.c       |   5 +-
>  lib/eventdev/rte_event_eth_tx_adapter.c       |   8 +-
>  lib/net/net_crc_avx512.c                      |   4 +-
>  lib/pcapng/rte_pcapng.c                       |   7 +-
>  lib/pipeline/rte_swx_ctl.c                    |  11 +-
>  lib/pipeline/rte_swx_pipeline.c               |  21 ++-
>  lib/pipeline/rte_swx_pipeline_internal.h      |  10 +-
>  lib/power/rte_power_pmd_mgmt.c                |   6 +-
>  lib/table/rte_lru.h                           |  38 ++---
>  lib/table/rte_lru_arm64.h                     |  14 +-
>  lib/table/rte_lru_x86.h                       |   4 +-
>  lib/table/rte_swx_table_em.c                  |   2 -
>  lib/table/rte_swx_table_learner.c             |   4 +-
>  lib/table/rte_table_hash_key16.c              |   4 +-
>  lib/table/rte_table_hash_key32.c              |   4 +-
>  lib/table/rte_table_hash_key8.c               |   4 +-
>  109 files changed, 477 insertions(+), 412 deletions(-)

Series applied, thanks.


-- 
David Marchand

