Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8835606A336
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=ow7z3XjX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE5AA40E22;
	Fri, 30 Oct 2026 15:48:22 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTPS id CDA4F40289
 for <dev@dpdk.org>; Fri, 30 Oct 2026 15:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=ZsM5VMl8CXUyFCChramO84Yc/IisSUB7hv0vGfKyQY4=;
 b=ow7z3XjXbZn3hl7gnu/Sve6rp3Q0Omqw+XHHQQ8NWkRLQEYaGfrCROpj2bXgHk
 MY2I6D4dG84GZkwIN7AEyTBG68buOrXiygwr7lt+dzS2GNK7JG41ZXfEoP1+phTv
 ScHVP4y551LLWla67Ltwoo1VuECUWHRQ18j28A61BXwFE=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 26/28] net/hinic3: add SP230 VF software statistics
Date: Fri, 30 Oct 2026 22:47:30 +0800
Message-ID: <20261030144733.2120-27-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S28
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWUJr43XFWUJrWDuFWruFg_yoW8tw4DpF
 yDGa43Ar9rXF4kJwnxK3yUZ345Gws3Z34UG3Z7JayY9Fs8Xr1Yy345trWjyrn8G3y3Za17
 Zws0kFs8C3yjgwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut5rxUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNx+GkGrkrh9bkwAA3J
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

The SP230 VF does not expose rx/tx counters through the vport statistics
path, so aggregate the software queue counters instead to return meaningful
ipackets/ibytes/opackets/obytes for VF ports.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 64797cc2a2..11f2ca6da6 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2958,13 +2958,16 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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
@@ -2985,6 +2988,12 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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
@@ -2995,8 +3004,16 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

