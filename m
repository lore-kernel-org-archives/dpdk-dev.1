Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E9D1037B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 10:40:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF6B640695;
	Wed, 26 Nov 2025 11:40:33 +0100 (CET)
Received: from out-dbl.mail.syseleven.net (out-dbl.mail.syseleven.net
 [195.192.142.195])
 by mails.dpdk.org (Postfix) with ESMTP id B63D84042F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 11:40:32 +0100 (CET)
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-dbl.mail.syseleven.net (Postfix) with ESMTPSA id 535CA1F81A4;
 Wed, 26 Nov 2025 11:40:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1764153631;
 bh=n0PAyoQsDX3mflDfv00TkAoc/EVuC2NGYmiMo3HdZTc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UcOxh3nav3Mz0UWpiL8/JHNv0EZL3/9XKHJrRjw3SUdzeAvI13FFxAnUSUAg16lRd
 n4Fka5WdblUCjGo/JTZqUB9l5x6NHYyBfnCMV7lC2mPBnXvAjBbJPO8OVtg6y/YbrZ
 X9aEm4Nsm7wb5tIifiP6F5JE/avk/Ej5Cq+biL1VhFK6p6x9gNoBDtVNwFW+cIAUAH
 ldMjtkV4g+wvXJ/OuIaMoC97tksSW4Yd1ZkmwVsKuGzDJ52rWcti3vp6n8vbqYY4pE
 K5kuDprROsJv6bxzsWfTc1d+3nFHOIo0Wr5MlMffdKbewf0ntJJ7LsOPZKaNE/6tId
 h8MgmkLKJvLDA==
From: a.schollmeyer@syseleven.de
To: Aman Singh <aman.deep.singh@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Subject: [PATCH v2] app/testpmd: warn on shared rxq switch mismatch
Date: Wed, 26 Nov 2025 11:40:09 +0100
Message-Id: <20251126104009.472852-1-a.schollmeyer@syseleven.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
References: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
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

To help with debugging issues with shared Rx queue configuration when
using testpmd, this commit introduces simple checks and warning messages
for all members of a share_group and share_qid to warn whenever there is
a mismatch in the switch and Rx domain.

Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
---
v2 changes:

  * remove unnecessary casts
  * refactor message printing logic to remove duplicate fprintf()

 app/test-pmd/testpmd.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 1fe41d852a..33b99756f7 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2675,6 +2675,52 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
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
+				const char *mismatch = NULL;
+				uint16_t this_val = 0;
+				uint16_t other_val = 0;
+
+				if (o_dom_id != dom_id) {
+					mismatch = "switch domain";
+					this_val = dom_id;
+					other_val = o_dom_id;
+				} else if (o_rx_dom != rx_dom) {
+					mismatch = "rx domain";
+					this_val = rx_dom;
+					other_val = o_rx_dom;
+				}
+
+				if (mismatch) {
+					fprintf(stderr, "Bad shared rxq config: "
+						"%s mismatch in share group/qid %u/%u: "
+						"%u (port %u) vs. %u (port %u)\n",
+						mismatch,
+						rxq->conf.share_group,
+						rxq->conf.share_qid,
+						this_val,
+						port_id,
+						other_val,
+						pid);
+				}
+			}
+		}
+	}
 
 	if ((rx_pkt_nb_segs > 1) &&
 	    (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
-- 
2.34.1

