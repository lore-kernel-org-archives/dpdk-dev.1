Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E57F94CA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 19:52:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4703A4028F;
	Tue, 21 Apr 2026 21:52:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 029044028F
 for <dev@dpdk.org>; Tue, 21 Apr 2026 21:52:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776801157; x=1808337157;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gJTT7OoVf+ZTRTL9cta29knxZNp9/YLlJThwOE0FvTQ=;
 b=JpstGYrquIX2a9rL/+c3zdRfWAk6FkK5GdaFSk6LII8ndDyH/MMNERQE
 XPow2PdcB3AtSM9kD2lA3K4h2mTv+9zh/DRFl+WKG/wzultZvYORiuNHF
 771VCH4IaHTPa/rNmZDs3OJN9ArnZbj/ou3UhEQdIVCXMKrofdgm86+Xn
 LG3YGfjxFxNlPRx8VEQK/+kCF2sX08aBuwdCvQFOq0qXLZFDiUWlx0rzU
 jP420fE9tWri4kyWidVO89KLXmyAjDTQWMj/MvbZxUcBIU8bfB0nG3Xuq
 4tFxiEGCiJYASQNV2XvrevO686gwqsWL/IEOb0iYGzchMZYq5xm/juqg1 w==;
X-CSE-ConnectionGUID: jvyTG9GhRBG2qNtL6l8rtQ==
X-CSE-MsgGUID: K1X4ZIZJTTqLdxAlzV21og==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="76909501"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="76909501"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 12:52:35 -0700
X-CSE-ConnectionGUID: no17U3vPSPiwILh4t407+A==
X-CSE-MsgGUID: WfqdFRyNRuq8p/c3e9dcZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="236507375"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 21 Apr 2026 12:52:34 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 0/2] Get fast-test suite to run on FreeBSD
Date: Tue, 21 Apr 2026 20:52:25 +0100
Message-ID: <20260421195227.1425625-1-bruce.richardson@intel.com>
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

V4: resubmit of v3 rebased on latest main

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

