Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935D0C982FE
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 06:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98678402D6;
	Tue, 22 Sep 2026 08:14:16 +0200 (CEST)
Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com
 [74.125.224.170])
 by mails.dpdk.org (Postfix) with ESMTP id B96CA4027E
 for <dev@dpdk.org>; Tue, 22 Sep 2026 03:29:01 +0200 (CEST)
Received: by mail-yx2-f42.google.com with SMTP id
 00721157ae682-89666eea29cso26672867b3.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 18:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790040541; x=1790645341; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H/lm5nWbYU7eJwq8by7AUrDD+MRq/tEUxBepcf4hZzw=;
 b=arRbVGTMBmxiDuh7g08/ESn0PJ6KZ2PyKxpWqisjv6Qfc3XrbAkqTB4UIhD2ruKwak
 p0MuCUOPJEYg+4FbxgKcQ1yVH9iOHXET3r7xyEc++bVVJWufZd59+ZTRvlHWeXDiL2g7
 sgqMTaYInL6DEGqitl8Px06Et78ogcOKn0B2/gpOLEWLfwnM4uVpIYV64hyMmKD8HZ8U
 FHDgdfqeF3trFERr1g6Huz90H4WOuA+Wm8GswvB11SIxil602CNzM4ttx1mXiYp9TBTJ
 MpaDlgZd2Ul/NOcmTyT7z72u9ppVd7tA4YuFAW+c0KqLtGfeNdcWwqGuJmmMdG6p2s8O
 Ka2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790040541; x=1790645341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H/lm5nWbYU7eJwq8by7AUrDD+MRq/tEUxBepcf4hZzw=;
 b=O13vRelnGnAIjNiJ3K+6NnqmsCNOrv8d+eRxnsbLvxeplUcJWohHZPWYvfViPfSMKr
 Gwq5ZK/I4fFjaNiIhvNxyPOM6LwFDYWSYMX9KENIEJ9F1Kg04QmhFT/gbyozcRp7cXmg
 eGa0cP/KiH4qQvhqlx8cQlKpjz5LXxl9tFB5D6w0XDiaRDIkk4ZDHNDKybfuRC4F6jlV
 xO1YWJhn1p+kdR08TY4hCCZojQjmdp5S+271DF9+TJQ1NKRUCYsxBt4dmay4rxF2L9YP
 /O0rdfgEsPvNPh0PDTSgvHKtetjfv1jDSy4R9+YXScnosSe1mwemg/OTM9IKR4E2DNmQ
 TdjA==
X-Gm-Message-State: AFuF++mPcmTjY3mJIie5YrxFQlFkiUWePWNcWmQ6ytrXYhCZvxlVSO0O
 91DOfp4Z0hgURBw4tpPa+7js5Aqnk6w5fFUaPnP079G6SkzCNoJ8RCZDboZOAGrx
X-Gm-Gg: AYBFou0l9E7WIiQsktGVYfp0OkPxo9bSFdzOpuOCi4YDB6nsnxq7yzFq+lWDkb7t0EJ
 UKfVMbfGecS6yhS00KOlYvPmsTPfGyc7QJ8lyV5qp5dzqO7fWf48t+ND0OBImH+2/vmKQM+Jlty
 84CUufx1rwsWXMbg3IAegR6GtPRe/05ZeNRfiyBKI5h+pV4ruRqjDGFR3c/ZDQgkOVw+mw31c2D
 Uz2d3dMn7XMpPkecrwmJsS6Dwy+D3JU+XCPxjns4TvCt6ZVBLahionXXfysB+2s6JJqzhrdx/Wu
 SX1gnuZb7OyrGh+kTy4Ck1AcnHcGbSneOeYPjLHbSu2HE3USpyIi13S/6Cke36yybfq2DO5ERx/
 VGH2mDDIPTAWY5SUNmfKo/0InrH3HLYF6K4f/u4VKGN5Ef//UNt1MZ0f3+PUpUdQnuZCC10Sjam
 ylXQxJNsVFTwL2klIi77kK069xhULwDdZrN9FKncHLBr9qDqzeJ0GQte7LZUWXvnJldBy3YNn0U
 1DtJcFV8hwX578TPB3DXZ5tQibX3+Eh8vY7JikxuEOXMpuBBgjhGOmn19rXcij9kiBUcUzcn0GQ
 mLuNRA==
X-Received: by 2002:a05:690c:a597:b0:882:1d1e:7d27 with SMTP id
 00721157ae682-89733d16f6bmr27537837b3.23.1790040540781; 
 Mon, 21 Sep 2026 18:29:00 -0700 (PDT)
Received: from localhost.localdomain ([2605:ad80:10:2c1c:617d:3934:1b66:df52])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a2bd79e82bsm926397b3.5.2026.09.21.18.28.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Sep 2026 18:28:59 -0700 (PDT)
From: Nam Tran <hoangnamtran18122005@gmail.com>
To: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org,
	Nam Tran <hoangnamtran18122005@gmail.com>
Subject: [PATCH] mbuf: avoid temporary array for bulk free
Date: Mon, 21 Sep 2026 21:28:56 -0400
Message-ID: <20260922012856.30090-1-hoangnamtran18122005@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:14:15 +0200
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
packet arrays, this requires copying pointers even though the
original array already contains contiguous freeable mbufs.

Track contiguous same-pool runs in the input array and pass them
directly to rte_mbuf_raw_free_bulk(). Flush a run when encountering
a NULL mbuf, an mbuf retained by reference counting, or a pool
change. Preserve the existing array-based implementation as the
fallback for chained packets.

On an ARM64 Linux test environment, same-binary A/B measurements
using rte_rdtsc showed lower median timer ticks per call for flat
bulk frees:

  burst  32:  2.05 ->  1.50
  burst  64:  5.16 ->  4.52
  burst 128: 11.16 ->  6.90
  burst 256: 26.46 -> 19.73

This corresponds to reductions of approximately 12% to 38% across
the tested burst sizes.

Add coverage for NULL entries, mixed mempools, and shared mbufs.

Signed-off-by: Nam Tran <hoangnamtran18122005@gmail.com>
---
 app/test/test_mbuf.c | 53 +++++++++++++++++++++++++++++++++
 lib/mbuf/rte_mbuf.c  | 71 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index db23259745..2aed37b225 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -833,6 +833,59 @@ test_pktmbuf_pool_bulk(void)
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
 	printf("Test bulk free of single long chain.\n");
 
 	/* Bulk allocate all mbufs in the pool, in one go. */
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 005bfaa573..796631a033 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -555,15 +555,15 @@ __rte_pktmbuf_free_seg_via_array(struct rte_mbuf *m,
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
 
 	for (idx = 0; idx < count; idx++) {
 		m = mbufs[idx];
+
 		if (unlikely(m == NULL))
 			continue;
 
@@ -582,6 +582,71 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
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
+		__rte_mbuf_sanity_check(m, 1);
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

