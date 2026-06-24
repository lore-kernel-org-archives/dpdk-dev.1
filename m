Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB61CDE002
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:37:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B5034067C;
	Wed, 24 Jun 2026 12:37:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6AB584066D;
 Wed, 24 Jun 2026 12:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297432; x=1813833432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bGk4GoiR+C1V2jaBq8XCP1O3DrOWUB4rmDgQse8Pi9o=;
 b=iNpqzZL2AC9xXNCZyd45qLhrceSZhYPmsNinv3yfczqKTcsNLlQkgb3g
 lYv2rvmP/HZyOapuL6b4+R0p/F+LT28uovCAyLAZEB/KDXHZT4p01z1uJ
 om2YxQV6D8iW4I8Djb5Gi5MJYNLWg86WFUNmyFzPvaXBSSbmEQDssU+SS
 EGTk50ULVbGMDm/IROlB6SABSYrxxijO1RwUtkQe4fZ7KRI2oW1YkLHSB
 TLm/KZ68UXAbdcGD8Z/VRC8sH7HiP1LFtJVDSMoIaRibd3DCTVcUdVA4i
 Ik84KD//Yg4ANeaj/VM6/brKUABZGUkMECVXOebCzb5HAB1uxQ065HAjj Q==;
X-CSE-ConnectionGUID: tzt+PKLsSDaVX6FaPpc1mQ==
X-CSE-MsgGUID: dqrJD2hTTxmbHOC5Dws4UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652343"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652343"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:11 -0700
X-CSE-ConnectionGUID: Dt2rjRcJQHSdm7F9aaUtCA==
X-CSE-MsgGUID: FZ9qFv45TOW1mFcwHwyVXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460015"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Kai Ji <kai.ji@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v2 04/17] crypto/scheduler: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:43 +0100
Message-ID: <20260624103658.792750-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
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

Fixes: 50e14527b9d1 ("crypto/scheduler: improve parameters parsing")
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

