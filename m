Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DBDC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:09:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7058F402E2;
	Mon, 21 Jul 2025 17:09:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5B53240297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753110540; x=1784646540;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o9cp56gcdpKtpWaotIGfMh4rOb2vvd9i8bbe8wc0gFI=;
 b=HoK7BPS4u7O/FiCAqYUBGddhEO7IwnlORn1ziJj0ugjrXgTMYGJL+z6Q
 qhhp1HUMAqBU2ULbpMFVvN8dug0x3j6cxdCPzgP1lu/3jfdwuvv2uiwbJ
 SLr2ok8l79J9VRa/KARkM9mtA2PGPGvfLNfxpy85zsC/lpp0YgpQYkO5t
 g7IPnI7jAAFaWU3TGXz0aN0kAsZxdnMk7GqmhFgvgGmqcTVE71GrtiuQ1
 j9KTFkxJGLVBFdq6r77WvNa8XdD6tpz/R8Hvur/STbLoIbqcic/6aLK+T
 kigF72x/XWY9VIoLxfzX6RJ53EeEbx92ax7xAJw0xTgCck5drXGoGuH3c g==;
X-CSE-ConnectionGUID: ZClNq1D5QoiRim6J7HsJqA==
X-CSE-MsgGUID: 6EUsHV0mTnKz+IRu0CylAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55179734"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="55179734"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 08:08:59 -0700
X-CSE-ConnectionGUID: GuxZcpsBQ/uv7J1lEOLwpA==
X-CSE-MsgGUID: i0GkAjRCRIe2ekCNIJeSdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="159291081"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa008.jf.intel.com with ESMTP; 21 Jul 2025 08:08:59 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 0/9] rework EAL argument parsing
Date: Mon, 21 Jul 2025 16:08:33 +0100
Message-ID: <20250721150843.2737763-2-bruce.richardson@intel.com>
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

