Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F2D10F9958
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 16:20:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9208540663;
	Wed,  8 Apr 2026 18:19:55 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 98AC14065A
 for <dev@dpdk.org>; Wed,  8 Apr 2026 18:19:54 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so7199343eec.0
 for <dev@dpdk.org>; Wed, 08 Apr 2026 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775665194;
 x=1776269994; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xr3kwQbl3QyMD99al6P+lCJtLWoe4rg4jrNY1mIf/S4=;
 b=lYEy/ckGvGQvaKu1i2S3lwsQMGNEHTntw+H0VfCLd2MV2OPS/WBhc/nw0nx7eAZmRK
 Gl85b19n9lH5SVqRUt1xzm0dgAP4VIlL/g03hwV4fVyQgLGm7nT7RTRIytkYOc0vRk+t
 BkKp34TgVz6qFNaCc/+WEEZ+Vq8uj7rp+oKYUJsekkdY2ho9gRr/mJtW51/kL50YEsRd
 Dt6jhP4qpRm8+rEjhnwKVtp0rcuGwf4//c2HDIrsPGNyst1YEdXX7LPpvKm1KMqyC5JU
 CE2rFTqcYiaDLsbOMj5THd9mBTG0Ak0D51BHBQmKRSGaUsd43hFzvbLe95t5Snu1jRqF
 VHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775665194; x=1776269994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xr3kwQbl3QyMD99al6P+lCJtLWoe4rg4jrNY1mIf/S4=;
 b=HflXk5ikjt659koWrQg7AK1DeNi9QgfPfhw2AI4PCCRA98UWFOJmjAtDmakHhe1Lqf
 fSgRDrl+eICec8TMhylXAqqHB+GMXwB09oArcvDyO/OanY/IYdqUwqWOR4greQCSBM/V
 mUrmqsybsHd9IyObLcUpCi1yklStZs4tQR2bjFJ2DwRX4bgNYc6d0g02dk2fUzTMNoOA
 ct4uwMhqCOhmpR1uWjPsedV/WNP2R0+T0ITKQ3knqpGzWJkloVcziXhu6wfE9NkIMBJS
 D/+mM/m4B1kTFn/461wAezdtSxknSCMmuO/VHcs4XA9uB/KO7uPkQvPRRImCOaYb5FfK
 0nTg==
X-Gm-Message-State: AOJu0Yxe3HfY9VsNkXne2piIWPLIwlwLHYgUKh4pFOf2afHggKfAQX8t
 yDotlWDY0qCzAuJjwBizH1RUKIBLcx+2B8DgAmeh4HvOVGtySVivfhToBTeSKs0wcHteoJ28Nxb
 kP5qO
X-Gm-Gg: AeBDieu/M/sCWrKYj4fycj1z0MjHT0AcS1pSKhInCendwBgQ1m7A5fRZb9JadKUDH8Z
 zTPZu42IASjd/ddGj2cbAqPEJkAQ3on4OW+5wqficzn6UwRtqMUBo5q1Lln/JEhxJub+/1hA9rT
 q+i+q4M44wNzq0v8VnQc3T7tO3bPsDP6AQkqEbEeSnxBEoB5AHFLHJyXuhYsel+mWSvorI7P32M
 gobwzedkpazjkpXkQAuPUkAVnD6Wy7c+lWgckX38uuube47VQV3nz5vauMctA6o8RsiECXPUYAQ
 AlS/1kZan9T1RNRhfSQcKPo5KcjajlgoZ72JvEpAC8UzkAtBHlfOShBbaa58Q+40dhF5PNNZc5Z
 XzRY7q4EqEVzPgsXmfO8SCf395HhE9vOr0JXBcPvvc/CiapnTzxjwTvC/M/ScqVhh6rSRoy14Ri
 5KGlhRCKzWKPM3CkFdVgzfzEpA5ICxDUVO
X-Received: by 2002:a05:7300:641a:b0:2c8:7172:3b8d with SMTP id
 5a478bee46e88-2cbf99ef517mr10370147eec.2.1775665193578; 
 Wed, 08 Apr 2026 09:19:53 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df5ed3sm21080062eec.6.2026.04.08.09.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:19:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH 2/2] ip_frag: randomize hash seed
Date: Wed,  8 Apr 2026 09:16:17 -0700
Message-ID: <20260408161947.285185-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408161947.285185-1-stephen@networkplumber.org>
References: <20260408161947.285185-1-stephen@networkplumber.org>
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

Both ipv4_frag_hash() and ipv6_frag_hash() use CRC32 (x86/ARM)
or jhash with a fixed, publicly known prime seed (0xeaad8405).
An attacker who can send crafted IP fragments can precompute hash
collisions, causing all fragments to land in the same bucket.
After bucket_entries concurrent flows collide, new flows are  dropped.

Fix by using a random hash seed added at table creation time.

Fixes: 416707812c03 ("ip_frag: refactor reassembly code into a proper library")
Cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ip_frag/ip_frag_internal.c   | 18 ++++++++----------
 lib/ip_frag/ip_reassembly.h      |  1 +
 lib/ip_frag/rte_ip_frag_common.c |  1 +
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/ip_frag/ip_frag_internal.c b/lib/ip_frag/ip_frag_internal.c
index 7cbef647df..382f42d0e1 100644
--- a/lib/ip_frag/ip_frag_internal.c
+++ b/lib/ip_frag/ip_frag_internal.c
@@ -9,8 +9,6 @@
 
 #include "ip_frag_common.h"
 
-#define	PRIME_VALUE	0xeaad8405
-
 #define	IP_FRAG_TBL_POS(tbl, sig)	\
 	((tbl)->pkt + ((sig) & (tbl)->entry_mask))
 
@@ -38,7 +36,7 @@ ip_frag_tbl_reuse(struct rte_ip_frag_tbl *tbl, struct rte_ip_frag_death_row *dr,
 
 
 static inline void
-ipv4_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2)
+ipv4_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2, uint32_t seed)
 {
 	uint32_t v;
 	const uint32_t *p;
@@ -46,12 +44,12 @@ ipv4_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2)
 	p = (const uint32_t *)&key->src_dst;
 
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
-	v = rte_hash_crc_4byte(p[0], PRIME_VALUE);
+	v = rte_hash_crc_4byte(p[0], seed);
 	v = rte_hash_crc_4byte(p[1], v);
 	v = rte_hash_crc_4byte(key->id, v);
 #else
 
-	v = rte_jhash_3words(p[0], p[1], key->id, PRIME_VALUE);
+	v = rte_jhash_3words(p[0], p[1], key->id, seed);
 #endif /* RTE_ARCH_X86 */
 
 	*v1 =  v;
@@ -59,7 +57,7 @@ ipv4_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2)
 }
 
 static inline void
-ipv6_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2)
+ipv6_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2, uint32_t seed)
 {
 	uint32_t v;
 	const uint32_t *p;
@@ -67,7 +65,7 @@ ipv6_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2)
 	p = (const uint32_t *) &key->src_dst;
 
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
-	v = rte_hash_crc_4byte(p[0], PRIME_VALUE);
+	v = rte_hash_crc_4byte(p[0], seed);
 	v = rte_hash_crc_4byte(p[1], v);
 	v = rte_hash_crc_4byte(p[2], v);
 	v = rte_hash_crc_4byte(p[3], v);
@@ -78,7 +76,7 @@ ipv6_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2)
 	v = rte_hash_crc_4byte(key->id, v);
 #else
 
-	v = rte_jhash_3words(p[0], p[1], p[2], PRIME_VALUE);
+	v = rte_jhash_3words(p[0], p[1], p[2], seed);
 	v = rte_jhash_3words(p[3], p[4], p[5], v);
 	v = rte_jhash_3words(p[6], p[7], key->id, v);
 #endif /* RTE_ARCH_X86 */
@@ -301,9 +299,9 @@ ip_frag_lookup(struct rte_ip_frag_tbl *tbl,
 
 	/* different hashing methods for IPv4 and IPv6 */
 	if (key->key_len == IPV4_KEYLEN)
-		ipv4_frag_hash(key, &sig1, &sig2);
+		ipv4_frag_hash(key, &sig1, &sig2, tbl->seed);
 	else
-		ipv6_frag_hash(key, &sig1, &sig2);
+		ipv6_frag_hash(key, &sig1, &sig2, tbl->seed);
 
 	p1 = IP_FRAG_TBL_POS(tbl, sig1);
 	p2 = IP_FRAG_TBL_POS(tbl, sig2);
diff --git a/lib/ip_frag/ip_reassembly.h b/lib/ip_frag/ip_reassembly.h
index 54afed5417..9e1666ef67 100644
--- a/lib/ip_frag/ip_reassembly.h
+++ b/lib/ip_frag/ip_reassembly.h
@@ -79,6 +79,7 @@ struct rte_ip_frag_tbl {
 	uint32_t bucket_entries; /* hash associativity. */
 	uint32_t nb_entries;     /* total size of the table. */
 	uint32_t nb_buckets;     /* num of associativity lines. */
+	uint32_t seed;		 /* hash function init value */
 	struct ip_frag_pkt *last;     /* last used entry. */
 	struct ip_pkt_list lru;       /* LRU list for table entries. */
 	struct ip_frag_tbl_stat stat; /* statistics counters. */
diff --git a/lib/ip_frag/rte_ip_frag_common.c b/lib/ip_frag/rte_ip_frag_common.c
index 79ac45289b..00bf9476de 100644
--- a/lib/ip_frag/rte_ip_frag_common.c
+++ b/lib/ip_frag/rte_ip_frag_common.c
@@ -79,6 +79,7 @@ rte_ip_frag_table_create(uint32_t bucket_num, uint32_t bucket_entries,
 	tbl->nb_buckets = bucket_num;
 	tbl->bucket_entries = bucket_entries;
 	tbl->entry_mask = (tbl->nb_entries - 1) & ~(tbl->bucket_entries  - 1);
+	tbl->seed = rte_rand();
 
 	TAILQ_INIT(&(tbl->lru));
 	return tbl;
-- 
2.53.0

