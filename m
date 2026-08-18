Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC7C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 11:18:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45FF240B97;
	Tue, 18 Aug 2026 13:17:57 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3353440A89
 for <dev@dpdk.org>; Tue, 18 Aug 2026 13:17:51 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1804720028F;
 Tue, 18 Aug 2026 13:17:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D5E42200280;
 Tue, 18 Aug 2026 13:17:50 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4A5DC1800226;
 Tue, 18 Aug 2026 19:17:49 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v12 12/26] net/dpaa: optimize FMC MAC type parsing
Date: Tue, 18 Aug 2026 16:47:16 +0530
Message-Id: <20260818111730.801760-13-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818111730.801760-1-hemant.agrawal@nxp.com>
References: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-1-hemant.agrawal@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

For ls104xa, MAC9 and MAC10's type could be either of 10G/2.5G/1G
up to serdes configuration, MAC index should be identified by
port name instead of parsing MAC type and port number.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa/dpaa_fmc.c | 84 ++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_fmc.c b/drivers/net/dpaa/dpaa_fmc.c
index 7dc42f6e23..9c86685db6 100644
--- a/drivers/net/dpaa/dpaa_fmc.c
+++ b/drivers/net/dpaa/dpaa_fmc.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017-2023 NXP
+ * Copyright 2017-2026 NXP
  */
 
 /* System headers */
@@ -204,6 +204,41 @@ struct fmc_model_t {
 
 struct fmc_model_t *g_fmc_model;
 
+#define FMC_PORT_NAME_MAC "MAC/"
+#define FMC_PORT_NAME_OFFLINE "OFFLINE/"
+
+static int
+dpaa_port_fmc_get_idx_from_name(const char *name)
+{
+	const char *found;
+	char *endptr;
+	int idx_str_start = -1, idx;
+
+	found = strstr(name, FMC_PORT_NAME_MAC);
+	if (!found) {
+		found = strstr(name, FMC_PORT_NAME_OFFLINE);
+		if (found)
+			idx_str_start = strlen(FMC_PORT_NAME_OFFLINE);
+	} else {
+		idx_str_start = strlen(FMC_PORT_NAME_MAC);
+	}
+
+	if (!found) {
+		DPAA_PMD_ERR("Invalid fmc port name: %s", name);
+		return -EINVAL;
+	}
+
+	idx = (int)strtol(&found[idx_str_start], &endptr, 10);
+	if (endptr == &found[idx_str_start] || (*endptr != '\0' && *endptr != '/')) {
+		DPAA_PMD_ERR("Invalid index in fmc port name: %s", name);
+		return -EINVAL;
+	}
+
+	DPAA_PMD_INFO("MAC index of %s is %d", name, idx);
+
+	return idx;
+}
+
 static int
 dpaa_port_fmc_port_parse(struct fman_if *fif,
 	const struct fmc_model_t *fmc_model,
@@ -211,7 +246,10 @@ dpaa_port_fmc_port_parse(struct fman_if *fif,
 {
 	int current_port = fmc_model->apply_order[apply_idx].index;
 	const fmc_port *pport = &fmc_model->port[current_port];
-	uint32_t num;
+	int num = dpaa_port_fmc_get_idx_from_name(pport->name);
+
+	if (num < 0)
+		return num;
 
 	if (pport->type == e_FM_PORT_TYPE_OH_OFFLINE_PARSING &&
 	    pport->number == fif->mac_idx &&
@@ -219,40 +257,30 @@ dpaa_port_fmc_port_parse(struct fman_if *fif,
 	     fif->mac_type == fman_onic))
 		return current_port;
 
-	if (fif->mac_type == fman_mac_1g) {
-		if (pport->type != e_FM_PORT_TYPE_RX)
-			return -ENODEV;
-		num = pport->number + DPAA_1G_MAC_START_IDX;
-		if (fif->mac_idx == num)
-			return current_port;
-
+	if (fif->mac_type == fman_mac_1g &&
+			pport->type != e_FM_PORT_TYPE_RX)
 		return -ENODEV;
-	}
-
-	if (fif->mac_type == fman_mac_2_5g) {
-		if (pport->type != e_FM_PORT_TYPE_RX_2_5G)
-			return -ENODEV;
-		num = pport->number + DPAA_2_5G_MAC_START_IDX;
-		if (fif->mac_idx == num)
-			return current_port;
 
+	if (fif->mac_type == fman_mac_2_5g &&
+			pport->type != e_FM_PORT_TYPE_RX_2_5G)
 		return -ENODEV;
-	}
-
-	if (fif->mac_type == fman_mac_10g) {
-		if (pport->type != e_FM_PORT_TYPE_RX_10G)
-			return -ENODEV;
-		num = pport->number + DPAA_10G_MAC_START_IDX;
-		if (fif->mac_idx == num)
-			return current_port;
 
+	if (fif->mac_type == fman_mac_10g &&
+			pport->type != e_FM_PORT_TYPE_RX_10G)
 		return -ENODEV;
+
+	if (fif->mac_type != fman_mac_1g &&
+			fif->mac_type != fman_mac_2_5g &&
+			fif->mac_type != fman_mac_10g) {
+		DPAA_PMD_ERR("Unknown mac_type(%d) for port %s",
+			     fif->mac_type, pport->name);
+		return -EINVAL;
 	}
 
-	DPAA_PMD_ERR("Invalid MAC(mac_idx=%d) type(%d)",
-		fif->mac_idx, fif->mac_type);
+	if (fif->mac_idx == num)
+		return current_port;
 
-	return -EINVAL;
+	return -ENODEV;
 }
 
 static int
-- 
2.25.1

