Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C4CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:11:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65D6440E2F;
	Wed, 14 Oct 2026 17:10:09 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id A15E940A72
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=NGnHJ7MKjxtZWER3pGKA7mdFgULbzWx0QeROwVuNJIs=;
 b=mM/h+TXaQ4V+qehztsLkvgtdMv0AXws0qZdKHOFLiaZJEXZgpPnlXVXxc70ixR
 DM1dllZlmqvuZrMOoM/rhLUMdzc9Dse5q8TcHB3TJn5AjiwFe3jbILA+a7RrulrM
 Jlo0dP5iLdn36U+IPlsq657AedBJrFSeTgNJ62WeZqX5s=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 22/26] net/hinic3: add SP230 VF software statistics
Date: Wed, 14 Oct 2026 23:09:18 +0800
Message-ID: <20261014150923.838-23-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S24
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWUJr43XFWUJrWDKFyUZFb_yoW8GF1rpF
 yDGa45AFyxXFsrJwnxGa48Aw15Ca93X347KFyxJay5uF45AFyYy34rKrWjvrn8KFWfA3W2
 vanrC3yqkrWjgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJUUbUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMx2EjmrPmz0eRQAA38
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

The SP230 VF does not expose rx/tx counters through the vport statistics
path, so aggregate the software queue counters instead to return meaningful
ipackets/ibytes/opackets/obytes for VF ports.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index b2f1d618c0..ea2a5c55ca 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2954,6 +2954,26 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		}
 	}
 
+	if (HINIC3_IS_VF(nic_dev->hwdev) && HINIC3_IS_SP230_NIC(nic_dev)) {
+		for (uint32_t i = 0; i < nic_dev->num_rqs; i++) {
+			struct hinic3_rxq *rxq = nic_dev->rxqs[i];
+			if (rxq == NULL)
+				continue;
+			stats->ipackets += rxq->rxq_stats.packets;
+			stats->ibytes += rxq->rxq_stats.bytes;
+			stats->imissed += rxq->rxq_stats.dropped;
+		}
+
+		for (uint32_t i = 0; i < nic_dev->num_sqs; i++) {
+			struct hinic3_txq *txq = nic_dev->txqs[i];
+			if (txq == NULL)
+				continue;
+			stats->opackets += txq->txq_stats.packets;
+			stats->obytes += txq->txq_stats.bytes;
+		}
+		return 0;
+	}
+
 	/* Vport stats. */
 	stats->oerrors += vport_stats.tx_discard_vport;
 
-- 
2.33.0

