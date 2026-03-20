Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F38710987A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 16:11:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA7D8402BB;
	Fri, 20 Mar 2026 17:11:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 41D4A402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 17:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774023079; x=1805559079;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GhT4NPb+5EoFShPKJQZUJfBT/IhUm9w5DORD/gFJ0Uc=;
 b=IK2AqlWvte5vkXbRXWKNGg/bsZienIDn3aeF79GvvwO63Uf5hf41PaNT
 UWJ4i9ABVPhSboRVyWC18P9Y091Xv3p89y8burzaemoaMoPpO7pPv2j1I
 De+0PmPgLsqUBIdMOGOI0N9IP5xCckDlemphcaupqgBWoS/vK75453Nv6
 8IayPmBfjd/lALn1KFM1fHAwSESJfSduLBwhDvoDj0fWgC4qJTndQ0Bpd
 5+a9nue+lWIsnK2wOHTd73E0PHi4WrtiW5JOyFhXP1d+x57RyKn4bgTF9
 RSul2noDVvl2kFyHQ2wJJ6QopYLQNBs33DDzlU2Bgr/F9/TxKsGRMSVJQ g==;
X-CSE-ConnectionGUID: MxY/b7cQTtW3GjKCVEos7g==
X-CSE-MsgGUID: PdDSIFwWTWSrzX/fu6ncyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74995148"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="74995148"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 09:11:17 -0700
X-CSE-ConnectionGUID: V+3UtgZ8RQ+LtWD3oiBOeg==
X-CSE-MsgGUID: Y7VV8umAT8yRQryVO8jgqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="223546847"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 20 Mar 2026 09:11:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, probb@iol.unh.edu,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/2] Get fast-test suite to run on FreeBSD
Date: Fri, 20 Mar 2026 16:11:06 +0000
Message-ID: <20260320161108.331745-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319171334.1151425-1-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
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

The standard "fast-tests" suite is used to sanity-check large parts
of the DPDK codebase, but it failed to run successfully on FreeBSD,
with large numbers of failures. This is a long-standing issue reported
in Bugzilla back in 2021 as issue 761.

This set attempts to rectify this situation by allowing the suite
to run without errors. Mostly it does this by disabling test suites
that rely on features like multi-process which are unsupported on
FreeBSD. It also fixes the test_debug suite which should run on
BSD but was failing.

v2:
* squash patches for fixes into patch 1
* separate patch for some cleanup of process spawning into patch 2 which
  does not need backport

Bruce Richardson (2):
  test: fix failing tests on FreeBSD
  test: simplify spawning extra test processes

 app/test/process.h              | 20 ++------------------
 app/test/test_debug.c           |  6 +++---
 app/test/test_eal_flags.c       | 26 +++++++++++++-------------
 app/test/test_external_mem.c    |  4 ++--
 app/test/test_interrupts.c      |  2 +-
 app/test/test_mp_secondary.c    |  4 ++--
 app/test/test_pdump.c           |  4 ++++
 app/test/test_timer_secondary.c |  4 ++--
 8 files changed, 29 insertions(+), 41 deletions(-)

--
2.51.0

