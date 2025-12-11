Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EA2D41D6B
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 17:18:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 631EB40E5E;
	Thu, 11 Dec 2025 18:17:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 9393640E34
 for <dev@dpdk.org>; Thu, 11 Dec 2025 18:17:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765473445; x=1797009445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IDE9hJgHc3DVPsQUeeff0e6ptDqJRDFCzRS56Zn+uSg=;
 b=L8HPJraKAE4RRKwP1Tm3rZmc1DUic4BarL2Q3UTDwDxKSAXNKFfWaqDz
 hSw7xlQIKD6iqyCDhFiZKQzB77R4EIOk7h5lkFjL+ef9zwgWJ5H8h8rCL
 8YjSi2qROoM3ab5EfNtI0hQk6YAItQ+d/IMEuGsNN1lRAw3wHdglcrRTJ
 IC7my/HSLaJLHiJHDaKBnvGVChu8jgtKuRicsRLjYH4rB5fcWJ9AHy1Lm
 Bs+cWNMNKszBHINJB4NKZ+B0nSUbUeNyae+DTLp3UMDV4xgltHzvpL8yE
 tlMl44v6zkOeqYk6cHgmADCNQaO+x8/3JMwQ/Z2Tf0QV044BBnzQX0hi8 g==;
X-CSE-ConnectionGUID: q5vuylzvQZOffbAcNRZnmw==
X-CSE-MsgGUID: C0qaGJBKSkem0JZWuC+P8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85069996"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="85069996"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 09:17:24 -0800
X-CSE-ConnectionGUID: N16g4n9cRA2BAzUg1BSHSQ==
X-CSE-MsgGUID: 5LTD6phmQ/mjqN0hGbrEzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="196461599"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2025 09:17:24 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 11/11] app/test: move red autotest to attic
Date: Thu, 11 Dec 2025 17:17:09 +0000
Message-ID: <20251211171709.714229-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211171709.714229-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251211171709.714229-1-bruce.richardson@intel.com>
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

