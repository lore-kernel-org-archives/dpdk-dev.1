Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6EFCA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:06:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4651409FA;
	Mon, 12 Oct 2026 13:05:59 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id A8280402C6;
 Mon, 12 Oct 2026 13:05:56 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803154t3911c456
X-QQ-Originating-IP: gP78yl1fnnWgn/68DfzEN58DZkP/LqtCDnuMEB5GtUo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1367535207422417481
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 11/16] net/txgbe: fix 40G FFE tuning applied to first lane
 only
Date: Mon, 12 Oct 2026 18:56:28 +0800
Message-ID: <D01FF79E6FB671AB+20261012110518.1911-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mb1BOhWcNIRMOoE5EnVKuhFtdJ3Mgq4avNr4+ExgoktRe0zTSEYYoXMX
 f2e4Q/ANGNmWNqIcV5XMisTWHsfioo7u4B+1iC5zUyoSXYt2t/aAu66J/6ZrQV054DjZGdk
 p8CK6G55+kp1F0WRyhoQjWtLueqaCCIKvrJMQPcGUOXbnCeRvOa5U78AK3yQWtNAecNhRdZ
 SNV9JNA0Oz5LvY8eFVur3Zy+hXsDH0jtGpF3nCx9z2BHdLoq2ma77GFDAisV1A9odYzbocD
 +xhbWvw/VuMkl/2UL7SYvUUGahRG5bhh794nW59/2qAzl7Fm11kwjy6NzNw8ekxOeL75Vcg
 NBeX2i7Y11CG1kh2xGgfb6A7ttWw+bwFmlaYIfi7O8uetsyPsLV+TBbx5JTNmt+g/vF2ijx
 Pol0cl0eBJaCz4A7ZOQh8qadbNNjUo0RA3g9sqnd38dpUNcTzOj7NqiULHN7cPyK8an8nx/
 9llTyyhKLwQ4kqNnXZwjcEohRXSq53n5Db/4eVVhmxbcXM7AOeCpvo/cbXjzwTsU6W11LHx
 PXHeYT6vP1dFqxEUbxW4Bt8cNRE0nieB0rIyaUZabA1g48bO/JU8YGiKD7oTWD6lnfxfwvI
 Z9yTsphJ7Q8pIWIH7+ByxzsC6vH4/nCV6SYrgIvlwUTI6FWwgXxkdcmxdMJygVt36nqFuqP
 HTDHPIMe/QJgZca/mSigzkONQGrIpR1lTqnWJyFohkfijH8WVbmt1p4FDmhtzN7Imf672qH
 ftm2+KBgicaltFuilFkXIxNDBwju7T07UYI4jaiCguKV/WG9ArJp4+jvGyMhqlz5rtmG0Mp
 PYi5CUXj16+ftPLKgg4V1EzSg35rvH1gT119LUi4Pl5/zhghAYz95sm1GVVYUwSnEoA+Svn
 L/u+BIHf/bKzksBK5Kl0GpVNV2RDIR+uu0PhS6/qhoCd/3g4KW7Dx+R33Ln16e8WIq61YEK
 Fos4Uc9+MahB8Wr5BVBEfRnA6NfK+cM2DrqQBy2L+YATeUiuHR5/r18UL+hBCI3sMbDlUbO
 H1ukgXI9+KC82R9HJg6CBG9YGHwkxxuO16LEpINIxYHaBBvojRArh3osK4mWVQYcV6XOg5j
 b4br4H4FwcL9VfNzRxRKBLr48H/ppqb7iMX37F0gmsa
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
index 8e2adb245e..25a65f6a6d 100644
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

