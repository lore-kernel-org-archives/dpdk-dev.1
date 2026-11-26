Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184F9606A689
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S6v8henQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4920640608;
	Thu, 26 Nov 2026 19:14:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 7FED7402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716863; x=1827252863;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vPzOJogIb7q+SwyVZpKJeKwGvFZciVAtsgJyqRClLc8=;
 b=S6v8henQFCDL0XKWRUO6uNp4sDNBisuOUpv+v4H2w5rV59lws2vdkVDe
 nikEzdWMJhj9reQYCOWrN6jo8lTMrdLx7SnyP+ZBwFYNVk+4tKmatv279
 yp4FuY4n5axZdjfBAZbQ2ZGumFC2k23+e/vEsbw0kDwHxJ6qcgDyIQpBq
 5r27HPvkKrXVL1H4tODR3q6h7My+V/rHiH+8pgLVdtqcLB/PkyUva8F+g
 lp8s9NlVoIqZWepXG4JqNqnHHNnlJKJW0Qo4fAK5fbr10K4ido6N5jvoH
 1Re1a6WoCOzNkqkBW6EoZxthHTmfY6NrwB2WW20FYcRjjAKJpQGHwHbB1 A==;
X-CSE-ConnectionGUID: JBNDkRfXQPyKvSqhwtb0Kw==
X-CSE-MsgGUID: l11d0mmbSVG0NtQEdToySA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633538"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633538"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:18 -0800
X-CSE-ConnectionGUID: mMxXpSgcRp2Xu5JOypZ5PA==
X-CSE-MsgGUID: xIqnWvqkS/685e2vv33fdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732835"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:17 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 00/39] Rework EAL configuration
Date: Thu, 26 Nov 2026 18:13:33 +0000
Message-ID: <20261126181414.124094-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721094555.2188496-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v3: rebase for 27.03
v2: minor rework following AI review.

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

 app/test/process.c                        |   4 +-
 app/test/test_argparse.c                  |  10 +
 doc/guides/linux_gsg/eal_args.include.rst |  38 +-
 lib/argparse/rte_argparse.c               |   5 +
 lib/eal/common/eal_common_bus.c           |   4 +-
 lib/eal/common/eal_common_config.c        | 267 ++++++-
 lib/eal/common/eal_common_dynmem.c        |  70 +-
 lib/eal/common/eal_common_fbarray.c       |  10 +-
 lib/eal/common/eal_common_launch.c        |  25 +-
 lib/eal/common/eal_common_lcore.c         | 267 ++++---
 lib/eal/common/eal_common_mcfg.c          |  46 +-
 lib/eal/common/eal_common_memalloc.c      |   5 +-
 lib/eal/common/eal_common_memory.c        | 104 ++-
 lib/eal/common/eal_common_memzone.c       |  24 +-
 lib/eal/common/eal_common_options.c       | 899 ++++++++--------------
 lib/eal/common/eal_common_proc.c          |  10 +-
 lib/eal/common/eal_common_tailqs.c        |   6 +-
 lib/eal/common/eal_common_thread.c        |  67 +-
 lib/eal/common/eal_common_timer.c         |   2 +-
 lib/eal/common/eal_common_trace.c         |  30 +-
 lib/eal/common/eal_common_trace_utils.c   | 104 ---
 lib/eal/common/eal_hugepages.h            |   8 +
 lib/eal/common/eal_internal_cfg.h         | 385 +++++++--
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
 lib/eal/freebsd/eal.c                     | 291 ++++---
 lib/eal/freebsd/eal_hugepage_info.c       |  78 +-
 lib/eal/freebsd/eal_lcore.c               |  16 +-
 lib/eal/freebsd/eal_memory.c              |  46 +-
 lib/eal/freebsd/include/rte_os.h          |   2 +
 lib/eal/include/rte_eal.h                 |  35 +-
 lib/eal/include/rte_memzone.h             |  10 +-
 lib/eal/include/rte_tailq.h               |   2 +-
 lib/eal/linux/eal.c                       | 297 ++++---
 lib/eal/linux/eal_hugepage_info.c         | 231 +++---
 lib/eal/linux/eal_lcore.c                 |  43 ++
 lib/eal/linux/eal_memalloc.c              | 168 ++--
 lib/eal/linux/eal_memory.c                | 167 ++--
 lib/eal/linux/eal_timer_hpet.c            |  21 +-
 lib/eal/linux/include/rte_os.h            |  10 +
 lib/eal/unix/eal_unix_thread.c            |  11 +-
 lib/eal/windows/eal.c                     | 197 +++--
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
 60 files changed, 2492 insertions(+), 1914 deletions(-)

--
2.55.0

