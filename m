Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA951104C007
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1511D40E2B;
	Wed, 11 Mar 2026 11:59:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 251CF40431
 for <dev@dpdk.org>; Wed, 11 Mar 2026 11:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773226738; x=1804762738;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=La5O8VPVzBkwRFeO5KLu746PkUqpC73ouPBJLfDoDR8=;
 b=h17lJ//I1wuaKG9gSUm+2EPF7W4Kxo9WQgJZUgin12RzOKU6X4+kTtPL
 noeR1RJlPi0z0AAlMFaXM7WlDyfyhqUyYdDOOxzgwp0outNcLKqbufkdW
 taIluAu/WvX/RkgN/bnQLTMKKvYlAQx5IMH7EMhPHiIgf8DSSZY7boNsi
 o7XXj292a5+fU6bZPleaJ+nvAhRvOEEZU5YlX03ORSOPdVtmO9Zo8Gwqz
 uBH7SmUt4ZNnYHKDK8if6+nNOYk29J0FNSWYBUsR+w/Kl/kcF4drxM70y
 nF5rZxsFOL3u5vUBoAGB4a+fyDqGWYtKNtaFpETzfcmpoN2mVh+tD3/t/ w==;
X-CSE-ConnectionGUID: G2cdMqDnSyGb4pbpw5jy7g==
X-CSE-MsgGUID: j8uqIMsQR/Wgv64PPmCf9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74481618"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74481618"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 03:58:57 -0700
X-CSE-ConnectionGUID: EGGFAY8jRzO4VvDtl8b2fQ==
X-CSE-MsgGUID: pSoHkbRgTYyvKt/M5/xO9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="250928191"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 11 Mar 2026 03:58:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/5] Make VA reservation limits configurable
Date: Wed, 11 Mar 2026 10:58:48 +0000
Message-ID: <cover.1773225702.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

Currently, the VA space reservation is governed by a combination of a few
values:

- Total max VA space (512G for most platforms, 1T for some, 2G for 32-bit) - Max
memory per memory type - Max pages per memory type

The "memory" type is defined as unique combination of NUMA node and page size.
The reason why there are two limits is because for large pages, having large
segment limit causes runaway multi-terabyte reservations, while for smaller
pages, having large memory limit causes hundreds of thousands of huge page
slots. The total maximum memory size was originally intended as a safeguard
against discontiguous NUMA nodes, but this has since been fixed by EAL API
explicitly supporting discontiguous NUMA nodes, so this is no longer a problem.

In addition to that, each memory type was split into multiple segment lists,
with the idea that it should be easier for a secondary process to reserve
multiple smaller chunks at discontiguous addresses than it is to reserve a large
single chunk of memory. It is unknown whether this actually makes a difference,
but what *is* known is that it's a source of additional complexity with memory
reservation, as well as a source of gratuitous memory reservation limits placed
on DPDK.

This patchset attempts to simplify and improve this situation in a few key
areas:

- Get rid of global memory limits

Total memory usage can, and should, scale with NUMA sockets, and so now it does.

- Get rid of multiple segment lists per memory type

This removes two config options, and makes the address space reservations a lot
simpler.

- Allocate all memory segment lists as one big blob of memory

This further simplifies address space reservations.

- Use memory size limits instead of segments limits

Despite smaller page sizes still needing limits on number of segments, they are
directly translated into memory size limits at init time, so that all limits the
VA space reservation ever sees are expressed in bytes, not segments. This
reduces complexity in how we manage the VA space reservations and work with our
limits.

- Do not use config constants directly

We switch to only invoking these constants once - at startup, when we are
discovering hugepage sizes available to the system. This allows us to be more
flexible in how we manage these limits.

- Add EAL command-line option to set per-page size limits

The final piece of the puzzle - the "more flexible in how we manage these
limits" part. This new parameter affords us more flexible VA space management,
including disabling specific page sizes entirely (by specifying 0 as the limit).
This allows increasing/decreasing VA space reservation limits without
recompiling DPDK.

Anatoly Burakov (5):
  eal/memory: always use one segment per memory type
  eal/memory: allocate all VA space in one go
  eal/memory: get rid of global VA space limits
  eal/memory: store default segment limits in config
  eal/memory: add page size VA limits EAL parameter

 app/test/test.c                               |   1 +
 app/test/test_eal_flags.c                     | 113 ++++++++++++
 config/arm/meson.build                        |   1 -
 config/meson.build                            |   5 -
 config/rte_config.h                           |   2 -
 doc/guides/linux_gsg/linux_eal_parameters.rst |  13 ++
 .../prog_guide/env_abstraction_layer.rst      |  33 +++-
 lib/eal/common/eal_common_dynmem.c            | 160 ++++++++---------
 lib/eal/common/eal_common_memory.c            |  29 ++-
 lib/eal/common/eal_common_options.c           | 120 +++++++++++++
 lib/eal/common/eal_internal_cfg.h             |   8 +
 lib/eal/common/eal_memcfg.h                   |   6 +
 lib/eal/common/eal_option_list.h              |   1 +
 lib/eal/common/eal_options.h                  |   1 +
 lib/eal/common/eal_private.h                  |  15 +-
 lib/eal/freebsd/eal.c                         |   6 +
 lib/eal/freebsd/eal_memory.c                  |  98 +++--------
 lib/eal/linux/eal.c                           |   6 +
 lib/eal/linux/eal_memalloc.c                  |   2 +-
 lib/eal/linux/eal_memory.c                    | 165 +++++++++++-------
 lib/eal/windows/eal.c                         |   6 +
 21 files changed, 542 insertions(+), 249 deletions(-)

-- 
2.47.3

