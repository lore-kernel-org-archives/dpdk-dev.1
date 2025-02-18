Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89834C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:38:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E9154065F;
	Tue, 18 Feb 2025 16:38:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 478634064F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 16:38:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739893092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2haxSvuaYWcOGuNu7U4vnzEet3HmiKjFNobwjNTlcaE=;
 b=TPHkVexd+Q3qZzXDVKys8P3M6pd4pu4eRX1fYbPIr3/lzqhYrNW0dLDgs+GiXx2NJs0H58
 CQKD8YqHrGOpz8IzL4L4ZMuvXj/bKVghzTnWphmRZK9TQVxTuTQLF17Oimmx2fHT5PcxA2
 /s2trVK9AMwkUrW9gfT9AeYC7OsQpRs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-Qf1cyXtlM2KmZSLd8TENhQ-1; Tue,
 18 Feb 2025 10:38:08 -0500
X-MC-Unique: Qf1cyXtlM2KmZSLd8TENhQ-1
X-Mimecast-MFC-AGG-ID: Qf1cyXtlM2KmZSLd8TENhQ_1739893087
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA04D180056F; Tue, 18 Feb 2025 15:38:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68DF21955BCB; Tue, 18 Feb 2025 15:38:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [PATCH v3 06/10] net/fm10k: remove weak symbols
Date: Tue, 18 Feb 2025 16:37:20 +0100
Message-ID: <20250218153730.773836-7-david.marchand@redhat.com>
In-Reply-To: <20250218153730.773836-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250218153730.773836-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZhvC4MYnqTkYacLjZ9qI9HIoSwDYspVBju9hQexp54Y_1739893087
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/fm10k/fm10k_ethdev.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 747042d621..75ce2e19cf 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -129,14 +129,15 @@ fm10k_mbx_unlock(struct fm10k_hw *hw)
 	rte_spinlock_unlock(FM10K_DEV_PRIVATE_TO_MBXLOCK(hw->back));
 }
 
-/* Stubs needed for linkage when vPMD is disabled */
-__rte_weak int
+#ifndef RTE_ARCH_X86
+/* Stubs for non x86 architectures. */
+int
 fm10k_rx_vec_condition_check(__rte_unused struct rte_eth_dev *dev)
 {
 	return -1;
 }
 
-__rte_weak uint16_t
+uint16_t
 fm10k_recv_pkts_vec(
 	__rte_unused void *rx_queue,
 	__rte_unused struct rte_mbuf **rx_pkts,
@@ -145,7 +146,7 @@ fm10k_recv_pkts_vec(
 	return 0;
 }
 
-__rte_weak uint16_t
+uint16_t
 fm10k_recv_scattered_pkts_vec(
 		__rte_unused void *rx_queue,
 		__rte_unused struct rte_mbuf **rx_pkts,
@@ -154,39 +155,40 @@ fm10k_recv_scattered_pkts_vec(
 	return 0;
 }
 
-__rte_weak int
+int
 fm10k_rxq_vec_setup(__rte_unused struct fm10k_rx_queue *rxq)
 
 {
 	return -1;
 }
 
-__rte_weak void
+void
 fm10k_rx_queue_release_mbufs_vec(
 		__rte_unused struct fm10k_rx_queue *rxq)
 {
 	return;
 }
 
-__rte_weak void
+void
 fm10k_txq_vec_setup(__rte_unused struct fm10k_tx_queue *txq)
 {
 	return;
 }
 
-__rte_weak int
+int
 fm10k_tx_vec_condition_check(__rte_unused struct fm10k_tx_queue *txq)
 {
 	return -1;
 }
 
-__rte_weak uint16_t
+uint16_t
 fm10k_xmit_fixed_burst_vec(__rte_unused void *tx_queue,
 			   __rte_unused struct rte_mbuf **tx_pkts,
 			   __rte_unused uint16_t nb_pkts)
 {
 	return 0;
 }
+#endif /* RTE_ARCH_X86 */
 
 /*
  * reset queue to initial state, allocate software buffers used when starting
-- 
2.48.1

