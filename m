Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41571E6817A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:16:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8AC640A80;
	Tue, 17 Feb 2026 13:15:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id AB8B140659
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:14:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330494; x=1802866494;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ZT1ZhnYJjQ9UjjBT1a6y6WEXFiFzq5PHytP0raXMPf4=;
 b=mkxgMp+P961cRbiEiHfG/pnistdziquUGC1joaZ+dBDqAd+we2j91b+O
 uQj1dzgv1c4smvA9yRbbr3s5aoLjaYkrKPDmBanepuFTpJzCel7LK3MZm
 6yp5IDFeISs0kq2EXJyNq4nGxm0F+PPq3EFCbtqlZY1htM8uaH8AHqjuw
 TfGTN/dsyzhhqU4Ufi9Btj3+KtH4iT416MfX8yd7SOY+HoGX+og0vqD2o
 be/mUFCG89s46QWdgBPD0u3y4J+xfhgO2Kc4RLeNTAWfhZehSSSng6wMX
 oo9kPqmy1pxVeWFa34guf0sbl6KjnYGU9BPOg8A8r+M55lxGC0/x3D22X A==;
X-CSE-ConnectionGUID: SzFOBFvNSLqWGLcKwqQmgA==
X-CSE-MsgGUID: 9JkaC9DFTFu1S2Q1qkJ+XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996036"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996036"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:14:53 -0800
X-CSE-ConnectionGUID: oBVLhTrMR2SelMfKancoRw==
X-CSE-MsgGUID: g/NZr8iHT96ZYWqXv07aKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396806"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:14:53 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 13/27] net/i40e: avoid rte malloc in adminq operations
Date: Tue, 17 Feb 2026 12:14:02 +0000
Message-ID: <ef10c810a3abce64136bec86a760b45d82322f1a.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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
index 1160acc551..ac465c90a4 100644
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

