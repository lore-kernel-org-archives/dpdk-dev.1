Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E3CC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 13:25:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9035C40616;
	Tue, 22 Jul 2025 15:24:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 665E24003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 15:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753190696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpQP7bs/nETpRQNHWYjAKowODKXd+zvgZg/76wo4jYY=;
 b=adNP0H5C1mQMyTh8HofHNBDVbfINB3RrYvlqH0qooVQw8L6IQsy6xRwtUTtLSgI4Katrxe
 V0KQ1St8dbXwKvS1EoR8bBWHqZl3WNcWVD77rEeVlczCe0I1rL+2tBDsFdmHsWt7S664YS
 uLfQnaLhnqxDjTYVxNeQWPqQ09xnbCU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-ZuPmr0VoNru9-yZI3aAm7w-1; Tue,
 22 Jul 2025 09:24:55 -0400
X-MC-Unique: ZuPmr0VoNru9-yZI3aAm7w-1
X-Mimecast-MFC-AGG-ID: ZuPmr0VoNru9-yZI3aAm7w_1753190694
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A5031800878; Tue, 22 Jul 2025 13:24:54 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 206EE19560AD; Tue, 22 Jul 2025 13:24:52 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH 2/2] net: remove v25 ABI compatibility
Date: Tue, 22 Jul 2025 15:24:41 +0200
Message-ID: <20250722132441.3700305-2-david.marchand@redhat.com>
In-Reply-To: <20250722132441.3700305-1-david.marchand@redhat.com>
References: <20250722132441.3700305-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LaFTPvEBUCnNZfYL50-N5XM4wsXXHlKhY2pTk1M2cg0_1753190694
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Now that the ABI has been bumped to 26, we can drop compatibility
symbols for the CRC API.

The logtype is not used anymore and can be removed.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/net/meson.build   |   2 -
 lib/net/rte_net_crc.c | 197 +++---------------------------------------
 2 files changed, 14 insertions(+), 185 deletions(-)

diff --git a/lib/net/meson.build b/lib/net/meson.build
index c528fcc9a2..3fad5edc5b 100644
--- a/lib/net/meson.build
+++ b/lib/net/meson.build
@@ -39,8 +39,6 @@ sources = files(
 )
 deps += ['mbuf']
 
-use_function_versioning = true
-
 if dpdk_conf.has('RTE_ARCH_X86_64')
     sources += files('net_crc_sse.c')
     cflags_options = ['-mpclmul', '-maes']
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index b8b0ba5127..3a589bdd6d 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -9,7 +9,6 @@
 #include <rte_cpuflags.h>
 #include <rte_common.h>
 #include <rte_net_crc.h>
-#include <rte_log.h>
 #include <rte_vect.h>
 #include <rte_malloc.h>
 
@@ -25,12 +24,6 @@
 static uint32_t crc32_eth_lut[CRC_LUT_SIZE];
 static uint32_t crc16_ccitt_lut[CRC_LUT_SIZE];
 
-static uint32_t
-rte_crc16_ccitt_default_handler(const uint8_t *data, uint32_t data_len);
-
-static uint32_t
-rte_crc32_eth_default_handler(const uint8_t *data, uint32_t data_len);
-
 static uint32_t
 rte_crc16_ccitt_handler(const uint8_t *data, uint32_t data_len);
 
@@ -45,47 +38,9 @@ struct rte_net_crc {
 	enum rte_net_crc_type type;
 };
 
-static rte_net_crc_handler handlers_default[] = {
-	[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_default_handler,
-	[RTE_NET_CRC32_ETH] = rte_crc32_eth_default_handler,
-};
-
 static struct {
 	rte_net_crc_handler f[RTE_NET_CRC_REQS];
-} handlers_dpdk26[RTE_NET_CRC_AVX512 + 1];
-
-static const rte_net_crc_handler *handlers = handlers_default;
-
-static const rte_net_crc_handler handlers_scalar[] = {
-	[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_handler,
-	[RTE_NET_CRC32_ETH] = rte_crc32_eth_handler,
-};
-#ifdef CC_AVX512_SUPPORT
-static const rte_net_crc_handler handlers_avx512[] = {
-	[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_avx512_handler,
-	[RTE_NET_CRC32_ETH] = rte_crc32_eth_avx512_handler,
-};
-#endif
-#ifdef RTE_ARCH_X86_64
-static const rte_net_crc_handler handlers_sse42[] = {
-	[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_sse42_handler,
-	[RTE_NET_CRC32_ETH] = rte_crc32_eth_sse42_handler,
-};
-#endif
-#ifdef CC_ARM64_NEON_PMULL_SUPPORT
-static const rte_net_crc_handler handlers_neon[] = {
-	[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_neon_handler,
-	[RTE_NET_CRC32_ETH] = rte_crc32_eth_neon_handler,
-};
-#endif
-
-static uint16_t max_simd_bitwidth;
-
-RTE_LOG_REGISTER_DEFAULT(libnet_logtype, INFO);
-#define RTE_LOGTYPE_NET libnet_logtype
-
-#define NET_LOG(level, ...) \
-	RTE_LOG_LINE_PREFIX(level, NET, "%s(): ", __func__, __VA_ARGS__)
+} handlers[RTE_NET_CRC_AVX512 + 1];
 
 /* Scalar handling */
 
@@ -182,18 +137,6 @@ rte_crc32_eth_handler(const uint8_t *data, uint32_t data_len)
 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_VPCLMULQDQ) \
 )
 
-static const rte_net_crc_handler *
-avx512_vpclmulqdq_get_handlers(void)
-{
-#ifdef CC_AVX512_SUPPORT
-	if (AVX512_VPCLMULQDQ_CPU_SUPPORTED &&
-			max_simd_bitwidth >= RTE_VECT_SIMD_512)
-		return handlers_avx512;
-#endif
-	NET_LOG(INFO, "Requirements not met, can't use AVX512");
-	return NULL;
-}
-
 static void
 avx512_vpclmulqdq_init(void)
 {
@@ -208,18 +151,6 @@ avx512_vpclmulqdq_init(void)
 #define SSE42_PCLMULQDQ_CPU_SUPPORTED \
 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_PCLMULQDQ)
 
-static const rte_net_crc_handler *
-sse42_pclmulqdq_get_handlers(void)
-{
-#ifdef RTE_ARCH_X86_64
-	if (SSE42_PCLMULQDQ_CPU_SUPPORTED &&
-			max_simd_bitwidth >= RTE_VECT_SIMD_128)
-		return handlers_sse42;
-#endif
-	NET_LOG(INFO, "Requirements not met, can't use SSE");
-	return NULL;
-}
-
 static void
 sse42_pclmulqdq_init(void)
 {
@@ -234,18 +165,6 @@ sse42_pclmulqdq_init(void)
 #define NEON_PMULL_CPU_SUPPORTED \
 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_PMULL)
 
-static const rte_net_crc_handler *
-neon_pmull_get_handlers(void)
-{
-#ifdef CC_ARM64_NEON_PMULL_SUPPORT
-	if (NEON_PMULL_CPU_SUPPORTED &&
-			max_simd_bitwidth >= RTE_VECT_SIMD_128)
-		return handlers_neon;
-#endif
-	NET_LOG(INFO, "Requirements not met, can't use NEON");
-	return NULL;
-}
-
 static void
 neon_pmull_init(void)
 {
@@ -255,62 +174,18 @@ neon_pmull_init(void)
 #endif
 }
 
-/* Default handling */
-
-static uint32_t
-rte_crc16_ccitt_default_handler(const uint8_t *data, uint32_t data_len)
-{
-	handlers = NULL;
-	if (max_simd_bitwidth == 0)
-		max_simd_bitwidth = rte_vect_get_max_simd_bitwidth();
-
-	handlers = avx512_vpclmulqdq_get_handlers();
-	if (handlers != NULL)
-		return handlers[RTE_NET_CRC16_CCITT](data, data_len);
-	handlers = sse42_pclmulqdq_get_handlers();
-	if (handlers != NULL)
-		return handlers[RTE_NET_CRC16_CCITT](data, data_len);
-	handlers = neon_pmull_get_handlers();
-	if (handlers != NULL)
-		return handlers[RTE_NET_CRC16_CCITT](data, data_len);
-	handlers = handlers_scalar;
-	return handlers[RTE_NET_CRC16_CCITT](data, data_len);
-}
-
-static uint32_t
-rte_crc32_eth_default_handler(const uint8_t *data, uint32_t data_len)
-{
-	handlers = NULL;
-	if (max_simd_bitwidth == 0)
-		max_simd_bitwidth = rte_vect_get_max_simd_bitwidth();
-
-	handlers = avx512_vpclmulqdq_get_handlers();
-	if (handlers != NULL)
-		return handlers[RTE_NET_CRC32_ETH](data, data_len);
-	handlers = sse42_pclmulqdq_get_handlers();
-	if (handlers != NULL)
-		return handlers[RTE_NET_CRC32_ETH](data, data_len);
-	handlers = neon_pmull_get_handlers();
-	if (handlers != NULL)
-		return handlers[RTE_NET_CRC32_ETH](data, data_len);
-	handlers = handlers_scalar;
-	return handlers[RTE_NET_CRC32_ETH](data, data_len);
-}
-
 static void
 handlers_init(enum rte_net_crc_alg alg)
 {
-	handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_handler;
-	handlers_dpdk26[alg].f[RTE_NET_CRC32_ETH] = rte_crc32_eth_handler;
+	handlers[alg].f[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_handler;
+	handlers[alg].f[RTE_NET_CRC32_ETH] = rte_crc32_eth_handler;
 
 	switch (alg) {
 	case RTE_NET_CRC_AVX512:
 #ifdef CC_AVX512_SUPPORT
 		if (AVX512_VPCLMULQDQ_CPU_SUPPORTED) {
-			handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] =
-				rte_crc16_ccitt_avx512_handler;
-			handlers_dpdk26[alg].f[RTE_NET_CRC32_ETH] =
-				rte_crc32_eth_avx512_handler;
+			handlers[alg].f[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_avx512_handler;
+			handlers[alg].f[RTE_NET_CRC32_ETH] = rte_crc32_eth_avx512_handler;
 			break;
 		}
 #endif
@@ -318,20 +193,16 @@ handlers_init(enum rte_net_crc_alg alg)
 	case RTE_NET_CRC_SSE42:
 #ifdef RTE_ARCH_X86_64
 		if (SSE42_PCLMULQDQ_CPU_SUPPORTED) {
-			handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] =
-				rte_crc16_ccitt_sse42_handler;
-			handlers_dpdk26[alg].f[RTE_NET_CRC32_ETH] =
-				rte_crc32_eth_sse42_handler;
+			handlers[alg].f[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_sse42_handler;
+			handlers[alg].f[RTE_NET_CRC32_ETH] = rte_crc32_eth_sse42_handler;
 		}
 #endif
 		break;
 	case RTE_NET_CRC_NEON:
 #ifdef CC_ARM64_NEON_PMULL_SUPPORT
 		if (NEON_PMULL_CPU_SUPPORTED) {
-			handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] =
-				rte_crc16_ccitt_neon_handler;
-			handlers_dpdk26[alg].f[RTE_NET_CRC32_ETH] =
-				rte_crc32_eth_neon_handler;
+			handlers[alg].f[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_neon_handler;
+			handlers[alg].f[RTE_NET_CRC32_ETH] = rte_crc32_eth_neon_handler;
 			break;
 		}
 #endif
@@ -345,36 +216,8 @@ handlers_init(enum rte_net_crc_alg alg)
 
 /* Public API */
 
-RTE_VERSION_SYMBOL(25, void, rte_net_crc_set_alg, (enum rte_net_crc_alg alg))
-{
-	handlers = NULL;
-	if (max_simd_bitwidth == 0)
-		max_simd_bitwidth = rte_vect_get_max_simd_bitwidth();
-
-	switch (alg) {
-	case RTE_NET_CRC_AVX512:
-		handlers = avx512_vpclmulqdq_get_handlers();
-		if (handlers != NULL)
-			break;
-		/* fall-through */
-	case RTE_NET_CRC_SSE42:
-		handlers = sse42_pclmulqdq_get_handlers();
-		break; /* for x86, always break here */
-	case RTE_NET_CRC_NEON:
-		handlers = neon_pmull_get_handlers();
-		/* fall-through */
-	case RTE_NET_CRC_SCALAR:
-		/* fall-through */
-	default:
-		break;
-	}
-
-	if (handlers == NULL)
-		handlers = handlers_scalar;
-}
-
-RTE_DEFAULT_SYMBOL(26, struct rte_net_crc *, rte_net_crc_set_alg, (enum rte_net_crc_alg alg,
-	enum rte_net_crc_type type))
+RTE_EXPORT_SYMBOL(rte_net_crc_set_alg)
+struct rte_net_crc *rte_net_crc_set_alg(enum rte_net_crc_alg alg, enum rte_net_crc_type type)
 {
 	uint16_t max_simd_bitwidth;
 	struct rte_net_crc *crc;
@@ -419,22 +262,10 @@ void rte_net_crc_free(struct rte_net_crc *crc)
 	rte_free(crc);
 }
 
-RTE_VERSION_SYMBOL(25, uint32_t, rte_net_crc_calc, (const void *data, uint32_t data_len,
-	enum rte_net_crc_type type))
-{
-	uint32_t ret;
-	rte_net_crc_handler f_handle;
-
-	f_handle = handlers[type];
-	ret = f_handle(data, data_len);
-
-	return ret;
-}
-
-RTE_DEFAULT_SYMBOL(26, uint32_t, rte_net_crc_calc, (const struct rte_net_crc *ctx,
-	const void *data, const uint32_t data_len))
+RTE_EXPORT_SYMBOL(rte_net_crc_calc)
+uint32_t rte_net_crc_calc(const struct rte_net_crc *ctx, const void *data, const uint32_t data_len)
 {
-	return handlers_dpdk26[ctx->alg].f[ctx->type](data, data_len);
+	return handlers[ctx->alg].f[ctx->type](data, data_len);
 }
 
 /* Call initialisation helpers for all crc algorithm handlers */
-- 
2.50.0

