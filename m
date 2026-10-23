Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F1606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D20AB40E42;
	Fri, 23 Oct 2026 15:44:26 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7AB3440E18
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:17 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DE5F1A0021;
 Fri, 23 Oct 2026 15:44:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 276861A003D;
 Fri, 23 Oct 2026 15:44:17 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F154618000BA;
 Fri, 23 Oct 2026 21:44:15 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4-S3 23/65] net/dpaa2: expand IP address extracts for RSS
 hashing
Date: Fri, 23 Oct 2026 19:13:03 +0530
Message-ID: <20261023134346.37727-24-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

When RSS distribution is enabled, hashing on an IP source or destination
address should cover both the outermost and the innermost (last) IP
header so that tunnelled and multi-layer IP traffic is spread correctly.
The key configuration only described a single header index, so only one
IP layer contributed to the hash.

Add dpaa2_flow_dpkg_ip_addr_hdr_expand(), which copies the existing key
extracts and, for every IP source/destination address extract, inserts a
second extract with hdr_index set to LAST_HDR_INDEX. The TC table
configuration now uses this expanded key configuration on the RSS
distribution path, while the exact-match path keeps the original key.

Move dpaa2_flow_is_ip_addr_extract() earlier so the new helper can use
it, and change it to return a boolean since only the match result is
needed.

Also fix LAST_HDR_INDEX, which was defined as 0xFFFFFFFF but is written
into the 8-bit hdr_index field of the MC key extract; use 0xFF so the
"last header" marker is programmed correctly.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_flow.c | 68 ++++++++++++++++++++++++++--------
 drivers/net/dpaa2/mc/fsl_net.h |  4 +-
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index a22af4f33b..dc2e821d75 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -2613,6 +2613,48 @@ dpaa2_flow_fs_table_set_default(struct dpaa2_dev_priv *priv,
 	return 0;
 }
 
+static int
+dpaa2_flow_is_ip_addr_extract(const struct dpkg_extract *extract)
+{
+	enum dpkg_extract_type type = extract->type;
+	enum net_prot prot = extract->extract.from_hdr.prot;
+	uint32_t field = extract->extract.from_hdr.field;
+
+	if (type == DPKG_EXTRACT_FROM_HDR && prot == NET_PROT_IP &&
+		(field == NH_FLD_IP_SRC || field == NH_FLD_IP_DST))
+		return true;
+
+	return false;
+}
+
+static int
+dpaa2_flow_dpkg_ip_addr_hdr_expand(const struct dpkg_profile_cfg *dpkg,
+	struct dpkg_profile_cfg *rss_dpkg)
+{
+	uint8_t i;
+
+	memset(rss_dpkg, 0, sizeof(struct dpkg_profile_cfg));
+	for (i = 0; i < dpkg->num_extracts; i++) {
+		if ((rss_dpkg->num_extracts + 1) > DPKG_MAX_NUM_OF_EXTRACTS)
+			return -ENOSPC;
+		rte_memcpy(&rss_dpkg->extracts[rss_dpkg->num_extracts],
+			&dpkg->extracts[i], sizeof(struct dpkg_extract));
+		rss_dpkg->extracts[rss_dpkg->num_extracts].extract.from_hdr.hdr_index = 0;
+		rss_dpkg->num_extracts++;
+		if (!dpaa2_flow_is_ip_addr_extract(&dpkg->extracts[i]))
+			continue;
+		if ((rss_dpkg->num_extracts + 1) > DPKG_MAX_NUM_OF_EXTRACTS)
+			return -ENOSPC;
+		rte_memcpy(&rss_dpkg->extracts[rss_dpkg->num_extracts], &dpkg->extracts[i],
+			sizeof(struct dpkg_extract));
+		rss_dpkg->extracts[rss_dpkg->num_extracts].extract.from_hdr.hdr_index =
+			LAST_HDR_INDEX;
+		rss_dpkg->num_extracts++;
+	}
+
+	return 0;
+}
+
 static int
 dpaa2_flow_tc_table_config(struct dpaa2_dev_priv *priv,
 	uint8_t tc_id, int rss_dist, int enable)
@@ -2624,6 +2666,8 @@ dpaa2_flow_tc_table_config(struct dpaa2_dev_priv *priv,
 	struct fsl_mc_io *dpni = priv->hw;
 	uint16_t entry_size;
 	struct dpaa2_queue *queue;
+	const struct dpkg_profile_cfg *cfg;
+	struct dpkg_profile_cfg rss_extract;
 
 	tbl_profile = &priv->flow_profile.tc_profile[tc_id];
 	if (tbl_profile->entry_num) {
@@ -2645,7 +2689,15 @@ dpaa2_flow_tc_table_config(struct dpaa2_dev_priv *priv,
 	}
 
 	dpaa2_flow_extracts_log(priv, "Configure", tc_id);
-	ret = dpkg_prepare_key_cfg(&key_profile->dpkg, tbl_profile->extract_param);
+	if (rss_dist) {
+		ret = dpaa2_flow_dpkg_ip_addr_hdr_expand(&key_profile->dpkg, &rss_extract);
+		if (ret)
+			return ret;
+		cfg = &rss_extract;
+	} else {
+		cfg = &key_profile->dpkg;
+	}
+	ret = dpkg_prepare_key_cfg(cfg, tbl_profile->extract_param);
 	if (ret < 0) {
 		DPAA2_PMD_ERR("TC[%d] prepare key failed", tc_id);
 		return ret;
@@ -3251,20 +3303,6 @@ dpaa2_flow_validate(struct rte_eth_dev *dev,
 	return ret;
 }
 
-static uint32_t
-dpaa2_flow_is_ip_addr_extract(const struct dpkg_extract *extract)
-{
-	enum dpkg_extract_type type = extract->type;
-	enum net_prot prot = extract->extract.from_hdr.prot;
-	uint32_t field = extract->extract.from_hdr.field;
-
-	if (type == DPKG_EXTRACT_FROM_HDR && prot == NET_PROT_IP &&
-		(field == NH_FLD_IP_SRC || field == NH_FLD_IP_DST))
-		return field;
-
-	return 0;
-}
-
 static void
 dpaa2_flow_key_offset_size(struct dpaa2_key_profile *key_profile,
 	uint8_t idx, uint8_t *offset, uint8_t *size)
diff --git a/drivers/net/dpaa2/mc/fsl_net.h b/drivers/net/dpaa2/mc/fsl_net.h
index 9ace8f3226..2aae0c99e2 100644
--- a/drivers/net/dpaa2/mc/fsl_net.h
+++ b/drivers/net/dpaa2/mc/fsl_net.h
@@ -1,14 +1,14 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2015 Freescale Semiconductor Inc.
- * Copyright 2018-2019 NXP
+ * Copyright 2018-2019, 2026 NXP
  *
  */
 
 #ifndef __FSL_NET_H
 #define __FSL_NET_H
 
-#define LAST_HDR_INDEX 0xFFFFFFFF
+#define LAST_HDR_INDEX 0xFF
 
 /*****************************************************************************/
 /*                Protocol fields                                            */
-- 
2.43.0

