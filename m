Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23495D3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 11:53:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCB5E40A7A;
	Mon,  8 Dec 2025 12:53:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8767C406A2;
 Mon,  8 Dec 2025 12:52:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765194780; x=1796730780;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i1gac9Iy3dG4jpWFIwe7aW6X0fO2kmgAD8oRINOd1BM=;
 b=ewD1KYqRHQXWLVyh1U/FeNyavXUehHpNJxGehjQTR4Ib4kY8pJVf3pB6
 QoP6vCIW0Abf3gTg2dCaSnkODi+Gqa/O5KrLQEJz1EcvLWw+d3I4RkI6D
 RK78YbcCxbweERwtJxqf2tYqCCHrndGsXK2XdnQ5YNKM1LixjZV6CAyuo
 rNmdARwuwaigrBtkPwcAQ04bJ9wnV16UQmsZyRthyldyotrfTfwLFo2Zi
 TByWlT+WTSo8hEPDujqXiGzcW7gDEJhE0xP8upx3OePkC9D3G3bw8s9lH
 s35RK0HsVdthslc2aTqVide2wIpklApDFS3Ea8exzcjuw9dLEFPyZYTEY Q==;
X-CSE-ConnectionGUID: /znzlsLPRFum6RErEMoFSA==
X-CSE-MsgGUID: QKhSvY7pRSSl0tupdzVC2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67096065"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67096065"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 03:52:59 -0800
X-CSE-ConnectionGUID: mPc0xJ40RMWNPQ5FG3Xbgg==
X-CSE-MsgGUID: Dx/D8lgcTyi2W27wvWGbbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195970679"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 08 Dec 2025 03:52:59 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v3 10/11] buildtools/get-test-suites: suppress empty output
Date: Mon,  8 Dec 2025 11:52:44 +0000
Message-ID: <20251208115245.3809624-11-bruce.richardson@intel.com>
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

If there are no tests which are not assigned to a test suite, omit the
line printing the non_suite_tests. This avoid having error messages from
meson about test "" not being in any test suite.

Fixes: 25065ef1f6c0 ("test: emit warning for orphaned tests")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
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

