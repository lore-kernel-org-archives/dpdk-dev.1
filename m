Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C6CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:15:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C8CE4028B;
	Fri,  3 Oct 2025 10:15:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id AD06B40262
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479315; x=1791015315;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MPh9hYhfxacRD+nKSFqzPkkr/B9NtpTalJB1Y3bNaXo=;
 b=FR07uzU49P25cVy6p6TRPIYpw+Ge+2Uq9fRCsMZ5LTJ/fQhJPICbPZlN
 Lp9kLSIohEq3mkxpT5z/Sax8yIlSbz7K7HfmtoxkuUvxD/7i1whUE1Tsa
 KrRdY0kXXttURl2LcNzGkrMOVP8a0ctKkYGrhy/mz3kpKf3K1LbrsQkoF
 nCqnjNa1o/RaDWCa2T2VqTouCSdV3Mqx3aNovydJzTVWzaAhsnTb1wdxB
 UIquIusRCqlHP94ee99yJ1xX/JgUGN2wSBOLNRnqhjFpT5jV8ZG+DQJ2H
 aFsKAXpbWB1F4Fex/toDdgyni2h61/I2qLcfusJnEbN7p99RLjz4MUkeh Q==;
X-CSE-ConnectionGUID: i6NbcMCQRx+zmTCXthfXKw==
X-CSE-MsgGUID: KGFNPkE7S1OMMWI5UUwnSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61473535"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61473535"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:15:14 -0700
X-CSE-ConnectionGUID: /L9y5CIYQLa9ONaS5287Zg==
X-CSE-MsgGUID: zycIRXEIS7euXljp4aPZDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="184525791"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 01:15:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 00/18] Simplify running with high-numbered CPUs
Date: Fri,  3 Oct 2025 09:14:52 +0100
Message-ID: <20251003081510.1197166-1-bruce.richardson@intel.com>
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


Bruce Richardson (18):
  build: add define for the OS environment name
  argparse: export function to print help text for object
  argparse: allow user-override of help printing
  argparse: add documentation on supported value types
  argparse: add support for parsing core lists
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
  eal: allow lcore id remapping with core lists
  eal: allow lcore remapping with autodetected core affinity

 app/test/test_argparse.c                   |  188 +++
 config/meson.build                         |    1 +
 doc/guides/contributing/design.rst         |    2 +-
 doc/guides/linux_gsg/eal_args.include.rst  |   42 +-
 doc/guides/prog_guide/argparse_lib.rst     |  121 +-
 doc/guides/rel_notes/release_25_11.rst     |   18 +
 drivers/event/dlb2/dlb2_priv.h             |    2 +-
 drivers/event/dlb2/pf/base/dlb2_resource.c |   11 +-
 lib/argparse/rte_argparse.c                |  109 +-
 lib/argparse/rte_argparse.h                |   23 +-
 lib/eal/common/eal_common_lcore.c          |   13 +-
 lib/eal/common/eal_common_memory.c         |    3 +-
 lib/eal/common/eal_common_options.c        | 1417 +++++++++++---------
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
 25 files changed, 1533 insertions(+), 1592 deletions(-)
 create mode 100644 lib/eal/common/eal_option_list.h

--
2.48.1

