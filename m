Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43D1CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:43:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 733CE42F69;
	Tue, 29 Sep 2026 18:40:04 +0200 (CEST)
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37]) by mails.dpdk.org (Postfix) with ESMTP id 6A08342ECE
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:52 +0200 (CEST)
Received: by mail-pz2-f37.google.com with SMTP id
 d2e1a72fcca58-8867466563eso90730b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699931;
 x=1791304731; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EAb6zA6XhMrmVkhO2r2H1ap61ntsio7jHpKxWhSaCW4=;
 b=gW7sxzVnMsDtoku1iQPcwiu1+0beII1/mN/tZwhPXy8sxPY/aHUAKe4fJOhn1YaLPI
 mLC4dQmfRPe5u5tn6TwVHPaO8U/ZnF1Lx+U9Yw37xjC60Ec6qAZWnlQ+oo7pjLuW/KF3
 PXDeBm4iOEKKX62CD8DVL8HNZnrtlKJZA9eS1tBv0Tt81IXlccg+xJFeb6U6aN5ug88c
 HmIBucxVBndjS5tZOxlLA0/c9gtn0E5DcL2F6+hJYnQbLx5eXFwRzzHx7j98CuhsVqUQ
 mfua7DEyjiBFdyZWlYffOjCl80U6rYkYw8DoEJEbllTTS7QyTwUkOEFi7hQBKSmjuHZh
 l4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699931; x=1791304731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EAb6zA6XhMrmVkhO2r2H1ap61ntsio7jHpKxWhSaCW4=;
 b=FRJMVVgP9UjgkU+ssWB/v+cu/NklfaLEfvZpWVA9ai3RJw919pO53s6vdwHg/wyLQQ
 TttuHZu1GFAbZmd/f6xGuGtppx6Hn5AkbefQ+jR8XuACVmH3vR1qFcAANq4YWAVYkNhN
 f64r2idtDEkKXRwjSNMuaakJyYI1gDnXSeNvVUr6ZwtlULahf9vjnATRMrqNMNZpg3oo
 nHOa5MCU4D9V2U58JJrAwPeZe62TRRoXH3ArXbu6q5uROHJpPXpMZbQXd7dYeYAb/BLP
 R64owH6DembQwurjubRrlHL9C9iEIa7VzVuvhx+dri45JvajgR5Mh7Ay5+fwifY2rhso
 xL9Q==
X-Gm-Message-State: AFuF++nUKJPXoG0gz9VXgv2CzgnzOJxnVEiqAOGi4V+NxYQuB3jQUvtf
 VKFT4RNDWoDW7DkApez9rg33hAOFLymXfz7+qgNrrXrMZ+g9nrwz+JKzBQMS/TzdAGQWsRvGL8I
 a5Txcl+k=
X-Gm-Gg: AYBFou23h/UDv6cZXpmLy/d3sbLoGmkjYp0m6SwnCB9tL32AJ+nLelzKeGDrNfqrl5z
 SJFHk3Y10AFBmc+6oTcLo5VkbgZYsFOByoJX+JSONKu7ZXWmpS3cU7JnFgCwBsXa6K0YW77XqhJ
 S8h86d521dRXJ9Rc8DvrZj3NaUGb3Ss04hMY8zrgtInxzwR3MqcZWLlJNBg5hfCZ1VkLYjT5ZXv
 FnU98vgRTmbKJacxNl3/qKKlaj2L3UwLZ6xpktphn5yE7uTTe0c/9CEIMJvIifWTdwnh86htFgC
 cYKlTCeBFlfVktfL03+NV1dqTsZd9Ng5lk1X1tqKYGvanbFSEaD8eFLwbayEW6cMYJTx4Mgq5y/
 jd4zRVeRLr0hm/ftj4aYRe/hGMrqBT/dm1d27SNWBf82O9xengpv4/LEI2pndkaxdUOSXOEh1k7
 smdNJ3RYFLaaYUFV2n89l3BYXHTnlWQ6pTBpHYvHaw/0zHAMDSJDrcCwguSErS83wQJy9uOfuGC
 xgW1g+0UfoORacy2E3YrCBc/lvDTIxAb44hBw==
X-Received: by 2002:a05:6a00:1942:b0:878:3704:e0ed with SMTP id
 d2e1a72fcca58-8855fd8949dmr1831101b3a.19.1790699931518; 
 Tue, 29 Sep 2026 09:38:51 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v2 49/61] ml/cnxk: use kvargs numeric helpers in cn10k
Date: Tue, 29 Sep 2026 09:36:52 -0700
Message-ID: <20260929163800.1108305-50-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

