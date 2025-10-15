Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127FDCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:04:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 184E940DDE;
	Wed, 15 Oct 2025 11:04:10 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id E63C140DDE
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:08 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-b632a6b9effso3898451a12.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519048; x=1761123848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b5s4amC7p9WJpKP5ilrkQY3tN37ouYRIk1tdUYSu/FQ=;
 b=mC197eQehhhAZdC64gR8Sef9WFqBbMa4HwELqoDVy9QB/1driql8lFTa0wIa9O6uyl
 ulrfmYFbxBf5M9mp4R7gS3KrMWG/0KnEb5a3Q1ONN58omCIbvJvko1lIgVApC2vgUauS
 O1SRyHIDCxlLAoairZHjApBONHjsEUQSmi+ip3Sr407U1CBKpQFmLFAK6xRjG5tc2Skl
 66TN+ffSxHY5UtJAx1DpQM0QOk17+UScfgT2vyAiFQbPZT0kxxhyUiDq0kD0qpS0xwPl
 Y1pO28zV5gu6lEqN9gpt1n9l1K/9rZT2u+k+Gu/VSXbSCfbapEi4TrvJQGSTN5S04Zac
 FZ7g==
X-Gm-Message-State: AOJu0Yz79I4g17d2PdBcHbpUCacvOw+R0niTBaEJwz0tZiBYQfiFPpQk
 8ENrIQX/SwLd8SYa0ihVgHQntnBkCxJ/zg4vNTLWfZR2Xry4xq1qcepWMrU133NKdcHOv+eNQnX
 HF2M/sWTfBcge34yOUtUBzrJUROxpmVnMhix75jNDPdaasZDUhIUBP8DUuWAd2FZfO120kPeux/
 oLK6LeYtt0yIe2nZO7i2EvGokzo80oAj8S3A6K6vnyiEPmN7H13v934LYrH4HhD8GZscKSVA==
X-Gm-Gg: ASbGncs5t0KBir33kzuS+wtilXmTywrV0EOxMOUadArksZ7MzEB0j3z6Vzz8PkfBpWY
 46ZZGglZk0ny3Ug8WqosWlz+mgKxOZ1ktYCQh2NexgvWiGwp9GJApL3gou+j5aKHvueCcnwcfZP
 X0QLEFQrplGH6Rxz4COG6vBCEgMqBKTUCqxKRg7UIB/EFobeVMxtM/MAVeHN/hHWYhBPb7sk6nX
 ASKcUSVLEzFD6Q2SOulkUHHkQ28YQM/ewenLWtdBmvT6/emuCdf3hPhcIaQnBBaqTo5YPUFO4wB
 yXmOODBRL4myMJqvw8JOv3l/qURL0l0gYvfdANNBVwltOWVemgbTlcG/2QQ/e6L4LFGXzSU7OjM
 jFLJ8pScy1Q9ubNUKebB/yeXR9lBPwMAQbJTpNKrwtul6z0zWcak6bQUyY4FXazngANpnAnFafo
 I6mQ==
X-Google-Smtp-Source: AGHT+IGRtXath3m/IWvume0HtPluKy+pD8iBek/QOl2L3cJYtRjvWOwalGsTHkjIXhrh5jDT+v8oMaOgRHwG
X-Received: by 2002:a17:903:b4e:b0:28e:acf2:a782 with SMTP id
 d9443c01a7336-290273edf3amr302433945ad.37.1760519047850; 
 Wed, 15 Oct 2025 02:04:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034efa708sm15740905ad.37.2025.10.15.02.04.07
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-77f610f7325so8093145b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519045; x=1761123845; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5s4amC7p9WJpKP5ilrkQY3tN37ouYRIk1tdUYSu/FQ=;
 b=X1Axj3GSujksEuUPej7yBRBeGidhkZdzgI/otSlvm2OE6ZCV7IscuInuugcb9dPO3X
 L3n5j1jJtCjUWdKCzTQ3icl135P5v89SvU5w4yam/zBRfid8wznCKBpkg6EvdoLeLvmB
 ELdBN+00H4Y9djH4L4WCWbokWoVy9ct2vQxgU=
X-Received: by 2002:a05:6a00:2447:b0:774:615b:c8ad with SMTP id
 d2e1a72fcca58-79385ce1228mr29257977b3a.9.1760519045517; 
 Wed, 15 Oct 2025 02:04:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:2447:b0:774:615b:c8ad with SMTP id
 d2e1a72fcca58-79385ce1228mr29257956b3a.9.1760519044916; 
 Wed, 15 Oct 2025 02:04:04 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:04 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v3 18/54] net/bnxt/tf_ulp: fix stats counter memory
 initialization
Date: Wed, 15 Oct 2025 04:59:48 -0400
Message-Id: <20251015090024.32250-19-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

The stats counter cache memory initialization did not print the
error message on failure, updated the initialization to print
error message on failure.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 35 ++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index fc4207b36c..b246b90fe2 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -63,29 +63,30 @@ int32_t ulp_sc_mgr_init(struct bnxt_ulp_context *ctxt)
 	int i;
 
 	if (!ctxt) {
-		BNXT_DRV_DBG(DEBUG, "Invalid ULP CTXT\n");
+		BNXT_DRV_DBG(ERR, "Invalid ULP CTXT\n");
 		return -EINVAL;
 	}
 
 	if (bnxt_ulp_cntxt_dev_id_get(ctxt, &dev_id)) {
-		BNXT_DRV_DBG(DEBUG, "Failed to get device id\n");
+		BNXT_DRV_DBG(ERR, "Failed to get device id\n");
 		return -EINVAL;
 	}
 
 	dparms = bnxt_ulp_device_params_get(dev_id);
 	if (!dparms) {
-		BNXT_DRV_DBG(DEBUG, "Failed to device parms\n");
+		BNXT_DRV_DBG(ERR, "Failed to device parms\n");
 		return -EINVAL;
 	}
 
 	sc_ops = bnxt_ulp_sc_ops_get(ctxt);
 	if (sc_ops == NULL) {
-		BNXT_DRV_DBG(DEBUG, "Failed to get the counter ops\n");
+		BNXT_DRV_DBG(ERR, "Failed to get the counter ops\n");
 		return -EINVAL;
 	}
 
 	ulp_sc_info = rte_zmalloc("ulp_sc_info", sizeof(*ulp_sc_info), 0);
 	if (!ulp_sc_info) {
+		BNXT_DRV_DBG(ERR, "Failed to allocate stats cache container\n");
 		rc = -ENOMEM;
 		goto error;
 	}
@@ -99,8 +100,9 @@ int32_t ulp_sc_mgr_init(struct bnxt_ulp_context *ctxt)
 	ulp_sc_info->num_counters = dparms->ext_flow_db_num_entries;
 	if (!ulp_sc_info->num_counters) {
 		/* No need for software counters, call fw directly */
-		BNXT_DRV_DBG(DEBUG, "Sw flow counter support not enabled\n");
-		return 0;
+		BNXT_DRV_DBG(ERR, "Num of flow entries is not configured\n");
+		rc = -EINVAL;
+		goto error;
 	}
 
 	/*
@@ -115,6 +117,7 @@ int32_t ulp_sc_mgr_init(struct bnxt_ulp_context *ctxt)
 	ulp_sc_info->stats_cache_tbl = rte_zmalloc("ulp_stats_cache_tbl",
 						   stats_cache_tbl_sz, 0);
 	if (!ulp_sc_info->stats_cache_tbl) {
+		BNXT_DRV_DBG(ERR, "Failed to allocate stats cache table\n");
 		rc = -ENOMEM;
 		goto error;
 	}
@@ -123,7 +126,7 @@ int32_t ulp_sc_mgr_init(struct bnxt_ulp_context *ctxt)
 					     ULP_SC_BATCH_SIZE * ULP_SC_PAGE_SIZE,
 					     ULP_SC_PAGE_SIZE);
 	if (!ulp_sc_info->read_data) {
-		rte_free(ulp_sc_info->stats_cache_tbl);
+		BNXT_DRV_DBG(ERR, "Failed to allocate stats cache data\n");
 		rc = -ENOMEM;
 		goto error;
 	}
@@ -135,10 +138,15 @@ int32_t ulp_sc_mgr_init(struct bnxt_ulp_context *ctxt)
 	}
 
 	rc = ulp_sc_mgr_thread_start(ctxt);
-	if (rc)
-		BNXT_DRV_DBG(DEBUG, "Stats counter thread start failed\n");
+	if (rc) {
+		BNXT_DRV_DBG(ERR, "Stats cache thread start failed\n");
+		rc = -EIO;
+		goto error;
+	}
 
- error:
+	return 0;
+error:
+	ulp_sc_mgr_deinit(ctxt);
 	return rc;
 }
 
@@ -399,8 +407,11 @@ void ulp_sc_mgr_thread_cancel(struct bnxt_ulp_context *ctxt)
 	if (!ulp_sc_info)
 		return;
 
-	ulp_sc_info->flags &= ~ULP_FLAG_SC_THREAD;
-	pthread_cancel(ulp_sc_info->tid);
+	/* if thread started then stop it */
+	if (ulp_sc_info->flags & ULP_FLAG_SC_THREAD) {
+		pthread_cancel((pthread_t)ulp_sc_info->tid.opaque_id);
+		ulp_sc_info->flags &= ~ULP_FLAG_SC_THREAD;
+	}
 }
 
 /*
-- 
2.39.5 (Apple Git-154)

