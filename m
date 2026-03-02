Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E75E9B36B
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:48:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1AB340E19;
	Mon,  2 Mar 2026 12:48:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id F2F7A400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772452129; x=1803988129;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q6FtvK+cuwjbhcoLOuBy1hDobN7SsqmXFkFrEv4I38s=;
 b=dPxGEXox7FLexfavS8wuWLtwHNEMtc6721CTgaebhDrs82zTPdnD4ocw
 hv6aofZX1YBf9PWaIk9Q0GuCEhsokzSpuMAaMHhuZWrF2VR+40ZoLpbKJ
 CuTxeYkgOlxpGFaw7rLM8fPcxZhn9yjmKiTO+5Zb1K0XydWZJcUH0sD8b
 h0Mwsfnw1xCf6bX4yaofNATeY9snxMlqRHSqwHtjPoIoZnqB6i/x4ppVz
 Afc84N6hBpitDwFcX25bjJUBbCLurGh/texZY6gLn1MChzVxZ/CHihSiL
 dFtaQf6cBD/xA6uIKwAJlSJW8Nbh1TwTKcHSTRijqWqkZHC67MC+mYaaw g==;
X-CSE-ConnectionGUID: fbxukmiTSf+qkm82GGdZJA==
X-CSE-MsgGUID: Y3J/Kh4FR++kYvnvNTK+tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="77294769"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="77294769"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 03:48:49 -0800
X-CSE-ConnectionGUID: 3/6ant3uRI6TQ/hhfpXtVA==
X-CSE-MsgGUID: lnshRm+YQ4id0pz7GWSipA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="222266605"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa005.fm.intel.com with ESMTP; 02 Mar 2026 03:48:48 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 1/2] net/ice: remove malloc call for admin queue msg
Date: Mon,  2 Mar 2026 11:48:41 +0000
Message-ID: <20260302114842.946182-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302114842.946182-1-bruce.richardson@intel.com>
References: <20260227110205.4099981-1-bruce.richardson@intel.com>
 <20260302114842.946182-1-bruce.richardson@intel.com>
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

The max message size is defined as 4k, so we don't need a special
malloc/free (and especially not rte_malloc/rte_free) for each call into
the function - especially if no data is present. Replace the malloc
calls with a local memory buffer instead.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 0d6b030536..a59ca2e047 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -1440,17 +1440,14 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
 {
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_ctl_q_info *cq = &hw->adminq;
-	struct ice_rq_event_info event;
+	unsigned char buf[ICE_AQ_MAX_BUF_LEN] = {0};
+	struct ice_rq_event_info event = {
+		.msg_buf = buf,
+		.buf_len = sizeof(buf),
+	};
 	uint16_t pending, opcode;
 	int ret;
 
-	event.buf_len = ICE_AQ_MAX_BUF_LEN;
-	event.msg_buf = rte_zmalloc(NULL, event.buf_len, 0);
-	if (!event.msg_buf) {
-		PMD_DRV_LOG(ERR, "Failed to allocate mem");
-		return;
-	}
-
 	pending = 1;
 	while (pending) {
 		ret = ice_clean_rq_elem(hw, cq, &event, &pending);
@@ -1477,7 +1474,6 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
 			break;
 		}
 	}
-	rte_free(event.msg_buf);
 }
 #endif
 
-- 
2.51.0

