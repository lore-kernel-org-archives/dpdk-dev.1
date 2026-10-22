Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C7C606A324
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:11:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D47140B99;
	Thu, 22 Oct 2026 13:11:02 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 8B60340A8A;
 Thu, 22 Oct 2026 13:10:59 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667457t72bb0b32
X-QQ-Originating-IP: voyihWpt0mBUUJUWkBiV5PaKFC5YD7pG7AynMubuXDs=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:10:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7488870012874104741
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 11/16] net/txgbe: fix 40G FFE tuning applied to first lane
 only
Date: Thu, 22 Oct 2026 19:03:17 +0800
Message-ID: <D6B3296B2D9C6AC4+20261022111017.3605-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NuQRJUP0KJGkhSEx4zO0qs07cLDRuMLNYViiGDWAtwlkFMr3K3KcnrBp
 v6ZRyRrcAZ/EDYrbNRFcWE0ocu3GHkayHVR1sPaHN6fHGh9DWhxGmOqNZpHbTpklqBqWJz8
 7t2g4J6IRiOXjUCn7uX26ht5bfg4xpnPmaYSdCYkKcqQ1UKndzhprhsklIN7hA2BMmxFwI7
 q1Erk6k9muUNWgnoazmjDh5WTbR9Mt4mnPQf4KfMqyzM20lzTH0jbfoMWbUm2ddA6ejQZms
 iYsJpJpbnQuBaJ8mh2OLfRk5C2gm9PFQ+Ay1awnI9GftH9Jio+uPKlGxAqX5TaqTzlw7U4Z
 JdGj79wAtu1m46L9gHzNjeZ2pP2LfH7NGdz75x/Irce33C/iZeYY4xcm6awXgSgn+pBYQTg
 /71Us/M7kZYlqxR7LICed0g7LNDVJ/k3ee1tY4pi3gRsIxFEDSAWG7B1qwa4pzdbYpfjsWB
 pdusFJq2l2aNsS7okUplykgAbTEyqmhU3+ru5DbplLxtzTe4XznW4afxj6RAfnx7kkazr/S
 h3QaR2Q78MUFjYu3rhW3UQW8UN2FCP3TCJodHFiqdoUkC05fUyC2mosYaWa0Rwty3Kw2rMi
 MJ4sqdFBLRqcZsayqWUmm1c4WR2D0esG87J1iin45xzLOb+gf6g5VEauTkFOpJLdP2XVBBe
 quYxKd3Z/hd8rLfXqY1Ee0hAlaVKhpwROMAiz7tsjz+fM6c9yrm8/Nnj7YdWZpyLBRIeANP
 trD1SKpaYR5yzq9w2f2DETAMeVZCu3lbY94RNLtv0922RBvQGBSW+Cl5RqQaXwF/XxBh3qZ
 QFPcp4McP6Kpsn2wDTbK6L1gD4xE14865A6Ow6LSrd0tVdhNTNfs4f7UiZiMgj2pgu+ogBG
 wCWdxbJPdFGVLoHkLMgDycb16bVlI3GpIXmjs+LuAPEAv3c6mD9JceKEpPs11Rv7XBMiuzW
 qFBQrxH0IqXXI8pxIjvwhc1RSo/cwbEQTv/i5mnNyc3IjH1ODyVdI1/VoqzFX94e1JFwErF
 w+3+d4NA/P3NsxTAjdFGEguPsG7y23rgG1/U8uH7tULOOwWkt8yfvqq8sakcj+sfXQbKorv
 8FflU80exmD
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 drivers/net/txgbe/base/txgbe_e56.h  |  3 +++
 drivers/net/txgbe/base/txgbe_type.h |  8 ++++----
 drivers/net/txgbe/txgbe_ethdev.c    | 22 +++++++++++++++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.h b/drivers/net/txgbe/base/txgbe_e56.h
index 1922a2eb92..a2ae7ccb7e 100644
--- a/drivers/net/txgbe/base/txgbe_e56.h
+++ b/drivers/net/txgbe/base/txgbe_e56.h
@@ -1714,6 +1714,9 @@ typedef union {
 #define S40G_TX_FFE_CFG_PRE2        0x0
 #define S40G_TX_FFE_CFG_POST        0x11111111
 
+/* One FFE byte per lane: replicate a user value over all four. */
+#define S40G_TX_FFE_4LANE(v)        ((u32)((v) & 0xFF) * 0x01010101u)
+
 #define BYPASS_CTLE_TAG             0x0
 
 #define S10G_PHY_RX_CTLE_TAPWT_WEIGHT1      0x1
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 5c16c4f07e..60298800ee 100644
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
index ececbfb13f..4529d34ca3 100644
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

