Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E18C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:13:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D18A40658;
	Sun, 20 Sep 2026 20:13:55 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id A0FB8402D6
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:13:52 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso1934615a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928032;
 x=1790532832; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c/NekmSXgyEIlDFaLGAh6uDDZK5sqPgybk6V+/HpP2c=;
 b=hbgZQYn9UVXWFxqGjD9Sogv0oa8DkvMva4rCydZj/21ynOJZ0PzThp8T/Z1YtWEo+W
 b4QrwKTZwp8hS8sTEbpti0pE/z3bpzgOOjl/zIT7EmFHEzvsLXCAz7yQXBZrBjdhiheN
 tT1RHzChghLIC/jyZLYmh4M8lV+9NtBPJrQtcJIU5zNh5VIeDL4gFNNnITn8Y6+dVI8j
 TpyB8qPWBmLVprorpNIQ7ltIubpaWI/gxUrPvl+nTLtWxwYDl3Fgv5L2x9Yr/8meBHle
 99SaQQnr+4zZe3sWIKYkdK6v5svCBNrIjsesfyJjgQyi0g2ywYYggd8U9pfEfXq16q1k
 nKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928032; x=1790532832;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c/NekmSXgyEIlDFaLGAh6uDDZK5sqPgybk6V+/HpP2c=;
 b=JCpFwvVDVkuSySzXQGl1KxDaAfuQFbeRI+XQnDE0w6OLVvCpYSqQmH8BMgrO1vnOHG
 ssrrr1iCJl18UcX1HReTbHWD080EuBMYVFWOomit+BZhVXOExJakC4B3SRsVwh+wBggN
 dn6z1+P2cMDWhpgDMKGgU6ob+CzzwtjmNf9NjWL3faGuKpAOV1GVo3mfiIYYmxzkASIT
 gNd5FGZzkRvAIBjXpj40Z24yP3JeUWJPReeL1ab/hsuYTxkE3Mw4mRuMLAfH/TuwoFwh
 WeAAXqfZy2JoPi+UUotVj5dazEUePpMKjUqw+TnQs9DWcqPJnURmX2j8RChqsNlFoooz
 F8UA==
X-Gm-Message-State: AFuF++lre4GKN4LVLp2nkYqoTPDXRx4APYBefe/eJlue4kimM2tcwf9M
 l9hSh17gcDJ2G4yFFso+M1voWo5kze4rNxYuXXZWiuHAPJhc0MkULoEP3b040I8My8eSU97SlE2
 i/AKz
X-Gm-Gg: AYBFou2X4jd8hB0XrCBbRneXpdeZKPzsE7NsAHgzLJTc0px+pf4Mvdhq/g8oWCtYEHT
 An4g6/rtOmR+vRAOlLVyCTumlayw0xgM54z6dYysHmn0HJi3dH9bguXq+PRgcnyI8KgT7CzoK/y
 l768OzLnph+0pPchGIQ/hZRZ5GOGU5Tey//ePzPFG3BjfiliOoOvGu5Ao2cIoA4o1WD4Nr0QMFZ
 o+LGIsBUpwneGjXYtZ9iGqYJ+2yCrzf/FcJOdjvAyAF0I8tKdxhWjeNnQQNRbVAHeIDkDkqJnBc
 3PyO9Rgw4bswVcRvRMTLW/uQmdl/8anDLpbl5kehT4xcoVVAdjLaGaCuUJ8gB1Wk4nuc3Rz5SAt
 ZnMeg3gk8f/RdimKBcwTFXsBoGnampPw2Vu3UNNxZW/gn9fk0DenVHNi4XMo991oJulXwUPpcpg
 DIPpr+lcDwBlb5fwZSOU2PGSCM1C6y9m26Ac2WTwKc9miTK7S6wUp+95HijOYuC0TYqK9LF1Nbz
 02xB85dR2hBRWKKn2fjsv/7U21SgNc8AbTvNhjTeFKOSqho
X-Received: by 2002:a17:90a:ec88:b0:39e:6c69:34dd with SMTP id
 98e67ed59e1d1-39e6c6936f4mr7359265a91.65.1789928031576; 
 Sun, 20 Sep 2026 11:13:51 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:13:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 00/33] remove rte_smp_XX barrier
Date: Sun, 20 Sep 2026 11:09:52 -0700
Message-ID: <20260920181347.747210-1-stephen@networkplumber.org>
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
tags and Cc: stable.

Most of this is mechanical with AI assistance, so strongly
encourage maintainers to take a good look.

Functional and build run on x86 and ARM native.
Should have no functional change, but as previous cleanups of
atomic have shown performance might be impacted by compiler bugs.

The lock-free stack patch measured faster than the generic version
it replaces, up to 63% on a 32-core x86 box; the numbers are in
that patch's commit message.

The RFC removed the barrier test outright.
Konstantin pointed out it still covers the custom x86 seq_cst fence,
so patch 19 now keeps the Peterson lock test and rewrites it around
rte_atomic_thread_fence(rte_memory_order_seq_cst) instead.
Need some careful patch series ordering to keep this all bisect
clean.


v2 - address review feedback 

Stephen Hemminger (33):
  bpf: replace deprecated SMP barriers with C11 fences
  bus/vmbus: remove packed attribute from ring buffer
  bus/vmbus: fix ring buffer ordering on weakly ordered CPUs
  bus/vmbus: fix missing acquire on receive ring index
  bus/vmbus: replace SMP barriers with C11 memory fences
  drivers/baseband: convert rte_smp_rmb to fence
  net/hinic: replace rte_smp_rmb
  net/intel: replace rte_smp_rmb
  net/virtio: replace rte_smp_rmb
  net/thunderx: replace rte_smp_rmb
  stack: always use C11 memory model implementation
  ring: replace SMP read barrier with C11 acquire fence
  crypto/virtio: update comment reference to rte_smp_rmb
  crypto/caam_jr: replace rte_smp_rmb
  crypto/caam_jr: use IO barrier before job ring doorbell
  crypto/octeontx: use IO barrier before doorbell
  event/sw: fix unlinks in progress counter races
  event/sw: replace SMP barriers with C11 atomics
  test/barrier: test sequentially consistent fence only
  eal/x86: move optimized fence out of SMP barrier
  common/octeontx: remove redundant barrier in mbox
  mempool/octeontx: use IO barrier in pool destroy
  event/octeontx: replace deprecated SMP barriers
  event/dpaa2: replace deprecated barrier in selftest
  event/dsw: replace SMP barriers with release fences
  event/opdl: replace SMP barriers with C11 atomics
  net/netvsc: replace SMP barrier in RNDIS response
  net/thunderx: replace deprecated SMP barriers
  net/virtio: replace deprecated barrier in avail index update
  eal: remove stale SMP barrier in rte_service
  eal: remove rte_smp_XX
  checkpatches: no longer warn about rte_smp_XX
  doc: update release notes about rte_smp_XX removal

 app/test/test_barrier.c                       | 105 ++++--------
 devtools/checkpatches.sh                      |   8 -
 doc/guides/rel_notes/deprecation.rst          |   8 -
 doc/guides/rel_notes/release_26_11.rst        |  11 ++
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |   8 +-
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |  12 +-
 drivers/bus/vmbus/private.h                   |  12 +-
 drivers/bus/vmbus/rte_vmbus_reg.h             |   4 +-
 drivers/bus/vmbus/vmbus_bufring.c             |  17 +-
 drivers/bus/vmbus/vmbus_channel.c             |  10 +-
 drivers/common/octeontx/octeontx_mbox.c       |   6 +-
 drivers/crypto/caam_jr/caam_jr.c              |   5 +-
 .../crypto/octeontx/otx_cryptodev_hw_access.h |   4 +-
 drivers/crypto/virtio/virtqueue.h             |   2 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |   4 +-
 drivers/event/dsw/dsw_event.c                 |   8 +-
 drivers/event/octeontx/ssovf_evdev_selftest.c |   6 +-
 drivers/event/octeontx/ssovf_worker.c         |   8 +-
 drivers/event/opdl/opdl_evdev.c               |   7 +-
 drivers/event/sw/sw_evdev.c                   |  37 +++--
 drivers/event/sw/sw_evdev.h                   |   2 +-
 drivers/event/sw/sw_evdev_scheduler.c         |  17 +-
 drivers/mempool/octeontx/octeontx_fpavf.c     |   4 +-
 drivers/net/hinic/base/hinic_pmd_cmdq.c       |   3 +-
 drivers/net/hinic/base/hinic_pmd_mgmt.c       |   2 +-
 drivers/net/intel/ice/ice_rxtx.c              |   2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   2 +-
 drivers/net/netvsc/hn_rndis.c                 |   2 +-
 drivers/net/thunderx/base/nicvf_hw.c          |   3 +-
 drivers/net/thunderx/base/nicvf_plat.h        |   5 +-
 drivers/net/virtio/virtqueue.h                |  18 +--
 lib/bpf/bpf_pkt.c                             |  25 ++-
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
 44 files changed, 208 insertions(+), 456 deletions(-)
 delete mode 100644 lib/stack/rte_stack_lf_generic.h

-- 
2.53.0

