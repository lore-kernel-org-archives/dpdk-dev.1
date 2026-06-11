Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BBCD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 08:35:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 324C142F1D;
	Thu, 11 Jun 2026 10:35:45 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 60B2442F13
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:35:43 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B8ZfvsE1787252,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1781166941;
 bh=WrcbpkUtTMFe4yMMOBY+icHoHyQBEeyBwwxpVqhlBDk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=JqSwmpxlV2evNZGDfE8wdF7mVmUAgANmhD5RRgFJ50bHr1RVmEzTkT/2zAS1fTjt5
 yw+YjzlY4GFydb1jG4YjIEEF/hSRS37qHBaW7ujRuvTEegQser7eEdfn0zdAglXF0Q
 lkn0AWFh0a8WgpclLS9QZlh8TV9mqlttUomwBif7CJuq9ZyFRvTNywfZ4B7x6HEwux
 ZKyPJ38t1fsQw6m/gEsVRFpl6+qTp2ocfoVdzf+cefL7z86zk4Eznto8j0BmqxpkkF
 kOOJX+VYEm/9Sgt4lqVmwCP+EzIas1FtWR0D/6gnk7uro1tv2rwK/hZHaaZj354KcQ
 EVLNZubwkoTiA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
 by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B8ZfvsE1787252
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:35:41 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 16:35:41 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 16:35:41 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 2/6] net/r8169: optimize Tx datapath by removing redundant
 packet checks
Date: Thu, 11 Jun 2026 16:28:29 +0800
Message-ID: <20260611083521.20669-3-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611083521.20669-1-howard_wang@realsil.com.cn>
References: <20260611083521.20669-1-howard_wang@realsil.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Malformed packets (e.g., pkt_len == 0 or nb_segs == 0) should never
be passed down to the PMD by the upper layers. The current handling
of such abnormal packets in the Tx datapath not only introduces
unnecessary branch overhead but can also lead to unexpected behaviors.

To adhere to DPDK's high-performance design principles, we should not
penalize the datapath to cover up upper-layer errors. Therefore, this
patch removes the runtime 'if' conditions for these anomalies. Instead,
RTE_ASSERT is introduced to help catch such issues during debugging.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_rxtx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index a2e9139ec6..e0154b7741 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -1621,8 +1621,7 @@ rtl_xmit_pkt(struct rtl_hw *hw, struct rtl_tx_queue *txq,
 
 		len = m_seg->data_len;
 
-		if (len == 0)
-			break;
+		RTE_ASSERT(len > 0);
 
 		txd = &txq->hw_ring[tail];
 
@@ -1971,10 +1970,7 @@ rtl_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		if (txq->tx_free < tx_pkt->nb_segs)
 			break;
 
-		/* Check mbuf is valid */
-		if (tx_pkt->nb_segs == 0 || tx_pkt->pkt_len == 0 ||
-		    (tx_pkt->nb_segs > 1 && tx_pkt->next == NULL))
-			break;
+		RTE_ASSERT(tx_pkt->pkt_len > 0);
 
 		rtl_xmit_pkt(hw, txq, tx_pkt);
 	}
-- 
2.43.0

