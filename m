Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81BCD41D6B
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 17:18:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3527740E48;
	Thu, 11 Dec 2025 18:17:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id C991640E2E;
 Thu, 11 Dec 2025 18:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765473444; x=1797009444;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i1gac9Iy3dG4jpWFIwe7aW6X0fO2kmgAD8oRINOd1BM=;
 b=HamXhbBdG5PbiRxhIMI1U1tcjsxXpVzYS4ZBDTL+gNmzZJjxH+RaVlds
 jdHOWec+pukW236MKEfaFgy6+YkbjQ+RNOuofRFd/ZGv7ncBIQpK0dR1a
 YGmGyFkRxG22I98tHTzJABSzVk0W5TTT0uyJQ748c3jufLRC8nYV+6rK+
 6Xwrfutz3mMFgJCB93YqPLYHEUCMdxqmc6NuJed+mbKMywGyFkwA7yIG5
 P4gxyeatA+HzWwOSHMaw1BzIf0NEtZJMRh8A0UA3L9m8LpILFrAWS8thn
 0IofXI3Bj3CT1V+tP1NS7en88+ShO333SULPWH3Zvo0LW2DJB2IRsEkMi g==;
X-CSE-ConnectionGUID: BjyHSMKvQNSerKdtegEp+w==
X-CSE-MsgGUID: icv/9QFTTzWyeRMV5b7cig==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85069994"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="85069994"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 09:17:23 -0800
X-CSE-ConnectionGUID: YDyKF7gyTRyfnx8mqYpFlg==
X-CSE-MsgGUID: sp4OYijgQDaG9vqXUZunTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="196461596"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2025 09:17:23 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v4 10/11] buildtools/get-test-suites: suppress empty output
Date: Thu, 11 Dec 2025 17:17:08 +0000
Message-ID: <20251211171709.714229-11-bruce.richardson@intel.com>
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

