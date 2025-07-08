Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD40AC83F0A
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 17:20:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBBFE40292;
	Tue,  8 Jul 2025 19:20:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 510524025E
 for <dev@dpdk.org>; Tue,  8 Jul 2025 19:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751995249; x=1783531249;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Rirt+FBJWc2EDP7ztBGmOmXOv3en4gkWZYZTCfDtBj8=;
 b=Ue0qYunYkHNAMBkHjbzUrwsvH3GOnOYSZf6lXnmuXrAXmhCbWK1ofO7j
 8XuQ/WqbzG8xr86uWZ1lt3jy8EQKUoXEFy/yKErYFfzYgjwJvgdzzRRBx
 PqKt66VgHq1lB4mh8c4t9+2UDQRWUsXyVSqx3eHxWxxdJ2yCDkPuIwLJ4
 0tC7Yuq2WshNnhrVwXrFzesmNtLZ5O2/snQPZThzD+9DpPTUezySR72e/
 andV13LUmQlcJ1xNu8QCPaunUosVoZgZF7gXwIf4wslyhdnvIRKlKup+r
 N/QQNASH/sTOdOi0mGN/rdjrL1/2izZOWOcl5MddyXgcmbVLObypi3Frj Q==;
X-CSE-ConnectionGUID: Bvw2VsNpQmiJBXZLq6sXWw==
X-CSE-MsgGUID: qM/GVCmQTFab8gELWHHSbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57913118"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57913118"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 10:20:48 -0700
X-CSE-ConnectionGUID: J6/4YOW0SHKzUtO4id6XYg==
X-CSE-MsgGUID: chKsaE7DT3yu6RH2Y0FpcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="161200605"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by orviesa005.jf.intel.com with ESMTP; 08 Jul 2025 10:20:46 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v2 0/5] rework EAL argument parsing in DPDK
Date: Tue,  8 Jul 2025 17:20:34 +0000
Message-ID: <20250708172039.183989-1-bruce.richardson@intel.com>
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

This RFC is a second, more complete, prototype of one approach we may
want to take to help improve management of EAL cmdline arguments.

BACKGROUND:
- The first problem that led to this work was that of providing a
  way for users to easily provide a set of CPU cores to DPDK where the
  CPU ids are >= RTE_MAX_LCORE
- There are a number of solutions which were discussed for this, most
  of which involved automatically remapping CPU ids to lcore ids
  starting at zero.
- However, in discussion with David M. at the last DPDK Summit in
  Prague, he pointed out the main difficulty with all these approaches
  in that they don't work with multi-process, since we can't reuse lcore
  id numbers in secondary process.
- This in turn lead to a realisation that when processing cmdline
  arguments in DPDK, we always do so with very little context. So, for
  example, when processing the "-l" flag, we have no idea whether there
  will be later a --proc-type=secondary flag. We have all sorts of
  post-arg-processing checks in place to try and catch these scenarios.

This patchset therefore tries to simplify the handling of argument
processing, by explicitly doing an initial pass to collate all arguments
into a structure. Thereafter, the actual arg parsing is done in a fixed
order, meaning that e.g. when processing the --main-lcore flag, we have
already processed the service core flags. We also can far quicker and
easier check for conflicting options, since they can all be checked for
NULL/non-NULL in the arg structure immediately after the struct has been
populated.

To do the initial argument gathering, this RFC uses the existing argparse
library in DPDK. With recent changes, this now meets our needs for EAL
argument parsing and allows us to not need to do direct getopt argument
processing inside EAL at all.

An additional benefit of this work, is that the argument parsing for EAL
is much more centralised into common options. This reduces code a bit.
However, what is missing here is proper handling for unsupported options
across BSD and Windows. We can either take two approaches:
1. just ifdef them out so they don't appear in the argparse list on
   unsupported platforms, giving errors when used.
2. keep them in the list of arguments, and ignore them (with warning) when
   used on unsupported platforms.
The advantage of #1 is that it is simple and correct, but the advantage
of #2 is that is makes it easier to move scripts and commandline args
between platforms - but at the cost of the arg list shown by help to be
less accurate.

Bruce Richardson (5):
  eal: add long options for each short option
  eal: define the EAL parameters in argparse format
  eal: gather EAL args before processing
  eal: combine parameter validation checks
  eal: simplify handling of conflicting cmdline options

 lib/eal/common/eal_common_memory.c  |    3 +-
 lib/eal/common/eal_common_options.c | 1236 ++++++++++++++-------------
 lib/eal/common/eal_options.h        |  101 +--
 lib/eal/common/eal_private.h        |   11 +
 lib/eal/freebsd/eal.c               |  164 +---
 lib/eal/linux/eal.c                 |  384 +--------
 lib/eal/linux/eal_memory.c          |    2 +-
 lib/eal/meson.build                 |    2 +-
 lib/eal/windows/eal.c               |  113 +--
 lib/meson.build                     |    1 +
 10 files changed, 726 insertions(+), 1291 deletions(-)

-- 
2.48.1

