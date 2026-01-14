Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF31D37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:46:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E82A40DDA;
	Wed, 14 Jan 2026 16:45:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8992E40DD5;
 Wed, 14 Jan 2026 16:45:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405518; x=1799941518;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oNag9pMdNuyeC4i8hoNVngDA+1Hf5dEQtTbpPm3P7oQ=;
 b=Zzumr/p9+tRNILs+50wIiqIv73GBQtDMSz4ia/6YSPXmuAWrKPizNBhy
 WkPQPEhlL6WrcD4lna9IhnZar8I96DCivT9BZFfmYHQ1XOB9fKn/HrA8+
 KLgeP/iXDUUAnymq/dUYm+cUOJbLSC4I2XCC9unZisaZd2gVkPOIYR8B7
 FPprO1MNDTzOC7o3b0IVECI7mgOlmBavez9WL9eBCJUAbsSeVP2XTX/6P
 iFDYg+IAPlywiKjGTa2aVDuSOm1T0R1fKg4kvUr2gx5q/SE0bdFN2hNhi
 Xxo9unZF5v6wSKeYvOhRYJ8Ut82vMN39wkoxjCbzZ4tfhgHqqS+BEfo4Q Q==;
X-CSE-ConnectionGUID: TeDDxcMYRZWyMC+XctZxyQ==
X-CSE-MsgGUID: x4/oebgPT0OcWsAhdbmb7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870837"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870837"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:18 -0800
X-CSE-ConnectionGUID: qm6j88TTTWmNvcIwGmf2Fg==
X-CSE-MsgGUID: kPG1JxcYR8O9zPfVsQVAiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203924992"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:15 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Amr Mokhtar <amr.mokhtar@intel.com>
Subject: [PATCH v4 10/31] bbdev: fix variable shadowing
Date: Wed, 14 Jan 2026 15:44:24 +0000
Message-ID: <20260114154450.2969716-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

The "ret" variable is declared twice in rte_bbdev_setup_queues function.
The second declaration is unneeded so remove it.

Fixes: 4935e1e9f76e ("bbdev: introduce wireless base band device lib")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bbdev/rte_bbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index 6c98296bdb..ea644c1f9b 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -357,7 +357,7 @@ rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
 	if (dev->data->queues != NULL) {
 		VALID_FUNC_OR_RET_ERR(dev->dev_ops->queue_release, dev_id);
 		for (i = 0; i < dev->data->num_queues; i++) {
-			int ret = dev->dev_ops->queue_release(dev, i);
+			ret = dev->dev_ops->queue_release(dev, i);
 			if (ret < 0) {
 				rte_bbdev_log(ERR,
 						"Device %u queue %u release failed",
-- 
2.51.0

