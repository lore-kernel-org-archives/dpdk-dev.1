Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C40CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:44:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C19842F76;
	Tue, 29 Sep 2026 18:40:05 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 37BCE42EA6
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:53 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-8805988a200so2865482b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699932;
 x=1791304732; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R9eLFuSirUTcrzKlNnryWcQANxQNfKX4rwdVS3XTQPM=;
 b=eo+BJoE+RPik8B3xiRwNvT7gn+/ySRuR01EZK7UZc87YBSRIDl517GGQw7EvwkfUq7
 F0JfJQgZt+3ybaJ30tXpvPMTcHrMmKVpoGLeBnbZ5/Ccri9DMEBUkT3pz3t5NplfEn6p
 xHfbmmCKexYgRiaZqNMGfKXjxlp74uTGgq/dx7VbbifWEWMwwxUlVhzxmMkyn2QCTF8A
 6PA9zyccVtdLUHdeJYT2zGu1p7KTqcJj3IrgekLe4EI/zk5ZJfMVA7o9T3x0CSzt1TD7
 j+EUOA1tjuo5ZbGf32ES07yut/phpCnTr1JYCX2PeyfuWF7mgLIfHnvy/+be57iNIQ0K
 pq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699932; x=1791304732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R9eLFuSirUTcrzKlNnryWcQANxQNfKX4rwdVS3XTQPM=;
 b=LO4rwLSf/7lzslEhc3UnEGSoSl/dtAFs5e5QvzfSxyWZCaXNFDURCW03qZI2jqNYim
 dq9q0A5BajozupXc59vb1EN9ziCFYDJjjE9O2DGEYY8rHYerYpSla+tNUaYOESXFVRYQ
 lyLlGeUoH77wBZv/FYA3Vh1JQE9akS0i5gdFBQDs52zeXjQlyvtTyfy2tPl4ZChG0sMi
 4TCDFwnEz4azrSqe/wqskNkZJmsyC0n2uJ92MaxhgJH/KCs/tf1xfFsk0BSErTZ0hNTH
 wR5tlKiUMIuligHNN2xUnp6Vwh6KTvXfubtx1XnhlVq5qIG3N8E16bUvnxpge4NS09+P
 p4Fg==
X-Gm-Message-State: AFuF++k+4eLBKoXgZR7836uG+0xfcd04hGsHuKmW3Z6d32RTDQp2Vrrj
 gMABOqVIoS7d+YNnJclofULv2UHVEAZOg1QFQ3mZlFuFYuL+bcsJT4ywj0tAaq45ed75YMthEUv
 xssdWUVc=
X-Gm-Gg: AYBFou2o51QzOWsJ707mypNPCAEcVqa9BZwfwOda6wZqurgf/tPJ0sNCUMQLTzohhMf
 bEUSjmVXkgTxE6KM3YsdiY8tpXovhxhGcURhBxUiGfdhiMp1KiarfPcpg5YHKtfDUQwuNPczp1M
 mfabSKcI1CZuaQWsZ+o+v3ZDYMlI1T4naZdDmlXQBLngdyqosYampBASHVcdlujlPZ63PJ+e8in
 pPcTi1YyvglDr7IZ0rjnqeRGlsFOzJC3jkk12drqacgUAn8L6MXSym98PF0W4Ppygado7NZgDZI
 1yDBPDKa8dJr60x9lhgJ4h9Rq1jRcaWWee3bO+IzySzaqkIqEt5pqEt33YpShtDncHe0T4QZetR
 b+flh7NwQOsn544R0elCpRobdVqBzzvITk4fFXYExdNjeeRBJJt6FsSKFhbZpkZVCGf/wJ69byO
 xj8tifMoPRpxh5rU2jU0POKrOzxhuxfKnmRL1sKdxO+D533SDbgvoVzQfFAJPbgUYNdcDEzXoE8
 yguwRQT0FCWaR3np4RBbJz1zXiruT1f//tH3v9/90IEupwu
X-Received: by 2002:a05:6a20:c709:b0:3dd:ff93:a99 with SMTP id
 adf61e73a8af0-3de0e73d7b6mr16731290637.25.1790699932364; 
 Tue, 29 Sep 2026 09:38:52 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v2 50/61] ml/cnxk: use kvargs numeric helpers in mvtvm
Date: Tue, 29 Sep 2026 09:36:53 -0700
Message-ID: <20260929163800.1108305-51-stephen@networkplumber.org>
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

