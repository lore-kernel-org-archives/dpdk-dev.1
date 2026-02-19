Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA536E9A04D
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:24:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC3BF406B7;
	Thu, 19 Feb 2026 17:23:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 481D24064E
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518214; x=1803054214;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=be7PvKESX4M8yNeIjLB/TXcf3X0elW6QYZZokzolfHM=;
 b=GVcLMgks46QWUYUjWOcOkIvnedozdgEYqJrbt7I6IkLAC9PEb9zVsccS
 RHuSr14jdheR8dOSqk+dgkklpmoWNBvY0N7u1pwaIFKGP3qI5TKcP9bm9
 Bx5JOyyQuKsS9HXf3LCmggtkkL0Ai/XeW8EmqQ17bOzTBzJOBMRi9C++z
 dy0spKOGXZo5Nd4PuGUOYf7z9js4+Ml/Tng6j+tRx/YsUbPX3ftA00QcJ
 CmqFdo3d/Q/EJrq+omV7d2XXVgNQMah38fO17gmDgPZVqJQDdQwiz2G4B
 sYXAIQU3myx6X3HvnE5Kl+RuHFJSiCZciFhS503SkSGfkBxphBY5Jd/zn w==;
X-CSE-ConnectionGUID: Y2ZkID4jTbS3faNY9BIyog==
X-CSE-MsgGUID: jvWoTNC+Qnu494keM1JwLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231443"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231443"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:32 -0800
X-CSE-ConnectionGUID: CwbIb9EkRuesf3q0hThnKQ==
X-CSE-MsgGUID: WNCZl23XS1eTLo19p0I+lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699884"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:31 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 13/27] net/i40e: avoid rte malloc in adminq operations
Date: Thu, 19 Feb 2026 16:22:56 +0000
Message-ID: <9bd5ba673586f972b4bd5f0af90b383ea45f7f54.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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
followed by an immediate rte_free. This memory does not need to be stored
in hugepage memory, so replace it with stack allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 72ff2ea59c..fff832fba1 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -6872,14 +6872,11 @@ i40e_dev_handle_aq_msg(struct rte_eth_dev *dev)
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct i40e_arq_event_info info;
 	uint16_t pending, opcode;
+	uint8_t msg_buf[I40E_AQ_BUF_SZ] = {0};
 	int ret;
 
-	info.buf_len = I40E_AQ_BUF_SZ;
-	info.msg_buf = rte_zmalloc("msg_buffer", info.buf_len, 0);
-	if (!info.msg_buf) {
-		PMD_DRV_LOG(ERR, "Failed to allocate mem");
-		return;
-	}
+	info.buf_len = sizeof(msg_buf);
+	info.msg_buf = msg_buf;
 
 	pending = 1;
 	while (pending) {
@@ -6915,7 +6912,6 @@ i40e_dev_handle_aq_msg(struct rte_eth_dev *dev)
 			break;
 		}
 	}
-	rte_free(info.msg_buf);
 }
 
 static void
-- 
2.47.3

