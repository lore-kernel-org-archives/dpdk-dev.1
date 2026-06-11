Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59746CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 08:36:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03BB742F55;
	Thu, 11 Jun 2026 10:35:56 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id AAFEE42F11;
 Thu, 11 Jun 2026 10:35:54 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B8ZqPjA1787359,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1781166953;
 bh=gM9l3syIeTT+l40SHGfTkeOqPt6WirPWvHarZMwx5Bs=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=HXo15cSIx+WnpFJExlyRGPhctqP4OMGP0qRq8nxKpo6re8VYu5MNuqM11P3/ECk1F
 vPgmq/e/6IVBxd0gIOpJ4rd8nxxzVo0SVsqmlZuJ9QJTYF0YjkK+cA+DAblqf3zbir
 MYc+wCZr0KXo5zE5erJxUoMufQQU6c8K24Mv/25N0X8esJ4wV9NUF9ae07WEmEl2OP
 V+Abw25GiWijcMSjnQ4z0y9XJ0XTfyNnb8eBlofXGm36y6TYT3ezvlZ2N0e/Bmrowi
 CDEiurhPYv9K6oy5LfPLsA9QgoV02lqJKihUs+6BRjUFRrbc1r8VHcBzWlsaJdTsOP
 Rgj12NTcU1UiA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
 by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B8ZqPjA1787359
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Jun 2026 16:35:52 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 16:35:52 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 16:35:52 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>,
 <stable@dpdk.org>
Subject: [PATCH v1 6/6] net/r8169: fix segmentation fault during RTL8168
 initialization
Date: Thu, 11 Jun 2026 16:28:33 +0800
Message-ID: <20260611083521.20669-7-howard_wang@realsil.com.cn>
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

In rtl_rx_init(), the configuration of RSS control and RX queue number
(which are specific to RTL8125) was incorrectly executed for all MAC
versions. Accessing RTL8125-specific registers (e.g., RSS_CTRL_8125)
on RTL8168 hardware causes a segmentation fault.

This patch fixes the issue by moving the RTL8125-specific RSS and VMQ
configurations into the existing `if (rtl_is_8125(hw))` block, ensuring
they are only executed on the correct hardware.

Fixes: 25e19d532b4b ("net/r8169: support multi-queues for 8126 and 8127")
Cc: stable@dpdk.org

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_rxtx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index e0154b7741..00de0471f4 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -672,7 +672,18 @@ rtl_rx_init(struct rte_eth_dev *dev)
 
 	rtl_enable_cfg9346_write(hw);
 
-	if (!rtl_is_8125(hw)) {
+	if (rtl_is_8125(hw)) {
+		/* RSS_control_0 */
+		if (hw->EnableRss) {
+			rtl_init_rss(hw, nb_rx_queues);
+			rtl8125_config_rss(hw, nb_rx_queues);
+		} else {
+			RTL_W32(hw, RSS_CTRL_8125, 0x00);
+		}
+
+		/* VMQ_control */
+		rtl8125_set_rx_q_num(hw, nb_rx_queues);
+	} else {
 		/* RX ftr mcu enable */
 		csi_tmp = rtl_eri_read(hw, 0xDC, 1, ERIAR_ExGMAC);
 		csi_tmp &= ~BIT_0;
@@ -700,17 +711,6 @@ rtl_rx_init(struct rte_eth_dev *dev)
 	else
 		rtl_clear_rdu = rtl8168_clear_rdu;
 
-	/* RSS_control_0 */
-	if (hw->EnableRss) {
-		rtl_init_rss(hw, nb_rx_queues);
-		rtl8125_config_rss(hw, nb_rx_queues);
-	} else {
-		RTL_W32(hw, RSS_CTRL_8125, 0x00);
-	}
-
-	/* VMQ_control */
-	rtl8125_set_rx_q_num(hw, nb_rx_queues);
-
 	RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) | CmdRxEnb);
 
 	return 0;
-- 
2.43.0

