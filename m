Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D213C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:55:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2A8042EB2;
	Tue, 22 Sep 2026 14:54:59 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id B83E242EB2;
 Tue, 22 Sep 2026 14:54:56 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081692t772eccdd
X-QQ-Originating-IP: Ux8y1K6qrkfOA5ZVfCF9l01QykczeF7MHqllu1CDruc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8793224513665766255
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 12/16] net/txgbe: fix 40G FFE tuning applied to first lane
 only
Date: Tue, 22 Sep 2026 20:37:45 +0800
Message-ID: <AE38F897AC61F6D3+20260922125414.3638-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MD9gZYskqmkEg1RThxasWc3AOH5zbmGxAlYOvw/guS5e436K2XqNfnN6
 +YQz70dicD+72D9SJ/9zFZ0+Dk4a1HG8M+OiPd2woXGb615VpRTfX1Fg0zljlxb9eC7TiqO
 VAwgcUWXwpyYZmSoJQNgw+SXj4CN2Z9Fcyip9lj8ZRnJXQgckiy2OvGiZ8n1Kfw2y2m8/3r
 Fi3KWpYBY5kyMjhO0r1A3GtEyUR5PxtmdSHT7Poc1wEwMYqIIzPrIK4OE5NeHYbz+Eh3eBV
 cXGwtB1vl5AY8npKI2sWBdSooNpo1SANm6F4osY1eVvqO42wKbIe1D5q06tYWXVeemyBOa7
 xFaeoyltpd4C0OyeI1qsoNYO2R2FvWXthI6ywgTsNUUfWwriKGl7hKUjzFulrxLsHAemqoM
 7i3wHx5CQSD9a2ZHsv/f59zd7UvDOgNvDU9Wnbdd61d8Env3NylJoLzLWdRvnU/xTM7uprT
 y1ZamgLr5OdXZGEFoX+s+kRPMZ+S+t0hFCvCRFKwclaXaiCLPoDTvfO+rWrWxP8RucmbhIL
 pdIA1AP7gD2tXmpLje0LRB/0x2q4aJLJhBhogvqOD9gofWa84QTSGCk0C6KLAqA2Zs6ukQ4
 ty0VTpaNl/V8XxkuI5vzbXvvQn3L4nt+8/Kt1uWuu9k1A/PoODxjxZofLOspkWXiZiB54p2
 BUs2KyqWYH9Zad+u0dPMXnHBISaJVLjShJ8u3ULbBPXmA7fsZx/xkpy9vs2denqOFgd/4Ds
 q1Zq5ZP32y57BOR/TfoLZcmuwVM2sh0hyOG2nr3cE11ZIyl2lCy11nyK+mepgGbFg/HEmXM
 NNe+BIowsSBWFuDGI8YeIM29KvMhGyJsrSzbEwSKFFa05fWWL+0NF9KDnnY4kj1REP6HUi/
 J8sg2+Yhv07hdGlEGmBa8/LQlGWZqNdO7q12p/BbhrOUKSf5QjV50GssEV4t/bB5OFZ7ZBK
 P2TTCVZGdCDkIruBNZg4bZk/IFrWSZTG8ddu20T/IHqNIH+UfXhUQop5rUJAxTBkIqAnSrU
 r78CL189/3VLz+/Fqxwdtf5zub99danc6WIz3wwNrbuMByB+R7bSZCkR+/k52hWpXgZIYb6
 kmso7jYrSDX/4+ngkyYUMI=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
index cd7b40dbdb..b27a5af062 100644
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

