Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D295CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:34:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 189F8402EA;
	Wed, 14 Oct 2026 00:34:57 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id BF79A40269
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:34:54 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e7e742a2c7so23440585ad.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930893;
 x=1792535693; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HWpZDhrAsXO3vQZMxfuZd9lS+SR4XrrhXLdP1Asmbi8=;
 b=fgdgL9bX6Z3hnZTNuBvpYSDpiTtR/XYMyFE4My+wGu4K2SENdLfW61+gC8lctljW41
 0AsAae9s++uYvbKMXaiCmbexz2f1+6ao3LCPwhmO61Rrgi9rCKsx0BzZv/3k25RxNEsL
 kyn2nJeOh74NrYRuq4qZEQ70Zv6zLM0FwJIjyl5I2VSBICJ8gp30RIJBmo5dDPpr42rk
 58japTY/7Gdxh6lJy0/BfA8+hlknm522sALZ+yRzX8D3fB+joL6VMA81SvUZ1euXTGuY
 6CXhoFKojcsHv7FFLvDOPMaIWfFMzRMN7HP06Tz8+7qhbgkf9GuRRKWyRCNZiMV0666u
 JyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930893; x=1792535693;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HWpZDhrAsXO3vQZMxfuZd9lS+SR4XrrhXLdP1Asmbi8=;
 b=BWpYP11PoqSQJBgvsbURoL96Cr67g72n2tDZzpRwBEz8ZTHpQ5hhcPZQpNcjiFQaVm
 kjDdjvZVVzK42zatNzyQwP1gNqNNT7CfrqfjARVKUI5/YDRzB3dzFzaxt/OYA8b5pS0q
 thSlbR57o7fsOr8TuPTg99p5v9Xl7TaUnHzksy7VKAK8haeh0+dt1WDcurNKLW3qbUZ3
 hxPo5JFGnWVWQ9fhpBVwgonOrh+f/YdhYjxxf3a/IsVnXdETy3Gon65MnXx4iuKZAfgE
 a3QCBSF+0gFLaR+5VpIU0s6zBdRRE7vnxTBmnKifEJb8BXuOSTsa3yyxBfLZkWklm9Kn
 qdFw==
X-Gm-Message-State: AFq9FYJNzgzujhE0UUXXjHkPfm9602ENtQln5f7DRbXoUfYTOJBCP76w
 u24+JbBRRLQyiN9FCLNYa+g0+MU3Mg2VblGN7xI3BkTNJs/XiBiv4FJDVUQgtmo/GGHuxOdqTJZ
 QFPdvzVE=
X-Gm-Gg: AYBFou2Ykizrpc6mq3dFrSbSdIIk5wYYUorPilj3vE0YncYeQBfPf9EdSUU1rvWSRxy
 zXTRVgqK/E+TIiZN2wDRA/n2gp1FyVeeg0dr9kzVG2VaqSbv8SlNBBlf/Zyl5vIXKz1QK8QPk6w
 I4LNz8DX38h0sUvVLxbdGvz276qnJ/xHbbA5cr8FY2E6IrCQkyO86u9BVROsA/LiuvizJDBzgpE
 mW+KMxSE7+UZzQEaX4YIVLJhX6r77dCEWKpAvoiz15RiN6X46VhhorXOW5ANjvaZ7wQ6eVonaTD
 yyvNxfiXiUbdNFSzwRqWWhr0pIACW7yKzSgXdP+yLBZ5Cl6yp9FXEnZWRaEdenFSTTwiAlx8F2m
 +8bA3mCJ/oK2L3CmXpQyJAIyboE7kyGZY11O1dnG0hksWekQ+kUOkhP63BWsewNVWBQW2nalAXA
 ixb5OI+ylt53rCYE/MTzS5CZ2NWt10Kh7Qg/3aZZ929oVELNbQeQdnPqfb3Q1k7pun2W02ENBKt
 DoTQSWRU1+NjOeGzK8Zw/PN82T2DItTQNltF9Y=
X-Received: by 2002:a17:903:1845:b0:2e5:3906:ea5d with SMTP id
 d9443c01a7336-2e8403c3f5dmr91941885ad.3.1791930893540; 
 Tue, 13 Oct 2026 15:34:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:34:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/29] remove rte_smp_XX barriers
Date: Tue, 13 Oct 2026 15:22:13 -0700
Message-ID: <20261013222410.2257622-1-stephen@networkplumber.org>
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

In the process several race conditions were found and fixed. See
patches 3, 4 and 17, marked with Fixes: and Cc: stable. Patch 2 is
also marked for stable because 3 and 4 do not build with clang
without it.

Most of this is mechanical with AI assistance, so strongly encourage
maintainers to take a good look.

Barriers ordering memory writes against a device doorbell now use
rte_io_wmb() rather than an SMP barrier; on arm64 that is dmb oshst
instead of dmb ishst. In some cases the C11 form gives marginal
performance gains.

The lock-free stack patch measured faster than the generic version it
replaces, up to 63% on a 32-core x86 box; the numbers are in that
patch's commit message.

Patch 19 keeps the Peterson lock test, converted to C11 atomics, with
the seq_cst fence and rte_mb() as its two cases. It comes before
patch 20, which holds the last rte_smp_mb() caller, so x86 builds
with tests enabled stay bisectable. Tested on x86, arm and riscv;
still untested on ppc and loongarch.

Patch 18 has no ack. Bruce, yours landed on 17; 18 changed since.

Left for follow-up: device read barriers in patches 6, 8 and 14 are
acquire fences where rte_io_rmb() would match the write side (same
generated code today, so no regression). And the net/thunderx mailbox
flags in patch 10 are plain bitfields that need to be atomic, which
is pre-existing.

v4 - rebase on main, which obsoleted the netvsc patch; address review
     comments from Konstantin, Marat, David and Wei Hu; collect tags

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
 drivers/event/sw/sw_evdev.h                   |  11 +-
 drivers/event/sw/sw_evdev_scheduler.c         |  24 ++-
 drivers/mempool/octeontx/octeontx_fpavf.c     |   4 +-
 drivers/net/hinic/base/hinic_pmd_cmdq.c       |   3 +-
 drivers/net/hinic/base/hinic_pmd_mgmt.c       |   2 +-
 drivers/net/intel/ice/ice_rxtx.c              |   2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   2 +-
 drivers/net/thunderx/base/nicvf_hw.c          |   3 +-
 drivers/net/thunderx/base/nicvf_plat.h        |   5 +-
 drivers/net/virtio/virtqueue.h                |  22 +--
 lib/bpf/bpf_pkt.c                             |  26 +--
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
 43 files changed, 226 insertions(+), 438 deletions(-)
 delete mode 100644 lib/stack/rte_stack_lf_generic.h

-- 
2.53.0

