Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F4CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:22:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F316541132;
	Tue, 29 Sep 2026 13:22:08 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id A611D427D8;
 Tue, 29 Sep 2026 13:22:02 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680918t4cd33296
X-QQ-Originating-IP: 3VbxaeKMxKoj7cJB51KJJi1JkmR+xdv1rSqPLiYE7jc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10830704852622925045
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 11/15] net/txgbe: fix 40G FFE tuning applied to first lane
 only
Date: Tue, 29 Sep 2026 19:18:11 +0800
Message-ID: <C7D610BFA05B6B58+20260929112119.4516-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvH2zBBgt3uTZTlSMeZrM0ri0F/qtcrFNk9LBO8TTOXx47daYC571z6f
 ssoYxSAogN6l7gHeOlP8O6iAXsFmdnLxrM1QlTEWRL3soF34pBnqEPZ4lR2xSnx3mFSzNK+
 r4UAPpDKHMph88KJBw0NJI2atUSz8G4+OwF2OcW4qQZ3OMhIaaO6hG9pIO5x5p59NnCkM3g
 /MS+Yx4UJ1L+2MqV9A3h2hJMzGz7cmncxlEKYlg81Cxn0x31WRlkp3ysI14zX/AvCdsNkhK
 ekaA0Jo/oH7lxE2ETVFeX6ZO8hq754hzvJhPQ2+tRrNsS5JilXArvhbG5Kid4cEslBeSeCh
 ufreOzjifNuPjaY8qte5M4tA7m/HEoGuOGqaeIAgDayGWBxgE3CJofm9eGiC6FpyD5jVJfM
 SXTSbtv2l8bKTDVe0s2EGHG+Q7SJnyQXXXG5vj0jDagD6avyEE/C40q8srdk0AXTd2Sfvdb
 PlFSAC1dKxSm4h2m3dT+HkeHzHcg/pmW39u/ajHmq67o13HCXJ2jin/o+K1/TRqcSJyy9/W
 Mh8YIBXGY0XVX8D2BTS3lX80N7nM8LW3EIN61P97hf9swpE8IX+VxMln4CW4vwyU675Zn7i
 H8PT/fWxTzJZ4GoRz7HcJ+ts8PI654M/BmGUwZHwO03jN9dO4pGzXWBWdOifYY4a2UucxLG
 7FtopGvHJozX97/tIKOWQRl8dyVKhwf4PwovaXn2WYVJxFNXetKg+sBTHXGbhqoV5498j1z
 aszYiQ9Dx8rzOHqXIdyQFlhYw/k2vUjRDX6QN0YFsMgM9LP72frXJUMyN9NIT23SF16rckh
 P3XUUgXjUXkbg/N8Qn4Gl51BReh9AM5qzMROIDvRXK1R/zRgtJHEbck7pP2LZKvHL/Kniow
 ltrOh0xi0RRO7F/0ROpDp2KhHeN07qxxEHvQzDXIAVBe7SQxN2lLmz9Lg2wRemug19iYkaJ
 RI56TdXRxns6JqkdxBOpfcjTOcpOShV5RgZEjxcvAm0W6iaN+93DuMcASEg5gW1NRFYgrfC
 zoJntIrDII/DFHkIoeqNpepPpShDme7Qts1acEB8RF9f6nuD63tL2zmWyNAlRvpBycjqGpQ
 3eax3+jsCumQ8aLIStRCE4=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
index 7481d45bf6..e130f72ae0 100644
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

