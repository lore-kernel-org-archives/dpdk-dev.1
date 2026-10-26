Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B937606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:28:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A94EA40659;
	Mon, 26 Oct 2026 13:27:23 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTPS id 5DF724064F
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:27:20 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017633te6e73554
X-QQ-Originating-IP: 4PKNdZrbHZ9JRRFU3PVcXouLEXiCToCtLvoXkEz6SS4=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:27:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10141645127357969619
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 12/17] net/txgbe: add pre2 FFE tap and backplane
 capability devargs
Date: Mon, 26 Oct 2026 20:21:58 +0800
Message-ID: <06F55888161DB9D8+20261026122638.9198-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MprXaYuKirmTfZZwQn63ts0zCw+PJ1WMhyNpWyevlFVXn/725BN0yRtp
 H0uOTZg3deaHjbUU8DiiUBPR19EasPxK6Bkhe/Ch+iJeQlWNHTOSMPky023QVBlPaFdXNFq
 4M6t7WNBeXSMM8MDu/b8zda3QUhZoSYIJ68FLc5o48OanpVZMIU5HdHP0xxehOy9NG8syHX
 MaBBoEXvvNaK90Mmxhz7l7iauRd05PmoKfCjpDse7EQIMd6CG/l1ycUoyEjrWfcSpTZyQC5
 uq6P/zxsajoVb79oMCT/NeFbsa9j8KiA3D4ToVHj1lCEEZgxT5b8MHuxIGfyAzY6+bNDd/Q
 R8jtYAxPBrclwBwoUDzyP96oMs/Kc8ycSfAR/3mUwkCcPBZkcMMSFLv/f0C1jEw/ohZEBa+
 JPP24Sj9hOi2naDv/KJSvp999pezRTek1vsxe5PzzNclmviAPcfL0s8TB1LYz3Bdudn5YpV
 Yf+sBGArK+Y6HP/FYue/9BVWTv/Pl4ix8qmIPDixU8Sx2FpLHGbg4XYjpGyWwdqg7eh2Fcp
 tFcyHo35olvcuuifM62asI9NlaHQXZAFRY6XP/PvBSq7Fc9Cyeu3a0TP7YtZ4TjNrVMOY6L
 v83mpD5ksrpBKODDBZnGLCOYeSWgxRBwuyTrpXWEbuNMstp9AdVswhxWgOpiKf9UDRRSYhP
 /whlT0dcIk7lAnkeTOf6hZ1ohfzpa3cfdAc9IjGbrX0H4SlVCKTeXKVRKzJl+EAehN1f68q
 p0uuxg2xhKd/pGKs6zn+i/B9jvqk7C2d53wovGXueRBysFMrTuPivhB72+n/COxkJmMUb+/
 1EG9otGzj12D91qshriiOpHtzVS9z3OPEixx5oUqSlyul8lShw7xQHy5QFGELEP4DBwh6ER
 02IlFt/6rVjuC2MZ9JbxUroRJ2N67UtEj8rMYoWpL1e27yHZVjE1IPufSXWoP7hglT1tMaW
 NBrA1RTtixYBh8hNnl7UiMuj6r8X1sU+YD7L/Nv1isbjywnPWx+zSvQGVGu3Com0GrrPlkT
 /ljODy4EP2RtS51Hmzbmm2C65Qn42prDRaicMcdvzEx9AxZdNQIi/fGUw3lMQZRgCzBZhUW
 Ui9cYGFyQS7ke+79F6lR5qe4/Za+ZMQ735qe/VcHyVM
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
 drivers/net/txgbe/txgbe_ethdev.c       | 84 ++++++++++++++++++++++++--
 4 files changed, 113 insertions(+), 10 deletions(-)

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
index 4529d34ca3..0e95643239 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -485,6 +485,10 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 ffe_pre = 8;
 	u16 ffe_pre2 = 0;
 	u16 ffe_post = 44;
+	u16 ffe_main_dflt = 0;
+	u16 ffe_pre_dflt = 0;
+	u16 ffe_pre2_dflt = 0;
+	u16 ffe_post_dflt = 0;
 	/* FDIR args */
 	u16 pballoc = 0;
 	u16 drop_queue = 127;
@@ -492,16 +496,26 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
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
 
+	ffe_main_dflt = ffe_main;
+	ffe_pre_dflt = ffe_pre;
+	ffe_pre2_dflt = ffe_pre2;
+	ffe_post_dflt = ffe_post;
+
 	if (devargs == NULL)
 		goto null;
 
@@ -523,6 +537,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &ffe_main);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE,
 			   &txgbe_handle_devarg, &ffe_pre);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE2,
+			   &txgbe_handle_devarg, &ffe_pre2);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
 			   &txgbe_handle_devarg, &ffe_post);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_PBALLOC,
@@ -535,6 +551,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &tx_headwb_size);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_RX_DESC_MERGE,
 			   &txgbe_handle_devarg, &rx_desc_merge);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_BP_CAPA,
+			   &txgbe_handle_devarg, &bp_capa);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -545,13 +563,65 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
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
@@ -6474,12 +6544,14 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

