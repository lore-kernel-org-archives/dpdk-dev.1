Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB74C44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 18:08:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CA2042E58;
	Wed, 21 Jan 2026 19:08:54 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 8ED0742E52
 for <dev@dpdk.org>; Wed, 21 Jan 2026 19:08:52 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so1222845e9.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 10:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769018932;
 x=1769623732; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJA55MY/C0inyLr4Di3+te5Hi0pPKdLYQCgxURcYGt4=;
 b=Pqp+Rwemte8MmsgvdvgqkoRVkoo4W5NZH0QEKdKFY6eJMNyRNJWfLA6P3W4A2yzSoS
 YuNPwQ92Hp4aWtclf0S38u02GHGQan5KH8KcvnOyQknQ3WvZHMZCkOYbR8ks+pQf8gfX
 eGmsXdwa3XF+F096bg8ZbOu1pvdZzMN+cegSW/mlUnxrYDNcKT3mAEMFpZTHvvSLNuV7
 TMguFDKBULeCH9PvDE+63UaV/Nav/L5vL5aBERUGkfXAkGk5ymHFORQf78BOUEgEfQd5
 X1BWel1CG9GbmNdJJ/kuAPZLAYqBEHWCZn7PniVcqTHw1DFcrc4272oRADsVr0MGpzl4
 Zwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769018932; x=1769623732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZJA55MY/C0inyLr4Di3+te5Hi0pPKdLYQCgxURcYGt4=;
 b=GZ1/n82BH843S2d/dk0rvQ05dkzAYZMtoV5+v5OC+iNKHhvThKUMyKDrm0NxL+bz6H
 fhTgG8oPIQU1EZ8OfVGf6cnzvcFTPk43aOBkbKStVjEVk0mBckXDmxXfRl+MBBOGWDne
 lXlpzVvA86zmnCbSexgm3orW1K1/rBmAHYOc2VAxbvUdnJHsydIH30dlbZNPiE6aqibx
 S1tOMgWQUE9pKwpco52O074o/XH8yEKHJPkVaTyVffO2tjMu0Pu/YMXNfOZBi7k/UAM5
 /TDX1Dyx5MfSSmzoVDSRMvSOSKIBMvjEVm+604OWHGqHhO9cMvafrE9+0b3K7DEcJPzk
 96YQ==
X-Gm-Message-State: AOJu0YwN/ndE/Oa29z6KDFCsSxGJlGXRtYldkj9i44TmvTv6+TvHaUE4
 HC+GwFrVn340suAMR+to/e/jUZiF+b2rbRkAVdT2RCe87LjeugfHI4HUFz3vBaPtXOkL9XOYLoL
 no7GO
X-Gm-Gg: AZuq6aKPdzni4LoI/odrs1aBX4xvl3IXeJ+LwD5nrUBWzTg+NVkEBvBuXEPAgcX1G93
 nCoWFnhJ55JrZ5ZCfPfCdmN9jG67Q+y5wWrGQhU7jhUYg2If+ciKJKM31k3LXoP4siMRkBvtqMm
 ftR8mJjZ+ReeJmpYOB8qhC6bQsEKqVJjavAkkK2evzCq9D8YWZPhvF3066o/sV8grwCUTE/AYoM
 3FkHAhPdmEMvhC+QEF1PFNTdQkcqk09p/6MixSSyYQUvacBqQP9fyDRz20uXFclrbh+LArh8O9n
 sW3/D1wvwAI+zzDmK9/7agYtcIQUZeOSlun2+OVuRIs1wzei/H8wRewar1+3nzhlbs3o96OvUWq
 z9cjUvPjGpB8GnAWyBQR6s4/ZuTOa/IM5PlxEXoCwhcSEvdXrVzKC5mTTXbsf+0Et6p2tiv9p3m
 LSqKeoCG88hCQpfxVZOfly0IbIGP27oMsQrzD9HSzHCg6AtAb1bw==
X-Received: by 2002:a05:600c:c0ce:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-4801eb14ffbmr187947695e9.34.1769018932063; 
 Wed, 21 Jan 2026 10:08:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c2ed5fsm29093565e9.8.2026.01.21.10.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 10:08:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC 1/3] net/cnxk: add pause to spinloops
Date: Wed, 21 Jan 2026 10:05:42 -0800
Message-ID: <20260121180845.889190-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121180845.889190-1-stephen@networkplumber.org>
References: <20260121180845.889190-1-stephen@networkplumber.org>
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

On SMT systems when a spinloop is done without a pause
it may cause excessive latency. This problem was found
by the fix_empty_spinloops coccinelle script.

This is compile tested only! I don't have this hardware.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cn10k_tx.h | 4 ++--
 drivers/net/cnxk/cn20k_tx.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/cnxk/cn10k_tx.h b/drivers/net/cnxk/cn10k_tx.h
index be9e020ac5..3f4cad168c 100644
--- a/drivers/net/cnxk/cn10k_tx.h
+++ b/drivers/net/cnxk/cn10k_tx.h
@@ -167,7 +167,7 @@ cn10k_nix_vwqe_wait_fc(struct cn10k_eth_txq *txq, uint16_t req)
 #else
 	RTE_SET_USED(pkts);
 	while (rte_atomic_load_explicit(&txq->fc_cache_pkts, rte_memory_order_relaxed) < 0)
-		;
+		rte_pause();
 #endif
 	cached = rte_atomic_fetch_sub_explicit(&txq->fc_cache_pkts, req, rte_memory_order_acquire) -
 		 req;
@@ -402,7 +402,7 @@ cn10k_nix_sec_fc_wait(struct cn10k_eth_txq *txq, uint16_t nb_pkts)
 #else
 	/* Wait for primary core to refill FC. */
 	while (rte_atomic_load_explicit(fc_sw, rte_memory_order_relaxed) < 0)
-		;
+		rte_pause();
 #endif
 
 	val = rte_atomic_fetch_sub_explicit(fc_sw, nb_pkts, rte_memory_order_acquire) - nb_pkts;
diff --git a/drivers/net/cnxk/cn20k_tx.h b/drivers/net/cnxk/cn20k_tx.h
index 9e48744831..3dfad5fd5a 100644
--- a/drivers/net/cnxk/cn20k_tx.h
+++ b/drivers/net/cnxk/cn20k_tx.h
@@ -165,7 +165,7 @@ cn20k_nix_vwqe_wait_fc(struct cn20k_eth_txq *txq, uint16_t req)
 #else
 	RTE_SET_USED(pkts);
 	while (rte_atomic_load_explicit(&txq->fc_cache_pkts, rte_memory_order_relaxed) < 0)
-		;
+		rte_pause();
 #endif
 	cached = rte_atomic_fetch_sub_explicit(&txq->fc_cache_pkts, req, rte_memory_order_acquire) -
 		 req;
@@ -392,7 +392,7 @@ cn20k_nix_sec_fc_wait(struct cn20k_eth_txq *txq, uint16_t nb_pkts)
 #else
 	/* Wait for primary core to refill FC. */
 	while (rte_atomic_load_explicit(fc_sw, rte_memory_order_relaxed) < 0)
-		;
+		rte_pause();
 #endif
 
 	val = rte_atomic_fetch_sub_explicit(fc_sw, nb_pkts, rte_memory_order_acquire) - nb_pkts;
-- 
2.51.0

