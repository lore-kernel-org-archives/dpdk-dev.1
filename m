Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BF8C02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:33:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50880427D9;
	Fri,  7 Feb 2025 09:33:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 44C05427B4
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:33:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738917208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEqUYqAEDS0poNjENzHYO490C5lbSZieeEsx4ftJfq4=;
 b=MQMPI0A9m3VsZEeNoIka8tgiEcvj/eE6GxsUzK6Jgq0JI3I61dxQMcxnUpslk2Bq400aFA
 dRyn2UQF8WG8Yzt+4gJX+krPEZ3DoeSOVjKYsDKy0pU3HBvOAbXcLZPGpk1JUdlStEFaao
 YJgCcBk8UQ+KZ4wXuGAo0vs3lfrUleM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-F-mIATgqNtSDGak1aoGNnA-1; Fri,
 07 Feb 2025 03:33:24 -0500
X-MC-Unique: F-mIATgqNtSDGak1aoGNnA-1
X-Mimecast-MFC-AGG-ID: F-mIATgqNtSDGak1aoGNnA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F37A1956086; Fri,  7 Feb 2025 08:33:23 +0000 (UTC)
Received: from dmarchan.com (unknown [10.45.224.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D5271800358; Fri,  7 Feb 2025 08:33:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Jie Hai <haijie1@huawei.com>
Subject: [RFC 05/10] net/hns3: remove weak symbols
Date: Fri,  7 Feb 2025 09:32:45 +0100
Message-ID: <20250207083252.3131588-6-david.marchand@redhat.com>
In-Reply-To: <20250207083252.3131588-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LEmg4kMat2ZuNwuha6QxSagTiiLmZZH_zJNMVJ9p5D8_1738917203
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
 drivers/net/hns3/hns3_rxtx.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index 09e39cb673..0b42b9826e 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -2787,18 +2787,19 @@ hns3_recv_scattered_pkts(void *rx_queue,
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
@@ -2806,13 +2807,16 @@ hns3_recv_pkts_vec(__rte_unused void *rx_queue,
 	return 0;
 }
 
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
+#endif /* RTE_ARCH_ARM64 */
 
 int
 hns3_rx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
@@ -4256,13 +4260,14 @@ hns3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
@@ -4270,13 +4275,16 @@ hns3_xmit_pkts_vec(__rte_unused void *tx_queue,
 	return 0;
 }
 
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
+#endif /* RTE_ARCH_ARM64 */
 
 int
 hns3_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
-- 
2.48.1

