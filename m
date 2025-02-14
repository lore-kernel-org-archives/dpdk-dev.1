Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE7EC02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:22:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12550406BC;
	Fri, 14 Feb 2025 18:21:53 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7071040698
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:21:50 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22100006bc8so7594875ad.0
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739553709;
 x=1740158509; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4BGX8mrdECUGcDmE3lVhBRuX6KeQ84mN3E1mIvS5WE=;
 b=At0y04N687L72CKt0S3xgcSxd/lykr3Qd0qqi+isUkczurOgas5V1hODIV+L4bWaVJ
 esvLPhyJL+IH0G7XsIWXKhmvExMnMCc2pOucjJVRiM3zhDm7papECsGOFpbl0SH1ka/l
 fHHpRW+m+OHWyV1H/lOps+p7/wU69IQoCIn9yv9meWLR5mGE+79hJV3cJ+fKSa47bhDD
 AJRBBmlserXEK8/OB21bndO4LN0VdP0AbX96Je1STiBjAzt1LFuYRf1UCUmDLIv+TSFt
 Scw+RFdzhxwBPfR03pGnQ1q23AXf7bACQjRZprgRkzkh6QfmbVQpizB40I1NZ0OIApcq
 dbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739553709; x=1740158509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k4BGX8mrdECUGcDmE3lVhBRuX6KeQ84mN3E1mIvS5WE=;
 b=inmF/qg+4G9agECAWWFGu1Hc+2j/7KZOqAVUtP/I76Becnvqbu8wtlLVc86zcyzvXX
 UvZh2cbVdIMn+3LCQHKhZ6GNOHKty03v3ayve3fpcs4bHXV0RRctoI0BPBgnxHs8V7OE
 YuojOXQe0ryiwA9XjtZ8TzdPyeHgJiftY5IYMHOuSd+T6KhGfe52xP4Lm/RE+szstjbe
 Di9aV+8U5wpTy0iOkqY4B9botEUK1ed2E3VtiiL49ygJaDihHpiumapdDAZ+en125Kzk
 OvNPtIu1Fx5REMzyd+cbE+cqIn6S/tmX6OP8rD3Fo8rgUoCN6Ew7dGNmVqCZLQGLViHM
 Ssnw==
X-Gm-Message-State: AOJu0YwRayiuzJDV+KA0RF+QPomVTa5/NzfcIVAyVjQ4w2cZtxFNHqqG
 nDPhSlLWnHgi+9RLiCqGdT3p3lKUifDUxiVBnXdWEHBdehxl9HKB016uoSfS0nFkiq4O7FjhkVA
 7Fb8=
X-Gm-Gg: ASbGncuvlNy8TRRvvjIRO99oyRqGhJyKaTN3Pv4fS1PQKEN7mi8fQBxxw6CPdwG8YTb
 uNOQrAq8DQ0VPLm3KEYa+/MDDqFaL1nO9xy49QNQc2SjtRyY4914RmHsppF7/Ztm6DCzJljIVFm
 dyBnEXyqOH6BiBxA8669ii7rtSNgVATb2AA1ZsjtKbIFEOSHkBXujLKr+G5R0sMJcOVwtOKTyhB
 fAYyTlyKbT96g2jkxcO9XGBQDmLW29o6iS9hJl7Sm2xP+fuagjYMOT/pEOi2RpTFm1W5Ugkk2SD
 YWd/vj+pUJ+8q2mktYqZXfuxhBwNmuQdj+iWVWp4jPKbPVL8aeiV4YKsKKMXXVsRRy+S
X-Google-Smtp-Source: AGHT+IHz9jnNXtJO4peENvzCgcKmKCblXExbzaTZN5E6vrUPAGqEXbfZQVimrAzmBRMwWF1J40KXmw==
X-Received: by 2002:a05:6a00:3915:b0:725:b201:2362 with SMTP id
 d2e1a72fcca58-732617c3c6emr250231b3a.11.1739553709701; 
 Fri, 14 Feb 2025 09:21:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a52af8bsm3134264a12.50.2025.02.14.09.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:21:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, ajit.khaparde@broadcom.com,
 stable@dpdk.org, Somnath Kotur <somnath.kotur@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v2 4/7] net/bnxt: fix use after free
Date: Fri, 14 Feb 2025 09:20:12 -0800
Message-ID: <20250214172134.73908-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214172134.73908-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
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

The filter cleanup loop was using STAILQ_FOREACH and rte_free
and would dereference the filter after free.

Found by build with -Dbsanitize=address,undefined

Fixes: e8fe0e067b68 ("net/bnxt: fix allocation of PF info struct")
Cc: ajit.khaparde@broadcom.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_filter.c b/drivers/net/bnxt/bnxt_filter.c
index 7b90ba651f..f083f3aa94 100644
--- a/drivers/net/bnxt/bnxt_filter.c
+++ b/drivers/net/bnxt/bnxt_filter.c
@@ -3,14 +3,12 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
-
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_flow.h>
 #include <rte_flow_driver.h>
-#include <rte_tailq.h>
+#include <rte_queue.h>
 
 #include "bnxt.h"
 #include "bnxt_filter.h"
@@ -151,7 +149,9 @@ void bnxt_free_filter_mem(struct bnxt *bp)
 	bp->filter_info = NULL;
 
 	for (i = 0; i < bp->pf->max_vfs; i++) {
-		STAILQ_FOREACH(filter, &bp->pf->vf_info[i].filter, next) {
+		struct bnxt_filter_info *tmp;
+
+		STAILQ_FOREACH_SAFE(filter, &bp->pf->vf_info[i].filter, next, tmp) {
 			rte_free(filter);
 			STAILQ_REMOVE(&bp->pf->vf_info[i].filter, filter,
 				      bnxt_filter_info, next);
-- 
2.47.2

