Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C0AC982F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:56:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCFEB42E84;
	Tue, 22 Sep 2026 11:55:46 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id B726842D76
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:55:41 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9BDD11A0005;
 Tue, 22 Sep 2026 11:55:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 644B41A0002;
 Tue, 22 Sep 2026 11:55:41 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0B1D018000BA;
 Tue, 22 Sep 2026 17:55:39 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v4-S2 09/13] net/dpaa2: add minimum key size support
Date: Tue, 22 Sep 2026 15:25:24 +0530
Message-ID: <20260922095528.2469885-10-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
 <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

The default size for a QoS key is 24 bytes. If the key size is
smaller than the maximum, use the default (minimum) key size
instead of always returning the maximum size (56 bytes). This
allows smaller flow tables to be used when the extracted key
fits within the default size.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.h |  2 ++
 drivers/net/dpaa2/dpaa2_flow.c   | 20 +++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index f821d2145d..dacbcfed30 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -506,6 +506,8 @@ struct dpaa2_dev_priv {
 #define DPNI_GET_MAC_SUPPORTED_IFS_VER_MINOR	6
 #define DPNI_TX_BURST_LARGE_VER_MAJOR		8
 #define DPNI_TX_BURST_LARGE_VER_MINOR		7
+#define DPNI_MIN_ENTRY_SIZE_VER_MAJOR		8
+#define DPNI_MIN_ENTRY_SIZE_VER_MINOR		8
 
 static inline int dpaa2_dev_cmp_dpni_ver(struct dpaa2_dev_priv *priv,
 					 uint16_t ver_major, uint16_t ver_minor)
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 20835e016f..97b93d8d75 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -26,8 +26,11 @@
 static char *dpaa2_flow_control_log;
 static int dpaa2_sp_loaded = -1;
 
+/* Default size of a key */
+#define DPNI_DEFAULT_KEY_SIZE 24
+
 enum dpaa2_flow_entry_size {
-	DPAA2_FLOW_ENTRY_MIN_SIZE = (DPNI_MAX_KEY_SIZE / 2),
+	DPAA2_FLOW_ENTRY_MIN_SIZE = DPNI_DEFAULT_KEY_SIZE,
 	DPAA2_FLOW_ENTRY_MAX_SIZE = DPNI_MAX_KEY_SIZE
 };
 
@@ -4520,7 +4523,7 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 }
 
 static inline uint16_t
-dpaa2_flow_entry_size(uint16_t key_max_size)
+dpaa2_flow_entry_size(struct dpaa2_dev_priv *priv, uint16_t key_max_size)
 {
 	if (key_max_size > DPAA2_FLOW_ENTRY_MAX_SIZE) {
 		DPAA2_PMD_ERR("Key size(%d) > max(%d)",
@@ -4533,7 +4536,10 @@ dpaa2_flow_entry_size(uint16_t key_max_size)
 	if (key_max_size > DPAA2_FLOW_ENTRY_MIN_SIZE)
 		return DPAA2_FLOW_ENTRY_MAX_SIZE;
 
-	/* Current MC only support fixed entry size(56)*/
+	if (dpaa2_dev_cmp_dpni_ver(priv, DPNI_MIN_ENTRY_SIZE_VER_MAJOR,
+				   DPNI_MIN_ENTRY_SIZE_VER_MINOR) >= 0)
+		return DPAA2_FLOW_ENTRY_MIN_SIZE;
+
 	return DPAA2_FLOW_ENTRY_MAX_SIZE;
 }
 
@@ -4596,7 +4602,7 @@ dpaa2_configure_fs_rss_table(struct dpaa2_dev_priv *priv,
 	}
 
 	key_max_size = tc_extract->key_profile.key_max_size;
-	entry_size = dpaa2_flow_entry_size(key_max_size);
+	entry_size = dpaa2_flow_entry_size(priv, key_max_size);
 
 	dpaa2_flow_fs_extracts_log(priv, tc_id);
 	ret = dpkg_prepare_key_cfg(&tc_extract->dpkg,
@@ -4687,7 +4693,7 @@ dpaa2_configure_qos_table(struct dpaa2_dev_priv *priv,
 	}
 
 	key_max_size = qos_extract->key_profile.key_max_size;
-	entry_size = dpaa2_flow_entry_size(key_max_size);
+	entry_size = dpaa2_flow_entry_size(priv, key_max_size);
 
 	dpaa2_flow_qos_extracts_log(priv);
 
@@ -4983,11 +4989,11 @@ dpaa2_generic_flow_set(struct dpaa2_dev_flow *flow,
 
 	qos_key_extract = &priv->extract.qos_key_extract;
 	key_size = qos_key_extract->key_profile.key_max_size;
-	flow->qos_rule.key_size = dpaa2_flow_entry_size(key_size);
+	flow->qos_rule.key_size = dpaa2_flow_entry_size(priv, key_size);
 
 	tc_key_extract = &priv->extract.tc_key_extract[flow->tc_id];
 	key_size = tc_key_extract->key_profile.key_max_size;
-	flow->fs_rule.key_size = dpaa2_flow_entry_size(key_size);
+	flow->fs_rule.key_size = dpaa2_flow_entry_size(priv, key_size);
 
 	/* Let's parse action on matching traffic */
 	end_of_list = 0;
-- 
2.43.0

