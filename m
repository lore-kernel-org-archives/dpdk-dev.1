Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDF7CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:53:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 361A540ED6;
	Tue, 21 Oct 2025 19:52:55 +0200 (CEST)
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com
 [209.85.166.226])
 by mails.dpdk.org (Postfix) with ESMTP id 4CA0A40E13
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:50 +0200 (CEST)
Received: by mail-il1-f226.google.com with SMTP id
 e9e14a558f8ab-430d0cad0deso16207225ab.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069169; x=1761673969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b5s4amC7p9WJpKP5ilrkQY3tN37ouYRIk1tdUYSu/FQ=;
 b=IP8JqZfMU/8GUtlc9qYjNzRrwzWN2YNN3ckDZ/IXIh4pC6Aft2YdTCoNhZy0yHa6bM
 YieEoq/kOkPTeaC3YD+kx7ZCLDFjjzHpPocxn5LQiQb7DlXIGm6NPJ7GU+nH7fjxq/PY
 kgFlQh9WUgZr++d5Ou4bDRJgcxtw9HPEGF9u2s8qagdhxU/tTwrWVv6JDcm9rY3YR1b5
 6RcccgJo7OHO9ZG97HNRvhBP13GymbY9AD8DyrOMvINaESIN0KFoZ7npSlOrKMmU/Eox
 craHL82pr32uMVeyWZHXy4Da92+g9/ta0zDyZ27x5qL/vRDTBM9nZktrTYl6Cm1cv1E6
 VKvA==
X-Gm-Message-State: AOJu0Yzt/yO2fQEypEhj0hlePaSzc3+FVIUc+Xkt21/U8pVEKLirYdYV
 gzz6TuDjBCjvXcl+QFpRRQos3SBYQ1plAWI5QVSZCVavzq/ZBUda7NBqdZeHwmYaCodqZ+i/WqU
 /Hoo2qmuT79R3oF7KsiA5xEEtL2dBrUt0ZW0tC49JzmwrJrIgZer+1luGA5+xDUGijLcwzS3ScK
 KRHJWFbIPos7il7sgfFpBOHLmT92fhK69thrydHHLhQHFCNsn47FTmUR36q8EadlS7L/eptA==
X-Gm-Gg: ASbGnct6lj5KJYdLz7dToE5yXX6ozxCGUwFBcIk7QUasPzmk255ja35N9LdbGt8sC+i
 nY4gyCq7P0dzmcg81mvv1acUwAMro872gT1lR+EG8obI1LycQYU17ofwlA2AW64/2ISig3B8T6r
 IwF3I8H/3ZY+Cgu4USS16NJ0iPYBwyazwM6KxGGJGf5ElvBqWZSsaslRnaLBYQBSIVQnzQU6zCs
 e+bPRgPqlLOQR1DrY90eAITXjadTu9D4yP+ABf9oE93J8aeKGFpRhboygYKGZZGdZ4UY4E4Aa4L
 NZc9sCMLXHbTigFhFe0GVZUmH/oPRdgxph8kH9gypwChq0TTCi7jhgN4OsQ53bIDClkxQ9mrKH1
 1h/xbJHHADD+ZeiGY5Q0jKT4Ui4Y1iRtS1BX8smJFHkBy3khL8GJRGm3Rq7oaTyGEqX/RA83PBq
 Zmrt7J0YYK5cuwnzCdwEv9xbak/Jta7hX1qQ==
X-Google-Smtp-Source: AGHT+IHU5t3Ln/COW3/WuzZKG/zhWl8dbkqyduDOMor8JFClAz+vnPUC5t6uCbzMK9KNnFjPZ3lkK40a2qLa
X-Received: by 2002:a05:6e02:1947:b0:42f:9ba7:e47e with SMTP id
 e9e14a558f8ab-430c522f01fmr259964325ab.14.1761069169484; 
 Tue, 21 Oct 2025 10:52:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-430d072ab18sm11683785ab.16.2025.10.21.10.52.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-290c9724deeso50090595ad.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069167; x=1761673967; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5s4amC7p9WJpKP5ilrkQY3tN37ouYRIk1tdUYSu/FQ=;
 b=C52KJL3qLcK0rfcYSooQLAXTvOBxGnD0y16+OObNzyYcpaSM7qHy2DJ1QJcUp9O/ju
 YdRCXZdoZfIs1kcqXJFJ+dr25oZ8Tb4iSh2pIz//ApUMFkU9inot0cazF6G2PnCXpszY
 zRHkPScvaGJKYXFgGPCWSOKq3P/XVBqMGuvP8=
X-Received: by 2002:a17:902:ef4c:b0:290:7803:9e8 with SMTP id
 d9443c01a7336-290cb659d58mr224115415ad.48.1761069167644; 
 Tue, 21 Oct 2025 10:52:47 -0700 (PDT)
X-Received: by 2002:a17:902:ef4c:b0:290:7803:9e8 with SMTP id
 d9443c01a7336-290cb659d58mr224115085ad.48.1761069167024; 
 Tue, 21 Oct 2025 10:52:47 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:46 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v4 21/57] net/bnxt/tf_ulp: fix stats counter memory
 initialization
Date: Tue, 21 Oct 2025 13:50:13 -0400
Message-Id: <20251021175049.46092-22-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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

