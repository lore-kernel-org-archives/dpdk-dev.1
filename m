Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D24CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1856E40E27;
	Wed, 15 Oct 2025 11:04:07 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id 09E4C40E01
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:06 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-339e71ccf48so8835138a91.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519045; x=1761123845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4AylXlH4WkXjfFfeqY8eCwFh20Z9D6E5To2ff0e2EI=;
 b=i6jfpJnm+QJrWkc0l6H1J+dbPJhijvHibvshNeT/R/e/ivtOPoEfFHXKAxSAei71Xi
 OSOCv9Un/9KgTIsfLlyffoKGtDTHbCdxrSzxxhXNoHLMmO5Yi5DBkFjE/7cOSA8EAO7x
 CFgI/v9IV++eyydFX3TX3YGnbj/g31uiqj4fM5aVj487QZSx+M+RF91RASnEPiEE7w0/
 BKb1iDtVE9hw6cEXmXs1lzzMGaauOZToM1bWePqKj0XxuARQczEKTM05biqxZpzaFfKL
 BUhYkPAiTtf03uGgGJW9wkSHp1HMqMFHNqQO/Lfyt/aniXUDhAYB8UDTRl0626CQ5Nyc
 XvZA==
X-Gm-Message-State: AOJu0YxH7HXake0NWio3CrwW9lffCBEbSaQBKIZYlZGRCo+NeQLDXcOg
 1DU9Ts4+ZASW4AitnvE6s3lQMPemmOlDUYuYkwiYdpBnLZlWbLDBdhEuZD8EEJTKzQfpzCV64op
 srCVfRTgFVG8OQn4i5/zRm20PDINiyUbDg2yPXh6JZoK9jqDqACNwjY1qTGUZRguJac8uTMPVh5
 OQLbwvmwgxXRpsiOxkcPwkPdFJi/v0rkmEXMwAXCH9DoeoFZnWUwmxSKx1t7aluSygBfO/NQ==
X-Gm-Gg: ASbGncvqwdihUXaL+ZvlClYtiG3afCTZWhuNrRLDSX03pLPkeBAOAfGHkeVlMZynEqJ
 N8IYnZ+dkJ5udL70fkNk2iUUa3Xn2q9oodle0VVD0coUo3VPL5Din5j66ngk/4EhO1L1I/Wm9+1
 ekoPMOarFyaa1P5xmnb98b8moVmf7P9986807vx0gN2SE25zFix+jgm2K6Ve7pUcsd0cgmgzcsL
 gMMZL5URcsA53+OeEipDUm7XgT2hY2WtOSpYlRZy1UwEcCnr4nm+j2/oXnHWNp1C7PrX6XFr7dy
 fQCar8Jw2YfhIZehEYV2OTM1l4+Fz6KGIKSOCqwj2vrEXFqfgXtEygPExoGh60JpI1Kct1m0cL2
 xldxSbG3dpFY9gSGnNxWVNyvXAjp40nOGNWSvqXtEDHk6KLp2vddgMMepdX7cLFtiJln6rsL1s7
 DKJg==
X-Google-Smtp-Source: AGHT+IFwz9c8Yme8WkvYHP50NeDbrYonyWcolEaDK6mOwB5tBYEVRY8bUNTRE3vGGmHLs0/yEsEXawlaIfSO
X-Received: by 2002:a17:90b:4d0a:b0:330:6edd:9cf with SMTP id
 98e67ed59e1d1-33b5127b26cmr37043624a91.22.1760519045118; 
 Wed, 15 Oct 2025 02:04:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33b62587e8dsm1492449a91.0.2025.10.15.02.04.04
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-78038ed99d9so14414358b3a.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519043; x=1761123843; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4AylXlH4WkXjfFfeqY8eCwFh20Z9D6E5To2ff0e2EI=;
 b=gfjR+8PntJixQwukqqSo7lXdvOvZHrMeGCBb9DY0xTgTetqYrO55BT3atb7v6njszK
 VwhNhwSukR/UUxeE9z3kph6f71JYehgpJOy0sDLnhOuBJGe25izvIkR0IblwkwEg3F64
 /OKZrj4Gdn//zBj67RgEdvh/QqJkLAui5MdgI=
X-Received: by 2002:a05:6a00:8d5:b0:793:1b79:ee61 with SMTP id
 d2e1a72fcca58-79387434292mr30217500b3a.22.1760519042846; 
 Wed, 15 Oct 2025 02:04:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d5:b0:793:1b79:ee61 with SMTP id
 d2e1a72fcca58-79387434292mr30217470b3a.22.1760519042041; 
 Wed, 15 Oct 2025 02:04:02 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:01 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v3 17/54] net/bnxt/tf_core: tcam manager logical id free
Date: Wed, 15 Oct 2025 04:59:47 -0400
Message-Id: <20251015090024.32250-18-manish.kurup@broadcom.com>
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

From: Farah Smith <farah.smith@broadcom.com>

Remove code allocating entry 0 during initialization as it is
not required. 0 is a valid entry.  Update session_bmp naming to
more descriptive logical_id_bmp.  The data structure
cfa_tcam_mgr_data is per session.  Within the cfa_tcam_mgr_data,
logical ids for TCAM entries are allocated from a global pool.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_core/cfa_tcam_mgr.c       | 35 +++++++------------
 .../net/bnxt/tf_core/cfa_tcam_mgr_device.h    |  6 ++--
 drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c    |  2 +-
 drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c   |  2 +-
 4 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/cfa_tcam_mgr.c b/drivers/net/bnxt/tf_core/cfa_tcam_mgr.c
index 89ca6814e5..c527750041 100644
--- a/drivers/net/bnxt/tf_core/cfa_tcam_mgr.c
+++ b/drivers/net/bnxt/tf_core/cfa_tcam_mgr.c
@@ -914,9 +914,8 @@ cfa_tcam_mgr_bitmap_alloc(struct tf *tfp __rte_unused,
 			  struct cfa_tcam_mgr_data *tcam_mgr_data)
 {
 	struct tfp_calloc_parms cparms;
-	uint64_t session_bmp_size;
-	struct bitalloc *session_bmp;
-	int32_t first_idx;
+	uint64_t logical_id_bmp_size;
+	struct bitalloc *logical_id_bmp;
 	int max_entries;
 	int rc;
 
@@ -924,11 +923,11 @@ cfa_tcam_mgr_bitmap_alloc(struct tf *tfp __rte_unused,
 		return -CFA_TCAM_MGR_ERR_CODE(INVAL);
 
 	max_entries = tcam_mgr_data->cfa_tcam_mgr_max_entries;
-	session_bmp_size = (sizeof(uint64_t) *
+	logical_id_bmp_size = (sizeof(uint64_t) *
 				(((max_entries - 1) / sizeof(uint64_t)) + 1));
 
 	cparms.nitems = 1;
-	cparms.size = session_bmp_size;
+	cparms.size = logical_id_bmp_size;
 	cparms.alignment = 0;
 	rc = tfp_calloc(&cparms);
 	if (rc) {
@@ -939,23 +938,15 @@ cfa_tcam_mgr_bitmap_alloc(struct tf *tfp __rte_unused,
 		return -CFA_TCAM_MGR_ERR_CODE(NOMEM);
 	}
 
-	session_bmp = (struct bitalloc *)cparms.mem_va;
-	rc = ba_init(session_bmp, max_entries, true);
+	logical_id_bmp = (struct bitalloc *)cparms.mem_va;
+	rc = ba_init(logical_id_bmp, max_entries, true);
 
-	tcam_mgr_data->session_bmp = session_bmp;
-	tcam_mgr_data->session_bmp_size = max_entries;
-
-	/* Allocate first index to avoid idx 0 */
-	first_idx = ba_alloc(tcam_mgr_data->session_bmp);
-	if (first_idx == BA_FAIL) {
-		tfp_free(tcam_mgr_data->session_bmp);
-		tcam_mgr_data->session_bmp = NULL;
-		return -CFA_TCAM_MGR_ERR_CODE(NOSPC);
-	}
+	tcam_mgr_data->logical_id_bmp = logical_id_bmp;
+	tcam_mgr_data->logical_id_bmp_size = max_entries;
 
 	TFP_DRV_LOG(DEBUG,
 		    "session bitmap size is %" PRIX64 "\n",
-		    tcam_mgr_data->session_bmp_size);
+		    tcam_mgr_data->logical_id_bmp_size);
 
 	return 0;
 }
@@ -1135,7 +1126,7 @@ static int cfa_tcam_mgr_free_entries(struct tf *tfp)
 	 * may not be of the same type, resulting in errors.
 	 */
 
-	while ((entry_id = ba_find_next_inuse_free(tcam_mgr_data->session_bmp,
+	while ((entry_id = ba_find_next_inuse_free(tcam_mgr_data->logical_id_bmp,
 						   0)) >= 0) {
 		free_parms.id = entry_id;
 		free_parms.type = CFA_TCAM_MGR_TBL_TYPE_MAX;
@@ -1405,7 +1396,7 @@ static int cfa_tcam_mgr_alloc_entry(struct tf *tfp __rte_unused,
 	int32_t free_idx;
 
 	/* Scan bitmap to get the free pool */
-	free_idx = ba_alloc(tcam_mgr_data->session_bmp);
+	free_idx = ba_alloc(tcam_mgr_data->logical_id_bmp);
 	if (free_idx == BA_FAIL) {
 		PMD_DRV_LOG_LINE(ERR,
 				 "Table full (session)");
@@ -1423,10 +1414,10 @@ static int cfa_tcam_mgr_free_entry(struct tf *tfp __rte_unused,
 {
 	int rc = 0;
 
-	if (entry_id >= tcam_mgr_data->session_bmp_size)
+	if (entry_id >= tcam_mgr_data->logical_id_bmp_size)
 		return -CFA_TCAM_MGR_ERR_CODE(INVAL);
 
-	rc = ba_free(tcam_mgr_data->session_bmp, entry_id);
+	rc = ba_free(tcam_mgr_data->logical_id_bmp, entry_id);
 	if (rc)
 		return rc;
 
diff --git a/drivers/net/bnxt/tf_core/cfa_tcam_mgr_device.h b/drivers/net/bnxt/tf_core/cfa_tcam_mgr_device.h
index 9d7f560e7b..1b5803f021 100644
--- a/drivers/net/bnxt/tf_core/cfa_tcam_mgr_device.h
+++ b/drivers/net/bnxt/tf_core/cfa_tcam_mgr_device.h
@@ -123,8 +123,10 @@ struct cfa_tcam_mgr_data {
 		cfa_tcam_mgr_tables[TF_DIR_MAX][CFA_TCAM_MGR_TBL_TYPE_MAX];
 	void *table_rows;
 	struct cfa_tcam_mgr_entry_data *entry_data;
-	struct bitalloc *session_bmp;
-	uint64_t session_bmp_size;
+	/* Logical ids assigned for all TCAM types */
+	struct bitalloc *logical_id_bmp;
+	/* Sum of all TCAM entries allocated  */
+	uint64_t logical_id_bmp_size;
 	void *row_tables[TF_DIR_MAX][TF_TCAM_TBL_TYPE_MAX];
 	void *rx_row_data;
 	void *tx_row_data;
diff --git a/drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c b/drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c
index ddc2728785..55b6b96439 100644
--- a/drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c
+++ b/drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c
@@ -374,7 +374,7 @@ static void cfa_tcam_mgr_data_free(struct tf_session *tfs)
 
 	tfp_free(tcam_mgr_data->table_rows);
 	tfp_free(tcam_mgr_data->entry_data);
-	tfp_free(tcam_mgr_data->session_bmp);
+	tfp_free(tcam_mgr_data->logical_id_bmp);
 	cfa_tcam_mgr_row_data_free(tcam_mgr_data);
 
 	tfp_free(tcam_mgr_data);
diff --git a/drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c b/drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c
index d5725f92e0..5b7e469e8a 100644
--- a/drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c
+++ b/drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c
@@ -372,7 +372,7 @@ static void cfa_tcam_mgr_data_free(struct tf_session *tfs)
 
 	tfp_free(tcam_mgr_data->table_rows);
 	tfp_free(tcam_mgr_data->entry_data);
-	tfp_free(tcam_mgr_data->session_bmp);
+	tfp_free(tcam_mgr_data->logical_id_bmp);
 	cfa_tcam_mgr_row_data_free(tcam_mgr_data);
 
 	tfp_free(tcam_mgr_data);
-- 
2.39.5 (Apple Git-154)

