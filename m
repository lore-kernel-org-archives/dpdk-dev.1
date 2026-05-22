Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E9DCD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:59:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 483D040669;
	Fri, 22 May 2026 16:59:04 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 91C4B40668
 for <dev@dpdk.org>; Fri, 22 May 2026 16:59:03 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so4591444f8f.2
 for <dev@dpdk.org>; Fri, 22 May 2026 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779461943; x=1780066743; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4GhWBj52hDpdO52kjRD0svusqLv03rZaZ7oV8uT248=;
 b=J7Tf5mn3CezPQEfgChVJFISgJ/6GV5/XmWuj/15XiHrOzGPKMczan18LGe1ssx+QtE
 kE2zlXBL9n+c18IIWt9jz0nsPM31sUKO7x78cH2IxPRE7uGFQw7ULPwCiHbB9MT3pWl0
 diy33zF7NJk0ta0iH9DmcRQCjkIKRK5/u8p8g5P2i/PWCNUihJ1x2w9093zHk432/NMs
 l6sjnUdOvSdQB7CgGFD77ZQ7WAlioI3sDluAQuj98AnwqwVyD9pdgezTABY4FQoes5jN
 GB2V3YuFVEuuCdUVQ2pS9mRu5xllFuTGkdkt19qoeFnHUYVNfg7K7/nM1bc9t31OLCJx
 3VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779461943; x=1780066743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v4GhWBj52hDpdO52kjRD0svusqLv03rZaZ7oV8uT248=;
 b=mhwP5gW8N/D0WnwtpG9Z/QzcwFMKAUVb5JYK7mY68QTj9DnvTeXA5Q8qYK4sDMxhD5
 //clx8e6PkpJwg4JzkUPofk2uSRywmk+wEC6TQHHKhQeQQ1HTBF7Q97CcJRd1FYMKXcf
 q+AKMWu3YaZsQq0aLoNiTOwuQRXI4atSkpNqkg/zqZnBmXZU9mpLYbHdyP6uO0s50U5x
 65ROi1QeZQ92WKztpzyeDTBL9od3Z2KHEi3KlD+GfioERDkTJs4CRY/T/9/lEyNJreEt
 saMGrUSUNrad4odwQdq5eH55bAbQWvBm3G84E9wXw4vll7IhadgbeNM/WEp0In6lVipa
 j+NQ==
X-Gm-Message-State: AOJu0YxE7v5eglzRvP15qAPALVE16lDThiOkAb+c7Xcd7qsJ9YklAP4r
 5hLEivNj4ExXWiUp1VOG8H8Hok15W5gLmOKhRl5GF+ESD6nzdJqafXhFelb7UXhK
X-Gm-Gg: Acq92OEjikL0wc54LmjfYAr+RH76WQNjH0b+7t/IxcnzmEFXNuc1beTQGE7xyzDD0oA
 Xf6CYYElGYFnJQpxhWyYbxWSSmeK2LqFdzA7Xf5GQBW0EAHlzwEV4vyvlPlnruZuy+10Z32sAay
 KVVkmyJqW36kwdG/dPKeG6HfxfC6odYnlQk+KTOU0iJfMWS0npcYGGit3lNRllLZtbDIpoEdtns
 90ISpBZKYKtL9qbqE8aJ21SMAod/aCTv9bd2wdZT+aI1r9N4uYseDpypObRxl5g03MDGNTl8lgu
 G9mygzdqxTlM+yw2oe4mxKdgXibf+3qrvSPZsYcu4E7/jUMws8P1i7Q512yrm/mJOvSezhfaQL8
 Fq2Jus754GLtNeuLAe5rC4pErR1Fkpwo52DwUjdRQ8CEEJCXbLjHVepivNanCUDVQ776nKjUKXu
 ZD00679UN3qJ6Fe1U94vKtWZYNpV2TYL0/57oOUWKDAtDi0rLVgtZ8Kvsc2DHESa0sVw==
X-Received: by 2002:a05:600c:3b0e:b0:48a:65ad:1881 with SMTP id
 5b1f17b1804b1-490426adf39mr60069305e9.13.1779461943130; 
 Fri, 22 May 2026 07:59:03 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042af026esm16476175e9.30.2026.05.22.07.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 07:59:02 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v1 1/5] fib6: fix tbl8 reservation drift in trie
Date: Fri, 22 May 2026 16:58:50 +0200
Message-ID: <20260522145855.1748406-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522145855.1748406-1-maxime@leroys.fr>
References: <cover.1778146229.git.maxime@leroys.fr>
 <20260522145855.1748406-1-maxime@leroys.fr>
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

trie_modify() maintained rsvd_tbl8s by computing a depth_diff from
the current RIB topology at both ADD and DEL. The two values diverge
when the RIB changes between an ADD and its later DEL (a covering
parent added or removed), and rsvd_tbl8s eventually wraps to
UINT32_MAX, rejecting all subsequent /25+ ADDs with -ENOSPC.

Replace the depth_diff arithmetic with the dir24_8 approach
generalised to multiple byte boundaries: for each byte boundary L
below depth, the supernet at level L needs a tbl8 if and only if at
least one prefix with depth > L exists in that supernet. The supernet
identity at level L is stable across unrelated RIB modifications, so
ADD/DEL pairs are symmetric by construction.

A helper count_empty_levels() scans byte boundaries from 24 upward,
stopping at the first level where the supernet has no descendant. A
NULL answer at level L propagates upward because narrower supernets
are subsets, so the remaining boundaries can be tallied in one shot
without further queries.

  - On ADD, count the empty levels and increment rsvd_tbl8s by that
    count. The capacity pre-check uses the exact post-operation
    envelope.

  - On DEL, after removing the prefix, count the levels that became
    empty and decrement.

Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/fib/trie.c | 71 +++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index fa5d9ec6b0..44b90f72ff 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -534,19 +534,43 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 	return 0;
 }
 
+/*
+ * Count byte boundaries between 24 and CEIL(depth, 8) where the
+ * supernet of ip has no descendant in the RIB. This is the number of
+ * new tbl8 levels an ADD of ip/depth would introduce, or the number
+ * to free at DEL once the prefix has been removed from the RIB.
+ *
+ * A NULL answer at level L propagates upwards: narrower supernets at
+ * L+8, L+16, ... are subsets of S_L and cannot contain descendants
+ * either. The loop stops at the first NULL and tallies the remaining
+ * boundaries in one shot.
+ */
+static uint8_t
+count_empty_levels(struct rte_rib6 *rib, const struct rte_ipv6_addr *ip,
+	uint8_t depth)
+{
+	uint8_t level, top = RTE_ALIGN_CEIL(depth, 8);
+
+	for (level = 24; level < top; level += 8) {
+		if (rte_rib6_get_nxt(rib, ip, level, NULL,
+				RTE_RIB6_GET_NXT_COVER) == NULL)
+			return (top - level) >> 3;
+	}
+	return 0;
+}
+
 int
 trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	uint8_t depth, uint64_t next_hop, int op)
 {
 	struct rte_trie_tbl *dp;
 	struct rte_rib6 *rib;
-	struct rte_rib6_node *tmp = NULL;
 	struct rte_rib6_node *node;
 	struct rte_rib6_node *parent;
-	struct rte_ipv6_addr ip_masked, tmp_ip;
+	struct rte_ipv6_addr ip_masked;
 	int ret = 0;
 	uint64_t par_nh, node_nh;
-	uint8_t tmp_depth, depth_diff = 0, parent_depth = 24;
+	uint8_t new_levels;
 
 	if ((fib == NULL) || (ip == NULL) || (depth > RTE_IPV6_MAX_DEPTH))
 		return -EINVAL;
@@ -559,37 +583,6 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	ip_masked = *ip;
 	rte_ipv6_addr_mask(&ip_masked, depth);
 
-	if (depth > 24) {
-		tmp = rte_rib6_get_nxt(rib, &ip_masked,
-			RTE_ALIGN_FLOOR(depth, 8), NULL,
-			RTE_RIB6_GET_NXT_ALL);
-		if (tmp && op == RTE_FIB6_DEL) {
-			/* in case of delete operation, skip the prefix we are going to delete */
-			rte_rib6_get_ip(tmp, &tmp_ip);
-			rte_rib6_get_depth(tmp, &tmp_depth);
-			if (rte_ipv6_addr_eq(&ip_masked, &tmp_ip) && depth == tmp_depth)
-				tmp = rte_rib6_get_nxt(rib, &ip_masked,
-					RTE_ALIGN_FLOOR(depth, 8), tmp, RTE_RIB6_GET_NXT_ALL);
-		}
-
-		if (tmp == NULL) {
-			tmp = rte_rib6_lookup(rib, ip);
-			/**
-			 * in case of delete operation, lookup returns the prefix
-			 * we are going to delete. Find the parent.
-			 */
-			if (tmp && op == RTE_FIB6_DEL)
-				tmp = rte_rib6_lookup_parent(tmp);
-
-			if (tmp != NULL) {
-				rte_rib6_get_depth(tmp, &tmp_depth);
-				parent_depth = RTE_MAX(tmp_depth, 24);
-			}
-			depth_diff = RTE_ALIGN_CEIL(depth, 8) -
-				RTE_ALIGN_CEIL(parent_depth, 8);
-			depth_diff = depth_diff >> 3;
-		}
-	}
 	node = rte_rib6_lookup_exact(rib, &ip_masked, depth);
 	switch (op) {
 	case RTE_FIB6_ADD:
@@ -603,7 +596,8 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return 0;
 		}
 
-		if ((depth > 24) && (dp->rsvd_tbl8s + depth_diff > dp->number_tbl8s))
+		new_levels = count_empty_levels(rib, &ip_masked, depth);
+		if (dp->rsvd_tbl8s + new_levels > dp->number_tbl8s)
 			return -ENOSPC;
 
 		node = rte_rib6_insert(rib, &ip_masked, depth);
@@ -622,7 +616,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return ret;
 		}
 successfully_added:
-		dp->rsvd_tbl8s += depth_diff;
+		dp->rsvd_tbl8s += new_levels;
 		return 0;
 	case RTE_FIB6_DEL:
 		if (node == NULL)
@@ -640,9 +634,8 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 
 		if (ret != 0)
 			return ret;
-		rte_rib6_remove(rib, ip, depth);
-
-		dp->rsvd_tbl8s -= depth_diff;
+		rte_rib6_remove(rib, &ip_masked, depth);
+		dp->rsvd_tbl8s -= count_empty_levels(rib, &ip_masked, depth);
 		return 0;
 	default:
 		break;
-- 
2.43.0

