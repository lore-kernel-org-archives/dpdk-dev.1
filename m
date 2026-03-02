Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76744EA4E36
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 16:08:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F412E40DD1;
	Mon,  2 Mar 2026 17:08:07 +0100 (CET)
Received: from mgamail.intel.com (unknown [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8CAE5400D7;
 Mon,  2 Mar 2026 17:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772467687; x=1804003687;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+9BI0ElvhLUu/2DTCo4lOBpu3m+Yj/+SoYtU0Eys3uQ=;
 b=Y1ArprLzPpm+CibOa7pJhR95qPF3Nfi8Urngj3SdEXD17qN5jSYg4cTe
 iKOYE7lYcSoTkj70iQFRM6AF5TI/p3i5HY2FGNCCaVaaPVkFI1xdiyk42
 2uEguTuY7HmK9O1Vg6JW20qMNeyu0enqc1d5Sc78027cci0+S4QQ4IxIa
 h+KLh99ww5B7zTgrclkQ9/WCf+eizM2/85zq2xQd4OrXi8mQXgxpRWfpQ
 E2KcArjOs8veuSGrZroS+5tgTt9vQkvOhlMr0erkVyC66Lc3H0RXDjVwP
 3xOv09avOZ1dQKGCiEkzZOfQuqrL3uVd1jLyHQsfVWXi30ksLt5cf8p2n w==;
X-CSE-ConnectionGUID: t3g4ZdVtQ1yY1ynLEIhn6w==
X-CSE-MsgGUID: XjYTZx0QQ6qTqwoeXnBIcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="72508289"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; d="scan'208";a="72508289"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 08:07:45 -0800
X-CSE-ConnectionGUID: 2R6hUvFyQcOtLWtbrj6cpg==
X-CSE-MsgGUID: BtwexusaQB+Mch6xR/Hykw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; d="scan'208";a="222692720"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 02 Mar 2026 08:07:44 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] test/security_inline_proto: skip tests if no HW support
Date: Mon,  2 Mar 2026 16:07:40 +0000
Message-ID: <20260302160740.1292642-1-bruce.richardson@intel.com>
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

If the underlying ethdev HW does not support the security offload,
return back the TEST_SKIPPED return value to immediately skip the tests
rather than continuing to fail later.

Fixes: 108646569579 ("test/security: add event inline IPsec cases")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_security_inline_proto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 8b88fce3e9..b0cce5ebd9 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -2147,7 +2147,9 @@ event_inline_ipsec_testsuite_setup(void)
 		return TEST_SKIPPED;
 	}
 
-	init_mempools(NB_MBUF);
+	ret = init_mempools(NB_MBUF);
+	if (ret != 0)
+		return ret;
 
 	if (tx_pkts_burst == NULL) {
 		tx_pkts_burst = (struct rte_mbuf **)rte_calloc("tx_buff",
-- 
2.51.0

