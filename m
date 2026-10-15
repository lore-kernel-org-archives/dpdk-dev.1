Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2104CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:29:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08FEA40689;
	Thu, 15 Oct 2026 13:29:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D7158402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICppBdhS9MYViEjEGUu5pDM1HU2Hcuv8/7AdrvabLRo=;
 b=dkCai0lh+QoLwGc1+6u0tyXp0WPmwcJOJh/AJOfJkMnFZR+/s5jnvgQwyWbrRWetveRD5W
 89L/i8cxyckDUI4cM85qlCi8CaBgR599St8l14i90Dn+9LQwlsA7b/SO9ZxqEVj83VLAAR
 v/W0c5/B3qjL7bcNCQ50Ay5Ifo6htQs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-NDyh3V6wMFSI8d1M8Ml4mw-1; Thu,
 15 Oct 2026 11:29:26 +0000
X-MC-Unique: NDyh3V6wMFSI8d1M8Ml4mw-1
X-Mimecast-MFC-AGG-ID: NDyh3V6wMFSI8d1M8Ml4mw_1792063765
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D7E41955F0C; Thu, 15 Oct 2026 11:29:25 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D5F2195608A; Thu, 15 Oct 2026 11:29:23 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, anatoly.burakov@intel.com
Subject: [PATCH v2 2/3] eal: simplify internal/experimental tags definitions
Date: Thu, 15 Oct 2026 13:29:15 +0200
Message-ID: <20261015112916.2622825-2-david.marchand@redhat.com>
In-Reply-To: <20261015112916.2622825-1-david.marchand@redhat.com>
References: <20261014201627.571496-1-thomas@monjalon.net>
 <20261015112916.2622825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nryr12utBc3n1y5WQaMViHJVAHmpuc8_1wwzRf03alY_1792063765
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

The tags definitions have become hard to read after adding support for
various compilers.

Let's reorder the definitions:
- put MSVC first, as it offers neither the section attribute nor helps
  with detecting wrong use of symbols,
- then for each tag
  - start with error/diagnostic tweaks for the respective !ALLOW cases,
  - if no tweak is available, and for the ALLOW cases, fallback to
    moving the symbol to a section,

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/include/rte_compat.h | 39 +++++++++++++++---------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/lib/eal/include/rte_compat.h b/lib/eal/include/rte_compat.h
index 97c1540bd0..cb7836a190 100644
--- a/lib/eal/include/rte_compat.h
+++ b/lib/eal/include/rte_compat.h
@@ -6,64 +6,57 @@
 #ifndef _RTE_COMPAT_H_
 #define _RTE_COMPAT_H_
 
-#ifndef ALLOW_EXPERIMENTAL_API
-
 #ifdef RTE_TOOLCHAIN_MSVC
+
 #define __rte_experimental
-#else
+#define __rte_internal
+
+#else /* !RTE_TOOLCHAIN_MSVC */
+
+#ifndef ALLOW_EXPERIMENTAL_API
+
 #define __rte_experimental \
 __attribute__((deprecated("Symbol is not yet part of stable ABI"), \
 section(".text.experimental")))
-#endif
 
-#else
+#endif /* !ALLOW_EXPERIMENTAL_API */
 
-#ifdef RTE_TOOLCHAIN_MSVC
-#define __rte_experimental
-#else
+#ifndef __rte_experimental
 #define __rte_experimental \
 __attribute__((section(".text.experimental")))
 #endif
 
-#endif
+#ifndef ALLOW_INTERNAL_API
 
 #ifndef __has_attribute
 /* if no has_attribute assume no support for attribute too */
 #define __has_attribute(x) 0
 #endif
 
-#if !defined ALLOW_INTERNAL_API && __has_attribute(error) /* For GCC */
+#if __has_attribute(error) /* For GCC */
 
-#ifdef RTE_TOOLCHAIN_MSVC
-#define __rte_internal
-#else
 #define __rte_internal \
 __attribute__((error("Symbol is not public ABI"), \
 section(".text.internal")))
-#endif
 
-#elif !defined ALLOW_INTERNAL_API && __has_attribute(diagnose_if) /* For clang */
+#elif __has_attribute(diagnose_if) /* For clang */
 
-#ifdef RTE_TOOLCHAIN_MSVC
-#define __rte_internal
-#else
 #define __rte_internal \
 _Pragma("GCC diagnostic push") \
 _Pragma("GCC diagnostic ignored \"-Wgcc-compat\"") \
 __attribute__((diagnose_if(1, "Symbol is not public ABI", "error"), \
 section(".text.internal"))) \
 _Pragma("GCC diagnostic pop")
+
 #endif
 
-#else
+#endif /* !ALLOW_INTERNAL_API */
 
-#ifdef RTE_TOOLCHAIN_MSVC
-#define __rte_internal
-#else
+#ifndef __rte_internal
 #define __rte_internal \
 __attribute__((section(".text.internal")))
 #endif
 
-#endif
+#endif /* !RTE_TOOLCHAIN_MSVC */
 
 #endif /* _RTE_COMPAT_H_ */
-- 
2.54.0

