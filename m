Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14554C02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03609427DE;
	Fri,  7 Feb 2025 09:33:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 19D2A427C8
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:33:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738917215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1a/c5V3rC6pgqbnBf0794Ia5qR/AJEFM7kzeTOpTDw=;
 b=O5L/+BX0RgtkdZbDuttJOh7KFEO8WsCe8bHAFjSTgNKUkS79CncKS6/mRBArXvfkmEC4mo
 l1sUMBf4jsI+AcoCc8siHA3Yu42OS7DryxLH6NzZrS0bzi05B7gXSC5WzAy/SDOfpCja/1
 OTd/2+0Wqbu9x5XuAUv65pE/GwQE0rc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-FzKFPPXBPFGN_muQC2Jzjg-1; Fri,
 07 Feb 2025 03:33:34 -0500
X-MC-Unique: FzKFPPXBPFGN_muQC2Jzjg-1
X-Mimecast-MFC-AGG-ID: FzKFPPXBPFGN_muQC2Jzjg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD7E81955D82; Fri,  7 Feb 2025 08:33:32 +0000 (UTC)
Received: from dmarchan.com (unknown [10.45.224.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D07B230001AB; Fri,  7 Feb 2025 08:33:30 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Chaoyong He <chaoyong.he@corigine.com>
Subject: [RFC 07/10] net/nfp: remove weak symbols
Date: Fri,  7 Feb 2025 09:32:47 +0100
Message-ID: <20250207083252.3131588-8-david.marchand@redhat.com>
In-Reply-To: <20250207083252.3131588-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 23GF5y1Y5_y3VOP7kOU2tTAVT5iB-qN9LF43ZYd5Sqg_1738917212
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

