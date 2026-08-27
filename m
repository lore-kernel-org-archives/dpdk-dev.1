Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4671C61DC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:44:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89AB540698;
	Thu, 27 Aug 2026 13:44:16 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 2E8704069D;
 Thu, 27 Aug 2026 13:44:13 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831050tc03ded29
X-QQ-Originating-IP: gq7JJTY3JcQonU6hFJVZPVLXzlhlkjDXr195UbkoT4A=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:44:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8609732540424383190
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 10/13] net/txgbe: add backplane FFE and capability devargs
Date: Thu, 27 Aug 2026 19:42:02 +0800
Message-ID: <353723D51C5A3785+20260827114309.10530-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MpF2fip8b+qQsnqmce+mINt2FXZAW6Qz4jbjPiHb85Y3s24hNCpruiAd
 7koMAwjvWnC7XbnQ0q6ZtxiAfd51+N9o6SChnNTdWYx5d6Jwm7hjSdZbTjKYnJ+liS6StJm
 UzFit+H7rBv/CCjBc7d5axTbfG0AV8jaY49bBOAym2JOE5RaiUyCRpGU6f4GF1wngp+LtBb
 MlBqkQhPEPAy1lM5ov2EeFx8Eb7eXIB9rGEllAVB99a3BoIFTBQ3APJTntNTiafnhXv0nYk
 adOwSwpswpZAcom+s4PdG+oehaxg/RsZJmGb8Ul47H4TLsVDrpy3UG6LJAF41JDyBy37Vvn
 LfCiikQO9yTCN3cEnQV5S+U/qH6nxz6keIbIJ4qC/+MJyGijjLkvMzAOl0eeFDyZVTF9kTQ
 wL/T0TcBB7/Eb9B8zRTdziVPWs7D72NCAWrdBly20t+MjAnRIqm1fAoABchdHJdlKtvf0Em
 36jaDBQgYZDHBpuye3u6XDQ6fqWHvcNy/saEHTaDVbxXIBj3YJS117VWhGoTjHQy3wFWtdB
 NojNgriWFIyDTgR5h4c1vKOKrac7+g6aAeMTvJmzpRZ8zr527w9A4PZ20HbDLUoWA0l4Zbu
 4D2S1lezLrxQKIEUFXJSZ8Nr1hfo1LOPNwcO8tljo2I58XJCkyQOATlSg7eOCaYvgNycSrE
 ecF24FCCHutI/abZQ0hX0Upu6Y5gNLpoROLqOfhhf7o+idQA0xF6D6N7Rd0WOJ53jDaEDhk
 x6sra1mqO8x+YR+/mSIRbHjVNUr9Kswbfmh6p8HDYsZHsVUwqp/G84G/j+UUgzajOFpdGoO
 lbXE3lILojByuhzv5EsBnBrfWP3D52wPs2f8tM6sgJ7pr5q76T5PQwVfWjAVYcqKMLP9gXd
 HmV50VPVaaEYwmYuevj3VhFCrSmsFGaN8x/g8/EsKPEQAZKWGn0EiqQhEUP8mxF5angh4J1
 W3Y2hmc3XoKkqOSqz6ENum6eXvowPkw1Doro2xYeM8Ug+fOIyFZSiOw/+/XkqhRR1Jp7gPW
 yz+m/vT+/+51ZZxQRCqVGREuUQYOB7mnd7W5xpHJ5ty3NaAhk5znuMzF4KlX/ls0KZC+tsZ
 23oIpD2FZo+y5svh42294cD053bc4Kkf7bruJUX3kSzRukfFQZJMog=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

Two backplane configuration knobs are missing.

The 25G E56 PHY has a second pre-cursor tap that cannot be tuned:
with ffe_set enabled, the pre2 value is never applied. On the 40G
PHY, a user supplied FFE value only reaches the first lane, because
the register holds one FFE byte per lane and the value is not
replicated over the four lanes.

The advertised 40G backplane capability is hardwired to KR4+CR4;
there is no way to advertise only 40GBASE-KR4 or only 40GBASE-CR4.

Add the ffe_pre2 and bp_capa devargs, use the E56 PHY FFE defaults
for AML/AML40 when ffe_set is enabled, and replicate the user FFE
value over the four 40G lanes. The devargs are parsed after the
shared code init so the MAC type is known when picking the defaults.

Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst           | 11 ++++++++
 drivers/net/txgbe/base/txgbe_e56.h  |  5 ++++
 drivers/net/txgbe/base/txgbe_type.h | 12 ++++++---
 drivers/net/txgbe/txgbe_ethdev.c    | 39 +++++++++++++++++++++++++++--
 4 files changed, 61 insertions(+), 6 deletions(-)

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
index f9b5cbe61a..f56cd70c6f 100644
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
+	u32 ffe_pre2; /* only for the Amber-Lite E56 PHY */
+	u32 ffe_post;
 	u16 fec_mode;
 	u16 bp_capa;
 };
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
index 38c58323e7..181a1df523 100644
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
@@ -539,6 +540,22 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 tx_headwb = 1;
 	u16 tx_headwb_size = 16;
 	u16 rx_desc_merge = 1;
+	u16 bp_capa = 0;
+
+	/* The E56 PHY needs its own FFE defaults, as the ones above only
+	 * apply to the Sapphire PHY.
+	 */
+	if (hw->mac.type == txgbe_mac_aml) {
+		ffe_main = S25G_TX_FFE_CFG_DAC_MAIN;
+		ffe_pre = S25G_TX_FFE_CFG_DAC_PRE1;
+		ffe_pre2 = S25G_TX_FFE_CFG_DAC_PRE2;
+		ffe_post = S25G_TX_FFE_CFG_DAC_POST;
+	} else if (hw->mac.type == txgbe_mac_aml40) {
+		ffe_main = S40G_TX_FFE_CFG_MAIN & 0xFF;
+		ffe_pre = S40G_TX_FFE_CFG_PRE1 & 0xFF;
+		ffe_pre2 = S40G_TX_FFE_CFG_PRE2 & 0xFF;
+		ffe_post = S40G_TX_FFE_CFG_POST & 0xFF;
+	}
 
 	if (devargs == NULL)
 		goto null;
@@ -561,6 +578,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &ffe_main);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE,
 			   &txgbe_handle_devarg, &ffe_pre);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE2,
+			   &txgbe_handle_devarg, &ffe_pre2);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
 			   &txgbe_handle_devarg, &ffe_post);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_PBALLOC,
@@ -573,6 +592,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &tx_headwb_size);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_RX_DESC_MERGE,
 			   &txgbe_handle_devarg, &rx_desc_merge);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_BP_CAPA,
+			   &txgbe_handle_devarg, &bp_capa);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -586,7 +607,17 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	hw->phy.ffe_set = ffe_set;
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
+	hw->phy.ffe_pre2 = ffe_pre2;
 	hw->phy.ffe_post = ffe_post;
+	hw->phy.bp_capa = bp_capa;
+
+	/* The 40G PHY expects one FFE byte per lane. */
+	if (hw->mac.type == txgbe_mac_aml40) {
+		hw->phy.ffe_main = S40G_TX_FFE_4LANE(ffe_main);
+		hw->phy.ffe_pre = S40G_TX_FFE_4LANE(ffe_pre);
+		hw->phy.ffe_pre2 = S40G_TX_FFE_4LANE(ffe_pre2);
+		hw->phy.ffe_post = S40G_TX_FFE_4LANE(ffe_post);
+	}
 
 	fdir_conf->pballoc = pballoc;
 	fdir_conf->drop_queue = drop_queue;
@@ -690,7 +721,6 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	hw->isb_dma = TMZ_PADDR(mz);
 	hw->isb_mem = TMZ_VADDR(mz);
 
-	txgbe_parse_devargs(eth_dev);
 	/* Initialize the shared code (base driver) */
 	err = txgbe_init_shared_code(hw);
 	if (err != 0) {
@@ -698,6 +728,9 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 		return -EIO;
 	}
 
+	/* Parsing the devargs requires a known MAC type. */
+	txgbe_parse_devargs(eth_dev);
+
 	if (hw->mac.type == txgbe_mac_aml)
 		txgbe_override_mac_ops(hw);
 
@@ -6478,12 +6511,14 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

