Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DD4F47CA4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:53:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CC4342686;
	Thu,  5 Mar 2026 18:53:37 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 6CC1A410FA
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:34 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-89a07f66f4eso47145756d6.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733214;
 x=1773338014; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MT0Nx6ezQYKvnIRN9g+SmqUUhb3O8EFOkdEYJV8BRfk=;
 b=P3Bvr639FOSXNV+UOgYxI1fklhZbOWBf9ubF3gOo8i4WCJzdjoeloZopxcuPz622df
 iubgy9KmENMuPhgtSqblauvSDQOmW8YPL/SvPywi3b9NvIWPyaKLXEbh1CEvwexoZGYx
 Hp9tAFFFoc8//MV4cxAC8BB1HA/eOXhz/YnzQSRBDJKmOwegfDn7gI3Vhb58BB30B30B
 QNU3/hbkjF8VD06dTu4u65jsJgfhYVv1XvO4ARam7LlEvfQnwyNc7Go9j9IxbKsxoE+5
 62CwsNkzG1nXPblGg38TQ78klKxFR/OujTMMK8z6ZE3OFcRWfW5ILwpvmJ4JasLOYD6K
 gysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733214; x=1773338014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MT0Nx6ezQYKvnIRN9g+SmqUUhb3O8EFOkdEYJV8BRfk=;
 b=biSyAzK9IjBdYn4CZhN1x5FH7g7vn2r2OyNhXr48/jLG1zBPFiCEdCVAv18bwwWdEq
 81dpEly8B5Qet0Mv0Vy4IyV/+cSIUxSMFwjXP2ucagZr+H8P1Bq44hGlpSrdGqMr3U/n
 EQr+sfEj4y8T+6WZBllbIbCdnXK1L9k2EFkfB7Vjp+iMPKzqKhqOLos7ji6DNhaWuqK3
 UbhY4qDxtBqui6/DBJ86rLp2v5PiP9dlJJbRXnym/sJK+33vinN1QoBy42XAkyJ82LJ5
 pD9qPU0t4zVJ0by+fXm9He1svxnpcvMRIJdIVxwR9vdF2w10WWYe6+qPJdahxZy2+5/t
 Qw7A==
X-Gm-Message-State: AOJu0YznCXqkv+oJQBVIQNM7/ClmOUtL2IRx+qe9psDmKFSS4NBYh9em
 7nL19O6ROgLvRMlvvKtPqj1LM+ilaBfIuM8VryZsgmGN+JCKsDpTkrS/jLtseXSxbc3abkjO1xL
 deL6T
X-Gm-Gg: ATEYQzwBK0GjJ6VMUIdm1EJBYUQu75BJYc34C2EF7NXRrXToPxQW/1tA0ZHpObnG97R
 J49TRyMA4FnFBYWrx8qsxDmC2C3KJS+2mqM139kmcwOWEYam0pDijVTylNTTwOSEgOcUPcKVLyg
 U+qlzVcJHUK71D6G4Xp0hC+TAGtKJOeg+MsBuZDhZSEeMGTLferw1D/kSRA+V9JRG7d3GUvVJYV
 JtJoK2fqtl2/Vk4TbRKxgMsEaMryBkoorrReAvEhaQ4mV7n3jQ/ZMUOf3lnDza2G01UbU8shYTj
 DVMocJEyITDFOpNxKlEq/s1hjH7Bo7z4UDLoQUodeWK0MFvUK6BTFxBA1NJdTEwhIk6k9QOjKpE
 tAFPK+x2Ec4/2hLpQNtOlsUxOeB4HXHilh3G3ZzhBfFX56riVOtclmulVFdkm1xPVFUZwg4gW7M
 mIMZbLp16mCaEDFMECL5wG8qcyWgCuuUaEgPmkZuKDFnaPcikiRpH9kjsOF+QKOcCYpWxuMki5
X-Received: by 2002:a05:6214:21c2:b0:899:f8c4:5c with SMTP id
 6a1803df08f44-89a199acacfmr101216076d6.22.1772733213711; 
 Thu, 05 Mar 2026 09:53:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 03/11] test/mcslock: scale test based on number of cores
Date: Thu,  5 Mar 2026 09:50:57 -0800
Message-ID: <20260305175326.279891-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305175326.279891-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260305175326.279891-1-stephen@networkplumber.org>
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

This test uses loops to synchronize but has problems on systems
with high number of cores. Scale iterations to the number of
cores.

Fixes: 32dcb9fd2a22 ("test/mcslock: add MCS queued lock unit test")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mcslock.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/app/test/test_mcslock.c b/app/test/test_mcslock.c
index 245df99a5d..b182da72f1 100644
--- a/app/test/test_mcslock.c
+++ b/app/test/test_mcslock.c
@@ -42,6 +42,10 @@ RTE_ATOMIC(rte_mcslock_t *) p_ml_perf;
 
 static unsigned int count;
 
+#define MAX_LOOP_BASE  1000000u
+#define MAX_LOOP_MIN   10000u
+static unsigned int max_loop;
+
 static RTE_ATOMIC(uint32_t) synchro;
 
 static int
@@ -60,8 +64,6 @@ test_mcslock_per_core(__rte_unused void *arg)
 
 static uint64_t time_count[RTE_MAX_LCORE] = {0};
 
-#define MAX_LOOP 1000000
-
 static int
 load_loop_fn(void *func_param)
 {
@@ -78,7 +80,7 @@ load_loop_fn(void *func_param)
 	rte_wait_until_equal_32((uint32_t *)(uintptr_t)&synchro, 1, rte_memory_order_relaxed);
 
 	begin = rte_get_timer_cycles();
-	while (lcount < MAX_LOOP) {
+	while (lcount < max_loop) {
 		if (use_lock)
 			rte_mcslock_lock(&p_ml_perf, &ml_perf_me);
 
@@ -175,6 +177,8 @@ test_mcslock(void)
 	rte_mcslock_t ml_me;
 	rte_mcslock_t ml_try_me;
 
+	max_loop = test_scale_iterations(MAX_LOOP_BASE, MAX_LOOP_MIN);
+
 	/*
 	 * Test mcs lock & unlock on each core
 	 */
-- 
2.51.0

