Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE25C02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:33:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 161D1427D2;
	Fri,  7 Feb 2025 09:33:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6C899427D0
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:33:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738917203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBFBEZJvH/OgKecf6MzEcifa4KGlXCGGvggMt1JfA5E=;
 b=FpHuvKpQ5YZqAE5FAc6X7YuHPV6HYBgb+yOCXOg8eqEvzM11wiewRjNwcCgvxst6STKty7
 GgMV0yinRD9UMTF6fM2tMzuO9WJDOj8w8XinTD6nRQGeFY7Phx7OZ/71XfzPPdTyK717DP
 FKUSqMm66kHuUsGpBRGNXyfqshHYpaE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-ktYTBCOkM5WL3pwQVSLKUw-1; Fri,
 07 Feb 2025 03:33:19 -0500
X-MC-Unique: ktYTBCOkM5WL3pwQVSLKUw-1
X-Mimecast-MFC-AGG-ID: ktYTBCOkM5WL3pwQVSLKUw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 517951801A0D; Fri,  7 Feb 2025 08:33:18 +0000 (UTC)
Received: from dmarchan.com (unknown [10.45.224.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE4F41800876; Fri,  7 Feb 2025 08:33:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, John Daley <johndale@cisco.com>,
 Hyong Youb Kim <hyonkim@cisco.com>
Subject: [RFC 04/10] net/enic: remove weak symbols
Date: Fri,  7 Feb 2025 09:32:44 +0100
Message-ID: <20250207083252.3131588-5-david.marchand@redhat.com>
In-Reply-To: <20250207083252.3131588-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0h_rtKC1vGeBObthXmYwbe5wUffd1OcotNuvcPVOKxw_1738917198
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
 drivers/net/enic/enic_main.c | 8 +++-----
 drivers/net/enic/meson.build | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
index b755b15d92..5ee2ae555d 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -509,15 +509,13 @@ static void enic_prep_wq_for_simple_tx(struct enic *enic, uint16_t queue_idx)
 	}
 }
 
-/*
- * The 'strong' version is in enic_rxtx_vec_avx2.c. This weak version is used
- * used when that file is not compiled.
- */
-__rte_weak bool
+#ifndef ENIC_RXTX_VEC
+bool
 enic_use_vector_rx_handler(__rte_unused struct rte_eth_dev *eth_dev)
 {
 	return false;
 }
+#endif /* ENIC_RXTX_VEC */
 
 void enic_pick_rx_handler(struct rte_eth_dev *eth_dev)
 {
diff --git a/drivers/net/enic/meson.build b/drivers/net/enic/meson.build
index 00f8348348..1e26338350 100644
--- a/drivers/net/enic/meson.build
+++ b/drivers/net/enic/meson.build
@@ -33,6 +33,7 @@ includes += include_directories('base')
 # may not. This is to support users who build for the min supported machine
 # and need to run the binary on newer CPUs too.
 if dpdk_conf.has('RTE_ARCH_X86_64')
+    cflags += '-DENIC_RXTX_VEC'
     enic_avx2_lib = static_library('enic_avx2_lib',
             'enic_rxtx_vec_avx2.c',
             dependencies: [static_rte_ethdev, static_rte_bus_pci],
-- 
2.48.1

