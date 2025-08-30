Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C496FCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:42:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69DCE40A80;
	Sat, 30 Aug 2025 14:41:09 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id E0FEB406B8
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:41:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=Kpt+HxtPjyqeJXpxsHVDW8FyyrD0Uwi/F7oe6m08Ayo=;
 b=AAUVwzckfEj++EtUuFTiEheraqZE99+fnw67CA/W+5wToXUmRs//5gL7XT1oU4
 n7N+LnE8S3IjkYEZZuDW1QbBXbyVcp25XulOuN9eY+lsxCVzQMuAXSGiqibcn1Ah
 8KmyIQrQrjveXnfB+P/RAA4NgQPQamVAwJGxaxWE8SMzg=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S18;
 Sat, 30 Aug 2025 20:41:03 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>
Subject: [V5 14/18] net/hinic3: add Rx/Tx functions
Date: Sat, 30 Aug 2025 20:39:26 +0800
Message-ID: <20250830123942.5037-15-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S18
X-Coremail-Antispam: 1Uf129KBjvAXoWfCF45Zr1fuw13Cr13CFyUJrb_yoW5urWkto
 WfXr43tr1FvryxCrWj9w4kuFnFqws0vFW5JwnYyF42vF1UAryYga9xGw1Fqa48XrWFk3Wx
 Aa45JwnFy39xJ3y5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUo73vUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAQ65CmiydD3F5AAAsO
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

From: Feifei Wang <wangfeifei40@huawei.com>=0D

This patch add package sending and receiving function codes.=0D
=0D
Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>=0D
Signed-off-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Xin Wang <wangxin679@h-partners.com>=0D
---=0D
 drivers/net/hinic3/hinic3_ethdev.c |  15 +-=0D
 drivers/net/hinic3/hinic3_rx.c     | 305 +++++++++++-=0D
 drivers/net/hinic3/hinic3_tx.c     | 754 +++++++++++++++++++++++++++++=0D
 drivers/net/hinic3/hinic3_tx.h     |   1 +=0D
 4 files changed, 1059 insertions(+), 16 deletions(-)=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index d9bca3aeb3..47b47b7412 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -21,9 +21,9 @@=0D
 #include "base/hinic3_hw_comm.h"=0D
 #include "base/hinic3_nic_cfg.h"=0D
 #include "base/hinic3_nic_event.h"=0D
-#include "hinic3_pmd_nic_io.h"=0D
-#include "hinic3_pmd_tx.h"=0D
-#include "hinic3_pmd_rx.h"=0D
+#include "hinic3_nic_io.h"=0D
+#include "hinic3_tx.h"=0D
+#include "hinic3_rx.h"=0D
 #include "hinic3_ethdev.h"=0D
 =0D
 #define HINIC3_MIN_RX_BUF_SIZE 1024=0D
@@ -1521,7 +1521,7 @@ hinic3_enable_interrupt(struct rte_eth_dev *dev)=0D
 =0D
 /** Dp interrupt msix attribute. */=0D
 #define HINIC3_TXRX_MSIX_PENDING_LIMIT	  2=0D
-#define HINIC3_TXRX_MSIX_COALESC_TIMER	  2=0D
+#define HINIC3_TXRX_MSIX_COALESCE_TIMER	  2=0D
 #define HINIC3_TXRX_MSIX_RESEND_TIMER_CFG 7=0D
 =0D
 static int=0D
@@ -1531,9 +1531,9 @@ hinic3_init_rxq_msix_attr(void *hwdev, u16 msix_index=
)=0D
 	int err;=0D
 =0D
 	info.lli_set =3D 0;=0D
-	info.interrupt_coalesc_set =3D 1;=0D
+	info.interrupt_coalesce_set =3D 1;=0D
 	info.pending_limt =3D HINIC3_TXRX_MSIX_PENDING_LIMIT;=0D
-	info.coalesc_timer_cfg =3D HINIC3_TXRX_MSIX_COALESC_TIMER;=0D
+	info.coalesce_timer_cfg =3D HINIC3_TXRX_MSIX_COALESCE_TIMER;=0D
 	info.resend_timer_cfg =3D HINIC3_TXRX_MSIX_RESEND_TIMER_CFG;=0D
 =0D
 	info.msix_index =3D msix_index;=0D
@@ -3337,6 +3337,9 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)=0D
 	PMD_DRV_LOG(INFO, "Network Interface pmd driver version: %s",=0D
 		    HINIC3_PMD_DRV_VERSION);=0D
 =0D
+	eth_dev->rx_pkt_burst =3D hinic3_recv_pkts;=0D
+	eth_dev->tx_pkt_burst =3D hinic3_xmit_pkts;=0D
+=0D
 	return hinic3_func_init(eth_dev);=0D
 }=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.=
c=0D
index 6fe565984b..36890e48e6 100644=0D
--- a/drivers/net/hinic3/hinic3_rx.c=0D
+++ b/drivers/net/hinic3/hinic3_rx.c=0D
@@ -7,14 +7,14 @@=0D
 #include <rte_mbuf.h>=0D
 =0D
 #include "base/hinic3_compat.h"=0D
-#include "base/hinic3_pmd_hwif.h"=0D
-#include "base/hinic3_pmd_hwdev.h"=0D
-#include "base/hinic3_pmd_wq.h"=0D
-#include "base/hinic3_pmd_nic_cfg.h"=0D
-#include "hinic3_pmd_nic_io.h"=0D
-#include "hinic3_pmd_ethdev.h"=0D
-#include "hinic3_pmd_tx.h"=0D
-#include "hinic3_pmd_rx.h"=0D
+#include "base/hinic3_hwif.h"=0D
+#include "base/hinic3_hwdev.h"=0D
+#include "base/hinic3_wq.h"=0D
+#include "base/hinic3_nic_cfg.h"=0D
+#include "hinic3_nic_io.h"=0D
+#include "hinic3_ethdev.h"=0D
+#include "hinic3_tx.h"=0D
+#include "hinic3_rx.h"=0D
 =0D
 /**=0D
  * Get wqe from receive queue.=0D
@@ -447,7 +447,7 @@ hinic3_refill_indir_rqid(struct hinic3_rxq *rxq)=0D
 				       HINIC3_RSS_INDIR_SIZE);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR,=0D
-			"Set indrect table failed, eth_dev:%s, queue_idx:%d",=0D
+			"Set indirect table failed, eth_dev:%s, queue_idx:%d",=0D
 			nic_dev->dev_name, rxq->q_id);=0D
 		goto out;=0D
 	}=0D
@@ -791,7 +791,7 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hin=
ic3_rxq *rxq)=0D
 		err =3D hinic3_refill_indir_rqid(rxq);=0D
 		if (err) {=0D
 			PMD_DRV_LOG(ERR,=0D
-				    "Refill rq to indrect table failed, "=0D
+				    "Refill rq to indirect table failed, "=0D
 				    "eth_dev:%s, queue_idx:%d err:%d",=0D
 				    nic_dev->dev_name, rxq->q_id, err);=0D
 			hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);=0D
@@ -812,3 +812,288 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct h=
inic3_rxq *rxq)=0D
 =0D
 	return err;=0D
 }=0D
+=0D
+=0D
+static inline u64=0D
+hinic3_rx_vlan(u32 offload_type, u32 vlan_len, u16 *vlan_tci)=0D
+{=0D
+	uint16_t vlan_tag;=0D
+=0D
+	vlan_tag =3D HINIC3_GET_RX_VLAN_TAG(vlan_len);=0D
+	if (!HINIC3_GET_RX_VLAN_OFFLOAD_EN(offload_type) || vlan_tag =3D=3D 0) {=
=0D
+		*vlan_tci =3D 0;=0D
+		return 0;=0D
+	}=0D
+=0D
+	*vlan_tci =3D vlan_tag;=0D
+=0D
+	return HINIC3_PKT_RX_VLAN | HINIC3_PKT_RX_VLAN_STRIPPED;=0D
+}=0D
+=0D
+static inline u64=0D
+hinic3_rx_csum(uint32_t status, struct hinic3_rxq *rxq)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
+	u32 csum_err;=0D
+	u64 flags;=0D
+=0D
+	if (unlikely(!(nic_dev->rx_csum_en & HINIC3_DEFAULT_RX_CSUM_OFFLOAD)))=0D
+		return HINIC3_PKT_RX_IP_CKSUM_UNKNOWN;=0D
+=0D
+	csum_err =3D HINIC3_GET_RX_CSUM_ERR(status);=0D
+	if (likely(csum_err =3D=3D 0))=0D
+		return (HINIC3_PKT_RX_IP_CKSUM_GOOD |=0D
+			HINIC3_PKT_RX_L4_CKSUM_GOOD);=0D
+=0D
+	/*=0D
+	 * If bypass bit is set, all other err status indications should be=0D
+	 * ignored.=0D
+	 */=0D
+	if (unlikely(csum_err & HINIC3_RX_CSUM_HW_CHECK_NONE))=0D
+		return HINIC3_PKT_RX_IP_CKSUM_UNKNOWN;=0D
+=0D
+	flags =3D 0;=0D
+=0D
+	/* IP checksum error. */=0D
+	if (csum_err & HINIC3_RX_CSUM_IP_CSUM_ERR) {=0D
+		flags |=3D HINIC3_PKT_RX_IP_CKSUM_BAD;=0D
+		rxq->rxq_stats.csum_errors++;=0D
+	}=0D
+=0D
+	/* L4 checksum error. */=0D
+	if ((csum_err & HINIC3_RX_CSUM_TCP_CSUM_ERR) ||=0D
+	    (csum_err & HINIC3_RX_CSUM_UDP_CSUM_ERR) ||=0D
+	    (csum_err & HINIC3_RX_CSUM_SCTP_CRC_ERR)) {=0D
+		flags |=3D HINIC3_PKT_RX_L4_CKSUM_BAD;=0D
+		rxq->rxq_stats.csum_errors++;=0D
+	}=0D
+=0D
+	if (unlikely(csum_err =3D=3D HINIC3_RX_CSUM_IPSU_OTHER_ERR))=0D
+		rxq->rxq_stats.other_errors++;=0D
+=0D
+	return flags;=0D
+}=0D
+=0D
+static inline u64=0D
+hinic3_rx_rss_hash(u32 offload_type, u32 rss_hash_value, u32 *rss_hash)=0D
+{=0D
+	u32 rss_type;=0D
+=0D
+	rss_type =3D HINIC3_GET_RSS_TYPES(offload_type);=0D
+	if (likely(rss_type !=3D 0)) {=0D
+		*rss_hash =3D rss_hash_value;=0D
+		return HINIC3_PKT_RX_RSS_HASH;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void=0D
+hinic3_recv_jumbo_pkt(struct hinic3_rxq *rxq, struct rte_mbuf *head_mbuf,=
=0D
+		      u32 remain_pkt_len)=0D
+{=0D
+	struct rte_mbuf *cur_mbuf =3D NULL;=0D
+	struct rte_mbuf *rxm =3D NULL;=0D
+	struct hinic3_rx_info *rx_info =3D NULL;=0D
+	u16 sw_ci, rx_buf_len =3D rxq->buf_len;=0D
+	u32 pkt_len;=0D
+=0D
+	while (remain_pkt_len > 0) {=0D
+		sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+		rx_info =3D &rxq->rx_info[sw_ci];=0D
+=0D
+		hinic3_update_rq_local_ci(rxq, 1);=0D
+=0D
+		pkt_len =3D remain_pkt_len > rx_buf_len ? rx_buf_len=0D
+						      : remain_pkt_len;=0D
+		remain_pkt_len -=3D pkt_len;=0D
+=0D
+		cur_mbuf =3D rx_info->mbuf;=0D
+		cur_mbuf->data_len =3D (u16)pkt_len;=0D
+		cur_mbuf->next =3D NULL;=0D
+=0D
+		head_mbuf->pkt_len +=3D cur_mbuf->data_len;=0D
+		head_mbuf->nb_segs++;=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+		rxq->rxq_stats.rx_free_mbuf_bytes++;=0D
+#endif=0D
+		if (!rxm)=0D
+			head_mbuf->next =3D cur_mbuf;=0D
+		else=0D
+			rxm->next =3D cur_mbuf;=0D
+=0D
+		rxm =3D cur_mbuf;=0D
+	}=0D
+}=0D
+=0D
+int=0D
+hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	int err =3D 0;=0D
+	int i;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
+=0D
+	for (i =3D 0; i < nic_dev->num_rqs; i++) {=0D
+		rxq =3D eth_dev->data->rx_queues[i];=0D
+		hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);=0D
+		err =3D hinic3_rearm_rxq_mbuf(rxq);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Fail to alloc mbuf for Rx queue %d, "=0D
+				    "qid =3D %u, need_mbuf: %d",=0D
+				    i, rxq->q_id, rxq->q_depth);=0D
+			goto out;=0D
+		}=0D
+		hinic3_dev_rx_queue_intr_enable(eth_dev, rxq->q_id);=0D
+		eth_dev->data->rx_queue_state[i] =3D RTE_ETH_QUEUE_STATE_STARTED;=0D
+	}=0D
+=0D
+	if (nic_dev->rss_state =3D=3D HINIC3_RSS_ENABLE) {=0D
+		err =3D hinic3_refill_indir_rqid(rxq);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Refill rq to indirect table failed, "=0D
+				    "eth_dev:%s, queue_idx:%d, err:%d",=0D
+				    rxq->nic_dev->dev_name, rxq->q_id, err);=0D
+			goto out;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+out:=0D
+	for (i =3D 0; i < nic_dev->num_rqs; i++) {=0D
+		rxq =3D eth_dev->data->rx_queues[i];=0D
+		hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);=0D
+		hinic3_free_rxq_mbufs(rxq);=0D
+		hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);=0D
+		eth_dev->data->rx_queue_state[i] =3D RTE_ETH_QUEUE_STATE_STOPPED;=0D
+	}=0D
+	return err;=0D
+}=0D
+=0D
+#define HINIC3_RX_EMPTY_THRESHOLD 3=0D
+u16=0D
+hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)=0D
+{=0D
+	struct hinic3_rxq *rxq =3D rx_queue;=0D
+	struct hinic3_rx_info *rx_info =3D NULL;=0D
+	volatile struct hinic3_rq_cqe *rx_cqe =3D NULL;=0D
+	struct rte_mbuf *rxm =3D NULL;=0D
+	u16 sw_ci, rx_buf_len, wqebb_cnt =3D 0, pkts =3D 0;=0D
+	u32 status, pkt_len, vlan_len, offload_type, lro_num;=0D
+	u64 rx_bytes =3D 0;=0D
+	u32 hash_value;=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_RX=0D
+	uint64_t t1 =3D rte_get_tsc_cycles();=0D
+	uint64_t t2;=0D
+#endif=0D
+	if (((rte_get_timer_cycles() - rxq->rxq_stats.tsc) < rxq->wait_time_cycle=
) &&=0D
+	    rxq->rxq_stats.empty >=3D HINIC3_RX_EMPTY_THRESHOLD)=0D
+		goto out;=0D
+=0D
+	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+	rx_buf_len =3D rxq->buf_len;=0D
+=0D
+	while (pkts < nb_pkts) {=0D
+		rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
+		status =3D hinic3_hw_cpu32((u32)(rte_atomic_load_explicit(&rx_cqe->statu=
s,=0D
+			rte_memory_order_acquire)));=0D
+		if (!HINIC3_GET_RX_DONE(status)) {=0D
+			rxq->rxq_stats.empty++;=0D
+			break;=0D
+		}=0D
+=0D
+		vlan_len =3D hinic3_hw_cpu32(rx_cqe->vlan_len);=0D
+=0D
+		pkt_len =3D HINIC3_GET_RX_PKT_LEN(vlan_len);=0D
+=0D
+		rx_info =3D &rxq->rx_info[sw_ci];=0D
+		rxm =3D rx_info->mbuf;=0D
+=0D
+		/* 1. Next ci point and prefetch. */=0D
+		sw_ci++;=0D
+		sw_ci &=3D rxq->q_mask;=0D
+=0D
+		/* 2. Prefetch next mbuf first 64B. */=0D
+		rte_prefetch0(rxq->rx_info[sw_ci].mbuf);=0D
+=0D
+		/* 3. Jumbo frame process. */=0D
+		if (likely(pkt_len <=3D (u32)rx_buf_len)) {=0D
+			rxm->data_len =3D (u16)pkt_len;=0D
+			rxm->pkt_len =3D pkt_len;=0D
+			wqebb_cnt++;=0D
+		} else {=0D
+			rxm->data_len =3D rx_buf_len;=0D
+			rxm->pkt_len =3D rx_buf_len;=0D
+=0D
+			/*=0D
+			 * If receive jumbo, updating ci will be done by=0D
+			 * hinic3_recv_jumbo_pkt function.=0D
+			 */=0D
+			hinic3_update_rq_local_ci(rxq, wqebb_cnt + 1);=0D
+			wqebb_cnt =3D 0;=0D
+			hinic3_recv_jumbo_pkt(rxq, rxm, pkt_len - rx_buf_len);=0D
+			sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+		}=0D
+=0D
+		rxm->data_off =3D RTE_PKTMBUF_HEADROOM;=0D
+		rxm->port =3D rxq->port_id;=0D
+=0D
+		/* 4. Rx checksum offload. */=0D
+		rxm->ol_flags |=3D hinic3_rx_csum(status, rxq);=0D
+=0D
+		/* 5. Vlan offload. */=0D
+		offload_type =3D hinic3_hw_cpu32(rx_cqe->offload_type);=0D
+=0D
+		rxm->ol_flags |=3D=0D
+			hinic3_rx_vlan(offload_type, vlan_len, &rxm->vlan_tci);=0D
+=0D
+		/* 6. RSS. */=0D
+		hash_value =3D hinic3_hw_cpu32(rx_cqe->hash_val);=0D
+		rxm->ol_flags |=3D hinic3_rx_rss_hash(offload_type, hash_value,=0D
+						    &rxm->hash.rss);=0D
+		/* 8. LRO. */=0D
+		lro_num =3D HINIC3_GET_RX_NUM_LRO(status);=0D
+		if (unlikely(lro_num !=3D 0)) {=0D
+			rxm->ol_flags |=3D HINIC3_PKT_RX_LRO;=0D
+			rxm->tso_segsz =3D pkt_len / lro_num;=0D
+		}=0D
+=0D
+		rx_cqe->status =3D 0;=0D
+=0D
+		rx_bytes +=3D pkt_len;=0D
+		rx_pkts[pkts++] =3D rxm;=0D
+	}=0D
+=0D
+	if (pkts) {=0D
+		/* 9. Update local ci. */=0D
+		hinic3_update_rq_local_ci(rxq, wqebb_cnt);=0D
+=0D
+		/* Update packet stats. */=0D
+		rxq->rxq_stats.packets +=3D pkts;=0D
+		rxq->rxq_stats.bytes +=3D rx_bytes;=0D
+		rxq->rxq_stats.empty =3D 0;=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+		rxq->rxq_stats.rx_free_mbuf_bytes +=3D pkts;=0D
+#endif=0D
+	}=0D
+	rxq->rxq_stats.burst_pkts =3D pkts;=0D
+	rxq->rxq_stats.tsc =3D rte_get_timer_cycles();=0D
+out:=0D
+	/* 10. Rearm mbuf to rxq. */=0D
+	hinic3_rearm_rxq_mbuf(rxq);=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_RX=0D
+	/* Do profiling stats. */=0D
+	t2 =3D rte_get_tsc_cycles();=0D
+	rxq->rxq_stats.app_tsc =3D t1 - rxq->prof_rx_end_tsc;=0D
+	rxq->prof_rx_end_tsc =3D t2;=0D
+	rxq->rxq_stats.pmd_tsc =3D t2 - t1;=0D
+#endif=0D
+=0D
+	return pkts;=0D
+}=0D
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.=
c=0D
index 6f8c42e0c3..04d5551bba 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.c=0D
+++ b/drivers/net/hinic3/hinic3_tx.c=0D
@@ -60,6 +60,98 @@ hinic3_get_sq_hw_ci(struct hinic3_txq *sq)=0D
 	return MASKED_QUEUE_IDX(sq, hinic3_hw_cpu16(*sq->ci_vaddr_base));=0D
 }=0D
 =0D
+static void *=0D
+hinic3_get_sq_wqe(struct hinic3_txq *sq, struct hinic3_wqe_info *wqe_info)=
=0D
+{=0D
+	u16 cur_pi =3D MASKED_QUEUE_IDX(sq, sq->prod_idx);=0D
+	u32 end_pi;=0D
+=0D
+	end_pi =3D cur_pi + wqe_info->wqebb_cnt;=0D
+	sq->prod_idx +=3D wqe_info->wqebb_cnt;=0D
+=0D
+	wqe_info->owner =3D (u8)(sq->owner);=0D
+	wqe_info->pi =3D cur_pi;=0D
+	wqe_info->wrapped =3D 0;=0D
+=0D
+	if (unlikely(end_pi >=3D sq->q_depth)) {=0D
+		sq->owner =3D !sq->owner;=0D
+=0D
+		if (likely(end_pi > sq->q_depth))=0D
+			wqe_info->wrapped =3D (u8)(sq->q_depth - cur_pi);=0D
+	}=0D
+=0D
+	return NIC_WQE_ADDR(sq, cur_pi);=0D
+}=0D
+=0D
+static inline void=0D
+hinic3_put_sq_wqe(struct hinic3_txq *sq, struct hinic3_wqe_info *wqe_info)=
=0D
+{=0D
+	if (wqe_info->owner !=3D sq->owner)=0D
+		sq->owner =3D wqe_info->owner;=0D
+=0D
+	sq->prod_idx -=3D wqe_info->wqebb_cnt;=0D
+}=0D
+=0D
+/**=0D
+ * Sets the WQE combination information in the transmit queue (SQ).=0D
+ *=0D
+ * @param[in] txq=0D
+ * Point to send queue.=0D
+ * @param[out] wqe_combo=0D
+ * Point to wqe_combo of send queue(SQ).=0D
+ * @param[in] wqe=0D
+ * Point to wqe of send queue(SQ).=0D
+ * @param[in] wqe_info=0D
+ * Point to wqe_info of send queue(SQ).=0D
+ */=0D
+static void=0D
+hinic3_set_wqe_combo(struct hinic3_txq *txq,=0D
+		     struct hinic3_sq_wqe_combo *wqe_combo,=0D
+		     struct hinic3_sq_wqe *wqe,=0D
+		     struct hinic3_wqe_info *wqe_info)=0D
+{=0D
+	wqe_combo->hdr =3D &wqe->compact_wqe.wqe_desc;=0D
+=0D
+	if (wqe_info->offload) {=0D
+		if (wqe_info->wrapped =3D=3D HINIC3_TX_TASK_WRAPPED) {=0D
+			wqe_combo->task =3D (struct hinic3_sq_task *)=0D
+				(void *)txq->sq_head_addr;=0D
+			wqe_combo->bds_head =3D (struct hinic3_sq_bufdesc *)=0D
+				(void *)(txq->sq_head_addr + txq->wqebb_size);=0D
+		} else if (wqe_info->wrapped =3D=3D HINIC3_TX_BD_DESC_WRAPPED) {=0D
+			wqe_combo->task =3D &wqe->extend_wqe.task;=0D
+			wqe_combo->bds_head =3D (struct hinic3_sq_bufdesc *)=0D
+				(void *)(txq->sq_head_addr);=0D
+		} else {=0D
+			wqe_combo->task =3D &wqe->extend_wqe.task;=0D
+			wqe_combo->bds_head =3D wqe->extend_wqe.buf_desc;=0D
+		}=0D
+=0D
+		wqe_combo->wqe_type =3D SQ_WQE_EXTENDED_TYPE;=0D
+		wqe_combo->task_type =3D SQ_WQE_TASKSECT_16BYTES;=0D
+=0D
+		return;=0D
+	}=0D
+=0D
+	if (wqe_info->wrapped =3D=3D HINIC3_TX_TASK_WRAPPED) {=0D
+		wqe_combo->bds_head =3D (struct hinic3_sq_bufdesc *)=0D
+			(void *)(txq->sq_head_addr);=0D
+	} else {=0D
+		wqe_combo->bds_head =3D=0D
+			(struct hinic3_sq_bufdesc *)(&wqe->extend_wqe.task);=0D
+	}=0D
+=0D
+	if (wqe_info->wqebb_cnt > 1) {=0D
+		wqe_combo->wqe_type =3D SQ_WQE_EXTENDED_TYPE;=0D
+		wqe_combo->task_type =3D SQ_WQE_TASKSECT_46BITS;=0D
+=0D
+		/* This section used as vlan insert, needs to clear. */=0D
+		wqe_combo->bds_head->rsvd =3D 0;=0D
+	} else {=0D
+		wqe_combo->wqe_type =3D SQ_WQE_COMPACT_TYPE;=0D
+	}=0D
+}=0D
+=0D
 int=0D
 hinic3_start_all_sqs(struct rte_eth_dev *eth_dev)=0D
 {=0D
@@ -220,6 +312,668 @@ hinic3_tx_done_cleanup(void *txq, u32 free_cnt)=0D
 	return hinic3_xmit_mbuf_cleanup(tx_queue, try_free_cnt);=0D
 }=0D
 =0D
+/**=0D
+ * Prepare the data packet to be sent and calculate the internal L3 offset=
.=0D
+ *=0D
+ * @param[in] mbuf=0D
+ * Point to the mbuf to be processed.=0D
+ * @param[out] inner_l3_offset=0D
+ * Inner(IP Layer) L3 layer offset.=0D
+ * @return=0D
+ * 0 as success, -EINVAL as failure.=0D
+ */=0D
+static int=0D
+hinic3_tx_offload_pkt_prepare(struct rte_mbuf *mbuf, u16 *inner_l3_offset)=
=0D
+{=0D
+	uint64_t ol_flags =3D mbuf->ol_flags;=0D
+=0D
+	/* Only support vxlan offload. */=0D
+	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) &&=0D
+	    (!(ol_flags & HINIC3_PKT_TX_TUNNEL_VXLAN)))=0D
+		return -EINVAL;=0D
+=0D
+#ifdef RTE_LIBRTE_ETHDEV_DEBUG=0D
+	if (rte_validate_tx_offload(mbuf) !=3D 0)=0D
+		return -EINVAL;=0D
+#endif=0D
+	/* Support tunnel. */=0D
+	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK)) {=0D
+		if ((ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM) ||=0D
+		    (ol_flags & HINIC3_PKT_TX_OUTER_IPV6) ||=0D
+		    (ol_flags & HINIC3_PKT_TX_TCP_SEG)) {=0D
+			/*=0D
+			 * For this senmatic, l2_len of mbuf means=0D
+			 * len(out_udp + vxlan + in_eth).=0D
+			 */=0D
+			*inner_l3_offset =3D mbuf->l2_len + mbuf->outer_l2_len +=0D
+					   mbuf->outer_l3_len;=0D
+		} else {=0D
+			/*=0D
+			 * For this senmatic, l2_len of mbuf means=0D
+			 * len(out_eth + out_ip + out_udp + vxlan + in_eth).=0D
+			 */=0D
+			*inner_l3_offset =3D mbuf->l2_len;=0D
+		}=0D
+	} else {=0D
+		/* For non-tunnel type pkts. */=0D
+		*inner_l3_offset =3D mbuf->l2_len;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static inline void=0D
+hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task, u16 vlan_tag,=0D
+			   u8 vlan_type)=0D
+{=0D
+	task->vlan_offload =3D SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |=0D
+			     SQ_TASK_INFO3_SET(vlan_type, VLAN_TYPE) |=0D
+			     SQ_TASK_INFO3_SET(1U, VLAN_TAG_VALID);=0D
+}=0D
+=0D
+/**=0D
+ * Set the corresponding offload information based on ol_flags of the mbuf=
.=0D
+ *=0D
+ * @param[in] mbuf=0D
+ * Point to the mbuf for which offload needs to be set in the sending queu=
e.=0D
+ * @param[out] task=0D
+ * Point to task of send queue(SQ).=0D
+ * @param[out] wqe_info=0D
+ * Point to wqe_info of send queue(SQ).=0D
+ * @return=0D
+ * 0 as success, -EINVAL as failure.=0D
+ */=0D
+static int=0D
+hinic3_set_tx_offload(struct rte_mbuf *mbuf, struct hinic3_sq_task *task,=
=0D
+		      struct hinic3_wqe_info *wqe_info)=0D
+{=0D
+	uint64_t ol_flags =3D mbuf->ol_flags;=0D
+	u16 pld_offset =3D 0;=0D
+	u32 queue_info =3D 0;=0D
+	u16 vlan_tag;=0D
+=0D
+	task->pkt_info0 =3D 0;=0D
+	task->ip_identify =3D 0;=0D
+	task->pkt_info2 =3D 0;=0D
+	task->vlan_offload =3D 0;=0D
+=0D
+	/* Vlan offload. */=0D
+	if (unlikely(ol_flags & HINIC3_PKT_TX_VLAN_PKT)) {=0D
+		vlan_tag =3D mbuf->vlan_tci;=0D
+		hinic3_set_vlan_tx_offload(task, vlan_tag, HINIC3_TX_TPID0);=0D
+		task->vlan_offload =3D hinic3_hw_be32(task->vlan_offload);=0D
+	}=0D
+	/* Cksum offload. */=0D
+	if (!(ol_flags & HINIC3_TX_CKSUM_OFFLOAD_MASK))=0D
+		return 0;=0D
+=0D
+	/* Tso offload. */=0D
+	if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {=0D
+		pld_offset =3D wqe_info->payload_offset;=0D
+		if ((pld_offset >> 1) > MAX_PAYLOAD_OFFSET)=0D
+			return -EINVAL;=0D
+=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L4_EN);=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L3_EN);=0D
+=0D
+		queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(1U, TSO);=0D
+		queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(pld_offset >> 1, PLDOFF);=0D
+=0D
+		/* Set MSS value. */=0D
+		queue_info =3D SQ_CTRL_QUEUE_INFO_CLEAR(queue_info, MSS);=0D
+		queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(mbuf->tso_segsz, MSS);=0D
+	} else {=0D
+		if (ol_flags & HINIC3_PKT_TX_IP_CKSUM)=0D
+			task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L3_EN);=0D
+=0D
+		switch (ol_flags & HINIC3_PKT_TX_L4_MASK) {=0D
+		case HINIC3_PKT_TX_TCP_CKSUM:=0D
+		case HINIC3_PKT_TX_UDP_CKSUM:=0D
+		case HINIC3_PKT_TX_SCTP_CKSUM:=0D
+			task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L4_EN);=0D
+			break;=0D
+=0D
+		case HINIC3_PKT_TX_L4_NO_CKSUM:=0D
+			break;=0D
+=0D
+		default:=0D
+			PMD_DRV_LOG(INFO, "not support pkt type");=0D
+			return -EINVAL;=0D
+		}=0D
+	}=0D
+=0D
+	/* For vxlan, also can support PKT_TX_TUNNEL_GRE, etc. */=0D
+	switch (ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) {=0D
+	case HINIC3_PKT_TX_TUNNEL_VXLAN:=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);=0D
+		break;=0D
+=0D
+	case 0:=0D
+		break;=0D
+=0D
+	default:=0D
+		/* For non UDP/GRE tunneling, drop the tunnel packet. */=0D
+		PMD_DRV_LOG(INFO, "not support tunnel pkt type");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	if (ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM)=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, OUT_L3_EN);=0D
+=0D
+	task->pkt_info0 =3D hinic3_hw_be32(task->pkt_info0);=0D
+	task->pkt_info2 =3D hinic3_hw_be32(task->pkt_info2);=0D
+	wqe_info->queue_info =3D queue_info;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Check whether the number of segments in the mbuf is valid.=0D
+ *=0D
+ * @param[in] mbuf=0D
+ * Point to the mbuf to be verified.=0D
+ * @param[in] wqe_info=0D
+ * Point to wqe_info of send queue(SQ).=0D
+ * @return=0D
+ * true as valid, false as invalid.=0D
+ */=0D
+static bool=0D
+hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe=
_info)=0D
+{=0D
+	u32 total_len, limit_len, checked_len, left_len, adjust_mss;=0D
+	u32 i, max_sges, left_sges, first_len;=0D
+	struct rte_mbuf *mbuf_head, *mbuf_first;=0D
+	struct rte_mbuf *mbuf_pre =3D mbuf;=0D
+=0D
+	left_sges =3D mbuf->nb_segs;=0D
+	mbuf_head =3D mbuf;=0D
+	mbuf_first =3D mbuf;=0D
+=0D
+	/* Tso sge number validation. */=0D
+	if (unlikely(left_sges >=3D HINIC3_NONTSO_PKT_MAX_SGE)) {=0D
+		checked_len =3D 0;=0D
+		total_len =3D 0;=0D
+		first_len =3D 0;=0D
+		adjust_mss =3D mbuf->tso_segsz >=3D TX_MSS_MIN ? mbuf->tso_segsz=0D
+							   : TX_MSS_MIN;=0D
+		max_sges =3D HINIC3_NONTSO_PKT_MAX_SGE - 1;=0D
+		limit_len =3D adjust_mss + wqe_info->payload_offset;=0D
+=0D
+		for (i =3D 0; (i < max_sges) && (total_len < limit_len); i++) {=0D
+			total_len +=3D mbuf->data_len;=0D
+			mbuf_pre =3D mbuf;=0D
+			mbuf =3D mbuf->next;=0D
+		}=0D
+=0D
+		/* Each continues 38 mbufs segmust do one check. */=0D
+		while (left_sges >=3D HINIC3_NONTSO_PKT_MAX_SGE) {=0D
+			if (total_len >=3D limit_len) {=0D
+				/* Update the limit len. */=0D
+				limit_len =3D adjust_mss;=0D
+				/* Update checked len. */=0D
+				checked_len +=3D first_len;=0D
+				/* Record the first len. */=0D
+				first_len =3D mbuf_first->data_len;=0D
+				/* First mbuf move to the next. */=0D
+				mbuf_first =3D mbuf_first->next;=0D
+				/* Update total len. */=0D
+				total_len -=3D first_len;=0D
+				left_sges--;=0D
+				i--;=0D
+				for (;=0D
+				     (i < max_sges) && (total_len < limit_len);=0D
+				     i++) {=0D
+					total_len +=3D mbuf->data_len;=0D
+					mbuf_pre =3D mbuf;=0D
+					mbuf =3D mbuf->next;=0D
+				}=0D
+			} else {=0D
+				/* Try to copy if not valid. */=0D
+				checked_len +=3D (total_len - mbuf_pre->data_len);=0D
+=0D
+				left_len =3D mbuf_head->pkt_len - checked_len;=0D
+				if (left_len > HINIC3_COPY_MBUF_SIZE)=0D
+					return false;=0D
+				wqe_info->sge_cnt =3D (u16)(mbuf_head->nb_segs +=0D
+							  i - left_sges);=0D
+				wqe_info->cpy_mbuf_cnt =3D 1;=0D
+=0D
+				return true;=0D
+			}=0D
+		} /**< End of while. */=0D
+	}=0D
+=0D
+	wqe_info->sge_cnt =3D mbuf_head->nb_segs;=0D
+=0D
+	return true;=0D
+}=0D
+=0D
+/**=0D
+ * Checks and processes transport offload information for data packets.=0D
+ *=0D
+ * @param[in] mbuf=0D
+ * Point to the mbuf to send.=0D
+ * @param[in] wqe_info=0D
+ * Point to wqe_info of send queue(SQ).=0D
+ * @return=0D
+ * 0 as success, -EINVAL as failure.=0D
+ */=0D
+static int=0D
+hinic3_get_tx_offload(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_i=
nfo)=0D
+{=0D
+	uint64_t ol_flags =3D mbuf->ol_flags;=0D
+	u16 i, total_len, inner_l3_offset =3D 0;=0D
+	int err;=0D
+	struct rte_mbuf *mbuf_pkt =3D NULL;=0D
+=0D
+	wqe_info->sge_cnt =3D mbuf->nb_segs;=0D
+	/* Check if the packet set available offload flags. */=0D
+	if (!(ol_flags & HINIC3_TX_OFFLOAD_MASK)) {=0D
+		wqe_info->offload =3D 0;=0D
+		return 0;=0D
+	}=0D
+=0D
+	wqe_info->offload =3D 1;=0D
+	err =3D hinic3_tx_offload_pkt_prepare(mbuf, &inner_l3_offset);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	/* Non tso mbuf only check sge num. */=0D
+	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG))) {=0D
+		if (unlikely(mbuf->pkt_len > MAX_SINGLE_SGE_SIZE))=0D
+			/* Non tso packet len must less than 64KB. */=0D
+			return -EINVAL;=0D
+=0D
+		if (likely(HINIC3_NONTSO_SEG_NUM_VALID(mbuf->nb_segs)))=0D
+			/* Valid non-tso mbuf. */=0D
+			return 0;=0D
+=0D
+		/*=0D
+		 * The number of non-tso packet fragments must be less than 38,=0D
+		 * and mbuf segs greater than 38 must be copied to other=0D
+		 * buffers.=0D
+		 */=0D
+		total_len =3D 0;=0D
+		mbuf_pkt =3D mbuf;=0D
+		for (i =3D 0; i < (HINIC3_NONTSO_PKT_MAX_SGE - 1); i++) {=0D
+			total_len +=3D mbuf_pkt->data_len;=0D
+			mbuf_pkt =3D mbuf_pkt->next;=0D
+		}=0D
+=0D
+		/* Default support copy total 4k mbuf segs. */=0D
+		if ((u32)(total_len + (u16)HINIC3_COPY_MBUF_SIZE) <=0D
+		    mbuf->pkt_len)=0D
+			return -EINVAL;=0D
+=0D
+		wqe_info->sge_cnt =3D HINIC3_NONTSO_PKT_MAX_SGE;=0D
+		wqe_info->cpy_mbuf_cnt =3D 1;=0D
+=0D
+		return 0;=0D
+	}=0D
+=0D
+	/* Tso mbuf. */=0D
+	wqe_info->payload_offset =3D=0D
+		inner_l3_offset + mbuf->l3_len + mbuf->l4_len;=0D
+=0D
+	/* Too many mbuf segs. */=0D
+	if (unlikely(HINIC3_TSO_SEG_NUM_INVALID(mbuf->nb_segs)))=0D
+		return -EINVAL;=0D
+=0D
+	/* Check whether can cover all tso mbuf segs or not. */=0D
+	if (unlikely(!hinic3_is_tso_sge_valid(mbuf, wqe_info)))=0D
+		return -EINVAL;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static inline void=0D
+hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs, rte_iova_t addr,=
=0D
+		    u32 len)=0D
+{=0D
+	buf_descs->hi_addr =3D hinic3_hw_be32(upper_32_bits(addr));=0D
+	buf_descs->lo_addr =3D hinic3_hw_be32(lower_32_bits(addr));=0D
+	buf_descs->len =3D hinic3_hw_be32(len);=0D
+}=0D
+=0D
+static inline struct rte_mbuf *=0D
+hinic3_alloc_cpy_mbuf(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	return rte_pktmbuf_alloc(nic_dev->cpy_mpool);=0D
+}=0D
+=0D
+/**=0D
+ * Copy packets in the send queue(SQ).=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Point to nic device.=0D
+ * @param[in] mbuf=0D
+ * Point to the source mbuf.=0D
+ * @param[in] seg_cnt=0D
+ * Number of mbuf segments to be copied.=0D
+ * @result=0D
+ * The address of the copied mbuf.=0D
+ */=0D
+static void *=0D
+hinic3_copy_tx_mbuf(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,=
=0D
+		    u16 sge_cnt)=0D
+{=0D
+	struct rte_mbuf *dst_mbuf;=0D
+	u32 offset =3D 0;=0D
+	u16 i;=0D
+=0D
+	if (unlikely(!nic_dev->cpy_mpool))=0D
+		return NULL;=0D
+=0D
+	dst_mbuf =3D hinic3_alloc_cpy_mbuf(nic_dev);=0D
+	if (unlikely(!dst_mbuf))=0D
+		return NULL;=0D
+=0D
+	dst_mbuf->data_off =3D 0;=0D
+	dst_mbuf->data_len =3D 0;=0D
+	for (i =3D 0; i < sge_cnt; i++) {=0D
+		rte_memcpy((u8 *)dst_mbuf->buf_addr + offset,=0D
+			   (u8 *)mbuf->buf_addr + mbuf->data_off,=0D
+			   mbuf->data_len);=0D
+		dst_mbuf->data_len +=3D mbuf->data_len;=0D
+		offset +=3D mbuf->data_len;=0D
+		mbuf =3D mbuf->next;=0D
+	}=0D
+	dst_mbuf->pkt_len =3D dst_mbuf->data_len;=0D
+=0D
+	return dst_mbuf;=0D
+}=0D
+=0D
+/**=0D
+ * Map the TX mbuf to the DMA address space and set related information fo=
r=0D
+ * subsequent DMA transmission.=0D
+ *=0D
+ * @param[in] txq=0D
+ * Point to send queue.=0D
+ * @param[in] mbuf=0D
+ * Point to the tx mbuf.=0D
+ * @param[out] wqe_combo=0D
+ * Point to send queue wqe_combo.=0D
+ * @param[in] wqe_info=0D
+ * Point to wqe_info of send queue(SQ).=0D
+ * @result=0D
+ * 0 as success, -EINVAL as failure.=0D
+ */=0D
+static int=0D
+hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,=0D
+			struct hinic3_sq_wqe_combo *wqe_combo,=0D
+			struct hinic3_wqe_info *wqe_info)=0D
+{=0D
+	struct hinic3_sq_wqe_desc *wqe_desc =3D wqe_combo->hdr;=0D
+	struct hinic3_sq_bufdesc *buf_desc =3D wqe_combo->bds_head;=0D
+=0D
+	uint16_t nb_segs =3D wqe_info->sge_cnt - wqe_info->cpy_mbuf_cnt;=0D
+	uint16_t real_segs =3D mbuf->nb_segs;=0D
+	rte_iova_t dma_addr;=0D
+	u32 i;=0D
+=0D
+	for (i =3D 0; i < nb_segs; i++) {=0D
+		if (unlikely(mbuf =3D=3D NULL)) {=0D
+			txq->txq_stats.mbuf_null++;=0D
+			return -EINVAL;=0D
+		}=0D
+=0D
+		if (unlikely(mbuf->data_len =3D=3D 0)) {=0D
+			txq->txq_stats.sge_len0++;=0D
+			return -EINVAL;=0D
+		}=0D
+=0D
+		dma_addr =3D rte_mbuf_data_iova(mbuf);=0D
+		if (i =3D=3D 0) {=0D
+			if (wqe_combo->wqe_type =3D=3D SQ_WQE_COMPACT_TYPE &&=0D
+			    mbuf->data_len > COMPACT_WQE_MAX_CTRL_LEN) {=0D
+				txq->txq_stats.sge_len_too_large++;=0D
+				return -EINVAL;=0D
+			}=0D
+=0D
+			wqe_desc->hi_addr =3D=0D
+				hinic3_hw_be32(upper_32_bits(dma_addr));=0D
+			wqe_desc->lo_addr =3D=0D
+				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
+			wqe_desc->ctrl_len =3D mbuf->data_len;=0D
+		} else {=0D
+			/*=0D
+			 * Parts of wqe is in sq bottom while parts=0D
+			 * of wqe is in sq head.=0D
+			 */=0D
+			if (unlikely(wqe_info->wrapped &&=0D
+				     (u64)buf_desc =3D=3D txq->sq_bot_sge_addr))=0D
+				buf_desc =3D (struct hinic3_sq_bufdesc *)=0D
+					   (void *)txq->sq_head_addr;=0D
+=0D
+			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);=0D
+			buf_desc++;=0D
+		}=0D
+		mbuf =3D mbuf->next;=0D
+	}=0D
+=0D
+	/* For now: support over 38 sge, copy the last 2 mbuf. */=0D
+	if (unlikely(wqe_info->cpy_mbuf_cnt !=3D 0)) {=0D
+		/*=0D
+		 * Copy invalid mbuf segs to a valid buffer, lost performance.=0D
+		 */=0D
+		txq->txq_stats.cpy_pkts +=3D 1;=0D
+		mbuf =3D hinic3_copy_tx_mbuf(txq->nic_dev, mbuf,=0D
+					   real_segs - nb_segs);=0D
+		if (unlikely(!mbuf))=0D
+			return -EINVAL;=0D
+=0D
+		txq->tx_info[wqe_info->pi].cpy_mbuf =3D mbuf;=0D
+=0D
+		/* Deal with the last mbuf. */=0D
+		dma_addr =3D rte_mbuf_data_iova(mbuf);=0D
+		if (unlikely(mbuf->data_len =3D=3D 0)) {=0D
+			txq->txq_stats.sge_len0++;=0D
+			return -EINVAL;=0D
+		}=0D
+		/*=0D
+		 * Parts of wqe is in sq bottom while parts=0D
+		 * of wqe is in sq head.=0D
+		 */=0D
+		if (i =3D=3D 0) {=0D
+			wqe_desc->hi_addr =3D=0D
+				hinic3_hw_be32(upper_32_bits(dma_addr));=0D
+			wqe_desc->lo_addr =3D=0D
+				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
+			wqe_desc->ctrl_len =3D mbuf->data_len;=0D
+		} else {=0D
+			if (unlikely(wqe_info->wrapped &&=0D
+				     ((u64)buf_desc =3D=3D txq->sq_bot_sge_addr)))=0D
+				buf_desc =3D (struct hinic3_sq_bufdesc *)=0D
+						   txq->sq_head_addr;=0D
+=0D
+			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Sets and configures fields in the transmit queue control descriptor bas=
ed on=0D
+ * the WQE type.=0D
+ *=0D
+ * @param[out] wqe_combo=0D
+ * Point to wqe_combo of send queue.=0D
+ * @param[in] wqe_info=0D
+ * Point to wqe_info of send queue.=0D
+ */=0D
+static void=0D
+hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,=0D
+		       struct hinic3_wqe_info *wqe_info)=0D
+{=0D
+	struct hinic3_sq_wqe_desc *wqe_desc =3D wqe_combo->hdr;=0D
+=0D
+	if (wqe_combo->wqe_type =3D=3D SQ_WQE_COMPACT_TYPE) {=0D
+		wqe_desc->ctrl_len |=3D=0D
+			SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |=0D
+			SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |=0D
+			SQ_CTRL_SET(wqe_info->owner, OWNER);=0D
+		wqe_desc->ctrl_len =3D hinic3_hw_be32(wqe_desc->ctrl_len);=0D
+=0D
+		/* Compact wqe queue_info will transfer to ucode. */=0D
+		wqe_desc->queue_info =3D 0;=0D
+=0D
+		return;=0D
+	}=0D
+=0D
+	wqe_desc->ctrl_len |=3D SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |=0D
+			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |=0D
+			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |=0D
+			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |=0D
+			      SQ_CTRL_SET(wqe_info->owner, OWNER);=0D
+=0D
+	wqe_desc->ctrl_len =3D hinic3_hw_be32(wqe_desc->ctrl_len);=0D
+=0D
+	wqe_desc->queue_info =3D wqe_info->queue_info;=0D
+	wqe_desc->queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(1U, UC);=0D
+=0D
+	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {=0D
+		wqe_desc->queue_info |=3D=0D
+			SQ_CTRL_QUEUE_INFO_SET(TX_MSS_DEFAULT, MSS);=0D
+	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <=0D
+		   TX_MSS_MIN) {=0D
+		/* Mss should not less than 80. */=0D
+		wqe_desc->queue_info =3D=0D
+			SQ_CTRL_QUEUE_INFO_CLEAR(wqe_desc->queue_info, MSS);=0D
+		wqe_desc->queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(TX_MSS_MIN, MSS);=0D
+	}=0D
+=0D
+	wqe_desc->queue_info =3D hinic3_hw_be32(wqe_desc->queue_info);=0D
+}=0D
+=0D
+/**=0D
+ * It is responsible for sending data packets.=0D
+ *=0D
+ * @param[in] tx_queue=0D
+ * Point to send queue.=0D
+ * @param[in] tx_pkts=0D
+ * Pointer to the array of data packets to be sent.=0D
+ * @param[in] nb_pkts=0D
+ * Number of sent packets.=0D
+ * @return=0D
+ * Number of actually sent packets.=0D
+ */=0D
+u16=0D
+hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts)=0D
+{=0D
+	struct hinic3_txq *txq =3D tx_queue;=0D
+	struct hinic3_tx_info *tx_info =3D NULL;=0D
+	struct rte_mbuf *mbuf_pkt =3D NULL;=0D
+	struct hinic3_sq_wqe_combo wqe_combo =3D {0};=0D
+	struct hinic3_sq_wqe *sq_wqe =3D NULL;=0D
+	struct hinic3_wqe_info wqe_info =3D {0};=0D
+=0D
+	u32 offload_err, free_cnt;=0D
+	u64 tx_bytes =3D 0;=0D
+	u16 free_wqebb_cnt, nb_tx;=0D
+	int err;=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_TX=0D
+	uint64_t t1, t2;=0D
+	t1 =3D rte_get_tsc_cycles();=0D
+#endif=0D
+=0D
+	if (unlikely(!HINIC3_TXQ_IS_STARTED(txq)))=0D
+		return 0;=0D
+=0D
+	free_cnt =3D txq->tx_free_thresh;=0D
+	/* Reclaim tx mbuf before xmit new packets. */=0D
+	if (hinic3_get_sq_free_wqebbs(txq) < txq->tx_free_thresh)=0D
+		hinic3_xmit_mbuf_cleanup(txq, free_cnt);=0D
+=0D
+	/* Tx loop routine. */=0D
+	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {=0D
+		mbuf_pkt =3D *tx_pkts++;=0D
+		if (unlikely(hinic3_get_tx_offload(mbuf_pkt, &wqe_info))) {=0D
+			txq->txq_stats.offload_errors++;=0D
+			break;=0D
+		}=0D
+=0D
+		if (!wqe_info.offload)=0D
+			wqe_info.wqebb_cnt =3D wqe_info.sge_cnt;=0D
+		else=0D
+			/* Use extended sq wqe with normal TS. */=0D
+			wqe_info.wqebb_cnt =3D wqe_info.sge_cnt + 1;=0D
+=0D
+		free_wqebb_cnt =3D hinic3_get_sq_free_wqebbs(txq);=0D
+		if (unlikely(wqe_info.wqebb_cnt > free_wqebb_cnt)) {=0D
+			/* Reclaim again. */=0D
+			hinic3_xmit_mbuf_cleanup(txq, free_cnt);=0D
+			free_wqebb_cnt =3D hinic3_get_sq_free_wqebbs(txq);=0D
+			if (unlikely(wqe_info.wqebb_cnt > free_wqebb_cnt)) {=0D
+				txq->txq_stats.tx_busy +=3D (nb_pkts - nb_tx);=0D
+				break;=0D
+			}=0D
+		}=0D
+=0D
+		/* Get sq wqe address from wqe_page. */=0D
+		sq_wqe =3D hinic3_get_sq_wqe(txq, &wqe_info);=0D
+		if (unlikely(!sq_wqe)) {=0D
+			txq->txq_stats.tx_busy++;=0D
+			break;=0D
+		}=0D
+=0D
+		/* Task or bd section maybe wrapped for one wqe. */=0D
+		hinic3_set_wqe_combo(txq, &wqe_combo, sq_wqe, &wqe_info);=0D
+=0D
+		wqe_info.queue_info =3D 0;=0D
+		/* Fill tx packet offload into qsf and task field. */=0D
+		if (wqe_info.offload) {=0D
+			offload_err =3D hinic3_set_tx_offload(mbuf_pkt,=0D
+							    wqe_combo.task,=0D
+							    &wqe_info);=0D
+			if (unlikely(offload_err)) {=0D
+				hinic3_put_sq_wqe(txq, &wqe_info);=0D
+				txq->txq_stats.offload_errors++;=0D
+				break;=0D
+			}=0D
+		}=0D
+=0D
+		/* Fill sq_wqe buf_desc and bd_desc. */=0D
+		err =3D hinic3_mbuf_dma_map_sge(txq, mbuf_pkt, &wqe_combo,=0D
+					      &wqe_info);=0D
+		if (err) {=0D
+			hinic3_put_sq_wqe(txq, &wqe_info);=0D
+			txq->txq_stats.offload_errors++;=0D
+			break;=0D
+		}=0D
+=0D
+		/* Record tx info. */=0D
+		tx_info =3D &txq->tx_info[wqe_info.pi];=0D
+		tx_info->mbuf =3D mbuf_pkt;=0D
+		tx_info->wqebb_cnt =3D wqe_info.wqebb_cnt;=0D
+=0D
+		hinic3_prepare_sq_ctrl(&wqe_combo, &wqe_info);=0D
+=0D
+		tx_bytes +=3D mbuf_pkt->pkt_len;=0D
+	}=0D
+=0D
+	/* Update txq stats. */=0D
+	if (nb_tx) {=0D
+		hinic3_write_db(txq->db_addr, txq->q_id, (int)(txq->cos),=0D
+				SQ_CFLAG_DP,=0D
+				MASKED_QUEUE_IDX(txq, txq->prod_idx));=0D
+		txq->txq_stats.packets +=3D nb_tx;=0D
+		txq->txq_stats.bytes +=3D tx_bytes;=0D
+	}=0D
+	txq->txq_stats.burst_pkts =3D nb_tx;=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_TX=0D
+	t2 =3D rte_get_tsc_cycles();=0D
+	txq->txq_stats.app_tsc =3D t1 - txq->prof_tx_end_tsc;=0D
+	txq->prof_tx_end_tsc =3D t2;=0D
+	txq->txq_stats.pmd_tsc =3D t2 - t1;=0D
+	txq->txq_stats.burst_pkts =3D nb_tx;=0D
+#endif=0D
+=0D
+	return nb_tx;=0D
+}=0D
+=0D
 int=0D
 hinic3_stop_sq(struct hinic3_txq *txq)=0D
 {=0D
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.=
h=0D
index f4c61ea1b1..6026b3fabc 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.h=0D
+++ b/drivers/net/hinic3/hinic3_tx.h=0D
@@ -308,6 +308,7 @@ struct __rte_cache_aligned hinic3_txq {=0D
 void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);=0D
 void hinic3_free_txq_mbufs(struct hinic3_txq *txq);=0D
 void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);=0D
+u16 hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkt=
s);=0D
 int hinic3_stop_sq(struct hinic3_txq *txq);=0D
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);=0D
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);=0D
-- =0D
2.45.1.windows.1=0D
=0D

