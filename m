Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EADC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 16:40:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99E7140B94;
	Tue, 20 May 2025 18:40:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id ADB224029C
 for <dev@dpdk.org>; Tue, 20 May 2025 18:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747759243; x=1779295243;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JpylTE1otNIe6HgIBohruPFZcpBOwvfvAGS5k7gh6z4=;
 b=ENU0OZAeL38GokXkPoA7rNdHBoMjV7GmolbOvUJt1rMDGZ69t+8j+OUO
 gf7HNCiqb3YbAlLQM84eehvbf7xXmcBIYmAhnvrnfDy1ym48RO/IsxYTe
 +pAUKn842xHPOVoAPuO/Fpf0XfQfqbZenscj0oiQ9k8+VoRwzChgoccB+
 1ADKWas/83Q7QvxrQe8nLhioGShC6sryLQk5Uqv04+yofpiCQD8N7wOb/
 Gu1d++d02dQVIZ4E3mwHTLNyBGyNE26PfTSCtsCg5lVxCR9UdRgtJr33m
 SU1SP+1rPoYqmbbivDRZQ+VTG3QkT6xlKGWwR8Dj2m/dzPVz3+NhfOjDY g==;
X-CSE-ConnectionGUID: teKxx7OORUGHja4Bn+jktw==
X-CSE-MsgGUID: B3JrJHjrSGmrCusL3lku3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="37320458"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="37320458"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 09:40:41 -0700
X-CSE-ConnectionGUID: 0R7aW1s+ReWh8aq80bEWEQ==
X-CSE-MsgGUID: nmve5BU6S023hWWRt4KGyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="170759470"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.30])
 by fmviesa001.fm.intel.com with ESMTP; 20 May 2025 09:40:41 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 0/7] rework EAL argument parsing in DPDK
Date: Tue, 20 May 2025 17:40:17 +0100
Message-ID: <20250520164025.2055721-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

This RFC is just an initial prototype of one approach we may want to
take to help improve management of EAL cmdline arguments.
Although not complete (no account taken yet for BSD or Windows),
it's hopefully complete enough to give an idea of what I think would
improve the handling.

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
library in DPDK. With some minor tweaking, this meets our needs for EAL
argument parsing and allows us to not need to do direct getopt argument
processing inside EAL at all.

Bruce Richardson (7):
  eal: add long options for each short option
  argparse: add support for string and boolean args
  argparse: make argparse EAL-args compatible
  eal: define the EAL parameters in argparse format
  eal: gather EAL args before processing
  eal: combine parameter validation checks
  eal: simplify handling of conflicting cmdline options

 app/test/test_argparse.c            |   46 +-
 lib/argparse/rte_argparse.c         |   46 +-
 lib/argparse/rte_argparse.h         |    9 +-
 lib/eal/common/eal_common_memory.c  |    3 +-
 lib/eal/common/eal_common_options.c | 1435 ++++++++++++++++-----------
 lib/eal/common/eal_options.h        |   99 +-
 lib/eal/common/eal_private.h        |   11 +
 lib/eal/linux/eal.c                 |  378 +------
 lib/eal/meson.build                 |    2 +-
 9 files changed, 966 insertions(+), 1063 deletions(-)

--
2.48.1

