Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63A6CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:07:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A7D842DC1;
	Tue, 29 Sep 2026 15:06:50 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 1188742DCD
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:06:46 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687202t115e4385
X-QQ-Originating-IP: 5cKUqGKovAUN+yhj7OlA/DCa6mTjXyCwqhE1wFVcvdw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 745310876189187396
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 12/15] net/txgbe: add pre2 FFE tap and backplane capability
 devargs
Date: Tue, 29 Sep 2026 21:04:43 +0800
Message-ID: <4BF3B56D06B968B6+20260929130611.4871-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NJ8/SpgTWw4zvGut1jmXZ3PxfzxmxazAkgeVPAqHvBpS7fpXI0Z7eXQ9
 S4tzK17a4KfWJ0mN0oV0rj+1KLIDXxPVOyv+zM43mGrl1IU1xt973PHijpiFdgMswcVEG3z
 CbZkB1xqW2PWP07zIxHvyB2nUWjTCocv5MKJ0+2pTYaSHEyFEtBQ8GYLZS3GJajvq+HqwVk
 ANl+yhlhkfJXGREkxmlZtYMPpYIzK+NyA0swkMlwlbsyAgBfiZo1su0zD6IxZa249ydAGKf
 ab6xC7MLyl7K/phL7c4BKsjbBxuwVRFQXCvTzNzRGBtAA/tqHW+jB16fO4i5Tbsutq+1/Sx
 9XrTSTOA/D97V8zv6mHPPMZvfhpxx5uo5CAgWmYzJefNXXlgsrL24ZRvkdBgLxyxEU5z3Mq
 ahmwoOySeTChJb0nX1p7l1WnbNy6W34cZNKvc15ZjeGJ+SpIY2hn22j0AbhGdb0deGYN8/x
 fcYHITAzoMpIQXUgiI1SATuf6RPKZY1wJ+OSt03poT9TkZZuWhztzpLl9dANQ/FBBVgg0Rw
 9lqI9qD9q2fCrtUcUZpzOmpbuh2WTHVnyjfiuupgOWX1rhhVlnG556wMJrpPCEoE+OdwUh5
 UjAz4ohwSGe5hGU0GO6iIfKoxHW2372h2yuW4GakXK1gNeFl7YmikMOgcgOlPtDm86u/7xI
 gJGKxgLV8ESMWMpm9ZD7TeTHU2UyWY33/UikkwxqJq1RyoBpTzPdQnsZk4KbGiNu1uHH+E6
 eMtrKXI4AUtOXcXysjR3oLG4UYRR7t0QyvKv9MPcOY9GLkdjrkjIp/KQ6tAnZoQRKpkI2b9
 F2RCrEVlrrM8BsUrb6OkQCfjil9ohNEpWDHP9/7bLHQ5oLs43vNFVGM/4RxT0mThFMPZGdD
 LdOxKgG+W7oapBVFBDhS3U/NNchsdT+88JrU+F3U0o2jzkv1gP/eZI5qVOsBaPTssR2NsFk
 4Wm65wNhVFfvvHpynrk1QnDIa9YZl6EgDF0tan64LwSqLEl0Ri/Wog/Fa+iuS3C5F5mCPWY
 lhYSJ5dlX3YuR7NnJzXzgDYmeDUIJQOyjpQEfCl0uwipbA39bedqcGEg+gdxQWIKbf5Ufds
 UWp5XsHslDBjdCDWr7E5GdvDhYOnlOnGqu2/A11X7KT
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

The Amber-Lite E56 PHY has per-MAC FFE defaults that differ from the
Sapphire defaults. In particular, the second pre-cursor tap defaults
to zero, but callers need a devarg to override it when ffe_set is
enabled.

Add ffe_pre2 for the E56 second pre-cursor tap, and bp_capa for the
40G backplane advertisement selection. The latter supports the
existing default of both KR4 and CR4, or either capability alone.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst              | 18 +++++++++++++++---
 doc/guides/rel_notes/release_26_11.rst |  8 ++++++++
 drivers/net/txgbe/base/txgbe_type.h    |  6 +++++-
 drivers/net/txgbe/txgbe_ethdev.c       | 23 +++++++++++++++++++----
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 90c55141f1..61766cc4ac 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -132,17 +132,23 @@ Please note that following ``devargs`` are only set for backplane NICs.
   If disabled, the FFE parameters will not take effect. Otherwise, set 1
   for SFI mode, set 2 for KR mode, set 3 for KX4 mode, set 4 for KX mode.
 
-- ``ffe_main`` (default **27**)
+- ``ffe_main`` (default **42** on the 25G Amber-Lite, **43** on the 40G
+  Amber-Lite, **27** otherwise)
 
   PHY parameter used for user debugging. Setting other values to
   take effect requires setting the ``ffe_set``.
 
-- ``ffe_pre`` (default **8**)
+- ``ffe_pre`` (default **3** on Amber-Lite, **8** otherwise)
 
   PHY parameter used for user debugging. Setting other values to
   take effect requires setting the ``ffe_set``.
 
-- ``ffe_post`` (default **44**)
+- ``ffe_pre2`` (default **0**)
+
+  PHY parameter used for user debugging, only for the Amber-Lite E56 PHY.
+  Setting other values to take effect requires setting the ``ffe_set``.
+
+- ``ffe_post`` (default **17** on Amber-Lite, **44** otherwise)
 
   PHY parameter used for user debugging. Setting other values to
   take effect requires setting the ``ffe_set``.
@@ -177,6 +183,12 @@ Please note that following ``devargs`` are only set for Amber-Lite NICs.
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
index dec96ccbc7..53da0dc66c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -134,6 +134,14 @@ New Features
   * Changed the set of per-queue xstats counters.
 
 
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
index db773a1b9a..cd54b696b4 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -492,13 +492,20 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
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
 
@@ -523,6 +530,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &ffe_main);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE,
 			   &txgbe_handle_devarg, &ffe_pre);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE2,
+			   &txgbe_handle_devarg, &ffe_pre2);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
 			   &txgbe_handle_devarg, &ffe_post);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_PBALLOC,
@@ -535,6 +544,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &tx_headwb_size);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_RX_DESC_MERGE,
 			   &txgbe_handle_devarg, &rx_desc_merge);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_BP_CAPA,
+			   &txgbe_handle_devarg, &bp_capa);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -548,7 +559,9 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	hw->phy.ffe_set = ffe_set;
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
+	hw->phy.ffe_pre2 = ffe_pre2;
 	hw->phy.ffe_post = ffe_post;
+	hw->phy.bp_capa = bp_capa;
 
 	/* The 40G PHY expects one FFE byte per lane. */
 	if (hw->mac.type == txgbe_mac_aml40) {
@@ -6481,12 +6494,14 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

