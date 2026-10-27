Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F0606A9F5
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:43:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 362EA4067B;
	Tue, 27 Oct 2026 12:42:56 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTPS id 8006A400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 12:42:50 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101366t5fdf8ccd
X-QQ-Originating-IP: tAjc2FRaiRhnJHBIQ1Tx17yf4BfYRZWKAVHlUkKTMvo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13924765603995703763
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 12/17] net/txgbe: add pre2 FFE tap and backplane
 capability devargs
Date: Tue, 27 Oct 2026 19:38:28 +0800
Message-ID: <7211E51D8D385CBF+20261027114218.9724-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mg90GDIyb2xWfS21NBJgSstWZy1oLcSQjPCt7tYGoX9W/8GmRXDjCsl3
 5yuelw2bkqDE/a8dBcM/eRWJcawK0vquxDcdom+FEeobUyTMaK/KcXlewvFrqAUs2O2T4q0
 nNJGsDlFXh9dgaHNhW9yX/C2bJcoYsmbwTGNb3NSLlSYmD6oBroMYqdXnbU5SnHdj1dKolt
 If48qFd9KhU9rJ/141SN2g6TZoF/1Yl+Qy97UF8qBRQVul0Z6111zMjx5fjYVHQWPHMIqNf
 nbyHrV4paaOGx/nhrDc2XLg2uIWweeZ5BTw6lJ4ulnDpPDjKfGvFXqkfv3jGGRpWQDv8gEo
 lPb9/ukZH9pvRQpa9saa3nQom+adifvRd7Xc61IQREeZWj+eXhlSaKPlUGyYuE2OdPGFcJk
 IDq0uuEnk1mazTfarBWTFBvAUVwBTaTh+yDnCyHh+JwWZrIC87nxbq/CoD/RqHwcZq9Dvs7
 WtrxpJx/K5N2gPw0YYXse5JQwonbvhJYQcU68qu25Tm0TIkCdqSKYtCj1Q0j9q2RutlQyyH
 BfhBpnucNfTVKGCKI5jEcK/PNC6LTpnx5IFnR4Mode8hniDJDh/NCHrGI46PTnz5K0X6bCy
 qe820/QwkxMh6+ddLY8qX8UgRgov1PG6ELSF03wLuJaeotdNCEU02Ww0L8CZnQe0vBYQbi2
 LLeY0JtA29sN1XUyk6eD+Vp7R5zzbYTmzdGFCKTk0lbwaiirdvougtK0BqJuUSqJltaMkoi
 8fGLHg4WIOh3IEohHPTV0vKmXXek435OTXuoNRy2yRXn9iz9lq+k6efvxRV/B3IcD90qppC
 Kzlw7uALgvTve/Op0q61sMgLLls5EdMFhW+S62mVmSutGcz26LCH2UJf8oCc++A1BKjkFB6
 saqn6fs86fhOfgIahcWB5s3J2annKin2pf5SpBv55yY6nAM65uFP+CngmPgL/GInKteDwCA
 iWlBy5mywYs7lQdtA913XzgmiBKFNdF9SVImdChy1iPnV5HjOnDFDeB5F6i7AG5zwd43dBY
 C3TjEvxrijdpv2Alison5zkSizBYfRNpuXfAGHhNwUb0KMBRI9t5J13dyNKtK+arwQQwJ+o
 3SHSzpbMM+F0SATB2bqXAphnZ7l6wpKHoZJWIsklzpn5CumTBM7d3Q=
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
in six bits and the post tap in seven, so a larger value would spill
into the neighbouring field. Such a value falls back to the per-MAC
default.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst              | 25 +++++++-
 doc/guides/rel_notes/release_26_11.rst |  8 +++
 drivers/net/txgbe/base/txgbe_type.h    |  6 +-
 drivers/net/txgbe/txgbe_ethdev.c       | 80 ++++++++++++++++++++++++--
 4 files changed, 109 insertions(+), 10 deletions(-)

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
index 4529d34ca3..541e7ca84f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -492,16 +492,26 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
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
 
+	u16 ffe_main_dflt = ffe_main;
+	u16 ffe_pre_dflt = ffe_pre;
+	u16 ffe_pre2_dflt = ffe_pre2;
+	u16 ffe_post_dflt = ffe_post;
+
 	if (devargs == NULL)
 		goto null;
 
@@ -523,6 +533,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &ffe_main);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE,
 			   &txgbe_handle_devarg, &ffe_pre);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE2,
+			   &txgbe_handle_devarg, &ffe_pre2);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
 			   &txgbe_handle_devarg, &ffe_post);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_PBALLOC,
@@ -535,6 +547,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &tx_headwb_size);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_RX_DESC_MERGE,
 			   &txgbe_handle_devarg, &rx_desc_merge);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_BP_CAPA,
+			   &txgbe_handle_devarg, &bp_capa);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -545,13 +559,65 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	hw->devarg.tx_headwb = tx_headwb;
 	hw->devarg.tx_headwb_size = tx_headwb_size;
 	hw->devarg.rx_desc_merge = rx_desc_merge;
+
+	if (hw->mac.type == txgbe_mac_sp) {
+		if (ffe_main > 0x3F) {
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0x3F",
+				     TXGBE_DEVARG_FFE_MAIN, ffe_main);
+			ffe_main = ffe_main_dflt;
+		}
+		if (ffe_pre > 0x3F) {
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0x3F",
+				     TXGBE_DEVARG_FFE_PRE, ffe_pre);
+			ffe_pre = ffe_pre_dflt;
+		}
+		if (ffe_post > 0x7F) {
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0x7F",
+				     TXGBE_DEVARG_FFE_POST, ffe_post);
+			ffe_post = ffe_post_dflt;
+		}
+	} else if (hw->mac.type == txgbe_mac_aml ||
+		   hw->mac.type == txgbe_mac_aml40) {
+		if (ffe_main > 0xFF) {
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0xFF",
+				     TXGBE_DEVARG_FFE_MAIN, ffe_main);
+			ffe_main = ffe_main_dflt;
+		}
+		if (ffe_pre > 0xFF) {
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0xFF",
+				     TXGBE_DEVARG_FFE_PRE, ffe_pre);
+			ffe_pre = ffe_pre_dflt;
+		}
+		if (ffe_pre2 > 0xFF) {
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0xFF",
+				     TXGBE_DEVARG_FFE_PRE2, ffe_pre2);
+			ffe_pre2 = ffe_pre2_dflt;
+		}
+		if (ffe_post > 0xFF) {
+			PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0xFF",
+				     TXGBE_DEVARG_FFE_POST, ffe_post);
+			ffe_post = ffe_post_dflt;
+		}
+	}
+
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
 	if (hw->mac.type == txgbe_mac_aml40) {
+		/* S40G_TX_FFE_4LANE() keeps the low byte of each value. */
 		hw->phy.ffe_main = S40G_TX_FFE_4LANE(ffe_main);
 		hw->phy.ffe_pre = S40G_TX_FFE_4LANE(ffe_pre);
 		hw->phy.ffe_pre2 = S40G_TX_FFE_4LANE(ffe_pre2);
@@ -6474,12 +6540,14 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

