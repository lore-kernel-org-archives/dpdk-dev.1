Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A778510F9961
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 17:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 726C140269;
	Wed,  8 Apr 2026 19:44:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5B5F54014F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 19:44:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775670250; x=1807206250;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uQPsa63BAU4NyDLLElDRrWMGDBOqvDCG9BeDM3O6rtE=;
 b=gq4QFS3df3fweH2SHgGlLpO78Y/eFOEvPXMr8maqqC7MK1ryjhJD5szh
 FXZMLkfXp77sjrByTF1VX4WRzx/NknHDtpqwRoAI+Nr/xsbCHabNUJMRb
 1yF+NYUChvCtdkYLWPQtmQriNXFCtu2W8Jdekz6uF4+neyCBhGC/QW/+X
 IP2yTdfnSFeklbR8H79iBk8zbK6uYRcNX4+HT1HOJlGmZbYiXvL3UWuUb
 +bYt4S+6iIe8qjscm4MU6RcSINWF4Coj2YHZ2eojxbSe/PuLeIn879mIX
 XZRztWOCDpFuJPSdtrbBTE/TBg6zQI0tt4NS23UbeqbSkY0Q0EvEvJD2P Q==;
X-CSE-ConnectionGUID: CpDwm8nESHK3oCtxzwIUrg==
X-CSE-MsgGUID: qMo3Jgq8S5i7O6jj/yrPgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76851140"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="76851140"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 10:44:09 -0700
X-CSE-ConnectionGUID: FvBncsDcRzaQJk8Es0VUDA==
X-CSE-MsgGUID: uAuFGTFsQouY4oXfw4S9wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="266510664"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 08 Apr 2026 10:44:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, thomas@monjalon.net,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 0/2] Get fast-test suite to run on FreeBSD
Date: Wed,  8 Apr 2026 18:44:02 +0100
Message-ID: <20260408174404.2002743-1-bruce.richardson@intel.com>
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

V3:
* fix typo in patch 1
* expand explanation in commit log of patch 2

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

