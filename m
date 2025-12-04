Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FF7D29FAB
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 18:22:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF7BB40A8A;
	Thu,  4 Dec 2025 19:21:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 38C684067A;
 Thu,  4 Dec 2025 19:21:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764872470; x=1796408470;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pca4zpiWh3YVecNrK/YVI1UX+DecIw7yxg6ZCnp67bA=;
 b=MWiUcm3c5PdTHTKoeU84wPFg62bVQkiYXKNBR/0fwRgxVuPpLJbjeOJi
 uNKq42WQ0BCx5CJNY7hNXgi6ZwTicullxmydq30/KLIvG96WcZAMR+lKY
 29/+H8KniIONOAgKsNUXJ2ipZwdrwE9nl186C0DBY81n7bjYYHoNXuT9Q
 fgu3vQ/x2BLs6SzvZpgsxDX7s0yzs5ol01p6BtQk2PeBeH9OhtL0Qfry4
 9JzR7tTeiJcJbVQkVrQ96OpnheGolvYFg4bFqoUxIF9DLQmqpdag72YTl
 mdPZnLO5Ad177JPmVOdkllvf2WR2lgdWLne+k8DNJhedlGHlXOHOPSnn5 Q==;
X-CSE-ConnectionGUID: 3GKSKgDfQUWS8fnqsKr14g==
X-CSE-MsgGUID: pAT/cKR9RG+zbUXEm8VVNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78013042"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="78013042"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 10:21:09 -0800
X-CSE-ConnectionGUID: y05osEzETl6DrFtCJgp+bA==
X-CSE-MsgGUID: 0xMHotPxQbmdhZNm35qVPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="218423211"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2025 10:21:09 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 10/10] buildtools/get-test-suites: suppress empty output
Date: Thu,  4 Dec 2025 18:20:47 +0000
Message-ID: <20251204182047.3154429-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204182047.3154429-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
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

If there are no tests which are not assigned to a test suite, omit the
line printing the non_suite_tests. This avoid having error messages from
meson about test "" not being in any test suite.

Fixes: 25065ef1f6c0 ("test: emit warning for orphaned tests")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 buildtools/get-test-suites.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/buildtools/get-test-suites.py b/buildtools/get-test-suites.py
index 73f1d9c9e1..36ed4bedc2 100644
--- a/buildtools/get-test-suites.py
+++ b/buildtools/get-test-suites.py
@@ -38,4 +38,5 @@ def get_fast_test_params(test_name, ln):
 
 for suite in test_suites.keys():
     print(f"{suite}={','.join(test_suites[suite])}")
-print(f"non_suite_tests={','.join(non_suite_tests)}")
+if non_suite_tests:
+    print(f"non_suite_tests={','.join(non_suite_tests)}")
-- 
2.51.0

