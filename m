Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C4EF34C63
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 16:47:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 597AF402F0;
	Mon, 13 Apr 2026 18:47:01 +0200 (CEST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by mails.dpdk.org (Postfix) with ESMTP id C93964021E
 for <dev@dpdk.org>; Mon, 13 Apr 2026 18:46:57 +0200 (CEST)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-46aa216a65aso2522360b6e.1
 for <dev@dpdk.org>; Mon, 13 Apr 2026 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776098817;
 x=1776703617; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mh6kartIOUf+Z2FIk3If/ITs2JwoDsjP86+8485vO2A=;
 b=VJn5B5Ry4Uxv+y7nTXVSL24yOqrY1EPzEngqeBfS3lbFHqFaHyG4QEdjaXp26nJQlk
 WakmEIznxgWgQmja+nK+LRDKTWgKClS0BCZ0K8pRYtRJ8stXiESvRtrT1I3tR+zUJ7XS
 aBIQ1CH9LGWL5ZbOC7L4e6+ALMAD9GGPKnkQ8m+Te2q5SpmdQgni30Bj3tcuzVNappQJ
 xRgbs37SUswVT2hMiYZ/OCs6JxkSKU561cxC8GG/fNRy6YexOIrIbh0/dTOW5nxQcild
 NazTCoaMn5lZUl0lL4hDbKTKIqWLAmTkLYKwt2ycyfUyHTSFQ7EPjaAH8t/Tt9yT3J8Z
 OxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776098817; x=1776703617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mh6kartIOUf+Z2FIk3If/ITs2JwoDsjP86+8485vO2A=;
 b=GM4SMkXjajsC3E7m3lYK3S3qqDQ4Cu87Eb6ZxrJ4nMHds4GXHHscWPr2z5v3u68gEl
 4SCdYSvryD61itudK2IKKX/ufJWlbaqwMVLJcEMl7X/FZSA3AXcgpMVi6e04yCA6gi1n
 K1sB8Qln4CgfJtP4492obPOv6ugPkybvL/UUcn8CHw1+AXu7N67OmztJOlWnpJro1M4o
 cGt8DYD8gs4baLKfpNEHIsfrT/6xms4E7Yac85IaIIMZKjaNaRmBGJH7GU/bKi7oVuyZ
 B2QeNGtgTLJOWg1k06hn9O1htELLYJzyrJmG9+06wOJyDLwz57I4sglih1uqgtSRQ1gX
 noig==
X-Gm-Message-State: AOJu0YyXANKM2SGsaRMX3bgC+8ysZpW+YyYKCPysuIueaYtsIu5T+AkV
 FU/MZgGoAjoIDmI2RGEWrUObMEdYLSttFnBW0eHBMu8ZJy6HW5geO9wlSRWpvUnhuo4IQdKE2CM
 Q2Xsv
X-Gm-Gg: AeBDiesqF9dEpQ8BwSJtiSWcbV0fz+14qS4qTCWQB2249Qx/u4wBg447NJGGj8Zmnpp
 udr3LmPO9CkfSM8w8MR9MwDhPkM6mxwOMeymqrnp4psUscAfc7c7ZDDg6JGP/outjp9XlQ9AkdT
 /wvNMljtB/NnEMVn+wBNHMS/XJg7MWLfVQtPu6yhI7Q0WYcdkCEyEAz27s3mt2ZeVn7Uc5j3KYc
 Cg9jvwoeBkf0VRa+G272ScV3xE/R0wJSHnzoiwQHbBSY7T6P84vfc0tQguCoDgM+YdG9xPIimnx
 XONygDk8I0CUJU7YZsT3G6QNmAa4Gd9+xgZZ1lVU/ncsvPg1KciuPaKHljzyD9N2xBekmCO07C6
 r8tE7hnLY9oOhVS0ObiQP7gAsHugCilhfgLQ5A8FR/8pbcDTTwR/4hhr/bT0VzIWTvPaS9xUm0z
 HUN+ICLAtZfYbe5SHu1CHhykNXakQ+d9eWLI4VXKXSLj4=
X-Received: by 2002:a05:6808:244e:b0:467:13b5:8af2 with SMTP id
 5614622812f47-4789d95100amr6650688b6e.5.1776098816929; 
 Mon, 13 Apr 2026 09:46:56 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc3959099fsm6218089a34.9.2026.04.13.09.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 09:46:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 1/3] net/cnxk: add pause to spinloops
Date: Mon, 13 Apr 2026 09:45:29 -0700
Message-ID: <20260413164652.33291-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413164652.33291-1-stephen@networkplumber.org>
References: <20260121180845.889190-1-stephen@networkplumber.org>
 <20260413164652.33291-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cn10k_tx.h | 4 ++--
 drivers/net/cnxk/cn20k_tx.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/cnxk/cn10k_tx.h b/drivers/net/cnxk/cn10k_tx.h
index 8c912a1f35..7657b06190 100644
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
index 8e64d2e352..ac0b00ef31 100644
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
2.53.0

