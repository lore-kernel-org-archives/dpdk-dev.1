Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64AEC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 16:21:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10C7340267;
	Wed, 23 Jul 2025 18:21:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6DBDB40144
 for <dev@dpdk.org>; Wed, 23 Jul 2025 18:20:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753287659; x=1784823659;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9DD7tQIpHaUld5imwQPmQbzQn8WSLLUV0UDTFJd45tg=;
 b=I7hs3LyF4yTrgTTKAoBp/gh7L7sNgN6/LspXmNSPog4+qvESwbHFqDUw
 LH6TkGFqIWMEOr2N2JZbjxKNONCOxDD3o0OkNmS9ijO0IfFC7IPbRFtCG
 slz0Rn7JjfkFXmrh9Ui8lEPR+m8i3GJGHC1+q+5IJuOE5lfTNdB3KNqKG
 JNuWn5XFeLiMd/14cfGh4gOSLJ75XpEEdnc/+OnPiY7yB0zr+DrZkIk+8
 Xkj5+acWIW6oCHg85yiybXTvm5wh12/XfkW53GiVrvgVtYdzCeYvv58+C
 BT36qqyRLvZRNpfXS95mZRDS6mhxrtYsnyDuUHPs7IcIs81LFUAOYXgg0 g==;
X-CSE-ConnectionGUID: cN977Io3QOaCv4tAxZ12Xw==
X-CSE-MsgGUID: fy+T7KGUSK2ML5ye+MsCDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43197955"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="43197955"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 09:20:58 -0700
X-CSE-ConnectionGUID: VvwsWUSZT9WXCpAkEyPIKQ==
X-CSE-MsgGUID: 9kIErLzjQGaHKmw5rpI+3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="160148886"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa008.fm.intel.com with ESMTP; 23 Jul 2025 09:20:56 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 00/13] Simplify running with high-numbered CPUs
Date: Wed, 23 Jul 2025 17:19:58 +0100
Message-ID: <20250723162013.2392-1-bruce.richardson@intel.com>
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
numbers >RTE_MAX_LCORE. The new EAL args "--lcores-remapped", also
shortened to just "-L", and "--lcoreid-base", are added to DPDK to
support this. However, in order to enable the addition of these new
flags, the first 10 patches of this set do cleanups, for reasons
explained below.

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

To do the initial argument gathering, this RFC uses the existing
argparse library in DPDK. With recent changes, and a few additional
patches at the start of this set, this library now meets our needs for
EAL argument parsing and allows us to not need to do direct getopt
argument processing inside EAL at all.

An additional benefit of this work is that the argument parsing for EAL
is much more centralised into common options and the options list file.
This single list with ifdefs makes it clear to the viewer what options
are common across OS's, vs what are unix-only or linux-only.

Once the cleanup and rework is done, adding the new options for
remapping cores becomes a lot simpler, since we can very easily check
for scenarios like multi-process and handle those appropriately.

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


Bruce Richardson (13):
  build: add define for the OS environment name
  argparse: export function to print help text for object
  argparse: allow user-override of help printing
  argparse: add documentation on supported value types
  eal: add long options for each short option
  eal: define the EAL parameters in argparse format
  eal: gather EAL args before processing
  eal: ensure proper cleanup on EAL init failure
  eal: combine parameter validation checks
  eal: simplify handling of conflicting cmdline options
  argparse: add support for parsing core lists
  eal: simplify running CPUs with ids above max lcores
  eal: add warnings about ignored options

 app/test/test_argparse.c                  |  188 +++
 config/meson.build                        |    1 +
 doc/guides/contributing/design.rst        |    2 +-
 doc/guides/linux_gsg/eal_args.include.rst |   66 +-
 doc/guides/prog_guide/argparse_lib.rst    |  121 +-
 doc/guides/rel_notes/release_25_11.rst    |   16 +
 lib/argparse/rte_argparse.c               |  109 +-
 lib/argparse/rte_argparse.h               |   23 +-
 lib/eal/common/eal_common_memory.c        |    3 +-
 lib/eal/common/eal_common_options.c       | 1344 ++++++++++++---------
 lib/eal/common/eal_option_list.h          |   92 ++
 lib/eal/common/eal_options.h              |  102 +-
 lib/eal/common/eal_private.h              |   11 +
 lib/eal/freebsd/eal.c                     |  245 +---
 lib/eal/linux/eal.c                       |  470 +------
 lib/eal/linux/eal_memory.c                |    2 +-
 lib/eal/meson.build                       |    2 +-
 lib/eal/windows/eal.c                     |  156 +--
 lib/meson.build                           |    1 +
 19 files changed, 1500 insertions(+), 1454 deletions(-)
 create mode 100644 lib/eal/common/eal_option_list.h

--
2.48.1

