Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83132C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C98254279C;
	Mon, 14 Sep 2026 07:52:14 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 3ED3A40696
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:13 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so1570828a91.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365132;
 x=1789969932; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6HFmozuflgN59e8Lxi2AyUY2UIgAxjJ8iSDzCEm14lE=;
 b=O6mm6PlLSV3lFNz+KxHwV9wlKxcXMRT+X8xYohgOW5CQsAHbI4RWIgmDPQrAfKYNmL
 eRmEdCIzG2JN0zAr/sfOHRVnk58y5/k5qiyjoUlewW7Xpwk1Zv71HT5ycJZxVY8y2jJN
 7wr1gJE0dZKFLdLNaMZt9/8oAwR9d85L8vVN3jEYzU4GU9uCaJkaJLI4PBvA6NRQWGZ6
 unYXumSSY8W11UfKnhXyMuJf9A01/Ta4mjkeGw/McxHAJnQNc8fw8Xx8oaB02ff2Hp5C
 X/0CDMJ/TOIuirzjZLY0661NDN7EKYfww83BEthfpp9OJf/APL7W0D1F2KpIDpkDphVS
 MjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365132; x=1789969932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6HFmozuflgN59e8Lxi2AyUY2UIgAxjJ8iSDzCEm14lE=;
 b=sO9bZM8nixpDj3FV9Ge9N6ARuhntgZ6amKGn7cRLGpUOeVLO/MEDhF+lOSiaBTOjQ5
 kl1E9ixhIennxaFzNkDr9MKKfBsUeGVDhoijJsD3PW9r61sPaPT9eNhf2r8s5JG4Z1+7
 XcdEESFmJVuawhy2YZNDL0zTaJAkXM9T5j7TxWajHlI4PTiojASSe+bo3sTjz4R+fLR8
 068KhjQ5Y8JIRm6rMuvxFd2UUObbezUibAptimt/whb4OdXVDRC+5kWovL4Okx9duFrm
 Shyd0L1MmxadIyJCm2RtstkXV+dURQnT3OV9NzPVRD5OOOyZsY4sduI1ehoPnJ+75d8o
 iExQ==
X-Gm-Message-State: AFuF++nHeOT2UzVWF33cV1rs+Gz4BOo0/Ixm/hMTPNi053O38qiyWSKT
 hrou9JwzKhTz2/I+hBuTlXL6SQWgMIHo3fG6SHY6kLoNSGVJUSJ4Nyjixx35+E5KRAHCyVcunm/
 S3L1q
X-Gm-Gg: AYBFou1MAgVU1AAzCjvRSSLGQUKqLf17M98XCT+86tBKelXniLej2qhqmlW1w+dUNch
 sZDp3tyFlKWAvjH9Q7b3ddZJp4D+lCkSdYdgVVQASCoREjMCeMJWRDLUL1NMmNaylKbuPoSGw71
 whzPMqQ8ECtHYBNH+ACss4VDI/18T9KJJj0X8k8CoyRdgHwNDPNuCvca8FVCLv2+X1PEcD6LUtR
 QqyC/3hSVMHR1EOuAY4qwQaV6uhAvXCyvsUm283TaORCfo6QkQXcX2s2lqpn5B2BgLpjXQ54adM
 JUoMthiY/UHzFBdINIHc/ta9yDguWikWnIAX/m6HrSBgLeVvK+26sSdp0FC/QeRPfUua3SpZBwb
 9NcSgc4EH4gF59QcU3CCVdFzukucz/1r77IUVrOGUt8fDZBazrOWk0hd/be3CX1E0qYh2E3JtQr
 urRr3cJgsVdsrux3uS5PqNac0rBAdE8Vg8CcUqdKHFBeLuv9NwkdASmcFrVqKJVKMHOh1BcLCY5
 ET+tq9088wRK82rm6OfMZPOt7aTzPjnu5TzFA==
X-Received: by 2002:a17:90b:4ac6:b0:39d:efef:9b21 with SMTP id
 98e67ed59e1d1-39defefd842mr1028436a91.3.1789365132349; 
 Sun, 13 Sep 2026 22:52:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH 50/62] ml/cnxk: use kvargs numeric helpers in cn10k
Date: Sun, 13 Sep 2026 22:47:21 -0700
Message-ID: <20260914054912.755403-51-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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
 drivers/ml/cnxk/cn10k_ml_dev.c | 70 ++++++----------------------------
 drivers/ml/cnxk/cn10k_ml_dev.h |  8 ++--
 drivers/ml/cnxk/cn10k_ml_ops.c |  2 +-
 3 files changed, 16 insertions(+), 64 deletions(-)

diff --git a/drivers/ml/cnxk/cn10k_ml_dev.c b/drivers/ml/cnxk/cn10k_ml_dev.c
index c35895dc14..60bfb41b0f 100644
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
@@ -131,8 +117,8 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 
 	if (rte_kvargs_count(kvlist, CN10K_ML_FW_ENABLE_DPE_WARNINGS) == 1) {
-		ret = rte_kvargs_process(kvlist, CN10K_ML_FW_ENABLE_DPE_WARNINGS,
-					 &parse_integer_arg, &cn10k_mldev->fw.enable_dpe_warnings);
+		ret = rte_kvargs_process_opt(kvlist, CN10K_ML_FW_ENABLE_DPE_WARNINGS,
+					 rte_kvargs_handle_bool, &cn10k_mldev->fw.enable_dpe_warnings);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s",
 				CN10K_ML_FW_ENABLE_DPE_WARNINGS);
@@ -143,8 +129,8 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 
 	if (rte_kvargs_count(kvlist, CN10K_ML_FW_REPORT_DPE_WARNINGS) == 1) {
-		ret = rte_kvargs_process(kvlist, CN10K_ML_FW_REPORT_DPE_WARNINGS,
-					 &parse_integer_arg, &cn10k_mldev->fw.report_dpe_warnings);
+		ret = rte_kvargs_process_opt(kvlist, CN10K_ML_FW_REPORT_DPE_WARNINGS,
+					 rte_kvargs_handle_bool, &cn10k_mldev->fw.report_dpe_warnings);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s",
 				CN10K_ML_FW_REPORT_DPE_WARNINGS);
@@ -155,7 +141,7 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 
 	if (rte_kvargs_count(kvlist, CN10K_ML_DEV_CACHE_MODEL_DATA) == 1) {
-		ret = rte_kvargs_process(kvlist, CN10K_ML_DEV_CACHE_MODEL_DATA, &parse_integer_arg,
+		ret = rte_kvargs_process_opt(kvlist, CN10K_ML_DEV_CACHE_MODEL_DATA, rte_kvargs_handle_bool,
 					 &cn10k_mldev->cache_model_data);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s",
@@ -178,7 +164,7 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 
 	if (rte_kvargs_count(kvlist, CN10K_ML_DEV_HW_QUEUE_LOCK) == 1) {
-		ret = rte_kvargs_process(kvlist, CN10K_ML_DEV_HW_QUEUE_LOCK, &parse_integer_arg,
+		ret = rte_kvargs_process_opt(kvlist, CN10K_ML_DEV_HW_QUEUE_LOCK, rte_kvargs_handle_bool,
 					 &cn10k_mldev->hw_queue_lock);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s",
@@ -190,7 +176,7 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
 	}
 
 	if (rte_kvargs_count(kvlist, CN10K_ML_OCM_PAGE_SIZE) == 1) {
-		ret = rte_kvargs_process(kvlist, CN10K_ML_OCM_PAGE_SIZE, &parse_integer_arg,
+		ret = rte_kvargs_process(kvlist, CN10K_ML_OCM_PAGE_SIZE, rte_kvargs_handle_int,
 					 &cn10k_mldev->ocm_page_size);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s", CN10K_ML_OCM_PAGE_SIZE);
@@ -207,44 +193,18 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
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
@@ -261,16 +221,8 @@ cn10k_mldev_parse_devargs(struct rte_devargs *devargs, struct cn10k_ml_dev *cn10
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

