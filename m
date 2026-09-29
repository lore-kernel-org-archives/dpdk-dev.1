Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97359CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:44:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E14D142F51;
	Tue, 29 Sep 2026 18:40:34 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 768A342E15
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:57 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so2784839b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699936;
 x=1791304736; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jnZo+hvqBlg2VdlmHakxJKIQ9hf0r/SuePtUe8eV9o8=;
 b=O4OfLZCldVrvDRDF2L3CmON4odfZ3stvkTGqvrDuZCsZoctpvypiPx+9Znj52FjqHq
 LKcsR8RM3Ar4DF03FBKVzzJ9895OCHcvXnFPD18Niv+ReTNt/yo+K5qqVmibn7CSb72p
 YTasoTBJjqgM9Y+UOUzaUYZezmplzE6SaYGp9wBf54ZQTJ5hA+xmZA4EpBsPHL3csmjC
 HqxcO2LzZco88/cWEbaIvOEj1rscSuK2we12uZ/J8dFoRVg2UVmwWk/r69fZO4udwm85
 FwEmc4/S9GoyIQh18DidhCTseBzV9auMuuEAg8ZqOitpgIoJkuSn7odk4PhVOpJGpagq
 cCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699936; x=1791304736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jnZo+hvqBlg2VdlmHakxJKIQ9hf0r/SuePtUe8eV9o8=;
 b=bWGOvFs8VAfiqticnIwsVP0O96ZRm42MatxS7JEYOIBT7IHshnWTuQEsKwgSjlkhKW
 4RFw8SMunID6HQQVOF8WmR4edtjgMe/tViF7/+DyljCCJbh7HlO2dqiuoYRBF0PXYj6u
 FaPZOaD9cK2L8qffS4Ns9ghVfzDA7lZ0VjqgpyVvVyKUG7QZV6qPZrVl34t1a/Io9bh3
 EjG+07ZljOByCwZgfqb4Cm/KpCN19IdwU0AY+ymT9uCuEIKuNiFxPY4g4ZtQP3uqmJi1
 G7+ae7vzEFouRqKeZ180IyfSNAxX4NIrMIwQwvkETGXqVMJtVxgWmMNkQaDnBZdEmvrW
 nlBQ==
X-Gm-Message-State: AFuF++kR6UYsH9NNuYRvvSCwrXUYyexgjiuyn4LOvVIqYRvoccCjZr5O
 uGdxkd9IUQQrpw3aFwiB2PT2u/ocZ4ZaWDimNwHNvK8S6JyD5ITQDA2nEeV7F3yF5qaY2jGxqBz
 l/aEzILH/4g==
X-Gm-Gg: AYBFou21mPkWVFZwZipVWQWiy8BpKu32siWe32WBooHfl5lrUAlcduJOQfj6eLO7F8/
 +LlImEI8g7dtsgE+IonI8KSxdqGR92MKyGA6Zxm83jDH+93F95Jcx6MDypw4Vq8pCBichGpl6cb
 T0UaQ4raMr26ovXnAC3FtlVSnZXEVGqP0jG14AtV2TvcYVCsn2BLE7ZFeZo5DFHxExnRA+h9BpR
 F2rhuxqokEKv4/nFNRXfflpjHUKQ1Yl0pMNnrObISa+lgFPrk98y/5jBFivgfR+Dr3N8SK6qQFy
 J5nSziZCXqFX/WXdvEsK2sH2xqX3fEcljrZncXMvEjaIr+H9HTEPP1ue7xkPNfmu5bqU8JAAeVl
 0YMks5YrK+b3VufGPCEdIKSG4HrOkuD5cVCsu6DfNAdjQRljOrsr60wNj4zL3KImmyUH5+RMEVn
 E60jAK7MMQ9pzOraMShJDExiVF8ERuIsxSmrPbGq+GbaqoSgvCrucl40oo4oM/q70sGeZRBO3uy
 UYbhJ4nthfEum4jDAgOr/9BcUCGHRpjLqyj2A==
X-Received: by 2002:a05:6a00:9298:b0:874:706d:856c with SMTP id
 d2e1a72fcca58-87e9b3b9e0bmr15389458b3a.29.1790699936548; 
 Tue, 29 Sep 2026 09:38:56 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v2 55/61] baseband/la12xx: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:58 -0700
Message-ID: <20260929163800.1108305-56-stephen@networkplumber.org>
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

parse_u16_arg() stored through a uint16_t pointer and parse_integer_arg()
through a uint32_t pointer, but both device arguments are 8 bit fields:
queues_num is a uint8_t and modem_id an int8_t, and they are adjacent in
struct bbdev_la12xx_params. Parsing either argument therefore wrote past
the field and corrupted its neighbour.

parse_u16_arg() did nothing beyond a range checked store, so drop it and
pass rte_kvargs_handle_u8() directly, which also gives queues_num the
width it actually has.

The modem id keeps a handler of its own. parse_integer_arg() rejected
both ends of the range, and a plain rte_kvargs_handle_i8() would accept
anything down to -128 while the caller only checks the upper bound, so
"modem=-5" would be stored and only fail later in open_ipc_dev(). The
new handler bounds it to -1..LA12XX_MAX_MODEM-1, keeping -1 which
la12xx_bbdev_create() uses to mean "derive the modem id from the device
id", and replaces the caller's upper bound check.

The handler now rejects an out of range modem id, where the old check
did a "goto exit" with ret still zero. The probe also checks the result
of parse_bbdev_la12xx_params(), which it used to discard, so a bad modem
id or queue count now fails the probe instead of only being logged.

Fixes: ee36ba0f3042 ("baseband/la12xx: add devargs option for max queues")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/baseband/la12xx/bbdev_la12xx.c | 60 +++++++++-----------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/drivers/baseband/la12xx/bbdev_la12xx.c b/drivers/baseband/la12xx/bbdev_la12xx.c
index 1116dacc4b..b9199189e7 100644
--- a/drivers/baseband/la12xx/bbdev_la12xx.c
+++ b/drivers/baseband/la12xx/bbdev_la12xx.c
@@ -912,44 +912,25 @@ setup_la12xx_dev(struct rte_bbdev *dev)
 	return ret;
 }
 
-static inline int
-parse_u16_arg(const char *key, const char *value, void *extra_args)
-{
-	uint16_t *u16 = extra_args;
-
-	uint64_t result;
-	if ((value == NULL) || (extra_args == NULL))
-		return -EINVAL;
-	errno = 0;
-	result = strtoul(value, NULL, 0);
-	if ((result >= (1 << 16)) || (errno != 0)) {
-		rte_bbdev_log(ERR, "Invalid value %" PRIu64 " for %s",
-			      result, key);
-		return -ERANGE;
-	}
-	*u16 = (uint16_t)result;
-	return 0;
-}
-
-/* Parse integer from integer argument */
+/*
+ * Parse the modem id.
+ *
+ * A dedicated handler is needed because -1 is meaningful here: it leaves the
+ * modem id unset, and la12xx_bbdev_create() then derives it from the device
+ * id. rte_kvargs_handle_i8() alone would also accept anything down to -128.
+ */
 static int
-parse_integer_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
+parse_modem_id(const char *key, const char *value, void *extra_args)
 {
-	int i;
-	char *end;
-
-	errno = 0;
+	int64_t modem_id;
 
-	i = strtol(value, &end, 10);
-	if (*end != 0 || errno != 0 || i < 0 || i > LA12XX_MAX_MODEM) {
-		rte_bbdev_log(ERR, "Supported Port IDS are 0 to %d",
-			LA12XX_MAX_MODEM - 1);
+	if (rte_kvargs_to_int(value, -1, LA12XX_MAX_MODEM - 1, &modem_id) < 0) {
+		rte_bbdev_log(ERR, "Invalid %s, must be -1..%u", key,
+				LA12XX_MAX_MODEM - 1);
 		return -EINVAL;
 	}
 
-	*((uint32_t *)extra_args) = i;
-
+	*(int8_t *)extra_args = modem_id;
 	return 0;
 }
 
@@ -970,20 +951,16 @@ parse_bbdev_la12xx_params(struct bbdev_la12xx_params *params,
 			return -EFAULT;
 
 		ret = rte_kvargs_process(kvlist, bbdev_la12xx_valid_params[0],
-					&parse_u16_arg, &params->queues_num);
+					rte_kvargs_handle_u8, &params->queues_num);
 		if (ret < 0)
 			goto exit;
 
 		ret = rte_kvargs_process(kvlist,
 					bbdev_la12xx_valid_params[1],
-					&parse_integer_arg,
+					parse_modem_id,
 					&params->modem_id);
-
-		if (params->modem_id >= LA12XX_MAX_MODEM) {
-			rte_bbdev_log(ERR, "Invalid modem id, must be < %u",
-					LA12XX_MAX_MODEM);
+		if (ret < 0)
 			goto exit;
-		}
 	}
 
 exit:
@@ -1062,6 +1039,7 @@ la12xx_bbdev_probe(struct rte_vdev_device *vdev)
 	};
 	const char *name;
 	const char *input_args;
+	int ret;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1073,7 +1051,9 @@ la12xx_bbdev_probe(struct rte_vdev_device *vdev)
 		return -EINVAL;
 
 	input_args = rte_vdev_device_args(vdev);
-	parse_bbdev_la12xx_params(&init_params, input_args);
+	ret = parse_bbdev_la12xx_params(&init_params, input_args);
+	if (ret < 0)
+		return ret;
 
 	return la12xx_bbdev_create(vdev, &init_params);
 }
-- 
2.53.0

