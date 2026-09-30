Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB074CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5303142F89;
	Thu,  1 Oct 2026 00:44:32 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id F32CF42F7F
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:29 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4c0da0145so807842a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808269;
 x=1791413069; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D574+uCnceRAP6vSmKiTiGViZJS779f1qW3F9bdMGlo=;
 b=KsZSC4T6+6EbYim5SHPhajexjVX6aps3MPDcGmoKM/OJKMfI5LMEhM7FbJ8JdDf/B3
 Y7hAIShoT3aeqqBwt6DQx1MVuu+7LNESHCVr09skyV2Q/Llz35NxDgClplPA0MDQzkMZ
 w+zvShQOf00GdFhJVJJMWBpUop8K70zPsyZDHgpCkFE+hpSXlzRLkTNlMTFrdUunumSe
 mPki3EczjFAW/2pcSneCWXqcWsrVc2UBcLb9SR8jJI4gQ7DGbyAWq3oef3JnqB0u8I3D
 mzZ1YgE1tFk1FA4Pd+UdtvM6mNNuWU1ZMlKVl86ZvvSEnOfz92eWmjSHAaV08O98wNNG
 GdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808269; x=1791413069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D574+uCnceRAP6vSmKiTiGViZJS779f1qW3F9bdMGlo=;
 b=P5bCGBXk3mrGl5mnJGTwKuLhO/uGhyj5aG8UQ796uU+LHOV9GyuBaJH2SA4wG3apAm
 J2++GYxQs13Vvyv/KCUxkKhgMgBUC/m3xDgG3w0HI9u4v3kAh9xFvlZzQGvPrA2SlF2j
 NI9cdJ45riQAN2ycJI6MpOiHNm0Ixf5HHWbCI9PECvJmQMFZ7BK1tliquwnH18onjbC8
 sKTbPsybDxHEeiDpObW6GQQP971eFX5OJtAwF+UgcCV47nQe2mC5g93aDHWQm/LJWC82
 Vd1vyk2wFTjdto0wXtANz4tDqaIUXGob3omCezGYBzXBJ0LKebpintwxVj8oo4BTGIfJ
 qWGQ==
X-Gm-Message-State: AFq9FYLCWXk9aX8pw0UskkoXxPNXixjpfH7zW8Y5G3ZOb2VnsFugLWTZ
 yi2aZivTix8czwASLJj3OlaCJgyX04VWzU/UFlzYZ+eJ17a9FRkR79FvQdGRUUbSIYYRKR5RpMR
 h9qx9mK0=
X-Gm-Gg: AYBFou2rgKQ8Cuvnxcfmh9TBqwtL/qP8bTjo3ipk8aoPFoM5dv0R5AayL+DoSncDb6O
 soIIG3SmqdOqyt98qCEsDrcAPgdVkcpG9uDFCT08FaV+jo8F8tPcDl5s9lpoPHuwZUNBJxDgZAw
 1ybbzxbbkx9jGJAFFdi9ImeElSgOldj78a4AR0/W8y4H7nSrf0eFWbmLteeZ/WONqMmBVkujnTn
 eGGSbCegCv5Lgr0V2+cx8E9sZ7gMvkCfYXrBrdO2XMmjpMoGHfq1CMgSgujjM3jCQhoqet4+8lf
 ESqJ8fsoM+5kRD/MM/144B1id1lMvvwmlV9Wg1Jx5Gie0Wr6BvzLTffkgf7bNP7Ga+smhApbCEA
 mDkWH6PRh7utwoPL3rsyFAiLZKnNXQaS6RlJgOXZlsqnq1Gcj54+6vBDhjCPMlNKFGmXR3MykAa
 dof2XLJ9gLXui5RZFjHYgW0a2yUlS5Aaa5rgdcfdFB/S9NYP5s6lCZPuEkYnwYr158So2YDbMKE
 OQHwRyAhtSkN0IEjKg0mXNCL908NWIjphH9Dg==
X-Received: by 2002:a17:90b:4cc4:b0:3a0:a515:c450 with SMTP id
 98e67ed59e1d1-3a4d164ee7cmr2197957a91.27.1790808268990; 
 Wed, 30 Sep 2026 15:44:28 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 42/65] net/nfp: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:00 -0700
Message-ID: <20260930224340.58580-43-stephen@networkplumber.org>
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

nfp_devarg_handle_int() infers overflow from the result being ULONG_MAX
rather than checking errno, so the literal value 18446744073709551615 is
rejected while a genuine overflow of any other value is not detected.

Both users of it parse a boolean, so use rte_kvargs_handle_bool() and
drop the local handler along with the open coded 0/1 check. The
documented "=0" and "=1" forms still work, and the usual spellings such
as "on" and "true" are now accepted as well.

The boolean uses rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_ethdev.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/net/nfp/nfp_ethdev.c b/drivers/net/nfp/nfp_ethdev.c
index 2f7ce812e4..2ad1f12e5b 100644
--- a/drivers/net/nfp/nfp_ethdev.c
+++ b/drivers/net/nfp/nfp_ethdev.c
@@ -48,28 +48,6 @@ struct nfp_net_init {
 	struct nfp_net_hw_priv *hw_priv;
 };
 
-static int
-nfp_devarg_handle_int(const char *key,
-		const char *value,
-		void *extra_args)
-{
-	char *end_ptr;
-	uint64_t *num = extra_args;
-
-	if (value == NULL)
-		return -EPERM;
-
-	*num = strtoul(value, &end_ptr, 10);
-	if (*num == ULONG_MAX) {
-		PMD_DRV_LOG(ERR, "%s: '%s' is not a valid param.", key, value);
-		return -ERANGE;
-	} else if (value == end_ptr) {
-		return -EPERM;
-	}
-
-	return 0;
-}
-
 static int
 nfp_devarg_parse_bool_para(struct rte_kvargs *kvlist,
 		const char *key_match,
@@ -77,7 +55,6 @@ nfp_devarg_parse_bool_para(struct rte_kvargs *kvlist,
 {
 	int ret;
 	uint32_t count;
-	uint64_t value;
 
 	count = rte_kvargs_count(kvlist, key_match);
 	if (count == 0)
@@ -88,20 +65,11 @@ nfp_devarg_parse_bool_para(struct rte_kvargs *kvlist,
 		return -EINVAL;
 	}
 
-	ret = rte_kvargs_process(kvlist, key_match, &nfp_devarg_handle_int, &value);
+	ret = rte_kvargs_process_opt(kvlist, key_match, rte_kvargs_handle_bool,
+			value_ret);
 	if (ret != 0)
 		return -EINVAL;
 
-	if (value == 1) {
-		*value_ret = true;
-	} else if (value == 0) {
-		*value_ret = false;
-	} else {
-		PMD_DRV_LOG(ERR, "The param does not work, the format is %s=0/1.",
-				key_match);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.53.0

