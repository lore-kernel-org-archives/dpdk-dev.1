Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BB3C53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37E9940A8B;
	Wed, 29 Jul 2026 19:57:46 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 418F240A6F
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:39 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so906735a12.2
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347858;
 x=1785952658; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CnsSPltc+ixF+8ZX8o2R5RNtuzhugwKZokT+Iy8aBS4=;
 b=i1BSozV6WzBR/gbQTUW2iWkAIZ1BI3vq642UQqtm01IZmX/x3J2fDw36sTSeaKjEu5
 hUswI4f5C68MjQgq4AQlHEG9+d5Qz9tKovr2yzsYtzYsUsM7eSjm4ydKtpduCHOBfcDW
 XheKzv0PZco1MYOBrlZnYJAJ21sbCq/45jJyGW5rYsD5FqC2GIWANryzbeYdFFT1cau3
 nBWLYRaOGd7snuIR6TqsYUKNGLiV82s7838ovSuUKeyWgyWpJ2JVS5Edf6YLSfkPJCLV
 TW+hJNzD/12+UQJl4EkkmReqAu0hHqQ/Um2UQcm7h7t9ERA+jFUWw0uUu9CpNJti04sV
 RAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347858; x=1785952658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CnsSPltc+ixF+8ZX8o2R5RNtuzhugwKZokT+Iy8aBS4=;
 b=K2LAzTW4xuFqncO7sT1+Qnqymr3GuIu3VACOHRx9ta3G4YPLqVE0KdXEHE+pz9LX67
 fn/Jl596lv6iuKvTg62CmyqnDokAzxA4V+nslXOmdZK+sczPrwb1hYtTiFPSjYNqcH0r
 sGkXHjRkjATi+lVET9zic1lpweDGknFNBuBmbTPcUDRQhbmbEhO/kgw1zC6Fti266JpD
 erRSXHZYdQ9UNjs90bbkgPMHfTOP5JIZOVjjjq53RfcqG4k185mAxb74AHBoyDt9ZmQA
 AzHWNoB/THdQmQ13Ss4YgN9OgDXdw1h3GisS6KjGBtRfb5NiPoonP52I8/DXt6aVfXRE
 Wm9A==
X-Gm-Message-State: AOJu0YyPkGffTvBY07kCqzDqWDO6nBr8xgMsmf1J6ILT8/ncaTKpFQO5
 p/Wd1ssRE9gGnfifsTFUQ0QJnwE5NvcXkfj3Lg8dRX8ofGDwwd+unrBnNQshxrbK8T04O7PgPrr
 Mw0Ro
X-Gm-Gg: AR+sD12T1WmqIpgelFiRoZPGTQOwMfhNiZFRYTYfOq6wpHmkUVrWHpZTIi/KmfqrycD
 yQVCb9R3tQMtacvxpV2KO9fOlUZsJEHq8uFqFPjAtf6PSYfoLNy3M5RZVvTfnjSTxxtKp+xxsHO
 RGVWcwNViirSoLcV80nMsorLsAtkn7TFiM9p6F5aUAJgaCFRZmy5BCTy+qWKzl4zDVRZNIosGbU
 JfRllNL/WCOVaZJWG0mvbUVD4H/KcGs9dFrgUzmxdo4udLXoxVBrJafD52wCmC7xfZfWwKUc9fq
 6xmiNeg43bBdb+RSB/1pYpwU6y55l2/jadHzcQm+nmDAxvso3lSGbZp24DpxifWW1UQSqtQoksA
 rqth7vVH1W9dD8bx73GdwataPeODIuBa4c1sg5SVb2oIm5g4FT2zatIZXblgc0ThvSdkfSLs3Ti
 6Ws4zbMScJZHNuM48lI2NTqcYwSJIbMCB8szCHxBfiJlX0Q8KA/eRBK1s5ikllenNJuDOrwytC0
 jXyTSvHl5kA/4bsOSidVoJyNqo=
X-Received: by 2002:a05:6a20:4322:b0:3c3:875d:7053 with SMTP id
 adf61e73a8af0-3c8aaf8de04mr8660762637.8.1785347858415; 
 Wed, 29 Jul 2026 10:57:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [RFC 19/32] crypto/caam_jr: use IO barrier before job ring doorbell
Date: Wed, 29 Jul 2026 10:54:12 -0700
Message-ID: <20260729175715.165120-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

The barrier orders the input ring descriptor write in DMA memory
against the MMIO doorbell write. That is device ordering, not SMP
ordering: rte_io_wmb() is the correct barrier, and on arm64 the
inner shareable dmb the SMP barrier generated was not sufficient
to order against the device in the first place.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/caam_jr/caam_jr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
index 1f97e72337..7a345c436e 100644
--- a/drivers/crypto/caam_jr/caam_jr.c
+++ b/drivers/crypto/caam_jr/caam_jr.c
@@ -1451,7 +1451,8 @@ caam_jr_enqueue_op(struct rte_crypto_op *op, struct caam_jr_qp *qp)
 	/* Set ptr in input ring to current descriptor	*/
 	sec_write_addr(&ring->input_ring[ring->pidx],
 			(phys_addr_t)caam_jr_vtop_ctx(ctx, ctx->jobdes.desc));
-	rte_smp_wmb();
+	/* Descriptor must be visible to the device before the doorbell */
+	rte_io_wmb();
 
 	/* Notify HW that a new job is enqueued */
 	hw_enqueue_desc_on_job_ring(ring);
-- 
2.53.0

