Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1C1C5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9784440B8F;
	Fri, 20 Feb 2026 11:15:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5122940609
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:15:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582505; x=1803118505;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=du3qwQx3RAjh/F654aIPhXR47vETZmsxPeYwcf+S82I=;
 b=k7OkY2Shmbbslci038afewsAK0m5qjqNtLQKg8rUEh1SWZosgXElicCs
 2PDPAhOpjgxeT1WcGNyYA6njGIjhnuRmh1YYyPjaMmYWU/vd8xEV5qYDB
 qeZbo+soxVfh8nd0k++hcCLn8Z3nb52Yb/G2XaJ5UtY/wUdh5i/SQeBMU
 VfXtTuI4Q7Vc6Q9Wdb7Ifpilp2Y0ecVbAKneYiJcLstOu8pIOwbaAmpcd
 atn7pVEulPNPEW02pIMSsO4Tx5TN3Fc17oJMZHx7cKAfpaV28TsMkXLqT
 islb0j1SbUTbR2B4wJ4A9IKxkuS0MMQnuhHrjk+BWGz1Ja3w3kVhDaMnB w==;
X-CSE-ConnectionGUID: VVLiWl3ERrOqx5+8SoixBw==
X-CSE-MsgGUID: 9ztDdlolSUyc9MY7czA2ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283355"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283355"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:15:05 -0800
X-CSE-ConnectionGUID: u5D3mTmCRxu25fJmRN2uzw==
X-CSE-MsgGUID: FXO2TdgETOS2ygpQvA4B9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038517"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:15:04 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 13/27] net/i40e: avoid rte malloc in adminq operations
Date: Fri, 20 Feb 2026 10:14:20 +0000
Message-ID: <854f2a1fd12dd64f3ede905a06a6ed4fe128754c.1771582363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771582362.git.anatoly.burakov@intel.com>
 <cover.1771582362.git.anatoly.burakov@intel.com>
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
index 672d337d99..cd648285d1 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -6870,14 +6870,11 @@ i40e_dev_handle_aq_msg(struct rte_eth_dev *dev)
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
@@ -6913,7 +6910,6 @@ i40e_dev_handle_aq_msg(struct rte_eth_dev *dev)
 			break;
 		}
 	}
-	rte_free(info.msg_buf);
 }
 
 static void
-- 
2.47.3

