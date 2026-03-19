Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE7D1090257
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:14:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D10C4065A;
	Thu, 19 Mar 2026 18:14:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 19882402C6;
 Thu, 19 Mar 2026 18:13:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773940437; x=1805476437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zuX3GSckrco/0MLRsptC2rN13XHViQ4CIBbxkKuTXW0=;
 b=TNX1oIP4vzja9FPimxa63VQB7Jfe5dfavgh/nH8UMaqluIS3PVNJkDWB
 i06xRtXUlUn/bzYVt31yKoPJkFriSjvrTbZDvxzx1IRoO4KXuyRCAhCeJ
 +bdDhKe0OZlf6OC91gRsuDPL0afhRrhfoVFQZLBtqYHeT4W9Afjw2sR6b
 Z+QhAS04FIr5fDnnIzGbyAlKODhoBDe7CNsuWnGh+jPRAdk/Tl9vitnLl
 /KqEq+RE63dOFOr30jdJEIfBsgkohGbzUyMC3ThPImo8Bk0dVNSzoM1Zq
 ps9oCg7ym3wQ1nToHg9bdRIDZNHLs7MDZJcamSbM9pW6ChsUNwRR2v0uZ g==;
X-CSE-ConnectionGUID: pVkj59ojQQScmXLupaCPJQ==
X-CSE-MsgGUID: +sEuqY0QQAKgBi31Vm5xVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85648041"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85648041"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 10:13:45 -0700
X-CSE-ConnectionGUID: fIDkOlS8SAW4/YfwIlXv8w==
X-CSE-MsgGUID: VD8jc6qbTqi7ByvKpX0Yrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="227979633"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 10:13:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: lylavoie@iol.unh.edu, probb@iol.unh.edu, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH 4/7] test/secondary_process: skip test on FreeBSD
Date: Thu, 19 Mar 2026 17:11:38 +0000
Message-ID: <20260319171334.1151425-5-bruce.richardson@intel.com>
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

Since there is no secondary process support on FreeBSD skip the unit
tests for that feature.

Bugzilla ID: 761 (partial fix)
Fixes: 764bf26873b9 ("add FreeBSD support")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_mp_secondary.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index 218eacb3bf..93fcfd735b 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -15,11 +15,11 @@
 #include <string.h>
 #include <unistd.h>
 
-#ifdef RTE_EXEC_ENV_WINDOWS
+#ifndef RTE_EXEC_ENV_LINUX
 int
 test_mp_secondary(void)
 {
-	printf("mp_secondary not supported on Windows, skipping test\n");
+	printf("Multiprocess support on present on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 #else
-- 
2.51.0

