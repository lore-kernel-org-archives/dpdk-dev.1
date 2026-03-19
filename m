Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA84E109025C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:13:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EFF0402BD;
	Thu, 19 Mar 2026 18:13:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 896124013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 18:13:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773940421; x=1805476421;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JgoPelVDRsB76TycRVxmlBx2CXzpOgt34/dUOWEO/YM=;
 b=IzBBG4SAW61IwZNyPDvp2a4j2FSk6n7I4tD5EFmoCBQ95GwPLn24iVjf
 GfbhV0PeZ0qgXg1zZBgxKibCztyquyBuI/Ot7ATVWP/CUTKnHh7mG0d39
 8MryxPGXBn+LxmM8IURBMA+4ICmxar8iQ/cX0ubZGxESTryVArpzzXk3Q
 fOnHDgF1/yf+KGKjFBFpy7s7JyMmIpWeagy6SZ08qF20XHuQHlZlgG7rW
 vym8c2ajTv+2Bgsbbqq74dAonY5ZLnI5/5vZUbovx1TQ/bViSvWf7aGUL
 vCq/KSGhxHWsoHkJDgRFa8laCZCSrWcZ2EwlHO8mmW+sL+EvIcVU97qEy g==;
X-CSE-ConnectionGUID: qEi0t1VGRQm2mjE+emirVw==
X-CSE-MsgGUID: y1nn9ysJSEOAlBSmzJXyqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85648022"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85648022"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 10:13:39 -0700
X-CSE-ConnectionGUID: flmYI0dySDeU0de2U2H4dw==
X-CSE-MsgGUID: KMPYCtr+QCGe+PgOjoz+Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="227979614"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 10:13:38 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: lylavoie@iol.unh.edu, probb@iol.unh.edu, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/7] Get fast-test suite to run on FreeBSD
Date: Thu, 19 Mar 2026 17:11:34 +0000
Message-ID: <20260319171334.1151425-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

Bugzilla ID: 761

The standard "fast-tests" suite is used to sanity-check large parts
of the DPDK codebase, but it failed to run successfully on FreeBSD,
with large numbers of failures. This is a long-standing issue reported
in Bugzilla back in 2021 (hence the 3-digit BZ ID)

This set attempts to rectify this situation by allowing the suite
to run without errors. Mostly it does this by disabling test suites
that rely on features like multi-process which are unsupported on
FreeBSD. It also fixes the test_debug suite which should run on
BSD but was failing.

After this set, a run on my FreeBSD system passes with zero failures
and 22 tests reported as skipped.

Bruce Richardson (7):
  test/timer_secondary: skip test on FreeBSD
  test/eal_flags: skip test on FreeBSD
  test/pdump: skip test on FreeBSD
  test/secondary_process: skip test on FreeBSD
  test/external_memory: skip test on FreeBSD
  test/interrupts: skip test on FreeBSD
  test/debug: fix unit test on FreeBSD

 app/test/process.h              | 11 ++++++++---
 app/test/test_debug.c           |  6 +++---
 app/test/test_eal_flags.c       | 26 +++++++++++++-------------
 app/test/test_external_mem.c    |  4 ++--
 app/test/test_interrupts.c      |  2 +-
 app/test/test_mp_secondary.c    |  4 ++--
 app/test/test_pdump.c           |  6 ++++++
 app/test/test_timer_secondary.c |  4 ++--
 8 files changed, 37 insertions(+), 26 deletions(-)

--
2.51.0

