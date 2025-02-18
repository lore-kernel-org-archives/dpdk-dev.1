Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521E3C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B5304066E;
	Tue, 18 Feb 2025 16:38:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A9AF64064F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 16:38:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739893097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FuzAbAj3xrho+o9JWJsa6Xujg//N8sEDGfrgfR/fBhQ=;
 b=DWz5AFrIeJF3VUs06qOFoIX03Nooa8Sq80u3DIUgxLm+8XHY4J6VoaBb2mvc3W1C4y3bu5
 IQp0a+2EYDm0X8e94tVIma9YpUcZnjl4rtgzVbNKvN2C2ip4t9fjxKob4aj6XmAiaaGy7+
 zlEOqa+cpOElN4HK4GoQ4f56oIDBZxg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-wmqtjV2pNCWI1b3w5UpPrA-1; Tue,
 18 Feb 2025 10:38:14 -0500
X-MC-Unique: wmqtjV2pNCWI1b3w5UpPrA-1
X-Mimecast-MFC-AGG-ID: wmqtjV2pNCWI1b3w5UpPrA_1739893092
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D14121903096; Tue, 18 Feb 2025 15:38:11 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.171])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D98B71800352; Tue, 18 Feb 2025 15:38:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v3 07/10] net/nfp: remove weak symbols
Date: Tue, 18 Feb 2025 16:37:21 +0100
Message-ID: <20250218153730.773836-8-david.marchand@redhat.com>
In-Reply-To: <20250218153730.773836-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250218153730.773836-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JUH4xXuYNrkv_uYJ9DPldFt3iedS5joccF_cGJl8pdA_1739893092
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

