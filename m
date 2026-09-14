Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352C9C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F408C42831;
	Mon, 14 Sep 2026 07:52:16 +0200 (CEST)
Received: from mail-pz2-f17.google.com (mail-pz2-f17.google.com
 [74.125.228.17]) by mails.dpdk.org (Postfix) with ESMTP id 36AE342831
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:16 +0200 (CEST)
Received: by mail-pz2-f17.google.com with SMTP id
 41be03b00d2f7-cc4c3304784so1493349a12.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365135;
 x=1789969935; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R9eLFuSirUTcrzKlNnryWcQANxQNfKX4rwdVS3XTQPM=;
 b=YxBI+zVXKPHGXgHUNbwHAkwptEKeoX8xq+IZvAgKeXX0vcV+y1pRD8mxTcTB5zcyej
 08nt3egxrSgGDREefg//z/x7ABuvqR3ZhfggzQvRs2RVRHC7y8BzRII0TDRK13LshMkj
 HfxJlQAYlMG7C4rul8mSgQ1pXskHZSSBHW+EJVUhDyg2QQ4nJ9eUO24NH9nKAmibdRRx
 XZ0K7N2wQkc0yzw71wxkKc1FqxkTvvzZCyVdLN8P3saFhLMIiCfmdcvcfQqUcOLN68ou
 9nkWvtNlXVGPzsnt6SVrUdxpWrJWHgkrAvZ5uzdaEFopPSNNZF0OhvjCd9s/09jJtnBK
 ngXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365135; x=1789969935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R9eLFuSirUTcrzKlNnryWcQANxQNfKX4rwdVS3XTQPM=;
 b=iohIcHhsjACcWNoDIUC2anMliITM79zklljHILvlf4MtluCLdiwEryjO1uO5aD7A1N
 Mo2cM4g8uMNACjXWzI3Em73hB8P7uskuL7BZm5qCDN4cjg4wbwF3P8ybaroylIhOk9H6
 la179SUsjMZbrNENlJHzQr4gPbng1xULmikttyuWr2Ysm3/H1POunYK4AJz+XRWGKFg6
 FilDc9iyzzB2XTsVjn6Io1VNaVCrZl9ppdmJquvpjx3Odwnzn1cbIjUUT1hoa05bTBwZ
 Z9APclhGP95hF7p17ukjCNjlw21ResUiKpndV/TPwRiwASVIV9U1Rt2XFbaa/LzrgeJl
 NspA==
X-Gm-Message-State: AFuF++kP/IplLqLjYYtffvllvSF1GSFmeB74jcCknl/YDEHyXCl64+9+
 Z/0srKDdUDLJ0IS9D+4tXfxOpjhvikZSO0a3qrTbxiRP+Bk1e9lhzB/s5qDHxkL+lxJFBjTP9XL
 RSbblfa0=
X-Gm-Gg: AYBFou3F0GcScseFEBqBKsvVvym6bOucBLChwt7hIHCw7C0OpYR+J56ced/7xCYDEKq
 1S07xf4mBnWfnST2iUNvvD0v9eGq/30rLT5DNLsq4sw+1cDFdssR229/EkaE9JLh4xMPMytZB9P
 mg8YKBs2i7r257aTW+vduqHCSdlfacu16QsjbgYUDvPXFBoyLgqed2WeAhU5A/yl+rb+p6pmrA3
 bXPedTJRmNwyX7Ir38exuSZICEZH7PATrMjwmOXhfOi7I6xpcN6e4gaGI9ox2fHAd7Z8z9ifweH
 OmRQSfhWIV349fRhkt/Atg4SamdOv9LSzhnRo8RKGr+4v/QpEYJi21tZ5X8fbfd4cKx18bPnUWx
 hb5ah2DapG6bAyBkmSuppsYJ7Yp/kIHhd//MXQLBNr8Fc2tQLyfhiKKFr9gBBiXW1NkoWjBbGmR
 MaIahTlpCaymacf/UPcCFc4z7KwUO5c3L2sZuJbj6CtFO3P+DPg7u7UsmZXpZG+Sog8Ay+83oGt
 UV7LUtxTeaEQH7xsz18Kp88/FfeQLTDbDku4g==
X-Received: by 2002:a17:90b:2885:b0:399:221d:63c0 with SMTP id
 98e67ed59e1d1-39dec16eff8mr2980394a91.25.1789365135377; 
 Sun, 13 Sep 2026 22:52:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH 51/62] ml/cnxk: use kvargs numeric helpers in mvtvm
Date: Sun, 13 Sep 2026 22:47:22 -0700
Message-ID: <20260914054912.755403-52-stephen@networkplumber.org>
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

parse_integer_arg() used atoi(), which cannot report an error, so a
malformed value became zero and the negative check never fired.
parse_uint_arg() open coded the errno and end pointer checks.

parse_uint_arg() also stored through a uint32_t pointer, but max_nb_qpairs
is a uint16_t followed by an int in the same struct, so parsing that
argument wrote past the field.

Neither handler did anything beyond a range checked store, so drop them
and pass rte_kvargs_handle_u16() directly for max_qps.

cache_model_data is a boolean, so make the field bool and use
rte_kvargs_handle_bool(), which makes the "< 0 || > 1" check that
followed it dead code. cache_model_data_set stays, since it still
tells an unset argument from one set to false. A bare key now enables
the option, and the usual spellings are accepted.

Bugzilla ID: 2043
Fixes: 48c6081ab4b3 ("ml/cnxk: enable creation of MVTVM virtual device")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/ml/cnxk/mvtvm_ml_dev.c | 47 ++++------------------------------
 drivers/ml/cnxk/mvtvm_ml_dev.h |  2 +-
 2 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/drivers/ml/cnxk/mvtvm_ml_dev.c b/drivers/ml/cnxk/mvtvm_ml_dev.c
index 74959a12fc..cbaf17698e 100644
--- a/drivers/ml/cnxk/mvtvm_ml_dev.c
+++ b/drivers/ml/cnxk/mvtvm_ml_dev.c
@@ -20,36 +20,6 @@
 
 static const char *const valid_args[] = {MVTVM_ML_DEV_MAX_QPS, MVTVM_ML_DEV_CACHE_MODEL_DATA, NULL};
 
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
-static int
-parse_uint_arg(const char *key __rte_unused, const char *value, void *extra_args)
-{
-	int i;
-	char *end;
-	errno = 0;
-
-	i = strtol(value, &end, 10);
-	if (*end != 0 || errno != 0 || i < 0)
-		return -EINVAL;
-
-	*((uint32_t *)extra_args) = i;
-
-	return 0;
-}
-
 static int
 mvtvm_mldev_parse_devargs(const char *args, struct mvtvm_ml_dev *mvtvm_mldev)
 {
@@ -68,7 +38,7 @@ mvtvm_mldev_parse_devargs(const char *args, struct mvtvm_ml_dev *mvtvm_mldev)
 	}
 
 	if (rte_kvargs_count(kvlist, MVTVM_ML_DEV_MAX_QPS) == 1) {
-		ret = rte_kvargs_process(kvlist, MVTVM_ML_DEV_MAX_QPS, &parse_uint_arg,
+		ret = rte_kvargs_process(kvlist, MVTVM_ML_DEV_MAX_QPS, rte_kvargs_handle_u16,
 					 &mvtvm_mldev->max_nb_qpairs);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s", MVTVM_ML_DEV_MAX_QPS);
@@ -79,8 +49,9 @@ mvtvm_mldev_parse_devargs(const char *args, struct mvtvm_ml_dev *mvtvm_mldev)
 	}
 
 	if (rte_kvargs_count(kvlist, MVTVM_ML_DEV_CACHE_MODEL_DATA) == 1) {
-		ret = rte_kvargs_process(kvlist, MVTVM_ML_DEV_CACHE_MODEL_DATA, &parse_integer_arg,
-					 &mvtvm_mldev->cache_model_data);
+		ret = rte_kvargs_process_opt(kvlist, MVTVM_ML_DEV_CACHE_MODEL_DATA,
+					     rte_kvargs_handle_bool,
+					     &mvtvm_mldev->cache_model_data);
 		if (ret < 0) {
 			plt_err("Error processing arguments, key = %s",
 				MVTVM_ML_DEV_CACHE_MODEL_DATA);
@@ -95,16 +66,8 @@ mvtvm_mldev_parse_devargs(const char *args, struct mvtvm_ml_dev *mvtvm_mldev)
 		mvtvm_mldev->max_nb_qpairs = MVTVM_ML_DEV_MAX_QPS_DEFAULT;
 	plt_ml_dbg("ML: %s = %u", MVTVM_ML_DEV_MAX_QPS, mvtvm_mldev->max_nb_qpairs);
 
-	if (!cache_model_data_set) {
+	if (!cache_model_data_set)
 		mvtvm_mldev->cache_model_data = CN10K_ML_DEV_CACHE_MODEL_DATA_DEFAULT;
-	} else {
-		if ((mvtvm_mldev->cache_model_data < 0) || (mvtvm_mldev->cache_model_data > 1)) {
-			plt_err("Invalid argument, %s = %d", MVTVM_ML_DEV_CACHE_MODEL_DATA,
-				mvtvm_mldev->cache_model_data);
-			ret = -EINVAL;
-			goto exit;
-		}
-	}
 	plt_ml_dbg("ML: %s = %d", MVTVM_ML_DEV_CACHE_MODEL_DATA, mvtvm_mldev->cache_model_data);
 
 exit:
diff --git a/drivers/ml/cnxk/mvtvm_ml_dev.h b/drivers/ml/cnxk/mvtvm_ml_dev.h
index 05e30f094c..f8b34ecd3a 100644
--- a/drivers/ml/cnxk/mvtvm_ml_dev.h
+++ b/drivers/ml/cnxk/mvtvm_ml_dev.h
@@ -31,7 +31,7 @@ struct mvtvm_ml_dev {
 	uint16_t max_nb_qpairs;
 
 	/* Enable / disable model data caching */
-	int cache_model_data;
+	bool cache_model_data;
 };
 
 #endif /* _MVTVM_ML_DEV_H_ */
-- 
2.53.0

