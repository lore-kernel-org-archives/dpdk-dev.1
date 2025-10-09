Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF025CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D9B240A72;
	Fri, 10 Oct 2025 00:15:43 +0200 (CEST)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by mails.dpdk.org (Postfix) with ESMTP id 5CF9E406B4
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:42 +0200 (CEST)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-b60971c17acso1231299a12.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048141; x=1760652941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4AylXlH4WkXjfFfeqY8eCwFh20Z9D6E5To2ff0e2EI=;
 b=AhKqJkDGFGinBBqerXHAYbwJxd2T7H8SIcKlaTYjP9IXGOj4T7slOv8ZUXFOmuQfxY
 3ZdsVN5DGq4v4hgfw304RSLhbbnNUH7N/l9w90Et0uEv0w9limGAn2I9lZAvOdV91S0O
 mJgCoOVBmpXZeMpoRUCkH5XvuS+n8q3Ej4X5bMvhjB91h41vRbQqrDz6kbJc1O/tFm+d
 q01GwCPap42wpfJZ4ZdUIc/sWKBTj5rpwlarVOA1C1zIePzJj7u84DWlSGzopYt8K5AB
 rlsI7BApxIDJGpoEBlCSXvzKSrv7NB6kpNAAX5nlEgG3gdodQD7l5KOML5f5qeI96xzw
 dcLQ==
X-Gm-Message-State: AOJu0YwU2SZeMGleY8OlSNxh+4rC8bHbmvyyEgbEGyoL3BsT72nzIdgs
 xEWRvjrDucyHeVpEkAQ9elWb5SVZ4hOdV7Y37t+N3ZUQJ3YxlsfRiAEQPYEQzFwyYFwrpegvI8E
 NTO4Sqt9b/sVZKTBNcx62OzXQeP87xeshYJ8ETCA1FpAUabPuUeSXsqpaxg8e3nhwZW9TH+DmUU
 IMXxQHHmpfP9CEdC557zOSjyb204gPfs3PG1QfJ6iXuwpx/PTGCbB894jODUmbKGhJDBEF2g==
X-Gm-Gg: ASbGnctkkDZsdlSDeQh+cByak4bZp1pm+4zoQaZkgDhBdh7vj7mdLKFXN7JrQGoS3Nk
 uOEuTpEE00fzTd0FDhHYCFvmzt/z4dUwUVTcKTHvMzjlg9QL+a28TjyqApZM8nlpj7RG9meaQhM
 8r5/Io8yit8z+3yi/cUgryDGNwPIYuAABC845V5BXYUPs1iEcdhHwG30abEI4rUeI7FSPh1oRC+
 oNTiUBZaqODkgFu+epgzsW7wQYpkFfp3V3Mx+g8Q/N0yNjgP9hhw8taig9B3ye+6GFRyVeK/l5N
 LT6aG/qF+gGXjZoZ75pxbAEFWcbUcTthe0OrrpBpUa4HyVsHnBcE9JIWx9I3v3jFlyWzV7QX4vR
 XJjeA+H/nQJjLBmncRBpMgXGCvyRu5+ksTtrvUu67XAx+wJl5O+5PuzhxaZKBrvfQiRI0fVqGzX
 8pK2N57wc=
X-Google-Smtp-Source: AGHT+IEBSrnzWEa9VoRKIbV1i5qBByOr8b2Qb3KMEWELli+qt9k9PUTecsFkLYR+TlT0lHmKGeyuZiOVdSUS
X-Received: by 2002:a17:902:ce0e:b0:275:6baa:d9 with SMTP id
 d9443c01a7336-290272e38b6mr123008605ad.40.1760048141497; 
 Thu, 09 Oct 2025 15:15:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034f2dd0asm3281705ad.57.2025.10.09.15.15.41
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-81d800259e3so28927566d6.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048140; x=1760652940; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4AylXlH4WkXjfFfeqY8eCwFh20Z9D6E5To2ff0e2EI=;
 b=e0sLdJ5QjRwBqMCuUAIwb4uNUSVXCMmZiy1gY4FuEuq3Bh+dYbFoa4Wix8ozXTvwfE
 WlVZ3mCcAjLw7hNODYsBnz5Puz2zncj0WXQK2aCYxmnrFzhtMdjqor9F4rDseZyYjmTe
 AIkyzYJCnBCCt2He6bLdB6la2OUtFdkbe7sT8=
X-Received: by 2002:a05:6214:1c4c:b0:820:8fa6:130e with SMTP id
 6a1803df08f44-87b074cdb2dmr112983686d6.0.1760048139508; 
 Thu, 09 Oct 2025 15:15:39 -0700 (PDT)
X-Received: by 2002:a05:6214:1c4c:b0:820:8fa6:130e with SMTP id
 6a1803df08f44-87b074cdb2dmr112983296d6.0.1760048138871; 
 Thu, 09 Oct 2025 15:15:38 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:37 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v2 17/54] net/bnxt/tf_core: tcam manager logical id free
Date: Thu,  9 Oct 2025 18:10:52 -0400
Message-Id: <20251009221129.28256-18-manish.kurup@broadcom.com>
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

