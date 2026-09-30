Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF212CA5FC1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 08:49:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9722C40A76;
	Wed, 30 Sep 2026 10:49:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E74B140278
 for <dev@dpdk.org>; Wed, 30 Sep 2026 10:49:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790758158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vLE2t10Lu1NI9DIheXG0hk5xuhRpB6lq9d/gK5G99dU=;
 b=A00+qlZMgrc0bNccmfqIa9Ou4BeLPFS5r6dL7HNbyBQ3joiXVojVfYy9DWuFX5vZoDZnMO
 0iS8xeuRuEk13eMKRc/ZR4YoedJqg5iJxRgZQS9AkXE2wVhECO0lRLlTnrLnzkcUQ4htjv
 x9jCZWdmyp9Fyao3VXF0KZnsZEkDvVE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-JUWe6KdSOhGJm6CQYmzdiA-1; Wed,
 30 Sep 2026 04:49:15 -0400
X-MC-Unique: JUWe6KdSOhGJm6CQYmzdiA-1
X-Mimecast-MFC-AGG-ID: JUWe6KdSOhGJm6CQYmzdiA_1790758153
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E83F1954B28; Wed, 30 Sep 2026 08:49:13 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73D21195604D; Wed, 30 Sep 2026 08:49:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH] hash: fix GFNI helpers for building with -O0
Date: Wed, 30 Sep 2026 10:49:08 +0200
Message-ID: <20260930084908.72055-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9SrEfrB5aTOpuc8tr7MdtUbXm23lwZ1w0yNgBfU1yYs_1790758153
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

Similarly to commit da31ef54c865 ("hash: fix GFNI stubs export"),
fix "internal" helpers used by public inline helpers by removing the
incorrect __rte_internal annotation.

The issue is usually not seen as those helpers get inlined under
standard compiler optimization level, but it becomes visible when
building with -O0.

Fixes: 4fd8c4cb0de1 ("hash: add new Toeplitz hash implementation")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/hash/rte_thash_x86_gfni.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/hash/rte_thash_x86_gfni.h b/lib/hash/rte_thash_x86_gfni.h
index 69973503fd..e5abdf2474 100644
--- a/lib/hash/rte_thash_x86_gfni.h
+++ b/lib/hash/rte_thash_x86_gfni.h
@@ -13,7 +13,6 @@
  */
 
 #include <rte_bitops.h>
-#include <rte_compat.h>
 #include <rte_vect.h>
 
 #ifdef __cplusplus
@@ -29,7 +28,6 @@ extern "C" {
 #define RTE_THASH_PERM_MSK_2		0xf0f0f0f0f0f0f0f0
 #define RTE_THASH_REWIND_MSK		0x0000000000113377
 
-__rte_internal
 static inline void
 __rte_thash_xor_reduce(__m512i xor_acc, uint32_t *val_1, uint32_t *val_2)
 {
@@ -64,7 +62,6 @@ __rte_thash_xor_reduce(__m512i xor_acc, uint32_t *val_1, uint32_t *val_2)
 #endif
 }
 
-__rte_internal
 static inline __m512i
 __rte_thash_gfni(const uint64_t *mtrx, const uint8_t *tuple,
 	const uint8_t *secondary_tuple, int len)
-- 
2.54.0

