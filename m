Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A20CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCE3542FB1;
	Thu,  1 Oct 2026 00:44:40 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 91F1E42FC9
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:37 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4c3304833so2319626a12.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808277;
 x=1791413077; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EAb6zA6XhMrmVkhO2r2H1ap61ntsio7jHpKxWhSaCW4=;
 b=b7ZTsLN0nYLOA+XqX9lIx2vFTAC2yJkmolQ67znG4P965N1Cc3NHWd+mkhm7buvFbc
 2g1JfIdagoE+l8lmSyLmXS3hHU2Lm4ZV6Jxb7gLYZjxCAvs7r4apuwJnsxcD7CBy+Gub
 NeB1NbAmTozvwYUXGshXLl3r6OWvm7yXbafMtUnDkvyV9ywcP6iyQPEC7aS4nz+jNJy3
 AySz3p2Gb4JUr5SZg8ZUXR99mpU03vERSz83N78hFDRZkPQYkzRDuSLWkPz9y5yixmh6
 QudB/cslrNxwMlON77rwpLTE5kyUFpfi3eNG8BvC5TzwQR04KYyypdU/OnhkUMWRIRMM
 UaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808277; x=1791413077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EAb6zA6XhMrmVkhO2r2H1ap61ntsio7jHpKxWhSaCW4=;
 b=ya+x08/3hPXrONMe+HUutmfc3nA+t1PgryivjA/vU3Iph2U9YKt9t2nMtC+WSBmvU0
 54WoDPslscXHqTwdpnh4gwvMn/JZEDrmzTu5VcUDJG3yLc/lPSiQu32MPf7a7htBe56S
 3OryBgZomZyXMWcItW658uyX4xMMFlQNYw2DAlrIdTHDc9lRfCORnV4eWkmhO5wj8HgC
 E78YFsEk0JafuhAYte6UX3zPxRQfIN4JEWDK7D4Be6v7hVTt7SeZe35SJXfuZ7S+POrc
 zXgo/cT/sYiOwTKR19Rb0VTn+VJAEQhrD7OmfiAyjKvFcXmA4gUV5Ixhanf77o4CS3r8
 oG1g==
X-Gm-Message-State: AFq9FYLSHw7Afg1q1t8YU6ntZByzEhT77G/d6mCWh7oquvyd1SoMXvty
 3XaQjpFVo1j71rz13snuJ146agZEP59aJBLogZvPUGsRvXO7WD2HE6HHKmSNdoDYJ8aZnBh51ND
 GlpgrA6k=
X-Gm-Gg: AYBFou1ca8R4qNtIfHL9gz9Y49tqaGJpJwPxY67vB/6rXHhvX3nyj10tP9DJ85nES3I
 efWG35W/4H/wV7c7BCOVsr5HUlWN8JW0hAWb827S3aSGLkLP8jkRXhMDudi8I8kdraB6nSkRfgG
 IaI8mNpPsvMKNCwL2wssMlHcJGmT7Xby7cHcyXpYlrp8+jtWNmDcIZafpKNVl1jFJcCbL3TtpNI
 +GmhvUXVgMD6ICLhab/M0qX2+mjuywdXZ1ltH4zTyr7A+kiXm1eSZTFDf1MJ4sG2igRLfFDyzw5
 Ah9UxZ1R86Vgds6EM8Hp9/bhzSgZQzosZGtMDmtEozQ7h5Xd8OkyO5Pyhk5fwfAwol8hpC2b3g9
 dStD5Qr74KgMOYlGXRU5gisdcaBc7knS5wE8SkqiLzWBiWLYSxANh7D/4cktnzFIwbNoB04jxs7
 fMcrTD2BHb6d6e4o/v+oBbJFQJr4dsngwwPx0pDNIJ4DkFITyh8PJyU81r6H9p61FyHyPPQSyJ2
 Pn7NoiBpQeMJPhshLiEwY87b9wtOvvZ4dr4bw==
X-Received: by 2002:a17:90b:2787:b0:3a2:b4bb:91ca with SMTP id
 98e67ed59e1d1-3a4d11df88fmr2396256a91.1.1790808276769; 
 Wed, 30 Sep 2026 15:44:36 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v3 50/65] ml/cnxk: use kvargs numeric helpers in cn10k
Date: Wed, 30 Sep 2026 15:41:08 -0700
Message-ID: <20260930224340.58580-51-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

parse_integer_arg() uses atoi(), which cannot report an error, so a
malformed value such as "abc" becomes zero and the negative check never
fires.

enable_dpe_warnings, report_dpe_warnings, cache_model_data and
hw_queue_lock are booleans, so make the fields bool and use
rte_kvargs_handle_bool(). The "< 0 || > 1" checks which followed each
of them are then dead and go away; the *_set flags stay, since they
still distinguish an unset argument from one set to false. A bare key
now enables the option, and the usual spellings are accepted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/ml/cnxk/cn10k_ml_dev.c | 74 +++++++---------------------------
 drivers/ml/cnxk/cn10k_ml_dev.h |  8 ++--
 drivers/ml/cnxk/cn10k_ml_ops.c |  2 +-
 3 files changed, 20 insertions(+), 64 deletions(-)

diff --git a/drivers/ml/cnxk/cn10k_ml_dev.c b/drivers/ml/cnxk/cn10k_ml_dev.c
index c35895dc14..ce96a408c4 100644
--- a/drivers/ml/cnxk/cn10k_ml_dev.c
+++ b/drivers/ml/cnxk/cn10k_ml_dev.c
@@ -80,20 +80,6 @@ parse_string_arg(const char *key __rte_unused, const char *value, void *extra_ar
 	return 0;
 }
 
-static int
-parse_integer_arg(const char *key __rte_unused, const char *value, void *extra_args)
-{
-	int *i = (int *)extra_args;
-
-	*i = atoi(value);
-	if (*i < 0) {
-		plt_err("Argument has to be positive.");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int
 cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10k_mldev)
 {
@@ -131,8 +117,9 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 
 	if (rte_kvargs_count(kvlist, CN10K_ML_FW_ENABLE_DPE_WARNINGS) == 1) {
-		ret = rte_kvargs_process(kvlist, CN10K_ML_FW_ENABLE_DPE_WARNINGS,
-					 &parse_integer_arg, &cn10k_mldev->fw.enable_dpe_warnings);
+		ret = rte_kvargs_process_opt(kvlist, CN10K_ML_FW_ENABLE_DPE_WARNINGS,
+					 rte_kvargs_handle_bool,
+					 &cn10k_mldev->fw.enable_dpe_warnings);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s",
 				CN10K_ML_FW_ENABLE_DPE_WARNINGS);
@@ -143,8 +130,9 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 
 	if (rte_kvargs_count(kvlist, CN10K_ML_FW_REPORT_DPE_WARNINGS) == 1) {
-		ret = rte_kvargs_process(kvlist, CN10K_ML_FW_REPORT_DPE_WARNINGS,
-					 &parse_integer_arg, &cn10k_mldev->fw.report_dpe_warnings);
+		ret = rte_kvargs_process_opt(kvlist, CN10K_ML_FW_REPORT_DPE_WARNINGS,
+					 rte_kvargs_handle_bool,
+					 &cn10k_mldev->fw.report_dpe_warnings);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s",
 				CN10K_ML_FW_REPORT_DPE_WARNINGS);
@@ -155,7 +143,8 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 
 	if (rte_kvargs_count(kvlist, CN10K_ML_DEV_CACHE_MODEL_DATA) == 1) {
-		ret = rte_kvargs_process(kvlist, CN10K_ML_DEV_CACHE_MODEL_DATA, &parse_integer_arg,
+		ret = rte_kvargs_process_opt(kvlist, CN10K_ML_DEV_CACHE_MODEL_DATA,
+					 rte_kvargs_handle_bool,
 					 &cn10k_mldev->cache_model_data);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s",
@@ -178,7 +167,8 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 
 	if (rte_kvargs_count(kvlist, CN10K_ML_DEV_HW_QUEUE_LOCK) == 1) {
-		ret = rte_kvargs_process(kvlist, CN10K_ML_DEV_HW_QUEUE_LOCK, &parse_integer_arg,
+		ret = rte_kvargs_process_opt(kvlist, CN10K_ML_DEV_HW_QUEUE_LOCK,
+					 rte_kvargs_handle_bool,
 					 &cn10k_mldev->hw_queue_lock);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s",
@@ -190,7 +180,7 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 
 	if (rte_kvargs_count(kvlist, CN10K_ML_OCM_PAGE_SIZE) == 1) {
-		ret = rte_kvargs_process(kvlist, CN10K_ML_OCM_PAGE_SIZE, &parse_integer_arg,
+		ret = rte_kvargs_process(kvlist, CN10K_ML_OCM_PAGE_SIZE, rte_kvargs_handle_int,
 					 &cn10k_mldev->ocm_page_size);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s", CN10K_ML_OCM_PAGE_SIZE);
@@ -207,44 +197,18 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 		cn10k_mldev->fw.path = fw_path;
 	plt_info("ML: %s = %s", CN10K_ML_FW_PATH, cn10k_mldev->fw.path);
 
-	if (!enable_dpe_warnings_set) {
+	if (!enable_dpe_warnings_set)
 		cn10k_mldev->fw.enable_dpe_warnings = CN10K_ML_FW_ENABLE_DPE_WARNINGS_DEFAULT;
-	} else {
-		if ((cn10k_mldev->fw.enable_dpe_warnings < 0) ||
-		    (cn10k_mldev->fw.enable_dpe_warnings > 1)) {
-			plt_err("Invalid argument, %s = %d", CN10K_ML_FW_ENABLE_DPE_WARNINGS,
-				cn10k_mldev->fw.enable_dpe_warnings);
-			ret = -EINVAL;
-			goto exit;
-		}
-	}
 	plt_info("ML: %s = %d", CN10K_ML_FW_ENABLE_DPE_WARNINGS,
 		 cn10k_mldev->fw.enable_dpe_warnings);
 
-	if (!report_dpe_warnings_set) {
+	if (!report_dpe_warnings_set)
 		cn10k_mldev->fw.report_dpe_warnings = CN10K_ML_FW_REPORT_DPE_WARNINGS_DEFAULT;
-	} else {
-		if ((cn10k_mldev->fw.report_dpe_warnings < 0) ||
-		    (cn10k_mldev->fw.report_dpe_warnings > 1)) {
-			plt_err("Invalid argument, %s = %d", CN10K_ML_FW_REPORT_DPE_WARNINGS,
-				cn10k_mldev->fw.report_dpe_warnings);
-			ret = -EINVAL;
-			goto exit;
-		}
-	}
 	plt_info("ML: %s = %d", CN10K_ML_FW_REPORT_DPE_WARNINGS,
 		 cn10k_mldev->fw.report_dpe_warnings);
 
-	if (!cache_model_data_set) {
+	if (!cache_model_data_set)
 		cn10k_mldev->cache_model_data = CN10K_ML_DEV_CACHE_MODEL_DATA_DEFAULT;
-	} else {
-		if ((cn10k_mldev->cache_model_data < 0) || (cn10k_mldev->cache_model_data > 1)) {
-			plt_err("Invalid argument, %s = %d", CN10K_ML_DEV_CACHE_MODEL_DATA,
-				cn10k_mldev->cache_model_data);
-			ret = -EINVAL;
-			goto exit;
-		}
-	}
 	plt_info("ML: %s = %d", CN10K_ML_DEV_CACHE_MODEL_DATA, cn10k_mldev->cache_model_data);
 
 	if (!ocm_alloc_mode_set) {
@@ -261,16 +225,8 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 	plt_info("ML: %s = %s", CN10K_ML_OCM_ALLOC_MODE, cn10k_mldev->ocm.alloc_mode);
 
-	if (!hw_queue_lock_set) {
+	if (!hw_queue_lock_set)
 		cn10k_mldev->hw_queue_lock = CN10K_ML_DEV_HW_QUEUE_LOCK_DEFAULT;
-	} else {
-		if ((cn10k_mldev->hw_queue_lock < 0) || (cn10k_mldev->hw_queue_lock > 1)) {
-			plt_err("Invalid argument, %s = %d", CN10K_ML_DEV_HW_QUEUE_LOCK,
-				cn10k_mldev->hw_queue_lock);
-			ret = -EINVAL;
-			goto exit;
-		}
-	}
 	plt_info("ML: %s = %d", CN10K_ML_DEV_HW_QUEUE_LOCK, cn10k_mldev->hw_queue_lock);
 
 	if (!ocm_page_size_set) {
diff --git a/drivers/ml/cnxk/cn10k_ml_dev.h b/drivers/ml/cnxk/cn10k_ml_dev.h
index dadb3b571b..4ca8dc63f4 100644
--- a/drivers/ml/cnxk/cn10k_ml_dev.h
+++ b/drivers/ml/cnxk/cn10k_ml_dev.h
@@ -108,10 +108,10 @@ struct cn10k_ml_fw {
 	const char *path;
 
 	/* Enable DPE warnings */
-	int enable_dpe_warnings;
+	bool enable_dpe_warnings;
 
 	/* Report DPE warnings */
-	int report_dpe_warnings;
+	bool report_dpe_warnings;
 
 	/* Data buffer */
 	uint8_t *data;
@@ -132,10 +132,10 @@ struct cn10k_ml_dev {
 	struct cn10k_ml_ocm ocm;
 
 	/* Enable / disable model data caching */
-	int cache_model_data;
+	bool cache_model_data;
 
 	/* Use spinlock version of ROC enqueue */
-	int hw_queue_lock;
+	bool hw_queue_lock;
 
 	/* OCM page size */
 	int ocm_page_size;
diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_ops.c
index 597806b787..732f9b62ae 100644
--- a/drivers/ml/cnxk/cn10k_ml_ops.c
+++ b/drivers/ml/cnxk/cn10k_ml_ops.c
@@ -377,7 +377,7 @@ cn10k_ml_dev_configure(struct cnxk_ml_dev *cnxk_mldev, const struct rte_ml_dev_c
 	rte_spinlock_init(&ocm->lock);
 
 	/* Set JCMDQ enqueue function */
-	if (cn10k_mldev->hw_queue_lock == 1)
+	if (cn10k_mldev->hw_queue_lock)
 		cn10k_mldev->ml_jcmdq_enqueue = roc_ml_jcmdq_enqueue_sl;
 	else
 		cn10k_mldev->ml_jcmdq_enqueue = roc_ml_jcmdq_enqueue_lf;
-- 
2.53.0

