Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB21606A335
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=IGMZ2GvU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C984840E40;
	Mon,  9 Nov 2026 17:21:02 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTPS id 086704028B
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:20:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=uddj2EhdczKOFK3j6mcxrT9Q2O2Afu5QVH95MEk0Sjc=;
 b=IGMZ2GvUmIp7FkM2zIs4KTbRESLYBBk/Rpep8wdh5Cf6rqygiEGpbrz+oHY7wZ
 ur1x7+72MYJR3yLQ4/QFPXRHtGB41WrWPWGQA1t4hOXI0Dr1GpYAbka7RvggQ142
 i4QKdL8aFkvG+j8TFhLkrugLbwaWaZgB5HXy1I6KK0q2g=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 06/28] net/hinic3: clear stale Rx hardware CI on queue reset
Date: Tue, 10 Nov 2026 00:20:10 +0800
Message-ID: <20261109162033.1144-7-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF18Cw45Kr1rGr13Zr13Jwb_yoW8XryfpF
 WUGFWqyr4kKF47tws3Aa1rZa45Xws5JFy7Kas3A3W5ur45AFyrAa45tFW0vr4UJrn7JF42
 vF47tr1vg3Z0v3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtsqAUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNgQNF2rx8uQOhgAA3t
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In compact CQE mode the driver relies on the hardware CI written back by
the NIC to decide whether a completion is pending. The hardware does not
clear that write-back memory on reset, so after a port stop/start the
stale value left by the previous session makes the driver take the whole
ring as completed and report q_depth packets that were never received
when the next packet arrives.

Clear the CI write-back memory in hinic3_reset_rx_queue() and add a
memory fence, so the cleared value is visible before the ring is
re-armed.

Fixes: c1537bf6c033 ("net/hinic3: support Compact CQE in init")

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index eb5ddd9de6..6c09d6e80d 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -884,6 +884,16 @@ hinic3_reset_rx_queue(struct rte_eth_dev *dev)
 		rxq->prod_idx = 0;
 		rxq->delta = rxq->q_depth;
 		rxq->next_to_update = 0;
+
+		/*
+		 * Hardware does not clear the CI write-back memory on reset, so
+		 * the stale hw_ci must be cleared as well, otherwise the driver
+		 * may treat queued mbufs as completed after restart.
+		 */
+		if (rxq->rq_ci != NULL) {
+			memset(rxq->rq_ci, 0, sizeof(*rxq->rq_ci));
+			rte_atomic_thread_fence(rte_memory_order_seq_cst);
+		}
 	}
 }
 
-- 
2.33.0

