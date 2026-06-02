Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09079CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F70D40656;
	Tue,  2 Jun 2026 17:45:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2EF4F402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 17:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780415119; x=1811951119;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ledrXiytj5MIUaOZjOpM7YYCBEPFJFlZROXbEr3JY8w=;
 b=I5rgKcO87ABHT0FzWYgsvh3qEasEJnitlm3x+m1Yt0zlmrlyMsL82b2R
 J5+fgHMrs/ivis0Qs2L0UkoMQIhLEOfJ+KptMI0mJI7oaL5oR86JmyiLj
 b3Wk6EHTXLNiFiGc7GLwUt6/E9wlCNYjnC+wZIQBksIyS0+01vKvmbYjR
 YY3Yt8Ej/jbntvoCYLbCkCS84dl4gGbnhEB7T4mCwPUb2DHf1BAuM1lf5
 bogdLrUgG8ATHygMltYF8HhXWdekdyt6ps4qUW3ErWXAAWPTjIszDF/jZ
 Ye53sEmUJp4rspbO81sozFdj7NM0XZm1fPIenBZqosHl/a3nicc4CoIPG A==;
X-CSE-ConnectionGUID: xE81SJCLS7qn3NIoTSEJ7g==
X-CSE-MsgGUID: UrVYkIm9Teau3VP7/Xnqbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81385607"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="81385607"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 08:45:18 -0700
X-CSE-ConnectionGUID: Lo2qpRRnTgS8o7sppoxKEg==
X-CSE-MsgGUID: kjL+M/RfRc2n+bm+JJb9rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="237593628"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 02 Jun 2026 08:45:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, ciara.loftus@intel.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 1/2] net/intel: write mbuf for last Tx desc of segment
Date: Tue,  2 Jun 2026 16:45:11 +0100
Message-ID: <20260602154513.1079865-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602154513.1079865-1-bruce.richardson@intel.com>
References: <20260123112032.2174361-1-bruce.richardson@intel.com>
 <20260602154513.1079865-1-bruce.richardson@intel.com>
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

When a single mbuf segment has more data than can be handled by a single
Tx data descriptor in the TSO case, adjust how the storing of mbufs is
being done. Rather than putting the mbuf pointer in the first slot for
that segment, store it in the last slot instead. This guarantees for us
that the descriptor for which we have desc-done (DD) writeback always
has a valid mbuf associated with it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 9fcd2e4733..7809bd53e8 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -509,7 +509,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
 			if (txe->mbuf)
 				rte_pktmbuf_free_seg(txe->mbuf);
-			txe->mbuf = m_seg;
 
 			/* Setup TX Descriptor */
 			/* Calculate segment length, using IPsec callback if provided */
@@ -528,6 +527,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 					((uint64_t)CI_MAX_DATA_PER_TXD << CI_TXD_QW1_TX_BUF_SZ_S) |
 					((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S);
 				write_txd(txd, buf_dma_addr, cmd_type_offset_bsz);
+				txe->mbuf = NULL;
 
 				buf_dma_addr += CI_MAX_DATA_PER_TXD;
 				slen -= CI_MAX_DATA_PER_TXD;
@@ -548,6 +548,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				((uint64_t)slen << CI_TXD_QW1_TX_BUF_SZ_S) |
 				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S);
 			write_txd(txd, buf_dma_addr, cmd_type_offset_bsz);
+			txe->mbuf = m_seg;
 
 			tx_id = txe->next_id;
 			txe = txn;
-- 
2.53.0

