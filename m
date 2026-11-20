Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC2606A334
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=oVBA11r5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66E3940685;
	Fri, 20 Nov 2026 17:35:24 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTPS id A6635402DF
 for <dev@dpdk.org>; Fri, 20 Nov 2026 17:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=gMLc7VI/If+sEOavHaiDT82jDhZ4oBxO8HDMkN2ylHA=;
 b=oVBA11r52d1On35VA8PXrQsRR8ztEyWF6wtXEfcKnK26k7c7VqCLGGTaWoS/K6
 VR/ZXxLMzImvgJ9w43yJdx8qufu7rncKObpgTnyW+GvJTe0l+h62xTVhoreohHp6
 4FCxr1+pzAhyK9MoFyGZFkyOSfBxtpgpHSiHVs4Wwi1Ug=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 06/28] net/hinic3: clear stale Rx hardware CI on queue reset
Date: Sat, 21 Nov 2026 00:34:31 +0800
Message-ID: <20261120163454.1159-7-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261120163454.1159-1-yejiacheng4@h-partners.com>
References: <20261117155711.1048-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCHL5q7dgBrCNqsBQ--.46998S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF18Cw45Kr1rGr13Zr13Jwb_yoW8GrW5pF
 WDGFWDAr4kKF42qwsxAa1fZa45Jws5try7Ka95J3WY9r45AFyFya45tFW0vr4UtrZ3JF42
 vF47Jr1vg3Z0v3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtsqAUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNx+nsWsAdr8RUAAA3d
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

Clear the CI write-back memory in hinic3_reset_rx_queue() so the ring is
re-armed with a fresh CI.

Fixes: c1537bf6c033 ("net/hinic3: support Compact CQE in init")

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index eb5ddd9de6..d9821d1c9f 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -884,6 +884,14 @@ hinic3_reset_rx_queue(struct rte_eth_dev *dev)
 		rxq->prod_idx = 0;
 		rxq->delta = rxq->q_depth;
 		rxq->next_to_update = 0;
+
+		/*
+		 * Hardware does not clear the CI write-back memory on reset, so
+		 * the stale hw_ci must be cleared as well, otherwise the driver
+		 * may treat queued mbufs as completed after restart.
+		 */
+		if (rxq->rq_ci != NULL)
+			memset(rxq->rq_ci, 0, sizeof(*rxq->rq_ci));
 	}
 }
 
-- 
2.33.0

