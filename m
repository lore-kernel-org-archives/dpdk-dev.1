Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCBACA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:25:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FE9D40DD7;
	Mon,  5 Oct 2026 22:25:45 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id 1267A40DD7
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:25:44 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3964dfb5b9aso569634a91.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231943; x=1791836743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JdmjfKMph/hqjD/XR4kG2bCozGtWGC4NCd+4NNThs9o=;
 b=VQs6Lpa5VwUFWr7PAFkqNA9jg5tpLUr1jbJqSuHde0cGK57+GTcNw9mXpul5cvZGfm
 +fhjsheIgijc55BC2ZjSaLAaKSWqrN1F2Do3mJj4Hi2RzMFPnB11oBPXJauEqAB+80p0
 0XXJaSbe0QCjhuRbu3Sj2T9T/AyNNwwOKHSqHt9nBj2zROyiqrUX+EgbuhNkN9QHUdKV
 gLjcrx+vi4zjvd8SQqBm3L/vtPhWnzAOSBDfCjZLbYvn6iZpdAqhCGLGPgMxpOXKHKPF
 B2UVPQ7VgKOJtGdb0J37Ju3lqLb1U4N0kGOJdnvzswiRm25oLd5Mbn36i91OnFURtyxR
 3Eqw==
X-Gm-Message-State: AFq9FYJ3KMQjkTXvOEQMC06gbkvmCJRaUBl3QzjECfGrMLI9G/T3Y395
 lDeAKTFqdhd3PthPpzZjcnhQ0HRKtgIq3ePZfMVtAtT7Haoku9kcENuVyqjrEl6uvG4xHz5oVus
 E9Ng89DKzIO3obKFlHo2Z52bpDdrTHEC67iAhhYyhCcek8IFOT7H8VF0WOAJJo6E7QF7xFiogob
 PdZ3giSWJp9YjdIg/e58QVKxC2oVrI7CDY8Vh/8Vz+MxuWSW29JLh7dpRL1AM7Zb7hGmL1EA==
X-Gm-Gg: AYBFou2wp82L0mpwoe4ALoTY91WF8iCe4dBZu4AiCjxhi/07yAuvX6m30zlU3GPkyIN
 zytEiwFKCQ0R9pq/91yqG4SDeQ9wL6yQvIakD511jzRDjx9BtJaDoBBpDYqLbYmAtTEcXxcow5r
 5a1xPr6Sdf72ZQXZ8hI9fb61sGNapuZXLedsYspQ/PBIbrcjs4FrtONa44fYeZYXEXGe9KGiFgU
 N0ey+ibqsgAW9sHmKzaUeAt6R61mmXbMRXbsaDe4Hn3dsDR1S8MCtUQYv+j54SD/ukqgxvjZckc
 MDGfy7AC9uf1PI730c1FGKwo3S9MsazXNSymjIwbNBV0xoFGGde9hmCj5JUysvwg1dbfBllRAvP
 RGOzo1QD63g6bMT6EPOlsvvxmdmnqDbCcXwPCZIZTQFVD5fwWicfjUthFCS2SOXgMW7QxiQzj/9
 KGORquXR7PPfRcix5s0mneDoGcLYBjYTPq693ApA==
X-Received: by 2002:a17:90b:3c44:b0:39e:6c6a:6577 with SMTP id
 98e67ed59e1d1-3a6ced75f41mr9428802a91.58.1791231941415; 
 Mon, 05 Oct 2026 13:25:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a8532a3676sm311050a91.1.2026.10.05.13.25.41
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:25:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a3f673221so497160885a.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231940; x=1791836740; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JdmjfKMph/hqjD/XR4kG2bCozGtWGC4NCd+4NNThs9o=;
 b=AKyRld1QbM3zfBx0BrjhzwNs2sS/JTaAEY+D8jtuJxoqxP2kW7V+GVw8xr6PVe5YMP
 Tnq0um1VynJxOiKpZNaBPts9o5xYOcfPEB13VOJcqrdz9pmDbQZeutpyq/igLCeghIQd
 855UQTg6yxeRw+GoAy3DobOKtS4tteoV2x1vc=
X-Received: by 2002:a05:620a:72cb:20b0:93e:8542:4f4d with SMTP id
 af79cd13be357-93e85425a47mr173315485a.57.1791231940131; 
 Mon, 05 Oct 2026 13:25:40 -0700 (PDT)
X-Received: by 2002:a05:620a:72cb:20b0:93e:8542:4f4d with SMTP id
 af79cd13be357-93e85425a47mr173310085a.57.1791231939323; 
 Mon, 05 Oct 2026 13:25:39 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca1a6c24sm961544585a.15.2026.10.05.13.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:25:38 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH] net/bnxt: validate pool index in pool manager APIs
Date: Mon,  5 Oct 2026 15:25:36 -0500
Message-Id: <20261005202536.18083-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Validate the pool index in the pool manager APIs so that it cannot go
out of bounds when setting or getting data from the table-scope pool
manager.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/hcapi/cfa_v3/tpm/cfa_tpm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/tpm/cfa_tpm.c b/drivers/net/bnxt/hcapi/cfa_v3/tpm/cfa_tpm.c
index 790b6c7e42..90d0206a15 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/tpm/cfa_tpm.c
+++ b/drivers/net/bnxt/hcapi/cfa_v3/tpm/cfa_tpm.c
@@ -6,6 +6,7 @@
 #define COMP_ID TPM
 
 #include <errno.h>
+#include <inttypes.h>
 #include <stddef.h>
 #include <stdint.h>
 #include <string.h>
@@ -119,6 +120,12 @@ int cfa_tpm_free(void *tpm, uint16_t pool_id)
 		return -EINVAL;
 	}
 
+	if (pool_id >= ctx->max_pools) {
+		CFA_LOG_ERR("pool_id (%" PRIu16 ") out of range (max %" PRIu16 ")\n",
+			    pool_id, ctx->max_pools);
+		return -EINVAL;
+	}
+
 	if (ctx->fid_tbl[pool_id] != CFA_INVALID_FID) {
 		CFA_LOG_ERR("A function (%d) is still using the pool (%d)\n",
 			    ctx->fid_tbl[pool_id], pool_id);
@@ -137,6 +144,12 @@ int cfa_tpm_fid_add(void *tpm, uint16_t pool_id, uint16_t fid)
 		return -EINVAL;
 	}
 
+	if (pool_id >= ctx->max_pools) {
+		CFA_LOG_ERR("pool_id (%" PRIu16 ") out of range (max %" PRIu16 ")\n",
+			    pool_id, ctx->max_pools);
+		return -EINVAL;
+	}
+
 	if (!ba_inuse(ctx->pool_ba, pool_id)) {
 		CFA_LOG_ERR("Pool id (%d) was not allocated\n", pool_id);
 		return -EINVAL;
@@ -163,6 +176,12 @@ int cfa_tpm_fid_rem(void *tpm, uint16_t pool_id, uint16_t fid)
 		return -EINVAL;
 	}
 
+	if (pool_id >= ctx->max_pools) {
+		CFA_LOG_ERR("pool_id (%" PRIu16 ") out of range (max %" PRIu16 ")\n",
+			    pool_id, ctx->max_pools);
+		return -EINVAL;
+	}
+
 	if (!ba_inuse(ctx->pool_ba, pool_id)) {
 		CFA_LOG_ERR("Pool id (%d) was not allocated\n", pool_id);
 		return -EINVAL;
-- 
2.31.1

