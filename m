Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E1EC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:55:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD31942E7F;
	Tue, 22 Sep 2026 14:55:00 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id DBC0542E91;
 Tue, 22 Sep 2026 14:54:57 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081695ta7143071
X-QQ-Originating-IP: iSZYc3DRrHKpkzz/Umdq6OIMc2iGPp0w99WpUl+tUqQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5993581630176637067
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 13/16] net/txgbe: fix unset pre2 FFE tap and backplane
 capability
Date: Tue, 22 Sep 2026 20:37:46 +0800
Message-ID: <596692D5AF4CE36B+20260922125414.3638-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NpiO5ZMYC9gnOuZi04NZWDPRTgzkXsVhPvHDL92j3+7xujpO+FB2nc7W
 HTfgdVikgwf08pIfwEZwsQ0v/ZBu6o38ivdPnabA9VIvIvrwZd2IxxVzLvHlvAsdXZCB5gf
 GPhLojLZWqZ5BQlkxMXFJEtmSguA6vTFPBMYGLrk+yPhrDzgaN9OnDaEPD7PesMXmDa/vhb
 ImgtrM0JNEA17P18iqLMpwsoa6LYg+gTv81dMSIjO3Rsnkg6KezjWxMmgchhw0hQEJ5QbJc
 tHKQ+nNDGSUz10VxSIQD8WXxck+glRhMBdUaXssYeWm6Mj0aDIRkixB1EdkHz0yXFQTWFTa
 JEnbJjF+KTOu2qGZEQIohbRbcGQS83g5ku9nUK8yP2pYeP1m5WHCCypllzkcLPPBsU7kOFm
 NgguCHNW/lgKeBlH2vhZJQwUdH2aNsdQQv/vQR+942wZbzGU6tt/p/d63crcdFMAerlScHK
 tkouCi7r/cD3DUK6BsMAo/ABgCztCquc9k4qhkusZ4/Wbp67suPSBEypGRe6GTgim8aSPCs
 d9K6TLhp5diPvZ8bh8KuXJL7xvxz1vAOwS1I3mNUWGu4iWJ2PweSr9hAtXd9Vk7VX6OgJ3i
 H0ek4S3zXVno4QSBHg3Sc7szoLQtVy6AO1AlWYt5CbNoQNIC1tWIhhzTCbNTrEYb4v7MdCl
 z6I9dEiYlb2VTKYJxBLowIqa91lVp15ZZFemC1tzCYMDWOJ5ub3V7ST2Ze7+jzUcnItD5Pp
 MrxVG2rR0boN5yXz6iJO2SOo3L9odajBdKGSh40l6XPK/lrci1V5xj0yTUx+GAICHXkE3LP
 QsqJx8TcudzzejTDNnDkteXk98FeKVEk50TR6yQD1tCsSZq/2yz+DrdRGD+QwjhqrxmbNVt
 y7dKvtOnT1dduxBOmS7CLNy3vQfmjJppfYdVp7NlwkgMXHGhlXJ1UWZy4g3NMTMwnd5bOpU
 eqnfRrHUv+lFdqdes+iUewBE02VG2nWoTcCd5tvn9DljD1e/mJ/JKa4ILLlxBpF7gs0UFrS
 EEWibq3dgtvpdLHqTp+a1CMt6dV0xCu8cXDo8+J02sRViBH+c+IRxM9Tea8oOXOfMHt7Osw
 ynjbBmLGrR0bd3MibvDoCM=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

The second pre-cursor tap of the 25G E56 PHY and the advertised 40G
backplane capability selector were both added without any value ever
being assigned, so hw->phy.ffe_pre2 and hw->phy.bp_capa stayed at
zero:

- With ffe_set enabled, txgbe_e56_tx_ffe_cfg() programmed a zero
  second pre-cursor tap instead of the recommended value for the
  module.
- txgbe_e56_set_phy_link_mode() could only advertise KR4+CR4: the
  KR4-only and CR4-only capabilities selected by bp_capa were
  unreachable.

Assign the recommended defaults and add the ffe_pre2 and bp_capa
device arguments so that both can be configured. The NIC guide and
the release notes document the two new devargs.

Fixes: 6104fd11089d ("net/txgbe: fix link stability for 25G NIC")
Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst              | 11 +++++++++++
 doc/guides/rel_notes/release_26_11.rst |  8 ++++++++
 drivers/net/txgbe/base/txgbe_type.h    |  6 +++++-
 drivers/net/txgbe/txgbe_ethdev.c       | 23 +++++++++++++++++++----
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 90c55141f1..d56fb3b99a 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -142,6 +142,11 @@ Please note that following ``devargs`` are only set for backplane NICs.
   PHY parameter used for user debugging. Setting other values to
   take effect requires setting the ``ffe_set``.
 
+- ``ffe_pre2`` (default **0**)
+
+  PHY parameter used for user debugging, only for the Amber-Lite E56 PHY.
+  Setting other values to take effect requires setting the ``ffe_set``.
+
 - ``ffe_post`` (default **44**)
 
   PHY parameter used for user debugging. Setting other values to
@@ -177,6 +182,12 @@ Please note that following ``devargs`` are only set for Amber-Lite NICs.
   In this mode, the hardware merges and writes back a group of RX descriptors
   together to reduce memory access times, which helps improve performance.
 
+- ``bp_capa`` (default **0**)
+
+  Backplane capability selection for the 40G NIC. Set 0 for both
+  40GBASE-KR4 and 40GBASE-CR4, set 1 for 40GBASE-KR4 only, set 2 for
+  40GBASE-CR4 only.
+
 Driver compilation and testing
 ------------------------------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..461e26459b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -56,6 +56,14 @@ New Features
      =======================================================
 
 
+* **Updated Wangxun txgbe driver.**
+
+  * Added the ``ffe_pre2`` device argument to tune the second pre-cursor
+    tap of the Amber-Lite E56 PHY (requires ``ffe_set``).
+  * Added the ``bp_capa`` device argument to select the advertised
+    backplane capability on the 40G NIC
+    (0 for 40GBASE-KR4 + 40GBASE-CR4, 1 for KR4 only, 2 for CR4 only).
+
 Removed Items
 -------------
 
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 4ed4737043..f56cd70c6f 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -741,7 +741,7 @@ struct txgbe_phy_info {
 	u16 ffe_set;
 	u32 ffe_main;
 	u32 ffe_pre;
-	u32 ffe_pre2;
+	u32 ffe_pre2; /* only for the Amber-Lite E56 PHY */
 	u32 ffe_post;
 	u16 fec_mode;
 	u16 bp_capa;
@@ -754,12 +754,14 @@ struct txgbe_phy_info {
 #define TXGBE_DEVARG_FFE_SET		"ffe_set"
 #define TXGBE_DEVARG_FFE_MAIN		"ffe_main"
 #define TXGBE_DEVARG_FFE_PRE		"ffe_pre"
+#define TXGBE_DEVARG_FFE_PRE2		"ffe_pre2"
 #define TXGBE_DEVARG_FFE_POST		"ffe_post"
 #define TXGBE_DEVARG_FDIR_PBALLOC	"pkt-filter-size"
 #define TXGBE_DEVARG_FDIR_DROP_QUEUE	"pkt-filter-drop-queue"
 #define TXGBE_DEVARG_TX_HEAD_WB		"tx_headwb"
 #define TXGBE_DEVARG_TX_HEAD_WB_SIZE	"tx_headwb_size"
 #define TXGBE_DEVARG_RX_DESC_MERGE	"rx_desc_merge"
+#define TXGBE_DEVARG_BP_CAPA		"bp_capa"
 
 static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_BP_AUTO,
@@ -769,12 +771,14 @@ static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_FFE_SET,
 	TXGBE_DEVARG_FFE_MAIN,
 	TXGBE_DEVARG_FFE_PRE,
+	TXGBE_DEVARG_FFE_PRE2,
 	TXGBE_DEVARG_FFE_POST,
 	TXGBE_DEVARG_FDIR_PBALLOC,
 	TXGBE_DEVARG_FDIR_DROP_QUEUE,
 	TXGBE_DEVARG_TX_HEAD_WB,
 	TXGBE_DEVARG_TX_HEAD_WB_SIZE,
 	TXGBE_DEVARG_RX_DESC_MERGE,
+	TXGBE_DEVARG_BP_CAPA,
 	NULL
 };
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index b27a5af062..72264befae 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -540,13 +540,20 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 tx_headwb = 1;
 	u16 tx_headwb_size = 16;
 	u16 rx_desc_merge = 1;
+	u16 bp_capa = 0;
 
-	/* The 40G NIC holds one FFE byte per lane, so the E56 PHY defaults
-	 * below are later replicated over the four lanes.
+	/* The E56 PHY needs its own FFE defaults, as the ones above only
+	 * apply to the Sapphire PHY.
 	 */
-	if (hw->mac.type == txgbe_mac_aml40) {
+	if (hw->mac.type == txgbe_mac_aml) {
+		ffe_main = S25G_TX_FFE_CFG_DAC_MAIN;
+		ffe_pre = S25G_TX_FFE_CFG_DAC_PRE1;
+		ffe_pre2 = S25G_TX_FFE_CFG_DAC_PRE2;
+		ffe_post = S25G_TX_FFE_CFG_DAC_POST;
+	} else if (hw->mac.type == txgbe_mac_aml40) {
 		ffe_main = S40G_TX_FFE_CFG_MAIN & 0xFF;
 		ffe_pre = S40G_TX_FFE_CFG_PRE1 & 0xFF;
+		ffe_pre2 = S40G_TX_FFE_CFG_PRE2 & 0xFF;
 		ffe_post = S40G_TX_FFE_CFG_POST & 0xFF;
 	}
 
@@ -571,6 +578,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &ffe_main);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE,
 			   &txgbe_handle_devarg, &ffe_pre);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE2,
+			   &txgbe_handle_devarg, &ffe_pre2);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
 			   &txgbe_handle_devarg, &ffe_post);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_PBALLOC,
@@ -583,6 +592,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &tx_headwb_size);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_RX_DESC_MERGE,
 			   &txgbe_handle_devarg, &rx_desc_merge);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_BP_CAPA,
+			   &txgbe_handle_devarg, &bp_capa);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -596,7 +607,9 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	hw->phy.ffe_set = ffe_set;
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
+	hw->phy.ffe_pre2 = ffe_pre2;
 	hw->phy.ffe_post = ffe_post;
+	hw->phy.bp_capa = bp_capa;
 
 	/* The 40G PHY expects one FFE byte per lane. */
 	if (hw->mac.type == txgbe_mac_aml40) {
@@ -6519,12 +6532,14 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
 			      TXGBE_DEVARG_FFE_SET "=<0-4>"
 			      TXGBE_DEVARG_FFE_MAIN "=<uint16>"
 			      TXGBE_DEVARG_FFE_PRE "=<uint16>"
+			      TXGBE_DEVARG_FFE_PRE2 "=<uint16>"
 			      TXGBE_DEVARG_FFE_POST "=<uint16>"
 			      TXGBE_DEVARG_FDIR_PBALLOC "=<0|1|2>"
 			      TXGBE_DEVARG_FDIR_DROP_QUEUE "=<uint8>"
 			      TXGBE_DEVARG_TX_HEAD_WB "=<0|1>"
 			      TXGBE_DEVARG_TX_HEAD_WB_SIZE "=<1|16>"
-			      TXGBE_DEVARG_RX_DESC_MERGE "=<0|1>");
+			      TXGBE_DEVARG_RX_DESC_MERGE "=<0|1>"
+			      TXGBE_DEVARG_BP_CAPA "=<0|1|2>");
 
 RTE_LOG_REGISTER_SUFFIX(txgbe_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(txgbe_logtype_driver, driver, NOTICE);
-- 
2.55.0.windows.2

