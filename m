Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CCECD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 18:44:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42015402D0;
	Fri, 19 Jun 2026 20:44:31 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8949E40279;
 Fri, 19 Jun 2026 20:44:29 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 604371A0012;
 Fri, 19 Jun 2026 20:44:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2AB671A0020;
 Fri, 19 Jun 2026 20:44:29 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4EF521800086;
 Sat, 20 Jun 2026 02:44:28 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	stable@dpdk.org
Subject: [PATCH 01/10] net/enetc: fix TX BD structure
Date: Sat, 20 Jun 2026 00:14:18 +0530
Message-Id: <20260619184427.522518-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619184427.522518-1-g.singh@nxp.com>
References: <20260619184427.522518-1-g.singh@nxp.com>
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

The flags field in struct enetc_tx_bd was declared as uint16_t but
ENETC4 TX BDs only use an 8-bit flags byte. Fix the type to uint8_t
to match the hardware descriptor layout.

Fixes: 696fa399d797 ("net/enetc: add PMD with basic operations")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/enetc/base/enetc_hw.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index 173d677..19efadd 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2024 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #ifndef _ENETC_HW_H_
@@ -198,8 +198,7 @@ enum enetc_bdr_type {TX, RX};
 
 #define ENETC_TX_ADDR(txq, addr) ((void *)((txq)->enetc_txbdr + (addr)))
 
-#define ENETC_TXBD_FLAGS_IE		BIT(13)
-#define ENETC_TXBD_FLAGS_F		BIT(15)
+#define ENETC_TXBD_FLAGS_F		BIT(7)
 
 /* ENETC Parsed values (Little Endian) */
 #define ENETC_PARSE_ERROR		0x8000
@@ -262,7 +261,7 @@ struct enetc_tx_bd {
 			uint8_t l3t:1;
 			uint8_t resv:5;
 			uint8_t l4t:3;
-			uint16_t flags;
+			uint8_t flags;
 		};/* default layout */
 		uint32_t txstart;
 		uint32_t lstatus;
-- 
2.25.1

