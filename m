Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8486CA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:43:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0271542E15;
	Wed,  7 Oct 2026 23:41:42 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2E3EC427B2
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:37 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2db80fcdf8bso18266135ad.2
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409296;
 x=1792014096; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bgOI2Y+H9dPvxGLAnU6Kxef2XBJDDup1zF3Tg6kgieM=;
 b=mqwFODOhhx+mrgGoDYN1M3zDqlXSMZOL1ucy9Ek2tKdJ99dIWTh27APzs5FJJFk4ei
 cKSh0zkmt5e5dhX4MI++rwLoUbZCk1uNSq3eB2O9Z8cIornW5j4yk4H79La3+zUcTTJ+
 wF0lfz3Ofu55BougR3MWz+0xEWKpXOwP1sRk/2rtXfDjtw6PQswuEv1Ht7oAGLvNTAig
 QvZlxKMHwJrhEH2gvfr5qM0NL8ZWHDx1tnnQlC3K7Bgxwmc8gyOS4AVHu1fUIL5oosI0
 +0dXKR7RV2eKMMKIiMSuUMt1xXJpPrDK2le9eY0n9F+vwtAJBS2ozwwhhUSOlTBJPosd
 Id/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409296; x=1792014096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bgOI2Y+H9dPvxGLAnU6Kxef2XBJDDup1zF3Tg6kgieM=;
 b=dBmDEy8icJbHC6D5PuajZhIijL3MkpDLimJiIqII9FEDOonOFBFuVJNwDTyzt0DnBp
 QXjalukMrm6hv2ogWel6XbuThQF/E/CtlQVTbHD+Ep5769hHZw24rPNc2p1pAgSN7X21
 fxMXAuRT/Q4//O6ajQ7NrZkK/7aLX6Ci1J67PMrvbwTOjLVXgrYa2kNkTVLMGKD9aqlM
 ej4M6YeuY+l9+QEhWkqVUB4yka+A3i/h4k0a7cYZMX/jWN54ragbCmZpi1g/L7kSEIgg
 ryg2xVcA+YNjo3Q627zLs1AIzJ0Zf0XwrOFbjOusntnleLNl5UUBhQxZAoxTnoN9QchO
 L2Wg==
X-Gm-Message-State: AFq9FYLJRlYMlhNifufCmKo2CCg0+LWUVGXrOYxtk5cgnWpe/6A7eK/0
 6TPCwMJojRk/FGkO+wwZ8upKF66ILAEYcMM2QQgXG8623uya0b5mL1eQEjR6WHw2Um0ktza9lk2
 1W+u1K0w=
X-Gm-Gg: AYBFou2AnTDTYde3qCZ1Exo3bievPELRnY5htpg38X8bg0CLc5MivS/h7I0YWyaBe3D
 dqsRmHm96vGDlYWWlQYx62xlrtzfAg7+dBI8bVZDD8s1a6Cu2jhX7z3mZ2bC4zj5VWovd3zc0hk
 r/t4Mwn1Avg5/c+1yQZuYkg2ipsZGJKdOM9i7mtXFnTRMZsha878A03JnnyskH0Kks0Y0dSHcQB
 S97cb9nszW90jsJ4HMTuI4dsjOfMI7Hp8QgW6DpTbHDWIjIxDZiO/9YY+cnPEOkG8GBCu62h+cL
 UOBVw7T0xeLdvd/UViahBwfcmfIhPsGWtAnKw06wHxI/OPZESdTwD3FtQsAlN8LXkPzbbky0MoW
 cgKT1mn5ZeytcwU4daUXeqihwKkLQ/9PtQlprNjb15f6IdNVNYBWRqL8HonijhdAi7IKqhQku6W
 Ooqe7qf9k9mB6GzxhrBENfJ88hOVLoXHkmnWObx2Jc0ytM+V1IPOMVBQ1fpsf02kj2ZR0WekxaD
 z91a/sJMD1YTE+Ovs7Eaa9CX1ujsd+0UuF0Cw==
X-Received: by 2002:a17:903:1ae7:b0:2e2:c55c:90c with SMTP id
 d9443c01a7336-2e60056cfd9mr28677255ad.64.1791409296346; 
 Wed, 07 Oct 2026 14:41:36 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 18/20] cryptodev: promote algorithm helpers to stable
Date: Wed,  7 Oct 2026 14:39:48 -0700
Message-ID: <20261007214115.3092715-19-stephen@networkplumber.org>
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

The algorithm name lookup helpers were added in 23.03 and the
asymmetric opcap check in 24.11. The inline raw enqueue/dequeue and
mbuf-to-vec helpers date back to 21.05. None of them have changed and
all are driver independent.

The queue pair reset, event error query and queue pair depth functions
are left experimental. They are currently implemented only by
crypto/cnxk, so the interface should not be frozen before a second
driver has tried to use it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 lib/cryptodev/rte_crypto_sym.h         |  2 --
 lib/cryptodev/rte_cryptodev.c          | 10 +++++-----
 lib/cryptodev/rte_cryptodev.h          | 10 ----------
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index f689f08338..6055c1edee 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -225,6 +225,10 @@ API Changes
 
 * cmdline: Promoted ``cmdline_token_bool_ops`` from experimental to stable.
 
+* cryptodev: Promoted the algorithm name helpers and the asymmetric
+  capability check from experimental to stable, along with the inline
+  raw enqueue/dequeue and mbuf-to-vec helpers.
+
 * dispatcher: Promoted the whole library API from experimental to stable.
   The ``rte_dispatcher_*`` functions are unchanged since the library was
   added in 23.11.
diff --git a/lib/cryptodev/rte_crypto_sym.h b/lib/cryptodev/rte_crypto_sym.h
index 630fd153bd..9bf5e63ce1 100644
--- a/lib/cryptodev/rte_crypto_sym.h
+++ b/lib/cryptodev/rte_crypto_sym.h
@@ -16,7 +16,6 @@
 
 #include <string.h>
 
-#include <rte_compat.h>
 #include <rte_mbuf.h>
 #include <rte_memory.h>
 #include <rte_mempool.h>
@@ -983,7 +982,6 @@ __rte_crypto_sym_op_attach_sym_session(struct rte_crypto_sym_op *sym_op, void *s
  *   - number of successfully filled entries in *vec* array.
  *   - negative number of elements in *vec* array required.
  */
-__rte_experimental
 static inline int
 rte_crypto_mbuf_to_vec(const struct rte_mbuf *mb, uint32_t ofs, uint32_t len,
 	struct rte_crypto_vec vec[], uint32_t num)
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 829a5d0846..f2d2e5c864 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -407,7 +407,7 @@ rte_cryptodev_asym_get_xform_enum(enum rte_crypto_asym_xform_type *xform_enum,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_cipher_algo_string, 23.03)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_cipher_algo_string)
 const char *
 rte_cryptodev_get_cipher_algo_string(enum rte_crypto_cipher_algorithm algo_enum)
 {
@@ -421,7 +421,7 @@ rte_cryptodev_get_cipher_algo_string(enum rte_crypto_cipher_algorithm algo_enum)
 	return alg_str;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_auth_algo_string, 23.03)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_auth_algo_string)
 const char *
 rte_cryptodev_get_auth_algo_string(enum rte_crypto_auth_algorithm algo_enum)
 {
@@ -435,7 +435,7 @@ rte_cryptodev_get_auth_algo_string(enum rte_crypto_auth_algorithm algo_enum)
 	return alg_str;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_aead_algo_string, 23.03)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_aead_algo_string)
 const char *
 rte_cryptodev_get_aead_algo_string(enum rte_crypto_aead_algorithm algo_enum)
 {
@@ -449,7 +449,7 @@ rte_cryptodev_get_aead_algo_string(enum rte_crypto_aead_algorithm algo_enum)
 	return alg_str;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_asym_get_xform_string, 23.03)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_get_xform_string)
 const char *
 rte_cryptodev_asym_get_xform_string(enum rte_crypto_asym_xform_type xform_enum)
 {
@@ -731,7 +731,7 @@ rte_cryptodev_asym_xform_capability_check_hash(
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_asym_xform_capability_check_opcap, 24.11)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_xform_capability_check_opcap)
 int
 rte_cryptodev_asym_xform_capability_check_opcap(
 	const struct rte_cryptodev_asymmetric_xform_capability *capability,
diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.h
index 37a6a5e49b..b8c00fe576 100644
--- a/lib/cryptodev/rte_cryptodev.h
+++ b/lib/cryptodev/rte_cryptodev.h
@@ -372,9 +372,6 @@ rte_cryptodev_asym_xform_capability_check_hash(
 	enum rte_crypto_auth_algorithm hash);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Check if op capability is supported
  *
  * @param	capability	Description of the asymmetric crypto capability.
@@ -385,7 +382,6 @@ rte_cryptodev_asym_xform_capability_check_hash(
  *   - Return 1 if the op capability is supported
  *   - Return 0 if unsupported
  */
-__rte_experimental
 int
 rte_cryptodev_asym_xform_capability_check_opcap(
 	const struct rte_cryptodev_asymmetric_xform_capability *capability,
@@ -460,7 +456,6 @@ rte_cryptodev_asym_get_xform_enum(enum rte_crypto_asym_xform_type *xform_enum,
  * - Return NULL if enum is not valid
  * - Return algo_string corresponding to enum
  */
-__rte_experimental
 const char *
 rte_cryptodev_get_cipher_algo_string(enum rte_crypto_cipher_algorithm algo_enum);
 
@@ -473,7 +468,6 @@ rte_cryptodev_get_cipher_algo_string(enum rte_crypto_cipher_algorithm algo_enum)
  * - Return NULL if enum is not valid
  * - Return algo_string corresponding to enum
  */
-__rte_experimental
 const char *
 rte_cryptodev_get_auth_algo_string(enum rte_crypto_auth_algorithm algo_enum);
 
@@ -486,7 +480,6 @@ rte_cryptodev_get_auth_algo_string(enum rte_crypto_auth_algorithm algo_enum);
  * - Return NULL if enum is not valid
  * - Return algo_string corresponding to enum
  */
-__rte_experimental
 const char *
 rte_cryptodev_get_aead_algo_string(enum rte_crypto_aead_algorithm algo_enum);
 
@@ -499,7 +492,6 @@ rte_cryptodev_get_aead_algo_string(enum rte_crypto_aead_algorithm algo_enum);
  * - Return NULL, if enum is not valid.
  * - Return xform string, for valid enum.
  */
-__rte_experimental
 const char *
 rte_cryptodev_asym_get_xform_string(enum rte_crypto_asym_xform_type xform_enum);
 
@@ -1690,7 +1682,6 @@ rte_cryptodev_raw_enqueue_burst(struct rte_crypto_raw_dp_ctx *ctx,
  *        until rte_cryptodev_raw_enqueue_done() is called.
  *   - negative integer: failure.
  */
-__rte_experimental
 static __rte_always_inline int
 rte_cryptodev_raw_enqueue(struct rte_crypto_raw_dp_ctx *ctx,
 	struct rte_crypto_vec *data_vec, uint16_t n_data_vecs,
@@ -1790,7 +1781,6 @@ rte_cryptodev_raw_dequeue_burst(struct rte_crypto_raw_dp_ctx *ctx,
  *   - The user data pointer retrieved from device queue or NULL if no
  *     operation is ready for dequeue.
  */
-__rte_experimental
 static __rte_always_inline void *
 rte_cryptodev_raw_dequeue(struct rte_crypto_raw_dp_ctx *ctx,
 		int *dequeue_status, enum rte_crypto_op_status *op_status)
-- 
2.53.0

