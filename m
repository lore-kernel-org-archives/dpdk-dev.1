Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DE8C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:42:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E914F410D3;
	Tue,  8 Sep 2026 14:41:32 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id A052040E28
 for <dev@dpdk.org>; Tue,  8 Sep 2026 14:41:30 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871286t7a60a3d0
X-QQ-Originating-IP: e7emqSDIgzlXubG1i1Z+nIWQmtM6PKGXctcYKArTU8M=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:41:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4055652423325996123
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 12/15] net/txgbe: add pre2 and backplane capability devargs
Date: Tue,  8 Sep 2026 20:38:57 +0800
Message-ID: <C437583106BEFCA2+20260908124047.2284-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OfSaI56XD7hZgsfu10rtqDR37u7FUyVfzyjrqUSS33pnGAEGiUqN2IFx
 yqDUHolTJmrKDqYXa0k+jtdWwwt5R6OPoxSWKy6OzNYbqLodlI70lriLTZQNauX2DfOLTnc
 H95+HLzXwWes8H/LyE4jOYMJ7DhL2ZP0JzIXrAgQIqiYxD90QSd/JZIM8jaXEJVEL+Nwqp4
 EG45/cNxBf+k534bMGGzEy73sil213y0xdvYXbRhoYYbKCNrCmULHNp2mwIT/CNO3KctJp0
 GuSoM5F1V6GOK5ajGs1bStX6rCugLXtwrR2yTHQ2yOlawHKSKxMVJ7/gwm3pSdgVbT0kQ7g
 NV/YFSSbGw0cKbgrE4DUQtyn4W2tJbQp4MvSLYkkfnpI3MmDPQ4oIugbAxU5PlatSLy0/ww
 1/s5eRlt3jTmfptSfwXv1pGgfdQhcV8/NrUXc/PYecqZiIbjOb1q9WdA1tIOxC+rpC6wSec
 92L1noHnI2kMQmrgc8gvuiDQV0WwDb7JcEHlptW3gCy6S4FKPCfgKG5LpprK0KpTRdeIrM6
 GVlL0EbOYKQ7u7B5CzLL2nkSj/2hAp+7lr7GwBldTDqZNN4jsiA8KipB0H52nitLGK7RYSQ
 3DVy6RfpkDzmkuSmSWnJhDMc+fCqhwr/zxujIdSwLh78h/EHouWck2TQPtGZXxh4bkCXEYz
 x8Y853mYLuggmpQQyHBEiCT/hAklCGLHj6vhLBaL4P8ghfBpmqzoUiUQYVLd37NscflH/Nv
 2oPWTeFUdJF2VvwHay1SnKkQ2TK3Q2ZUWS1MA5KelvINLLeVa0d20QWkkoBGGLxavWP++TG
 Ss7/7kMv9nZHzTsXPsaxPKvoBdussifayM1vB7rCCmpNm6p1z6pA8V1W93IxwrfCrZywSWE
 ywyPQMMIMP2ZeHlk0PRSJP8CpK9pL/f9Ru9S2TwHtOJsxzV8ZB95hGZry6f1jRw5/pv4jfi
 1UHTPoIdnPI1bAZTvEwgigsIA++6fuRv8porP9+e22FrH2Ih9i5YPODjtJksJ32ZDLFSAhT
 kPkoS3ZjhGzNTO0naUUpJZHiE7e8llBL3qnNbGXWFupdEcG0/mOusWhVFcVFhuJWBypQi2/
 DQf8lHhhSGZEpZB62d2msktgIySY+1FTiGSqJLQnLiRRPZwRNm1JjVBBnYlcEII8NQ2ZiTv
 nQT8
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

The 25G E56 PHY has a second pre-cursor tap that cannot be tuned
with the existing devargs: with ffe_set enabled, pre2 stays at the
default value because no devarg feeds it.

The advertised 40G backplane capability is hardwired to KR4+CR4,
so there is no way to advertise only 40GBASE-KR4 or only 40GBASE-CR4.

Add the ffe_pre2 and bp_capa device arguments. ffe_pre2 configures
the E56 PHY second pre-cursor tap, bp_capa selects the backplane
capability advertised on the 40G NIC, and both are documented in the
NIC guide and the release notes.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst              | 11 +++++++++++
 doc/guides/rel_notes/release_26_07.rst |  5 +++++
 drivers/net/txgbe/base/txgbe_type.h    |  6 +++++-
 drivers/net/txgbe/txgbe_ethdev.c       | 23 +++++++++++++++++++----
 4 files changed, 40 insertions(+), 5 deletions(-)

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
 
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 3d18ba2dd0..f65044c9b9 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -163,6 +163,11 @@ New Features
     so the application can reset the VF and resume normal packet Rx/Tx.
   * Added VF support for the Amber-Lite 40G NIC variant,
     with new device IDs ``0x503f`` and ``0x513f``.
+  * Added the ``ffe_pre2`` device argument to tune the second pre-cursor
+    tap of the Amber-Lite E56 PHY (requires ``ffe_set``).
+  * Added the ``bp_capa`` device argument to select the advertised
+    backplane capability on the 40G NIC
+    (0 for 40GBASE-KR4 + 40GBASE-CR4, 1 for KR4 only, 2 for CR4 only).
 
 * **Updated Intel qat crypto driver dependency requirements.**
 
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
index afed59d4cf..27a6ff0b2e 100644
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
@@ -6498,12 +6511,14 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

