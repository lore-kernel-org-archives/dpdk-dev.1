Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDA6C79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:32:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6661740A84;
	Mon,  7 Sep 2026 20:32:49 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 29E5B402E8
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:32:48 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cace91f112so30989265ad.0
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788805967;
 x=1789410767; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FDmsWUg9OB3xFYxvEBUzU+K01WN8Aa/D6FEJlC2OKRI=;
 b=FBltYwiFbbla4yflAYGcJAcGtE/671z+eR7SJTBrm1OZMdFPyRD/mfzBOhA82m4T9L
 RyjwpF76appQB1IpDGQCLbZMSa4ETXgEvImm/awmih5WVcunixKKLkZO+KCbw867bt3X
 8znDr/KdEtQa8maMkl0VfsDA0RtoqAuWRWsBYlqD4l0I3VgiuwkdurPzCPTwbECIuaI7
 Sdf+uQ5X81eludhLbsu1h51W9fq0I1zfxb8lC7xV2/gghe6lhBtsy67qXAZiYW47Xq/j
 N1dwwbcd74QFXVqjlivc5V5btnNSRBeAvf8iBgkwacn6XIPjUdqXOmEb8lBrbPxXZKJX
 YBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805967; x=1789410767;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FDmsWUg9OB3xFYxvEBUzU+K01WN8Aa/D6FEJlC2OKRI=;
 b=XQW1UGumAoSBeLUBmIWc70QTncFlKM7edyEC8kNpBl5EbN9umBH9E6xsEJwrdiz4LG
 VYJ9Z4BSOYCWuS+S0wxKdnO+s7XFwlIturSJtHpQAyqELyQK2PVzKYlVvy3+6v2EPK7n
 rkLBXDZQqMDqxpqhzquOEa56PK7x/0P95cUyBYSi/pWbiv1C7m8Vy7/71eRlaFLYxADk
 F3iL8aMd024HF2w/Ppf03GM3cEz2V5AKimU4P9LHfU6qaUGk1ZtRLrCqbyHCkPFChSiK
 i3FqwCngOxQKl93AuyVAt8SlPD05LBGefyeSfrdMQG6aM95IyC3wdS/BCeA6ypSQ26eW
 H9Ng==
X-Gm-Message-State: AFuF++mCxdQikJVpiL4JMaM6uHFLjPRAj5P7/0yZnXmR+Z0j+2Ao2Yo9
 kmj9+yRJCV+PceW3hW4jUHl/bPjxkjK7LcP3I6plpGRNHcpddAjWmHNUo6TR3c59sEiq6ik7Mb1
 3t6by
X-Gm-Gg: AYBFou1VgJ3DYt/S/mTfw7/r5Dmjk4eYzPcecB70PtzdBMW80dkIftxJPCnm1bvHy77
 /BUaZsMEafmyA6aq18G7zHOV3LAdcDC2zyDkmRBNQFWMvBMmBP9lNAbAQiM2hgToYrNDrIeEFfW
 WtzLayuKChg10YlPva8K+pY6WZeWl9MOTEmOzO7P9KzCbBGazrBFzsSm5PT0BBzS5RHw3u9goH+
 1AORzzQstdlXz+E90WqdKIfzM7xjV9pyhRHC76i7E3PrNVLDbZyJibSpxhqyIyCa0nljGIUOOrU
 +RMKUr7e6KL5K2BWDcWJA3U8KCwYoxJhM90u/nOl5rXWXO2axY5ZXkz42UssKmFqdPi+N40RaQ8
 eq2LJkIVDA92cINd6vhJESs5dDwPx2zaOJayZpj2x80bz/UNzXz8IREejS6muVLQNIz0PqA6cvJ
 L79BYY/YLmnTrMqsvgc8xess11583nGe2T8xHBWcQ99CIb0gplMYRhh3vsX1fjDJ7PJ08SpIn48
 nKVK7YUYmPhB/+rIsD77fKRWZyB2Zf3Bii3Ag==
X-Received: by 2002:a17:903:98f:b0:2d8:d4d3:3fc0 with SMTP id
 d9443c01a7336-2db12678d9emr387014545ad.20.1788805967119; 
 Mon, 07 Sep 2026 11:32:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1495a0c0sm47590795ad.17.2026.09.07.11.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:32:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/5] eal: RTE_PTR_ADD and fix unaligned types
Date: Mon,  7 Sep 2026 11:31:19 -0700
Message-ID: <20260907183239.629053-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904220953.3105930-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
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

This series started with Scott Mitchell's patch to preserve pointer
qualifications across RTE_PTR_ADD and RTE_PTR_SUB. Reviewing it
turned up two further problems.

The first is that unaligned_uintNN_t only had alignment 1 on armv8
aarch32, the one target setting RTE_ARCH_STRICT_ALIGN. Everywhere
else they were ordinary aligned types, so code using them to read
or write at arbitrary offsets was still undefined behaviour and was
reported by UBSAN. Giving them alignment 1 on all architectures
fixes that, and once mlx5 no longer needs its strict alignment
path, RTE_ARCH_STRICT_ALIGN has no users left and is removed.

The second is the jhash test, which declared its key as a byte
array and cast it to unaligned_uint32_t * to pass to a function
taking const uint32_t *. That is fixed first in the series so the
alignment change does not introduce a new clang warning.

Only patch 1 should go to stable.

Note for reviewers: unaligned_uintNN_t is in an installed header,
so applications embedding one of these types in a structure will
see its layout change. That is called out in the release notes.

The types are also used in the hash key compare path
(rte_cuckoo_hash.c, rte_cmp_generic.h) and for 8 byte ring elements
(rte_ring_elem_pvt.h). Scalar code generation is unchanged on x86,
but the compiler can no longer assume alignment when combining
adjacent accesses, so hash and ring perf results would be welcome,
particularly on arm.

v3 - fix definition of unaligned types on Windows

Scott Mitchell (1):
  eal: RTE_PTR_ADD/SUB API improvements

Stephen Hemminger (4):
  test: fix jhash 32 bit key type
  eal: make unaligned really unaligned
  net/mlx5: drop unnecessary STRICT_ALIGN
  arm: remove no longer used RTE_ARCH_STRICT_ALIGN

 app/test-pmd/cmdline_flow.c                 |   4 +-
 app/test/test_common.c                      | 507 +++++++++++++++++++-
 app/test/test_hash_functions.c              |  14 +-
 config/arm/meson.build                      |   1 -
 doc/guides/rel_notes/release_26_11.rst      |  20 +
 drivers/bus/cdx/cdx_vfio.c                  |  13 +-
 drivers/bus/pci/linux/pci.c                 |   6 +-
 drivers/bus/vmbus/linux/vmbus_uio.c         |   6 +-
 drivers/common/cnxk/roc_cpt_debug.c         |  12 +-
 drivers/common/cnxk/roc_ml.c                |   4 +-
 drivers/common/cnxk/roc_nix_bpf.c           |   2 +-
 drivers/common/cnxk/roc_nix_inl.h           |   4 +-
 drivers/common/cnxk/roc_nix_inl_dp.h        |   8 +-
 drivers/common/mlx5/mlx5_common_mr.c        |   2 +-
 drivers/dma/idxd/idxd_pci.c                 |   2 +-
 drivers/dma/odm/odm_dmadev.c                |   4 +-
 drivers/event/cnxk/cn10k_worker.c           |  32 +-
 drivers/event/cnxk/cn20k_worker.c           |  32 +-
 drivers/mempool/bucket/rte_mempool_bucket.c |   7 +-
 drivers/net/cxgbe/sge.c                     |   4 +-
 drivers/net/ena/ena_ethdev.c                |  10 +-
 drivers/net/mlx4/mlx4_txq.c                 |   3 +-
 drivers/net/mlx5/mlx5_tx.h                  |  12 +-
 lib/eal/common/eal_common_fbarray.c         |   2 +-
 lib/eal/common/eal_common_memory.c          |  29 +-
 lib/eal/common/eal_common_options.c         |   3 +-
 lib/eal/common/malloc_elem.h                |  34 +-
 lib/eal/freebsd/eal_memory.c                |   4 +
 lib/eal/include/rte_common.h                | 192 +++++++-
 lib/eal/linux/eal_memalloc.c                |   5 +
 lib/eal/linux/eal_memory.c                  |   7 +
 lib/eal/windows/eal_memalloc.c              |   5 +
 lib/graph/rte_graph.h                       |   4 +-
 lib/latencystats/rte_latencystats.c         |   3 +
 lib/mbuf/rte_mbuf.c                         |   2 +
 lib/mbuf/rte_mbuf.h                         |   3 +
 lib/member/rte_xxh64_avx512.h               |   6 +-
 lib/mempool/rte_mempool.h                   |   5 +
 lib/pdcp/pdcp_entity.h                      |   8 +-
 lib/vhost/vhost_user.c                      |  13 +-
 40 files changed, 875 insertions(+), 159 deletions(-)

-- 
2.53.0

