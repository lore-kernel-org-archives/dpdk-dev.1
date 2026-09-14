Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEBCC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BADB40FB5;
	Mon, 14 Sep 2026 07:51:48 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 8DB65410D0
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:46 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so1350645a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365106;
 x=1789969906; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tZF/Y9qrrrrdhcxdFFhF8quoE2AEBu36EzSyLFlxFq4=;
 b=EIP+iYC2CGcfYni455+oIxlLUnGXSdG5mXMjy+0TfZQizoPz0eWzQR7pLRwjPNfCut
 q2BkXcvVAIViaKBS+kCP/Ox8JnJuvxoVKkEsTmrJs9L5j56bowXJfExwsrgTG0LcK1QP
 kLmMXOMpz4wfDTq2ZeZJqXC+e5rWQky1lMSejm4ZkZ40z/J/Hx4BsGLoX2BiwaZFGDv1
 Ex3tjeCzfqmePf6uggObVqMEHwfTIvDvIYG933lk00/IgIqkRIv0FyBR60BWhG6nFNar
 JUuBBcQIO7MvM0eTNpi6EC8V3RPrOYn4N6/Quax6Vp3PoyFP7moG867WGtVvGAbGeCfM
 dy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365106; x=1789969906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tZF/Y9qrrrrdhcxdFFhF8quoE2AEBu36EzSyLFlxFq4=;
 b=DQPj9u2gctVhOKxeAAQG4xrf18wjj9Q266myvXnDLw7u92kL2KkrlnDoq3UAGeigwm
 mV8+oxOIrvq3zh4dlIAzkD66/h+U4YJnNOHh8B5q9QCvXHoU0SS8seuNWXOzEEygzTI0
 7C5oV2g24h2gQGJdKFrxsDDBrlfBAoEoYoEfrlWevbPLqE9ka170F+tY9/eGlgz0r8v6
 lq8geUSxX086rwlJiXPWnPcjJpxENlGo5ti/szQo6nDOVyNOT+peBeP2n1nYwWfLtfFh
 QOKsBpQfQNIbtNJbK6sJXMMIxinFLErcaaIyNJNt4vE3Z8jmp5yWb79uACSEtEjqfdHW
 HHuA==
X-Gm-Message-State: AFuF++mJT9wZ5REinQtN6MJ+T/E+bGD17xPLGCTSNHjFAz27OTkCn+IM
 4/hNRD6X6zBkfL/wzOCu+ldJKXyhqavp2vXI/Oi23Yz5U9CC+smTAFM0ckaMVX4+1MqjwCjrFv4
 KMEK42kM=
X-Gm-Gg: AYBFou1QWjWSjMA8Jbce0F8VoqvG21QCaWcIJqpUOgAmPXsGXAZDITfyCXxJ/j8vRPz
 Gg7453xhjhMp3VxkDEQRvkJqsKucgm+Kwza3tQSYchP2zTT2W5MAQc2wXoUQIZ5j+xqb1+DsBuL
 s6tCachXgXbzU+FZex9/Yf90znU4t3UrWiHQawonEmq6AHdclK5hPqpaAgsWhR6WyKSs4bHg3oN
 MPYiMx7OhxVsm36+zcGJ4mDMY0aDJoiC0wVBslORu72N2ZgOp+TFjHEuYibdeAShO26b7ZSxwgU
 xNIyfpm/waH/bia7SzcF744IL8NY29t5RpZ8NkryAAOR4pyOeVrRmm3j6Fn44ickNJ5vI9TRqUv
 WI3eNb/6+WGfGadOYXirxEo+rMqB3GqMOpGBsKzhi0Z6gu45cglk6NCTSCzMwYjr809JZY3btKJ
 H9eD1JNAMx598K632ZkyujXSV1nJPeK5D1OWM3+gn79jv0rCYVcdxa4UCvHqBYVtcdTV9qjObtl
 6WJyitPG6qKV7iBqOgXmPtp8aRwcudDbbGMxg==
X-Received: by 2002:a17:90a:c2cd:b0:39d:f2a1:3a with SMTP id
 98e67ed59e1d1-39df2a10424mr48423a91.15.1789365105574; 
 Sun, 13 Sep 2026 22:51:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 42/62] net/nfp: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:13 -0700
Message-ID: <20260914054912.755403-43-stephen@networkplumber.org>
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
index d2da18013c..37005a3cea 100644
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

