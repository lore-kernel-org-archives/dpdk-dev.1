Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2BCCA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:19:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C90124027C;
	Tue, 29 Sep 2026 02:18:59 +0200 (CEST)
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com
 [74.125.224.97]) by mails.dpdk.org (Postfix) with ESMTP id 898FC40276
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:18:57 +0200 (CEST)
Received: by mail-yx1-f97.google.com with SMTP id
 956f58d0204a3-671454dbcaaso288537d50.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641137; x=1791245937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P3wkS1QGh1d3ttV0mLmdV1AsVNkdKRvrlOKHjbJdiME=;
 b=M+VySUp5DtP+VpTWosL7ryswW7B1IcG6aJiRfBse0FsK67miQ6kSLGRCKOMEFVFbE9
 RYCqvBlmlVSaU6yY8m+g92HgW069qFJzg5yGSc+qavgye4WnZh6PTCv0t218vfRxzgCn
 5P9ClTwWUkftqgThND20Ya72BTIJFysg6N8Un44ZpAebTEzCCm8fSVnsF0L6ZR0RysnS
 1XR0GrVgZG+p8w4d9kcUYSXSOGZtw6/PEBw5c6b3iCxHZYUsdQGljzkSKULcZYBLPlL7
 ammHkd9bU5F8xmcD4HOmMK0ZjPNt7RWtfDifvVTBb59dLozAC0wKOYmcygbTbZNLXdDe
 sK8w==
X-Gm-Message-State: AFq9FYJw8M840DjORFQqUl/i3051H4mfk0/qtkZ3qWoPlrzB12UiV+PZ
 3YTj+h8QhuaBO/xI2PxwJM4zatpC2gaMiSNfjWKTsmbiv5y4ljzM9nyk0usiiwmaRYlkeRuvGgk
 OyG579ZrPe+02yTb0yyGydopED8HIyyymIHB6pNUAK/2vOGL4S/dzFu5HHJok6RBQa7mKUfi0xk
 T7NtPi2fCyhpwOboY8z4USjYkO0tnC158JQyVq9TLLTdQvTYLie42nsYVaeONiEH8zxLlLUq0TR
 aF0EI6l9u0G
X-Gm-Gg: AYBFou0qgxHEXRCpnAw25eW3qdtLYl573LTCI7zPvLeTSWWOC5tPlybFbKiyU43rnaV
 AmhLKLaChQY01PJHQVKVijHah3fqnhxEbeQqISV3JeMrDnyaFkr4i1qV7x9Doku189UfVrBM+F/
 AfmvSZ+8mIxbWDVAEnIFM5VbBxw6tqWpatbKng/T57Wa/WLsvwjL5y6VbVU6jiGhadZN83hCwH6
 w0Q+RKQK8WxzpUazEqbSdUlnovrblP407Y2Hyivn6MO8zPHdbnPSTSR7n43XZFyq/x/81Z6/5HK
 4X5qi0jxXxlrUschNTkclQmAzPXES5iowAGFahJcjPiWwcQ1Up97tTIwucQKupY5mnTf0TxKt8i
 Rckq5YXj5c6KaK4kDDJDHwvJdRyqlaCgQOaHjnVVb1Vj3/SW4q6p4FniLCv7qbcNH7/hNayFhfm
 rtAXiPykDPDV6ic7x4GL+XX/vWqCVbclz7kRCYNjJOhEz8+DP+eA==
X-Received: by 2002:a05:690e:440b:b0:671:70ea:46d3 with SMTP id
 956f58d0204a3-672ed9da9b1mr4047290d50.106.1790641136654; 
 Mon, 28 Sep 2026 17:18:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-6756534a9b1sm54707d50.15.2026.09.28.17.18.56
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:18:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-915b4976f5fso29481816d6.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641135; x=1791245935; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P3wkS1QGh1d3ttV0mLmdV1AsVNkdKRvrlOKHjbJdiME=;
 b=INkZAwBZdmhfEnsQxhJZJa+LKwcfL6tASU+vi2A64n4pi5YQGOG5eGGgn7cofq+eF9
 Hy0/Ec4c5URYpi7oJVOQVhhm+EXeC2eMP/V7P7bfila/ORacH/7ZVGivgvMCgrDvBR6y
 /P1dSdMm2xwwOUZReo+y5VlvjgYhkO4ZgPdx4=
X-Received: by 2002:ad4:5748:0:b0:914:4c70:f513 with SMTP id
 6a1803df08f44-9144c70f8eemr151404476d6.2.1790641135644; 
 Mon, 28 Sep 2026 17:18:55 -0700 (PDT)
X-Received: by 2002:ad4:5748:0:b0:914:4c70:f513 with SMTP id
 6a1803df08f44-9144c70f8eemr151404096d6.2.1790641135036; 
 Mon, 28 Sep 2026 17:18:55 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430e281a8sm91735706d6.33.2026.09.28.17.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:18:53 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: remove VMDq support
Date: Mon, 28 Sep 2026 18:21:53 -0600
Message-ID: <20260929002153.1208331-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921030811.1034869-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260921030811.1034869-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

Remove support for the VMDq feature from the driver: the multi-pool
Rx-queue configuration path in bnxt_mq_rx_configure(), the VMDQ VLAN
pool wiring in the L2 filter alloc path, and the max_vmdq_pools/
vmdq_queue_num reporting in dev_info (now always reported as 0).

bnxt_mq_rx_configure() validates dev_conf->rxmode.mq_mode explicitly:
RTE_ETH_MQ_RX_NONE and RTE_ETH_MQ_RX_RSS are handled (the latter via
the existing rx_cosq_cnt-based pool count for multi-COS RSS), and any
other mode is rejected with -EINVAL rather than falling through.

The per-non-default-VNIC skip_filter_allocation guard in the same
function, and the RTE_ETH_VMDQ_ACCEPT_HASH_UC/BROADCAST/MULTICAST ->
l2_rx_mask flag mapping in rte_pmd_bnxt_set_vf_rxmode(), are both
unrelated to VMDq pools and kept as-is: the former is used by the
plain multi-COS RSS path, and the latter -- despite the name -- is
the standard DPDK VF-rxmode API used regardless of hardware VMDq
pool support.

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
* Explicitly reject any dev_conf->rxmode.mq_mode value
  bnxt_mq_rx_configure() doesn't handle, instead of silently falling
  through. Stephen Hemminger noted this validation was lost along
  with VMDq support's own mq_mode switch cases.

 doc/guides/nics/features/bnxt.ini |  1 -
 drivers/net/bnxt/bnxt_ethdev.c    | 27 ++------------
 drivers/net/bnxt/bnxt_hwrm.c      | 17 ---------
 drivers/net/bnxt/bnxt_rxq.c       | 58 +++++++------------------------
 drivers/net/bnxt/rte_pmd_bnxt.c   |  1 -
 5 files changed, 14 insertions(+), 90 deletions(-)

diff --git a/doc/guides/nics/features/bnxt.ini b/doc/guides/nics/features/bnxt.ini
index f632de135a..447cb178b5 100644
--- a/doc/guides/nics/features/bnxt.ini
+++ b/doc/guides/nics/features/bnxt.ini
@@ -26,7 +26,6 @@ RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
 Inner RSS            = Y
-VMDq                 = Y
 SR-IOV               = Y
 VLAN filter          = Y
 Flow control         = Y
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 4d4349457c..afb00cda43 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1169,7 +1169,6 @@ static int bnxt_dev_info_get_op(struct rte_eth_dev *eth_dev,
 {
 	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pdev);
 	struct bnxt *bp = eth_dev->data->dev_private;
-	uint16_t max_vnics, i, j, vpool, vrxq;
 	unsigned int max_rx_rings;
 	int rc;
 
@@ -1191,7 +1190,6 @@ static int bnxt_dev_info_get_op(struct rte_eth_dev *eth_dev,
 	dev_info->max_tx_queues = max_rx_rings;
 	dev_info->reta_size = bnxt_rss_hash_tbl_size(bp);
 	dev_info->hash_key_size = HW_HASH_KEY_SIZE;
-	max_vnics = bp->max_vnics;
 
 	/* MTU specifics */
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
@@ -1254,29 +1252,8 @@ static int bnxt_dev_info_get_op(struct rte_eth_dev *eth_dev,
 	 * TODO: default_rxconf, default_txconf, rx_desc_lim, and tx_desc_lim
 	 *       need further investigation.
 	 */
-
-	/* VMDq resources */
-	vpool = 64; /* RTE_ETH_64_POOLS */
-	vrxq = 128; /* RTE_ETH_VMDQ_DCB_NUM_QUEUES */
-	for (i = 0; i < 4; vpool >>= 1, i++) {
-		if (max_vnics > vpool) {
-			for (j = 0; j < 5; vrxq >>= 1, j++) {
-				if (dev_info->max_rx_queues > vrxq) {
-					if (vpool > vrxq)
-						vpool = vrxq;
-					goto found;
-				}
-			}
-			/* Not enough resources to support VMDq */
-			break;
-		}
-	}
-	/* Not enough resources to support VMDq */
-	vpool = 0;
-	vrxq = 0;
-found:
-	dev_info->max_vmdq_pools = vpool;
-	dev_info->vmdq_queue_num = vrxq;
+	dev_info->max_vmdq_pools = 0;
+	dev_info->vmdq_queue_num = 0;
 
 	dev_info->vmdq_pool_base = 0;
 	dev_info->vmdq_queue_base = 0;
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 1615b36aae..beb1fa1390 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -892,24 +892,7 @@ int bnxt_hwrm_set_l2_filter(struct bnxt *bp,
 	int rc = 0;
 	struct hwrm_cfa_l2_filter_alloc_input req = {.req_type = 0 };
 	struct hwrm_cfa_l2_filter_alloc_output *resp = bp->hwrm_cmd_resp_addr;
-	struct rte_eth_conf *dev_conf = &bp->eth_dev->data->dev_conf;
-	const struct rte_eth_vmdq_rx_conf *conf =
-		    &dev_conf->rx_adv_conf.vmdq_rx_conf;
 	uint32_t enables = 0;
-	uint16_t j = dst_id - 1;
-
-	//TODO: Is there a better way to add VLANs to each VNIC in case of VMDQ
-	if ((dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) &&
-	    conf->pool_map[j].pools & (1UL << j)) {
-		PMD_DRV_LOG_LINE(DEBUG,
-			"Add vlan %u to vmdq pool %u",
-			conf->pool_map[j].vlan_id, j);
-
-		filter->l2_ivlan = conf->pool_map[j].vlan_id;
-		filter->enables |=
-			HWRM_CFA_L2_FILTER_ALLOC_INPUT_ENABLES_L2_IVLAN |
-			HWRM_CFA_L2_FILTER_ALLOC_INPUT_ENABLES_L2_IVLAN_MASK;
-	}
 
 	if (filter->fw_l2_filter_id != UINT64_MAX)
 		bnxt_hwrm_clear_l2_filter(bp, filter);
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index ea3cdffbc0..b0a1e1a714 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -76,50 +76,25 @@ int bnxt_mq_rx_configure(struct bnxt *bp)
 {
 	struct rte_eth_conf *dev_conf = &bp->eth_dev->data->dev_conf;
 	struct rte_eth_rss_conf *rss = &bp->rss_conf;
-	const struct rte_eth_vmdq_rx_conf *conf =
-		    &dev_conf->rx_adv_conf.vmdq_rx_conf;
 	unsigned int i, j, nb_q_per_grp = 1, ring_idx = 0;
 	int start_grp_id, end_grp_id = 1, rc = 0;
 	struct bnxt_vnic_info *vnic;
 	struct bnxt_filter_info *filter;
-	enum rte_eth_nb_pools pools = 1, max_pools = 0;
+	enum rte_eth_nb_pools pools = 1;
 	struct bnxt_rx_queue *rxq;
 
 	bp->nr_vnics = 0;
 
 	/* Multi-queue mode */
-	if (dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_DCB_RSS) {
-		/* VMDq ONLY, VMDq+RSS, VMDq+DCB, VMDq+DCB+RSS */
-
-		switch (dev_conf->rxmode.mq_mode) {
-		case RTE_ETH_MQ_RX_VMDQ_RSS:
-		case RTE_ETH_MQ_RX_VMDQ_ONLY:
-		case RTE_ETH_MQ_RX_VMDQ_DCB_RSS:
-			/* FALLTHROUGH */
-			/* ETH_8/64_POOLs */
-			pools = conf->nb_queue_pools;
-			/* For each pool, allocate MACVLAN CFA rule & VNIC */
-			max_pools = RTE_MIN(bp->max_vnics,
-					    RTE_MIN(bp->max_l2_ctx,
-					    RTE_MIN(bp->max_rsscos_ctx,
-						    RTE_ETH_64_POOLS)));
-			PMD_DRV_LOG_LINE(DEBUG,
-				    "pools = %u max_pools = %u",
-				    pools, max_pools);
-			if (pools > max_pools)
-				pools = max_pools;
-			break;
-		case RTE_ETH_MQ_RX_RSS:
-			pools = bp->rx_cosq_cnt ? bp->rx_cosq_cnt : 1;
-			break;
-		default:
-			PMD_DRV_LOG_LINE(ERR, "Unsupported mq_mod %d",
-				dev_conf->rxmode.mq_mode);
-			rc = -EINVAL;
-			goto err_out;
-		}
-	} else if (!dev_conf->rxmode.mq_mode) {
+	switch (dev_conf->rxmode.mq_mode) {
+	case RTE_ETH_MQ_RX_NONE:
+	case RTE_ETH_MQ_RX_RSS:
 		pools = bp->rx_cosq_cnt ? bp->rx_cosq_cnt : pools;
+		break;
+	default:
+		PMD_DRV_LOG_LINE(ERR, "Unsupported mq_mode %d",
+				 dev_conf->rxmode.mq_mode);
+		return -EINVAL;
 	}
 
 	pools = RTE_MIN(pools, bp->rx_cp_nr_rings);
@@ -141,19 +116,13 @@ int bnxt_mq_rx_configure(struct bnxt *bp)
 				    "rxq[%d] = %p vnic[%d] = %p",
 				    ring_idx, rxq, i, vnic);
 		}
-		if (i == 0) {
-			if (dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_DCB) {
-				bp->eth_dev->data->promiscuous = 1;
-				vnic->flags |= BNXT_VNIC_INFO_PROMISC;
-			}
+		if (i == 0)
 			vnic->func_default = true;
-		}
 		vnic->start_grp_id = start_grp_id;
 		vnic->end_grp_id = end_grp_id;
 
 		if (i) {
-			if (dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_DCB ||
-			    !(dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS))
+			if (!(dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS))
 				vnic->rss_dflt_cr = true;
 			goto skip_filter_allocation;
 		}
@@ -165,10 +134,7 @@ int bnxt_mq_rx_configure(struct bnxt *bp)
 		}
 		filter->mac_index = 0;
 		filter->flags |= HWRM_CFA_L2_FILTER_ALLOC_INPUT_FLAGS_OUTERMOST;
-		/*
-		 * TODO: Configure & associate CFA rule for
-		 * each VNIC for each VMDq with MACVLAN, MACVLAN+TC
-		 */
+
 		STAILQ_INSERT_TAIL(&vnic->filter, filter, next);
 
 skip_filter_allocation:
diff --git a/drivers/net/bnxt/rte_pmd_bnxt.c b/drivers/net/bnxt/rte_pmd_bnxt.c
index 4974e390e7..a0ce89fca9 100644
--- a/drivers/net/bnxt/rte_pmd_bnxt.c
+++ b/drivers/net/bnxt/rte_pmd_bnxt.c
@@ -435,7 +435,6 @@ int rte_pmd_bnxt_set_vf_rxmode(uint16_t port, uint16_t vf,
 		return -ENOTSUP;
 	}
 
-	/* Is this really the correct mapping?  VFd seems to think it is. */
 	if (rx_mask & RTE_ETH_VMDQ_ACCEPT_HASH_UC)
 		flag |= BNXT_VNIC_INFO_PROMISC;
 
-- 
2.47.3

