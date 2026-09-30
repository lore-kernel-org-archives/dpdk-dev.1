Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9ECCA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB58D427D8;
	Thu,  1 Oct 2026 00:44:41 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 67F3142FE5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:38 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so2644154a12.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808277;
 x=1791413077; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R9eLFuSirUTcrzKlNnryWcQANxQNfKX4rwdVS3XTQPM=;
 b=fLr/qJTUud6xL5TsMCabCc4FUUP+dSlJ7Ys0qPPofFEIQYoCQ/wSDedBQ+vHpiZcvq
 xg4AGu0QTiEN0445G9JTmlSaypTO88jUMSMxHCpc56qiPFnDHHUxV2Bebhm3S47IxsSc
 /pNzp9R6w6nS0UAEh2b5ZBsoGuC0qX3+UuIRLnAoqTR9fM09HdzWIG/js1dP3bBusMZZ
 N/Tb2HyKEk1dANnIkJD3q0aYW85wk3ftQjJQJbtX/Ar1wcpFWxoCUiGhpv9eNLv8B7q/
 O82HShVnmTvggE/YrARua6w7WWkmWWR1x3B3Ky3U06pR5xHMjB3wQPsvqtzZH2ADe/Zk
 kxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808277; x=1791413077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R9eLFuSirUTcrzKlNnryWcQANxQNfKX4rwdVS3XTQPM=;
 b=b7xDyeAP6KwAaIt3NwuQoSKSU+gzlITA5XrjBoDkeI6yEfid0V7YExji8EUzL604je
 ZHnTdl0EdXUNgK47H+OK6CzztsXdpKLmpF/3e+GMFWV1RBmc1EqZfu7xq+WAHT3h4cxo
 xIHunbP4OYnmFwtD8Mg2eUEEZeFscLeG+C9wstRN7xLPA1sz/fCYyxzyx1lcXcz7vPZK
 lsNAbvg7Y3uMCIidHJSU5nctwntH5gfEI5OfufMna8BA3A0mKkdBCKTXPvDC2jV3BrKN
 pegKSGhtYxT/8bdlm7YvhVwc6J5R85249QOeAA7oz1HZDZVjbu2AjR26TFYIqhrvF82M
 QdxQ==
X-Gm-Message-State: AFq9FYJ2DM5EEvoEvlCDRBiTNyNhtfYznOL8ZkS6ddJHyj7htHkN/4kw
 eZdpcjGGSR++JbCzahnjqOx8gWKvtRvR0trRQVgG4T53BBYH7vsctxDxBojUBTUeXAVTQI3It1f
 IpIMBRFs=
X-Gm-Gg: AYBFou0VClJRAWdlzUjES1t31JdBhhkzcpWJDOOWHQAx5Po1k5pB4NWb9yAz29NtpPn
 69uomJCoXuihCbuC9AfmpRfO23iibYfYr9K0ELUvjvmZoyrSWWKd/ICZi2yyPvHUhdfos8dlLoI
 0FGcP1jh6lt6cduzXvr4sDZ/QTzTKfId4B957Xdlf55NVg91c9oPmB88wAieICDQYg6Y/pMf10V
 v4nArURO7LknhBkeIPF2IobYYkki+PN1/jrZjE/BZxREG6/Ta8cxbE8TGqDTZOun5OXMgjQA0Yq
 ryMCKI8/LJ6bf9ij29na8R2GxOQO78bWFwr0snEaUrRI1AsaLtSVIEjagKm/L0TnJyD+kraczKZ
 XPw7fSGfRI4Mh/BXSYHMQEPQAODYZWWLtLgDmKS/rAEUadF00yH3jpU6AAhL8V3V87OFsGni6Kd
 pBU8JiY1qXl88siJ7p/XksRJivDHmgzKHCjmneOTwjLIJWhZmslgd6oCiubSvhmPTzbKoyHUU19
 gX6MpZy7dP1gOg9B8pusKjlHXBMAxktGrHPcw==
X-Received: by 2002:a17:90b:2885:b0:3a4:c52e:8126 with SMTP id
 98e67ed59e1d1-3a4d1b17cc6mr1985348a91.40.1790808277571; 
 Wed, 30 Sep 2026 15:44:37 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v3 51/65] ml/cnxk: use kvargs numeric helpers in mvtvm
Date: Wed, 30 Sep 2026 15:41:09 -0700
Message-ID: <20260930224340.58580-52-stephen@networkplumber.org>
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

