Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF03C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:00:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B74940293;
	Mon, 29 Jun 2026 21:00:34 +0200 (CEST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by mails.dpdk.org (Postfix) with ESMTP id E747340150
 for <dev@dpdk.org>; Mon, 29 Jun 2026 21:00:32 +0200 (CEST)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-80cd342a796so23485707b3.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782759632;
 x=1783364432; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/tpeItllc3IhYqkB1umDGhfWGkumICt7S/dB3iAmSrk=;
 b=yU8RHo+jUVjbqs+LPvUPrI1B86ew9l6+rhmthzPFZ22dH0zdcSmVxFQxoFgHtLi8Nl
 RVzOTEzuQFRTU3Z6R/bpIGQFOaDP2zsbDLrYq1aKop9rHBzl6vKuyvRFbU1LqhLnWNP4
 lxtNskf9T1CUA6SjTPlRYADIkcFqZ/DZdXJtw8o8QGLSo0iIYSk7skbOq7hH18ttSm2S
 E3vB/AGGPRyLqzwz+JaxbJMwSJ8IA9EkfBijyY0ABk75JqlKK3dJlfWyOaGwCY6nRr7u
 Glk2OAmqD39DQJh2PDqF4od71BwxNzXqmNgb1QK5n2CV07YftWsDmj/GS4YC2DDcM8ok
 Spdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782759632; x=1783364432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/tpeItllc3IhYqkB1umDGhfWGkumICt7S/dB3iAmSrk=;
 b=RhX4b0QyYwr5q9Nm1JBZltRWHxyZVSbeJAPJq3j5O0g6yc4D5s6GmwpztoqKqov90A
 1ewIc/WPIvQxkimudLjc4i/IIEszV3LbkowwaAJ0Wl7h+ZwVa2wO3bZ/CZmSu49LSXHC
 Efz3TEMCoumZLp7io9tlXriGpthR7EZtdYzDN2GhnShvMSWyn6VaeZWjIWPe6DwHZSds
 7t1edh0zFs1s1vdzJjVe9ndh5Oen/Ta8Ucv4ZtqEGpw+A0pAjiS7mJkajMaCYaLfafix
 7gPityflmNBfp15tMU6eGxT0Lkhq//zyTksrWY1UwZa91cERl5KxslIJcoTC6Bo/IoaW
 gNTg==
X-Gm-Message-State: AOJu0YyDgltDOlVf1bAn2y3vEo7kv9s5+vLKS/WuEwz0iwx8GozVych3
 X/zkiLl2wYUsxqXJPPbqZU0M0Unv/n3a5scvGoyCkFjyKIvXygudWoplV2b0241dSZoMpsic6CD
 6nauI
X-Gm-Gg: AfdE7clg/zUsnVciIC/QnN1FxIeTPZux8IP2gBVjYT1yLl/Yi0ldpkf4LFXjwT33WqK
 S3qEd76n48f41M7Vy89oYseU1h+x52EDqQGYb7kQ9ZKWsOJ1cS2VXsSXWrpx9GVF5a72eRx9FkN
 3OXVSbKazWnOwBLYEfAceoQvP7qSJuDVU0o4rq33aR3sqvgqamEu2xzIinYglLOR0033fu+wMl7
 2jy2lWUuBaJPMbCJHA4wtD2DSUnvDJlT0x+fJCHLDrShOY0ocGdlRnmC0FOz4RE3x5EImEBAmk8
 OKWtFzY8btuSDiHLzyIjVw997YpXwRYQMgtdNoeOt5YzmOFWKzocUti8pRMMhglNkTsbJTbGhwV
 RSlpaHnI0MXrRw0cRkNnw/Fmfe8YMZsRyAQ1FIkOHpg+j0NP+2j3RPPcwgx+2+e4vYZ12909Hzr
 fZEEcC2YWmC7mWvTEQsWEcrzh11E/zaYQOQ1HLpZx8smcfxEjy/Ow=
X-Received: by 2002:a05:690c:7093:b0:80a:9f1a:d48f with SMTP id
 00721157ae682-810dac04c32mr8312837b3.54.1782759631979; 
 Mon, 29 Jun 2026 12:00:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-810e728a009sm1747287b3.5.2026.06.29.12.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:00:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 1/6] eal: take experimental flag off of rte_memeq_timingsafe
Date: Mon, 29 Jun 2026 11:59:24 -0700
Message-ID: <20260629190027.2071745-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629190027.2071745-1-stephen@networkplumber.org>
References: <20260625160200.24170-1-stephen@networkplumber.org>
 <20260629190027.2071745-1-stephen@networkplumber.org>
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

This function is needed in other places, and don't want to
have to propagate allow_experimental_api into those drivers.
It is stable enough and inline so no ABI exposure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_07.rst | 4 ++++
 lib/eal/include/rte_memory.h           | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 4ca0a9ac77..ec227fd90d 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -241,6 +241,10 @@ API Changes
   - ``rte_pmd_mlx5_enable_steering``
   - ``rte_pmd_mlx5_disable_steering``
 
+* **eal: promoted timing-safe memory comparison from experimental to stable.**
+
+  The inline function ``rte_memeq_timingsafe()`` is no longer marked experimental.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/include/rte_memory.h b/lib/eal/include/rte_memory.h
index b6e97ad695..940770f1eb 100644
--- a/lib/eal/include/rte_memory.h
+++ b/lib/eal/include/rte_memory.h
@@ -747,9 +747,6 @@ void
 rte_memzero_explicit(void *dst, size_t sz);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Timing-safe memory equality comparison.
  *
  * This function compares two memory regions in constant time,
@@ -770,7 +767,6 @@ rte_memzero_explicit(void *dst, size_t sz);
  * @return
  *   true if the memory regions are identical, false if they differ.
  */
-__rte_experimental
 static inline bool
 rte_memeq_timingsafe(const void *a, const void *b, size_t n)
 {
-- 
2.53.0

