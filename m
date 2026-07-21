Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4E2C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4835A402B5;
	Tue, 21 Jul 2026 11:46:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id ACD2840289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627163; x=1816163163;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DjDM4hMNCnMN+Y9BxxNX2x0Q16t3BUm4cvBpiLSQTR4=;
 b=CGc8z/jhOqIGfMbyt9L3Gvg9i8l/OxsbGF84DaMiaJuoZwADsqbRsQwg
 xtMUjIys2p99KaiVgpIFR3KCHcnnAXabp94SwX4x+jdnJ2B7XXq4ONfw2
 dIv3won32p5t22uLufQQjb4YuyR2/dm715p2afX9zXyH4Rd4LWly2YLe3
 5Ftu0KLShBqoAqIFOCTJX0NUg0OVoSdyYU3gLOBa0ZxX+jB9tYuQZJQzY
 DQykTbP1euFeAIOnjYWcNncAepnczteXJ+Uc34FgLMZYi5cJqPhLORKot
 EhiI4Wb35SaZW7LalYAshipM261GDbAuQl7PvIHk3DuBkoL/mJ6k+syzW A==;
X-CSE-ConnectionGUID: jYMazdfYRzGjOf1mVFODtw==
X-CSE-MsgGUID: YMc9M+mYSi6gkLuC5SKuRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872413"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872413"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:01 -0700
X-CSE-ConnectionGUID: jcRU8FhAQtioWMrDBYXGJg==
X-CSE-MsgGUID: dY51oslqTz29lMS2O2g94Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922208"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:00 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 00/39] Rework EAL configuration
Date: Tue, 21 Jul 2026 10:45:08 +0100
Message-ID: <20260721094555.2188496-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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

This patchset reworks how configuration is stored and managed in EAL.
The existing "internal_config", "rte_config", "lcore_config" structures,
which sometimes have arbitrary separation between them (especially the
first two) are replaced by three new structures with clearly defined
roles:

- eal_platform_info - contains the raw HW info for the system, details
  of CPUs and hugepage mounts. This is initialized on first use - even
  before EAL init is called - and is then immutable, since our HW should
  not change much underneath us. Its early availability means that it
  can be used to sanity check the contents of the other structs as they
  are being built up.

- eal_user_cfg - contains the config settings passed in by the user. For
  existing rte_eal_init, this is built up in the arg parse stage, and
  it's contents verified against the platform info, e.g. to check core
  masks are valid etc. Once argument parsing is completed, is also
  immutable.

- runtime_cfg - basically all the runtime settings that need to be there
  for DPDK to run, or which change over time. Largely combined content
  of the old rte_config, internal_config and lcore_config structs. This
  is initialized from the other two structs by eal initialization and
  can be modified by EAL at any time.

Once that is done, we have a clean separation between user provided
configuration and the rest of EAL, we can split EAL init into two parts,
the first of which parses cmdline arguments and then calls the second
which takes the eal_user_cfg struct result of that parse and does the
actual initialization. The longer-term objective is to have other
first-stage functions that prepare the user_cfg struct for
initialization, so that we can move away from argc/argv as the only
method of configuring DPDK initialization.

Bruce Richardson (39):
  telemetry: make cpuset init parameter const
  argparse: check for range overflow in CPU lists
  eal: define new functionally distinct config structs
  eal: move memory request fields to user config
  eal: move NUMA request fields to user config
  eal: move hugepage policy fields to user config
  eal: move process policy fields to user config
  eal: move hugepage limit fields to new config structs
  eal: move advanced user config options to user cfg struct
  eal: move hugepage size info to platform info struct
  eal: move runtime state to appropriate structure
  eal: record details of all cpus in platform info
  eal: use platform info for lcore lookups
  eal: add macro for lowest set CPU bit in a set
  eal: store lcore configuration in runtime data
  eal: move core indices bitset to runtime state
  eal: cleanup CPU init function
  eal: move NUMA node information to platform info struct
  eal: move lcore role and count to runtime state
  eal: make lcore role a field in lcore config struct
  eal: move main lcore setting to runtime config struct
  eal: move IOVA mode and process type to runtime cfg
  eal: move memory config pointer to runtime state struct
  eal: remove rte_config structure
  eal: separate runtime state update from arg parsing
  eal: move device options staging list into user cfg
  eal: separate plugin paths from loaded plugin objects
  eal: simplify internal driver path iteration APIs
  eal: move trace config into user config struct
  eal: record service cores in user config struct
  eal: store user-provided lcore info in user config struct
  eal: clarify docs on params taking lcore IDs
  eal: remove internal config reset function
  eal: move functions setting runtime state
  eal: initialize platform info on first use
  eal: remove duplicated scan of sysfs for hugepage details
  eal: add utilities for working with user config struct
  eal: split EAL init into two stages
  eal: provide hooks for init with externally supplied config

 app/test/process.h                        |   4 +-
 app/test/test_argparse.c                  |  10 +
 doc/guides/linux_gsg/eal_args.include.rst |  38 +-
 lib/argparse/rte_argparse.c               |   5 +
 lib/eal/common/eal_common_bus.c           |   4 +-
 lib/eal/common/eal_common_config.c        | 264 ++++++-
 lib/eal/common/eal_common_dev.c           |  10 +-
 lib/eal/common/eal_common_dynmem.c        |  70 +-
 lib/eal/common/eal_common_fbarray.c       |  10 +-
 lib/eal/common/eal_common_launch.c        |  25 +-
 lib/eal/common/eal_common_lcore.c         | 267 ++++---
 lib/eal/common/eal_common_mcfg.c          |  44 +-
 lib/eal/common/eal_common_memalloc.c      |   5 +-
 lib/eal/common/eal_common_memory.c        | 104 ++-
 lib/eal/common/eal_common_memzone.c       |  24 +-
 lib/eal/common/eal_common_options.c       | 899 ++++++++--------------
 lib/eal/common/eal_common_proc.c          |  43 +-
 lib/eal/common/eal_common_tailqs.c        |   6 +-
 lib/eal/common/eal_common_thread.c        |  67 +-
 lib/eal/common/eal_common_timer.c         |   2 +-
 lib/eal/common/eal_common_trace.c         |  30 +-
 lib/eal/common/eal_common_trace_utils.c   | 104 ---
 lib/eal/common/eal_hugepages.h            |   8 +
 lib/eal/common/eal_internal_cfg.h         | 386 ++++++++--
 lib/eal/common/eal_memcfg.h               |   3 +
 lib/eal/common/eal_option_list.h          |   6 +-
 lib/eal/common/eal_options.h              |   8 +-
 lib/eal/common/eal_private.h              | 121 ++-
 lib/eal/common/eal_trace.h                |  11 -
 lib/eal/common/malloc_elem.c              |  15 +-
 lib/eal/common/malloc_heap.c              |  41 +-
 lib/eal/common/malloc_mp.c                |   2 +-
 lib/eal/common/rte_malloc.c               |  14 +-
 lib/eal/common/rte_service.c              |  17 +-
 lib/eal/freebsd/eal.c                     | 287 ++++---
 lib/eal/freebsd/eal_hugepage_info.c       |  78 +-
 lib/eal/freebsd/eal_lcore.c               |  16 +-
 lib/eal/freebsd/eal_memory.c              |  46 +-
 lib/eal/freebsd/include/rte_os.h          |   2 +
 lib/eal/include/rte_eal.h                 |  35 +-
 lib/eal/include/rte_memzone.h             |  10 +-
 lib/eal/include/rte_tailq.h               |   2 +-
 lib/eal/linux/eal.c                       | 296 ++++---
 lib/eal/linux/eal_hugepage_info.c         | 231 +++---
 lib/eal/linux/eal_lcore.c                 |  43 ++
 lib/eal/linux/eal_memalloc.c              | 168 ++--
 lib/eal/linux/eal_memory.c                | 168 ++--
 lib/eal/linux/eal_timer_hpet.c            |  21 +-
 lib/eal/linux/eal_vfio.c                  |  11 +-
 lib/eal/linux/include/rte_os.h            |  10 +
 lib/eal/unix/eal_unix_thread.c            |  11 +-
 lib/eal/windows/eal.c                     | 193 +++--
 lib/eal/windows/eal_hugepages.c           |  60 +-
 lib/eal/windows/eal_lcore.c               |   6 +
 lib/eal/windows/eal_memalloc.c            |  37 +-
 lib/eal/windows/eal_memory.c              |  14 +-
 lib/eal/windows/eal_thread.c              |  11 +-
 lib/eal/windows/eal_windows.h             |   8 -
 lib/eal/windows/include/rte_os.h          |   1 +
 lib/eal/windows/include/sched.h           |  10 +
 lib/telemetry/telemetry.c                 |   4 +-
 lib/telemetry/telemetry_internal.h        |   2 +-
 62 files changed, 2499 insertions(+), 1949 deletions(-)

--
2.53.0

