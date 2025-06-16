Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8DEC71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 10:49:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A003A40616;
	Mon, 16 Jun 2025 12:49:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 94F1940430
 for <dev@dpdk.org>; Mon, 16 Jun 2025 12:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750070993; x=1781606993;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ss3mGu9zL04LJ1HSfCLyHNc+0T9JFrHT+tDqKtM/4/4=;
 b=H3b7eoVHIs9PO1ZgUOlG1oPH5SGnXcpLKTUqnCy4v5m/ZQmTeCN5MfUE
 c0mB3eloNqclrKBDh2G2gWSi95gYCFGJA1jtRBiLmfdqnoe6zCnlQOU0W
 Ern8xUew8P4rjVOtb5laYy31s8V+owcOKrsTOE/fAXD+OyI2a2Nc/fHcY
 kxpzcAt1hhSAuaZNnum+06zDjeE7CzegdPbMN+UmzG2hmFtdcsiowVbQA
 Vgrk4th4FEEHXwld/SOP8bnYeFxyiwKkJYKA3EVKxHzfxADLVC3WPgo48
 Nw1rbSmZrlG8ZrtMVSYOntZ5g4Z8rcDhRvxLesTzG125mZh6/XFPRjwv8 g==;
X-CSE-ConnectionGUID: MVc3l/BNQbK7Qa5ztjxLtw==
X-CSE-MsgGUID: mDNysF88Q263YkkY9YDESQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="54828143"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="54828143"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 03:49:51 -0700
X-CSE-ConnectionGUID: P0cHFdHbSueHvjORXsDpcg==
X-CSE-MsgGUID: ZaVsyxvgQ4mQoXP7pbzcbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="148281486"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa006.fm.intel.com with ESMTP; 16 Jun 2025 03:49:50 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/3] argparse: improve handling of multi-instance args
Date: Mon, 16 Jun 2025 11:49:40 +0100
Message-ID: <20250616104944.3425929-1-bruce.richardson@intel.com>
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

Coverity (correctly) identified an issue[1] where, after the recent
rework[2], the internal flag, used by argparse to track what arguments
were previously encountered or not, was out of range for the type and no
longer having any effect. Fixing this flag to be back into range then,
somewhat surprisingly, caused a number of unit test failures to occur.

The reason for these failures is that the tracking of args encountered
is done via setting an internal flag on the user-passed arguments
object. In the unit tests, this caused issues where the flags field was
not getting properly reset between calls to the parse operation. [This
is only an issue after the rework, because previously information like
param type and optionality was encoded in the flags, so they were more
often reset during testing].

Rather than fixing the tests directly to always reset the flags, which
is simply working around the issue IMHO, this patchset instead fixes the
issue in a more user-friendly way by changing the library to never
modify the user-passed structure - making it completely safe to reuse
across multiple calls. This is done in the first two patches.

The final, third patch, adds an additional unit test to check that the
tracking of flags being seen or not, and the handling of the
"RTE_ARGPARSE_FLAG_SUPPORT_MULTI" flag is correct. This closes a gap in
testing, since the original issue of the flag being out-of-range should
have been caught in testing, rather than having to rely on coverity.

[1] Coverity Issue: 470190
[2] https://github.com/DPDK/dpdk/commit/04acc21beeeb78477b15a3f497d3628fd70a6a9f

Bruce Richardson (3):
  argparse: track parsed arguments internally
  argparse: mark parameter struct as const
  test/argparse: add test for repeated arguments

 app/test/test_argparse.c    | 33 +++++++++++++++++
 lib/argparse/rte_argparse.c | 73 ++++++++++++++++++++++---------------
 lib/argparse/rte_argparse.h |  2 +-
 3 files changed, 77 insertions(+), 31 deletions(-)

--
2.48.1

