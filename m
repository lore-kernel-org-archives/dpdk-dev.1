Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E82DCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:51:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2318340A87;
	Mon,  3 Nov 2025 17:49:46 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 1323A40A4B
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:42 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-33067909400so3274177a91.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188581;
 x=1762793381; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtIJhvZSt6OEgeupU0v41SB41BjNEfctS2VXm0jxgVw=;
 b=wIFtY9VCa7ie6XuplxCPU2tqCLLqV1+7uUkKoy2CydovyA7wjz/mglZOZx9Bd5Secu
 VcHG+3bqEcCcTXn3GajoFwS66lZpycb5gYI6rCMyYl8/p8E8I6DtzHyYlrp1u4s4qpXr
 NFtPZQZtOSkbpMqFOYM1A0/dtc8tfwZn0xNSTgNxgWa67RzfStcIn2tH4bjxULj9nMp9
 H9+f1LX2fFXtPmkCe1AcDxQCPgfxMEHXzPvRy3qoOlA/ArcDKR6oDQNJihFPOCs6A+uV
 nxtzhlVgxAurKB+4ZgO/VxZeOUi6FS1en5cJP1+pUWElq/tOIRDcLAJdkEFVp+als9Y+
 nwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188581; x=1762793381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LtIJhvZSt6OEgeupU0v41SB41BjNEfctS2VXm0jxgVw=;
 b=jX5/VZXFp7maB5x5IcYyqtI+XKA2KNygSu9ry5J3ObHknYl7cbuelsg8qu9H9pYZ5f
 BgiGpMrJU0i9ymF96lGMWVRPECB92Vf/TGAsO2Bm8kx1Y7olSpKvV/cJk9kUmI82FoeR
 39tchjvmhk372mgwtps1hO1BieTpQeGq+iprgwB5qehzrvwpLXkVrGIjStFkbooZD/Yr
 xNPRuCc8Yre8MKdKAs0nvN87ft5YEXPLXv9DiCyw2G47CfbshtWNFdFkbbnkWhpks8Vu
 vh8XQrDFsjrLEVmyKXHL1HDrrLsXlJz7LQofJ6phpClaD3KBzo2i64D0eNNxcCStTtbF
 jyxg==
X-Gm-Message-State: AOJu0YyoynM28FTrRLzfhwKu6UB25jG4je8CtdN8rc6qVbudYsxivl0b
 c7pEptsvWxR5iAA4pBBgsQ/mr/QDgGQ6gMrWz1rKFu5u2A2GRBWLywiRhG6q2uBrF5XoyZHzfpm
 wI/e1
X-Gm-Gg: ASbGncu33sd0lxEuF3k5MsFzFeGnAZs6yZslcwct8a52vDw1J9HWh2VrLiMcbwcLSGj
 Ur2JM9MHvFIUQTGijZidrH3XQRpKdHM4uPbt26+OYvBR3A27SvK/fYoKRgWXzsm5+i1laetAgBm
 9fd/d0fydMcx4lge+ZI6ScRDJ1Mt1+I2hJnjdKCc/1zi9m73hn7jYfLxrkkShwHMg96ac6gaOkS
 LXtUIuHSoi98DtadEpPdajUETzvfjuKVMLvKieOwce3qvtKNoGgpuQtFoyQPekjQi8X5gXpnh8F
 pyrcFVG5gT7F79txwD5c3I+Dmi9l560SV0de/9LexMlhcZA6Tf+7ujAzQpThF5GlajTEbdVBYzn
 8VXOonvj5EKgbbuCZSIgrYn3dh8lAk43b/SQKFEzNOUBodIqyZq5lIGmlh+PwFARJ+4UJ2njmSX
 s1T6Aalg7vIj999TJ7c8+7v8iZDfDIzWYWLAOPk4N59UrqfPUcTQ==
X-Google-Smtp-Source: AGHT+IE7HpGxXCxFz6c7CV6kwSsw0DGm0SpNV/KYsx+mvHDD/sB0a2HOKfUiex8myjDY6+3ZndLlnw==
X-Received: by 2002:a17:90b:5550:b0:32d:f352:f764 with SMTP id
 98e67ed59e1d1-34082fcc5eamr14240117a91.2.1762188581279; 
 Mon, 03 Nov 2025 08:49:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, ajit.khaparde@broadcom.com,
 stable@dpdk.org, Somnath Kotur <somnath.kotur@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v3 15/44] net/bnxt: remove use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:20 -0800
Message-ID: <20251103164915.101713-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Fix unsafe use after free by using STAILQ_FOREACH_SAFE.

Fixes: e8fe0e067b68 ("net/bnxt: fix allocation of PF info struct")
Cc: ajit.khaparde@broadcom.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/bnxt.h                  | 1 -
 drivers/net/bnxt/bnxt_filter.c           | 7 +++----
 drivers/net/bnxt/bnxt_flow.c             | 1 -
 drivers/net/bnxt/bnxt_vnic.h             | 1 -
 drivers/net/bnxt/tf_ulp/bnxt_ulp.h       | 1 -
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c | 1 -
 6 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index c9fdd36d3e..e9099a3ff2 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -9,7 +9,6 @@
 #include <inttypes.h>
 #include <stdbool.h>
 #include <pthread.h>
-#include <sys/queue.h>
 
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
diff --git a/drivers/net/bnxt/bnxt_filter.c b/drivers/net/bnxt/bnxt_filter.c
index 7b90ba651f..0176b9f7cf 100644
--- a/drivers/net/bnxt/bnxt_filter.c
+++ b/drivers/net/bnxt/bnxt_filter.c
@@ -3,8 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
-
+#include <rte_bsd_queue.h>
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
@@ -110,7 +109,7 @@ void bnxt_free_all_filters(struct bnxt *bp)
 
 void bnxt_free_filter_mem(struct bnxt *bp)
 {
-	struct bnxt_filter_info *filter;
+	struct bnxt_filter_info *filter, *tmp;
 	uint16_t max_filters, i;
 	int rc = 0;
 
@@ -151,7 +150,7 @@ void bnxt_free_filter_mem(struct bnxt *bp)
 	bp->filter_info = NULL;
 
 	for (i = 0; i < bp->pf->max_vfs; i++) {
-		STAILQ_FOREACH(filter, &bp->pf->vf_info[i].filter, next) {
+		STAILQ_FOREACH_SAFE(filter, &bp->pf->vf_info[i].filter, next, tmp) {
 			rte_free(filter);
 			STAILQ_REMOVE(&bp->pf->vf_info[i].filter, filter,
 				      bnxt_filter_info, next);
diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..d3da309254 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -3,7 +3,6 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
 
 #include <rte_log.h>
 #include <rte_malloc.h>
diff --git a/drivers/net/bnxt/bnxt_vnic.h b/drivers/net/bnxt/bnxt_vnic.h
index 5a4fd4ecb7..be232df2e7 100644
--- a/drivers/net/bnxt/bnxt_vnic.h
+++ b/drivers/net/bnxt/bnxt_vnic.h
@@ -6,7 +6,6 @@
 #ifndef _BNXT_VNIC_H_
 #define _BNXT_VNIC_H_
 
-#include <sys/queue.h>
 #include <stdbool.h>
 #include <rte_hash.h>
 
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
index e0e31532fd..f8c46186fe 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
@@ -8,7 +8,6 @@
 
 #include <inttypes.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 
 #include "rte_version.h"
 #include "rte_ethdev.h"
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
index 591bde96e8..cd97bc6635 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
@@ -4,7 +4,6 @@
  */
 
 #include <math.h>
-#include <sys/queue.h>
 
 #include <rte_log.h>
 #include <rte_malloc.h>
-- 
2.51.0

