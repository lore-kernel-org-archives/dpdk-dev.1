Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469A6CD3427
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 09:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C77A64064A;
	Thu,  7 May 2026 11:50:50 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id DCE184025F
 for <dev@dpdk.org>; Thu,  7 May 2026 11:50:49 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488ad135063so5794375e9.0
 for <dev@dpdk.org>; Thu, 07 May 2026 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778147449; x=1778752249; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/zq0PQTZUXx8NU7wIBPri3rDkQ71wdmSAHEWT9sW/M=;
 b=kBwwxJKoqYkG6YiZKVZZiai8UYtHuuGfpO0lqZjrEoMDWKkhR571Wad6WZWQFm/Kt1
 kuj4BNdJhCfYKhqCByboUIlAP3Kidurh7QAfw9Vfeor2j3dtuCrs1g4Zv6fPik5Mzuh2
 EGlVhGV/e5VqnA2uHtwWssh1kMICkLWMmBR7dcp/OXd1+TFHfNht+nNMHNtcnhiMv+6V
 iWNULek3yRZNEE1jdqN46YFf9lJbhYKmqPeenpnuIzGpzPuaWmkxWxTYb8YPnrPbcPzR
 zL/dtMkRVVYn/IGBAN8szEOct3cuqe1ZEwBYByC4sNpt38gAbGLbpHH63BTQRcmv9g4z
 nmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778147449; x=1778752249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h/zq0PQTZUXx8NU7wIBPri3rDkQ71wdmSAHEWT9sW/M=;
 b=fA9xk+ujYMbxJGO5u6FzFyPD3c6cAqD1xfrQGILaNonGgaBcE4EXD75YSSb5j0T/IJ
 rNtZlBIoqMF2SBqOiVNbvwbqKh095Xd2tqwXz3hZNoeC1Cd6v39T/SN4pckm1cDVbIER
 1tdO3jk7mrqPnIsAfKPl6lLBPFX0SDiRvZzcngWm90d5sM8kZzbYelcsnaciwBi0ifB3
 +bD9OlMXvOL8qVrZFN8eAxYZsiCvKCorY669sbktIsnBpT6KrYNio60idLDETrfFSRel
 /yQNlQMhdAG/rONkCLbHMgXfTFvqXgJ7qi1yIdKA2q2oXK+eIk9Hz127XRoRr1CRRuUH
 fkrg==
X-Gm-Message-State: AOJu0Yzv0xjoFWhsFN0d7afkpCr45o56hA8niSFebH0AjfaBWqQAfW6n
 zDpjEjIit3qLUz+OXxtQk6HCCqe5xhxV8Ys8gf7hV2OKh/jO6hFnFeg/
X-Gm-Gg: AeBDievc2YdPqePDvS77FSsJIhBrRE+fHy/DhsPYIUh5WNCHGkrImK6a4oyB5DeLXYw
 6431XKs/ACGzkgCOcS4bQhARxdvoMyHAFilbnmdd4gWMNHlwKdqdL4OQhx3qt7rKqYfGNd9tTQH
 kWZ9EOksHE8H2fz3bQYsxvSyzYuLaozk02NS84fSx4C8lh2dQDVnQXbOYzL+Wn6luGg1P3r+4/D
 03d6/zzYjf7ueXynrABdA7YmuRjC5iFnpkyTWP26S1nsA21RNg/uuZsJzXWVhq0MnUffOD43tVJ
 zeq+Fnq8HjrB9f+Gpp2GU9D+GT4z4x5smSzom6277lrFrVyqW/qCnsXdev+Dpiw1qk3q4EEPXz4
 4Vrs5v1d7f6oCNkPiMgosKYQroHKHkoj+sdZGXkUEL9a5pNu+E/bSfq2oBDDOm7KwP+MdpYqlFk
 14RtJZIZtTvqThqIJiEwtfNNuCdX18aUOyQNEJsh+c/Ac5uWhsYMTHIiJuls2Uw10=
X-Received: by 2002:a05:600c:8012:b0:48e:5fb8:f80f with SMTP id
 5b1f17b1804b1-48e5fb8fac9mr23661935e9.24.1778147449209; 
 Thu, 07 May 2026 02:50:49 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530fdc50sm56811335e9.5.2026.05.07.02.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:50:48 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>,
	stable@dpdk.org
Subject: [RFC 1/3] fib6: fix tbl8 reservation drift in trie
Date: Thu,  7 May 2026 11:50:41 +0200
Message-ID: <51c96687deba79270c867ae37d01f51adfca6622.1778146229.git.maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778146229.git.maxime@leroys.fr>
References: <cover.1778146229.git.maxime@leroys.fr>
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

trie_modify() updates rsvd_tbl8s by depth_diff computed from the
current RIB state. The RIB is not invariant between the ADD of a
prefix and its later DEL (a covering parent may be added or removed
in between), so depth_diff at DEL time may not match depth_diff at
ADD time. Repeated over asymmetric pairs, rsvd_tbl8s drifts and
eventually wraps to UINT32_MAX, after which the pre-check rejects
all long-prefix ADDs with -ENOSPC even when the pool is empty.

Replace rsvd_tbl8s with tbl8_pool_pos, which tbl8_get()/tbl8_put()
maintain exactly. To preserve the QSBR_MODE_DQ safety net previously
provided by the retry-with-reclaim inside tbl8_alloc(), the pre-check
now calls rte_rcu_qsbr_dq_reclaim(depth_diff) before returning
-ENOSPC.

The single-tbl8 retry inside tbl8_alloc() is removed: depth_diff is
the algorithmic upper bound for new tbl8 allocations, and the
pre-check now performs the DQ reclaim before allocation, so the
retry inside the allocator is no longer needed.

Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/fib/trie.c | 23 ++++++++++-------------
 lib/fib/trie.h |  3 +--
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index fa5d9ec6b0..52f25d499c 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -161,12 +161,6 @@ tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 	uint8_t		*tbl8_ptr;
 
 	tbl8_idx = tbl8_get(dp);
-
-	/* If there are no tbl8 groups try to reclaim one. */
-	if (unlikely(tbl8_idx == -ENOSPC && dp->dq &&
-			!rte_rcu_qsbr_dq_reclaim(dp->dq, 1, NULL, NULL, NULL)))
-		tbl8_idx = tbl8_get(dp);
-
 	if (tbl8_idx < 0)
 		return tbl8_idx;
 	tbl8_ptr = get_tbl_p_by_idx(dp->tbl8,
@@ -603,8 +597,15 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return 0;
 		}
 
-		if ((depth > 24) && (dp->rsvd_tbl8s + depth_diff > dp->number_tbl8s))
-			return -ENOSPC;
+		if ((depth > 24) &&
+		    (dp->tbl8_pool_pos + depth_diff > dp->number_tbl8s)) {
+			/* Reclaim deferred tbl8s before failing. */
+			if (dp->dq != NULL)
+				rte_rcu_qsbr_dq_reclaim(dp->dq, depth_diff,
+					NULL, NULL, NULL);
+			if (dp->tbl8_pool_pos + depth_diff > dp->number_tbl8s)
+				return -ENOSPC;
+		}
 
 		node = rte_rib6_insert(rib, &ip_masked, depth);
 		if (node == NULL)
@@ -614,15 +615,13 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 		if (parent != NULL) {
 			rte_rib6_get_nh(parent, &par_nh);
 			if (par_nh == next_hop)
-				goto successfully_added;
+				return 0;
 		}
 		ret = modify_dp(dp, rib, &ip_masked, depth, next_hop);
 		if (ret != 0) {
 			rte_rib6_remove(rib, &ip_masked, depth);
 			return ret;
 		}
-successfully_added:
-		dp->rsvd_tbl8s += depth_diff;
 		return 0;
 	case RTE_FIB6_DEL:
 		if (node == NULL)
@@ -641,8 +640,6 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 		if (ret != 0)
 			return ret;
 		rte_rib6_remove(rib, ip, depth);
-
-		dp->rsvd_tbl8s -= depth_diff;
 		return 0;
 	default:
 		break;
diff --git a/lib/fib/trie.h b/lib/fib/trie.h
index c34cc2c057..b42a28f84e 100644
--- a/lib/fib/trie.h
+++ b/lib/fib/trie.h
@@ -31,8 +31,7 @@
 
 struct rte_trie_tbl {
 	uint32_t	number_tbl8s;	/**< Total number of tbl8s */
-	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
-	uint32_t	cur_tbl8s;	/**< Current cumber of tbl8s */
+	uint32_t	cur_tbl8s;	/**< Current number of tbl8s */
 	uint64_t	def_nh;		/**< Default next hop */
 	enum rte_fib_trie_nh_sz	nh_sz;	/**< Size of nexthop entry */
 	uint64_t	*tbl8;		/**< tbl8 table. */
-- 
2.43.0

