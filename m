Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA0CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:07:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 681A242DBD;
	Tue, 29 Sep 2026 15:06:45 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id A804A42D9D;
 Tue, 29 Sep 2026 15:06:42 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687200t7f7474c0
X-QQ-Originating-IP: XWl3vOMpV1R8wNnVrVh0z1IRf0tYK/Z8E2Qx554xFx8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6034040362531857366
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 11/15] net/txgbe: fix 40G FFE tuning applied to first lane
 only
Date: Tue, 29 Sep 2026 21:04:42 +0800
Message-ID: <03123F32F4CF6ADB+20260929130611.4871-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MC9VX3O6wVAO/u975VYgupJ6ljArhhbBkoFNvTZOkAZEaXNZY+UyuxLC
 8fI0ZxTfa8AbycacpVt29/2KtLIYiTHX+tk/Vp1DywxCVKUpydWRXuIF/StfEWpjko9Vp3a
 zZvVSx4qgwmuL5xXT8KFY+XMcF0K5S1DS9DC3dzKoFk0aOwzVlSf4Kzc60vEGWjT6gZ1PgJ
 fDA3PLDaqnmQvGEfaAIAVoXB6lKVjsBM3Kr4BajI3MkQyz14esa6nbuYRUeQTKGPmeDoFh0
 ovAjbWA83cu7U1IRpunMBPtE+mzuWPxOeNMxuBiMAV+jgQBOes+rzXOn6Pbx7ndFA7sz4lX
 Lh4k6LxY9ECF+358Uyj6fWfwDEIJIO5169/GxO45qrIeGtt/28wEZYb/UthS439IlRtnWaD
 tTOv/Sr17sN+jAYhhik6l94TT93WCAVbXQpmHWz3/9jRS2kr3W4EJbCNiW9McL3Mb/fFtXc
 JxAJPUGBWGHN7fVEMp8bF8SlVv0pKql/kpbn/U1F3dDn8+nawNMDX5fF9txCu41TKQKhWaX
 38T7PRs5aFMJZwYtHl//H3dR/aqEchbpNGGxVS4fzCR0XEis6MRDGfdMEs71xqcYcuZl8GK
 skCgU+pDKy3/rhK5KCDfbPXpowktmD1Gvr81ayHSOdp+WPU962ST+yDfX3zRjyJf52QxzpG
 64iFyWTaeY33e4rdRupoofwVf85Jk5Z+nxINZyJlXdg083u0c+fDKIoXxfMklhxlaMZKCMf
 HhPTRmtUP188kRoi08QeqaxkVRuMkoVon9fGGhRiOivq3PKldtpaKt3OffLqKBEa2ZyT+EM
 ZjW8CGys2n0SzXWWmSy9re1oFM3kDw9UBU8LnvkEF9aSJsXAYykIkLELABv6bGAUSYdc2LF
 G4rL15vSe6R/KaGsgs8uCM3TgCItt4iKlS966cW4DnYAewOpED5jt6EatFMdAGtQiMssGqM
 RmkwDmaRBcPEqy1xEu4JsQgNHLj9OnKnJssU2pbY4bqgYYwsfV0nayb/WcZUyym8Kkej9AZ
 6JCY7wQnWh/Z0RIWKNHRqgdKKEWnBYvN+0rSrq5AsqRmd6sfKWVxoHDuaQILONMAvn3CVXT
 OOszE0PViPnHjz5lvGuaJhBWyHyTL/pTMvvn9sQpVPdoy7FzwxEYRGELs4pfmSvUA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
index 222c82694e..db773a1b9a 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -483,6 +483,7 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 ffe_set = 0;
 	u16 ffe_main = 27;
 	u16 ffe_pre = 8;
+	u16 ffe_pre2 = 0;
 	u16 ffe_post = 44;
 	/* FDIR args */
 	u16 pballoc = 0;
@@ -492,6 +493,15 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
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
 
@@ -540,6 +550,14 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
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
@@ -642,7 +660,6 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	hw->isb_dma = TMZ_PADDR(mz);
 	hw->isb_mem = TMZ_VADDR(mz);
 
-	txgbe_parse_devargs(eth_dev);
 	/* Initialize the shared code (base driver) */
 	err = txgbe_init_shared_code(hw);
 	if (err != 0) {
@@ -650,6 +667,9 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 		return -EIO;
 	}
 
+	/* Parsing the devargs requires a known MAC type. */
+	txgbe_parse_devargs(eth_dev);
+
 	if (hw->mac.type == txgbe_mac_aml)
 		txgbe_override_mac_ops(hw);
 
-- 
2.55.0.windows.2

