Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FE4CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 16:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6843E40262;
	Fri, 29 May 2026 18:16:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id AC484400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 18:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780071365; x=1811607365;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lgeRt6a0qDI+q402EPOs7dysk0QdqG7X+EeAnNqUKuk=;
 b=nLBwX9AAflX0IoGWF4eIc80cCi5KNnoaC4WLfpm3ihOnOUWJgkUZD8ej
 rkRbdyVxz6qQPT4opwxVW2jSvCXydJ/59xgBU9ajEr0/aewJpjN2b4v8O
 SQN7tJZ7GicXeovaSciY+0wwhjycYWyKVpMWwbHc75Fj1hKdU0uRYSLLj
 w9OjCWtzDp79pntVWTdTibP/mtwnz+VzSxwVvcov7Oo0er/L8A/nCfsAY
 h1g4o61ZhRF3wxFywg4a1DZu0XyytlWTJEgxQEieYC6xAAUve+WhMjuA+
 9b36pyAehXPUFEIlx5NxmFBPnYYRHWx5nonh5AESw9SUu0DklQQODYnyX A==;
X-CSE-ConnectionGUID: tR4zL168TveFT7KIWTX/Vg==
X-CSE-MsgGUID: Q3Yvz6pKRHG/ukasJr4isw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="106375589"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="106375589"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 09:16:02 -0700
X-CSE-ConnectionGUID: RHc73UCqSBKnqP/cLuoFmw==
X-CSE-MsgGUID: VF46e0cwTiKZXG0u0i1qVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="266756019"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 29 May 2026 09:16:01 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 0/6] Make VA reservation limits configurable
Date: Fri, 29 May 2026 17:15:47 +0100
Message-ID: <cover.1780071269.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773225702.git.anatoly.burakov@intel.com>
References: <cover.1773225702.git.anatoly.burakov@intel.com>
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

v2 -> v3:
- Reworded commit messages to be more clear
- Reformatted to avoid unnecessary line breaks
- Simplify FreeBSD nsegs handling
- Fix 32-bit build failure

v1 -> v2:
- Fix str_to_size not handling invalid input properly
- Move str_to_size autotests to string autotests file
- Fix hugepage file segment indexing to not use global constants
- More validation around VA reservation

Anatoly Burakov (6):
  eal: reject non-numeric input in str to size
  eal/memory: remove per-list segment and memory limits
  eal/memory: allocate all VA space in one go
  eal/memory: get rid of global VA space limits
  eal/memory: store default segment limits in config
  eal/memory: add page size VA limits EAL parameter

 app/test/test.c                               |   1 +
 app/test/test_eal_flags.c                     | 126 ++++++++++++
 app/test/test_malloc.c                        |  30 ---
 app/test/test_string_fns.c                    |  66 ++++++
 config/arm/meson.build                        |   1 -
 config/meson.build                            |   5 -
 config/rte_config.h                           |   2 -
 doc/guides/linux_gsg/linux_eal_parameters.rst |  13 ++
 .../prog_guide/env_abstraction_layer.rst      |  33 ++-
 lib/eal/common/eal_common_dynmem.c            | 190 ++++++++----------
 lib/eal/common/eal_common_memory.c            |  30 ++-
 lib/eal/common/eal_common_options.c           | 142 +++++++++++++
 lib/eal/common/eal_common_string_fns.c        |   4 +
 lib/eal/common/eal_filesystem.h               |  11 +
 lib/eal/common/eal_internal_cfg.h             |   8 +
 lib/eal/common/eal_memcfg.h                   |   6 +
 lib/eal/common/eal_option_list.h              |   1 +
 lib/eal/common/eal_options.h                  |   1 +
 lib/eal/common/eal_private.h                  |  19 +-
 lib/eal/freebsd/eal.c                         |   6 +
 lib/eal/freebsd/eal_memory.c                  |  97 ++-------
 lib/eal/linux/eal.c                           |   6 +
 lib/eal/linux/eal_memalloc.c                  |   4 +-
 lib/eal/linux/eal_memory.c                    | 169 ++++++++++------
 lib/eal/windows/eal.c                         |   6 +
 25 files changed, 680 insertions(+), 297 deletions(-)

-- 
2.47.3

