Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1A3F3C995
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:16:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49E74406B7;
	Tue, 24 Feb 2026 16:15:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B8B6540612
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:14:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946093; x=1803482093;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=du3qwQx3RAjh/F654aIPhXR47vETZmsxPeYwcf+S82I=;
 b=eDe1duskXJRyn9ib2svsI1sB2znMCLsWGSVKBPsigkah8kBrNpkBuW5d
 jm6PypIrTvfsc6yI4YSWvdujuoDim4KUUIaFhaCJ/BBehHrEC/VOfhbxH
 2ONZHTxnHCEXP5etQQ9P/JXY+g9mGx5VEq1rKyLC8C7Vc9jFW4FCN1CK8
 3ygeOskZPZiLe4v5yR2Z40QH1vYkaE1uQbziKfcqHXpkZoJHHdHkAApZH
 45k6fNojfAZi2+sjglwtxekjtO7mKNJ6p5S/esBllwwfma9HjfjOxJ9EK
 rAQhzLp8htLY7bLFOrXQSc/get9GbahyfJ2WLgAzpRL6SE1sEPVbjh2p5 g==;
X-CSE-ConnectionGUID: RO9jy6+WTQKBVrMHu0e5tA==
X-CSE-MsgGUID: BgVilRn6SE+jfXBTCKEkuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056259"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056259"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:14:52 -0800
X-CSE-ConnectionGUID: HP7Qx+JHTlyajIETAWWUhg==
X-CSE-MsgGUID: OhDiqfY8SQWHEbE9iQvJew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526159"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:14:52 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 13/26] net/i40e: avoid rte malloc in adminq operations
Date: Tue, 24 Feb 2026 15:14:18 +0000
Message-ID: <fa23f104dec6e0830e9e4cf8c8bf85817cf19263.1771945933.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771945933.git.anatoly.burakov@intel.com>
 <cover.1771945933.git.anatoly.burakov@intel.com>
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

