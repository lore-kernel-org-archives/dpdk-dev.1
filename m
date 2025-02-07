Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A5CC02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:34:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83FD7427C7;
	Fri,  7 Feb 2025 09:33:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BBDCE427D5
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:33:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738917231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWi87dT+F1rY9eq1BWA6Osh7DSwIWepghWFCnBrv6P4=;
 b=cWQfxvkeW5vdwKQG3uNuX+DSCCNhoG4+eUUYa4T3mhJjjNsUh6t3gVPLTKozlKLY/bpmwT
 AJ06LQIq5U+8XJ8fPMcDKhlvAcVPcVxqlj29q35Y9hrbI7xdJEPNrly3KYLHT9uYjdTb79
 rX4/hea9r0ceXAGysEgCPDE+kxMb8G8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-SUcy5lzLMLayJc4GJvgAYg-1; Fri,
 07 Feb 2025 03:33:48 -0500
X-MC-Unique: SUcy5lzLMLayJc4GJvgAYg-1
X-Mimecast-MFC-AGG-ID: SUcy5lzLMLayJc4GJvgAYg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1633F180087C; Fri,  7 Feb 2025 08:33:47 +0000 (UTC)
Received: from dmarchan.com (unknown [10.45.224.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DA48180087A; Fri,  7 Feb 2025 08:33:44 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC 10/10] eal: deprecate weak symbols
Date: Fri,  7 Feb 2025 09:32:50 +0100
Message-ID: <20250207083252.3131588-11-david.marchand@redhat.com>
In-Reply-To: <20250207083252.3131588-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iJbpLKwPYy08tYfxpmiTMBDsf4wGk-7JtD0-OrtQMdc_1738917227
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
index 269ab6f68a..e9a9abbb13 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -125,6 +125,8 @@ API Changes
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

