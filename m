Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60104C88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA1FC42E74;
	Tue, 15 Sep 2026 21:22:40 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 108804025F
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:39 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea4c7a0so136591a12.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500158;
 x=1790104958; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zDFS7xVKL4kbb4tUY/91HHR0peVYj5129ilm6kQ/6Rg=;
 b=UfUvG/6OqgyGIHCY10zwaZwlN9S2ZfQChImtmXpFbnbzLQuuW7zkKpw3SCly1eh5f9
 N2+FMnFW4LjjHfJBKVNb5KmkUbp1t76/hzQdS2sjQC00XSwXQb2JnMU/pSS7w57VYA1Y
 v7AMtPWKvXYqyVF83HXFSM01SM9WzabVfttHxe0jJslurMsctcOAw39QDVL6sxxb9yCZ
 1Ai/ouYdvj402+aMdZUBy/O3EqzN4WW/K4C/5gQKHQ61rO8IZj+fjxBhsuiThE4zOIb7
 pjmmIiF9898OjSoXlaMXwwb46ryA0g5AWNS2HD/iTWJpngWVWSnQ3/0/VJueXwZlorbS
 N4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500158; x=1790104958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zDFS7xVKL4kbb4tUY/91HHR0peVYj5129ilm6kQ/6Rg=;
 b=vk5dqnZRCgNlw6AJHOGvu67XWBrB7oDrUAgBkFXYTBUTMGJM5GNrNe+ZUS3FbczSmh
 zC27qaDs2CCem5CI9DPEYnTOcZPRk+3Wv6imgL+4yBjQ3f/0JRMfudVu4UijRLMCbywE
 IRCa/rQCTuMu919lqG2VS3neRugeJqpxCRP6JB2kenoRIlL9+ZFzO6DbTvC6sJBK7Oig
 oBC1fqn2VUL1xWGDTRNARfwvVNVFkKCYmake4wetXoY9wK70be0KLYYeZ1sU5JMy5Lrg
 jRwImcsZcyQQZicRVQJLiEs7G8VMlMdZ1a309ozqNUgqGjgySvnt8i4wUip1VVwM8eH4
 chpg==
X-Gm-Message-State: AFuF++lx6bL4MZyQ5kreB3vo4FielE/8Fuc8x8Evas6AaAwSkD1s7p1U
 o4bszjBrQF5iAfAAHf755ljNGgP6Tj+DUYpXDPQhoZJlqxnmQTRoAo2OqBZUPC4oswPwI3Kao9+
 ioJ509iD8rQ==
X-Gm-Gg: AYBFou1V3+ch8FCnrYdya1HGrBHCYpcq6MsqXXMNxJYfpOxxM50ysYullBKJFH19E4Y
 U8HT1/nuxIW8T9tZ7ma2ObuRAp7q6nlcmoBkBQbSiBFLsCS9YpxwOOlkq0vCKaCQiCimLHq+MvH
 +llfwZHxu+YCQyPRFQBgrJw7Q2VZM9KkxnX7L8+pjjOWAtIdyu8IY3oGXohqAlOe2fixXjLrUxa
 pv4rRvhqjhd/B/Sf24VvfDF+c9uANilUsrFy7AvsLgq5NhOukRnEIJ+KCM9zmycOhI0ZQXu6zZD
 Ttp5TeZ6eXQaZBFboI78GFTj/5j3HPrmnsPoA/OE1udgJeuzNg1QGkwmSy8MJ0GFUiddwoUfz3e
 Kj83RNlmUwPFWeCLPgxGNdaTw+FUhBJ4pd1bMuAk2ag/lVoTtBAXn0x51nMuw1qFnHJQ6AN/9Ql
 Ejwo1D2VFecgeD/ktQskFvHhQix+HHMo6e/7eNYu9YyZM3j4oewjCw1YE2ZRFAxzsZ94HCCrhCj
 j0TlH1biLhV68KpSq564htwmD03wu7teL5DGw==
X-Received: by 2002:a17:90b:1b0c:b0:39d:b1bd:b384 with SMTP id
 98e67ed59e1d1-39e1103b474mr4162170a91.17.1789500157926; 
 Tue, 15 Sep 2026 12:22:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 07/18] hash: use secure random for Toeplitz hash key
Date: Tue, 15 Sep 2026 12:21:05 -0700
Message-ID: <20260915192207.3926217-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

When no key is supplied by the application, rte_thash_init_ctx()
generated the Toeplitz hash key with rte_rand().

That generator is not meant to be unpredictable and its internal state
can be recovered from a small number of outputs, so an attacker able to
observe other random values can derive the RSS key and craft flows that
all land on a single receive queue.

Use rte_random_bytes() for the hash key and for the LFSR state.

The hash key is generated once at context creation. It is now drawn
before the tailq lock is taken, since the system random generator can
block until the kernel pool is initialized and that should not be
done while holding a global lock.

The LFSR state is also set from alloc_lfsr(), which besides context
creation is reached from rte_thash_add_helper() and
rte_thash_adjust_tuple(). Those paths report a failure of the random
source as -ENOMEM, which is what they already return when alloc_lfsr()
fails.

No longer use rte_memcpy() just use memcpy().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_thash.c | 46 +++++++++++++++++++++++++++++++++++---------
 lib/hash/rte_thash.h |  4 +++-
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index fcd41248b9..7730ee053b 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -9,7 +9,6 @@
 #include <rte_thash.h>
 #include <rte_tailq.h>
 #include <rte_random.h>
-#include <rte_memcpy.h>
 #include <rte_errno.h>
 #include <rte_eal_memconfig.h>
 #include <rte_log.h>
@@ -176,7 +175,17 @@ alloc_lfsr(uint32_t poly_degree)
 	lfsr->deg = poly_degree;
 	lfsr->poly = thash_get_rand_poly(lfsr->deg);
 	do {
-		lfsr->state = rte_rand() & ((1 << lfsr->deg) - 1);
+		uint32_t rnd;
+
+		if (rte_random_bytes(&rnd, sizeof(rnd)) != 0) {
+			rte_free(lfsr);
+			return NULL;
+		}
+
+		/* deg can be 32, so the mask must not be computed by
+		 * shifting an int by the degree.
+		 */
+		lfsr->state = rnd & RTE_GENMASK32(lfsr->deg - 1, 0);
 	} while (lfsr->state == 0);
 	/* init reverse order polynomial */
 	lfsr->rev_poly = get_rev_poly(lfsr->poly, lfsr->deg);
@@ -215,13 +224,35 @@ rte_thash_init_ctx(const char *name, uint32_t key_len, uint32_t reta_sz,
 	struct rte_thash_ctx *ctx;
 	struct rte_tailq_entry *te;
 	struct rte_thash_list *thash_list;
-	uint32_t i;
+	uint8_t *rand_key = NULL;
 
 	if ((name == NULL) || (key_len == 0) || !RETA_SZ_IN_RANGE(reta_sz)) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
 
+	/* Draw the random key before taking the tailq lock, the system
+	 * random generator can block until it is initialized.
+	 */
+	if (key == NULL) {
+		rand_key = rte_zmalloc(NULL, key_len, 0);
+		if (rand_key == NULL) {
+			HASH_LOG(ERR, "thash ctx %s key allocation failed",
+				name);
+			rte_errno = ENOMEM;
+			return NULL;
+		}
+
+		if (rte_random_bytes(rand_key, key_len) != 0) {
+			HASH_LOG(ERR,
+				"Cannot generate hash key for thash context %s",
+				name);
+			rte_free(rand_key);
+			rte_errno = EIO;
+			return NULL;
+		}
+	}
+
 	thash_list = RTE_TAILQ_CAST(rte_thash_tailq.head, rte_thash_list);
 
 	rte_mcfg_tailq_write_lock();
@@ -262,12 +293,7 @@ rte_thash_init_ctx(const char *name, uint32_t key_len, uint32_t reta_sz,
 	LIST_INIT(&ctx->head);
 	ctx->flags = flags;
 
-	if (key)
-		rte_memcpy(ctx->hash_key, key, key_len);
-	else {
-		for (i = 0; i < key_len; i++)
-			ctx->hash_key[i] = rte_rand();
-	}
+	memcpy(ctx->hash_key, key ? key : rand_key, key_len);
 
 	if (rte_thash_gfni_supported()) {
 		ctx->matrices = rte_zmalloc(NULL, key_len * sizeof(uint64_t),
@@ -286,6 +312,7 @@ rte_thash_init_ctx(const char *name, uint32_t key_len, uint32_t reta_sz,
 	TAILQ_INSERT_TAIL(thash_list, te, next);
 
 	rte_mcfg_tailq_write_unlock();
+	rte_free(rand_key);
 
 	return ctx;
 
@@ -295,6 +322,7 @@ rte_thash_init_ctx(const char *name, uint32_t key_len, uint32_t reta_sz,
 	rte_free(te);
 exit:
 	rte_mcfg_tailq_write_unlock();
+	rte_free(rand_key);
 	return NULL;
 }
 
diff --git a/lib/hash/rte_thash.h b/lib/hash/rte_thash.h
index 8bca430663..4387eb4a07 100644
--- a/lib/hash/rte_thash.h
+++ b/lib/hash/rte_thash.h
@@ -295,7 +295,9 @@ struct rte_thash_subtuple_helper;
  *  the reta entry.
  * @param key
  *  Pointer to the key used to init an internal key state.
- *  Could be NULL, in this case internal key will be inited with random.
+ *  Could be NULL, in this case the internal key is generated from the
+ *  random source of the operating system, and context creation fails
+ *  if that source is unavailable.
  * @param flags
  *  Supported flags are:
  *   RTE_THASH_IGNORE_PERIOD_OVERFLOW
-- 
2.53.0

