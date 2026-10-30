Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4113606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=Jvr++0yb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5721240E3A;
	Fri, 30 Oct 2026 15:48:12 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTPS id 8F7E840285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 15:47:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=xRfAJPQHypo+qwy9qCGwDuqk0kZqcnm2zG26Aw9a8qM=;
 b=Jvr++0ybZBm1Ek6ekXWbF2aLhaA7gzF26ahm5qdUwTpYT2IM8idhIx5xpbTkgy
 hj/KGpJ1L7K2n3t0GVhcMOTe/PTrIYLP+tjw9xRLyfL8tEcH7rYirm9+z8sVvL5M
 21AYMr8a/mgLpJJ03M3eRY05TT6XOla0oBEQK/faZt/Yg=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 06/28] net/hinic3: clear stale Rx hardware CI on queue reset
Date: Fri, 30 Oct 2026 22:47:10 +0800
Message-ID: <20261030144733.2120-7-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF18Cw45Kr1rGr13Zw4DXFb_yoW8Xr47pF
 WDGFWqyr4kKF47tws3Ca1rZa45Xws5GFy7Kas3Aas8ur45AFyrAa45KFW0vr4Utrn7JF42
 vF42yr4vgan0v3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtsqAUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMxeEjmrkrhdTgQAA3L
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
ring as completed and report q_depth spurious packets when the next
packet arrives.

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

