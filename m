Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D366CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:52:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12E4C4067A;
	Tue, 23 Jun 2026 18:52:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E308B4066D;
 Tue, 23 Jun 2026 18:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233524; x=1813769524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/6+/5I2/H/2aW2Iyd/+JSp7sF2erogCs9LCs/joUHDI=;
 b=ifToA+P1X99zehPaj26n7HicPup+DCeGeAVatVlRvPOaByx+Ufnu92Zm
 pCkTS6XFyROrNyPCOUs1Iumfpq5RXPuAQz4vwgyQyiU9RdFlK4WWbdd79
 03Jjeguz46ryZTTDl+QZhcAnYFLkZ18AOyX2lo/FcXpiqyuW7oQ3pyOQ0
 g65EUZI8bO2IF7IIesRk8ZyqSZ69jYSxOoKPW8cXLInM4FtF1KeByAdIq
 SA/76X7qPKmNyn4ewGJ3n9yDmIraRVBykUGKw7K4b+RdNGrB7hE7olsuh
 ZaoUBu2L6juN9d4uIg5yiI1DJDsPifPyAAXP+3LSYY1F1jy9g/qjpmTvR w==;
X-CSE-ConnectionGUID: AvORqTPYSTy6BWN8UkcsAQ==
X-CSE-MsgGUID: FAt8sc5NSNGfj15MzOFnjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534632"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534632"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:04 -0700
X-CSE-ConnectionGUID: 8yyB8Z+9RIGI9hyUuvwYrw==
X-CSE-MsgGUID: nUXjRzQBQ+uR58ZM94cEPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928300"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:01 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Kai Ji <kai.ji@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Adam Dybkowski <adamx.dybkowski@intel.com>,
 Ruifeng Wang <ruifeng.wang@arm.com>
Subject: [PATCH 04/17] crypto/scheduler: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:34 +0100
Message-ID: <20260623165150.765443-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: 85b00824aeef ("crypto/scheduler: rename slave to worker")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/scheduler/scheduler_pmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/scheduler/scheduler_pmd.c b/drivers/crypto/scheduler/scheduler_pmd.c
index 95ce893f05..ceaefa329b 100644
--- a/drivers/crypto/scheduler/scheduler_pmd.c
+++ b/drivers/crypto/scheduler/scheduler_pmd.c
@@ -229,10 +229,10 @@ cryptodev_scheduler_create(const char *name,
 			return -ENOMEM;
 		}
 
-		strncpy(sched_ctx->init_worker_names[
+		strlcpy(sched_ctx->init_worker_names[
 					sched_ctx->nb_init_workers],
 				init_params->worker_names[i],
-				RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN - 1);
+				RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN);
 
 		sched_ctx->nb_init_workers++;
 	}
@@ -443,8 +443,8 @@ parse_worker_arg(const char *key __rte_unused,
 		return -ENOMEM;
 	}
 
-	strncpy(param->worker_names[param->nb_workers++], value,
-			RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN - 1);
+	strlcpy(param->worker_names[param->nb_workers++], value,
+			RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN);
 
 	return 0;
 }
-- 
2.53.0

