Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E98E8B365
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 21:19:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06A80402C0;
	Tue,  3 Feb 2026 22:19:55 +0100 (CET)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id B554640288
 for <dev@dpdk.org>; Tue,  3 Feb 2026 22:19:53 +0100 (CET)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2b71320f501so2960010eec.1
 for <dev@dpdk.org>; Tue, 03 Feb 2026 13:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770153592; x=1770758392; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjuMuo/VOJ7WwYMBG8PMSz3GtC7tEtLBMaIB9JnKca8=;
 b=H7u6hfG58RrGmd8f39fHRWuYepC/PJVAd6NR7m3xiw+jyavG4Z17X/m8VE1mcMNOAh
 wr3YC4d1oWX9kvyPD3WsLk4wHBFov5odVqUHnfWcJAxAqrmCHzcH8U4VjaY88tUDfapR
 Y8zHUG4UoD23RPTohJ2cQiiA5TeXtRwFw06x9x1IqOp46CbkdU6m+TYREV4006JII8aS
 bsM/JVa/RgF4UrnFsfplTdn5YWtpHeiYoU5I+YZj0WRfNlny3DtKeKPp7pjn4j0zPYjN
 fX6nVq282gy0wx+4nnUgaf2XIGm8Ug8q7Jx1vD5OsjrUzVrZVguu3J0D3LHkLM2bDojH
 m52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770153592; x=1770758392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zjuMuo/VOJ7WwYMBG8PMSz3GtC7tEtLBMaIB9JnKca8=;
 b=EyJJbSMG5pAMcki5CtS5g5Zz9giE0dV785zREj/jK1v8bsy6hlhhU9gPzXr+IxrrNi
 TEcYdpD9tIHm0CQ999fLz1OKOWFa1lEghYkJKPm8RDOQrYVDxBsl/l9MghKdCuTi0T5/
 QsNrCigRtKsTlP397hM/hVlSj5G6Xtbdecuqwjt0cFWYFr06AcfL9twpxn7S0+5iPNBd
 yAmnd4PHRYFvYlee7XXdICwPL1fH/5ADtVwb2ixoaCSWIP/hOMVJyUZOEvwxCMzuZrdq
 cdrZS33Ec3GmB+sNR3ILaFu9gJvi2P7BETop3Ahbb2aJHtPaxDwNbcjlYn2e2spTN14Q
 Makg==
X-Gm-Message-State: AOJu0YzwpDpU9k9Ik03F3wiDiM+KUaOQl0WBMV5ZMDbVS6Vuoj4ybP3c
 1LhCllh4Guu4kP57A7OQt/arW9N6RNlHCJh/kZ8ILCNeb4jCzRnCCfN+58lVEA==
X-Gm-Gg: AZuq6aIbvwnAjSBm+4Eb+4Or12dasg9klpd5sHrd4eXWvI+VvN6uWwXWd3BelAxEQjJ
 pYFIGN7zdcHBA/W4M1gkfeQ22aWWmtt6P4LA0lFm7gd/qTtN+SBeCBZJO57egU2E/6dLa9k98Fs
 30dg6OAVwLCvrLd3NaUoCDFNJTktVbEe6/TnEAq1TahlKn44el+S7yvkHVigxQ32pmES25i1Zu4
 xVEfEtW4q1PzdGa6YiIYXBGi6uFcowxJ0OQZUFt0CIAF2pZ4aXIlP4Ul18DSYkwUu3InW2PoXZP
 M06uvGXytfqs0p/LAD/zvsuYVPiZWlvj9OZkQNbR02PAxDZGn98wFSzopBkZhfzhYBvtpz6Z997
 VPSl5tjO1nBbyjRcSLNfP/dk7SJ/8VmKHdwFCO2lmwsZC1GBveWEjFjgkGLly3eF5wJ7FGl09S2
 Mi1A2h5VIqSwj0osuSXxmOLq0KsKwefCfiY7QlEz2yH3pDmvll7uA=
X-Received: by 2002:a05:7301:1296:b0:2b7:befe:3748 with SMTP id
 5a478bee46e88-2b832a556bdmr455196eec.25.1770153592316; 
 Tue, 03 Feb 2026 13:19:52 -0800 (PST)
Received: from mr41p01nt-relayp04.apple.com ([17.115.166.158])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832e56c25sm406927eec.14.2026.02.03.13.19.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 13:19:51 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v18 0/2] eal: RTE_PTR_ADD/SUB API improvements
Date: Tue,  3 Feb 2026 13:18:31 -0800
Message-Id: <20260203211833.44063-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260202052442.92192-1-scott.k.mitch1@gmail.com>
References: <20260202052442.92192-1-scott.k.mitch1@gmail.com>
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
v18:
- Removed RTE_INT_PTR* macros
- Explicit NULL compare in asserts
- Consolidated test_ptr_add_sub.c into test_common.c

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
 app/test/test_common.c                      | 307 ++++++++++++++++++--
 doc/guides/rel_notes/release_26_03.rst      |  12 +
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
 drivers/event/cnxk/cn10k_worker.c           |  32 +-
 drivers/event/cnxk/cn20k_worker.c           |  32 +-
 drivers/mempool/bucket/rte_mempool_bucket.c |   7 +-
 drivers/mempool/dpaa/dpaa_mempool.c         |   2 +-
 drivers/net/cxgbe/sge.c                     |   4 +-
 drivers/net/ena/ena_ethdev.c                |   9 +-
 drivers/net/intel/fm10k/fm10k.h             |   6 +-
 drivers/net/intel/fm10k/fm10k_rxtx_vec.c    |  12 +-
 drivers/net/mlx4/mlx4_txq.c                 |   3 +-
 lib/eal/common/eal_common_fbarray.c         |   3 +-
 lib/eal/common/eal_common_memory.c          |  32 +-
 lib/eal/common/eal_common_options.c         |   3 +-
 lib/eal/common/malloc_elem.h                |  34 ++-
 lib/eal/freebsd/eal_memory.c                |   4 +
 lib/eal/include/rte_common.h                | 158 +++++++++-
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
 44 files changed, 649 insertions(+), 152 deletions(-)

-- 
2.39.5 (Apple Git-154)

