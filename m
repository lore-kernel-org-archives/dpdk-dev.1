Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A2FC79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:29:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5080640E45;
	Tue,  8 Sep 2026 15:28:21 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 03C4540E39
 for <dev@dpdk.org>; Tue,  8 Sep 2026 15:28:18 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874095t5b344b62
X-QQ-Originating-IP: crjobEv16lJRpPss84H7/Wz+boUSz6TyTX1cHHrJ0jk=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:28:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6576659414566841770
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 12/15] net/txgbe: add pre2 and backplane capability devargs
Date: Tue,  8 Sep 2026 21:25:57 +0800
Message-ID: <1C58BB000776E8F7+20260908132742.2661-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MU2EjfY/Pbb+Ue5Kkz2qjjW8z6gOPbK0bhCEqMrJDHx7AKZAjhCOhiY/
 7XIbpwdlZHHYsUsItc9gsLnQdMu/PrMqKZ9UzVuj6fNxb98r+evYrDrTEeZ8UPzhxbbDK3n
 v0oebprdAwA5Sy9FIgjLY0LsdJWb1qAciA8GeWTB8W5hs9Vxo1mCLq0Rm/67GGn2bw9faCy
 yLHSDnpp1FSpBEHWHXf4Q68ojQZjcV7/rhhUyetUv1VDuDofZdQxYTMHeEN9+AmE7OvgIi3
 LrUUgWEBEr9kJZiPGP0cg2WlLBCUq7OpPryCiXjFf08IrT8qb36MjoJd4lrOSH1cvQ1Bx+F
 /9AzGTx3OwfjfLvTkutYWPAi7ztrXIZtfsQiuJiXJJgYP1jOakly2dYs3xRTbp2KO9cbS2a
 dH3bOoM8Pn2B3wl1gXvxKolzuH65UPLTI0bgKNX9/KWDfcb/5CpFBB5xJA0Pid3CJ72kEPS
 4KiXtB8/noVGSCE5iaLQnAQ9cityQ0bPsx9EX8ESRgwUfKxCMN+c3RTA0rULhEF1daX/pTG
 /HZeoeBsZwgvDA3KQAwJ1G80sKzfPTwZF9BS6Tjtv/q2uPWoHEJ3JVNwqGVNrM5zQ1VsRnU
 emnRh1h0lhR1ufyEWMuyv1flFEqSPQNr/FNG5+6iwYLR1ZlzKTe6FAV8dc7+a7nrCjr2dt7
 8vPS5JC99y2jdXrtozOhG0wxvDCxYmedAqlgU5xK6FyroKRSLd2Dn6q49up3zjKg9jt8T9W
 qomiozL3/D0IzH7+C5WcXt70D2QvbauESbduS1k4dCOnruANG8ndtz9pyrljvpz4HyEcDv5
 Ezz6jGdVoMrLEv2qAw/kjGjSVDCs1MtcOxSdwUXofTW5N76Fx83EuHllw+Va54uw5Y39CyV
 FXhejyasZxiyyjX7eifWT6trhc9eFBeBHJNeUg2MHKmljgQmZUHt44r7D1tjO5uIEQyc6Bq
 Ba7+XuTOTWxntbViXx/Wg6RXG5z/2u2PL6rNgDCe8OkZTb2p5YtOU9zrb7a00j8PVvmQX+h
 H6XlRJPWkmDwL63U2wwvqggsKBS2ETiP+iz33tPsKC0OeChHw2BXKwnv3n4Lctibo62gA6a
 oSQfxJwnRtLBTpquuW4ceBnWY8X/pNJnxivHba8ZR7A56+r99zHju2Q6eHsTMjWeQtx2ZB0
 nvqFAYeiRVeJA34=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
index 87c7e81bde..822cd36d20 100644
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

