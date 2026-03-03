Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63684EDA694
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:22:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D378410DD;
	Tue,  3 Mar 2026 17:22:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 01A12402B0
 for <dev@dpdk.org>; Tue,  3 Mar 2026 17:22:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772554928; x=1804090928;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1orAowSbfR9cXfY1BNWAGAolEo70MvUywLQu/lRi9FQ=;
 b=W7dIh8rvAuUSqg8r0BEcib1UAazrOKaok/+/URyA75Clfl1Qp6y7ibBw
 /EwluXY+KD4OUcXIorRHorYnNaFtf17tVcLaS0ed1VAV2nWlZfermW9Ee
 ByYaPxVACEF5lY5vZv/zZutPTiI7o5LE3IYy2GG9oUfu1hjBaW0k+eOV5
 JColBvPb+PYDKhUochYrlZyw9XAouZxjrFh3kQ9ga2Pn6GNxx7hU/iY/M
 XKoin9PYMSfsskYRrB9QdPjbrIuGX6qOhwbRMJrZ6doEQ7F+X1EoQ86DZ
 09ltUCEnDkgBH0KtYCn0PpntjCAn3D1enY2fBxXBGnoGVtpNtjKIj8hVQ Q==;
X-CSE-ConnectionGUID: ZnuxSEOxRmOW9CHzXaKLaA==
X-CSE-MsgGUID: 4wD8WRWpTHGZ8xwDZhh/Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="76198954"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="76198954"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 08:22:04 -0800
X-CSE-ConnectionGUID: BqqmO0sFQ5+vUGtVbwASOQ==
X-CSE-MsgGUID: ZXcCVFlES+iN7rEtGkcoxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="223049305"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Mar 2026 08:22:03 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 1/2] net/ice: remove malloc call for admin queue msg
Date: Tue,  3 Mar 2026 16:21:56 +0000
Message-ID: <20260303162157.1634379-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303162157.1634379-1-bruce.richardson@intel.com>
References: <20260227110205.4099981-1-bruce.richardson@intel.com>
 <20260303162157.1634379-1-bruce.richardson@intel.com>
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

