Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4BBCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76E5142DAC;
	Wed,  7 Oct 2026 23:41:38 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id EE3F542D90
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:33 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2df982e04c1so15506195ad.2
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409293;
 x=1792014093; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/wkW4pHX0tAIM0ZEbXmvIrOGByXvydqvoaeQcYmDiTw=;
 b=G3GoMF05KxRGMwdS0ZtWrTtH3Zi1kQMrTIpmNoFENUg6rz9qycdPDw55iZXSrCnkV1
 /KPX3fyry7NmnyfVdDRzZLM+LfBqIEYqV3LCYdY4qyYH4x6IHxAMmmJ5o1+KM/TdVg2Y
 n3I4x7agxa31bUG1Qg4lO611JBFnFqbg2NPyJd8QSL8dBLPmCpdKPqWo1u1oSoohKrdj
 I4V8wfBSAAhZ01V9QrSEPFqkFoSWKzv/5e1eDywRcy+VVUaI9R1ErKGVfbrhQCPX3dXP
 +ILBBHyzcIf9VEUhw9fN7WH60U00utfd03x2uWsyVslAe1Y93LAF5Ry+X8XRrBCl8bCg
 5kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409293; x=1792014093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/wkW4pHX0tAIM0ZEbXmvIrOGByXvydqvoaeQcYmDiTw=;
 b=Y8O9s9vPipg3fbkmgQlG899szKIhAwz9r4F8Y0tzLZDMtNdMJkzX9fyFY3ZryDwRFG
 RLqC/RtGjnksQQyWKxRtklDt6TsMkrRQCaix+Cm0Estttp9pWGfmtU3dCo8u1ae7lQw8
 TxpfgjgO+AXxCbUt83kwIYXLvfy/PJo6fgpkXE+IDBqDcTC2u1TJevSWm2t/8yhyvbOq
 t4lY6h45AeKofUdQ6a9ZcFJU7OLMU+cB9K8Lce0cTkd23suSNp3SH3/qnV8sS7QQW2HL
 qVCm7kQwNJPKpAaBIzBr5/lixzSD9m6ZgrWaqfKz2Sg3vdPi8WHzkm19XWKPMQo15hCl
 nVfg==
X-Gm-Message-State: AFq9FYKXIvjiz6FOM9xXFfjYxSI1CP/9oBecSg9tUKyzSEMKRSmXJMQg
 Rtkcrcoy8ak3KuYzO+cVvjo0LzayLyz8Aogw4Bs0TuiOVH83WaOPUhDFGqPs5odAFZkfgTsEmgw
 /4GZT0TI=
X-Gm-Gg: AYBFou1LZjQdni50Rz4mtwKGLg9WRmLYADZFBUmrjLuWKgDox3zvisDg8EjpxEx1kRw
 zMq89ayEOJjN50X01txGZbEvk8h1rvhdwjr103gxqWH4wGIM2hNq0gbGH/ooEZQRDcoZk1e7NNX
 uo1zjv9ZjLB9KWpRPLHUTNXTjUObeuHj87Gu08gCamF3QassW5ihHsLHuY4E8J2l+sBuUYn5bq+
 xqZ8JrWAkYshRLk2PKfG5Rn1WNVIYPgzwCeXoeMxnYbPsJmM9RUl4TkxjN9ULnzFoQipthHtjTf
 7bLSlhTQV+NnDvTymwUq0REbMFUHPUaIOTzRi5NK4o42GtUbjeY1LUkVlsl5vn4X91ivXuD2Bfi
 f4F+jZU7YWbmaoQkcO6LFLvvXSooQA6KCU/kLVKNZyNmerNX3HjAY6hz4uwHZ9X/IpOUXUMWG6S
 K8l4Yi5SAhLD5FWpMats6wPAxEIpJjlzagWChjLzAIbZv4vNLIeXAh5+6NcpmMorao1mSQJg9t9
 GeBzSj0zggokOrcQnw3Bn7dg4zU9uo78H/DTLw=
X-Received: by 2002:a17:902:db03:b0:2e7:f0ba:244d with SMTP id
 d9443c01a7336-2e7f0ba3f48mr4792825ad.36.1791409291830; 
 Wed, 07 Oct 2026 14:41:31 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 13/20] ring: promote soring API to stable
Date: Wed,  7 Oct 2026 14:39:43 -0700
Message-ID: <20261007214115.3092715-14-stephen@networkplumber.org>
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

The staged ordered ring (soring) API was introduced in 25.03 and the
core enqueue, dequeue, acquire and release functions have not changed
since.

Promote those to stable. The peek API added in 26.07 is left
experimental since it is only one release old, as is the soring and
ring headtail dump debug output which may still change.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  5 ++
 lib/ring/rte_soring.c                  |  4 +-
 lib/ring/rte_soring.h                  | 72 --------------------------
 lib/ring/soring.c                      | 32 ++++++------
 4 files changed, 23 insertions(+), 90 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e9e9b1f6da..790b8943c2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -359,6 +359,11 @@ API Changes
   ``rte_reorder_seqn``, ``rte_reorder_drain_up_to_seqn``,
   ``rte_reorder_min_seqn_set`` and ``rte_reorder_memory_footprint_get``.
 
+* ring: Promoted the staged ordered ring (soring) API from experimental
+  to stable, except the peek and dump functions.
+  The peek API added in 26.07 and the ``rte_soring_dump`` and
+  ``rte_ring_headtail_dump`` debug functions remain experimental.
+
 * telemetry: Promoted the following API from experimental to stable:
 
   * ``rte_tel_data_add_array_uint_hex``
diff --git a/lib/ring/rte_soring.c b/lib/ring/rte_soring.c
index 0d8abba69c..508de8cc74 100644
--- a/lib/ring/rte_soring.c
+++ b/lib/ring/rte_soring.c
@@ -120,7 +120,7 @@ rte_soring_dump(FILE *f, const struct rte_soring *r)
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_get_memsize, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_get_memsize)
 ssize_t
 rte_soring_get_memsize(const struct rte_soring_param *prm)
 {
@@ -154,7 +154,7 @@ soring_compilation_checks(void)
 		offsetof(struct soring_stage_headtail, unused));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_init, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_init)
 int
 rte_soring_init(struct rte_soring *r, const struct rte_soring_param *prm)
 {
diff --git a/lib/ring/rte_soring.h b/lib/ring/rte_soring.h
index 69ada68b24..82f5c09dca 100644
--- a/lib/ring/rte_soring.h
+++ b/lib/ring/rte_soring.h
@@ -68,9 +68,6 @@ struct rte_soring_param {
 struct rte_soring;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Calculate the memory size needed for a soring
  *
  * This function returns the number of bytes needed for a soring, given
@@ -85,14 +82,10 @@ struct rte_soring;
  *   - The memory size needed for the soring on success.
  *   - -EINVAL if provided parameter values are invalid.
  */
-__rte_experimental
 ssize_t
 rte_soring_get_memsize(const struct rte_soring_param *prm);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Initialize a soring structure.
  *
  * Initialize a soring structure in memory pointed by "r".
@@ -108,14 +101,10 @@ rte_soring_get_memsize(const struct rte_soring_param *prm);
  * @return
  *   - 0 on success, or a negative error code.
  */
-__rte_experimental
 int
 rte_soring_init(struct rte_soring *r,  const struct rte_soring_param *prm);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Return the total number of filled entries in a soring.
  *
  * @param r
@@ -123,14 +112,10 @@ rte_soring_init(struct rte_soring *r,  const struct rte_soring_param *prm);
  * @return
  *   The number of entries in the soring.
  */
-__rte_experimental
 unsigned int
 rte_soring_count(const struct rte_soring *r);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Return the total number of unfilled entries in a soring.
  *
  * @param r
@@ -138,7 +123,6 @@ rte_soring_count(const struct rte_soring *r);
  * @return
  *   The number of free entries in the soring.
  */
-__rte_experimental
 unsigned int
 rte_soring_free_count(const struct rte_soring *r);
 
@@ -158,9 +142,6 @@ void
 rte_soring_dump(FILE *f, const struct rte_soring *r);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue several objects on the soring.
  * Enqueues exactly requested number of objects or none.
  *
@@ -178,15 +159,11 @@ rte_soring_dump(FILE *f, const struct rte_soring *r);
  * @return
  *   - Actual number of objects enqueued, either 0 or n.
  */
-__rte_experimental
 uint32_t
 rte_soring_enqueue_bulk(struct rte_soring *r, const void *objs,
 	uint32_t n, uint32_t *free_space);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue several objects plus metadata on the soring.
  * Enqueues exactly requested number of objects or none.
  *
@@ -212,15 +189,11 @@ rte_soring_enqueue_bulk(struct rte_soring *r, const void *objs,
  * @return
  *   - Actual number of objects enqueued, either 0 or n.
  */
-__rte_experimental
 uint32_t
 rte_soring_enqueux_bulk(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, uint32_t *free_space);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue several objects on the soring.
  * Enqueues up to requested number of objects.
  *
@@ -238,15 +211,11 @@ rte_soring_enqueux_bulk(struct rte_soring *r, const void *objs,
  * @return
  *   - Actual number of objects enqueued.
  */
-__rte_experimental
 uint32_t
 rte_soring_enqueue_burst(struct rte_soring *r, const void *objs,
 	uint32_t n, uint32_t *free_space);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue several objects plus metadata on the soring.
  * Enqueues up to requested number of objects.
  *
@@ -272,15 +241,11 @@ rte_soring_enqueue_burst(struct rte_soring *r, const void *objs,
  * @return
  *   - Actual number of objects enqueued.
  */
-__rte_experimental
 uint32_t
 rte_soring_enqueux_burst(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, uint32_t *free_space);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Dequeue several objects from the soring.
  * Dequeues exactly requested number of objects or none.
  *
@@ -298,15 +263,11 @@ rte_soring_enqueux_burst(struct rte_soring *r, const void *objs,
  * @return
  *   - Actual number of objects dequeued, either 0 or 'num'.
  */
-__rte_experimental
 uint32_t
 rte_soring_dequeue_bulk(struct rte_soring *r, void *objs,
 	uint32_t num, uint32_t *available);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Dequeue several objects plus metadata from the soring.
  * Dequeues exactly requested number of objects or none.
  *
@@ -332,15 +293,11 @@ rte_soring_dequeue_bulk(struct rte_soring *r, void *objs,
  * @return
  *   - Actual number of objects dequeued, either 0 or 'num'.
  */
-__rte_experimental
 uint32_t
 rte_soring_dequeux_bulk(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, uint32_t *available);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Dequeue several objects from the soring.
  * Dequeues up to requested number of objects.
  *
@@ -358,15 +315,11 @@ rte_soring_dequeux_bulk(struct rte_soring *r, void *objs, void *meta,
  * @return
  *   - Actual number of objects dequeued.
  */
-__rte_experimental
 uint32_t
 rte_soring_dequeue_burst(struct rte_soring *r, void *objs,
 	uint32_t num, uint32_t *available);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Dequeue several objects plus metadata from the soring.
  * Dequeues up to requested number of objects.
  *
@@ -392,15 +345,11 @@ rte_soring_dequeue_burst(struct rte_soring *r, void *objs,
  * @return
  *   - Actual number of objects dequeued.
  */
-__rte_experimental
 uint32_t
 rte_soring_dequeux_burst(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, uint32_t *available);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Acquire several objects from the soring for given stage.
  * Acquires exactly requested number of objects or none.
  *
@@ -424,15 +373,11 @@ rte_soring_dequeux_burst(struct rte_soring *r, void *objs, void *meta,
  * @return
  *   - Actual number of objects acquired, either 0 or 'num'.
  */
-__rte_experimental
 uint32_t
 rte_soring_acquire_bulk(struct rte_soring *r, void *objs,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Acquire several objects plus metadata from the soring for given stage.
  * Acquires exactly requested number of objects or none.
  *
@@ -464,15 +409,11 @@ rte_soring_acquire_bulk(struct rte_soring *r, void *objs,
  * @return
  *   - Actual number of objects acquired, either 0 or 'num'.
  */
-__rte_experimental
 uint32_t
 rte_soring_acquirx_bulk(struct rte_soring *r, void *objs, void *meta,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Acquire several objects from the soring for given stage.
  * Acquires up to requested number of objects.
  *
@@ -496,15 +437,11 @@ rte_soring_acquirx_bulk(struct rte_soring *r, void *objs, void *meta,
  * @return
  *   - Actual number of objects acquired.
  */
-__rte_experimental
 uint32_t
 rte_soring_acquire_burst(struct rte_soring *r, void *objs,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Acquire several objects plus metadata from the soring for given stage.
  * Acquires up to requested number of objects.
  *
@@ -536,15 +473,11 @@ rte_soring_acquire_burst(struct rte_soring *r, void *objs,
  * @return
  *   - Actual number of objects acquired.
  */
-__rte_experimental
 uint32_t
 rte_soring_acquirx_burst(struct rte_soring *r, void *objs, void *meta,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Release several objects for given stage back to the soring.
  * Note that it means these objects become available for next stage or
  * dequeue.
@@ -565,15 +498,11 @@ rte_soring_acquirx_burst(struct rte_soring *r, void *objs, void *meta,
  * @param ftoken
  *   Opaque 'token' value obtained from acquire() op.
  */
-__rte_experimental
 void
 rte_soring_release(struct rte_soring *r, const void *objs,
 	uint32_t stage, uint32_t n, uint32_t ftoken);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Release several objects plus metadata for given stage back to the soring.
  * Note that it means these objects become available for next stage or
  * dequeue.
@@ -602,7 +531,6 @@ rte_soring_release(struct rte_soring *r, const void *objs,
  * @param ftoken
  *   Opaque 'token' value obtained from acquire() op.
  */
-__rte_experimental
 void
 rte_soring_releasx(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t stage, uint32_t n, uint32_t ftoken);
diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 45292c0f78..d2f67a7b48 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -635,7 +635,7 @@ soring_release(struct rte_soring *r, const void *objs,
  * Public functions (data-path) start here.
  */
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_release, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_release)
 void
 rte_soring_release(struct rte_soring *r, const void *objs,
 	uint32_t stage, uint32_t n, uint32_t ftoken)
@@ -644,7 +644,7 @@ rte_soring_release(struct rte_soring *r, const void *objs,
 }
 
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_releasx, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_releasx)
 void
 rte_soring_releasx(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t stage, uint32_t n, uint32_t ftoken)
@@ -652,7 +652,7 @@ rte_soring_releasx(struct rte_soring *r, const void *objs,
 	soring_release(r, objs, meta, stage, n, ftoken);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_bulk, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_enqueue_bulk)
 uint32_t
 rte_soring_enqueue_bulk(struct rte_soring *r, const void *objs, uint32_t n,
 	uint32_t *free_space)
@@ -661,7 +661,7 @@ rte_soring_enqueue_bulk(struct rte_soring *r, const void *objs, uint32_t n,
 			free_space);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueux_bulk, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_enqueux_bulk)
 uint32_t
 rte_soring_enqueux_bulk(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, uint32_t *free_space)
@@ -670,7 +670,7 @@ rte_soring_enqueux_bulk(struct rte_soring *r, const void *objs,
 			free_space);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_burst, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_enqueue_burst)
 uint32_t
 rte_soring_enqueue_burst(struct rte_soring *r, const void *objs, uint32_t n,
 	uint32_t *free_space)
@@ -679,7 +679,7 @@ rte_soring_enqueue_burst(struct rte_soring *r, const void *objs, uint32_t n,
 			free_space);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueux_burst, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_enqueux_burst)
 uint32_t
 rte_soring_enqueux_burst(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, uint32_t *free_space)
@@ -688,7 +688,7 @@ rte_soring_enqueux_burst(struct rte_soring *r, const void *objs,
 			free_space);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_bulk, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_dequeue_bulk)
 uint32_t
 rte_soring_dequeue_bulk(struct rte_soring *r, void *objs, uint32_t num,
 	uint32_t *available)
@@ -697,7 +697,7 @@ rte_soring_dequeue_bulk(struct rte_soring *r, void *objs, uint32_t num,
 			available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_bulk, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_dequeux_bulk)
 uint32_t
 rte_soring_dequeux_bulk(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, uint32_t *available)
@@ -706,7 +706,7 @@ rte_soring_dequeux_bulk(struct rte_soring *r, void *objs, void *meta,
 			available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_burst, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_dequeue_burst)
 uint32_t
 rte_soring_dequeue_burst(struct rte_soring *r, void *objs, uint32_t num,
 	uint32_t *available)
@@ -715,7 +715,7 @@ rte_soring_dequeue_burst(struct rte_soring *r, void *objs, uint32_t num,
 			available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_burst, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_dequeux_burst)
 uint32_t
 rte_soring_dequeux_burst(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, uint32_t *available)
@@ -724,7 +724,7 @@ rte_soring_dequeux_burst(struct rte_soring *r, void *objs, void *meta,
 			available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquire_bulk, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_acquire_bulk)
 uint32_t
 rte_soring_acquire_bulk(struct rte_soring *r, void *objs,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -733,7 +733,7 @@ rte_soring_acquire_bulk(struct rte_soring *r, void *objs,
 			RTE_RING_QUEUE_FIXED, ftoken, available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquirx_bulk, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_acquirx_bulk)
 uint32_t
 rte_soring_acquirx_bulk(struct rte_soring *r, void *objs, void *meta,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -742,7 +742,7 @@ rte_soring_acquirx_bulk(struct rte_soring *r, void *objs, void *meta,
 			RTE_RING_QUEUE_FIXED, ftoken, available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquire_burst, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_acquire_burst)
 uint32_t
 rte_soring_acquire_burst(struct rte_soring *r, void *objs,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -751,7 +751,7 @@ rte_soring_acquire_burst(struct rte_soring *r, void *objs,
 			RTE_RING_QUEUE_VARIABLE, ftoken, available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquirx_burst, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_acquirx_burst)
 uint32_t
 rte_soring_acquirx_burst(struct rte_soring *r, void *objs, void *meta,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -760,7 +760,7 @@ rte_soring_acquirx_burst(struct rte_soring *r, void *objs, void *meta,
 			RTE_RING_QUEUE_VARIABLE, ftoken, available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_count, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_count)
 unsigned int
 rte_soring_count(const struct rte_soring *r)
 {
@@ -770,7 +770,7 @@ rte_soring_count(const struct rte_soring *r)
 	return (count > r->capacity) ? r->capacity : count;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_free_count, 25.03)
+RTE_EXPORT_SYMBOL(rte_soring_free_count)
 unsigned int
 rte_soring_free_count(const struct rte_soring *r)
 {
-- 
2.53.0

