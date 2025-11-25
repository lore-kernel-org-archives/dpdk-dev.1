Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD2CFD377
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 10:23:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BB8240A73;
	Tue, 25 Nov 2025 11:23:42 +0100 (CET)
Received: from out-ham1.mail.syseleven.net (out-ham1.mail.syseleven.net
 [151.252.42.30]) by mails.dpdk.org (Postfix) with ESMTP id B5BC9402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 11:23:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1764066219;
 bh=geGhdieUGttn9tA6Pt9ZYBI/gdZm1tWzm1mXZ6/kP5k=;
 h=From:To:Cc:Subject:Date:From;
 b=SN4oLyKHf8lEDC+pH5SjX3LbZF5QFaO5xM4C5HOkggyHDLzssAbTMS7EQnd+N0uz9
 5bQOuTjCSy0ouRHeYfc2gfN78/IMdTl9NFUJk8trFnRo+tTHP52vTUgQRh97hpgGI2
 eaxd1y+UVqURcp/J00pOjjkP7FCpBa6NLTbKW5rvuMf6KMfYTW+jmT6X7dGnHRvd42
 UGP6uVWBiSS+n5Lnr17vjkSskfaR+A+BuNHAHY2RI3EtHaPK1V20e6MJiqwSrvYxPD
 SNuJGhiVarbk7O+FAQ9+eOSj30OX5KywoydeIzqKc8LsnGQ9KM1ZKvlnXu23YmY4Rz
 rkF/v9+RfPG9g==
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-ham1.mail.syseleven.net (Postfix) with ESMTPSA id A3A1346E94;
 Tue, 25 Nov 2025 11:23:39 +0100 (CET)
From: a.schollmeyer@syseleven.de
To: Aman Singh <aman.deep.singh@intel.com>
Cc: dev@dpdk.org,
	Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Subject: [PATCH] app/testpmd: warn on shared rxq switch mismatch
Date: Tue, 25 Nov 2025 11:22:07 +0100
Message-Id: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>

Shared Rx queues do not work with every combination of ports. Besides
requiring the corresponding device capability, shared Rx queues also
require all ports of one share group and queue ID have the same switch
domain and Rx domain. When these fields do not match, shared Rx queues
are not properly set up and queue sharing may fail silently. This can
happen even in some less intuitive cases like multiple VFs of one
physical NIC.

To make debugging issues with shared Rx queue configuration easier, this
commit introduces simple checks and warning messages for all members of
a share_group and share_qid to warn whenever there is a mismatch in the
switch and Rx domain.

Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
---
 app/test-pmd/testpmd.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 1fe41d852a..6e42930730 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2675,6 +2675,48 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	uint32_t prev_hdrs = 0;
 	int ret;
 
+	if (rx_conf->share_group > 0) {
+		/* Additional warnings for bad Rx queue sharing */
+
+		const uint16_t dom_id = ports[port_id].dev_info.switch_info.domain_id;
+		const uint16_t rx_dom = ports[port_id].dev_info.switch_info.rx_domain;
+
+		uint16_t pid;
+		RTE_ETH_FOREACH_DEV(pid) {
+			struct rte_port *o_port = &ports[pid];
+			for (uint16_t q = 0; q < nb_rxq; ++q) {
+				struct port_rxqueue *rxq = &o_port->rxq[q];
+				if (rxq->conf.share_group != rx_conf->share_group ||
+						rxq->conf.share_qid != rx_conf->share_qid)
+					continue;
+
+				const uint16_t o_dom_id = o_port->dev_info.switch_info.domain_id;
+				const uint16_t o_rx_dom = o_port->dev_info.switch_info.rx_domain;
+
+				if (o_dom_id != dom_id) {
+					fprintf(stderr, "Bad shared rxq config: "
+						"switch domain mismatch in share group/qid %u/%u: "
+						"%u (port %u) vs. %u (port %u)\n",
+						(unsigned int)rxq->conf.share_group,
+						(unsigned int)rxq->conf.share_qid,
+						(unsigned int)dom_id,
+						(unsigned int)port_id,
+						(unsigned int)o_dom_id,
+						(unsigned int)pid);
+				} else if (o_rx_dom != rx_dom) {
+					fprintf(stderr, "Bad shared rxq config: "
+						"switch rx domain mismatch in share group/qid %u/%u: "
+						"%u (port %u) vs. %u (port %u)\n",
+						(unsigned int)rxq->conf.share_group,
+						(unsigned int)rxq->conf.share_qid,
+						(unsigned int)rx_dom,
+						(unsigned int)port_id,
+						(unsigned int)o_rx_dom,
+						(unsigned int)pid);
+				}
+			}
+		}
+	}
 
 	if ((rx_pkt_nb_segs > 1) &&
 	    (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
-- 
2.34.1

