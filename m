Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10B5C282D6
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 16:07:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82C5640395;
	Tue,  4 Mar 2025 17:07:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1F10C402E8
 for <dev@dpdk.org>; Tue,  4 Mar 2025 17:07:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741104425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TU/m9rDpdqBkjJJTwbxDx7/Li8oMqB7em7zl4pdQWvk=;
 b=ObOqQpxJp5li/9UghToFjjXWY11uF8lvgat2bUoIjde6lHXPE/tp+BFV8Hq/4jUS9Bt7DB
 Y8WP3iJiHiAUHfYKj2YSqSBN7wVcsuBtT7gxY2niZeCXUKbF1yQI9GOg2IRdVK9cAgjJ7j
 83In3j2ev3AIZ6kdFnCU9NEReoK5GP4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-NlZaJzP7MTeEt_kCqInohg-1; Tue,
 04 Mar 2025 11:06:57 -0500
X-MC-Unique: NlZaJzP7MTeEt_kCqInohg-1
X-Mimecast-MFC-AGG-ID: NlZaJzP7MTeEt_kCqInohg_1741104415
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4D361800879; Tue,  4 Mar 2025 16:06:54 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15C66180035F; Tue,  4 Mar 2025 16:06:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v4 3/5] trace: support dereferencing pointers
Date: Tue,  4 Mar 2025 17:06:31 +0100
Message-ID: <20250304160633.385185-4-david.marchand@redhat.com>
In-Reply-To: <20250304160633.385185-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250304160633.385185-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bcPNdSp1IzRCEm7b8fQnrmlpAx3vihJOI1VYcTg3_tQ_1741104415
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

Rather than use an intermediate variable, add new helpers that handle
dereferencing pointers.
Update dmadev traces accordingly (and adjust the emitter type).

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v3:
- started from scratch with different approach, added new helpers
  to avoid touching ctf metadata,

Changes since v2:
- split this change out of patch 2, as it required updating CTF metadata
  fixup,

---
 lib/dmadev/rte_dmadev_trace_fp.h           | 12 ++---
 lib/eal/include/rte_trace_point.h          | 52 ++++++++++++++--------
 lib/eal/include/rte_trace_point_register.h |  9 ++--
 3 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/lib/dmadev/rte_dmadev_trace_fp.h b/lib/dmadev/rte_dmadev_trace_fp.h
index f5b96838bc..f2656c6726 100644
--- a/lib/dmadev/rte_dmadev_trace_fp.h
+++ b/lib/dmadev/rte_dmadev_trace_fp.h
@@ -37,10 +37,9 @@ RTE_TRACE_POINT_FP(
 	enum rte_dma_vchan_status __status = 0;
 	status = &__status;
 #endif /* _RTE_TRACE_POINT_REGISTER_H_ */
-	int vchan_status = *status;
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
-	rte_trace_point_emit_int(vchan_status);
+	rte_trace_point_emit_int_ptr(status);
 	rte_trace_point_emit_int(ret);
 )
 
@@ -107,13 +106,11 @@ RTE_TRACE_POINT_FP(
 	last_idx = &__last_idx;
 	has_error = &__has_error;
 #endif /* _RTE_TRACE_POINT_REGISTER_H_ */
-	int has_error_val = *has_error;
-	int last_idx_val = *last_idx;
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
 	rte_trace_point_emit_u16(nb_cpls);
-	rte_trace_point_emit_int(last_idx_val);
-	rte_trace_point_emit_int(has_error_val);
+	rte_trace_point_emit_u16_ptr(last_idx);
+	rte_trace_point_emit_u8_ptr(has_error);
 	rte_trace_point_emit_u16(ret);
 )
 
@@ -126,11 +123,10 @@ RTE_TRACE_POINT_FP(
 	uint16_t __last_idx = 0;
 	last_idx = &__last_idx;
 #endif /* _RTE_TRACE_POINT_REGISTER_H_ */
-	int last_idx_val = *last_idx;
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
 	rte_trace_point_emit_u16(nb_cpls);
-	rte_trace_point_emit_int(last_idx_val);
+	rte_trace_point_emit_u16_ptr(last_idx);
 	rte_trace_point_emit_ptr(status);
 	rte_trace_point_emit_u16(ret);
 )
diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index b24db3b6da..0780460759 100644
--- a/lib/eal/include/rte_trace_point.h
+++ b/lib/eal/include/rte_trace_point.h
@@ -376,10 +376,10 @@ do { \
 		return; \
 	__rte_trace_point_emit_header_generic(t)
 
-#define __rte_trace_point_emit(in, type) \
+#define __rte_trace_point_emit(name, in, type) \
 do { \
-	memcpy(mem, &(in), sizeof(in)); \
-	mem = RTE_PTR_ADD(mem, sizeof(in)); \
+	memcpy(mem, in, sizeof(*in)); \
+	mem = RTE_PTR_ADD(mem, sizeof(*in)); \
 } while (0)
 
 #define rte_trace_point_emit_string(in) \
@@ -396,7 +396,7 @@ do { \
 		return; \
 	if (len > RTE_TRACE_BLOB_LEN_MAX) \
 		len = RTE_TRACE_BLOB_LEN_MAX; \
-	__rte_trace_point_emit(len, uint8_t); \
+	__rte_trace_point_emit(RTE_STR(len), &len, uint8_t); \
 	memcpy(mem, in, len); \
 	memset(RTE_PTR_ADD(mem, len), 0, RTE_TRACE_BLOB_LEN_MAX - len); \
 	mem = RTE_PTR_ADD(mem, RTE_TRACE_BLOB_LEN_MAX); \
@@ -406,7 +406,7 @@ do { \
 
 #define __rte_trace_point_emit_header_generic(t) RTE_SET_USED(t)
 #define __rte_trace_point_emit_header_fp(t) RTE_SET_USED(t)
-#define __rte_trace_point_emit(in, type) RTE_SET_USED(in)
+#define __rte_trace_point_emit(name, in, type) RTE_SET_USED(in)
 #define rte_trace_point_emit_string(in) RTE_SET_USED(in)
 #define rte_trace_point_emit_blob(in, len) \
 do { \
@@ -418,20 +418,34 @@ do { \
 #endif /* ALLOW_EXPERIMENTAL_API */
 #endif /* _RTE_TRACE_POINT_REGISTER_H_ */
 
-#define rte_trace_point_emit_u64(in) __rte_trace_point_emit(in, uint64_t)
-#define rte_trace_point_emit_i64(in) __rte_trace_point_emit(in, int64_t)
-#define rte_trace_point_emit_u32(in) __rte_trace_point_emit(in, uint32_t)
-#define rte_trace_point_emit_i32(in) __rte_trace_point_emit(in, int32_t)
-#define rte_trace_point_emit_u16(in) __rte_trace_point_emit(in, uint16_t)
-#define rte_trace_point_emit_i16(in) __rte_trace_point_emit(in, int16_t)
-#define rte_trace_point_emit_u8(in) __rte_trace_point_emit(in, uint8_t)
-#define rte_trace_point_emit_i8(in) __rte_trace_point_emit(in, int8_t)
-#define rte_trace_point_emit_int(in) __rte_trace_point_emit(in, int32_t)
-#define rte_trace_point_emit_long(in) __rte_trace_point_emit(in, long)
-#define rte_trace_point_emit_size_t(in) __rte_trace_point_emit(in, size_t)
-#define rte_trace_point_emit_float(in) __rte_trace_point_emit(in, float)
-#define rte_trace_point_emit_double(in) __rte_trace_point_emit(in, double)
-#define rte_trace_point_emit_ptr(in) __rte_trace_point_emit(in, uintptr_t)
+#define rte_trace_point_emit_u64(in) __rte_trace_point_emit(RTE_STR(in), &in, uint64_t)
+#define rte_trace_point_emit_i64(in) __rte_trace_point_emit(RTE_STR(in), &in, int64_t)
+#define rte_trace_point_emit_u32(in) __rte_trace_point_emit(RTE_STR(in), &in, uint32_t)
+#define rte_trace_point_emit_i32(in) __rte_trace_point_emit(RTE_STR(in), &in, int32_t)
+#define rte_trace_point_emit_u16(in) __rte_trace_point_emit(RTE_STR(in), &in, uint16_t)
+#define rte_trace_point_emit_i16(in) __rte_trace_point_emit(RTE_STR(in), &in, int16_t)
+#define rte_trace_point_emit_u8(in) __rte_trace_point_emit(RTE_STR(in), &in, uint8_t)
+#define rte_trace_point_emit_i8(in) __rte_trace_point_emit(RTE_STR(in), &in, int8_t)
+#define rte_trace_point_emit_int(in) __rte_trace_point_emit(RTE_STR(in), &in, int32_t)
+#define rte_trace_point_emit_long(in) __rte_trace_point_emit(RTE_STR(in), &in, long)
+#define rte_trace_point_emit_size_t(in) __rte_trace_point_emit(RTE_STR(in), &in, size_t)
+#define rte_trace_point_emit_float(in) __rte_trace_point_emit(RTE_STR(in), &in, float)
+#define rte_trace_point_emit_double(in) __rte_trace_point_emit(RTE_STR(in), &in, double)
+#define rte_trace_point_emit_ptr(in) __rte_trace_point_emit(RTE_STR(in), &in, uintptr_t)
+
+#define rte_trace_point_emit_u64_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, uint64_t)
+#define rte_trace_point_emit_i64_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, int64_t)
+#define rte_trace_point_emit_u32_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, uint32_t)
+#define rte_trace_point_emit_i32_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, int32_t)
+#define rte_trace_point_emit_u16_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, uint16_t)
+#define rte_trace_point_emit_i16_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, int16_t)
+#define rte_trace_point_emit_u8_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, uint8_t)
+#define rte_trace_point_emit_i8_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, int8_t)
+#define rte_trace_point_emit_int_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, int32_t)
+#define rte_trace_point_emit_long_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, long)
+#define rte_trace_point_emit_size_t_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, size_t)
+#define rte_trace_point_emit_float_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, float)
+#define rte_trace_point_emit_double_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, double)
 
 #endif /* __DOXYGEN__ */
 
diff --git a/lib/eal/include/rte_trace_point_register.h b/lib/eal/include/rte_trace_point_register.h
index 748c931830..ff861c1fba 100644
--- a/lib/eal/include/rte_trace_point_register.h
+++ b/lib/eal/include/rte_trace_point_register.h
@@ -35,11 +35,10 @@ RTE_INIT(trace##_init) \
 #define __rte_trace_point_emit_header_fp(t) \
 	__rte_trace_point_emit_header_generic(t)
 
-#define __rte_trace_point_emit(in, type) \
+#define __rte_trace_point_emit(name, in, type) \
 do { \
-	RTE_BUILD_BUG_ON(sizeof(type) != sizeof(typeof(in))); \
-	__rte_trace_point_emit_field(sizeof(type), RTE_STR(in), \
-		RTE_STR(type)); \
+	RTE_BUILD_BUG_ON(sizeof(type) != sizeof(typeof(*in))); \
+	__rte_trace_point_emit_field(sizeof(type), name, RTE_STR(type)); \
 } while (0)
 
 #define rte_trace_point_emit_string(in) \
@@ -52,7 +51,7 @@ do { \
 #define rte_trace_point_emit_blob(in, len) \
 do { \
 	RTE_SET_USED(in); \
-	__rte_trace_point_emit(len, uint8_t); \
+	__rte_trace_point_emit(RTE_STR(len), &len, uint8_t); \
 	__rte_trace_point_emit_field(RTE_TRACE_BLOB_LEN_MAX, \
 		RTE_STR(in)"[" RTE_STR(RTE_TRACE_BLOB_LEN_MAX)"]", \
 		RTE_STR(uint8_t)); \
-- 
2.48.1

