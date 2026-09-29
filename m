Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEEBC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:43:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C752A410E8;
	Tue, 29 Sep 2026 07:41:56 +0200 (CEST)
Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com
 [74.125.224.171])
 by mails.dpdk.org (Postfix) with ESMTP id B187840276
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:25:37 +0200 (CEST)
Received: by mail-yx2-f43.google.com with SMTP id
 00721157ae682-895eaf31683so35196667b3.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641537; x=1791246337; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ppSpDkW3EQW9SN1exlL/8T6djTBY173TvloAcGrkUcM=;
 b=VT7ffRZwkuCYtQK+nc8iNfzrbLt+QmQKXPjT8rvr5gNzjZmLq6MytSyrYMvPRHmQKc
 TU2utTr1s+0YSHsepPW/Vg1eQFAAfRJB5K7rzGKQvKP4ZGs48IJwnOM9vemfNekQaoob
 Es7HMaOI4ING/odrLNGc+V2qkEykMQS+1XBo8RTolNkmHDDvN5JWBu3ymz4gN3dnHJbt
 mek5xLOhgJSufdu8DTWjiaEmhTssZsk+YDopadW5x8jN2jqrmekGa0xV6z+AtfAW5syO
 M3hyZbEap9tJ5XRduj8qcjH5MDCGWMn11t9ZoRbadql8XnKwrq/YAYHhsJlQS26x/Cdt
 u/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641537; x=1791246337;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ppSpDkW3EQW9SN1exlL/8T6djTBY173TvloAcGrkUcM=;
 b=hZpT4YsQkq+ZIXaQ45TB4gqUgIrM/tHxooHzPPeeDP1z0J8NIXA0wjwjxCHEWLCtOk
 t+lWEKPP7WdYYw25/fJVz4XgXbzxGg4dQPpLOVFMPqgT9rHWFwLDTFt6okl/ejhFZwqp
 lSgn21BeULRNSGYhN70eefDxqj/5btiAlKGHdUPk/HpAeuto1RQd39vqJJoCoWklRjli
 E3VHNpbRyV3NZoPmkSNAU4o8lsxKpHa5pYC8LAeWTMlf9CZ2xqJmLmKe2A97TL1M7o4e
 5eRV2vVyp0cQ8Os+EO5mDQlRwPsH6wRCfKafCjgPMNzmEWtZNHjr5UNVsnCZgSq/Bk0e
 pzwA==
X-Gm-Message-State: AFq9FYItLdkN5gNBrWQb46mzycNcszXlKD/R0VECgJtf0fETC9T3wmjN
 xqSgMq9/YWCOsJay3Fy4aF/r9AiJCJ4UZz03ZoU2phEsLd1p2j2eKoETCwkigxfVNFw=
X-Gm-Gg: AYBFou3QY83Bfd0YuNjrJ7uqQNZOBEnDT49VDIiE6FaafalTkniEYtaeCfp0VFzSccN
 qIjAkcm8qJzvAkEiLLZKpFb1GoS/Zws37FimLCFPviE7EgJE+ZGL9nfGC8T7z5xbMKIFRXPX1/y
 ZPFtIS3noFw65NpShLLDf4V9rxB3bzyVioKJQ9K5D4XUlvUj+qZo6EOpBFImzVzTqCY2iy5oH1b
 RV2A52v/9cUDP6rcTIZewlos0cEXd6ZOrTZniJ89AOXN5lPSYUJaUt3AP0/pcjVhBWqypjWleBS
 g3qDXBzkDIMKjcVf1v5kJ9aTWh203PinSAYBlt9OoSEJImw3cdnrbX64IpXJ1OhHltm7PQEWWpQ
 oa7Nwa8ThVtlwoJSCeKnp3hiDx5BQRlle49P+HpAqbApqdhTSN6ArFE3TMCvxNCsdsA7vg4WKEL
 8kbAMqK+7j0fVVaU2FF3Vkp9lZFpzSoVb6/wa2IamjWaLnXmQ9k6cyFHIyiY6FVNUd4ixxATovq
 iFRcESG4lh2l9X3ZauCaVq4GmlgwKfsz/eEXPkul2DT1bSEDCxO2A5fDolCoqJ5ro2WJQkrhg==
X-Received: by 2002:a53:ac92:0:b0:671:5b87:321c with SMTP id
 956f58d0204a3-674113ae55emr3722803d50.76.1790641536837; 
 Mon, 28 Sep 2026 17:25:36 -0700 (PDT)
Received: from localhost.localdomain ([104.222.18.161])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6740ef87db6sm5450964d50.17.2026.09.28.17.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:25:35 -0700 (PDT)
From: Nam Tran <hoangnamtran18122005@gmail.com>
To: mb@smartsharesystems.com
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Nam Tran <hoangnamtran18122005@gmail.com>
Subject: [PATCH v2] mbuf: avoid temporary array for bulk free
Date: Tue, 29 Sep 2026 00:25:27 +0000
Message-ID: <20260929002527.7-1-hoangnamtran18122005@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922012856.30090-1-hoangnamtran18122005@gmail.com>
References: <20260922012856.30090-1-hoangnamtran18122005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 07:41:44 +0200
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

rte_pktmbuf_free_bulk() currently stages freeable mbufs in a
temporary array before returning them to their mempool. For flat
packet arrays, this copies pointers even when the input array
already contains contiguous freeable mbufs.

Track contiguous same-pool runs in the input array and pass them
directly to rte_mbuf_raw_free_bulk(). Flush at 64 entries to
preserve the existing mempool-cache behavior. Also flush on NULL
entries, retained mbufs, and pool changes. Keep the array-based
fallback for chained packets.

Add coverage for NULL entries, mixed mempools, shared and indirect
mbufs, and a flat run followed by a chained packet.

Signed-off-by: Nam Tran <hoangnamtran18122005@gmail.com>
Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
- Cap same-pool runs at 64 to retain mempool-cache behavior.
- Move the sanity check after the chained-packet fallback decision.
- Add mixed flat/chained and indirect-mbuf regression cases.
- Remove the earlier timing claim; the capped version has not yet
  been benchmarked on x86 or with a cached mempool.

Tested: ARM64 Linux debug build and mbuf_autotest passed.

 app/test/test_mbuf.c | 94 ++++++++++++++++++++++++++++++++++++++++++++
 lib/mbuf/rte_mbuf.c  | 74 ++++++++++++++++++++++++++++++++--
 2 files changed, 165 insertions(+), 3 deletions(-)

diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index db23259745..249e541173 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -833,6 +833,100 @@ test_pktmbuf_pool_bulk(void)
 		goto err;
 	}
 
+	printf("Test bulk free with NULL entries.\n");
+
+	ret = rte_pktmbuf_alloc_bulk(pool, mbufs, 4);
+	if (ret != 0)
+		goto err;
+
+	m = mbufs[1];
+	mbufs[1] = NULL;
+	rte_pktmbuf_free_bulk(mbufs, 4);
+	rte_pktmbuf_free(m);
+
+	if (!rte_mempool_full(pool)) {
+		printf("mempool not full after NULL-entry bulk free\n");
+		goto err;
+	}
+
+	printf("Test bulk free with multiple pools.\n");
+
+	for (i = 0; i < 4; i++) {
+		mbufs[i] = rte_pktmbuf_alloc((i & 1) ? pool2 : pool);
+		if (mbufs[i] == NULL)
+			goto err;
+	}
+
+	rte_pktmbuf_free_bulk(mbufs, 4);
+
+	if (!(rte_mempool_full(pool) && rte_mempool_full(pool2))) {
+		printf("mempools not full after mixed-pool bulk free\n");
+		goto err;
+	}
+
+	printf("Test bulk free with shared mbuf.\n");
+
+	ret = rte_pktmbuf_alloc_bulk(pool, mbufs, 4);
+	if (ret != 0)
+		goto err;
+
+	m = mbufs[1];
+	rte_mbuf_refcnt_update(m, 1);
+	rte_pktmbuf_free_bulk(mbufs, 4);
+
+	if (rte_mbuf_refcnt_read(m) != 1) {
+		printf("shared mbuf reference count incorrect\n");
+		goto err;
+	}
+
+	rte_pktmbuf_free(m);
+
+	if (!rte_mempool_full(pool)) {
+		printf("mempool not full after shared mbuf free\n");
+		goto err;
+	}
+
+	printf("Test bulk free of flat mbufs around a chain.\n");
+
+	ret = rte_pktmbuf_alloc_bulk(pool, mbufs, 5);
+	if (ret != 0)
+		goto err;
+
+	ret = rte_pktmbuf_chain(mbufs[1], mbufs[2]);
+	if (ret != 0)
+		goto err;
+	mbufs[2] = mbufs[3];
+	mbufs[3] = mbufs[4];
+	rte_pktmbuf_free_bulk(mbufs, 4);
+
+	if (!rte_mempool_full(pool)) {
+		printf("mempool not full after mixed flat and chain bulk free\n");
+		goto err;
+	}
+
+	printf("Test bulk free with an indirect mbuf.\n");
+
+	m = rte_pktmbuf_alloc(pool);
+	if (m == NULL)
+		goto err;
+	mbufs[0] = rte_pktmbuf_alloc(pool);
+	mbufs[1] = rte_pktmbuf_clone(m, pool);
+	mbufs[2] = rte_pktmbuf_alloc(pool);
+	if (mbufs[0] == NULL || mbufs[1] == NULL || mbufs[2] == NULL)
+		goto err;
+
+	rte_pktmbuf_free_bulk(mbufs, 3);
+	if (rte_mbuf_refcnt_read(m) != 1) {
+		printf("indirect mbuf reference count incorrect\n");
+		goto err;
+	}
+	rte_pktmbuf_free(m);
+
+	if (!rte_mempool_full(pool)) {
+		printf("mempool not full after indirect mbuf bulk free\n");
+		goto err;
+	}
+
 	printf("Test bulk free of single long chain.\n");
 
 	/* Bulk allocate all mbufs in the pool, in one go. */
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 005bfaa573..99b2ea07cf 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -555,9 +555,8 @@ __rte_pktmbuf_free_seg_via_array(struct rte_mbuf *m,
  */
 #define RTE_PKTMBUF_FREE_PENDING_SZ 64
 
-/* Free a bulk of packet mbufs back into their original mempools. */
-RTE_EXPORT_SYMBOL(rte_pktmbuf_free_bulk)
-void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
+static void
+__rte_pktmbuf_free_bulk_fallback(struct rte_mbuf **mbufs, unsigned int count)
 {
 	struct rte_mbuf *m, *m_next, *pending[RTE_PKTMBUF_FREE_PENDING_SZ];
 	unsigned int idx, nb_pending = 0;
@@ -582,6 +581,75 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
 		rte_mbuf_raw_free_bulk(pending[0]->pool, pending, nb_pending);
 }
 
+/* Free a bulk of packet mbufs back into their original mempools. */
+RTE_EXPORT_SYMBOL(rte_pktmbuf_free_bulk)
+void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
+{
+	struct rte_mempool *run_pool = NULL;
+	unsigned int run_start = 0;
+	unsigned int run_count = 0;
+	unsigned int idx;
+
+	for (idx = 0; idx < count; idx++) {
+		struct rte_mbuf *m = mbufs[idx];
+
+		if (unlikely(m == NULL)) {
+			if (run_count != 0) {
+				rte_mbuf_raw_free_bulk(run_pool,
+						&mbufs[run_start], run_count);
+				run_count = 0;
+			}
+			continue;
+		}
+
+		/*
+		 * Preserve the generic path for chained packets. No mbuf in
+		 * this suffix has been modified yet.
+		 */
+		if (unlikely(m->next != NULL)) {
+			if (run_count != 0)
+				rte_mbuf_raw_free_bulk(run_pool,
+						&mbufs[run_start], run_count);
+
+			__rte_pktmbuf_free_bulk_fallback(&mbufs[idx],
+					count - idx);
+			return;
+		}
+
+		__rte_mbuf_sanity_check(m, 1);
+		m = rte_pktmbuf_prefree_seg(m);
+		if (unlikely(m == NULL)) {
+			if (run_count != 0) {
+				rte_mbuf_raw_free_bulk(run_pool,
+						&mbufs[run_start], run_count);
+				run_count = 0;
+			}
+			continue;
+		}
+
+		if (run_count != 0 && m->pool != run_pool) {
+			rte_mbuf_raw_free_bulk(run_pool,
+					&mbufs[run_start], run_count);
+			run_count = 0;
+		}
+
+		if (run_count == 0) {
+			run_pool = m->pool;
+			run_start = idx;
+		}
+
+		run_count++;
+		if (run_count == RTE_PKTMBUF_FREE_PENDING_SZ) {
+			rte_mbuf_raw_free_bulk(run_pool,
+					&mbufs[run_start], run_count);
+			run_count = 0;
+		}
+	}
+
+	if (run_count != 0)
+		rte_mbuf_raw_free_bulk(run_pool, &mbufs[run_start], run_count);
+}
+
 /* Creates a shallow copy of mbuf */
 RTE_EXPORT_SYMBOL(rte_pktmbuf_clone)
 struct rte_mbuf *
-- 
2.51.0

