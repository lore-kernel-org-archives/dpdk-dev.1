Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD71DCA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:36:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A32F44021F;
	Fri,  9 Oct 2026 01:36:53 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id D5D8C40144
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:36:52 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-88d48da248eso2835135b3a.1
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502612;
 x=1792107412; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wsSO5eDN32kyXwPhqSTxbP+zHudTdboLFYVLS+cW8UM=;
 b=qT+hs42EixQzdKHh//7kwtlYCMotVVx0baWfhScS93E5qrutjQRB519YH5b88tqT2Q
 H4xvdvlFrS/C99wpUzXz8xnqlWN7+XAPm5yK6OeW6YdEPUSfPnq9r5LPOERuvHsL6Yi1
 O/qcjfEDTByNi+Hg+wvqm5nSfxA0i0HyMMKZzmaZKJmT4cDV/a4U3FurxA2LU3MInwHz
 pAsg7nc8yyGXc34/MK752FYbi2YvDKRKya60kHMVdAN7o1iyZDaI37rn+Z8VVz/I9KR2
 c/alUDrwog0mYx0kvYicyhSR4yzQ+mmRgGvELujYG3RNAPXD978C6847HHd5ie6L0LiP
 ciQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502612; x=1792107412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wsSO5eDN32kyXwPhqSTxbP+zHudTdboLFYVLS+cW8UM=;
 b=KnyQPHAVfmwyrvLFVI44pLomNM3hJPj5JDNTxevvH8tcdSu1rh/StBxCg7MOE2O6gQ
 q0A/WjrCowypy7k2LmYR5hufdqDJdbE+pfIjS97RUaggRP2Z6u61l9h6CH7nesAgiJUd
 CFhJwP/V1VocmYJ3/lGVZuDnNrsgEGug24KG7GbXKo4jG1zLMdbRodNy3IopQkIMHEDB
 tQM0wBS1Sf05qngL2JXba0YwtsTzaxlD2ZPQl3BKcv4Npgzn9tri+H8Tuw11YOF/GlWp
 I9qLOGReYBsWxv6oxmL9QDPnhxOwzosuenb0BNWze0rcNJlm5bOG2dazVueLnNd7k9Ih
 p+yw==
X-Gm-Message-State: AFq9FYJVpBC29NMA7quoJ13Om/uMDr+TV0BNGCIQPv2b8CYjFtzXBS6T
 dExgSMSAJxEWRhM8q+U0JeIOXGzgJvrrsETLohFgPt3WESsmZHUPeDVmZ7i7uZDKI3jLc0vdExz
 dZJ8P2Ns=
X-Gm-Gg: AYBFou2yFVjT4yoh9QqFAl5/6OLBlckcH+o6l1801czVsmO7k/NcdRf2JIMIJWrQ615
 EnSlQM844z/sHQ4KBToPc4dqbe9zjrAO9y9W5xyMGTPFm5uaz9Gdo7xREHErsw8pjYCMMfggKer
 TnA2c/yOsG+d0U3IIL+8uJhmaP2JnAzZ4GxMdrL1dkPu37BFOuwpnmOQGa/hP2CI0yof0W9GNa8
 qbd4rWLoyo7MKNMAsQQN9wNp/oG1cbkDpB1EUbZjLsH4kT+zsa1hnhUSrr3VUPA2imYSLNHnmsi
 cjYP+yWryzgre8zcRB7wsPyQ7E1uSRotGoZ9/iyvjRh8a3hKBBWzOnKBYJ7AgSDPanuWFeyICsW
 g9OuTV71XOK+9ItrXs4yQaENm6juVFOD1ijAIcDRpl6fkM4pOOryHWkCf7o8GwiHadFRLlenYrP
 fUJ2SBDldEteecKyOLJzQQoklU/dOOWpe+2kSca+abo2uI3KoOdjiOhdcmnPrudLy1oygM15L/i
 /+xADKJ9OZryducffDUoJDE6P8hqUGOw0FFtDE=
X-Received: by 2002:a05:6a00:908c:b0:87a:9335:c93f with SMTP id
 d2e1a72fcca58-897c79e217emr42660b3a.43.1791502611638; 
 Thu, 08 Oct 2026 16:36:51 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:36:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/29] remove rte_smp_XX barriers
Date: Thu,  8 Oct 2026 16:34:53 -0700
Message-ID: <20261008233649.1260843-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This patch series completes the removal of rte_smp_XX barrier
functions that was announced over five years ago (20.05).

In the process several cases of race conditions were found
and fixed. See patches 3, 4, and 17. These are marked with Fixes:
tags and Cc: stable. Patch 2 is also marked for stable because
3 and 4 do not build with clang without it.

Most of this is mechanical with AI assistance, so strongly
encourage maintainers to take a good look.

Functional and build run on x86 and ARM native.
Barriers ordering memory writes against a device doorbell now use
rte_io_wmb() rather than an SMP barrier; on arm64 that is dmb oshst
instead of dmb ishst. In some cases the C11 form gives marginal
performance gains.

The lock-free stack patch measured faster than the generic version
it replaces, up to 63% on a 32-core x86 box; the numbers are in
that patch's commit message.

The RFC removed the barrier test outright. Konstantin pointed out it
still covers the custom x86 seq_cst fence, so patch 19 now keeps the
Peterson lock test and converts it to C11 atomics instead, with the
fence and rte_mb() as its two cases. It comes before the x86 patch
that drops rte_smp_mb(), since it holds the last caller and x86
builds with tests enabled would otherwise break for the rest of the
series.

As a side note, Konstantin asked whether the two versions of
__rte_ring_headtail_move_head_st() could be merged into one, keeping
only the _mt variants separate. That looks reasonable but is out of
scope here; left for a follow-up.

v3 - rebase
   - address review feedback
   - detailed review of bpf change
   - reword overly verbose AI verbiage
   - combine patches where possible

Stephen Hemminger (29):
  bpf: replace deprecated SMP barriers with C11 fences
  bus/vmbus: remove packed attribute from ring buffer
  bus/vmbus: fix ring buffer ordering on weakly ordered CPUs
  bus/vmbus: fix missing acquire on receive ring index
  bus/vmbus: replace SMP barriers with C11 memory fences
  drivers/baseband: convert rte_smp_rmb to fence
  net/hinic: replace rte_smp_rmb
  net/intel: replace rte_smp_rmb
  net/virtio: replace rte_smp_rmb
  net/thunderx: replace deprecated SMP barriers
  stack: always use C11 memory model implementation
  ring: replace SMP read barrier with C11 acquire fence
  crypto/virtio: update comment reference to rte_smp_rmb
  crypto/caam_jr: replace rte_smp_rmb
  crypto/caam_jr: use IO barrier before job ring doorbell
  crypto/octeontx: use IO barrier before doorbell
  event/sw: fix unlinks in progress counter races
  event/sw: replace SMP barriers with C11 atomics
  test/barrier: convert to C11 atomics
  eal/x86: move optimized fence out of SMP barrier
  common/octeontx: remove redundant barrier in mbox
  mempool/octeontx: use IO barrier in pool destroy
  event/octeontx: replace deprecated SMP barriers
  event/dpaa2: replace deprecated barrier in selftest
  event/dsw: replace SMP barriers with release fences
  event/opdl: replace SMP barriers with C11 atomics
  net/virtio: replace deprecated barrier in avail index update
  eal: remove stale SMP barrier in rte_service
  eal: remove rte_smp_XX

 app/test/test_barrier.c                       |  71 ++++----
 devtools/checkpatches.sh                      |   8 -
 doc/guides/rel_notes/deprecation.rst          |   8 -
 doc/guides/rel_notes/release_26_11.rst        |  11 ++
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |   8 +-
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |  12 +-
 drivers/bus/vmbus/private.h                   |  12 +-
 drivers/bus/vmbus/rte_vmbus_reg.h             |   4 +-
 drivers/bus/vmbus/vmbus_bufring.c             |  22 +--
 drivers/bus/vmbus/vmbus_channel.c             |  13 +-
 drivers/common/octeontx/octeontx_mbox.c       |   6 +-
 drivers/crypto/caam_jr/caam_jr.c              |   5 +-
 .../crypto/octeontx/otx_cryptodev_hw_access.h |   4 +-
 drivers/crypto/virtio/virtqueue.h             |   8 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |   4 +-
 drivers/event/dsw/dsw_event.c                 |   8 +-
 drivers/event/octeontx/ssovf_evdev_selftest.c |   6 +-
 drivers/event/octeontx/ssovf_worker.c         |   8 +-
 drivers/event/opdl/opdl_evdev.c               |   8 +-
 drivers/event/sw/sw_evdev.c                   |  37 +++--
 drivers/event/sw/sw_evdev.h                   |   2 +-
 drivers/event/sw/sw_evdev_scheduler.c         |  24 ++-
 drivers/mempool/octeontx/octeontx_fpavf.c     |   4 +-
 drivers/net/hinic/base/hinic_pmd_cmdq.c       |   3 +-
 drivers/net/hinic/base/hinic_pmd_mgmt.c       |   2 +-
 drivers/net/intel/ice/ice_rxtx.c              |   2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   2 +-
 drivers/net/thunderx/base/nicvf_hw.c          |   3 +-
 drivers/net/thunderx/base/nicvf_plat.h        |   5 +-
 drivers/net/virtio/virtqueue.h                |  22 +--
 lib/bpf/bpf_pkt.c                             |  45 ++++--
 lib/eal/arm/include/rte_atomic_32.h           |   6 -
 lib/eal/arm/include/rte_atomic_64.h           |   6 -
 lib/eal/common/rte_service.c                  |   1 -
 lib/eal/include/generic/rte_atomic.h          |  61 -------
 lib/eal/loongarch/include/rte_atomic.h        |   6 -
 lib/eal/ppc/include/rte_atomic.h              |   6 -
 lib/eal/riscv/include/rte_atomic.h            |   6 -
 lib/eal/x86/include/rte_atomic.h              |  41 ++---
 lib/ring/rte_ring_gcc_pvt.h                   |   6 +-
 lib/stack/meson.build                         |   1 -
 lib/stack/rte_stack_lf.h                      |   4 -
 lib/stack/rte_stack_lf_generic.h              | 153 ------------------
 43 files changed, 237 insertions(+), 437 deletions(-)
 delete mode 100644 lib/stack/rte_stack_lf_generic.h

-- 
2.53.0

