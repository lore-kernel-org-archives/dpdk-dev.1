Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB0C021AA
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 12:46:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E2AD402CC;
	Fri, 21 Feb 2025 13:46:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6153C402BB
 for <dev@dpdk.org>; Fri, 21 Feb 2025 13:46:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740142003; x=1771678003;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=m/7v+AmHOaFbowrYLfUr1XJxboMNN5ckoJDqecrhB+0=;
 b=S56Knp74xuWCu1+EbfXgGmqA+lNOhip3wDZ27GIsyWRd6x5FBBNcopIK
 sUi/5IpHr0KFxVTWGN7CEoCtfhILnylvmNdzjFPNnI++M3lzwPyV0LHlO
 bpwK3sP7Zpcoee5RTCMQc00Lo13VhlTh0iWo+5AxmaTj6/XiJ2WMSZJYK
 ATppZ6Wi26HRw1zffD/MR7iLjCvTaMJ74zFJwnhdwG3cfb8/4EHeOLpJq
 SHALZW+OeGHWKyae9WZxoYmpq3nJFGBSf46yxQABNWbMAMq79ET4Io/Tj
 cKMbONdR38vxhvK8QbJlbU6oWDlvuJqxMIXE/fw2y4CuYr1RYciAnelso A==;
X-CSE-ConnectionGUID: mAZp23ERR5+qc4OeVgJKnQ==
X-CSE-MsgGUID: XTst1oDYTDafb9ZQqTJt4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40148901"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="40148901"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 04:46:42 -0800
X-CSE-ConnectionGUID: IXYt/NfhQG+3C91gb2ecMQ==
X-CSE-MsgGUID: YP8Qs3tlTVmuAHPYjkAXMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="115894194"
Received: from npg-sp-srv11.iind.intel.com (HELO npg-npf-wlpr-srv27..)
 ([10.190.212.78])
 by fmviesa010.fm.intel.com with ESMTP; 21 Feb 2025 04:46:41 -0800
From: Megha Ajmera <megha.ajmera@intel.com>
To: dev@dpdk.org
Cc: jasvinder.singh@intel.com,
	cristian.dumitrescu@intel.com
Subject: [PATCH] sched: fix wrr parameter data type
Date: Fri, 21 Feb 2025 18:17:55 +0530
Message-Id: <20250221124755.427459-1-megha.ajmera@intel.com>
X-Mailer: git-send-email 2.34.1
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

wrr tokens getting truncated to uint8_t in wrr_store function() due to
type mismatch. This patch chnages the data type to uint16_t.

Fixes: e16b06da0908 ("sched: remove WRR from strict priority TC queues")

Signed-off-by: Megha Ajmera <megha.ajmera@intel.com>
---
 lib/sched/rte_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index d8ee4e7e91..dcef44b91b 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -66,7 +66,7 @@ struct __rte_cache_aligned rte_sched_pipe {
 	uint64_t tc_credits[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
 
 	/* Weighted Round Robin (WRR) */
-	uint8_t wrr_tokens[RTE_SCHED_BE_QUEUES_PER_PIPE];
+	uint16_t wrr_tokens[RTE_SCHED_BE_QUEUES_PER_PIPE];
 
 	/* TC oversubscription */
 	uint64_t tc_ov_credits;
-- 
2.34.1

