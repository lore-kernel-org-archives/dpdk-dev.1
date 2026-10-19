Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ABE609F0C6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=X+DbN3Vt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB79F40E01;
	Mon, 19 Oct 2026 17:20:18 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 58F0640689
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=UEZwglNI9bcdMI8fOBQsU263fJ1t7AoITTBed2tgHDQ=;
 b=X+DbN3VtJ0AECzIIiTOa3AuQuuMWXRmfdQ3QwUd4POd9OVG1IvZd4CLvHhZWGC
 8TWVan4KFKEq6kMDh8SekbRfXoWgdu8LcZX6HTSTK7LKIQYOXJOijxTTj6YLAnHi
 PsZIH172gWj0YePAyahHx/iYmzscvc5Gl25PvNYCFYhf8=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 24/27] net/hinic3: add SP230 VF software statistics
Date: Mon, 19 Oct 2026 23:19:26 +0800
Message-ID: <20261019151930.1572-25-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261019151930.1572-1-yejiacheng4@h-partners.com>
References: <20261014150923.838-1-yejiacheng4@h-partners.com>
 <20261019151930.1572-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCXK5cUNdZqqgUkBA--.15723S26
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWUJr43XFWUJrWDuFWruFg_yoW8tw4DpF
 yDGa43Ar9rXF4kXwnxKayUAa45Gws3Z3yUGas7JayYkF4DXr1Yy34UKrWjyrn8G3y3Za17
 Zws0kFs8C3yjgwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut5rxUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQKlr2rWNSLSfQAA35
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SP230 VF does not expose rx/tx counters through the vport statistics
path, so aggregate the software queue counters instead to return meaningful
ipackets/ibytes/opackets/obytes for VF ports.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 32218fa0f6..05382bc6db 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2922,13 +2922,16 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	struct hinic3_vport_stats vport_stats;
 	uint64_t rx_discards_pmd = 0;
+	bool sw_stats = HINIC3_IS_VF(nic_dev->hwdev) && HINIC3_IS_SP230_NIC(nic_dev);
 	int err;
 
-	err = hinic3_get_vport_stats(nic_dev->hwdev, &vport_stats);
-	if (err) {
-		PMD_DRV_LOG(ERR, "Get vport stats from fw failed, nic_dev: %s",
-			    nic_dev->dev_name);
-		return err;
+	if (!sw_stats) {
+		err = hinic3_get_vport_stats(nic_dev->hwdev, &vport_stats);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Get vport stats from fw failed, nic_dev: %s",
+				    nic_dev->dev_name);
+			return err;
+		}
 	}
 
 	/* Rx queue stats. */
@@ -2949,6 +2952,12 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		stats->ierrors += rxq->rxq_stats.errors;
 		rx_discards_pmd += rxq->rxq_stats.dropped;
 		dev->data->rx_mbuf_alloc_failed += rxq->rxq_stats.rx_nombuf;
+
+		if (sw_stats) {
+			stats->ipackets += rxq->rxq_stats.packets;
+			stats->ibytes += rxq->rxq_stats.bytes;
+			stats->imissed += rxq->rxq_stats.dropped;
+		}
 	}
 
 	/* Tx queue stats. */
@@ -2959,8 +2968,16 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 			qstats[i].q_opackets = txq->txq_stats.packets;
 			qstats[i].q_obytes = txq->txq_stats.bytes;
 		}
+
+		if (sw_stats) {
+			stats->opackets += txq->txq_stats.packets;
+			stats->obytes += txq->txq_stats.bytes;
+		}
 	}
 
+	if (sw_stats)
+		return 0;
+
 	/* Vport stats. */
 	stats->oerrors += vport_stats.tx_discard_vport;
 
-- 
2.33.0

