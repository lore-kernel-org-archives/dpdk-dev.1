Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC42606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaspersky.com header.i=@kaspersky.com header.a=rsa-sha256 header.s=mail202505 header.b=Ej5qDotn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83B15402E2;
	Tue, 24 Nov 2026 11:39:39 +0100 (CET)
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
 by mails.dpdk.org (Postfix) with ESMTPS id 7B1B54027A;
 Tue, 24 Nov 2026 11:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1795516778;
 bh=41kT8ZOk8fCs/LrU3K1oUrpyGjgLzJR1m6+XT6MzWXU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=Ej5qDotnOG2Z0WcqFqKydI+u0MgfzRD6S2DK/D0QWcniy89b1B1Qm2IpG0ScavjWG
 Ik3uB1fOluENCdvEoAhgJlNf1VKbXszQvEeVnSx8l6yePN2x1dEtG65Rd2HEc+gpL2
 /doo4unJMgKW31dk7W2gSw4xjHxfpoov2A54p44leZJOfWYMxy/PVBjIWy23RqV+jG
 32tnlE+MqAcEwDkO+fVpEoT3HTycaYeVRduH6tnu6bUIqy3ZNr1wsg2+eaV92UMiai
 BrX4oSkm/r1vMCWQ0L8fmtWOFbv1tAzv8iYhFKmiwj/kRdmCSNrJt+y/tE/z1JjcBH
 +Ai2mDKHHNmMQ==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
 by relay16.kaspersky-labs.com (Postfix) with ESMTP id 39489C07333;
 Tue, 24 Nov 2026 13:39:38 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id B36B8C07385;
 Tue, 24 Nov 2026 13:39:37 +0300 (MSK)
Received: from kotkov-o.avp.ru (10.16.105.25) by HQMAILSRV4.avp.ru
 (10.64.57.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 13:39:36 +0300
From: Oleg Kotkov <Oleg.Kotkov@kaspersky.com>
To: <jingjing.wu@intel.com>, <praveen.shetty@intel.com>
CC: <dev@dpdk.org>, Oleg Kotkov <Oleg.Kotkov@kaspersky.com>, <stable@dpdk.org>
Subject: [PATCH] net/idpf: fix Rx queue dereference before null check
Date: Tue, 24 Nov 2026 13:38:16 +0300
Message-ID: <20261124103816.427756-1-Oleg.Kotkov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV1.avp.ru (10.64.57.51) To HQMAILSRV4.avp.ru
 (10.64.57.54)
X-KSE-ServerInfo: HQMAILSRV4.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/24/2026 10:24:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 207774 [Nov 24 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: Oleg.Kotkov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 135 0.3.135
 58dcfca10e9e4d27990d8f7387f1467d65061802
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kotkov-o.avp.ru:7.1.1,5.0.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; kaspersky.com:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions_lk}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/24/2026 10:27:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/24/2026 9:35:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.1.0.9599,
 bases: 2026/11/24 06:41:00 #28967674
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The scalar Rx burst functions read queue fields before checking
whether the queue pointer is null.

Move the queue-dependent initializations after existing blocks.

The issue was found by static analysis with Svace.

Fixes: 268d82e5f3e5 ("net/idpf: support timestamp offload")
Fixes: 13145ac41fe1 ("net/idpf: support single queue scatter Rx")
Fixes: f02f6afea14f ("net/idpf: support scattered Rx for split Rx queues")
Cc: stable@dpdk.org

Signed-off-by: Oleg Kotkov <Oleg.Kotkov@kaspersky.com>
---
 .mailmap                                  |  1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c | 40 ++++++++++++++---------
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/.mailmap b/.mailmap
index a0096fb97a..040257c033 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1261,6 +1261,7 @@ Ofer Dagan <ofer.d@claroty.com>
 Ognjen Joldzic <ognjen.joldzic@gmail.com>
 Ola Liljedahl <ola.liljedahl@arm.com>
 Oleg Akhrem <oleg.akhrem@intel.com>
+Oleg Kotkov <Oleg.Kotkov@kaspersky.com>
 Oleg Polyakov <olegp123@walla.co.il>
 Oleksandr Kolomeiets <okl-plv@napatech.com>
 Oleksandr Nahnybida <oleksandrn@interfacemasters.com>
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index eb29024547..b9fe5ca952 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -659,12 +659,12 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	volatile struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc_ring;
 	volatile struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;
 	uint16_t pktlen_gen_bufq_id;
-	struct idpf_rx_queue *rxq = rx_queue;
+	struct idpf_rx_queue *rxq;
 	const uint32_t *ptype_tbl;
 	uint8_t status_err0_qw1;
 	struct idpf_adapter *ad;
-	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
-	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
+	struct rte_mbuf *first_seg;
+	struct rte_mbuf *last_seg;
 	struct rte_mbuf *rxm;
 	uint16_t rx_id_bufq1;
 	uint16_t rx_id_bufq2;
@@ -678,11 +678,13 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 	nb_rx = 0;
 	rxq = rx_queue;
-	ad = rxq->adapter;
 
 	if (unlikely(rxq == NULL) || unlikely(!rxq->q_started))
 		return nb_rx;
 
+	ad = rxq->adapter;
+	first_seg = rxq->pkt_first_seg;
+	last_seg = rxq->pkt_last_seg;
 	rx_id = rxq->rx_tail;
 	rx_id_bufq1 = rxq->bufq1->rx_next_avail;
 	rx_id_bufq2 = rxq->bufq2->rx_next_avail;
@@ -1189,11 +1191,10 @@ idpf_dp_singleq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	nb_hold = 0;
 	rxq = rx_queue;
 
-	ad = rxq->adapter;
-
 	if (unlikely(rxq == NULL) || unlikely(!rxq->q_started))
 		return nb_rx;
 
+	ad = rxq->adapter;
 	rx_id = rxq->rx_tail;
 	rx_ring = rxq->rx_ring;
 	ptype_tbl = rxq->adapter->ptype_tbl;
@@ -1293,30 +1294,39 @@ uint16_t
 idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			       uint16_t nb_pkts)
 {
-	struct idpf_rx_queue *rxq = rx_queue;
-	volatile union virtchnl2_rx_desc *rx_ring = rxq->rx_ring;
+	struct idpf_rx_queue *rxq;
+	volatile union virtchnl2_rx_desc *rx_ring;
 	volatile union virtchnl2_rx_desc *rxdp;
 	union virtchnl2_rx_desc rxd;
 	struct idpf_adapter *ad;
-	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
-	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
+	struct rte_mbuf *first_seg;
+	struct rte_mbuf *last_seg;
 	struct rte_mbuf *rxm;
 	struct rte_mbuf *nmb;
-	const uint32_t *ptype_tbl = rxq->adapter->ptype_tbl;
-	uint16_t rx_id = rxq->rx_tail;
+	const uint32_t *ptype_tbl;
+	uint16_t rx_id;
 	uint16_t rx_packet_len;
-	uint16_t nb_hold = 0;
+	uint16_t nb_hold;
 	uint16_t rx_status0;
-	uint16_t nb_rx = 0;
+	uint16_t nb_rx;
 	uint64_t pkt_flags;
 	uint64_t dma_addr;
 	uint64_t ts_ns;
 
-	ad = rxq->adapter;
+	nb_rx = 0;
+	nb_hold = 0;
+	rxq = rx_queue;
 
 	if (unlikely(!rxq) || unlikely(!rxq->q_started))
 		return nb_rx;
 
+	rx_ring = rxq->rx_ring;
+	ad = rxq->adapter;
+	first_seg = rxq->pkt_first_seg;
+	last_seg = rxq->pkt_last_seg;
+	ptype_tbl = rxq->adapter->ptype_tbl;
+	rx_id = rxq->rx_tail;
+
 	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0)
 		rxq->hw_register_set = 1;
 
-- 
2.43.0

