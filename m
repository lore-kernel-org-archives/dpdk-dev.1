Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D702CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:29:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAFD1406B6;
	Thu, 15 Oct 2026 13:29:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C09F8402F2
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmpueLm+gGltxWBMMFzVkewhcAQx9Mffks3zX1+Ov78=;
 b=JAdey9eXzjE67rfjCro5J3fUCL4OGPpvePua569/5a6SJ/ggYdeu5XHZQFB3zDBqmyW4xZ
 XdiSGlkL154vrkp8yca4LAWTIQaaedZ6erMIp2lbT7EtO1ar1eA76tH8UC4z6t0sMV1l3D
 HYnk43qA0MnpIPa//kCz8M1IG9D2Z1w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-Ufzi7_kEP7SDeLWOmMMyAg-1; Thu,
 15 Oct 2026 11:29:31 +0000
X-MC-Unique: Ufzi7_kEP7SDeLWOmMMyAg-1
X-Mimecast-MFC-AGG-ID: Ufzi7_kEP7SDeLWOmMMyAg_1792063770
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B33F180065E; Thu, 15 Oct 2026 11:29:29 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 053EE7D5; Thu, 15 Oct 2026 11:29:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, anatoly.burakov@intel.com,
 stable@dpdk.org
Subject: [PATCH v2 3/3] eal: enforce internal API check with Clang 14
Date: Thu, 15 Oct 2026 13:29:16 +0200
Message-ID: <20261015112916.2622825-3-david.marchand@redhat.com>
In-Reply-To: <20261015112916.2622825-1-david.marchand@redhat.com>
References: <20261014201627.571496-1-thomas@monjalon.net>
 <20261015112916.2622825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Uh2F6UtcBC6iaFKnGjC6WJJz22mnHVVyXvsgocrTE4_1792063770
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

From: Thomas Monjalon <thomas@monjalon.net>

The __rte_internal macro is intended to prevent calls
to internal API functions unless ALLOW_INTERNAL_API is defined.
Unfortunately the check misses some calls to internal API
when built with GCC or Clang.
Clang can be better to diagnose such cases.

Clang 14 and later support the error attribute
and therefore select it instead of diagnose_if for __rte_internal.
Unlike diagnose_if, the error attribute only rejects
internal API calls that remain after optimization.
Internal API calls can therefore go easily unnoticed,
making internal API checks less strict with recent Clang.

Prefer diagnose_if when available to keep strong Clang diagnostics.
Retain the error attribute as a fallback for GCC.

Fixes: 4ab63cd60ceb ("eal: fix internal ABI tag with clang")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/include/rte_compat.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/eal/include/rte_compat.h b/lib/eal/include/rte_compat.h
index cb7836a190..89c3465245 100644
--- a/lib/eal/include/rte_compat.h
+++ b/lib/eal/include/rte_compat.h
@@ -33,13 +33,7 @@ __attribute__((section(".text.experimental")))
 #define __has_attribute(x) 0
 #endif
 
-#if __has_attribute(error) /* For GCC */
-
-#define __rte_internal \
-__attribute__((error("Symbol is not public ABI"), \
-section(".text.internal")))
-
-#elif __has_attribute(diagnose_if) /* For clang */
+#if __has_attribute(diagnose_if) /* For Clang */
 
 #define __rte_internal \
 _Pragma("GCC diagnostic push") \
@@ -48,6 +42,12 @@ __attribute__((diagnose_if(1, "Symbol is not public ABI", "error"), \
 section(".text.internal"))) \
 _Pragma("GCC diagnostic pop")
 
+#elif __has_attribute(error) /* For GCC */
+
+#define __rte_internal \
+__attribute__((error("Symbol is not public ABI"), \
+section(".text.internal")))
+
 #endif
 
 #endif /* !ALLOW_INTERNAL_API */
-- 
2.54.0

