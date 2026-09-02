Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8AFC624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 23:27:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C4B24028D;
	Thu,  3 Sep 2026 01:27:12 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 23E3940285
 for <dev@dpdk.org>; Thu,  3 Sep 2026 01:27:11 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso1370433b3a.0
 for <dev@dpdk.org>; Wed, 02 Sep 2026 16:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788391630;
 x=1788996430; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rp8V/LIdEpm4YMzxS2AfUIFi0lVjhcjgZnnjQ1Xexh0=;
 b=i7CDLDA2jvLlzrSLHr1cYdYkunSF5iQcy5GTzG47qvO6QMVqTfDXmfxRpt28+ZTYyN
 x/ledTQ12uJHuWCVTdwptE/3OVogIayePBukVX7k+gU3o8DjHYUKmnxMal7uv6PNt+PX
 /F6LXgCkSdLR0k58jcaoNQf5wZw0GVmecFwuOhDtT8LGlRc2nBQkGcnVrvAWoKRDt9J9
 PBWcquKhzLj9qPkDXowGgKLh/D7fi1DY2VCg2s/JqxuA+MynQr4UVygTrNnL4b8Y4TTY
 TUq1KGp1D3DdPY7/tqBkyB+0s2mFX/B3PucI5Igyb2TVzRB5y9CljcUFaEe1I4ND2XP8
 RHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788391630; x=1788996430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rp8V/LIdEpm4YMzxS2AfUIFi0lVjhcjgZnnjQ1Xexh0=;
 b=lmXVUXJXxZgIZOMkZi8+O1qbvhLlbUkrCoDZ58JkdtpcpyiQ6av8rECkO3Tx/ib4w1
 bY6f1dLGbaa7TooYAnOA5BNPEcFc8PIpJJbbif+PDevD45Bc+wnap1xLJbB+lgjmEQ5Y
 A3l0WUTBAk8A2BZIxp5n6NK7C/5WefKNOx5rClnCnMtalH+BEgSbrhlQMNHRtiRHwI3C
 wwm12Fq0McqDVuR+DLFVVWHtTjpcTU3AMZ+iyjqW1agdJ6p3+W4sxdFdzXmwW74iz2kV
 O4vmGfJVdFr8Z2AhEj05ZDBe8WAt58bV9ANiQVZcHelk75GxHl4+tpM9YYxKHw+SRRoP
 TIDA==
X-Gm-Message-State: AFuF++lEvfab0dCVeH6lCo+mTqla8COCswMCaVO9fHpKz9jdZo5br5GY
 GEuYB/fMkCEjqKPkzAB5rHuE1WJqP+8pVVh8o+hXOKu/XZLeSz/V+nwwZFj9IR0gkDydfPdT2ob
 fq6Rv
X-Gm-Gg: AYBFou1IQ1LWNTraGzQhUCM9D2fy3/4TT1nRr/4K+yrBQr3Ny1bkBkSbuGc4m1F5ZiI
 rtt6SbA7ETAoMhKgKn5Ngs6xfhRHH/FkjcgqJLh2yTiDVMuNwzI0Rhzkw05+LTC8JII3bAcXrvt
 Li8uxCA5bxA3NZJOogTcgX37IKvvRkiZcszeQmIoxL8Vzo04kMYp70cm7XohtD/NoN4uzwz/S2Z
 lLgpWSyL50zJ2nhu+BQKqP2gN6o+SzYlVZlpZCLXHDFDtS8t/Y/5BU8KfdZGjyR4IYiUGEkkG2G
 RQFz+ldzDenFE7RDqtT1QR/Ljqbr+5ZGtAGIPoqIDXRE09HF6gmmsXHrhErypJe8Bjy8NGkyiYA
 L8kye87i5ixslNxakuZe57hcKu6Y/yjGOIZ9gzJc1yWJZJsuwkXzsoUYruMspk5C7rzrbvFssuJ
 mdPe4h5GKpQTD9lJuBlVIWbWAodSdNIIJ2BP2t5Gfodl6BMiENjd48vs3RV4AxPh77qB+qAF7G/
 gDVJiNip4GEmBABMHSD41zGsjE=
X-Received: by 2002:a05:6a00:4b0c:b0:847:83bc:d2a4 with SMTP id
 d2e1a72fcca58-85ed21edef2mr11575576b3a.2.1788391630146; 
 Wed, 02 Sep 2026 16:27:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85db24f2098sm1946654b3a.6.2026.09.02.16.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 16:27:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Volodymyr Fialko <vfialko@marvell.com>
Subject: [PATCH] reorder: promote experimental API to stable
Date: Wed,  2 Sep 2026 16:27:00 -0700
Message-ID: <20260902232700.550000-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

All the experimental symbols in the reorder library were added in
DPDK 23.07 or earlier and have not changed since, so remove the
experimental tag.

The sequence number accessor rte_reorder_seqn() and the underlying
rte_reorder_seqn_dynfield_offset date back to 20.11,
rte_reorder_drain_up_to_seqn() and rte_reorder_min_seqn_set() to 23.03,
and rte_reorder_memory_footprint_get() to 23.07.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 lib/reorder/rte_reorder.c              |  8 ++++----
 lib/reorder/rte_reorder.h              | 16 ----------------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..437cb8f2cc 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -95,6 +95,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* reorder: Promoted the following experimental API to stable:
+  ``rte_reorder_seqn``, ``rte_reorder_drain_up_to_seqn``,
+  ``rte_reorder_min_seqn_set`` and ``rte_reorder_memory_footprint_get``.
+
 
 ABI Changes
 -----------
diff --git a/lib/reorder/rte_reorder.c b/lib/reorder/rte_reorder.c
index be06530860..af5a6d9f01 100644
--- a/lib/reorder/rte_reorder.c
+++ b/lib/reorder/rte_reorder.c
@@ -35,7 +35,7 @@ EAL_REGISTER_TAILQ(rte_reorder_tailq)
 #define RTE_REORDER_NAMESIZE 32
 
 #define RTE_REORDER_SEQN_DYNFIELD_NAME "rte_reorder_seqn_dynfield"
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_seqn_dynfield_offset, 20.11)
+RTE_EXPORT_SYMBOL(rte_reorder_seqn_dynfield_offset)
 int rte_reorder_seqn_dynfield_offset = -1;
 
 /* A generic circular buffer */
@@ -61,7 +61,7 @@ struct __rte_cache_aligned rte_reorder_buffer {
 static void
 rte_reorder_free_mbufs(struct rte_reorder_buffer *b);
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_memory_footprint_get, 23.07)
+RTE_EXPORT_SYMBOL(rte_reorder_memory_footprint_get)
 unsigned int
 rte_reorder_memory_footprint_get(unsigned int size)
 {
@@ -482,7 +482,7 @@ ready_buffer_seqn_find(const struct cir_buffer *ready_buf, const uint32_t seqn)
 	return low;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_drain_up_to_seqn, 23.03)
+RTE_EXPORT_SYMBOL(rte_reorder_drain_up_to_seqn)
 unsigned int
 rte_reorder_drain_up_to_seqn(struct rte_reorder_buffer *b, struct rte_mbuf **mbufs,
 		const unsigned int max_mbufs, const rte_reorder_seqn_t seqn)
@@ -553,7 +553,7 @@ rte_reorder_is_empty(const struct rte_reorder_buffer *b)
 	return true;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_min_seqn_set, 23.03)
+RTE_EXPORT_SYMBOL(rte_reorder_min_seqn_set)
 unsigned int
 rte_reorder_min_seqn_set(struct rte_reorder_buffer *b, rte_reorder_seqn_t min_seqn)
 {
diff --git a/lib/reorder/rte_reorder.h b/lib/reorder/rte_reorder.h
index 1c8c1d5079..5bcb32b164 100644
--- a/lib/reorder/rte_reorder.h
+++ b/lib/reorder/rte_reorder.h
@@ -29,15 +29,11 @@ typedef uint32_t rte_reorder_seqn_t;
 extern int rte_reorder_seqn_dynfield_offset;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Read reorder sequence number from mbuf.
  *
  * @param mbuf Structure to read from.
  * @return pointer to reorder sequence number.
  */
-__rte_experimental
 static inline rte_reorder_seqn_t *
 rte_reorder_seqn(struct rte_mbuf *mbuf)
 {
@@ -170,9 +166,6 @@ rte_reorder_drain(struct rte_reorder_buffer *b, struct rte_mbuf **mbufs,
 		unsigned max_mbufs);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Fetch set of reordered packets up to specified sequence number (exclusive).
  *
  * Returns a set of in-order packets from the reorder buffer structure.
@@ -190,15 +183,11 @@ rte_reorder_drain(struct rte_reorder_buffer *b, struct rte_mbuf **mbufs,
  * @return
  *   Number of mbuf pointers written to mbufs. 0 <= N < max_mbufs.
  */
-__rte_experimental
 unsigned int
 rte_reorder_drain_up_to_seqn(struct rte_reorder_buffer *b, struct rte_mbuf **mbufs,
 		unsigned int max_mbufs, rte_reorder_seqn_t seqn);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Set minimum sequence number of packet allowed to be buffered.
  * To successfully set new value,
  * reorder buffer has to be empty (after create, reset or drain_all).
@@ -210,14 +199,10 @@ rte_reorder_drain_up_to_seqn(struct rte_reorder_buffer *b, struct rte_mbuf **mbu
  * @return
  *   0 on success, a negative value otherwise.
  */
-__rte_experimental
 unsigned int
 rte_reorder_min_seqn_set(struct rte_reorder_buffer *b, rte_reorder_seqn_t min_seqn);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Determine the amount of memory needed by the reorder buffer
  * to accommodate a given number of elements.
  * @see rte_reorder_init()
@@ -227,7 +212,6 @@ rte_reorder_min_seqn_set(struct rte_reorder_buffer *b, rte_reorder_seqn_t min_se
  * @return
  *   Reorder buffer footprint measured in bytes.
  */
-__rte_experimental
 unsigned int
 rte_reorder_memory_footprint_get(unsigned int size);
 
-- 
2.53.0

