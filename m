Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4CC606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:49:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1126B40A80;
	Tue, 20 Oct 2026 16:49:08 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 27F2740A6C
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:48:55 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B9692000BC;
 Tue, 20 Oct 2026 16:48:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB6932000B1;
 Tue, 20 Oct 2026 16:48:54 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 78802180006C;
 Tue, 20 Oct 2026 22:48:53 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v14-S2 08/10] net/dpaa2: add minimum key size support
Date: Tue, 20 Oct 2026 20:18:39 +0530
Message-ID: <20261020144841.506038-9-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020144841.506038-1-prashant.gupta_3@nxp.com>
References: <20261019183443.176790-1-prashant.gupta_3@nxp.com>
 <20261020144841.506038-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

The default size for a QoS key is 24 bytes. If the key size is
smaller than the maximum, use the default (minimum) key size
instead of always returning the maximum size (56 bytes). This
allows smaller flow tables to be used when the extracted key
fits within the default size.

Support for 24-byte QoS key entries is available from DPNI
version 8.7 onwards. For older DPNI versions, the existing
56-byte entry size is retained to maintain compatibility.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_flow.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 28106a033a..979ab4cae0 100644
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
 
@@ -4519,7 +4522,7 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 }
 
 static inline uint16_t
-dpaa2_flow_entry_size(uint16_t key_max_size)
+dpaa2_flow_entry_size(struct dpaa2_dev_priv *priv, uint16_t key_max_size)
 {
 	if (key_max_size > DPAA2_FLOW_ENTRY_MAX_SIZE) {
 		DPAA2_PMD_ERR("Key size(%d) > max(%d)",
@@ -4529,11 +4532,11 @@ dpaa2_flow_entry_size(uint16_t key_max_size)
 		return 0;
 	}
 
-	if (key_max_size > DPAA2_FLOW_ENTRY_MIN_SIZE)
+	if (key_max_size > DPAA2_FLOW_ENTRY_MIN_SIZE ||
+			dpaa2_dev_cmp_dpni_ver(priv, 8, 7) < 0)
 		return DPAA2_FLOW_ENTRY_MAX_SIZE;
 
-	/* Current MC only support fixed entry size(56)*/
-	return DPAA2_FLOW_ENTRY_MAX_SIZE;
+	return DPAA2_FLOW_ENTRY_MIN_SIZE;
 }
 
 static inline int
@@ -4595,7 +4598,7 @@ dpaa2_configure_fs_rss_table(struct dpaa2_dev_priv *priv,
 	}
 
 	key_max_size = tc_extract->key_profile.key_max_size;
-	entry_size = dpaa2_flow_entry_size(key_max_size);
+	entry_size = dpaa2_flow_entry_size(priv, key_max_size);
 
 	dpaa2_flow_fs_extracts_log(priv, tc_id);
 	ret = dpkg_prepare_key_cfg(&tc_extract->dpkg,
@@ -4690,7 +4693,7 @@ dpaa2_configure_qos_table(struct dpaa2_dev_priv *priv,
 	}
 
 	key_max_size = qos_extract->key_profile.key_max_size;
-	entry_size = dpaa2_flow_entry_size(key_max_size);
+	entry_size = dpaa2_flow_entry_size(priv, key_max_size);
 
 	dpaa2_flow_qos_extracts_log(priv);
 
@@ -4981,11 +4984,11 @@ dpaa2_generic_flow_set(struct dpaa2_dev_flow *flow,
 
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

