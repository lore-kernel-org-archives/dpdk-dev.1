Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE6CC02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D600540672;
	Tue, 18 Feb 2025 16:38:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 518A640671
 for <dev@dpdk.org>; Tue, 18 Feb 2025 16:38:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739893087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/lFN6zU1iHSKBiAAvyFvzwskN/GD3skHUU4DAU5mRQ=;
 b=IuMSYz0wdoaSRjZCHJ0jw44RvqDiZ9G1xtFPewPHCndIjSSiCIJWAB4UIHTBPnLTj8Q/rQ
 yuNxQk98CXVhqvAEpSaOh4F4pSUy66f2t6ytPkD0d5FMSTtU+xfWv58qV413kD4sMgl4ZX
 uEp0fWPqGrPtaFS3vK6EfH3DRvb3ITQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-ldWXENwpPzGTBv63mLmSpw-1; Tue,
 18 Feb 2025 10:38:02 -0500
X-MC-Unique: ldWXENwpPzGTBv63mLmSpw-1
X-Mimecast-MFC-AGG-ID: ldWXENwpPzGTBv63mLmSpw_1739893081
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FCDD1800982; Tue, 18 Feb 2025 15:38:01 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.171])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AD0A19560AB; Tue, 18 Feb 2025 15:37:59 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Jie Hai <haijie1@huawei.com>
Subject: [PATCH v3 05/10] net/hns3: remove weak symbols
Date: Tue, 18 Feb 2025 16:37:19 +0100
Message-ID: <20250218153730.773836-6-david.marchand@redhat.com>
In-Reply-To: <20250218153730.773836-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250218153730.773836-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n3caSca6--Xu9t0m4mZQg2RBzeTGW1PhZ3xGktfjYjk_1739893081
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
Changes since v1:
- fix build for Arm64 without SVE,

---
 drivers/net/hns3/hns3_rxtx.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index 09e39cb673..bb7ffee12c 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -2787,32 +2787,36 @@ hns3_recv_scattered_pkts(void *rx_queue,
 	return nb_rx;
 }
 
-void __rte_weak
+#ifndef RTE_ARCH_ARM64
+void
 hns3_rxq_vec_setup(__rte_unused struct hns3_rx_queue *rxq)
 {
 }
 
-int __rte_weak
+int
 hns3_rx_check_vec_support(__rte_unused struct rte_eth_dev *dev)
 {
 	return -ENOTSUP;
 }
 
-uint16_t __rte_weak
+uint16_t
 hns3_recv_pkts_vec(__rte_unused void *rx_queue,
 		   __rte_unused struct rte_mbuf **rx_pkts,
 		   __rte_unused uint16_t nb_pkts)
 {
 	return 0;
 }
+#endif /* RTE_ARCH_ARM64 */
 
-uint16_t __rte_weak
+#ifndef RTE_HAS_SVE_ACLE
+uint16_t
 hns3_recv_pkts_vec_sve(__rte_unused void *rx_queue,
 		       __rte_unused struct rte_mbuf **rx_pkts,
 		       __rte_unused uint16_t nb_pkts)
 {
 	return 0;
 }
+#endif /* RTE_HAS_SVE_ACLE */
 
 int
 hns3_rx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
@@ -4256,27 +4260,31 @@ hns3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	return nb_tx;
 }
 
-int __rte_weak
+#ifndef RTE_ARCH_ARM64
+int
 hns3_tx_check_vec_support(__rte_unused struct rte_eth_dev *dev)
 {
 	return -ENOTSUP;
 }
 
-uint16_t __rte_weak
+uint16_t
 hns3_xmit_pkts_vec(__rte_unused void *tx_queue,
 		   __rte_unused struct rte_mbuf **tx_pkts,
 		   __rte_unused uint16_t nb_pkts)
 {
 	return 0;
 }
+#endif /* RTE_ARCH_ARM64 */
 
-uint16_t __rte_weak
+#ifndef RTE_HAS_SVE_ACLE
+uint16_t
 hns3_xmit_pkts_vec_sve(void __rte_unused * tx_queue,
 		       struct rte_mbuf __rte_unused **tx_pkts,
 		       uint16_t __rte_unused nb_pkts)
 {
 	return 0;
 }
+#endif /* RTE_HAS_SVE_ACLE */
 
 int
 hns3_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
-- 
2.48.1

