Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A3CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51A9540666;
	Fri, 10 Oct 2025 00:15:45 +0200 (CEST)
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by mails.dpdk.org (Postfix) with ESMTP id E728940A75
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:43 +0200 (CEST)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so1463455b3a.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048143; x=1760652943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b5s4amC7p9WJpKP5ilrkQY3tN37ouYRIk1tdUYSu/FQ=;
 b=cePVGAO8ZQ/wRVv+UoWn+NHz8nkOmlN3wY8/QnYHufmEeS/nIDOmrRzKzUaYJ+GE5z
 J2R5AYCBHrcwL1risGAZijDhbLXQeXQodEs9obDVKoOYabDrS8KZ86SCMGK1CgNZq/9I
 SanHACvjhv7o+qGe7RYoqWdJkjRgVNZzjJliQxEvx/6LuP5fu+qDYixOeeI/UTJSZIP0
 /D5Aq/IUuSMdjylPtuttpHY/McwgyKWYxloB0CH0dE6GuBUViv0RpvzCkTJ397V9eRwf
 xkXXZ4l9Bx74mhdk6fRLTuVcb8vTw3O3Rc/In2MwjIeyFADMmHP+nZzPFDbVTaO4mKEq
 lIVw==
X-Gm-Message-State: AOJu0Yykbd6meVLNPCs33+bZscxXtWA4hCfKCKEYG2fMtP+IlzD/rXtJ
 V/ChhvS3EBWY9s83MLVewOiHO1MnW8j6PE9hpbauFnWjBUH7tqAw9glo5mVKAY1XWoNq12jK+TA
 OaENCNLnXh46Xvqt8QqMmGDB80EwqKGTMyUEbcCY7usoatT2CUwuVHdba9FtbDc3bH920PgsdjX
 YY0TWUoDhIrzElD57O7BtrtDM/bp3BZlEWw8XAr1aVeC7wZtvueV8Kst++m7FbWiWT94xsCQ==
X-Gm-Gg: ASbGnctHHRHtaASfhyNZhIOp1Fo/msvfql/QGPdoeX4a8tcbrlbiBfmL0onBcT20QLC
 wT6Be+BOw4qUY8hayzEHj1EUBUFsT2rJQDC33oyZsmFXhgMVhXjm/XEJuVZjOyehJ9RlmA++y1/
 tux43aVDu5hLfNt2hDSXOqcd43TU9hZMgmTu4FWWDhfF8AQ84yyAhDoslLb7dMGXroibfr0yhD1
 1THFeDRiLpaWZ7+Nny8hQHwSi9r3WuYQZRMS6Eq9qJBj7i0eXGEbohv/BkZuk+B7sEjAWfBQcUP
 JfUBwGbfYycF5bv44UEbkdalwdCnoYtsFOfU8LgeBoJ4bN1gbqU23y1+QO1cO3PxM5FMVNEyrQq
 tq5qoaCFM/oNOXNEKBZaxRH4saRAow6JmV3o/XtszFo1YU+5+AHFa1omIxZlXiPEk+L8HG6Ms3B
 UKkcE2
X-Google-Smtp-Source: AGHT+IFsVeuXz9C0RqQZIhDrnCIlcaOa+aUc6dHIiZF2A8T6mlwe/dyhnk4NyzSWfXQ6gSVG1boZUb3V7XgB
X-Received: by 2002:a05:6a20:6a09:b0:309:48d8:cf1d with SMTP id
 adf61e73a8af0-32da8f7bb52mr12753476637.18.1760048142812; 
 Thu, 09 Oct 2025 15:15:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-79930562ba6sm71602b3a.4.2025.10.09.15.15.42
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-876ee102b44so84266036d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048141; x=1760652941; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5s4amC7p9WJpKP5ilrkQY3tN37ouYRIk1tdUYSu/FQ=;
 b=NYRO/8ZIcGIWOayqb0i3i7lPP+rQyoWE5XT0B9uJQMcXht1np+WjVqghcaeeFa9jFh
 LAgJ609yTlVJY2XkOFyE0gOp3XmjljWKtn0vNADWBYTIoQmx2PUc8jmmMwwV5adtOcKY
 tkBQj6F2Vww2PkgDHkoRgJ6//Y5xzYWk6nFtI=
X-Received: by 2002:a05:6214:3014:b0:78f:48ef:d8c with SMTP id
 6a1803df08f44-87b3a7e7b73mr106863006d6.22.1760048141386; 
 Thu, 09 Oct 2025 15:15:41 -0700 (PDT)
X-Received: by 2002:a05:6214:3014:b0:78f:48ef:d8c with SMTP id
 6a1803df08f44-87b3a7e7b73mr106862486d6.22.1760048140698; 
 Thu, 09 Oct 2025 15:15:40 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:40 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v2 18/54] net/bnxt/tf_ulp: fix stats counter memory
 initialization
Date: Thu,  9 Oct 2025 18:10:53 -0400
Message-Id: <20251009221129.28256-19-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

