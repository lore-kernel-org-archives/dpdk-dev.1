Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFEFEA3F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:15:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 031C640DF5;
	Tue, 10 Feb 2026 17:14:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 03FB640BA6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740060; x=1802276060;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JDJwC/dT3zHOUSL4CWaGVZjFR/cQjAUxaQFLx7/JDvg=;
 b=YHv23r8mj1YFZskqZtFmJpP2RmOW4h7yxURAu5jHUhVTOnAW9nj2E35B
 9XNOu8l2xY7CWlkm59EmK9s/I15FQDx1uMGUcrGdr55+J7x/EKJ0vkQbs
 yJz94+RRfQEdqMI84dvnf2WmMSY3yKis8JxxHhXjS9zjizrSxrVuap7S2
 unbCyEHf9Vb6UC15/J+BtCa03p5eg4eTKOMyNd0uRhEPLWu5czrenYECL
 v/Qqc5vo3m84tAI/xchqkkA+wiLIjbJgslmzrpJmoGU1TVTLmffzaXig7
 wZOGH7UW7jpRiXybXTwjVs27vPlVh0IBWy9m/h/ydkdOMSDGQ/TdiPKbK A==;
X-CSE-ConnectionGUID: 5E4HwqOsSD+piE2NZdbhRQ==
X-CSE-MsgGUID: QF+OyLPETjmAFWX9tazvTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286219"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286219"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:19 -0800
X-CSE-ConnectionGUID: 8DHBmMGsQGysz4LlqygmLQ==
X-CSE-MsgGUID: lIBrU/Y+QcitArkpViLWWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127763"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:18 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 13/26] net/i40e: avoid rte malloc in adminq operations
Date: Tue, 10 Feb 2026 16:13:42 +0000
Message-ID: <f91686667986104a6d6330d511de2022378ffa67.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
References: 
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

Currently, when processing admin queue messages, we are using rte_zmalloc
followed by an immediate rte_free. This is not needed as the message
buffer is only used temporarily within the function scope, so replace it
with regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 806c29368c..2e0c2e2482 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -6896,7 +6896,7 @@ i40e_dev_handle_aq_msg(struct rte_eth_dev *dev)
 	int ret;
 
 	info.buf_len = I40E_AQ_BUF_SZ;
-	info.msg_buf = rte_zmalloc("msg_buffer", info.buf_len, 0);
+	info.msg_buf = calloc(1, info.buf_len);
 	if (!info.msg_buf) {
 		PMD_DRV_LOG(ERR, "Failed to allocate mem");
 		return;
@@ -6936,7 +6936,7 @@ i40e_dev_handle_aq_msg(struct rte_eth_dev *dev)
 			break;
 		}
 	}
-	rte_free(info.msg_buf);
+	free(info.msg_buf);
 }
 
 static void
-- 
2.47.3

