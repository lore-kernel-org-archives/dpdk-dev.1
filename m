Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880F7D46BEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:02:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0249440A77;
	Wed, 28 Jan 2026 20:01:51 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 6A4D140696
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:01:43 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so165826f8f.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769626903;
 x=1770231703; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYlqT9ZAhN9JxyV35Fm+0KZ/SI0RGcb0ou6qTTkDRBw=;
 b=NBybDIKmZBCFkoceMQZL6pdM7SxZn43Txp3BoZb1vc0W5sfPevyGJ9dMR0aVCtosvR
 mERBK5nyjbsXhXYDQ056uGbDvOMinBsPRHXUg3fGVlNtvZKq3M4xFNcUd15Wy7oSCfDr
 ClqNIa/YiBXk47Yn1uO0ZSKP6ohYoMAXlvoiROQo2Cc6cxbF+kmqpCSUBjN5StWZIhsz
 l28VCM8O5r4BgBCDb8kZU0TC0nSwU7FVp5KdoQ9bZl9bBONsQ2CTqLRR8A0R9w+xRQwd
 nyO2fuzlys4Ei+mS+Sehpng6FfrmbgD/YXK4mlGJE0NRWLuKX5J15b2+qNqcEh7oicwG
 fvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769626903; x=1770231703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RYlqT9ZAhN9JxyV35Fm+0KZ/SI0RGcb0ou6qTTkDRBw=;
 b=Ll8EmqaTtnMOeWaE+0hAHxf3WYkQEXFr2LdTBot/obwNWUV9eo4uZ2uSuye/rHRS/i
 ro8SAmb+rf/zpBiB+N3Q6PJYfNCx16/9bjI+kmnNUO173k3y5EGNjnps+c1ktiThiLs0
 mBHyvd0rmr0Cwj1b5Hxd2kcqLv/qZZ/zi1+aXRlFDz/rAbiJhMwhd9Y9DDTRuJlqGdPy
 Nd5xXJg9jfOyL269NSlrd8fiZo5lT16aXx+NL5pzVOpLcBahcOV1RxSL5fq4IszhWMuT
 JgYKTcgtkcTIXsE4Rus1M+6FT45RP35wlKElqbswlbuTR6fkAZ31BZO7eg8m6W0S3O9M
 UmOQ==
X-Gm-Message-State: AOJu0YysSJyMmFPToYGGlonNeNYj+RoMY7CNB4M1qA3sOiobYarOV4nt
 6gZyDfDLMARVsH8IokiicBzdekuX3f011fyxV4EPcC3z8EYzdhO0f4yfV7ug4RIWIaVvJlnVBAA
 ZJsXh
X-Gm-Gg: AZuq6aJaFXwcEgyYDssSfSa3sOvoHc8oXIUEihh5ESQ4kVAm2JLIVvz+HJfmxW8T/3v
 SFliARwf59bnlimE9MYhL+Noko9vPmSSXMJJaxRYTeFr+g89+xAG2Ko37eJid7Te4Nj9YwU+7gF
 Vijhfa4ohfnFPD22XIvDWp7iMroRm4CGDoSPo/Xfz1zdivdfTA/BcyH+JiE9XhzTPF3qOz/Z1Pj
 KB8eQzn6OHXxrAw/wihJYJNA7U+/0CoFYi4Df1PNGDHw3srHniTOrZJJ/eOlFrxiJaPUK9g/k2c
 1zrqALMn9z7yeOB37/b+/CZlnveBxWk9ADYFgKTLOctxj9vVEbQDYMRAqOzxPMG/2E330yoKdvX
 ttPmllw66ikEazusOJNHCt17llcoz1NMFAV3+ESQmJIt8q4fpwc1Dx77OmicQTkSh1STLJvqiM7
 X+b5ud+mmjH3o00tB4BNyZwHvZH0ndtSKLXrpKJH/PKb+C3Fagfw==
X-Received: by 2002:a05:6000:4282:b0:431:752:672b with SMTP id
 ffacd0b85a97d-435dd05a81amr8118976f8f.14.1769626903014; 
 Wed, 28 Jan 2026 11:01:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm8673333f8f.3.2026.01.28.11.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:01:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v8 5/5] net/null: check packet size argument
Date: Wed, 28 Jan 2026 11:00:13 -0800
Message-ID: <20260128190127.465743-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128190127.465743-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260128190127.465743-1-stephen@networkplumber.org>
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

The size argument to the PMD can not be larger than the largest
per-mbuf data segment size; otherwise the logic in eth_null_rx()
would generate an invalid mbuf.

Fixes: 4df90194f2a2 ("net/null: prefer unsigned int")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 4b4d996686..aee7754654 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -611,14 +611,17 @@ get_packet_size_arg(const char *key __rte_unused,
 {
 	const char *a = value;
 	unsigned int *packet_size = extra_args;
+	unsigned long sz;
 
 	if ((value == NULL) || (extra_args == NULL))
 		return -EINVAL;
 
-	*packet_size = (unsigned int)strtoul(a, NULL, 0);
-	if (*packet_size == UINT_MAX)
-		return -1;
+	errno = 0;
+	sz = strtoul(a, NULL, 0);
+	if (sz > UINT16_MAX || errno != 0)
+		return -EINVAL;
 
+	*packet_size = sz;
 	return 0;
 }
 
-- 
2.51.0

