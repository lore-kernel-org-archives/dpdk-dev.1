Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D8EC53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B03A040A89;
	Wed, 29 Jul 2026 19:57:33 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id C472D406BA
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:28 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cea3004256so15384415ad.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347848;
 x=1785952648; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNhhrhYuiHFZhREb3ay/JGcqu8rktEuOvU9zdqljMWU=;
 b=JNlLbOA7M22quKbLpWwbroK/E/ZmR7+/YzIa5D5ZWqJNsxB7Nuv33OyWgtLdPlREs6
 EAKlb98BIM5UwSL2TnItLIS+OMIixnAarZQI/+7sp5yi+HSQ8L1iKlPWAFR0oeOr6ZMK
 qtTHTreATqgy41RnqTKCn7uT6sRVwSu14VRtezs1XUA5sMh9T36YPatRnSoUI2IwhRdy
 r/CnX4M01BD2JiQcRUrJvGf1dP952RUvf2VERWTRC3j7lgsOcdD/KohxtNEZN5ODqLg9
 IU8ZvQRKxoyjlH5kuQ8vUyJnLsanrGgwDN3Zk/9B3qnhdRlrt1iJWL3KrpSNSQWXnxJy
 TalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347848; x=1785952648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PNhhrhYuiHFZhREb3ay/JGcqu8rktEuOvU9zdqljMWU=;
 b=Izz4yPTxhxd1nvO8NVyA+AW1RkfHoLgoKJ6AqK4Ps0krmKDBMaFeRhnKrY7Kb/we6x
 YoL3gnjVxtstGQkDuRGJiwREXGlQXPCil+9zoQO0svQkSCnz+XKNcAIRWEdfve3oODiY
 o1MmGAhRVlaj3h8NSxqFY2xe8K0lyA8gkH/ieK/m2a7/mYIgMb7tkAkxfGJ/asdGQ/uw
 EYWzydaoQ1ez4Z9/PwKh5VRVjrunLihmUFvSv1RIE2ELtfLM3u/EzWfQl8r9rB1Tfipt
 PXB/RhAvCV3RXmR+3olL/w81Lr7oM6R507zpoFSEDAiZHgBoESnqHVx4GhMSUTO3+G9x
 3/lQ==
X-Gm-Message-State: AOJu0YzNAGtWAe2w7LbIPyZG1QKzcy3byn2o9Pq66a9dC2cPEv/fMJwa
 1k879ODXpVgAk6IxhEvQyT5vEEW1ahed6hW6zkUECfuiIdfRFdn+qWqQl2mDxLJBXy0hPI0+BdZ
 3lq89
X-Gm-Gg: AR+sD12ETrSXVW8lTIUR4oHBeWlI7P+tsXmnA8CZUA1pVULPccztMwe/Udr8x6lhxBm
 fwPklBZBiLsRwrY88BdIqHhC4aQGJB4+nwkKBv0RyII3DYKo7LIlToiA8ZpSpyZ0Ll0o9AGmufC
 YderbdtITLS0Z4XKjX246/RWqCDa07KUpkafxaWmffJBo7wih+jq8f6OxVJKk5pEMBvmXD5oYx0
 A06vOlHeXk6VZ5rGpv5tlUzaS9QS5WtIbAcy59YD6bQe2hJAamKS41dUrxz8OBgNPy9mhXtjt9Y
 QZrIlku5ApuZXsXbWp664VSq4wxZIA6fEnamw2+oNtyy+iF6V/bi12XYQG4BeGrwXJD3qxJZs5M
 IrUc2JYHtAkkeLIyL7xD28GEzL+Dw+zgq5yD6hpRki1EzObSse/cSxSn2xXOekZauYlhfM1pBbx
 RLxa79Ks9VmMjQSBeRZT5NnXEOsVv+DQ2Yh0lZbBods4AMMKJLfo4JQ25zU9zpHet9RDQ5yT0kP
 +ek34ov4G558s8PEvDk7U5XV/M=
X-Received: by 2002:a17:903:160c:b0:2ca:bba:b35c with SMTP id
 d9443c01a7336-2d015c37989mr89359015ad.31.1785347847929; 
 Wed, 29 Jul 2026 10:57:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [RFC 09/32] crypto_caam_jr: replace rte_smp_rmb
Date: Wed, 29 Jul 2026 10:54:02 -0700
Message-ID: <20260729175715.165120-10-stephen@networkplumber.org>
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

Replace rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

