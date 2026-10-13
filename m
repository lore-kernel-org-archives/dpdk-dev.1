Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447ABCC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A93C84069D;
	Wed, 14 Oct 2026 00:35:12 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id C522140BA2
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:10 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2e623eda81cso21109925ad.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930910;
 x=1792535710; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+toDJcO+IBhy0znUe5s4dpV6ckQ/Z213y0w8eDUQJVk=;
 b=tdGwzIqtvg8avuE1YiBLVL5B+YTfty5xINskwC3zUxEuQPPA04NXJggYHVTn3yO5+F
 xFMFf3Jc575g0m55gk5AvWlCqzKogaDhUITGkcYE6yNApJvtt+u3vNm7Gwy2DGHXt59u
 eVck42BQ9/CzAjg/FKdYykzjdGjcBwFNlt3O9+MMm2xZ/qTcWHDrsiWvtTSgbniG8esG
 yQuR236qm3RlNDEHiPwu92Nuu1Efo/mXhYgkgXEobDVpjR4Nv3ABPV7y9cCnQHqqiMGc
 iOjRe4t8oMd+Q0HMg/kXfpdwvFcIV7G3HwNB9pvtZe2S3/6R0szt7TNyFw9IC2OVVGOQ
 ILYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930910; x=1792535710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+toDJcO+IBhy0znUe5s4dpV6ckQ/Z213y0w8eDUQJVk=;
 b=eQ1uj7NZ0l5KbvunYLPIHnrDSwF4Adw16VHhKSkmsaRkYoUyetyx41hYapKJ5xuwow
 B+KZJQ3dRN0XJyMsvtwCFpnpV2azOdbvoqz7W8k1lqWdo95IkqMtNHBYRfXKgUMcLWvH
 5WTChsoDGAlR4TUyrJwbNfoN7w2Cgv3lsrY1Q9E+jL6xa0/NrIZVgM7IftU66WRYBarK
 nz/oDUkJ391FUsgi3adxXHv7dd+6qnWXOGBZzxiFAd/zt5dnF4UzVNxEX3tOp9ebfHCj
 lzPMBUBKQpoKyk0kioLUYtRfI0UWXo6iERM1MwJjQyUr2PKJ9Kq9gsqBLfzROa6F6cW3
 UVrg==
X-Gm-Message-State: AFq9FYLaw0cVHgUjzX5PWg79H1QAXOJGOLWgZZI8RZ3LQivblXeNchfn
 BCKKgHkGVnQI2Lo1FqoCz5TF4BjeX9xptd759RX7C4e88239/DH80PDRY47ztpi62uAtaIlxG1O
 rjCG4ENY=
X-Gm-Gg: AYBFou2oX68E+8DNLSpOvr+H3EFESt7apQi/VAQ1xqKFWN55/NDEOYyhEVQCwFCD3Lk
 vBFIsKH/uPXs8H0M0eprtlXSjd5rIVwrWIJ36U+Gd11rMYRpUeZ4YVIHoHegj8H3nj1AElb5d2/
 wQPrbEXyWfzdZF1ai+5LMjmAWxygURHtvSbpgMQkzjpCrZPXVTyU7MdqMpMs1M9+rBvrV8rI7Yl
 sRO+3wD3hC1sbGytRrj+8fS1zCEY90yQuohWF8LJdZruEn9BXlnENEQ0GSGaSC92UEAuLQihOYG
 BsIh+sI2qe0XKoWGFZBDPLkl17pEoCJIoc+D9HtnlqPcZ/QJFaTrWbx4i4teVfKp4OzzQcGS4eE
 btnSywmHv6my2AjoeoM/warY+mUkHa3DaUrqbzT0dewreWxZBClkPSAaZxQFEairZwmQq0LV9Gn
 qQ7PT7pMQPf5BzoMZQKHVwYRB7wzsKb9Qgo26kRjdgNNL9zW1SuLfoJxsJ3yVLdZdLJZQE7pGBg
 /pgKnKbIHVs2D34lmDcRwsEBCp7AAgBf4EtPw==
X-Received: by 2002:a17:902:f60c:b0:2e8:4f3f:60dd with SMTP id
 d9443c01a7336-2e84f3f6347mr104764625ad.37.1791930909856; 
 Tue, 13 Oct 2026 15:35:09 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 14/29] crypto/caam_jr: replace rte_smp_rmb
Date: Tue, 13 Oct 2026 15:22:27 -0700
Message-ID: <20261013222410.2257622-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

Replace rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/crypto/caam_jr/caam_jr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
index 104ce52d11..a7d314bfab 100644
--- a/drivers/crypto/caam_jr/caam_jr.c
+++ b/drivers/crypto/caam_jr/caam_jr.c
@@ -572,7 +572,7 @@ hw_poll_job_ring(struct sec_job_ring_t *job_ring,
 		job_ring, job_ring->pidx, job_ring->cidx,
 		limit, number_of_jobs_available, jobs_no_to_notify);
 
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	while (jobs_no_to_notify > notified_descs_no) {
 		static uint64_t false_alarm;
-- 
2.53.0

