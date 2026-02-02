Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B42D172CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 05:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DE8740285;
	Mon,  2 Feb 2026 06:24:49 +0100 (CET)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id C1C6340281
 for <dev@dpdk.org>; Mon,  2 Feb 2026 06:24:47 +0100 (CET)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2b73112ab62so3766056eec.1
 for <dev@dpdk.org>; Sun, 01 Feb 2026 21:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770009886; x=1770614686; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++g5BGmmouynPNWBwztgXDsMokji9vkKFvNwU3AjqkI=;
 b=EbjEM9btZWl56XPZHvJPo6folEWt+zwzL+550YL8/nW2CQNTCpPDmS2F0A/YrjXCO2
 Mu900gQaXxSyJ/LpRjkxHqHuFdjni3yTZMMjjBZLGv62gi/xTZXnVogG7X+h1imgrSx3
 ufG0GQ9Vu8/974LV8MaHPrF9ijz5e9yBaTdZdy6USHI4s2hey/+PtVBW4YjPGqSOUwm8
 lYXqfVPlzcqpkfxXtqmmUone4cSX2Hnh7aT5GNBZk/dJv3jIThPQNdO9lab9Qz5mlYSI
 1eUuFMau1i4vrupkNQndCf3yLtp+jb5WP61arNWowv1KoMBTMySSzfC+yjnqNYmKZMIh
 a88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770009886; x=1770614686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=++g5BGmmouynPNWBwztgXDsMokji9vkKFvNwU3AjqkI=;
 b=ksQDo7yDIiLCMy2SCdGwP9SxhNPHW4YkqFdjxrOnbeWuOvJJxeUXxhgrpha4Z8cBON
 drp8yicgBmMTrKVZR+Qo1nUaxUY+M7x3WagwCLt5eMrPiXXter6L8TKI5CegYTfj8sd9
 UWRaYmCUWKDII84Y0NDM7oSoWgtFTBQPuGxzzrIxg+xyIyaQ81HR8/HSiPLd2Zom6IZL
 oyMwFScOQG9Hxj7vyI8dbwEEzqnLC7vSIvK4rybQAKI0TZdHrbxb/H53BCzaiWyUuJl2
 E7ItvSMDuUy4xjbX/Cajd35oUDnW+JwOcCZSxO6iVz3P1NmfFEL6zejCzP4iQuMSYnz8
 tXmg==
X-Gm-Message-State: AOJu0YwqDHRqSA3CuQwWK+TYgd0+ECJKmzLqHyIaE8zPFfD0Jk/0tFgs
 f3HVX1V9WJ5UWOWLWoe1JeGBbaEo7nUoDO8H9LWghbT9WweVxdjzjHFrLtwhWA==
X-Gm-Gg: AZuq6aJVzd21XUmIV3SA+TRP1yBjIdn0/GOb376sXsXdU2JELF5iikC1D4kKOpDgN+J
 +CN4aieR+ZsJcXRvmOz9hiJG9stEJXhyrYa/Wm5Yx7riXck5NK576gygxcsOUlLxszkLe33H3Ks
 GRlSj5fvD2bNRwq459mCoOo4VNDWg1JiPjQzd1UtFK/dgA5wbJmey/eoMHn8s4aZeuY02Mf9lTW
 jJ3JrhI77Z17TDxZCl4SinAHTiXBRMMWjm1jTDszK7k5AoiVr8UpqbhVpR3nt9+ZgpaxNZDWytR
 Cp/ZgTLNmn90SlMuRAo6O/r8exTGVzLPEWC+Nbuw+pe+bh2BAq/IJoxIGIbHHyRKMeaVemIVGFs
 X9R3/tBF8SGOHqRlGmIEAdQ04M6xRVO8tf7rme9ca1NbHImN2K0y0zVwvXm8UdQ+bzwWNa9NiH+
 UpDCajPA8gqbq1jZcTgBgzflzqCIOuQgEp
X-Received: by 2002:a05:7301:2e89:b0:2b7:34e1:435d with SMTP id
 5a478bee46e88-2b7c8632bedmr5131570eec.3.1770009886275; 
 Sun, 01 Feb 2026 21:24:46 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1abe714sm19350499eec.20.2026.02.01.21.24.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 21:24:45 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v17 0/2] eal: RTE_PTR_ADD/SUB API improvements
Date: Sun,  1 Feb 2026 21:24:40 -0800
Message-Id: <20260202052442.92192-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260127052900.68045-1-scott.k.mitch1@gmail.com>
References: <20260127052900.68045-1-scott.k.mitch1@gmail.com>
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

From: Scott <scott.k.mitch1@gmail.com>

This series addresses two issues:

1. Removes the semantically incorrect __rte_alloc_size attribute from
   rte_lcore_var_alloc which was causing FORTIFY_SOURCE failures on
   Ubuntu 24.04 CI. The attribute was incorrect because the function
   returns a handle to per-lcore variables, not a direct pointer to
   'size' bytes.

2. Improves RTE_PTR_ADD/SUB macros to preserve pointer type qualifiers
   (const/volatile) and use pointer arithmetic instead of integer casts
   to enable compiler optimizations and maintain pointer provenance.

The bugfix (patch 1) is placed first so it can be backported independently
to stable branches.

---
v17:
- Improved release notes to explicitly list macro names for search/indexing
- eal_common_fbarray.c RTE_ASSERT to runtime NULL check

v16:
- Fixed test_common.c: parenthesize PTR_DIFF in RTE_INT_PTR tests

v15:
- Fixed __rte_alloc_size, spilt into 2 patch series
- Replaced RTE_INT_PTR_ADD/SUB with simpler RTE_INT_PTR(val) macro
users do int arithmetic directly: RTE_INT_PTR(addr + offset)

v14:
- fixed cpp compiler error, avoiding array pointer decay
which is implicitly done in cpp (but not c)
- fixed MALLOC_ELEM_TRAILER const preservation compile error

v13:
- Added release notes documenting API changes
- Fixed alignment in test file: use alignas(uint32_t) for buffer
- Fixed NULL pointer handling in cdx_vfio.c: check base_va before RTE_PTR_ADD
- Added GCC array-bounds diagnostic suppression in malloc_elem_from_data()
- Added bug tracker reference for volatile cast issue in idxd_pci.c
- Improved __rte_auto_type documentation: added C++11 and C23 support
- Moved doxygen rationale for void* return type to @return blocks
- Fixed MALLOC_ELEM_TRAILER to use RTE_PTR_UNQUAL for write operations

v12:
- void* return type to avoid optimizations assuming
aligned access which isn't generally safe/true.

v11:
- Split API into PTR and INT_PTR variants, update all usage
of PTR API for new APIs.

v10:
- Use unit_test_suite_runner for easier subtest failure identification

v9:
- Fix include order: system includes, then DPDK includes, then application includes
- Use NOHUGE_OK and ASAN_OK constants in REGISTER_FAST_TEST (instead of true, true)

v8:
- Remove tests for types < 32-bit (bool, char, short, uint8_t, uint16_t)
- Merge test_ptr_add_sub_typedefs() into test_ptr_add_sub_integer_types()
- Separate RTE_PTR_ADD and RTE_PTR_SUB documentation
- Move Clang/GCC implementation note from Doxygen to regular comment
- Tests verify both intermediate ADD result and SUB round-trip
- Use uintptr_t cast consistently for all integer-to-pointer conversions
- Make TEST_RETVAL calculated from TEST_INITVAL + TEST_INCREMENT

v7:
- Fix tests: use TEST_BUFFER_SIZE macro for buffer allocation
- Fix tests: ADD then SUB same amount to avoid out-of-bounds pointer arithmetic
- All RTE_PTR_SUB tests now verify round-trip (ADD+SUB returns to original)

v6:
- Make char* optimization Clang-only to avoid GCC false positive warnings
- Improve tests: use named constants instead of magic numbers
- Improve tests: use void* casts on expected values instead of uintptr_t on results

v5:
- Initial implementation with char* arithmetic for all compilers

v4:
- Used _Generic for type-based dispatch with char* casts
- Had warnings on both Clang and GCC due to _Generic type-checking all branches

Scott Mitchell (2):
  eal: remove alloc_size from rte_lcore_var_alloc
  eal: RTE_PTR_ADD/SUB API improvements

 app/test-pmd/cmdline_flow.c                 |   4 +-
 app/test/meson.build                        |   1 +
 app/test/test_common.c                      |  20 +-
 app/test/test_ptr_add_sub.c                 | 199 +++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst      |  14 ++
 drivers/bus/cdx/cdx_vfio.c                  |  13 +-
 drivers/bus/pci/linux/pci.c                 |   6 +-
 drivers/bus/vmbus/linux/vmbus_uio.c         |   6 +-
 drivers/common/cnxk/roc_cpt_debug.c         |   4 +-
 drivers/common/cnxk/roc_ml.c                |   4 +-
 drivers/common/cnxk/roc_nix_bpf.c           |   2 +-
 drivers/common/cnxk/roc_nix_inl.h           |   4 +-
 drivers/common/cnxk/roc_nix_inl_dp.h        |   8 +-
 drivers/common/cnxk/roc_platform.h          |   2 +
 drivers/common/mlx5/mlx5_common_mr.c        |   2 +-
 drivers/dma/idxd/idxd_pci.c                 |  11 +-
 drivers/dma/odm/odm_dmadev.c                |   4 +-
 drivers/event/cnxk/cn10k_worker.c           |  32 +--
 drivers/event/cnxk/cn20k_worker.c           |  32 +--
 drivers/mempool/bucket/rte_mempool_bucket.c |   7 +-
 drivers/mempool/dpaa/dpaa_mempool.c         |   2 +-
 drivers/net/cxgbe/sge.c                     |   4 +-
 drivers/net/ena/ena_ethdev.c                |   9 +-
 drivers/net/intel/fm10k/fm10k.h             |   6 +-
 drivers/net/intel/fm10k/fm10k_rxtx_vec.c    |  12 +-
 drivers/net/mlx4/mlx4_txq.c                 |   3 +-
 lib/eal/common/eal_common_fbarray.c         |   3 +-
 lib/eal/common/eal_common_memory.c          |  32 ++-
 lib/eal/common/eal_common_options.c         |   2 +-
 lib/eal/common/malloc_elem.h                |  34 ++-
 lib/eal/freebsd/eal_memory.c                |   4 +
 lib/eal/include/rte_common.h                | 231 ++++++++++++++++++--
 lib/eal/include/rte_lcore_var.h             |   2 +-
 lib/eal/linux/eal_memalloc.c                |   6 +
 lib/eal/linux/eal_memory.c                  |   7 +
 lib/eal/windows/eal_memalloc.c              |   6 +
 lib/graph/rte_graph.h                       |   4 +-
 lib/latencystats/rte_latencystats.c         |   3 +
 lib/mbuf/rte_mbuf.c                         |   1 +
 lib/mbuf/rte_mbuf.h                         |   2 +
 lib/member/rte_xxh64_avx512.h               |   6 +-
 lib/mempool/rte_mempool.c                   |   8 +-
 lib/mempool/rte_mempool.h                   |   3 +
 lib/mempool/rte_mempool_ops_default.c       |   2 +-
 lib/pdcp/pdcp_entity.h                      |   8 +-
 lib/vhost/vhost_user.c                      |  13 +-
 46 files changed, 652 insertions(+), 136 deletions(-)
 create mode 100644 app/test/test_ptr_add_sub.c

-- 
2.39.5 (Apple Git-154)

