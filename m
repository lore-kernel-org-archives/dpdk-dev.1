Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BA8C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 17:45:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA23341153;
	Mon, 10 Feb 2025 18:45:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1B35940615
 for <dev@dpdk.org>; Mon, 10 Feb 2025 18:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739209511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/w5IJSVWPMCdTFOAUjdozXIaLnUVopo+P80xMURmX+M=;
 b=G5VQds9VhID/mpmPLQmKOtySyObJEsU6cQF9PRmiYhrukdHpaNBT1fJsoA+LqL2HOd4lQd
 Dq9IGeyjE3Q7UVE/XoV0WGQ9zpoZLvisdMWbNQ98GN1WQxb3NvxUrMk7nnYfeoHavUbfyI
 1RYzWJC0hn54IlFgbBuz2UTGOfN+k3o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-CzHpdNQXNPycoQKgi8702Q-1; Mon,
 10 Feb 2025 12:45:09 -0500
X-MC-Unique: CzHpdNQXNPycoQKgi8702Q-1
X-Mimecast-MFC-AGG-ID: CzHpdNQXNPycoQKgi8702Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C862318011F7; Mon, 10 Feb 2025 17:45:05 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5792B30001AB; Mon, 10 Feb 2025 17:45:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, fengchengwen@huawei.com,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 6/6] trace: fix undefined behavior in register
Date: Mon, 10 Feb 2025 18:44:22 +0100
Message-ID: <20250210174424.3364021-7-david.marchand@redhat.com>
In-Reply-To: <20250210174424.3364021-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6pmnZHRhn_SUh8D2u2H4l4fx0kW9UtFBbkYiycsuvRE_1739209506
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

Registering a tracepoint handler was resulting so far in undefined
behavior at runtime.

The RTE_TRACE_POINT_REGISTER() macro was casting the tracepoint handler
(which expects arguments) to a void (*)(void).
At runtime, calling this handler while registering resulted in
reading the current stack with no relation to this function prototype.

Instead, declare an additional inline _register() handler for each
tracepoint and make sure that the emitting macros in
rte_trace_point_register.h only work on arguments name and type.

The original tracepoint handler prototype is adjusted by adding a
__rte_unused for each argument (since emitting macros do nothing
with them).
This last part introduces an implementation limit of 15 arguments.

With this change in place, the workaround in dmadev tracepoints can be
removed.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/dmadev/rte_dmadev_trace.h              | 12 ------
 lib/dmadev/rte_dmadev_trace_fp.h           | 14 -------
 lib/eal/include/rte_trace_point.h          |  4 ++
 lib/eal/include/rte_trace_point_register.h | 43 +++++++++++++++++++---
 4 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index ddf60b9649..9de9b54aad 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -22,10 +22,6 @@ extern "C" {
 RTE_TRACE_POINT(
 	rte_dma_trace_info_get,
 	RTE_TRACE_POINT_ARGS(int16_t dev_id, struct rte_dma_info *dev_info),
-#ifdef _RTE_TRACE_POINT_REGISTER_H_
-	struct rte_dma_info __dev_info = {0};
-	dev_info = &__dev_info;
-#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_string(dev_info->dev_name);
 	rte_trace_point_emit_u64(dev_info->dev_capa);
@@ -42,10 +38,6 @@ RTE_TRACE_POINT(
 	rte_dma_trace_configure,
 	RTE_TRACE_POINT_ARGS(int16_t dev_id, const struct rte_dma_conf *dev_conf,
 			     int ret),
-#ifdef _RTE_TRACE_POINT_REGISTER_H_
-	const struct rte_dma_conf __dev_conf = {0};
-	dev_conf = &__dev_conf;
-#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(dev_conf->nb_vchans);
 	rte_trace_point_emit_u16(dev_conf->priority);
@@ -78,10 +70,6 @@ RTE_TRACE_POINT(
 	rte_dma_trace_vchan_setup,
 	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan,
 			     const struct rte_dma_vchan_conf *conf, int ret),
-#ifdef _RTE_TRACE_POINT_REGISTER_H_
-	const struct rte_dma_vchan_conf __conf = {0};
-	conf = &__conf;
-#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
 	rte_trace_point_emit_int(conf->direction);
diff --git a/lib/dmadev/rte_dmadev_trace_fp.h b/lib/dmadev/rte_dmadev_trace_fp.h
index 4950f58cd2..106eac24be 100644
--- a/lib/dmadev/rte_dmadev_trace_fp.h
+++ b/lib/dmadev/rte_dmadev_trace_fp.h
@@ -33,10 +33,6 @@ RTE_TRACE_POINT_FP(
 	rte_dma_trace_vchan_status,
 	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan,
 			     enum rte_dma_vchan_status *status, int ret),
-#ifdef _RTE_TRACE_POINT_REGISTER_H_
-	enum rte_dma_vchan_status __status = 0;
-	status = &__status;
-#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
 	rte_trace_point_emit_int(*status);
@@ -100,12 +96,6 @@ RTE_TRACE_POINT_FP(
 	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan,
 			     const uint16_t nb_cpls, uint16_t *last_idx,
 			     bool *has_error, uint16_t ret),
-#ifdef _RTE_TRACE_POINT_REGISTER_H_
-	uint16_t __last_idx = 0;
-	bool __has_error = false;
-	last_idx = &__last_idx;
-	has_error = &__has_error;
-#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
 	rte_trace_point_emit_u16(nb_cpls);
@@ -119,10 +109,6 @@ RTE_TRACE_POINT_FP(
 	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan,
 			     const uint16_t nb_cpls, uint16_t *last_idx,
 			     enum rte_dma_status_code *status, uint16_t ret),
-#ifdef _RTE_TRACE_POINT_REGISTER_H_
-	uint16_t __last_idx = 0;
-	last_idx = &__last_idx;
-#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
 	rte_trace_point_emit_u16(nb_cpls);
diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index a162502002..444175f238 100644
--- a/lib/eal/include/rte_trace_point.h
+++ b/lib/eal/include/rte_trace_point.h
@@ -36,6 +36,8 @@ extern "C" {
 /** The tracepoint object. */
 typedef RTE_ATOMIC(uint64_t) rte_trace_point_t;
 
+#ifndef _RTE_TRACE_POINT_REGISTER_H_
+
 /**
  * Macro to define the tracepoint arguments in RTE_TRACE_POINT macro.
 
@@ -53,6 +55,8 @@ _tp _args \
 	__VA_ARGS__ \
 }
 
+#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
+
 /**
  * Create a tracepoint.
  *
diff --git a/lib/eal/include/rte_trace_point_register.h b/lib/eal/include/rte_trace_point_register.h
index 8d0959c403..06f5eae377 100644
--- a/lib/eal/include/rte_trace_point_register.h
+++ b/lib/eal/include/rte_trace_point_register.h
@@ -18,6 +18,43 @@ extern "C" {
 
 RTE_DECLARE_PER_LCORE(volatile int, trace_point_sz);
 
+#define RTE_TRACE_POINT_ARGS_COUNT_(_0,_1,_2,_3,_4,_5,_6,_7,_8,_9,_10,_11,_12,_13,_14,_15,N, ...) \
+	N
+#define RTE_TRACE_POINT_ARGS_COUNT(...) \
+	RTE_TRACE_POINT_ARGS_COUNT_(__VA_ARGS__,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0)
+
+#define RTE_TRACE_POINT_ARGS_1(a) __rte_unused a
+#define RTE_TRACE_POINT_ARGS_2(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_1(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_3(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_2(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_4(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_3(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_5(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_4(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_6(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_5(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_7(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_6(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_8(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_7(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_9(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_8(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_10(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_9(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_11(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_10(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_12(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_11(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_13(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_12(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_14(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_13(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_15(a, ...) __rte_unused a, RTE_TRACE_POINT_ARGS_14(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS_FUNC(a) RTE_TRACE_POINT_ARGS_ ## a
+#define RTE_TRACE_POINT_ARGS_EXPAND(...) __VA_ARGS__
+#define RTE_TRACE_POINT_ARGS_(N, ...) \
+	RTE_TRACE_POINT_ARGS_EXPAND(RTE_TRACE_POINT_ARGS_FUNC(N))(__VA_ARGS__)
+#define RTE_TRACE_POINT_ARGS(...) \
+	(RTE_TRACE_POINT_ARGS_(RTE_TRACE_POINT_ARGS_COUNT(0, __VA_ARGS__), __VA_ARGS__))
+
+#define __RTE_TRACE_POINT(_mode, _tp, _args, ...) \
+extern rte_trace_point_t __##_tp; \
+static __rte_always_inline void _tp _args { } \
+static __rte_always_inline void \
+_tp ## _register (void) \
+{ \
+	__rte_trace_point_emit_header_##_mode(&__##_tp); \
+	__VA_ARGS__ \
+}
+
 #define RTE_TRACE_POINT_REGISTER(trace, name) \
 rte_trace_point_t __rte_section("__rte_trace_point") __##trace; \
 static const char __##trace##_name[] = RTE_STR(name); \
@@ -26,7 +63,7 @@ RTE_INIT(trace##_init) \
 	if (!rte_trace_feature_is_enabled()) \
 		return; \
 	__rte_trace_point_register(&__##trace, __##trace##_name, \
-		(void (*)(void)) trace); \
+		trace ## _register); \
 }
 
 #define __rte_trace_point_emit_header_generic(t) \
@@ -37,22 +74,18 @@ RTE_INIT(trace##_init) \
 
 #define __rte_trace_point_emit(in, type) \
 do { \
-	RTE_SET_USED(in); \
 	__rte_trace_point_emit_field(sizeof(type), RTE_STR(in), \
 		RTE_STR(type)); \
 } while (0)
 
 #define rte_trace_point_emit_string(in) \
 do { \
-	RTE_SET_USED(in); \
 	__rte_trace_point_emit_field(__RTE_TRACE_EMIT_STRING_LEN_MAX, \
 		RTE_STR(in)"[32]", "string_bounded_t"); \
 } while (0)
 
 #define rte_trace_point_emit_blob(in, len) \
 do { \
-	RTE_SET_USED(in); \
-	RTE_SET_USED(len); \
 	__rte_trace_point_emit_field(sizeof(uint8_t), \
 		RTE_STR(in) "_" RTE_STR(len), \
 		RTE_STR(uint8_t)); \
-- 
2.48.1

