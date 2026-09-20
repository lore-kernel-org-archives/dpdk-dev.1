Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BDEC982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 064EE40E44;
	Sun, 20 Sep 2026 20:14:15 +0200 (CEST)
Received: from mail-pj2-f25.google.com (mail-pj2-f25.google.com
 [74.125.227.153])
 by mails.dpdk.org (Postfix) with ESMTP id 33BD04060F
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:09 +0200 (CEST)
Received: by mail-pj2-f25.google.com with SMTP id
 d9443c01a7336-2dd4b43b20bso15135135ad.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928048;
 x=1790532848; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dA2dAAWCysH9z+bD3VzsE/DeWK1GbENs/7aMLE6HYIA=;
 b=vftOtQXKyGEn0tdMoaTUQQDva7KVfsHN6W9dTYx4sB4VdxT4RsOoJMYyEHxNBENF/j
 HeJvOlRMutl6FIRca0IMK6lCMDqOLAGsw6fzChFq4cfdkPd5yCKwyNQ6tjrDHEFSw/1y
 n/sl2TB/Kjzy6fZsboggMFicoHH4SOdikJG1WIFy/LU0wlkYczjWOCx+1GTQkZar+jA4
 u6l1JHYiVSUC1mqUQgL91+j7z2+0PXhLCGqeVQGZNCCLmZWi2WoGBWMXLT8D+mxm/N9z
 eOnTqbBnZEjCAriCb2tgIFDGnL47f2UgBKSniNH4z71AoViiR1JUpvRKIwaXATMsg2jc
 zvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928048; x=1790532848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dA2dAAWCysH9z+bD3VzsE/DeWK1GbENs/7aMLE6HYIA=;
 b=bWYjamgt33P+fJGhP6+e35wY3pPI0CjyAQR/fwwRoVSDIjS1VQRYt7/1sUNGJgP8LD
 ac/gLsXk97Ch3zZhu32NeKyMz6okQjgxSViSTaAlyjMcBKW9tBLd/NCY8eQ/hM5ZftjD
 NU6+rwIEwTK0G6WElCwXC0+O2FW47CRZ8hwZMtIUMrPPxHv/Kayxfxfsk/RIcsiRS1m4
 FuPbzuezzyNj9c8oMWyqatpIh1Y3H15hnZ3QNqfUf8BHUtz4uhXomuyFXYOCJhrzqpAf
 8LL4+Gv+uwVNzNJgHFpQ3sNTedPA8182P4cQ3C1biqDlGe5VL6qsBi8ut5WkCyLPRgaK
 7dEw==
X-Gm-Message-State: AFuF++nFJMI6ktgSUxYG3b8hqUhxsC08+pmi8ExTYDC7rSvi0/My7GEW
 EmlvgtTOUi1xIxj3JXK0i9GHB/RRSlNOCNlVRZ+8W9AiFf6bu1SaZ9oF2qi7quCZ72kKd87XUTI
 kct3U
X-Gm-Gg: AYBFou0va9EakSWroPhVdt25H153J5XQ0F9ncnkyobEeLtZWEZgaN+a/TJ6zuM+4MnY
 bIb2hjLMe6//xvQujgH9oHjn383VSYpM61MSR5n38E+vob84yV5FnaDllFk88F8xf2sv4TxOIWw
 aj7ToCPPukkw28vqLM0fK6O3WQrWE7uS79fezP21dE3pEGhOiUk96F7qPSZ0AK3HE90pWB55Fvs
 blcxce2/0Zl7wBkTGnlBoA2BcYeN+Orwt/419aVTr2xYU7mJ8dVx/s9UyvDraRJWR/EMlGjcgmR
 A9qciapMjhmeLIZjgfQuwZWEwGyRKMGxbLn4dcfiyrXMv93DvejfloWLBKjhoYxl9oGfHM4gaqa
 /U+LhEnR2SXjX5dv29evuQH8EMp6wrNNtzr98HfiTyzEVENhachavLWOF7VCuZdLTPBDNEp3xLH
 7X8wTVGB+G8HcImCjg7yq0C9c3Iw0R4AG+2ZRg2M+q4NoqJGWDY6b0eWdxnS6U182E8knQzrehJ
 wKHFEOegm7nl74VIErkxxGPjOIZ6eZGNJLKKA==
X-Received: by 2002:a17:90b:53c3:b0:39d:f130:8f13 with SMTP id
 98e67ed59e1d1-39e54e3c624mr14473694a91.21.1789928048279; 
 Sun, 20 Sep 2026 11:14:08 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 14/33] crypto/caam_jr: replace rte_smp_rmb
Date: Sun, 20 Sep 2026 11:10:06 -0700
Message-ID: <20260920181347.747210-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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
index a57dc56b80..1f97e72337 100644
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

