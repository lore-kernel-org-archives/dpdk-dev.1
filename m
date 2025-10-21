Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2DECCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7122340E68;
	Tue, 21 Oct 2025 19:52:50 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 7E4DA40E50
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:48 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-339d7c4039aso5207553a91.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069168; x=1761673968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4AylXlH4WkXjfFfeqY8eCwFh20Z9D6E5To2ff0e2EI=;
 b=Dbz0DyyO+tfxahWAAfI0gbFVBYGcLmYDG8HilcKQTSe7U/r9cWCAjB8JQoPnqn8Pwn
 EKv3vf1TjqWIcIOehgg1tzRJUkBM9XGAMlraZXqEz1dsO4XkJEZjCg/JbeG0ndtNAL3y
 uaP1Q7DeMC1x4hNfXCS8znq7yTZqCeAXQMjHHCViE8DfQlQTHL0IKwbxluyEQ8bkwdDp
 5AEwtNuewYxHYeOxqOZ2QIXZpBa/8LyRZvorEDDgVFiRFcpL645TRhUOfhld7f1dJDA2
 r+kFKBKetZGad2Zo7iH9RRD7Vveh0YjK0549m/ecFdzwa9tARdzA0f4BgN22xz/NTAWv
 R/zQ==
X-Gm-Message-State: AOJu0YybsQNum5b5MgqFbQCUfS97ANaR0FuSiVaDqTyV0ZNJuXkxVs7C
 f+AbxFMGUOVw6/A3u1vknrqY0jt7Bi8o9sQWHDU1Tv45gauiQhISEAA/No9mRQqGzAh/ARzvWHM
 t/KbIAI+k/QgXLNHtsvCl0djPm5/KkMXdoNf7Wlcj8dRTRnaVdc2NeFEcKfTDNy/zrknKLknGyE
 8G+vEW/Vrp+2aA2UqD13PaO0WsaEVmTGlvpqNuA4/69g0BZPF9JnGevZR0wmFfxUwnfCFMeA==
X-Gm-Gg: ASbGnctLiuFqUM9iQUdC+8P2nPT9itlo06tkr1Uc+nN6hlgJAGgpEXzwnyt6Vhnx324
 /vRLGnRb9AcO8k7m0z5iL3HXSUGBitCPXcB9c7yfl/Iv2fS0Iy3JIeBurxqpryLta6hyudxz1CG
 aQhByTtGk6fOQF6ex2huUVyL90bVN1iRQzrnsYVu13NHAamlkqUJSVlAZVilxpa3N7u1aME3ySu
 Fq28pPIm2nb4yB4XEohHspD/Xnz6jp7WIJQ96DNeQFWeHquYT6VbDewYyczyQbmLJg5PFnd6iqi
 foSr+fabkqxQAXFYS5RCmGi5TT4wdUUxoxJYaMpqyWt5Bz6mtGgryWb/oa7B5YP+/ODTMz7ZjDm
 L+tSwvKOcHuMR7olsXyT1xsznPX6YOBfIwZVQM/JgEVmBMxnX48fhwQBZ+75DPWMBkTfUtaf8A6
 icm73GyvB7LojA6EBNmTmR103bQ+87NnA=
X-Google-Smtp-Source: AGHT+IH/hHyLpiEA8h1I8dxRqfllfzG8omuIMzeDUgEZsG0PrDoxnotkdZeGzkJQCf+Kz3jJrFGwuGIqyl79
X-Received: by 2002:a17:90b:3d8a:b0:330:84c8:92d7 with SMTP id
 98e67ed59e1d1-33bcf87ab2dmr26428084a91.12.1761069167578; 
 Tue, 21 Oct 2025 10:52:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33e2240820bsm18175a91.5.2025.10.21.10.52.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2924b3b9d47so35051825ad.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069165; x=1761673965; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4AylXlH4WkXjfFfeqY8eCwFh20Z9D6E5To2ff0e2EI=;
 b=htSuHbPkS9qOK1spbYvN3uI2jZh7XHjrPBe7/+34sNqGpVmGzAa40/GjMEP3cTufo2
 DoVsXokINrL9ezYiSarhBe3hfJjxEnOwjKDxMr51HADuv70B9grTcys5966gIavH582f
 qq4r9NUegOTrNZgR9yaf61k5uT/N3DP3QdHko=
X-Received: by 2002:a17:903:46d0:b0:267:9931:dbfb with SMTP id
 d9443c01a7336-290cb65c642mr216155075ad.54.1761069165449; 
 Tue, 21 Oct 2025 10:52:45 -0700 (PDT)
X-Received: by 2002:a17:903:46d0:b0:267:9931:dbfb with SMTP id
 d9443c01a7336-290cb65c642mr216154785ad.54.1761069164797; 
 Tue, 21 Oct 2025 10:52:44 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:44 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v4 20/57] net/bnxt/tf_core: tcam manager logical id free
Date: Tue, 21 Oct 2025 13:50:12 -0400
Message-Id: <20251021175049.46092-21-manish.kurup@broadcom.com>
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

