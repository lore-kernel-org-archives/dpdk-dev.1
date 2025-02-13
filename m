Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80991C021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:19:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 314CB40673;
	Thu, 13 Feb 2025 23:18:41 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 8B5A940612
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:37 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so2339125a91.0
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485117;
 x=1740089917; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNJHgWrp7PrghusG1EGUIcrHmq1efQC46Cm2w7NVkN8=;
 b=xEUs+i9r5WyaPpj53a+xwrF1oUVOLwEkU2WX/VBu/7k0cf+fi3GYLLSeVTWWerwD6H
 AU0sayWJ8JXe8CseYsJg23tQD2DBbYMuRO1f7oBpClUPuYqtCZOIVshlVszwhaKp2+RN
 JBiBkCDvHuFAT/nFsLrZjVuYkhpz0jC9rFeEK7dIbYBZS1m2hA4vJuy6Q3X0O7lcRg5s
 x6gs2qKemi0PnIwWEpTfFEjgY/8ESPUcmn4tfPgTM0Lq01qpipE+dYxBAXxpNLMEFS6o
 jfLuQof1HoNKPafpLWay8hYNF0WkOaM56DVMCrvlqZhgYoO5UQN0HDhJbOcax13rr7hB
 /stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485117; x=1740089917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNJHgWrp7PrghusG1EGUIcrHmq1efQC46Cm2w7NVkN8=;
 b=Ex2tC74TNq5xgF3ZanRgCjOutmeFy//QC5b7VV6wauKYlSllU9TMXPDLSb3Yrg1LkU
 YpxlOqyVWfVJPgUpQdx7VuCwSh81Pu/U59F/ZKGUbEaiWpxS6L9kjDWwpN4GgNAgUa1X
 wm4izeZiZTFVBu8uyrjtG/MH9FkYkNZmoq4Ycxge6+QrUVtaOkyzT/ipojuqP3PG1Fmg
 da/bEGcr/PFzFkP0T9U4fnI9fziiDXBWq2iC8JtmZb5F1JBVSRsR4NUKaT+Q5be0Br4/
 BmAjCEz5bq1ol67OxrBaWUVbydUM8Q6LP7qCmlDdpsc/eK13Kl4T5EVdRbwPcOjQoHNd
 D+yA==
X-Gm-Message-State: AOJu0YxyG+jykgQrdVeBFIVHz0ozAiRWDkLek8uTO8tXYK02eXmeZnGR
 tQxE6BOEogd8wazxEJ6rQbKHkdFPmDu3r8HjorebxXoHNrOFLunt6VJBIFWTukBhawxjfSWuXhA
 Q
X-Gm-Gg: ASbGncvM/eIubhnWEswNUZ59LDdlpHHwstwCDMu7sANk8rrji8hTqnlj9EZNWUKqd/d
 G7EU3GI7NU2VV6IdtLQvkOjLTxVGLEgL4CIHK+bwAe4O07wDDFJXbvCeCpg8JIeiMjYTWK5Szzv
 UtcwSAiF3r0EERVG1l5sXHmUx8jMMTfeLoKgjqES2lHU4AJDSGWh8h7m8WB9eJgDnr7bye0v0Po
 ndW2zE+T+IjBmRY5tpaMYmeBqaED3tD9K+ZN8hcpWeuFjskSXpnUFoK+/qyiaGc1spWkwNY+O97
 fcnI57RBeaVUn5awCVzsFtfbVhUd329yPjPmOyOcE7jCKVUvNqbj5rc+SjotN2Ru6Trn
X-Google-Smtp-Source: AGHT+IGchBI3CLWZrtl6mUF1o54OtuvE/3QbgjZtrggt+a6GBrlPN7XxtnV41bGk5e6OOKVRqiiz3Q==
X-Received: by 2002:a17:90b:1d8e:b0:2f4:4500:bb4d with SMTP id
 98e67ed59e1d1-2fc0e7a307bmr6599893a91.20.1739485116763; 
 Thu, 13 Feb 2025 14:18:36 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v6 05/11] crypto/qat: use secure memset
Date: Thu, 13 Feb 2025 14:16:18 -0800
Message-ID: <20250213221819.1856769-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213221819.1856769-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
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

Regular memset maybe removed by compiler if done before a free
function. Use new rte_free_sensitive instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/qat/qat_asym.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index f5b56b2f71..d8a1406819 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -102,10 +102,7 @@ static const struct rte_driver cryptodev_qat_asym_driver = {
 		curve.p.data, curve.bytesize)
 
 #define PARAM_CLR(what) \
-	do { \
-		memset(what.data, 0, what.length); \
-		rte_free(what.data);	\
-	} while (0)
+	rte_free_sensitive(what.data)
 
 static void
 request_init(struct icp_qat_fw_pke_request *qat_req)
-- 
2.47.2

