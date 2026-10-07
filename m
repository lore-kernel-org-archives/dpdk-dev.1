Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226BBCA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23CEE427C3;
	Wed,  7 Oct 2026 23:41:25 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 68EC74279F
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:23 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2dd76b1361dso29639105ad.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409282;
 x=1792014082; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=trZ63WbvdN8zif8p3BSRn4IhH/ZZ0mjThTmuI+TkUBM=;
 b=PRwtpB4/uA5qJ+EmXUhx9MN0sD67rmd1NzG/RoOBFoVvlBY1Qwkah16HOpw6sGqmkp
 wzKRLNb7A3LDme2/i1MUrbPu78P8UgVLoo3NAXZ2EH3rbHPb6tk3AaAvAOy0sRChL79e
 /8C34DzWYeUujvJXhFfYh7CBZlvwupO7kgV5KZL2pwQ9tOhhrZTZ1dssQSbGczg9Y+23
 Xf1fmgmzJgjsihJws1mLGDPZ5PiBcSLfQ91GFlxChfCenv/u53oYLz4GcOP/03mrejC3
 PnOUSJi0J+aFREofmfR10yQ0jL7lew/r9F+MlO68eXCfNc7dPCLmMJ3A/FLbr8KRw1qz
 Ed6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409282; x=1792014082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=trZ63WbvdN8zif8p3BSRn4IhH/ZZ0mjThTmuI+TkUBM=;
 b=0mP379g0F4Sfrm5F3VgUAYVQmJdri2tcgF41nzPHgSYwOUgcqqlCbxIftDOtwqeiD2
 +6AVEwO1JpT0heRFOtK2u6EetDwEOjg2nc/JIPVAbn2pZqQGjZIpeuOktgst+4VRlJtH
 KnV02u9LrrcL4Mox/8AFVgeJhr/KyyRBdF3qhwJ3Wdjv2f98vXvO5nkzexMsCoE+5PqK
 jijxly2WStEuaKwcpAc+faIMHzhB+DDdoBReSrBv2y4Tl53ILZ2nZ2xeqFCccZaHRMFO
 2uT1UKoK7WOeOerXFipYB9lhpwKqe9RR7iQJnbbttWV9vwtTqWWPTXc464MQj9nFAGti
 7INg==
X-Gm-Message-State: AFq9FYIM6awekr/5gmdUg635+OS5imEKX/1w3anh0BPrYw5CiYuPYoWO
 Pgy9+jNbP1lXW88n4mLXl0bqV06dZutTtBHlfPHdsFCbeCYohKeZa0N5vOhXiJWacpIdJuo7szO
 +qMX3ors=
X-Gm-Gg: AYBFou3OhIhBDR1BzP45JzligzTT/EUpq/QMAVDWJgsN+Wd2gEBB4E/GcvUV55JfqYK
 MWJMG8SMu4ViGVRkSkFPRaoEOdZb2t6me5EPmXO3391kO8hn4HOPbD8X4t17vMj0BIuKq1KVHQa
 Ez0Ke5zK+35pPcXvCyVfF0Fdqi5VW5U5PH/NPx8g8q2kEQ9dVGUcQ8jFBW+uh/3rRqn4cKfFIVv
 e5/OVxhAwbfCHvPBEweM7qRhtkST6Hbl0SsgojhyMSDeJf08S76b7si2V5vzFZXl/0uReBkRU+2
 QkXzFn5RobxS6x+LHeMBjcZaPa8WwGQvuo1xf6Z2yE1u/141DAIDimGEEiG+1m4AOIX40aCWW1o
 yFVOQEuO1Ib0FmUM6Jxp7XUeEoGGloycBdI6qhhxV1tr9SxkZ57h98e65E4zQmhZcEU4ObHAssl
 tQ6a1VnFLR0Xh4+NTxs/HyxK2go7zye7yZjxDyeS3OwxyxmVeQ5+24tBPPh3RXF+ozzgSlxrOMa
 hjC2Ldk/KIq1bD+IcQKEqb1nXz17uCYqcPU/Q==
X-Received: by 2002:a17:902:d4cd:b0:2e4:b37a:d577 with SMTP id
 d9443c01a7336-2e6005073a6mr31419535ad.43.1791409282490; 
 Wed, 07 Oct 2026 14:41:22 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 03/20] eal: promote explicit zero and sensitive free to stable
Date: Wed,  7 Oct 2026 14:39:33 -0700
Message-ID: <20261007214115.3092715-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

rte_memzero_explicit() and rte_free_sensitive() were added in 25.07 and
have not changed since. They are used by the QAT crypto driver for
asymmetric and symmetric session keys and by the ixgbe IPsec code, which
are exactly the sensitive data paths they exist for.

An API for clearing keys is of little use to applications while it is
marked as subject to change, so promote it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 2 +-
 lib/eal/common/rte_malloc.c        | 2 +-
 lib/eal/include/rte_malloc.h       | 4 ----
 lib/eal/include/rte_memory.h       | 4 ----
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index 33681e7a37..c12b9e1e7f 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1730,7 +1730,7 @@ RTE_INIT(memory_telemetry)
 
 #endif /* telemetry !RTE_EXEC_ENV_WINDOWS */
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memzero_explicit, 25.07)
+RTE_EXPORT_SYMBOL(rte_memzero_explicit)
 void
 rte_memzero_explicit(void *dst, size_t sz)
 {
diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 388e5a63b6..0c71f26df3 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -56,7 +56,7 @@ rte_free(void *addr)
 	mem_free(addr, true, false);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_free_sensitive, 25.07)
+RTE_EXPORT_SYMBOL(rte_free_sensitive)
 void
 rte_free_sensitive(void *addr)
 {
diff --git a/lib/eal/include/rte_malloc.h b/lib/eal/include/rte_malloc.h
index 0a397e7723..c42006b594 100644
--- a/lib/eal/include/rte_malloc.h
+++ b/lib/eal/include/rte_malloc.h
@@ -53,9 +53,6 @@ rte_free(void *ptr);
 
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Frees the memory space pointed to by the provided pointer
  * and guarantees it will be zero'd before reuse.
  * This function is slower than simple rte_free() it should only
@@ -70,7 +67,6 @@ rte_free(void *ptr);
  * @param ptr
  *   The pointer to memory to be freed.
  */
-__rte_experimental
 void
 rte_free_sensitive(void *ptr);
 
diff --git a/lib/eal/include/rte_memory.h b/lib/eal/include/rte_memory.h
index 940770f1eb..a7749ceed1 100644
--- a/lib/eal/include/rte_memory.h
+++ b/lib/eal/include/rte_memory.h
@@ -729,9 +729,6 @@ int
 rte_mem_alloc_validator_unregister(const char *name, int socket_id);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Fill memory with zero's (e.g. sensitive keys).
  * Normally using memset() is fine, but in cases where clearing out local data
  * before going out of scope is required, use rte_memzero_explicit() instead
@@ -742,7 +739,6 @@ rte_mem_alloc_validator_unregister(const char *name, int socket_id);
  * @param sz
  *   Number of bytes to fill.
  */
-__rte_experimental
 void
 rte_memzero_explicit(void *dst, size_t sz);
 
-- 
2.53.0

