Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F926D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 10:22:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEA6D40261;
	Mon,  1 Dec 2025 11:22:17 +0100 (CET)
Received: from out-cbk.mail.syseleven.net (out-cbk.mail.syseleven.net
 [195.192.142.27])
 by mails.dpdk.org (Postfix) with ESMTP id E0B844013F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 11:22:15 +0100 (CET)
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-cbk.mail.syseleven.net (Postfix) with ESMTPSA id 3A67E3F149;
 Mon,  1 Dec 2025 10:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1764584535;
 bh=yk9M4RwrLyK4owlGwjleWWbKMaGh+t4zRM/1sciNP94=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rDGL3fu5gToLlqZub10s0lHZFGQD8jZUXc3JZoNn6o8SzmbnUpe8quY9TZAQHjUvm
 QwOZonXioOodGgeuBz137hFPwADg2e64Evvvo54kGtN9ZnH7juPGUO52mgFtF9/nVX
 rJCA85YCEbJbgM966wMMGyys62ZwohQVqZE+SNq8ldzJaGXqpqZ/4YCYsZ+EhwPPjp
 nmnj5fHT4MmD7DrCTTNzR91quwf6W/iXGbpiadoxUu4UEqTR0w9gm9uJreIChE3vIQ
 9EZVIBdcqh+wvhvybSe/nt4BgKv1gcNJ37isSOYFZDG2JGFAMww9EoIyIe0TzL0CtJ
 k0ycxi073qw7Q==
From: a.schollmeyer@syseleven.de
To: Aman Singh <aman.deep.singh@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Subject: [PATCH v3] app/testpmd: fail on shared rxq switch mismatch
Date: Mon,  1 Dec 2025 11:22:11 +0100
Message-Id: <20251201102211.490071-1-a.schollmeyer@syseleven.de>
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
physical NIC and may cause packets not to be read by the application,
depending on how the data path is implemented.

To help with debugging issues with shared Rx queue configuration when
using testpmd, this commit introduces simple checks and error messages
for members of a share_group and share_qid to fail whenever there is a
mismatch in the switch and Rx domain.

Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
---
v3 changes:

  * make switch/rx domain mismatch an error with shared Rx queues
  * shorten error message
  * move error message outside of the loops
  * update commit message to reflect warning -> failure

v2 changes:

  * remove unnecessary casts
  * refactor message printing logic to remove duplicate fprintf()

 app/test-pmd/testpmd.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 1fe41d852a..6464a97b9b 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2675,6 +2675,47 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	uint32_t prev_hdrs = 0;
 	int ret;
 
+	if (rx_conf->share_group > 0) {
+		/* Check required switch info for Rx queue sharing */
+
+		const uint16_t dom_id = ports[port_id].dev_info.switch_info.domain_id;
+		const uint16_t rx_dom = ports[port_id].dev_info.switch_info.rx_domain;
+
+		uint16_t pid;
+		const char *mismatch = NULL;
+		uint16_t mismatch_pid = (uint16_t)RTE_PORT_ALL;
+		RTE_ETH_FOREACH_DEV(pid) {
+			struct rte_port *o_port = &ports[pid];
+			const uint16_t o_dom_id = o_port->dev_info.switch_info.domain_id;
+			const uint16_t o_rx_dom = o_port->dev_info.switch_info.rx_domain;
+
+			for (uint16_t q = 0; q < nb_rxq; ++q) {
+				struct port_rxqueue *rxq = &o_port->rxq[q];
+				if (rxq->conf.share_group != rx_conf->share_group ||
+						rxq->conf.share_qid != rx_conf->share_qid)
+					continue;
+				if (o_dom_id == dom_id && o_rx_dom == rx_dom)
+					continue;
+
+				if (o_dom_id != dom_id)
+					mismatch = "switch domain";
+				else if (o_rx_dom != rx_dom)
+					mismatch = "rx domain";
+
+				mismatch_pid = pid;
+				break;
+			}
+		}
+
+		if (mismatch) {
+			fprintf(stderr,
+				"Invalid shared rxq config: %s mismatch between ports %u and %u\n",
+				mismatch,
+				port_id,
+				mismatch_pid);
+			return -EINVAL;
+		}
+	}
 
 	if ((rx_pkt_nb_segs > 1) &&
 	    (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
-- 
2.34.1

