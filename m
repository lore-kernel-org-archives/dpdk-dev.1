Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776B9C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:47:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A93C9427AA;
	Wed, 12 Aug 2026 19:46:29 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2E2D4427C1
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:46:27 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 121E520004D;
 Wed, 12 Aug 2026 19:46:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D0A4920003D;
 Wed, 12 Aug 2026 19:46:26 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5449818000B1;
 Thu, 13 Aug 2026 01:46:25 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v9 10/25] net/dpaa: optimize FMC MAC type parsing
Date: Wed, 12 Aug 2026 23:15:53 +0530
Message-Id: <20260812174609.1100111-11-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260812174609.1100111-1-hemant.agrawal@nxp.com>
References: <20260811115731.3421032-1-hemant.agrawal@nxp.com>
 <20260812174609.1100111-1-hemant.agrawal@nxp.com>
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
 drivers/net/dpaa/dpaa_fmc.c | 73 ++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_fmc.c b/drivers/net/dpaa/dpaa_fmc.c
index 7dc42f6e23..3404b27bea 100644
--- a/drivers/net/dpaa/dpaa_fmc.c
+++ b/drivers/net/dpaa/dpaa_fmc.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017-2023 NXP
+ * Copyright 2017-2026 NXP
  */
 
 /* System headers */
@@ -204,6 +204,36 @@ struct fmc_model_t {
 
 struct fmc_model_t *g_fmc_model;
 
+#define FMC_PORT_NAME_MAC "MAC/"
+#define FMC_PORT_NAME_OFFLINE "OFFLINE/"
+
+static int
+dpaa_port_fmc_get_idx_from_name(const char *name)
+{
+	const char *found;
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
+	idx = atoi(&found[idx_str_start]);
+
+	DPAA_PMD_INFO("MAC index of %s is %d", name, idx);
+
+	return idx;
+}
+
 static int
 dpaa_port_fmc_port_parse(struct fman_if *fif,
 	const struct fmc_model_t *fmc_model,
@@ -211,7 +241,10 @@ dpaa_port_fmc_port_parse(struct fman_if *fif,
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
@@ -219,40 +252,22 @@ dpaa_port_fmc_port_parse(struct fman_if *fif,
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
+		pport->type != e_FM_PORT_TYPE_RX)
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
+		pport->type != e_FM_PORT_TYPE_RX_2_5G)
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
+		pport->type != e_FM_PORT_TYPE_RX_10G)
 		return -ENODEV;
-	}
 
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

