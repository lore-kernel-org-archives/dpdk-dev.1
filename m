Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B22FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 16:58:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6829E4065E;
	Wed, 29 Apr 2026 18:58:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5368E4064A;
 Wed, 29 Apr 2026 18:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481936; x=1809017936;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0iUCHj+eRezY2lAyblUCnQk9mABQnILRvA051S4D0wI=;
 b=mexd4FNnosqx/ZnfCYDrjIsElOsyOb76t3z51XUTZ0hmecZ+9PhuAFCk
 Y11/JRsWPNlHF8WH0/3BvjwBtg47wRq4Zw6V+srajJVNMp7agHCXCM7Kp
 I6WVI/643jjEEuwNT6kwTZkgtkXANWSjek7+pf2bbZTKzT4/fgwkalLdB
 yzxbLalI4/7x5dymj4jTko54i5cmEUIKsgVippvirSWViSm1RwEgwQHP2
 B4cg5k8h18npxqFChpji37tB2cKlerR9QbbJcaRWaTQ8WpfzZ+yHhGgtz
 5jLAfYbqBelWoqb/j315ri7uchdw0odfcMmKwSP1H4rEZ4xnv0I+eBTyh w==;
X-CSE-ConnectionGUID: fMX7oJHCR5OEvAfdPWiL/Q==
X-CSE-MsgGUID: KJR/e1jhSqKsQ8bUcp1b5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725286"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725286"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:58:55 -0700
X-CSE-ConnectionGUID: IJ6SmB72RBinv5myr5cVtg==
X-CSE-MsgGUID: MCBkLV/gTwCfx7AMd+FrFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696907"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:58:53 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 00/44] Allow intitializing EAL without argc/argv
Date: Wed, 29 Apr 2026 17:57:52 +0100
Message-ID: <20260429165845.2136843-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

The ultimate end goal of this RFC is, as stated in the title, to move
away from argc/argv as the sole means of configuring EAL on init. This
set therefore looks to:
* rework EAL so that we have a generic EAL init function taking a
  struct-based configuration
* provide a rough *example* of how that might be used to create a new
  set of C APIs to be used by apps to initialize EAL without having to
  create dummy argc/argv pairs. [A side benefit of this is that it
  makes it a lot easier to initialize EAL from other languages like Rust
  or Python too, because arrays of C strings are not the most
  user-friendly for a foreign interface]

Therefore this set can be considered in 3 parts:

Part 1: Struct rework.

Largely for legacy reasons, we have a number of different structs and
arrays holding eal configuration, without having clear guides as to why
certain fields are stored where. The first ~30 patches rework the
existing structs - rte_config, internal_config, lcore_config etc.
into three defined-purpose structs:

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

Part 2: Cleanup and Split EAL init

With the 3 structs clearly separated by purpose, we can then do some
cleanup of the code, before - in patches 35 & 36 - splitting EAL into
two and providing an *internal* struct-based alternative API for
initializing DPDK. The old rte_eal_init function still exists, just the
contents of it after the argument parsing are put into a new, static
eal_runtime_init() function, which take the argparse output (user_cfg
struct). Patch 36, adds a thin internal-API wrapper around this static,
which is necessary to take care of things like the run-once flag.  [This
wrapper should never be the public API, since the struct will change and
therefore be an ABI break. It's designed to be used by other wrapper
libs which provide a stable ABI for config]

Part 3: Prototype of an eal_cfg library

Once we have the internal C API to init eal using a struct
rte_eal_user_cfg, we can create new libraries which provide alternate
ways to build up the user_cfg and initialize DPDK. Patches 37-44 have a
rough example of such a library.

- The lib allows a user to create an opaque rte_eal_user_cfg struct,
  which can then be modified by APIs to get/set various parameters
  before calling rte_cfg_eal_init().
- An alternative way to do things (not prototyped), may be to have a
  library that creates an eal_user_cfg struct based on the contents of
  an ini file using the configfile library.
[Both these options could be used in parallel. Note too that both have
no ABI implications for adding new flags, or making old ones no-ops!]

Bruce Richardson (44):
  eal: define new functionally distinct config structs
  eal: move memory request fields to user config
  eal: move NUMA request fields to user config
  eal: move hugepage policy fields to user config
  eal: move process policy fields to user config
  eal: move advanced user config options to user cfg struct
  eal: move hugepage size info to platform info struct
  telemetry: make cpuset init parameter const
  eal: move runtime state to appropriate structure
  eal: record details of all cpus in platform info
  eal: use platform info for lcore lookups
  eal: add RTE_CPU_FFS macro
  eal: store lcore configuration in runtime data
  eal: cleanup CPU init function
  eal: move numa node information to platform info struct
  eal: move lcore role and count to runtime state
  eal: make lcore role a field in lcore config struct
  eal: move main lcore setting to runtime config struct
  eal: move iova mode and process type to runtime cfg
  eal: move memory config pointer to runtime state struct
  eal: remove rte_config structure
  eal: separate runtime state update from arg parsing
  eal: move devopt_list staging list into user_cfg
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
  eal_cfg: add new library to programmatically init DPDK
  eal_cfg: configure defaults for easier testing and use
  app/test: enable testing init using EAL config lib
  eal_cfg: add basic setters and getters
  eal_cfg: add hugepage memory configuration
  eal_cfg: support configuring lcores
  eal_cfg: support device and driver lists
  eal_cfg: add APIs for configuring remaining init settings

 app/test/meson.build                      |    1 +
 app/test/process.h                        |    4 +-
 app/test/test.c                           |   14 +-
 app/test/test.h                           |    1 +
 app/test/test_eal_cfg.c                   | 1323 +++++++++++++++++++++
 doc/api/doxy-api-index.md                 |    1 +
 doc/api/doxy-api.conf.in                  |    1 +
 doc/guides/linux_gsg/eal_args.include.rst |   38 +-
 doc/guides/prog_guide/eal_cfg_lib.rst     |   23 +
 doc/guides/prog_guide/index.rst           |    1 +
 lib/eal/common/eal_common_bus.c           |    4 +-
 lib/eal/common/eal_common_config.c        |  221 +++-
 lib/eal/common/eal_common_dynmem.c        |   66 +-
 lib/eal/common/eal_common_fbarray.c       |   10 +-
 lib/eal/common/eal_common_launch.c        |   25 +-
 lib/eal/common/eal_common_lcore.c         |  230 ++--
 lib/eal/common/eal_common_mcfg.c          |   44 +-
 lib/eal/common/eal_common_memalloc.c      |    5 +-
 lib/eal/common/eal_common_memory.c        |  104 +-
 lib/eal/common/eal_common_memzone.c       |   24 +-
 lib/eal/common/eal_common_options.c       |  823 +++++--------
 lib/eal/common/eal_common_proc.c          |   43 +-
 lib/eal/common/eal_common_tailqs.c        |    6 +-
 lib/eal/common/eal_common_thread.c        |   81 +-
 lib/eal/common/eal_common_timer.c         |    2 +-
 lib/eal/common/eal_common_trace.c         |   30 +-
 lib/eal/common/eal_common_trace_utils.c   |  104 --
 lib/eal/common/eal_hugepages.h            |    8 +
 lib/eal/common/eal_internal_cfg.h         |  376 +++++-
 lib/eal/common/eal_memcfg.h               |    3 +
 lib/eal/common/eal_option_list.h          |    6 +-
 lib/eal/common/eal_options.h              |    7 +-
 lib/eal/common/eal_private.h              |  108 +-
 lib/eal/common/eal_trace.h                |   11 -
 lib/eal/common/malloc_elem.c              |   15 +-
 lib/eal/common/malloc_heap.c              |   41 +-
 lib/eal/common/malloc_mp.c                |    2 +-
 lib/eal/common/rte_malloc.c               |   14 +-
 lib/eal/common/rte_service.c              |   17 +-
 lib/eal/freebsd/eal.c                     |  271 +++--
 lib/eal/freebsd/eal_hugepage_info.c       |   71 +-
 lib/eal/freebsd/eal_lcore.c               |   16 +-
 lib/eal/freebsd/eal_memory.c              |   46 +-
 lib/eal/freebsd/include/rte_os.h          |    2 +
 lib/eal/include/rte_eal.h                 |   35 +-
 lib/eal/include/rte_memzone.h             |   10 +-
 lib/eal/include/rte_tailq.h               |    2 +-
 lib/eal/linux/eal.c                       |  280 +++--
 lib/eal/linux/eal_hugepage_info.c         |  219 ++--
 lib/eal/linux/eal_lcore.c                 |   13 +
 lib/eal/linux/eal_memalloc.c              |  168 ++-
 lib/eal/linux/eal_memory.c                |  153 ++-
 lib/eal/linux/eal_timer_hpet.c            |   21 +-
 lib/eal/linux/eal_vfio.c                  |   11 +-
 lib/eal/linux/include/rte_os.h            |   10 +
 lib/eal/unix/eal_unix_thread.c            |   11 +-
 lib/eal/windows/eal.c                     |  177 ++-
 lib/eal/windows/eal_hugepages.c           |   60 +-
 lib/eal/windows/eal_lcore.c               |    6 +
 lib/eal/windows/eal_memalloc.c            |   37 +-
 lib/eal/windows/eal_memory.c              |   14 +-
 lib/eal/windows/eal_thread.c              |   11 +-
 lib/eal/windows/eal_windows.h             |    8 -
 lib/eal/windows/include/rte_os.h          |    1 +
 lib/eal/windows/include/sched.h           |   10 +
 lib/eal_cfg/eal_cfg.c                     |  918 ++++++++++++++
 lib/eal_cfg/meson.build                   |    6 +
 lib/eal_cfg/rte_eal_cfg.h                 |  903 ++++++++++++++
 lib/meson.build                           |    1 +
 lib/telemetry/telemetry.c                 |    4 +-
 lib/telemetry/telemetry_internal.h        |    2 +-
 71 files changed, 5450 insertions(+), 1884 deletions(-)
 create mode 100644 app/test/test_eal_cfg.c
 create mode 100644 doc/guides/prog_guide/eal_cfg_lib.rst
 create mode 100644 lib/eal_cfg/eal_cfg.c
 create mode 100644 lib/eal_cfg/meson.build
 create mode 100644 lib/eal_cfg/rte_eal_cfg.h

--
2.51.0

