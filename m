Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5D3E78D45
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 08:55:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C98F74060F;
	Mon,  9 Feb 2026 09:55:34 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 87CF640609
 for <dev@dpdk.org>; Mon,  9 Feb 2026 09:55:33 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6198tUbO51144229,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770627331;
 bh=vQihHup3PXhfXukbJBXC2OJ4vp9Ka4T7LjtmQt6nwaA=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=vkn+sfxVUdHcINwhY5D0yXvssP/ElES6hD+y1UHdUy9SKbd5+pU9DALJIqjr9NKHI
 1XhrMkiEJzk88bonRDSm/QsOO0WtXcr01cQuNL9bBC3FebtWqYTsPit26IoFYeYqT+
 DHK9wmv7gxjG1EMjEqeK1OvfNT91ZZqG/WQZlERaLB4/cHWZqclNNdVb2/909liy04
 +zlGkUTu18rfmjNvThUC3pduyZmSCuj8m87Qrnz9J0trLT/K95odZCI14DxaTxeAy4
 5j2yW2lFXhQTuwx5jDoAPfcsqMOGCpm09w2YaT2A5FOd4Ps7SWKMNDWPnD6+NZ511g
 m9QvqaO/JEWBA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6198tUbO51144229
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Mon, 9 Feb 2026 16:55:31 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 9 Feb 2026 16:55:31 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 9 Feb 2026 16:55:31 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 02/12] net/r8169: tune RX desc fetch num for 8126 and 8127
Date: Mon, 9 Feb 2026 16:54:52 +0800
Message-ID: <20260209085502.26722-3-howard_wang@realsil.com.cn>
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

For RTL8126: Tune RX descriptor fetch number to 20.
For RTL8127: Tune RX descriptor fetch number to 12.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/base/rtl8126a.c | 4 ++--
 drivers/net/r8169/base/rtl8127.c  | 2 +-
 drivers/net/r8169/r8169_compat.h  | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/r8169/base/rtl8126a.c b/drivers/net/r8169/base/rtl8126a.c
index 047ef83587..58b1cc2664 100644
--- a/drivers/net/r8169/base/rtl8126a.c
+++ b/drivers/net/r8169/base/rtl8126a.c
@@ -14,12 +14,12 @@ hw_init_rxcfg_8126a(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
 	case CFG_METHOD_69:
-		RTL_W32(hw, RxConfig, Rx_Fetch_Number_8 | RxCfg_pause_slot_en |
+		RTL_W32(hw, RxConfig, Rx_Fetch_Number_20 | RxCfg_pause_slot_en |
 			(RX_DMA_BURST_512 << RxCfgDMAShift));
 		break;
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
-		RTL_W32(hw, RxConfig, Rx_Fetch_Number_8 | Rx_Close_Multiple |
+		RTL_W32(hw, RxConfig, Rx_Fetch_Number_20 | Rx_Close_Multiple |
 			RxCfg_pause_slot_en | (RX_DMA_BURST_512 << RxCfgDMAShift));
 		break;
 	}
diff --git a/drivers/net/r8169/base/rtl8127.c b/drivers/net/r8169/base/rtl8127.c
index 9e79255e3c..26c2cfd25b 100644
--- a/drivers/net/r8169/base/rtl8127.c
+++ b/drivers/net/r8169/base/rtl8127.c
@@ -14,7 +14,7 @@ hw_init_rxcfg_8127(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
 	case CFG_METHOD_91:
-		RTL_W32(hw, RxConfig, Rx_Fetch_Number_8 | Rx_Close_Multiple |
+		RTL_W32(hw, RxConfig, Rx_Fetch_Number_12 | Rx_Close_Multiple |
 			RxCfg_pause_slot_en | (RX_DMA_BURST_512 << RxCfgDMAShift));
 		break;
 	}
diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index 9163c7f59f..ab6a984a54 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -563,6 +563,8 @@ enum RTL_chipset_name {
 #define TX_DMA_BURST_16     0
 #define InterFrameGap       0x03    /* 3 means InterFrameGap = the shortest one */
 #define Rx_Fetch_Number_8  (1 << 30)
+#define Rx_Fetch_Number_12  (BIT_30 | BIT_29)
+#define Rx_Fetch_Number_20  (BIT_31 | BIT_29)
 #define Rx_Close_Multiple  (1 << 21)
 #define RxEarly_off_V2	   (1 << 11)
 #define Rx_Single_fetch_V2 (1 << 14)
-- 
2.34.1

