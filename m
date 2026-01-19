Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDBCCCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 10:41:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 162B84025D;
	Mon, 19 Jan 2026 11:41:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 525494025A
 for <dev@dpdk.org>; Mon, 19 Jan 2026 11:41:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768819314; x=1800355314;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WHx+OTpQcP5wG+rndb6Y/QQelbNfq+9Br2HMKRBJA2E=;
 b=TGZVYRFzIBGaWAljchMYNCzBedq+sRkmB/80lUb+JWrVZtmsB0zmnIUB
 YEbdCzTM7q0EyMgN1LaaUiofBmY893QSlY1XnzfQIcBysiOcMUw9gm7qZ
 VmDp/bqP0t0+BeDCUZL25fSwm/cxd6xdWOf6i3fdhw5CUgLyZVRA2xYcs
 t93jHjmPebHuYHyz4aKbSYOUd5dUatCuVPuH8xzQmJrXEhL1e76j+hQJf
 1ipUMkTF83AxB41rY+EYzXhDxu7ivtedYfKlb79Yk5ZlxDMUIwxmRrqUt
 Wr81XDjxev7GgZnkqA8+lWnNObd1YCRXg9j7/+GnFOMo2CaTz4UOHjgg1 Q==;
X-CSE-ConnectionGUID: xjKPzWjiRT6yrjnOdJ0s9Q==
X-CSE-MsgGUID: XXtVbJo3TG+vSWsZTtKaDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="87610599"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; d="scan'208";a="87610599"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2026 02:41:52 -0800
X-CSE-ConnectionGUID: E15nQ/DVTuqX6+ekqyT+HQ==
X-CSE-MsgGUID: 1QOmGk+jSY+nGfzgRpr4zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; d="scan'208";a="210347007"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 19 Jan 2026 02:41:51 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH] ci: improve logging of unit tests runs
Date: Mon, 19 Jan 2026 10:41:47 +0000
Message-ID: <20260119104147.219027-1-bruce.richardson@intel.com>
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
--max-lines=20:
  limit output on error to just 20 lines, to avoid overloading the
  user with superfluous output.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 .ci/linux-build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index ceead259f3..f733da7758 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -218,7 +218,7 @@ fi
 if [ "$RUN_TESTS" = "true" ]; then
     failed=
     configure_coredump
-    sudo meson test -C build --suite fast-tests -t 3 || failed="true"
+    sudo meson test -C build --suite fast-tests -t 3 --no-stdsplit --print-errorlogs --max-lines=20 || failed="true"
     catch_coredump
     catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
     check_traces
-- 
2.51.0

