Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB03CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 06:46:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 168B040A79;
	Wed,  1 Oct 2025 08:46:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8028B40A67
 for <dev@dpdk.org>; Wed,  1 Oct 2025 08:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759301168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=waqnPtFNEAm495YzWtQSqHnActNg7sA3Ix5/gll7E/0=;
 b=TR1+LZx6mCA08NPrFm7JQ3UoyAdHLzFA4xlMa5n8O8A891Tjc78lngpTBhk7qF/9sHMYo3
 M8boRvBt4gWlPgnGR9qlvA9umqdWmcmrENSfN5UAsPS23yGpkGKMjbYUR+jhn9n/P2EfRA
 HiGSJZJ0qT34JECaWHR0EUmt3j/z0es=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-beMG67I8O1G1h6xjxNHw1w-1; Wed,
 01 Oct 2025 02:46:04 -0400
X-MC-Unique: beMG67I8O1G1h6xjxNHw1w-1
X-Mimecast-MFC-AGG-ID: beMG67I8O1G1h6xjxNHw1w_1759301163
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58E3D195604F; Wed,  1 Oct 2025 06:46:03 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 704E8180035E; Wed,  1 Oct 2025 06:46:00 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v7 6/9] eal/arm: fix C++ build for 32-bit memcpy
Date: Wed,  1 Oct 2025 08:45:08 +0200
Message-ID: <20251001064512.2539269-7-david.marchand@redhat.com>
In-Reply-To: <20251001064512.2539269-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20251001064512.2539269-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pwc7azpTJ8w4uKDm8kSM7zwR8lS8WmH5RePwXxsGNU8_1759301163
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

