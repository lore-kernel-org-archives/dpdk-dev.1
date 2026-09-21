Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00D7C982DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:05:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12391410ED;
	Mon, 21 Sep 2026 05:05:21 +0200 (CEST)
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com
 [209.85.210.100])
 by mails.dpdk.org (Postfix) with ESMTP id 2B7DE40EE1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 05:05:19 +0200 (CEST)
Received: by mail-ot1-f100.google.com with SMTP id
 46e09a7af769-7f4e729368fso1757086a34.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789959918; x=1790564718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CXhMyCvnnnbk4h28bWg5Ul7UkmB+or/+VaB2uiuWWeI=;
 b=vlemtquo7tkG8UBFGl4+KmpytuvNRNxBAB8GibbkaQByw+pxlVExvSQfg3QRvP7mB9
 bFnxUEhgQ/KavXw5/dp/7SYqOIX4hZYewsEeaPtqVPU+ANluyYYn4kqhkcgUBYTXfas7
 //XKaQwdY5UudshGqtxQ6Mv/OaS34XFHoExOpFQiU8uFUl7P8S6VB3UIgMdXBdQA2HC+
 BdccmBH79bMmGr9dy9iSXaQb3aUmRu4ss3XRkcYkGRJxNzTQejVKFfI334840eZBpn27
 13i7Qo9ozCoEZsq+TV794za+dPGw0JqtCNG+8rtRgEfuU91NeNl79sRMkmrOfP3i4Sv9
 WZDA==
X-Gm-Message-State: AFuF++mhtwOF4mtdNdp7JC3OEDIHtndON1yY9lKMUYvVaD0A/Tt5h7Ma
 82OimQl4EWk7LqvFeLu9IFvH5NhjZPMRg+twNwJiJ7hgTjNWDcujjrhIrGKs3Cj1BAjVp+rnZFT
 XE4zKHAtHh5IZHVu0zfQJqG9RbDrVbPCqfmMUd8ycI51z8wYN5uWSL4F2hXlqangKuZRegfvYMh
 X5l3AhNtlY8CPQZoY0KeB79DVqtux4eblC7YycjD1W0AIqhqmhH2Oapuod8p7ZiBHzl6u+1kSj/
 f7A5aEcWwlp
X-Gm-Gg: AYBFou3/B+RSqC+cQVE/PYvHU1xQj+Dc6uy8eaAEEIOrag2M6UT55mMlsYrvynZJF8L
 zmXUA4kKbIUWqxtTqSngwTTBNsIFSKFT5Dr/nsY4GD5Qqmu+9zBrzMDauevvVIvPnEdKBYLhAxp
 RyE49oDcIlIgmNwSlEWXRxRIA1lDYyGFLkxK6e5yz7UYNkwX9kdtAe4NzL5zj12kAxM0pDIuQTx
 Wtgluhw+HrbGJt7FDJu521o0fWRjxmwnZTNwOggO5x53v8R+0IMlEehZJ5REICGTlGRJVjpvXA5
 vPK0YLQ1Nidrd4RT5xQR/105MaSPTDpyOp+sqTlUh/dBmfSFWaBvi3nJ51RSAXVBbISaXnRy8FX
 6LnEmhbbcCC3fRJRUWOWdn4CUOMM/znL5qHKRvuHMTxxqt6xZNz3gFLZFEmLYKqWK118DaNzV32
 KxHXFMjgmMwzgh0CWlLwoqhnlo+Aw8pq5HyRNYej6kM8UAWYt4UQnB
X-Received: by 2002:a05:6830:6b05:b0:805:9b28:87d7 with SMTP id
 46e09a7af769-80de064ee29mr9036769a34.8.1789959918335; 
 Sun, 20 Sep 2026 20:05:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-8107dd8c125sm3677584a34.7.2026.09.20.20.05.17
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 20:05:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-530e0cb072eso42402251cf.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789959917; x=1790564717; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CXhMyCvnnnbk4h28bWg5Ul7UkmB+or/+VaB2uiuWWeI=;
 b=dlArAB1DfqjMvG8qNI9rjwwB/2HySz7fHIKF6P7AA1cSAZM5weVUK+DrCR5O9oBO8b
 UBpsYn9pUxEv1rEumw1bCMu3pzhCb4UmLM1dMObc8/qrYhyq8+IF0lYGZxGjIP7LLdvx
 adTbWpv2s+xON57EApRFlNB2bxf3+gSJzMYjI=
X-Received: by 2002:a05:622a:1314:b0:530:f67d:83ea with SMTP id
 d75a77b69052e-532b71af0admr82278741cf.11.1789959916945; 
 Sun, 20 Sep 2026 20:05:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1314:b0:530:f67d:83ea with SMTP id
 d75a77b69052e-532b71af0admr82278361cf.11.1789959916362; 
 Sun, 20 Sep 2026 20:05:16 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532ae5eefffsm53378871cf.10.2026.09.20.20.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 20:05:15 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: remove VMDq support
Date: Sun, 20 Sep 2026 21:08:11 -0600
Message-ID: <20260921030811.1034869-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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

Preserved two pieces of logic that live in the same
function/switch statement but are not VMDq-pool-specific: the
RTE_ETH_MQ_RX_RSS pools=rx_cosq_cnt case and the
per-non-default-VNIC skip_filter_allocation guard in
bnxt_mq_rx_configure(), both used by the plain multi-COS RSS path.
Also kept the RTE_ETH_VMDQ_ACCEPT_HASH_UC/BROADCAST/MULTICAST ->
l2_rx_mask flag mapping in rte_pmd_bnxt_set_vf_rxmode(): despite the
name, those bits are the standard DPDK VF-rxmode API used regardless
of hardware VMDq pool support, not a VMDq-pool-specific control.

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 doc/guides/nics/features/bnxt.ini      |  1 -
 doc/guides/rel_notes/release_26_11.rst |  3 ++
 drivers/net/bnxt/bnxt_ethdev.c         | 27 +------------
 drivers/net/bnxt/bnxt_hwrm.c           | 17 ---------
 drivers/net/bnxt/bnxt_rxq.c            | 53 +++-----------------------
 drivers/net/bnxt/rte_pmd_bnxt.c        |  1 -
 6 files changed, 11 insertions(+), 91 deletions(-)

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
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..55e9461b86 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,6 +68,9 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* net/bnxt: Removed VMDq support. ``max_vmdq_pools`` and
+  ``vmdq_queue_num`` are now always reported as 0 in ``dev_info``.
+
 * Removed deprecated symbols:
 
   * eal: ``__rte_packed``
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 8e8ead8f61..0be6241570 100644
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
index 023cb0e174..3f50923043 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -76,51 +76,19 @@ int bnxt_mq_rx_configure(struct bnxt *bp)
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
+	if (!dev_conf->rxmode.mq_mode ||
+	    dev_conf->rxmode.mq_mode == RTE_ETH_MQ_RX_RSS)
 		pools = bp->rx_cosq_cnt ? bp->rx_cosq_cnt : pools;
-	}
 
 	pools = RTE_MIN(pools, bp->rx_cp_nr_rings);
 	nb_q_per_grp = bp->rx_cp_nr_rings / pools;
@@ -146,19 +114,13 @@ int bnxt_mq_rx_configure(struct bnxt *bp)
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
@@ -170,10 +132,7 @@ int bnxt_mq_rx_configure(struct bnxt *bp)
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

