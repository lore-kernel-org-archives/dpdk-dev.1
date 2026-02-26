Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2ADFD8FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 15:36:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 749ED4026F;
	Thu, 26 Feb 2026 16:36:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B05674021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 16:36:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772120214; x=1803656214;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Aq05Ey9UZqG9o2sBMBhzbFEEUdScZv7BVTUoJUQni1E=;
 b=EwuE2LscA9BjYsQ0qty7bEiv2pDk3H3wqclMDZJ8/DbFpdK7Fbb0FoLN
 vxK384Kwx4BhAJTE6CNE4bYvWB0VBUAmmMsUspjL60GoDWGE2N9mLme0f
 HPi/4B5YYTBkH7+8X8kTTJqrPR76DP0d38KJEdDIcQyDbo4Ty/F4wM+fb
 v5QTxNxSRR3fWBUt8QrMIfcXg9yTUyAjafdxpVzoI0bQZNcucjarT+b78
 H8JD/y647VlQuYVVLzHls/HzWg5kATNQCyGQbAe+gCAjoREG8bD1CP12e
 umAHh7+SJ9y6BqPNH4vRIaIwdZcPk21qF1/wa2hvXVVhSHwbxuYknKqu+ A==;
X-CSE-ConnectionGUID: LF/8PDOmSxudj+MLzGhsoQ==
X-CSE-MsgGUID: JAVfdEC4T8Chs/q8IiRSbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72886029"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="72886029"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 07:36:51 -0800
X-CSE-ConnectionGUID: ZrdenXI1TEK6GtqNHuVfAw==
X-CSE-MsgGUID: qIzSuvOiQf6sISZ0SPDWjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="216728370"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 26 Feb 2026 07:36:51 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] net/intel: fix wrap-around check in simple Tx scalar path
Date: Thu, 26 Feb 2026 15:36:35 +0000
Message-ID: <20260226153636.3925387-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

There was an error condition when the burst of packets being transmitted
ended exactly on the last descriptor of the ring. In that instance
alone, we ended up writing an invalid tx_tail value to the hardware, of
ring_size rather than of zero. Add an explicit check for this case to
the simple Tx path code.

Fixes: 9bacf6a81b92 ("net/intel: align scalar simple Tx path with vector logic")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 4475995180..9fcd2e4733 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -145,6 +145,8 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 		if (txq->tx_next_rs >= txq->nb_tx_desc)
 			txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 	}
+	if (tx_id == txq->nb_tx_desc)
+		tx_id = 0;
 
 	txq->tx_tail = tx_id;
 
-- 
2.51.0

