Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2F9CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 12:42:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8DA1406BB;
	Fri, 26 Sep 2025 14:42:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 575D84025D
 for <dev@dpdk.org>; Fri, 26 Sep 2025 14:42:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758890522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ga8NyTprxvmklqe8gkL+jc+kQeLzdYw88OdZESA39Zg=;
 b=gibsYyOuw2ZEWAmYit/Q3D8oDKkThHUMTYe6b3gfTRdNPtCmA+01nI4KTjMeX+6HSKRqgF
 2ZUlW4DZGgF6/VHdPm+fBQJdxAfOfjQVQAF2dLHuOujIsWYX/zBMoJpizk9PSxA/1Nnp7A
 jmfKLVeDKKXBXM8M6eH5iXVQhwDv2yE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-v21wT4aOM665oXF14jQfvw-1; Fri,
 26 Sep 2025 08:41:59 -0400
X-MC-Unique: v21wT4aOM665oXF14jQfvw-1
X-Mimecast-MFC-AGG-ID: v21wT4aOM665oXF14jQfvw_1758890517
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A94D619560AA; Fri, 26 Sep 2025 12:41:56 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0489C19560AB; Fri, 26 Sep 2025 12:41:53 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v5 6/9] eal/arm: fix C++ build for 32-bit memcpy
Date: Fri, 26 Sep 2025 14:40:59 +0200
Message-ID: <20250926124103.750844-7-david.marchand@redhat.com>
In-Reply-To: <20250926124103.750844-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EUBifKJ4S1t6mUqM8cnSkzhWfN7g-zj1hFZfDmVs25o_1758890517
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

