Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A67CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:07:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A359240E0A;
	Tue, 30 Sep 2025 09:05:45 +0200 (CEST)
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com
 [209.85.222.227])
 by mails.dpdk.org (Postfix) with ESMTP id 64016402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:56 +0200 (CEST)
Received: by mail-qk1-f227.google.com with SMTP id
 af79cd13be357-85e76e886a0so384876285a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192616; x=1759797416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4AylXlH4WkXjfFfeqY8eCwFh20Z9D6E5To2ff0e2EI=;
 b=CvqMzmje1VuST3CKqFVHCm4Gc26oHDRT7BvadSM4BIGda81JcrhBIotcrcnfLHcD7S
 4JKhPajhRuPTaftYkhVs0L4uhDS67I+l0r8ESkVJ+GxkCsu5jFsnx85GaszwL+2M00LV
 9PDa9IL0Pl2EZWKNn1OJP4OTjeg9KiGnZ4Bqvg3mIKfwkHKGrlLYdR2fZ9Ogg8FxCg2/
 uabU3lkxolZOD1mzc+dhN8qnJc1nBpkhnIbb4UDDt6O88vVIFfnA9YLG1Kpo9uj9XkPr
 VLM958ILy8EIJPgETdMuIYasLq1QQwNVQAlPbPiri8ih9tHRIOCzqfvdxpsdyf6PRlZW
 7ZUQ==
X-Gm-Message-State: AOJu0Yy51C7qL+dszkBQsdKnpf0GM8QWrN9I0aDo8LX7FhUzl7zPEHBe
 M8OQNRCHFUUgs7pZp/9qYU8Hr1f9DjqutRQ4p6XdD2ojHKehDCqVeK3bKAAOUk2Rd3pvjZzySto
 J9N9+vNxSj2G3PzdlU+WGYQz3X5TPt/YELunxPNfXyk9ILdWMPV0iKouAcqcCS5zGnQ1i4CpDbB
 XN9kNXq1IhfkNGLorZUyVAOZEavzmRRRqfHE9RwGZKBD9enygogZ2A6w/8NF1eo43bJ+h0yg==
X-Gm-Gg: ASbGncuezVEbFBSpO/CIVWzZn9zyvPe4FHyEl5Phi6k8CxJ+jvINg/G/Ri35VY1jAdB
 IibOonqxoKKA1PAcTjAcBjxbDUmRk7muBVGJBsFg+UWzc1qKUi75C0Xb+zJWCMOcQKx1UNfM23u
 AO8E12k5Be+EZ1t9lxo4ja6+CM83ZInvMj7hPsW+qplTrzfAWVoKI8uWdE+kQ//JYmMgFdoUClB
 3y2Jt47hB6mkrC/Z0qaav7KnWuncL2J52nZJ/SdWeLmzg+Sw743ea6VTL5TnxbtfweCQOo5FBOd
 vvtF4XshzQ9xO5xwBMcZtqp47TDm+xobOy4wyXGQHnkaEMfoCZnLxeIFBDSPz5z8O88T6Ah7rlF
 RQWZNrTTz3CVs7Leoqqm1Wn4kXTE/23MNG+mcjpH+O8Ze6aONZxz9UaJZ09mbq40XG603xIkzHy
 Tu3w==
X-Google-Smtp-Source: AGHT+IF+Tj6++8tGnzYNsRaeoPTwD5gbhnpJUHZhnxAsZ8kzUAfd3jCxkzxTHdEOzoNBv4kyuxpLadWHWVjq
X-Received: by 2002:ad4:596d:0:b0:799:d62c:9328 with SMTP id
 6a1803df08f44-7fc42aef16fmr311252796d6.54.1759192615611; 
 Mon, 29 Sep 2025 17:36:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8013949f46dsm9482176d6.13.2025.09.29.17.36.55
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b55443b4114so3644015a12.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192614; x=1759797414; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4AylXlH4WkXjfFfeqY8eCwFh20Z9D6E5To2ff0e2EI=;
 b=ccyEU6UUa4FNbWdJshXGFBI458wLyoGb/jbNNhqiURAFXOOiK7tuKRvyiUrxc4UM4Y
 qlMTyhIG9lsyCGqSIij1oVW7HNJ/MqryRTpdIRdy4109CM+YdInGa0ahpIy8D7H1+c4S
 ak5dAQF0R7DHcCYayNryVVuO5JOy4GFggarjk=
X-Received: by 2002:a05:6a21:112:b0:306:639e:1a65 with SMTP id
 adf61e73a8af0-306639e1b54mr9669423637.59.1759192614097; 
 Mon, 29 Sep 2025 17:36:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:112:b0:306:639e:1a65 with SMTP id
 adf61e73a8af0-306639e1b54mr9669397637.59.1759192613590; 
 Mon, 29 Sep 2025 17:36:53 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:53 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 17/54] net/bnxt/tf_core: tcam manager logical id free
Date: Mon, 29 Sep 2025 20:35:27 -0400
Message-Id: <20250930003604.87108-18-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

