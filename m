Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BF4C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:02:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 743CF410ED;
	Wed, 16 Apr 2025 16:00:46 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 342B340E50
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 81679E11C3;
 Wed, 16 Apr 2025 18:00:38 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 81679E11C3
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812039;
 bh=dBCb5e4H+1dDvOPAJIXCiqnkI4r0+E1lWNb6RLgBTkQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VWmyA5DcOfJotV6LgBIeTHyzWM/Yv6Q+mn0ZlRJb3OraYSfnfASgFVypM+e81gsU/
 vXBiKKxzUJXEsyDLvheVWicpJNG/PH4sbDaCIw56sZXqZ16GNFjDNJYrG0QILq1z9q
 mjE8TwppZDrl5MXTdHQqcW+iI7T9fOBBoBbhk2s+YVGoM331k6C0qrm3b0O4vb2zM+
 0rM7pJ3ivbES4rG/7meXKFGx1WmhSVt/LSuw/iy6YWWtGtohVi7JPq3uK0iaejyuGd
 EwHTWTNusOy++NE+2BJDZkdo9g0/z1TFupVaIUFeO7otob9RymnbOZ6DwD3nR26Ctz
 nWrwFXXiOhEvQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 16/46] common/sfc_efx/base: add port mode for 8 port hardware
Date: Wed, 16 Apr 2025 17:59:46 +0400
Message-Id: <20250416140016.36127-17-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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
index 77c97217ee..0e00ff64d4 100644
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
 	/* FIXME: review Medford4 port modes */
 };
 
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

