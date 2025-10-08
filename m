Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2374BCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 20:42:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C03840277;
	Wed,  8 Oct 2025 22:42:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 017B040267
 for <dev@dpdk.org>; Wed,  8 Oct 2025 22:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759956174; x=1791492174;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VDjyv4c9p8e0MCWTxadTuc0KUCdVI+FdQpCthk8UIQs=;
 b=dUoL0vgckazUoyE7fLD6i1JdAC5vc1QBqfyuYPBekQCRnuAuRck0WD88
 1bmLQXYZ07B9GSM3W0On9ONlFgn3qg9ziRGxUWpuFtS0C3Qqjm1irRGYr
 0HOJElUNAWHgBHR37YLS0+KXQaOxKDZkFEcP4BQlTYdIqYLz1nH1T4Re+
 jrUicKAYhqiA9WFYlhdH368weZv+BI5d6tKXdRmZOgT1PDlC0f3xGuXbv
 It+ADntvYSrslgMQGg+mQ9j0A+Ml8OPxDzbaNDZp8CmeJ4Ka9gWqoF3qy
 IIS1yAKzLJm9Ac9Z77eqFE+f3l5eDcT43ID+PUOnt/ucVF7Gm0/uXFGJZ w==;
X-CSE-ConnectionGUID: AEOjcbqHTY+KyTbWGSgosQ==
X-CSE-MsgGUID: +dY8YLTOQOmy/+wNzdqZsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62079217"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62079217"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 13:42:53 -0700
X-CSE-ConnectionGUID: IzxUio+ISniyOUmHzk2k9w==
X-CSE-MsgGUID: BDCIC5ZZTVujfBpWeJrUIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; d="scan'208";a="179790603"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 08 Oct 2025 13:42:52 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 00/21] Simplify running with high-numbered CPUs
Date: Wed,  8 Oct 2025 21:42:23 +0100
Message-ID: <20251008204244.2288583-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520164025.2055721-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
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

The ultimate of this patchset is to make it easier to run on systems
with large numbers of cores, by simplifying the process of using core
numbers >RTE_MAX_LCORE. The new EAL arg ``-remap-lcore-ids``, also
shortened to ``-R``, is added to DPDK to support this.

However, in order to add this new flag easily, the first dozen or more
patches rework the argument handling in EAL to simplify things, using
the argparse library for argument handling.

When processing cmdline arguments in DPDK, we always do so with very
little context. So, for example, when processing the "-l" flag, we have
no idea whether there will be later a --proc-type=secondary flag. We
have all sorts of post-arg-processing checks in place to try and catch
these scenarios.

To improve this situation, this patchset tries to simplify the handling
of argument processing, by explicitly doing an initial pass to collate
all arguments into a structure. Thereafter, the actual arg parsing is
done in a fixed order, meaning that e.g. when processing the
--main-lcore flag, we have already processed the service core flags. We
also can far quicker and easier check for conflicting options, since
they can all be checked for NULL/non-NULL in the arg structure
immediately after the struct has been populated.

An additional benefit of this work is that the argument parsing for EAL
is much more centralised into common options and the options list file.
This single list with ifdefs makes it clear to the viewer what options
are common across OS's, vs what are unix-only or linux-only.

Once the cleanup and rework is done, adding the new options for
remapping cores becomes a lot simpler, since we can very easily check
for scenarios like multi-process and handle those appropriately.


V10:
* add patch 2 to fix func_reentrancy test bug reported mid-way through
  the series.
* added patches 7 & 8 to resolve arg parsing compat issues:
   - support reordering args to have non-flag parameters at the end so
     we can e.g. mix autotest names in with EAL args
   - support having optional params with single-letter args without
     having to use "=" syntax, i.e. -l4 rather than -l=4
* fixed issues with the final patch when the autodetected range of cores
  was >RTE_MAX_LCORE

V9: rebase to latest main. CI complains cannot apply v8 patches.

V8:
* dropped the final two patches from the series, dropping the new -L
  option in favour of the -R modifier.
* reordered patch 11 to be with the other argparse patches (now patch 5)
* added patch 12, which uses macros to initialize the args structure
  from the arguments header file, avoiding potential issues when we add
  new args.
* simplified and consolidated lcore mask and core list parsing to always
  work off cpusets rather than arrays of uint8
* enhanced debug printouts to also work better with cpusets and handle
  core values in those sets >= RTE_MAX_LCORE
* for completeness, ensure the new -R option works for coremasks, and
  for cases where no explicit core-list or coremask is specified.

V7:
* expand the scope of the patchset beyond just cleanup to add in the
  extra 3 patches for -L and --lcoreid-base option.

V6:
* Rebase to apply cleanly on latest main

V5:
* Resubmit of V4, which didn't get sent correctly, or picked up correctly
  in patchwork.

V4:
* Updated patch 5 to auto-generate the arg struct definition from the same
  list of defines used to construct the argument list.

V3:
* Added 3 new initial patches, one for minor build-system addition, and two
  for functionality in argparse to allow the user-callback help function to
  be maintained as we move to argparse.
* Added doc updates in the first EAL patch adding the long options
* Fixed ASAN issues by adding a patch to properly clean up EAL init - both
  memory allocations and fixing the run-once flag
* Put ifdefs around the linux-only or unix-only options in EAL patch 2
* Updated args to handle numa-mem and numa-limit as equivalent socket-mem
  and socket-limit

Bruce Richardson (21):
  build: add define for the OS environment name
  test/func_reentrancy: fix args to EAL init call
  argparse: export function to print help text for object
  argparse: allow user-override of help printing
  argparse: add documentation on supported value types
  argparse: add support for parsing core lists
  argparse: allow optional flag reordering
  argparse: support parameters to short options without "="
  eal: add long options for each short option
  eal: define the EAL parameters in argparse format
  eal: gather EAL args before processing
  eal: ensure proper cleanup on EAL init failure
  eal: combine parameter validation checks
  eal: simplify handling of conflicting cmdline options
  eal: automatically init arg list options
  eal: add internal fn for converting cpuset to string
  eal: use common cpuset to string function
  eal: introduce lcore remapping option for coremasks
  eal: rework internal coremask parsing to use cpu sets
  eal: allow lcore ID remapping with core lists
  eal: allow lcore remapping with autodetected core affinity

 app/test/test_argparse.c                   |  695 ++++++++++
 app/test/test_func_reentrancy.c            |    5 +-
 config/meson.build                         |    1 +
 doc/guides/contributing/design.rst         |    2 +-
 doc/guides/linux_gsg/eal_args.include.rst  |   42 +-
 doc/guides/prog_guide/argparse_lib.rst     |  138 +-
 doc/guides/rel_notes/release_25_11.rst     |   18 +
 drivers/event/dlb2/dlb2_priv.h             |    2 +-
 drivers/event/dlb2/pf/base/dlb2_resource.c |   11 +-
 lib/argparse/rte_argparse.c                |  181 ++-
 lib/argparse/rte_argparse.h                |   29 +-
 lib/eal/common/eal_common_lcore.c          |   13 +-
 lib/eal/common/eal_common_memory.c         |    3 +-
 lib/eal/common/eal_common_options.c        | 1439 +++++++++++---------
 lib/eal/common/eal_common_thread.c         |   43 +-
 lib/eal/common/eal_option_list.h           |   98 ++
 lib/eal/common/eal_options.h               |  104 +-
 lib/eal/common/eal_private.h               |   21 +
 lib/eal/common/eal_thread.h                |   13 +-
 lib/eal/freebsd/eal.c                      |  245 +---
 lib/eal/include/rte_eal.h                  |   20 -
 lib/eal/linux/eal.c                        |  470 +------
 lib/eal/linux/eal_memory.c                 |    2 +-
 lib/eal/meson.build                        |    2 +-
 lib/eal/windows/eal.c                      |  156 +--
 lib/meson.build                            |    1 +
 26 files changed, 2148 insertions(+), 1606 deletions(-)
 create mode 100644 lib/eal/common/eal_option_list.h

--
2.48.1

