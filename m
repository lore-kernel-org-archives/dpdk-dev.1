Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BE6CCF2EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 11:56:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E498402CC;
	Mon, 19 Jan 2026 12:56:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2B538402C0
 for <dev@dpdk.org>; Mon, 19 Jan 2026 12:56:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768823775; x=1800359775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vr77Upypg0k3uGK2P0IVonvTyegy4cBhzdIvwFq062k=;
 b=dGcD6WQiPtA7GpcmbQZlqAmur/ZJWwo/zA1qfalavq/SOaJhXNECxbz/
 RoB/iggMo2s9F9DSKwwU69+7plhlSBX/1SrZ2wvBa3es8TThe5RgxakXr
 HdL2xE7DBrxVtzGWP8BaqrtWbRZ+daJGuxiotm/Y8zLyRx5OanOcpgCxH
 lzOrrCp5z88krZwF/sranEyneNFftsaxjWfA2LQJqq/nbwQiMFfzH0j/V
 hDLmDz1qMN+ZZBvEPbkuN4BtQnMcBN4lH/t1cWje+Sd9bZp5isOHNrazl
 Dc8BcS0knAngELtfLqemlraVDDOKUVtliBi7TqMJ48UH/d7dtd8vW/5lO A==;
X-CSE-ConnectionGUID: gYk5tj5kRTmtpMKTQAhRoA==
X-CSE-MsgGUID: tTmQOnOnRLCuMgPaCh6INw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69930647"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; d="scan'208";a="69930647"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2026 03:56:14 -0800
X-CSE-ConnectionGUID: CgxKpehDRVmK+vklkxxVvA==
X-CSE-MsgGUID: kdkXtgaSRwiNpCWm2dR6KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; d="scan'208";a="210867704"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 19 Jan 2026 03:56:13 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v2] ci: improve logging of unit tests runs
Date: Mon, 19 Jan 2026 11:56:07 +0000
Message-ID: <20260119115607.225929-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119104147.219027-1-bruce.richardson@intel.com>
References: <20260119104147.219027-1-bruce.richardson@intel.com>
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

To help track down issues reported by CI test runs, add some additional
meson flags to the run of the fast-tests:

--no-stdsplit:
  keep the stdout and stderr output interleaved, rather
  than separated in the logs, to make following what is happening during
  a test run easier.
--print-errorlogs:
  when an error with a unit test does occur, output to the terminal the
  last N lines of output. This allows us to see inline what may have
  failed without always needing to check log files.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
V2: Drop max-lines flag, since it's only introduced in very recent meson
    versions.
---
 .ci/linux-build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index ceead259f3..084d9642fc 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -218,7 +218,7 @@ fi
 if [ "$RUN_TESTS" = "true" ]; then
     failed=
     configure_coredump
-    sudo meson test -C build --suite fast-tests -t 3 || failed="true"
+    sudo meson test -C build --suite fast-tests -t 3 --no-stdsplit --print-errorlogs || failed="true"
     catch_coredump
     catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
     check_traces
-- 
2.51.0

