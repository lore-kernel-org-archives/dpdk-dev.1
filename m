Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC458606A31F
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:11:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7448040BA3;
	Thu, 22 Oct 2026 13:11:07 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id EE69D40689
 for <dev@dpdk.org>; Thu, 22 Oct 2026 13:11:03 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667459t6e1e0405
X-QQ-Originating-IP: 93Iq5M5iAgaJgUs5GbAcPqRnmp1SyGOO2INy54tiq6c=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:10:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11873613499446895921
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 12/16] net/txgbe: add pre2 FFE tap and backplane capability
 devargs
Date: Thu, 22 Oct 2026 19:03:18 +0800
Message-ID: <9BD1080D88EF6493+20261022111017.3605-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NChuY+V9daHbaJlYsAX/TKQqxoI12QPRhiMnU3FPR80a7auEXckqrsik
 QCIbpoXeS32RdouUEQd3/aGIA6WLD+CW/aigvRNtaNd65YlRkIVg/rngCViWR9+yCwoH8Qp
 76uKT8pzkUsMpllUo9yCJgUKM6iA4TeQxx/nksspHy2t+7YI+5fYvIv2Chkwy8Ba+T7NI9p
 UKH8fMUN8Az+53IZnK5PY+DaTthQP3uRiEDcVp8j+6zBexCZySC0KR0q2W5E9asOOivvbzg
 2RuozRJp8LjLgl00ooLysZF3t3wXdYC1hmTcgsZ0JGaU27rQ39lbn84TK7E+WkyP/7JeSwt
 LhQvjGJ9Le+SsWH4ItG0jpIkUfCnhC40CeWlXFOLkCFsMkU0TkfwriwSDlJkcM6lYmLsaxF
 oSzc2UZmlsRas+gNnEpD+LEvYeyQQYkeSuqG5X+5f77s0v2jCV2UpT0RINParPxArtS0xEL
 1qNmU4L5+fWjiI2gz6eoZT6ilWGXpbEjeDQzcUqIsJJEnn4WG6+Z6aTuTFk2QLsroaS2oVU
 7H/DslMb+ZaQSE3+AeV6SU30hxOfebu5q0lmSPsDrjw/nwx/oaKXyy1zeqmicK/ek41NoBK
 W8RrgFDrucqkkMyuXklg8F6IxZmgyGdhmEoeqIi34wvvN32It0nkkQ9EkBsHOEB0L9n6Km6
 Ow0CGqBLQ9UrII+PtOAcdU98an2pA1mIyH4gmkQ0DkziFIv2Rf1tphI6zjqg6wg2HGDmRF/
 eo4QzNf3kbrRTNkFH/Tx594xo56/vnxWfYKh0+t7AVHFT1/E54JJIXmjW0z+R37DlBGQCDi
 PS45MLtw3cpDlExVZf1iW+VwTAwFA67o/uHrMn0xET2iHNNJN9PSXyAmFzPlJgLg6mCWWE6
 hTaXl++8qgk7G/dz24MaPcRmhDhacHGOG+9ADbyXYJGJhXQe+xqx7jU2YIcCxt0514ToA4k
 53wXUUv1iVWlWrNB8LP3Kydqcs/pmsl6Jh7wT1hqfJVToFXgRnqtRW2cpd0EQL8GQWdC5AO
 WcAeJv8cNZKJUAHY8VvQAH6o2fu7pMTa93YgxE/jxcQXGPLk9teY5A04xJB5XGh4bk57Dex
 0BTXwYVAwlz
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

The Amber-Lite E56 PHY has per-MAC FFE defaults that differ from the
Sapphire defaults. In particular, the second pre-cursor tap defaults
to zero, but callers need a devarg to override it when ffe_set is
enabled.

Add ffe_pre2 for the E56 second pre-cursor tap, and bp_capa for the
40G backplane advertisement selection. The latter supports the
existing default of both KR4 and CR4, or either capability alone.
Some switches do not reach the mode the board is wired for when both
are advertised, and then the NIC has to offer only one of them. The
subsystem device ID cannot decide this: it only separates a backplane
assembly from an SFP assembly, with no KR4-only or CR4-only value.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst              | 25 ++++++++++++--
 doc/guides/rel_notes/release_26_11.rst |  8 +++++
 drivers/net/txgbe/base/txgbe_type.h    |  6 +++-
 drivers/net/txgbe/txgbe_ethdev.c       | 46 +++++++++++++++++++++++---
 4 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 90c55141f1..0f5b48683d 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -126,27 +126,40 @@ Please note that following ``devargs`` are only set for backplane NICs.
 
   Special treatment for KX SGMII cards.
 
+The following ``devargs`` override the transmitter equalizer taps.
+``ffe_main``, ``ffe_pre`` and ``ffe_post`` are used by the backplane link
+tuning and by the Amber-Lite E56 PHY; ``ffe_pre2`` is used by the E56 PHY
+only.
+
 - ``ffe_set`` (default **0**)
 
   Use to set PHY link mode and enable FFE parameters for user debugging.
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
 
+The following ``devargs`` configure the flow director.
+
 - ``pkt-filter-size`` (default **0**)
 
   Memory allocation for the flow director filter.
@@ -177,6 +190,12 @@ Please note that following ``devargs`` are only set for Amber-Lite NICs.
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
index be758a0c02..7b6bf917a0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -200,6 +200,14 @@ New Features
 
   * Added VF support on AMD Solarflare X45xx adapters.
 
+* **Updated Wangxun txgbe driver.**
+
+  * Added the ``ffe_pre2`` device argument to tune the second pre-cursor
+    tap of the Amber-Lite E56 PHY (requires ``ffe_set``).
+  * Added the ``bp_capa`` device argument to select the advertised
+    backplane capability on the 40G NIC
+    (0 for 40GBASE-KR4 + 40GBASE-CR4, 1 for KR4 only, 2 for CR4 only).
+
 * **Updated ZTE zxdh ethernet driver.**
 
   * Added a fast single-segment Rx path (``zxdh_recv_single_pkts``)
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 60298800ee..d65a50530f 100644
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
index 4529d34ca3..909457c536 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -492,13 +492,18 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 tx_headwb = 1;
 	u16 tx_headwb_size = 16;
 	u16 rx_desc_merge = 1;
+	u16 bp_capa = 0;
 
-	/* The 40G NIC holds one FFE byte per lane, so the E56 PHY defaults
-	 * below are later replicated over the four lanes.
-	 */
-	if (hw->mac.type == txgbe_mac_aml40) {
+	/* The E56 PHY has its own FFE defaults; the ones above are Sapphire. */
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
 
@@ -523,6 +528,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &ffe_main);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE,
 			   &txgbe_handle_devarg, &ffe_pre);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE2,
+			   &txgbe_handle_devarg, &ffe_pre2);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
 			   &txgbe_handle_devarg, &ffe_post);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_PBALLOC,
@@ -535,6 +542,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &tx_headwb_size);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_RX_DESC_MERGE,
 			   &txgbe_handle_devarg, &rx_desc_merge);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_BP_CAPA,
+			   &txgbe_handle_devarg, &bp_capa);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -548,10 +557,35 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	hw->phy.ffe_set = ffe_set;
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
+	hw->phy.ffe_pre2 = ffe_pre2;
 	hw->phy.ffe_post = ffe_post;
 
+	/* The 40G backplane block takes 0, 1 or 2; any other value leaves
+	 * it advertising nothing for 40G.
+	 */
+	if (bp_capa > 2) {
+		PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 2, using 0",
+			     TXGBE_DEVARG_BP_CAPA, bp_capa);
+		bp_capa = 0;
+	}
+	hw->phy.bp_capa = bp_capa;
+
 	/* The 40G PHY expects one FFE byte per lane. */
 	if (hw->mac.type == txgbe_mac_aml40) {
+		/* S40G_TX_FFE_4LANE() keeps the low byte of each value. */
+		if (ffe_main > 0xFF)
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0xFF",
+				     TXGBE_DEVARG_FFE_MAIN, ffe_main);
+		if (ffe_pre > 0xFF)
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0xFF",
+				     TXGBE_DEVARG_FFE_PRE, ffe_pre);
+		if (ffe_pre2 > 0xFF)
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0xFF",
+				     TXGBE_DEVARG_FFE_PRE2, ffe_pre2);
+		if (ffe_post > 0xFF)
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0xFF",
+				     TXGBE_DEVARG_FFE_POST, ffe_post);
+
 		hw->phy.ffe_main = S40G_TX_FFE_4LANE(ffe_main);
 		hw->phy.ffe_pre = S40G_TX_FFE_4LANE(ffe_pre);
 		hw->phy.ffe_pre2 = S40G_TX_FFE_4LANE(ffe_pre2);
@@ -6474,12 +6508,14 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

