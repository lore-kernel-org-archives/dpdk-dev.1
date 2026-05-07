Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5C4CD3439
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 14:59:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A3234060A;
	Thu,  7 May 2026 16:59:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id C80144026A
 for <dev@dpdk.org>; Thu,  7 May 2026 16:59:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778165997; x=1809701997;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZgFTySQrIfdtjrSZlvPBGaAkdEBpw9/VkreotaaFZw0=;
 b=C8L5r/cGLKJgo9ahkA9OUhlJE83FalReTMBiW+QCzAocuwjKV0MX850A
 Jof5fyKkXc/zHBA8P/FefHBafNQAzUkDCBs1FuKaQlDvKSwJHBhF+yT0o
 tVVE/u9oIXg025CWZYGFlCO57y3ImgreDSrsMG9H3Lfyda2SRmyuyjO8z
 ewqB4bq8xCnQmrugM70COO7pTwWdf8yqbSjDbsLofCYdjetyZapp4vzfX
 ALvxltz3V17h9RC/HvEvTXza1oR+7jqvP1inGZyY3LDRwXv0XE4KAOVuu
 uW++HZRIAG4pActQSKYgbFPd1jFsbBKohuBmjuzD9m4fIBMibyhKWCFp9 g==;
X-CSE-ConnectionGUID: VJBYQ6DuSYStGbIGL49/jQ==
X-CSE-MsgGUID: PxmrnSWRTyqlc5T3zCz3Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82738153"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="82738153"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 07:59:56 -0700
X-CSE-ConnectionGUID: 63iOLZC0T3CMjInYxCuh+w==
X-CSE-MsgGUID: Hd5V5tziTtGQta54+q4+9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="233818171"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 07 May 2026 07:59:55 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/6] add hardening checks to cmdline and cfgfile libs
Date: Thu,  7 May 2026 15:59:43 +0100
Message-ID: <20260507145950.197753-1-bruce.richardson@intel.com>
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

Using AI tools to review the cmdline and cfgfile libraries throws up a
couple of places in the libraries where additional hardening could help
prevent future issues. A number of these are purely defensive, e.g.
adding NULL checks to input parameters where a well-behaved app should
never call the function with a NULL value, and so those are not
explicitly marked for backport.

Bruce Richardson (6):
  cfgfile: add null checks to public APIs
  cfgfile: prevent issues with overflow on resize
  cmdline: harden parser result buffer handling
  cmdline: add explicit help function for bool type
  cmdline: guard zero-size destination buffers
  cmdline: add null checks for invalid input

 lib/cfgfile/rte_cfgfile.c          | 118 ++++++++++++++++++++---------
 lib/cmdline/cmdline.c              |   3 +
 lib/cmdline/cmdline_parse.c        |   6 +-
 lib/cmdline/cmdline_parse_bool.c   |  37 ++++++++-
 lib/cmdline/cmdline_parse_num.c    |   2 +-
 lib/cmdline/cmdline_parse_string.c |   3 +
 lib/cmdline/cmdline_rdline.c       |   3 +
 7 files changed, 128 insertions(+), 44 deletions(-)

--
2.51.0

