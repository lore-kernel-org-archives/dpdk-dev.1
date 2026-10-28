Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2524606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:41:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C34740A82;
	Wed, 28 Oct 2026 11:40:30 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTPS id AA2DA4067B;
 Wed, 28 Oct 2026 11:40:27 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184024t062ccb48
X-QQ-Originating-IP: wam/uV5IDeUJ05W+ogPous7aNGs/aTG1iLFrXPWE8oA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11931242878719802302
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 11/17] net/txgbe: fix 40G FFE tuning applied to first lane
 only
Date: Wed, 28 Oct 2026 18:34:00 +0800
Message-ID: <A6F2E44B73CF802A+20261028103913.10188-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M0PjjqbLT90wf0uVj93TuxlWfUL22Mf3kNd5H+ZFdbxinx8s6ep5UVM7
 rUoegfEuFOjYjSeApKaG8bMJ1KZk06meIDZ2L2mQOA9A7+LUS5dcd1DioS1l8keyESuuLxa
 mAB1ssqMuAlSHiwLk0jB7E804FjuMCkkbd7Qm8Dcx54/MA8epwupHnX1/U/3hfLDASjoDI3
 8LRLLQ6WiAaefzjko2cMtJRfrRnA7xyUzOMWNnfXQbYWyEyo5n6VRi5FaKcIxs+jFzrYNCL
 oJgm8QXQsOtKvsgkILxGrBOh1JNAgnHuIxcMpQmg5rQH1Q2ywvMOoIFtOrryUCV2JRKxrUr
 qw03DpOCI/vQQuWoze5ShCREKRbTGyWCGG3rjRljaMqKbSDP4lye5SO2CJ7PMust5XCX4Cp
 Z3oslCj0+eBGRJT76K7Vug4zGvC9/9YLf/+HJdGqgKY72RoEVN/d3wUCiaXF2CXGfSPt9GG
 Sw8njo8yvJ5gKBFRwnLFaBzntxFR6Tz+78XtKAgnOpF5D3HMszY/yEFL0Rd1zFQnqCloWsu
 gYN+D5SBGP2yN1k74cCxiaXBxrC8QVfQvTXbqRuXdxcU9HGLuuxzf1FY3OCXG50q7P9xwZh
 Mo9C1737CVLCFlh+LdzJQoRg/iVnx47bvJRi970lDVBI2q02Ssm/4YQqzAaEwxbI3EVoHPH
 ON1RE5827MOd+XjNWXHLPwRaLkbPX0h4l3g6NYME1D3YA760w38E4iQ5SvyGNmiSkrWZ9rZ
 9xmtPAH1Mrfrbyi6kLgF8olxinYZM7o4ONN3Xnw6lM0DztvsdirVuE0XcZGxxwDeGfgmCF6
 ZhUnajKALRJkUkvMhX0oDQ6nVUOsSf3USOLD6lhfl+zLnQgI5dVEzWJzQwe+ABWq94RgQpV
 rxwBXBG3kzhEGK58cYsOh5Fsp0xQoyjGNIOr9a7CgMDpWN/XbbY5qLlcr3q2C363qWs8+nx
 5tbtw/jvz81V46LtT6lTXcKb4n/xB16XMG8+bUJh/iwGUAWK8uBZZ3GRtUkNhP4zP4Z0DZt
 oK3nF8aBubwm5aYmHV65TG7KHcRgfOZdFDlyP/MRZFdlvT3K1L3ya9rzEoN1NXlMV1YPV4r
 URTDPeJpG/UlQu1EwzCbHo=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

