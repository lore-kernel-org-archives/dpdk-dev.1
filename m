Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FD1CA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:43:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2773C42E69;
	Wed,  7 Oct 2026 23:41:44 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id CA54A42DE9
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:40 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e2c837fa12so11571475ad.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409300;
 x=1792014100; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Hzmo/snJxhFQ9QXmAqYhLmjg9C+iOwa2T+0DgZFipw=;
 b=Ds1rXCqj2OpiJvxjgbwgNNothEdnxG1D/jY46B3LDSM1pikVrTNsTTkASYEcbwSqSl
 faDOswyWC/hJnaHOeUa/oBA8lX8OPhl9tEzvG/foj0aiPA3+XbFeXt5u7ykHJgMerhlS
 rhSL0NgOYcG5g24NR9dLMZvdtDEeuWEXzi+CQHmrZFB/IVNHZVDlDlz0ZTVxJpaIh68o
 PY11xV536VSIrnbzJUJAhAnJssFnwGx/lsSUwoAABoD71Y0gnnFl7PlacBVY1VjX4YXR
 lfqrgyRG8xLSNLOMf0NCyGzGglSTPmDhTPivi3nZYECF5dGePlFdfpajZ664ed8YdGWt
 BZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409300; x=1792014100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Hzmo/snJxhFQ9QXmAqYhLmjg9C+iOwa2T+0DgZFipw=;
 b=Mey1NN/R8fAqJ+eOiSdDgD80xIsd1i7aFDpHrCKDEA7pTmrX9C3KPg3nyZT+tkUyn4
 wjP8FjhfBVeTRSMu5zEsRmGaQZwx1m6fA5S9OSPmNmWnzHxaCW34G6NU/Y0vlfAXcHl6
 99xEZHDPEZk/lzXXktpMTXEzYLaX2H6iVrTzzzqA1CbbmCnMY0Ghz2wDcGvhbARywwtf
 0WHtRaR7UbRnpVAcIR/XI0OBwJ8Rca7RFaew6v+DhPHX8xFv3ApVIq3BnSPnwAHffrmn
 Vmudg+FrSgd0v3R9CVrnoxDG8PLSPHLzgGfka0cWhAJ95s4nQ4NXhLWZcyM44G48czXH
 Dc3A==
X-Gm-Message-State: AFq9FYLzUdMpuGOyED5AWhqhYlQeajny4pEnKxyDoxzDVW5UcaXibL62
 3ct/5+Wo71GrGuBIjmU7rXRyeRkogS3p1EbENG55RyroVzHt6hXa6GJnz7GcnFKiy7SFWQG3I5s
 QJOkhalM=
X-Gm-Gg: AYBFou2qhHtiDnUTRxTz3LbBUiKwzPnAidLYZ6/Pcp5XNrMiHf13G2GXOiEfLOWI1AO
 mgrQv0YDCpcSlqCAh0Ldj3gezlrJTGRAC0f5LvfPNN0NzJthwNPUXl42LUPfeOA65vJ/0ySW33u
 tmQKkLbnpPXdUp6Oaz5XFSGGfgimweA1rl13bur8ZeIj+E95R8q0LgTbxHbbr5cCKPC0OStdgRq
 6Hm0X6umdeJuoz1X5xQ9n4GUNcC9YFBlOL6YZD8pyQzE1kO8IPRVUqn1j8zqj/q2Ek73GjpcIuM
 8iAfN0f85evgGiKWQ7QSfROZxbPvfJogBHHJAzBox/NSAY3+rlxL7WYFZ8CNv/3WdfKIMlmmbAl
 jHgsn4WR0MGvr0aSKGc1V2UV9GLyD4a66UYV9hPW8PtoL1GOZ23+9TweKI3z38fu2QOCUgv9INd
 cYSC9hNI18z2xvGKQiGyoIo7EhxnuJEJc/Wl5UnOGyiAwUOwUkaLkn+5TTnxgeXKTIEbIVPbP81
 Dm0RWYbj/q711A11TpnSzPt8A6bjcF0MYkSiw==
X-Received: by 2002:a17:903:120c:b0:2dd:c053:82f3 with SMTP id
 d9443c01a7336-2e6004f118emr30540975ad.42.1791409299899; 
 Wed, 07 Oct 2026 14:41:39 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 20/20] mempool: promote memory range and alignment to stable
Date: Wed,  7 Oct 2026 14:39:50 -0700
Message-ID: <20261007214115.3092715-21-stephen@networkplumber.org>
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

rte_mempool_get_mem_range() and rte_mempool_get_obj_alignment() were
added in 24.07 and have not changed since. The bulk of the mempool API
is already stable.

The trace points and rte_mempool_stats_reset() from 26.07 are left
experimental.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 3 +++
 lib/mempool/rte_mempool.c              | 4 ++--
 lib/mempool/rte_mempool.h              | 8 --------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 1fb9251dbf..48ecf23b00 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -356,6 +356,9 @@ API Changes
 * hash: Promoted ``rte_hash_rcu_qsbr_dq_reclaim`` and ``rte_thash_gen_key``
   from experimental to stable.
 
+* mempool: Promoted ``rte_mempool_get_mem_range`` and
+  ``rte_mempool_get_obj_alignment`` from experimental to stable.
+
 * node: Promoted the whole library API from experimental to stable.
   The ``rte_node_*`` control path functions date from 23.07 to 25.07 and
   are used by the graph application and the l3fwd-graph example.
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 817e2b8dc1..39a652527b 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -1444,7 +1444,7 @@ void rte_mempool_walk(void (*func)(struct rte_mempool *, void *),
 	rte_mcfg_mempool_read_unlock();
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_get_mem_range, 24.07)
+RTE_EXPORT_SYMBOL(rte_mempool_get_mem_range)
 int rte_mempool_get_mem_range(const struct rte_mempool *mp,
 		struct rte_mempool_mem_range_info *mem_range)
 {
@@ -1479,7 +1479,7 @@ int rte_mempool_get_mem_range(const struct rte_mempool *mp,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_get_obj_alignment, 24.07)
+RTE_EXPORT_SYMBOL(rte_mempool_get_obj_alignment)
 size_t rte_mempool_get_obj_alignment(const struct rte_mempool *mp)
 {
 	if (mp == NULL)
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 40c3f26087..239d20935c 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1966,9 +1966,6 @@ struct rte_mempool_mem_range_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Get information about the memory range used to store objects in the mempool.
  *
  * @param[in] mp
@@ -1980,15 +1977,11 @@ struct rte_mempool_mem_range_info {
  * @return
  *   0 on success, -EINVAL if mempool is not valid or mem_range is NULL.
  */
-__rte_experimental
 int
 rte_mempool_get_mem_range(const struct rte_mempool *mp,
 	struct rte_mempool_mem_range_info *mem_range);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Return alignment of objects stored in the mempool.
  *
  * @param[in] mp
@@ -1996,7 +1989,6 @@ rte_mempool_get_mem_range(const struct rte_mempool *mp,
  * @return
  *   Object alignment if mp is valid. 0 if mp is NULL.
  */
-__rte_experimental
 size_t
 rte_mempool_get_obj_alignment(const struct rte_mempool *mp);
 
-- 
2.53.0

