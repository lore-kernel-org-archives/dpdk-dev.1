Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5ACCCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:09:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6A5940A82;
	Wed, 29 Oct 2025 17:09:03 +0100 (CET)
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com
 [209.85.161.98]) by mails.dpdk.org (Postfix) with ESMTP id 157C440A7A
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:09:03 +0100 (CET)
Received: by mail-oo1-f98.google.com with SMTP id
 006d021491bc7-65363319bacso3795075eaf.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754142; x=1762358942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4AylXlH4WkXjfFfeqY8eCwFh20Z9D6E5To2ff0e2EI=;
 b=FXL0TJNVvhTH+18QXiE08+szqVMYhAPy35lso3PbqcYV9bO4rXn+UnZVS6s6P7c0TH
 9ARuYXh9FpDIS1r1XxSyQavUfqJo9hXCIHIta/1x4weGDohQiBgrubV/bIuge7t62/b7
 m5kkLG9+35t83htr/clqEj8V0E9arM6by6gT0kmCXKVuXQs5HFFmP7DH0dknmH5iLN88
 b3gom+NrkYTRIfc7OkPBpiSqtJG+0UaVTBcZgPiKW2Muh9peJ41ElikQhxhvQJmsRCBa
 Qy7mjQ24MnPKaOWTKEf/7ScoQrPx5mkbnNz9Cw9kcm6tax256mvt+/q6kYPEHGRc36Dk
 vVug==
X-Gm-Message-State: AOJu0Yw7lc2TYYfy1cv86NOBo5aWxU9GKPltevILIfPEC0O1+LavSWZ/
 1IojwuFOG4V9+YSOElf7DqGdHmhyP3cqfqi5/FrUKxvozQNjBI2B/IVypjXRup4HLPee8fyMKHn
 h+LQEeqrbz6UdUTpvOVbngvaWX52p3+Yy9SAM29WqQY3HOpuRblkHhHo3oqTOqULMimAhVFTaFj
 VcvoLOOgQMquZ2/dH2ZaKQK33kwmAxGJnPDEQTJWaCInyNkm5fCZ88y9ZPhh84AzfEncrvpw==
X-Gm-Gg: ASbGncvjCbelGzaZq1zsqnCkrGWiNY04jZfDhbogk5oozDI+NnXoLyV3zx331C/+EH1
 ora0ZUzAQtpJoEzc2dVoPVwFT7R9/QxDsykzSzJ09sOMkK1uh9lmOvJW9hvJri07Mq+okVb+PKn
 +zelmSBxPalQImKbjiTZ/RgyhmwVDGTCVKS/GK58fxvfDP4DKwMV3xV5v0OzT5ALutPxP+rgn4c
 YnUNscKtDh16AhEUJLwBJoeuOwHl1jpacn7FAkYpZ/+D4Z29/1iqiXT8Sk/xLuz73RIoyQJCUFs
 i+IGFHG5Cd3jJ/peuYZDuwAszjKl6PSQIQa1WvBCV7eU5ZoHQYPvKucpumOtsj3SI/9kncMmcRT
 a3WYmf6FshTzcTwSJS7T4WDFrhf3XMlAZyWp0OR+JCydFpQYDbgsW+Wu0RZModaVR8/FVv/LX7e
 KpjA8ocJiHhsinmQHv9ihSjrg94OuPJAoM/w==
X-Google-Smtp-Source: AGHT+IEe/5Ar4QSecA1SsadXL3vhio0afY/jgAdnsHMVfb4ZTEcG57zUw3qIZqiUkaaRLhoes64kVE76gcEv
X-Received: by 2002:a05:6820:3091:b0:654:fd90:bdcb with SMTP id
 006d021491bc7-65677eec8a3mr1463030eaf.5.1761754142078; 
 Wed, 29 Oct 2025 09:09:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-654ef28d6e8sm372340eaf.4.2025.10.29.09.09.01
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:09:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8a9b1fa8092so147433385a.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754141; x=1762358941; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4AylXlH4WkXjfFfeqY8eCwFh20Z9D6E5To2ff0e2EI=;
 b=VhUUiylBmfg67VDcBrSlNXHSo6r+SXkOmK8pTEUw/Sul/dW5EBqGSrtrWtEFHbzLVs
 mmAEAF1iAvnEyRADxDUOlT1ETT4TjYyVZZZSmy+lOs8GEC6STxs3i6nGDHxhJgiuMIhL
 A4DO+Vtj9xMa7cIpckBBlhCmAID0rHhRRftiQ=
X-Received: by 2002:a05:620a:370e:b0:7e8:46ff:baac with SMTP id
 af79cd13be357-8aa2c08edc4mr19239585a.1.1761754140802; 
 Wed, 29 Oct 2025 09:09:00 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:7e8:46ff:baac with SMTP id
 af79cd13be357-8aa2c08edc4mr19232685a.1.1761754140206; 
 Wed, 29 Oct 2025 09:09:00 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:59 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v5 20/57] net/bnxt/tf_core: tcam manager logical id free
Date: Wed, 29 Oct 2025 12:06:35 -0400
Message-Id: <20251029160712.58519-21-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

