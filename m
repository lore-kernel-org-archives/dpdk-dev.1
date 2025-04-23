Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51547C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:02:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6F6540A6F;
	Wed, 23 Apr 2025 18:00:29 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 2BB4F40674
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:24 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 6F3FEE02A8;
 Wed, 23 Apr 2025 20:00:23 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 6F3FEE02A8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424023;
 bh=flOE8HnwXzCtx5BR2oVpqC85G/K2SF6Tnwjde8hgmWo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=8Ti5NB+LKIhEYsReBQnn2b9DJFInN3+xj7AdAtX92IOij4aJU1FvcxBUj14HmTxnx
 7+zNmRJP0CyW6Lx16WnKnJbESP+oXr4fd1PkpC2oIhnd5rZG6r51Jt8viG9VDmzS8K
 I+ElFtwFFu6yb4pXaYAMWAB4JsIhgGNAedLk94YDnHwCqtDD97+lJ4WID2Na5uG2vO
 fydf7P0778GUPiylAELGHQztNLMWHmAFbJ0HbA1CAO5tVnw68uoDaLk0jJCiCkbotD
 659dItfcnMAuN/WM2OKy4cyPHKcPresAq7yIacnv+3F9OGySIF+r/h1Pahr8AWFa4d
 Yo9TPTPxQh1NA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 15/45] common/sfc_efx/base: add port mode for 8 port
 hardware
Date: Wed, 23 Apr 2025 19:59:32 +0400
Message-Id: <20250423160002.35706-16-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Andy Moreton <andy.moreton@amd.com>

Add support for 8 port mode and adjust the bus bandwidth
computation and external port mapping table.

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 drivers/common/sfc_efx/base/ef10_nic.c        | 20 +++++++++++++++++++
 drivers/common/sfc_efx/base/ef10_tlv_layout.h |  9 ++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_nic.c b/drivers/common/sfc_efx/base/ef10_nic.c
index 9bff68f054..afad167dcb 100644
--- a/drivers/common/sfc_efx/base/ef10_nic.c
+++ b/drivers/common/sfc_efx/base/ef10_nic.c
@@ -176,6 +176,9 @@ ef10_nic_get_port_mode_bandwidth(
 	case TLV_PORT_MODE_2x1_2x1:			/* mode 5 */
 		bandwidth = (2 * single_lane) + (2 * single_lane);
 		break;
+	case TLV_PORT_MODE_4x1_4x1:			/* mode 26 */
+		bandwidth = (4 * single_lane) + (4 * single_lane);
+		break;
 	case TLV_PORT_MODE_1x2_1x2:			/* mode 12 */
 		bandwidth = dual_lane + dual_lane;
 		break;
@@ -1952,6 +1955,23 @@ static struct ef10_external_port_map_s {
 		(1U << TLV_PORT_MODE_4x1_NA),			/* mode 4 */
 		{ 0, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
 	},
+	/*
+	 * Modes that on Medford4 allocate up to 4 adjacent port numbers
+	 * to cage 1 and 4 port numbers to cage 2.
+	 *	port 0 -> cage 1
+	 *	port 1 -> cage 1
+	 *	port 2 -> cage 1
+	 *	port 3 -> cage 1
+	 *	port 4 -> cage 2
+	 *	port 5 -> cage 2
+	 *	port 6 -> cage 2
+	 *	port 7 -> cage 2
+	 */
+	{
+		EFX_FAMILY_MEDFORD4,
+		(1U << TLV_PORT_MODE_4x1_4x1),			/* mode 26 */
+		{ 0, 4, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
+	},
 };
 
 static	__checkReturn	efx_rc_t
diff --git a/drivers/common/sfc_efx/base/ef10_tlv_layout.h b/drivers/common/sfc_efx/base/ef10_tlv_layout.h
index 9ac50f1df6..712a1c7d26 100644
--- a/drivers/common/sfc_efx/base/ef10_tlv_layout.h
+++ b/drivers/common/sfc_efx/base/ef10_tlv_layout.h
@@ -7,7 +7,7 @@
 /*
  * This is NOT the original source file. Do NOT edit it.
  * To update the tlv layout, please edit the copy in
- * the sfregistry repo and then, in that repo,
+ * the smartnic_registry repo and then, in that repo,
  * "make tlv_headers" or "make export" to
  * regenerate and export all types of headers.
  */
@@ -635,7 +635,10 @@ struct tlv_global_port_mode {
 #define TLV_PORT_MODE_1x1_NA_LL                  (23) /* Single 10G/25G on mdi0, low-latency PCS */
 #define TLV_PORT_MODE_1x1_1x1_LL                 (24) /* Single 10G/25G on mdi0, single 10G/25G on mdi1, low-latency PCS */
 #define TLV_PORT_MODE_BUG63720_DO_NOT_USE        (9) /* bug63720: Do not use */
-#define TLV_PORT_MODE_MAX TLV_PORT_MODE_1x1_1x1_LL
+
+/* X4 */
+
+#define TLV_PORT_MODE_4x1_4x1                    (25) /* Quad 10G/25G on mdi0, quad 10G/25G on mdi1 */
 
 /* Deprecated Medford aliases - DO NOT USE IN NEW CODE */
 #define TLV_PORT_MODE_10G_10G_10G_10G_Q          (5)
@@ -643,7 +646,7 @@ struct tlv_global_port_mode {
 #define TLV_PORT_MODE_10G_10G_10G_10G_Q2         (8)
 #define TLV_PORT_MODE_10G_10G_10G_10G_Q1_Q2      (9)
 
-#define TLV_PORT_MODE_MAX TLV_PORT_MODE_1x1_1x1_LL
+#define TLV_PORT_MODE_MAX TLV_PORT_MODE_4x1_4x1
 };
 
 /* Type of the v-switch created implicitly by the firmware */
-- 
2.39.5

