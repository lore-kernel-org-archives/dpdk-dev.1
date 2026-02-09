Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CEDE78D46
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 08:56:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E36EC40652;
	Mon,  9 Feb 2026 09:55:49 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 1FC4C40652
 for <dev@dpdk.org>; Mon,  9 Feb 2026 09:55:47 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6198tjJdB1144236,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770627346;
 bh=lL4IIEmpQOBzk+B1c/+Y89zX7d6g1Dsn9D5h45t2gto=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=sa/I6vO61gs2YaQuy37HvtfMWZcLbc6stt4uL9jvcIfKp+xQiVrB5WKBXPV/ghTW3
 AwocQtywWqMc0XMSwpo8PYq7U82Mz5HfrC1IFreNznaVASU6+vlsid1Oe85YhzV3i1
 zaM8ygM71gfgT1SIEPLmfaroOz/eYFV1CNrGEWv08G/LacFf2WkRHuyiQhynyMLgtn
 Y2sYq01bObLnaQnjCdiVt8J8b9/329dEwxZ9oN3s/GxNZLLB10voJoyo1iVt8ocsrl
 CswOJ1/J7EWFoNlBCcArRO0VA6zoTS1myTJEDjPX8jzxz4Wh4kfd5H+P/CwU5tRnSB
 1eHGeJZ2dcsog==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6198tjJdB1144236
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Mon, 9 Feb 2026 16:55:46 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 9 Feb 2026 16:55:45 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 9 Feb 2026 16:55:45 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 05/12] net/r8169: adjust jumbo frame size limit for non-1G
 cards
Date: Mon, 9 Feb 2026 16:54:55 +0800
Message-ID: <20260209085502.26722-6-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209085502.26722-1-howard_wang@realsil.com.cn>
References: <20260209085502.26722-1-howard_wang@realsil.com.cn>
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

For 8125A, set the max size to (16K - 1).
For other non-1G cards, set the max size to 16K.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_compat.h |  1 +
 drivers/net/r8169/r8169_ethdev.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index d2d928cdd7..673a1ca274 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -617,6 +617,7 @@ enum RTL_chipset_name {
  */
 #define RTL_ETH_OVERHEAD (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + VLAN_TAG_SIZE)
 #define JUMBO_FRAME_9K  (9 * 1024 - RTE_ETHER_HDR_LEN - RTE_VLAN_HLEN - RTE_ETHER_CRC_LEN)
+#define JUMBO_FRAME_16K  (16 * 1024 - RTE_ETHER_HDR_LEN - RTE_VLAN_HLEN - RTE_ETHER_CRC_LEN)
 
 #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL << (n)) - 1))
 
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index f620154bf0..8e46ce09a1 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -412,9 +412,30 @@ rtl_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	struct rtl_hw *hw = &adapter->hw;
 
 	dev_info->min_rx_bufsize = 1024;
-	dev_info->max_rx_pktlen = JUMBO_FRAME_9K;
 	dev_info->max_mac_addrs = 1;
 
+	switch (hw->mcfg) {
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+		dev_info->max_rx_pktlen = JUMBO_FRAME_16K - 1;
+		break;
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_58:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+	case CFG_METHOD_91:
+		dev_info->max_rx_pktlen = JUMBO_FRAME_16K;
+		break;
+	default:
+		dev_info->max_rx_pktlen = JUMBO_FRAME_9K;
+		break;
+	}
+
 	if (hw->mcfg >= CFG_METHOD_69) {
 		dev_info->max_rx_queues = 4;
 		dev_info->max_tx_queues = 2;
-- 
2.34.1

