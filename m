Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E5C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:29:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 734F3410E3;
	Tue,  8 Sep 2026 15:28:24 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 968CE402DF;
 Tue,  8 Sep 2026 15:28:20 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874093t5abc1cc5
X-QQ-Originating-IP: e0qQpu782I3QEeXQZHH4BfGNtQ43srkJS921OSGe2vw=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:28:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6916109202203707695
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 11/15] net/txgbe: fix 40G FFE tuning applied to first lane
 only
Date: Tue,  8 Sep 2026 21:25:56 +0800
Message-ID: <59645EEA582A4CEA+20260908132742.2661-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MjavoF4/XaCKsyDrO3Wye/Q6F6ASXrUAnEVK+xltGKQFEAKHYI4yzFqB
 0ZzJz8gxbKW4i+HSPI8IiJUoWzwtMOiGiteEs2ZnayDEJtdKm8Ub0fEiSuTD9QnKeJ4C4vw
 FqJSswdI3le3OAmCBverS17Dys8IHLMo99iU3QirhnpfxfRe865w6WsUHT9T6HoaRH1JQdc
 /qTu3whsWkljzwnCMFCmxVgK9xg3G4qqkrkSx8oVDMYI7CV7bECvjJbWFlhkkPLzR5VfkUf
 Fly/N9mbGZO9Yaxh+ZufcgdhYP3+5ZfQvZnNaLOtKy0N5Q9b5z6fcS5A39Z95MzKjgA9Cx5
 5imXX/ouyXSc+t4QnkEXzZrvRljFrFNy3Ji/+9kFTYm2kD1DUT2+3GldZMur3eziEib9dWO
 aVIl42M04ehmrTp3K/iL2Xw1ijQMVV72OnItsdiFI0YnDlccrK9tYd/jAV9syGJ48EO+bpl
 kIbDN+6MN16axzEsN2olkAFy288mr3VSmvEPEMbZwsCwTwLSJqi3MmS5YeGhD8rlL++tJf3
 juhj8wut3csv2mbAaACQicnLiOE2TpVx3nxvd1XES2fSGSi8GCs1C9Sa1kPo8zIG/62LrCK
 hzACbL+9HKqieHZYIOUwI5HMCUS3FSSRkRTZoXxGpuBZ+l10tN1sD/ghbAEYATw6zDhEj9y
 HDzpCjFQjyvmIXrxvn9zZrSFaiQE4FJUtWusMbWHuhapqCJiK9t/teW+L3Yi0dS6ZeNHYFa
 ubHYxnxT/MoM+ogWqdnG8EK2TyIzx0qfPujg0rpPF1bbO0ai/xDAcDqJwey1NosaRQOP4+I
 QpJVY+0xdM4BA5ZbEot/k28YhL1VYirjoRk14Ls7V6P9JCxiIqQnl7vAyetuX1POAs7SV51
 7zkzVcigCArIaKYMuV//eahmpmzfLP7off7BSjycV26GkMS0LsyM19E1lO22aPhQ7pLb8Wn
 o2ePBr0WCZlC1Ca1Dj6IgN44fYiqds7zPb9ABrI5We+c4Cb5hR0xgdD3NqyUr3db16dJLz5
 ZXxepfFpOf4R/GYWGRqM/zOVdcj+M7XsIr19vx4dIZ9t/cCx9DzkBIs2+vXp2lHuyfL6nLx
 5cIeuqTn4k8HF39e2Am5D4NYoAHpXR/bwl9jrzny4B1wXCF4ZCkXMoCY4Dl4VE3umysUwTQ
 Y0ub
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
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

On the 40G NIC, an FFE value only reaches the first of the four
lanes: the E56 PHY holds one FFE byte per lane, but the tuned taps
were written as a single byte value, so the other three lanes keep
their default equalizer setting and the received signal on them can
be degraded.

Use the E56 PHY FFE defaults on the 40G NIC and replicate each tap
value over the four lanes. The FFE fields grow to 32 bits to hold
the replicated value, and the devargs are parsed after the shared
code init so the MAC type is known when the 40G defaults are picked.

Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.h  |  5 +++++
 drivers/net/txgbe/base/txgbe_type.h |  8 ++++----
 drivers/net/txgbe/txgbe_ethdev.c    | 22 +++++++++++++++++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.h b/drivers/net/txgbe/base/txgbe_e56.h
index 1922a2eb92..fe9a83ae01 100644
--- a/drivers/net/txgbe/base/txgbe_e56.h
+++ b/drivers/net/txgbe/base/txgbe_e56.h
@@ -1714,6 +1714,11 @@ typedef union {
 #define S40G_TX_FFE_CFG_PRE2        0x0
 #define S40G_TX_FFE_CFG_POST        0x11111111
 
+/* The 40G PHY holds one FFE byte per lane, so a user supplied value has to
+ * be replicated over the four lanes.
+ */
+#define S40G_TX_FFE_4LANE(v)        ((u32)((v) & 0xFF) * 0x01010101u)
+
 #define BYPASS_CTLE_TAG             0x0
 
 #define S10G_PHY_RX_CTLE_TAPWT_WEIGHT1      0x1
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index f9b5cbe61a..4ed4737043 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -739,10 +739,10 @@ struct txgbe_phy_info {
 
 	/* Some features need tri-state capability */
 	u16 ffe_set;
-	u16 ffe_main;
-	u16 ffe_pre;
-	u16 ffe_pre2;
-	u16 ffe_post;
+	u32 ffe_main;
+	u32 ffe_pre;
+	u32 ffe_pre2;
+	u32 ffe_post;
 	u16 fec_mode;
 	u16 bp_capa;
 };
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 0aa2d5719b..afed59d4cf 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -531,6 +531,7 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 ffe_set = 0;
 	u16 ffe_main = 27;
 	u16 ffe_pre = 8;
+	u16 ffe_pre2 = 0;
 	u16 ffe_post = 44;
 	/* FDIR args */
 	u8 pballoc = 0;
@@ -540,6 +541,15 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 tx_headwb_size = 16;
 	u16 rx_desc_merge = 1;
 
+	/* The 40G NIC holds one FFE byte per lane, so the E56 PHY defaults
+	 * below are later replicated over the four lanes.
+	 */
+	if (hw->mac.type == txgbe_mac_aml40) {
+		ffe_main = S40G_TX_FFE_CFG_MAIN & 0xFF;
+		ffe_pre = S40G_TX_FFE_CFG_PRE1 & 0xFF;
+		ffe_post = S40G_TX_FFE_CFG_POST & 0xFF;
+	}
+
 	if (devargs == NULL)
 		goto null;
 
@@ -588,6 +598,14 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	hw->phy.ffe_pre = ffe_pre;
 	hw->phy.ffe_post = ffe_post;
 
+	/* The 40G PHY expects one FFE byte per lane. */
+	if (hw->mac.type == txgbe_mac_aml40) {
+		hw->phy.ffe_main = S40G_TX_FFE_4LANE(ffe_main);
+		hw->phy.ffe_pre = S40G_TX_FFE_4LANE(ffe_pre);
+		hw->phy.ffe_pre2 = S40G_TX_FFE_4LANE(ffe_pre2);
+		hw->phy.ffe_post = S40G_TX_FFE_4LANE(ffe_post);
+	}
+
 	fdir_conf->pballoc = pballoc;
 	fdir_conf->drop_queue = drop_queue;
 }
@@ -690,7 +708,6 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	hw->isb_dma = TMZ_PADDR(mz);
 	hw->isb_mem = TMZ_VADDR(mz);
 
-	txgbe_parse_devargs(eth_dev);
 	/* Initialize the shared code (base driver) */
 	err = txgbe_init_shared_code(hw);
 	if (err != 0) {
@@ -698,6 +715,9 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 		return -EIO;
 	}
 
+	/* Parsing the devargs requires a known MAC type. */
+	txgbe_parse_devargs(eth_dev);
+
 	if (hw->mac.type == txgbe_mac_aml)
 		txgbe_override_mac_ops(hw);
 
-- 
2.55.0.windows.2

