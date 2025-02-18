Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D31C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:38:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 918AD4060F;
	Tue, 18 Feb 2025 16:38:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A89DF4060F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 16:38:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739893109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GSFGyl3rKH+F7VB8lWsYbEHt5RIZ62mdEQFMlCx61w=;
 b=dP1w3LSAWOXCWnnyhWBZohsuFeekscEk9QLYifapUqkOvO/sa/UEfob0Mz9gSrydJfP3G7
 ESTFfLXoPh0QmI6cQaItAoRmaK5kPY77mqbrWV8pTeviYkd8ehJ3WB58NfLSEoGUKo1rMj
 VwpZNxXKH/2oNGaFO/42dRkriXcMbi4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-1D42PqRhPNyEB5dCTaX6Eg-1; Tue,
 18 Feb 2025 10:38:28 -0500
X-MC-Unique: 1D42PqRhPNyEB5dCTaX6Eg-1
X-Mimecast-MFC-AGG-ID: 1D42PqRhPNyEB5dCTaX6Eg_1739893107
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2A6F1800268; Tue, 18 Feb 2025 15:38:26 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.171])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF6D619560AB; Tue, 18 Feb 2025 15:38:24 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 10/10] eal: deprecate weak symbols
Date: Tue, 18 Feb 2025 16:37:24 +0100
Message-ID: <20250218153730.773836-11-david.marchand@redhat.com>
In-Reply-To: <20250218153730.773836-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250218153730.773836-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L-BtYk1ueGL0Nei80s_IDBb9Bczc_Ja4OXnHUOyryrQ_1739893107
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
index ca67c17c5c..8867a4bd74 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -188,6 +188,8 @@ API Changes
 * eal: The ``__rte_packed`` macro for packing data is replaced with
   ``__rte_packed_begin`` / ``__rte_packed_end``.
 
+* eal: The ``__rte_weak`` macro is deprecated and will be removed in a future release.
+
 * net: Changed the API for CRC calculation to be thread-safe.
   An opaque context argument was introduced to the net CRC API
   containing the algorithm type and length.
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 3f77b7624e..4be65376a5 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -179,7 +179,11 @@ typedef uint16_t unaligned_uint16_t;
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

