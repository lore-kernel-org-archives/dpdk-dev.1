Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478ABE9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:55:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1436040A6F;
	Wed, 11 Feb 2026 14:53:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8E14E40B8F
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818028; x=1802354028;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JDJwC/dT3zHOUSL4CWaGVZjFR/cQjAUxaQFLx7/JDvg=;
 b=fMxgqEw+P3ITA5tK4yurljVh3exqsFVtvpgRM274x2PpxRhgUn6u16h7
 SE+RPV10dgtBsTnodQkiKjjxzLBIeVqATak0GeW4y1bLMiQTK3ZXzJaHO
 bdle8DFa8o6qXu5R97+STQxUEtgYM0+WP22JIs6OwL6LNnX+whdL+D+Fo
 ZA6Fy2gBkMf7sEzHfUhAIeEd+I+vgNJffA11/RO2blLS7IebDhJEo6Fow
 bKYBM4TP9zi0/8TBtXvZppXiDPMDDdXBPA6HjlViearr0m5HOAFd07x0j
 /nyicdDVI1ehUIJFlWfkIuPGpjAzlqp0n4maab3hxnfMz6zcLTMcIrJPQ g==;
X-CSE-ConnectionGUID: 6F8YZeCQQBKNKFDJAnwTyg==
X-CSE-MsgGUID: NkUBhb/BRLuBMD+ypiA4Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808255"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808255"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:48 -0800
X-CSE-ConnectionGUID: 0HQx1YKVRuCTPJWatdTzKQ==
X-CSE-MsgGUID: sPzdYR+UQNWH2RxEg41cqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359597"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:47 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 13/27] net/i40e: avoid rte malloc in adminq operations
Date: Wed, 11 Feb 2026 13:52:55 +0000
Message-ID: <a2d5f396ca602dc6d510542b8014306529fc87bb.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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

