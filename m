Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D06BC021A1
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 17:29:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05CAD40B8C;
	Sun,  9 Feb 2025 18:29:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1473340A7A
 for <dev@dpdk.org>; Sun,  9 Feb 2025 18:29:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739122174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FuzAbAj3xrho+o9JWJsa6Xujg//N8sEDGfrgfR/fBhQ=;
 b=KtZAFJx+qGZzE5izyZOP7a6cvSAUhbkKeMKR6YwTu2FRrIBfKnNpqB421VkVtB5WAqbrJd
 ML3nYio2XQUZrzGLVUiH2UfkJh81SdYQt5pIViiWwW6T8H6oHI0pcWFNn9IbvyOJjTMIsH
 8Ud+TTgT0DnNiYfOpLtn5E8OqRYWovE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-tMimyZSeNmW1TmVjPfzcug-1; Sun,
 09 Feb 2025 12:29:32 -0500
X-MC-Unique: tMimyZSeNmW1TmVjPfzcug-1
X-Mimecast-MFC-AGG-ID: tMimyZSeNmW1TmVjPfzcug
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C065519560A0; Sun,  9 Feb 2025 17:29:30 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A52511800352; Sun,  9 Feb 2025 17:29:28 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Chaoyong He <chaoyong.he@corigine.com>
Subject: [RFC v2 07/10] net/nfp: remove weak symbols
Date: Sun,  9 Feb 2025 18:28:45 +0100
Message-ID: <20250209172850.2429075-8-david.marchand@redhat.com>
In-Reply-To: <20250209172850.2429075-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250209172850.2429075-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NV7uXk8pHi5lw99-hXCi1z3ZBf4tDTX8kED5fixDSwA_1739122170
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

Rather than use weak symbols, link stubs code when needed.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Chaoyong He <chaoyong.he@corigine.com>
---
 drivers/net/nfp/meson.build              | 7 +++++--
 drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c | 2 +-
 drivers/net/nfp/nfp_rxtx_vec_stub.c      | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/nfp/meson.build b/drivers/net/nfp/meson.build
index 4052846dc2..39762bd45a 100644
--- a/drivers/net/nfp/meson.build
+++ b/drivers/net/nfp/meson.build
@@ -17,7 +17,6 @@ sources = files(
         'flower/nfp_flower_service.c',
         'nfd3/nfp_nfd3_dp.c',
         'nfdk/nfp_nfdk_dp.c',
-        'nfdk/nfp_nfdk_vec_stub.c',
         'nfpcore/nfp_cppcore.c',
         'nfpcore/nfp_crc.c',
         'nfpcore/nfp_elf.c',
@@ -45,7 +44,6 @@ sources = files(
         'nfp_net_flow.c',
         'nfp_net_meta.c',
         'nfp_rxtx.c',
-        'nfp_rxtx_vec_stub.c',
         'nfp_service.c',
 )
 
@@ -67,6 +65,11 @@ if arch_subdir == 'x86'
         )
 
         objs += nfp_avx2_lib.extract_all_objects(recursive: true)
+else
+        sources += files(
+                'nfp_rxtx_vec_stub.c',
+                'nfdk/nfp_nfdk_vec_stub.c',
+        )
 endif
 
 deps += ['hash', 'security', 'common_nfp']
diff --git a/drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c b/drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c
index 146ec21d51..4f905bce6b 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c
+++ b/drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c
@@ -5,7 +5,7 @@
 
 #include "nfp_nfdk_vec.h"
 
-uint16_t __rte_weak
+uint16_t
 nfp_net_nfdk_vec_avx2_xmit_pkts(__rte_unused void *tx_queue,
 		__rte_unused struct rte_mbuf **tx_pkts,
 		__rte_unused uint16_t nb_pkts)
diff --git a/drivers/net/nfp/nfp_rxtx_vec_stub.c b/drivers/net/nfp/nfp_rxtx_vec_stub.c
index c480f61ef0..201965afbe 100644
--- a/drivers/net/nfp/nfp_rxtx_vec_stub.c
+++ b/drivers/net/nfp/nfp_rxtx_vec_stub.c
@@ -10,13 +10,13 @@
 
 #include "nfp_rxtx_vec.h"
 
-bool __rte_weak
+bool
 nfp_net_get_avx2_supported(void)
 {
 	return false;
 }
 
-uint16_t __rte_weak
+uint16_t
 nfp_net_vec_avx2_recv_pkts(__rte_unused void *rx_queue,
 		__rte_unused struct rte_mbuf **rx_pkts,
 		__rte_unused uint16_t nb_pkts)
-- 
2.48.1

