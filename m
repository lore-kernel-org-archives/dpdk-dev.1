Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD71D606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X5KvPbpH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AB9940678;
	Tue,  3 Nov 2026 18:30:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id ABA6C400D6;
 Tue,  3 Nov 2026 18:30:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793727047; x=1825263047;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8xr0D3JAUwmBHvv7+ON8lETwgXZ7YUGsHMGIMO0UkBU=;
 b=X5KvPbpHyMlR0z4qpvuqqJA8m1sXiLzN227gnmLG15sJYvDY/KUcCzWP
 qJajZS5JCjaRpeRpKCsx1Ij4KJlMDdm6lzonHYntgCt5hupXoPvorp3yK
 BHVif0jQAwqy4eN47rAuoGnzclwUv/ii7rvs6JiX4ZoYC4hPu8MqRZ2zd
 Ul5nE/ParIImUFjfUx+1OUEFPpXPjGi/DW96A7TRleuDRiBwOu63C8UYu
 a1KFICP36qMCX8sDahXrT0jqGYCVfjpX15kfUIcC3rb+VuSU8dE3CGyQA
 qOsERDmeljfehxRHdO23GrJWg6AbOJeOYy9VLD5NkwWqMg9T9TwJiWRwl A==;
X-CSE-ConnectionGUID: GPFSuyHsQnWHBEyHFP4TfQ==
X-CSE-MsgGUID: CroxkKKrQAS5hA/XToJCAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2553269"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2553269"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:28:58 -0800
X-CSE-ConnectionGUID: h+8+TliWQ/yloTauErFCXQ==
X-CSE-MsgGUID: C9Yn37LkTOiqVRdvKIxhdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6495698"
Received: from unknown (HELO an4-swa15-spr.example.org) ([10.241.130.94])
 by fmviesa004.fm.intel.com with ESMTP; 03 Nov 2026 09:28:57 -0800
From: Hernan Vargas <hernan.vargas@intel.com>
To: dev@dpdk.org, gakhil@marvell.com, trix@redhat.com,
 maxime.coquelin@redhat.com
Cc: nicolas.chautru@intel.com, qi.z.zhang@intel.com,
 Hernan Vargas <hernan.vargas@intel.com>, stable@dpdk.org
Subject: [PATCH v1 1/5] bbdev: fix status error for ops dump
Date: Tue,  3 Nov 2026 09:28:58 -0800
Message-Id: <20261103172902.4152956-2-hernan.vargas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103172902.4152956-1-hernan.vargas@intel.com>
References: <20261103172902.4152956-1-hernan.vargas@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The error log being reported by rte_bbdev_enqueue_status_str is
displayed even without an actual error. The function may be called for
such index (notably for queue dump) for valid reasons.

Fixes: 4f08028c5e24 ("bbdev: expose queue related warning and status")
Cc: stable@dpdk.org

Signed-off-by: Hernan Vargas <hernan.vargas@intel.com>
---
 lib/bbdev/rte_bbdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index ea644c1f9b..3961c9deb3 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -1236,7 +1236,6 @@ rte_bbdev_enqueue_status_str(enum rte_bbdev_enqueue_status status)
 	if ((uint8_t)status < sizeof(enq_sta_string) / sizeof(char *))
 		return enq_sta_string[status];
 
-	rte_bbdev_log(ERR, "Invalid enqueue status");
 	return NULL;
 }
 
-- 
2.34.1

