Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D2DC0219B
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 17:29:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A3BF40A80;
	Sun,  9 Feb 2025 18:29:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 39C8040647
 for <dev@dpdk.org>; Sun,  9 Feb 2025 18:29:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739122180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Labvj+3reRIKOL8ZnrJ1W6+3fBeXSM8oHjWD8F65t/4=;
 b=bmSgsSmmHlMfttPmd6neOjHh/Shiu52hC7YtzqUmjkdnXqL0zmGyx0ZQICXoxqb30G8Lmg
 k+WL+SFVzPW+xtoNet09+HthvtkgAwe2diXnZA8ONDwXhHRcl2TzOyuCXZyf2FePEV9Oek
 yAqZICojIx2Ka2CO/Vn7/pyKy5gLatU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-bYjUL_jbOn-DTUMT-2JzrA-1; Sun,
 09 Feb 2025 12:29:37 -0500
X-MC-Unique: bYjUL_jbOn-DTUMT-2JzrA-1
X-Mimecast-MFC-AGG-ID: bYjUL_jbOn-DTUMT-2JzrA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7BD01800877; Sun,  9 Feb 2025 17:29:35 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9823E1800570; Sun,  9 Feb 2025 17:29:33 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [RFC v2 08/10] net/virtio: remove weak symbols
Date: Sun,  9 Feb 2025 18:28:46 +0100
Message-ID: <20250209172850.2429075-9-david.marchand@redhat.com>
In-Reply-To: <20250209172850.2429075-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250209172850.2429075-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GDwE2z2rqOyObV_xanbPMrmJ8tFkzFpDO3TmtavXPVw_1739122175
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

Rather than use weak symbols, expose stubs symbols when needed.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/virtio/meson.build          | 5 +++++
 drivers/net/virtio/virtio_rxtx.c        | 6 ++++--
 drivers/net/virtio/virtio_rxtx_simple.c | 4 +++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
index c708ea5258..56c763e96f 100644
--- a/drivers/net/virtio/meson.build
+++ b/drivers/net/virtio/meson.build
@@ -28,6 +28,7 @@ cflags += no_wvla_cflag
 if arch_subdir == 'x86'
     if cc_has_avx512
         cflags += ['-DCC_AVX512_SUPPORT']
+        cflags += ['-DVIRTIO_RXTX_PACKED_VEC']
         virtio_avx512_lib = static_library('virtio_avx512_lib',
                 'virtio_rxtx_packed.c',
                 dependencies: [static_rte_ethdev,
@@ -43,11 +44,15 @@ if arch_subdir == 'x86'
             cflags += '-DVIRTIO_ICC_UNROLL_PRAGMA'
         endif
     endif
+    cflags += ['-DVIRTIO_RXTX_VEC']
     sources += files('virtio_rxtx_simple_sse.c')
 elif arch_subdir == 'ppc'
+    cflags += ['-DVIRTIO_RXTX_VEC']
     sources += files('virtio_rxtx_simple_altivec.c')
 elif arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
+    cflags += ['-DVIRTIO_RXTX_PACKED_VEC']
     sources += files('virtio_rxtx_packed.c')
+    cflags += ['-DVIRTIO_RXTX_VEC']
     sources += files('virtio_rxtx_simple_neon.c')
 endif
 
diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virtio_rxtx.c
index b67f063b31..2a0d1b6101 100644
--- a/drivers/net/virtio/virtio_rxtx.c
+++ b/drivers/net/virtio/virtio_rxtx.c
@@ -2045,7 +2045,8 @@ virtio_xmit_pkts_inorder(void *tx_queue,
 	return nb_tx;
 }
 
-__rte_weak uint16_t
+#ifndef VIRTIO_RXTX_PACKED_VEC
+uint16_t
 virtio_recv_pkts_packed_vec(void *rx_queue __rte_unused,
 			    struct rte_mbuf **rx_pkts __rte_unused,
 			    uint16_t nb_pkts __rte_unused)
@@ -2053,10 +2054,11 @@ virtio_recv_pkts_packed_vec(void *rx_queue __rte_unused,
 	return 0;
 }
 
-__rte_weak uint16_t
+uint16_t
 virtio_xmit_pkts_packed_vec(void *tx_queue __rte_unused,
 			    struct rte_mbuf **tx_pkts __rte_unused,
 			    uint16_t nb_pkts __rte_unused)
 {
 	return 0;
 }
+#endif /* DVIRTIO_RXTX_PACKED_VEC */
diff --git a/drivers/net/virtio/virtio_rxtx_simple.c b/drivers/net/virtio/virtio_rxtx_simple.c
index 439e00a7e1..aa96c9c488 100644
--- a/drivers/net/virtio/virtio_rxtx_simple.c
+++ b/drivers/net/virtio/virtio_rxtx_simple.c
@@ -43,8 +43,9 @@ virtio_rxq_vec_setup(struct virtnet_rx *rxq)
 	return 0;
 }
 
+#ifndef VIRTIO_RXTX_VEC
 /* Stub for linkage when arch specific implementation is not available */
-__rte_weak uint16_t
+uint16_t
 virtio_recv_pkts_vec(void *rx_queue __rte_unused,
 		     struct rte_mbuf **rx_pkts __rte_unused,
 		     uint16_t nb_pkts __rte_unused)
@@ -52,3 +53,4 @@ virtio_recv_pkts_vec(void *rx_queue __rte_unused,
 	rte_panic("Wrong weak function linked by linker\n");
 	return 0;
 }
+#endif /* VIRTIO_RXTX_VEC */
-- 
2.48.1

