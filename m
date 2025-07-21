Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA49C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50DA8402E2;
	Mon, 21 Jul 2025 17:16:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9E43540297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:16:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753111010; x=1784647010;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mT4bFu5eeIUTYjKtLr7knX+6Ck8TyQE5IPNAGLQfWrs=;
 b=DT/32Ut2XDGGgu03WURWdNtjf4lNTRQoXamVKZL59A5x96SQcIBumn1R
 XNs4VNqgQNnrVK5ItY7r0ysUEOxpM5MkthHmkVGysN77B/wDeyNhLxhN5
 so4726rvx5kOIxjHMZNNHeOQ5nMFikRj8z+2CL6OKcv/YEVCtMZRS36Zf
 3kRzHvq2apnixO3BlfqFEoY14pEqnstKwJECHAPq7rfGeYw3Bq7I3LlzW
 z7C0+RLBZpXHMBt9R7EBqdKVRfLl5b+/pcS35s1rdsYNJK0EGLmxrHEjc
 IpqPTHnYISWeb4SPb4I4yFHvf7M8VT+6r7JMQ9QyA0TpcfERIqRapzNVO g==;
X-CSE-ConnectionGUID: oXXrrNrlSRqjQ17TDW5vqg==
X-CSE-MsgGUID: 1BluSC0RTUmeo2xxhyBDpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="42949370"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="42949370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 08:16:49 -0700
X-CSE-ConnectionGUID: FYTRZOKjSI+pZz2Wa9s/Gw==
X-CSE-MsgGUID: Hvc0w4r9TjeHmrBoQ2hihQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="182575388"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2025 08:16:47 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 0/9] rework EAL argument parsing
Date: Mon, 21 Jul 2025 16:16:33 +0100
Message-ID: <20250721151643.2739725-1-bruce.richardson@intel.com>
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
argparse library in DPDK. With recent changes, and two additional
patches at the start of this set, this library now meets our needs for
EAL argument parsing and allows us to not need to do direct getopt
argument processing inside EAL at all.

An additional benefit of this work is that the argument parsing for EAL
is much more centralised into common options and the options list file.
This single list with ifdefs makes it clear to the viewer what options
are common across OS's, vs what are unix-only or linux-only.

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

Bruce Richardson (9):
  build: add define for the OS environment name
  argparse: export function to print help text for object
  argparse: allow user-override of help printing
  eal: add long options for each short option
  eal: define the EAL parameters in argparse format
  eal: gather EAL args before processing
  eal: ensure proper cleanup on EAL init failure
  eal: combine parameter validation checks
  eal: simplify handling of conflicting cmdline options

 config/meson.build                        |    1 +
 doc/guides/contributing/design.rst        |    2 +-
 doc/guides/linux_gsg/eal_args.include.rst |   20 +-
 doc/guides/prog_guide/argparse_lib.rst    |   16 +
 lib/argparse/rte_argparse.c               |   46 +-
 lib/argparse/rte_argparse.h               |   21 +-
 lib/eal/common/eal_common_memory.c        |    3 +-
 lib/eal/common/eal_common_options.c       | 1217 +++++++++++----------
 lib/eal/common/eal_option_list.h          |   90 ++
 lib/eal/common/eal_options.h              |  102 +-
 lib/eal/common/eal_private.h              |   11 +
 lib/eal/freebsd/eal.c                     |  245 +----
 lib/eal/linux/eal.c                       |  470 +-------
 lib/eal/linux/eal_memory.c                |    2 +-
 lib/eal/meson.build                       |    2 +-
 lib/eal/windows/eal.c                     |  156 +--
 lib/meson.build                           |    1 +
 17 files changed, 960 insertions(+), 1445 deletions(-)
 create mode 100644 lib/eal/common/eal_option_list.h

--
2.48.1

