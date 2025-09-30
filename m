Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F1CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 06:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 941324066C;
	Tue, 30 Sep 2025 08:58:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 753B24066C
 for <dev@dpdk.org>; Tue, 30 Sep 2025 08:58:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759215506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=waqnPtFNEAm495YzWtQSqHnActNg7sA3Ix5/gll7E/0=;
 b=gLqRzNtdlEv9GefOZBX0kwjVBbQZg7o8Tq645ElqZy4YDfCyUHsRlU3t9E3AHyE90YcRCs
 ST7vJv8ujoYl5BsqmQIWkUl05ExANY+pHTUTYW75TnGoFnNDFsLnP55zNyVTB0STl4RvUp
 QBwyYOx5qXzAjFUumgdDtzCeb1D7fU8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-j-PMEBsuOwK4qyYzXop06A-1; Tue,
 30 Sep 2025 02:58:23 -0400
X-MC-Unique: j-PMEBsuOwK4qyYzXop06A-1
X-Mimecast-MFC-AGG-ID: j-PMEBsuOwK4qyYzXop06A_1759215502
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C07B91800447; Tue, 30 Sep 2025 06:58:21 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 868AD180057A; Tue, 30 Sep 2025 06:58:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v6 6/9] eal/arm: fix C++ build for 32-bit memcpy
Date: Tue, 30 Sep 2025 08:57:36 +0200
Message-ID: <20250930065740.1838899-7-david.marchand@redhat.com>
In-Reply-To: <20250930065740.1838899-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250930065740.1838899-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g9v1z0ca_l1gcxAFBG2bI0HKGtI7YQLQxzxa5nrb0pM_1759215502
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

This was caught while checking ARM arch headers.

In file included from buildtools/chkincs/chkincs-cpp.p/rte_memcpy_32.cpp:1:
/home/runner/work/dpdk/dpdk/lib/eal/arm/include/rte_memcpy_32.h:302:1:
	error: expected declaration before ‘}’ token
  302 | }
      | ^

Fixes: 719834a6849e ("use C linkage where appropriate in headers")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/eal/arm/include/rte_memcpy_32.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/arm/include/rte_memcpy_32.h b/lib/eal/arm/include/rte_memcpy_32.h
index 99fd5757ca..861be06f5e 100644
--- a/lib/eal/arm/include/rte_memcpy_32.h
+++ b/lib/eal/arm/include/rte_memcpy_32.h
@@ -19,10 +19,14 @@
 /* ARM NEON Intrinsics are used to copy data */
 #include <arm_neon.h>
 
+#endif /* RTE_ARCH_ARM_NEON_MEMCPY */
+
 #ifdef __cplusplus
 extern "C" {
 #endif
 
+#ifdef RTE_ARCH_ARM_NEON_MEMCPY
+
 static inline void
 rte_mov16(uint8_t *dst, const uint8_t *src)
 {
@@ -252,7 +256,7 @@ rte_memcpy_func(void *dst, const void *src, size_t n)
 	return ret;
 }
 
-#else
+#else /* ! RTE_ARCH_ARM_NEON_MEMCPY */
 
 static inline void
 rte_mov16(uint8_t *dst, const uint8_t *src)
-- 
2.51.0

