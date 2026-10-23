Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30378606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:09:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F23D940A81;
	Fri, 23 Oct 2026 13:08:27 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 7A7A340B8D
 for <dev@dpdk.org>; Fri, 23 Oct 2026 13:08:24 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753701t0154f15a
X-QQ-Originating-IP: ju3Ifa5Mh/v0J+TccCh6J2BYrN6rSWwP2Z6MPpkahPA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:08:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1250361435624102381
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 12/17] net/txgbe: add pre2 FFE tap and backplane
 capability devargs
Date: Fri, 23 Oct 2026 19:03:50 +0800
Message-ID: <4711A3023DF2FC06+20261023110728.3975-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mfm8HKGnOlI9+rF/jdfOBNXmaw6P162a31HA8408GzjB5x+QB8ISNc0Y
 hEbURsfoVXbIwund4aOAZ6sKtIE2skXlsogoiqRzTdR2Ec1WL5NBgvsagB7PS8mVjlNmGPw
 ai5SscCyAx/BKY3yUywy1Nq4Mg7gh6/vKfdTPb6TpzSImmFCc9qM5sImzo0vTj1jFuUdPot
 TBRr0kcjL42ZKGq4wGn0gbdnsH/we8JasaEfMnVpFhLLfpil5TtMmMUCrhwbQ+9gcVPU6Ib
 dbPcH4jnWe6i1gYeMjXvuaPSHvnTdEcNIUs8p33axLy9QeEVERSNQvb9oXv5R87CtzF18gm
 4JEF615nscROWKaJ0TRBPebagsu8illvI9EhSI0UKmJ5tk8uEh+i3ASyJi75KT6C5POCEAw
 D6Ofjtl7ETIZKo7V1+TWfENEkGHjWz5npc3FaGxju+U3XnX4kj0LQOWYFDBDWLMRSkTQ2CQ
 kbynwOsLto/9MwKJOjmwPjN/oMrzRYOTUw7U3cr/JwITl1l+Cy3bspXwyyoxrxMxT4gXYyo
 RRtyI/WbCLKzhj6HBZ9ok6a5afZuHyxmA0V4gPPr8H9bA7cHe4b2cR7rYcEMDz+E73gTz7F
 7xDRca0j2Hs+y7qo6wCoYG8/mh+7M4vtcBDpxXgqqtNnF6MGfmLRknDiBVXoug3F9M/nTTn
 b5bBJMjIzsUwFo1NCti1S6PdzNF4G/A1XiILlP4W6julkHzJS3jjQxstCsfrat9xA73knGj
 aa8Z6imMcgHAnK4fzeGB/NyvYq2MOa3zl22VOHfTFcA2StnF8kQ9SKJAmfkZ6X3K/p9yLhz
 siq0sgudkgwZj8bVdrT6x9Ffq8lQj7QKtuUK7zxhm8TNf4kOEsEiC1OjriKW6AmYF8W5f4I
 ghVexxTHtSXc99PgZW9+j8etO34k24a8JBkrTeUG4jCrhRHMqSIbQbKo0Rfy+v2KsURNiYt
 Zgeieo9JjZU60tDOF/0f/LEIn6R0AP9qcdUmDRI4c+07bL+5XRVIPRV1BZTJNeIYceLQMfr
 k+cqvR+7YrUqubFKu1JWxg7woqE/n/2Rk5DdbhhH9Wy/zNPqLryVb3MmLp2Irf7RNlyMK9U
 3wIY7jlK77TdEssd147U2PQYO6o1xs5uexrC3akgvn7
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

Also, add range checks for the four FFE taps. The E56 PHY takes one
byte per tap; the Sapphire TX_EQ registers hold the main and pre taps
in six bits and the post tap in seven.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst              | 25 +++++++++--
 doc/guides/rel_notes/release_26_11.rst |  8 ++++
 drivers/net/txgbe/base/txgbe_type.h    |  6 ++-
 drivers/net/txgbe/txgbe_ethdev.c       | 60 +++++++++++++++++++++++---
 4 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 90c55141f1..13f6a0a1fa 100644
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
+  Backplane capability selection for the Amber-Lite 40G NIC. Set 0 for
+  both 40GBASE-KR4 and 40GBASE-CR4, set 1 for 40GBASE-KR4 only, set 2
+  for 40GBASE-CR4 only.
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
index 4529d34ca3..d669fcf116 100644
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
@@ -548,10 +557,47 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	hw->phy.ffe_set = ffe_set;
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
+	hw->phy.ffe_pre2 = ffe_pre2;
 	hw->phy.ffe_post = ffe_post;
 
-	/* The 40G PHY expects one FFE byte per lane. */
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
+	if (hw->mac.type == txgbe_mac_sp) {
+		if (ffe_main > 0x3F)
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0x3F",
+				     TXGBE_DEVARG_FFE_MAIN, ffe_main);
+		if (ffe_pre > 0x3F)
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0x3F",
+				     TXGBE_DEVARG_FFE_PRE, ffe_pre);
+		if (ffe_post > 0x7F)
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0x7F",
+				     TXGBE_DEVARG_FFE_POST, ffe_post);
+	} else if (hw->mac.type == txgbe_mac_aml ||
+		   hw->mac.type == txgbe_mac_aml40) {
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
+	}
+
 	if (hw->mac.type == txgbe_mac_aml40) {
+		/* S40G_TX_FFE_4LANE() keeps the low byte of each value. */
 		hw->phy.ffe_main = S40G_TX_FFE_4LANE(ffe_main);
 		hw->phy.ffe_pre = S40G_TX_FFE_4LANE(ffe_pre);
 		hw->phy.ffe_pre2 = S40G_TX_FFE_4LANE(ffe_pre2);
@@ -6474,12 +6520,14 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

