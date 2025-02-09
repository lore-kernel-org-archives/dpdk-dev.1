Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D0DC0219B
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 17:30:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CB2D40B9A;
	Sun,  9 Feb 2025 18:29:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A09884065C
 for <dev@dpdk.org>; Sun,  9 Feb 2025 18:29:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739122188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7lOD+GaQPpHum54VnppMl+N76TfdSxFYPMO4xIo70g=;
 b=OoNTHdjH/YnHWBLssn4s3dYge2Zu5u27aAdYt7bobjwK+/TEuorbhxJTLWQJkp3Zzk05E1
 hjBEwhx2kRzPVW44hERBIS5+1hwR/0wuHXl6a8eEcPbk9zXIXVasy0MzIA3aoyW1DLSnuT
 hKdopPbm1k9k04+zLRBaO6VPjR96TZI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-Q0hIWgSrNeKuBHyXFZIy6A-1; Sun,
 09 Feb 2025 12:29:46 -0500
X-MC-Unique: Q0hIWgSrNeKuBHyXFZIy6A-1
X-Mimecast-MFC-AGG-ID: Q0hIWgSrNeKuBHyXFZIy6A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF7811956086; Sun,  9 Feb 2025 17:29:45 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 622FC195608D; Sun,  9 Feb 2025 17:29:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC v2 10/10] eal: deprecate weak symbols
Date: Sun,  9 Feb 2025 18:28:48 +0100
Message-ID: <20250209172850.2429075-11-david.marchand@redhat.com>
In-Reply-To: <20250209172850.2429075-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250209172850.2429075-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JTg8RwLW3134l8JNZxHWXoshtDfwLsxKVUx4hskgITI_1739122185
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

Mark __rte_weak as deprecated.
It will avoid having to support such feature with other linkers,
plus this was never really needed.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/rel_notes/release_25_03.rst | 2 ++
 lib/eal/include/rte_common.h           | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 2b139fc35b..3426bfee0e 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -154,6 +154,8 @@ API Changes
 * eal: The ``__rte_packed`` macro for packing data is replaced with
   ``__rte_packed_begin`` / ``__rte_packed_end``.
 
+* eal: The ``__rte_weak`` macro is deprecated and will be removed in a future release.
+
 * build: The Intel networking drivers:
   cpfl, e1000, fm10k, i40e, iavf, ice, idpf, igc, ipn3ke and ixgbe,
   have been moved from ``drivers/net`` to a new ``drivers/net/intel`` directory.
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 7a252c1997..2e0ee9dc7e 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -181,7 +181,11 @@ typedef uint16_t unaligned_uint16_t;
 /**
  * Mark a function or variable to a weak reference.
  */
-#define __rte_weak __attribute__((__weak__))
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __rte_weak RTE_DEPRECATED(__rte_weak)
+#else
+#define __rte_weak RTE_DEPRECATED(__rte_weak) __attribute__((__weak__))
+#endif
 
 /**
  * Mark a function to be pure.
-- 
2.48.1

