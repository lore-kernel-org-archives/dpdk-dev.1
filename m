Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5951CD3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 11:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E284C40A7F;
	Mon,  8 Dec 2025 12:53:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6F784406BA
 for <dev@dpdk.org>; Mon,  8 Dec 2025 12:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765194781; x=1796730781;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IDE9hJgHc3DVPsQUeeff0e6ptDqJRDFCzRS56Zn+uSg=;
 b=X0wEdye7uEHGtNsfZ6rCypRkDVUZPqV28x91WGvyg7wq/rg3y8QG5lKP
 H2E01TvfAyRblFqrv0bU3rD9ra900SR9Sl/N5pprjyaozgJEntNGRiPSX
 LHtWC8ro7n/3+5thuwLGI6bO/Nu+DNKr2th/smj7vOkhFlMddCpp6GPYq
 yMIFbh3iaIiOdBMzgnPsh/eWdjVdePHq/7viR8PxUYBJE48rxcltinV8U
 sIruqdaxl25d0TlJ65lO3ro9yi6mGxZ9L0Uk+Vq3ONBe2keSraidlKyQd
 MEOQDj13zNAZZF65ECT6rSJ6HNamxQWe8T2yYPEDeaSHkpAqhDiYDxtje Q==;
X-CSE-ConnectionGUID: QmxofZ16SmKwkbgnepSw2A==
X-CSE-MsgGUID: sYg+VihVRrahKu/s231Jfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67096072"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67096072"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 03:53:00 -0800
X-CSE-ConnectionGUID: p5edr1xCSvu7oQSA0RpWlQ==
X-CSE-MsgGUID: Ykl6ePyJTKao5CB4l/Z9oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195970683"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 08 Dec 2025 03:53:00 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 11/11] app/test: move red autotest to attic
Date: Mon,  8 Dec 2025 11:52:45 +0000
Message-ID: <20251208115245.3809624-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208115245.3809624-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
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

Define an "attic" test suite for unstable or unmaintained tests, and
move the red autotest to that suite.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test.h     | 4 ++++
 app/test/test_red.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/app/test/test.h b/app/test/test.h
index 30a8e1b8f1..10dc45f19d 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -218,5 +218,9 @@ void add_test_command(struct test_command *t);
  */
 #define REGISTER_FAST_TEST(cmd, no_huge, ASan, func)  REGISTER_TEST_COMMAND(cmd, func)
 
+/* For unstable or experimental tests cases which need work or which may be removed
+ * in the future.
+ */
+#define REGISTER_ATTIC_TEST REGISTER_TEST_COMMAND
 
 #endif
diff --git a/app/test/test_red.c b/app/test/test_red.c
index 7f38ed1469..23013237c0 100644
--- a/app/test/test_red.c
+++ b/app/test/test_red.c
@@ -1872,6 +1872,6 @@ test_red_all(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(red_autotest, test_red);
+REGISTER_ATTIC_TEST(red_autotest, test_red);
 REGISTER_PERF_TEST(red_perf, test_red_perf);
 REGISTER_PERF_TEST(red_all, test_red_all);
-- 
2.51.0

