Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12484CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 18:07:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E417F402E7;
	Thu, 21 May 2026 20:07:11 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 8894F400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 20:07:10 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30246cfd41aso35885eec.1
 for <dev@dpdk.org>; Thu, 21 May 2026 11:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779386829;
 x=1779991629; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y63v3AvnnIZZrh/OrxohOlwq3AZ9qnv1rdik2VcXlIg=;
 b=Zz/Jo6hUK/1aiL+YPFEZKPfGyzjhBwdCil61XlBX3RFrHnpm39UymJEYSlVpJPT2io
 f0LNO+B7zVxjXnrYdNRMXMOw7Um7JUc38GHIbPQkH8b7s1fCDkxXroO7G5lDxf5jdM52
 oIV+sACUxZooTxrZuZs9k7YMEns4ro66LclHmHIeYnSV1EhfYCyLqDLJZvH714dZDk7W
 B7xOq5zkjUFEUVMpxoZ3WdR3hU27k8zfro+dW3kzE8FtnXyBUs/yol5c8voZUXaywSyU
 wCqcGgeV482jVKKg4LfA7nSHWu9qmOYZYOBfjzO1xD6kwfeomU36mj59u8kqwjLN7wDk
 p7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386829; x=1779991629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y63v3AvnnIZZrh/OrxohOlwq3AZ9qnv1rdik2VcXlIg=;
 b=bQJGkubn1D/eaTNZI5EnOy4+FDci+iQryFdZb2mgxcvBgqOZo0q6R/jReFwdyP5zFP
 79dPDoT/zxdIRLFxGg63SYYviyudnI3OA2Zt3eSn3pxHbpO+K2BuyzccTvl7fua7VEhJ
 DGQO/DXAw8tnYN3jUCs3B4HaVzb8u4kUn1F3iytuHPyBMF/J5VvtwZ5YQ/AfNMSpVLom
 HBLvUEp8FuwAujdMD5/jkfWVTeoYtT18bfTye8yIv2kCQyus4qeQTyPoqrt9oI7kHtpD
 2twKJyPCdcDm7tqnm4iHgVXfwRzAtwpaMi5gI2pOzP0BxnC+9BhnM/xP/tpyMFSuLdSd
 ooyw==
X-Gm-Message-State: AOJu0Yy8FbsUnpawMxEkQn+PZlJEGSIwRL+yRtj4srt8zO2SDkyD7Rbv
 VDNAv9Z6JPBR0eSAGCeXa2YbtbZoD8T6ofKWV90en9N5jnYbgS8Ods7kJKcS9HJxoux7D04bUL4
 WmPSc
X-Gm-Gg: Acq92OGFTfIzXIsOkLhal4KBwGWWbuWIwONtTIqEhQmXq+A0O690nQjmWNPRjo4LcJn
 jWt8dgFmlkybn579u2ttSRxjIsQproM1aQIxk93Z+Uzjef42csJeSuYS1qcwBAPNJo6rDOUpRY4
 I5yBf9P9d2MEOjuJNDkJG0r4r9dAVCLkb9rJswY7lkrcn+EKu8fbKJFCMnobCQ/5mzIqCiqnQSP
 lKy6B2jFWixS74CX39SPnGj/ck1ezD1O17KHu9NsG7AbVc6Rx91N4fUw00tQEnBDcgEZbPjxHJr
 8x0ngfu/Sq9LxBFWZlC3s97Ab/n5evM8sL5aZuBBgsVjHDVu/o93k+vrhBxEGPWteF3Cn0+7lTm
 TZ73aB0CiFkIQpm9UezY7+RbGRtmD517hxAwb7ZxYUbiK62F9kxn4BysH2DA51ZBXZgzx+STmhz
 RqvrGMBnI9bXmbGAQ/ULpOS+1WPQEP7DInuOdmWknDV1nXGSWTYa+QtmCMmXdof+SD3I6FQ0RI
X-Received: by 2002:a05:693c:3017:b0:2ce:f3d7:221 with SMTP id
 5a478bee46e88-30449149050mr111278eec.17.1779386829305; 
 Thu, 21 May 2026 11:07:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c10desm1034069eec.27.2026.05.21.11.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 00/11] prepare deprecation of rte_atomicNN_*() family
Date: Thu, 21 May 2026 11:04:12 -0700
Message-ID: <20260521180706.678377-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521042043.1590536-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
MIME-Version: 1.0
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

The goal is to land every deprecation currently listed in the release
notes by the 26.11 ABI bump. Functions to be removed in 26.11 need
to be marked __rte_deprecated by 26.07, with all in-tree users
converted off them first so CI stays clean.

This is the first step. After this series there are no remaining
in-tree users of rte_atomic64. Expected follow-ups:

  - convert remaining rte_atomic32 users (dpaa/fslmc, netvsc, vmbus,
    sw_evdev, txgbe, ifc, hinic, bnx2x, vhost)
  - convert remaining rte_atomic16 users (dpaa/fslmc, qman)
  - mark the rte_atomicNN_*() family __rte_deprecated
  - remove the legacy test_atomic.c
  - remove the API itself at 26.11

Patch 1 deletes the inline-asm atomic fallbacks across arm, ppc,
loongarch, riscv, and x86 now that RTE_FORCE_INTRINSICS has been
the default everywhere for years. Largest patch by line count and
the one most worth review attention.

Patch 2 retires the rte_smp_*mb deprecation notice (open since 2021)
by reimplementing those APIs as inline wrappers over
rte_atomic_thread_fence; the API is preserved for readability.

Patch 3 is the load-bearing change for lib/: the last caller of
rte_atomic32_cmpset() is converted, with explicit acquire/release
orderings matching the existing HTS/RTS ring pattern.

Driver conversions (patches 4-11) match each rte_atomic64 use to its
best fit rather than blanket seq_cst: software stats become plain
assignment (DPDK convention, torn reads accepted); CAS loops setting
a flag collapse to fetch_or or exchange; open-coded link-status CAS
in net/pfe and net/sfc moves to the existing rte_eth_linkstatus
helpers; genuine synchronization stays atomic with explicit ordering.

v2 - fix clang build
   - replace rte_atomic64 in more drivers
   - incorporate feedback on rte_smp and ring
   - drop zxdh change (only caused by intrinsics in spinlock)

Stephen Hemminger (11):
  eal: use intrinsics for rte_atomic on all platforms
  eal: reimplement rte_smp_*mb with rte_atomic_thread_fence
  ring: use C11 atomic operations for MP/SP head/tail
  net/bonding: use stdatomic
  net/nbl: remove unused rte_atomic16 field
  net/ena: replace use of rte_atomicNN
  net/failsafe: convert to stdatomic
  net/enic: do not use deprecated rte_atomic64
  net/pfe: use ethdev linkstatus helpers
  net/sfc: replace rte_atomic with stdatomic
  crypto/ccp: replace use of rte_atomic64 with stdatomic

 doc/guides/rel_notes/deprecation.rst          |   8 -
 drivers/crypto/ccp/ccp_crypto.c               |  11 +-
 drivers/crypto/ccp/ccp_crypto.h               |   2 +-
 drivers/crypto/ccp/ccp_dev.c                  |  10 +-
 drivers/crypto/ccp/ccp_dev.h                  |   4 +-
 drivers/net/bonding/eth_bond_8023ad_private.h |   6 +-
 drivers/net/bonding/rte_eth_bond_8023ad.c     |  35 ++-
 drivers/net/ena/base/ena_plat_dpdk.h          |  14 +-
 drivers/net/ena/ena_ethdev.c                  |  21 +-
 drivers/net/ena/ena_ethdev.h                  |   7 +-
 drivers/net/enic/enic.h                       |   6 +-
 drivers/net/enic/enic_compat.h                |   1 -
 drivers/net/enic/enic_main.c                  |  17 +-
 drivers/net/enic/enic_rxtx.c                  |  14 +-
 drivers/net/enic/enic_rxtx_vec_avx2.c         |   4 +-
 drivers/net/failsafe/failsafe_ops.c           |  12 +-
 drivers/net/failsafe/failsafe_private.h       |  29 +--
 drivers/net/failsafe/failsafe_rxtx.c          |   2 +-
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   1 -
 drivers/net/pfe/pfe_ethdev.c                  |  32 +--
 drivers/net/sfc/sfc.c                         |   9 +-
 drivers/net/sfc/sfc.h                         |   4 +-
 drivers/net/sfc/sfc_port.c                    |   7 +-
 drivers/net/sfc/sfc_stats.h                   |   2 +-
 lib/eal/arm/include/rte_atomic_32.h           |  10 -
 lib/eal/arm/include/rte_atomic_64.h           |  10 -
 lib/eal/include/generic/rte_atomic.h          | 206 +++---------------
 lib/eal/loongarch/include/rte_atomic.h        |  10 -
 lib/eal/ppc/include/rte_atomic.h              | 179 ---------------
 lib/eal/riscv/include/rte_atomic.h            |  10 -
 lib/eal/x86/include/rte_atomic.h              | 205 +----------------
 lib/eal/x86/include/rte_atomic_32.h           | 188 ----------------
 lib/eal/x86/include/rte_atomic_64.h           | 157 -------------
 lib/ring/rte_ring_generic_pvt.h               |  65 ++++--
 34 files changed, 190 insertions(+), 1108 deletions(-)

-- 
2.53.0

