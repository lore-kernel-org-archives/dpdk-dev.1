Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E6EC87FD3
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 07:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB06E4025D;
	Mon,  4 Aug 2025 09:47:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1C1E4400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 09:47:53 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5745kGjf001461;
 Mon, 4 Aug 2025 00:47:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
 7YXh8/djHzhM1Tle17irzIwiLOhqbi6znXmFZag7Hw=; b=J/qSwzRBdUSki6lgN
 Fm8ARIPzQyNfeW04UcLff+NveNS8ajECaOpbKRfHt+dgVyy9KsesDXmVFIsoboGg
 hQScL8G+gtrazBGZ5pLgTOZgsMYNH+OEeCpy6117oGDVNJCvvhBeO5aHZEyoIYNF
 mRqGkVWZyNbVVMhfdwhxxAuApxTYT/3FA0c7J/mWFIQb26eNw3TE7imPpW9wZqZu
 s7SOq0OSccj99ddfV8H78IPiZJZT9KWKm2/6gs2nW5M06jk/NKaWGmkwgl+j88Ao
 S+cIJ/DDFBYA6D8o/Y0Vj7CfTHqfYFLTKi87A0EUzm1auynuCy/WD/R2TTbxI1Vf
 K2GGg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48aq0hr6ak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Aug 2025 00:47:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 4 Aug 2025 00:47:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 4 Aug 2025 00:47:49 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 82FC15B6937;
 Mon,  4 Aug 2025 00:47:36 -0700 (PDT)
From: <skori@marvell.com>
To: Shepard Siegel <shepard.siegel@atomicrules.com>, Ed Czeck
 <ed.czeck@atomicrules.com>, John Miller <john.miller@atomicrules.com>,
 "Igor Russkikh" <irusskikh@marvell.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, "Sunil Kumar Kori" <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, "Harman Kalra" <hkalra@marvell.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@nxp.com>, John Daley
 <johndale@cisco.com>, "Hyong Youb Kim" <hyonkim@cisco.com>, Dengdui Huang
 <huangdengdui@huawei.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
 Chaoyong He <chaoyong.he@corigine.com>, Jiawen Wu
 <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>,
 Jian Wang <jianwang@trustnetic.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Jochen Behrens <jochen.behrens@broadcom.com>, "Thomas
 Monjalon" <thomas@monjalon.net>
CC: <dev@dpdk.org>, =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 1/2] ethdev: remove unnecessary type conversion
Date: Mon, 4 Aug 2025 13:16:23 +0530
Message-ID: <20250804074733.55145-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512150732.65743-1-skori@marvell.com>
References: <20250512150732.65743-1-skori@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qzm0kdq9HZnWJVTFro-ZElDMUkZOA1C4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0MCBTYWx0ZWRfX/i4cKiW208iL
 agsK0FQ20vi9VbSSkFHMV2LRnvRXNlRiDxmGHaX7wipBlveMI7Bvcx+UlK8wL7+bNWWaXc5U3dl
 +XvwWGNoSj6gMs5VlJIFrxWSPHj5gO88o75x0xByp53PLblHaVAwgveeRWS8QPUdS+6pdvZz9lL
 bKiOGeUrmtEpcgLA5QJ4WME/+HdVv0mUbkusEU1OxAsLf5bso30fRoaCg3QF6YKKdxyM+PDhkEh
 3KXmhr2/9Tg1H9eHJEeV6KmFEVuK0/xeRvEIsZMxR3aoQnqEFqME6qA2B8EpRF1gxvnVOlvLbJU
 zZouIbcQXHNN7ZQMTIDPlOp5x0otKXPtKj6fVvp1THCLvfvDYyfybCrS9Rxje95PL9s10eyrguf
 MKExwCUBWfqUUT7wxBPICnRtBs9xll1bAtdQAl3PBX94+FsOrBJWrOStJn35OLMqIYuQNp2t
X-Authority-Analysis: v=2.4 cv=PMkP+eqC c=1 sm=1 tr=0 ts=689065a5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=n02bokGJAAAA:8
 a=pK7X0mNQAAAA:8 a=BKhrPrD6j7upzqSj918A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=rszdq1ld3peujIA30KyE:22 a=5HA-qpC1VU4iIGLgRoNS:22
X-Proofpoint-GUID: qzm0kdq9HZnWJVTFro-ZElDMUkZOA1C4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
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

From: Sunil Kumar Kori <skori@marvell.com>

As rte_eth_rx_queue_count() returns signed value to represent
the error cases but internally invoked callback is returning
unsigned value. Hence unnecessary type conversion is done.

To avoid this typecasting from signed to unsigned, fixed
return type of callback functions.

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
v2..v3
 - fix build error for intel driver

 drivers/net/ark/ark_ethdev_rx.c        | 2 +-
 drivers/net/ark/ark_ethdev_rx.h        | 2 +-
 drivers/net/atlantic/atl_ethdev.h      | 2 +-
 drivers/net/atlantic/atl_rxtx.c        | 2 +-
 drivers/net/bnxt/bnxt_ethdev.c         | 2 +-
 drivers/net/cnxk/cnxk_ethdev.h         | 2 +-
 drivers/net/cnxk/cnxk_ethdev_ops.c     | 2 +-
 drivers/net/dpaa/dpaa_ethdev.c         | 2 +-
 drivers/net/dpaa2/dpaa2_ethdev.c       | 2 +-
 drivers/net/enic/enic_ethdev.c         | 2 +-
 drivers/net/hns3/hns3_rxtx.c           | 2 +-
 drivers/net/hns3/hns3_rxtx.h           | 2 +-
 drivers/net/intel/e1000/e1000_ethdev.h | 4 ++--
 drivers/net/intel/e1000/em_rxtx.c      | 2 +-
 drivers/net/intel/e1000/igb_rxtx.c     | 2 +-
 drivers/net/intel/e1000/igc_txrx.c     | 2 +-
 drivers/net/intel/e1000/igc_txrx.h     | 2 +-
 drivers/net/intel/fm10k/fm10k.h        | 2 +-
 drivers/net/intel/fm10k/fm10k_rxtx.c   | 2 +-
 drivers/net/intel/i40e/i40e_rxtx.c     | 2 +-
 drivers/net/intel/i40e/i40e_rxtx.h     | 2 +-
 drivers/net/intel/iavf/iavf_rxtx.c     | 2 +-
 drivers/net/intel/iavf/iavf_rxtx.h     | 2 +-
 drivers/net/intel/ice/ice_rxtx.c       | 2 +-
 drivers/net/intel/ice/ice_rxtx.h       | 2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c   | 2 +-
 drivers/net/mlx5/mlx5_rx.c             | 4 ++--
 drivers/net/mlx5/mlx5_rx.h             | 2 +-
 drivers/net/netvsc/hn_rxtx.c           | 2 +-
 drivers/net/netvsc/hn_var.h            | 2 +-
 drivers/net/nfp/nfp_rxtx.c             | 2 +-
 drivers/net/nfp/nfp_rxtx.h             | 2 +-
 drivers/net/ngbe/ngbe_ethdev.h         | 2 +-
 drivers/net/ngbe/ngbe_rxtx.c           | 2 +-
 drivers/net/sfc/sfc_ethdev.c           | 2 +-
 drivers/net/thunderx/nicvf_rxtx.c      | 2 +-
 drivers/net/thunderx/nicvf_rxtx.h      | 2 +-
 drivers/net/txgbe/txgbe_ethdev.h       | 2 +-
 drivers/net/txgbe/txgbe_rxtx.c         | 2 +-
 drivers/net/vhost/rte_eth_vhost.c      | 2 +-
 drivers/net/vmxnet3/vmxnet3_ethdev.h   | 2 +-
 drivers/net/vmxnet3/vmxnet3_rxtx.c     | 2 +-
 lib/ethdev/rte_ethdev.h                | 2 +-
 lib/ethdev/rte_ethdev_core.h           | 2 +-
 45 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 80e431f1ae..2fff0ffded 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -396,7 +396,7 @@ eth_ark_rx_queue_drain(struct ark_rx_queue *queue)
 	}
 }
 
-uint32_t
+int
 eth_ark_dev_rx_queue_count(void *rx_queue)
 {
 	struct ark_rx_queue *queue;
diff --git a/drivers/net/ark/ark_ethdev_rx.h b/drivers/net/ark/ark_ethdev_rx.h
index 2e3400fd2f..12d4f61637 100644
--- a/drivers/net/ark/ark_ethdev_rx.h
+++ b/drivers/net/ark/ark_ethdev_rx.h
@@ -17,7 +17,7 @@ int eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			       unsigned int socket_id,
 			       const struct rte_eth_rxconf *rx_conf,
 			       struct rte_mempool *mp);
-uint32_t eth_ark_dev_rx_queue_count(void *rx_queue);
+int eth_ark_dev_rx_queue_count(void *rx_queue);
 int eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id);
 int eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id);
 uint16_t eth_ark_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
diff --git a/drivers/net/atlantic/atl_ethdev.h b/drivers/net/atlantic/atl_ethdev.h
index ed9ef9f0cc..d2f951c146 100644
--- a/drivers/net/atlantic/atl_ethdev.h
+++ b/drivers/net/atlantic/atl_ethdev.h
@@ -66,7 +66,7 @@ int atl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		uint16_t nb_tx_desc, unsigned int socket_id,
 		const struct rte_eth_txconf *tx_conf);
 
-uint32_t atl_rx_queue_count(void *rx_queue);
+int atl_rx_queue_count(void *rx_queue);
 
 int atl_dev_rx_descriptor_status(void *rx_queue, uint16_t offset);
 int atl_dev_tx_descriptor_status(void *tx_queue, uint16_t offset);
diff --git a/drivers/net/atlantic/atl_rxtx.c b/drivers/net/atlantic/atl_rxtx.c
index 0f367faad5..7b7bf5abbc 100644
--- a/drivers/net/atlantic/atl_rxtx.c
+++ b/drivers/net/atlantic/atl_rxtx.c
@@ -688,7 +688,7 @@ atl_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 
 /* Return Rx queue avail count */
 
-uint32_t
+int
 atl_rx_queue_count(void *rx_queue)
 {
 	struct atl_rx_queue *rxq;
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 8213ff9e4b..cb0d99b9ee 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -3407,7 +3407,7 @@ bnxt_dev_led_off_op(struct rte_eth_dev *dev)
 	return bnxt_hwrm_port_led_cfg(bp, false);
 }
 
-static uint32_t
+static int
 bnxt_rx_queue_count_op(void *rx_queue)
 {
 	struct bnxt *bp;
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 9fb3367422..7868185768 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -705,7 +705,7 @@ void cnxk_nix_txq_info_get(struct rte_eth_dev *eth_dev, uint16_t qid,
 /* Queue status */
 int cnxk_nix_rx_descriptor_status(void *rxq, uint16_t offset);
 int cnxk_nix_tx_descriptor_status(void *txq, uint16_t offset);
-uint32_t cnxk_nix_rx_queue_count(void *rxq);
+int cnxk_nix_rx_queue_count(void *rxq);
 
 /* Lookup configuration */
 const uint32_t *cnxk_nix_supported_ptypes_get(struct rte_eth_dev *eth_dev,
diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 3921c38649..7a8ddb4c9b 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -887,7 +887,7 @@ cnxk_nix_txq_info_get(struct rte_eth_dev *eth_dev, uint16_t qid,
 	memcpy(&qinfo->conf, &txq_sp->qconf.conf.tx, sizeof(qinfo->conf));
 }
 
-uint32_t
+int
 cnxk_nix_rx_queue_count(void *rxq)
 {
 	struct cnxk_eth_rxq_sp *rxq_sp = cnxk_eth_rxq_to_sp(rxq);
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 00b57cb715..02ec501228 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1414,7 +1414,7 @@ int dpaa_eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 }
 
-static uint32_t
+static int
 dpaa_dev_rx_queue_count(void *rx_queue)
 {
 	struct qman_fq *rxq = rx_queue;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 998d1e7c53..24a706c3c7 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1047,7 +1047,7 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	}
 }
 
-static uint32_t
+static int
 dpaa2_dev_rx_queue_count(void *rx_queue)
 {
 	int32_t ret;
diff --git a/drivers/net/enic/enic_ethdev.c b/drivers/net/enic/enic_ethdev.c
index c216994766..749cc9ca5c 100644
--- a/drivers/net/enic/enic_ethdev.c
+++ b/drivers/net/enic/enic_ethdev.c
@@ -258,7 +258,7 @@ static void enicpmd_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	enic_free_rq(rxq);
 }
 
-static uint32_t enicpmd_dev_rx_queue_count(void *rx_queue)
+static int enicpmd_dev_rx_queue_count(void *rx_queue)
 {
 	struct enic *enic;
 	struct vnic_rq *sop_rq;
diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index 785e06db9c..aa7ee6f3e8 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -4856,7 +4856,7 @@ hns3_dev_tx_descriptor_status(void *tx_queue, uint16_t offset)
 		return RTE_ETH_TX_DESC_DONE;
 }
 
-uint32_t
+int
 hns3_rx_queue_count(void *rx_queue)
 {
 	/*
diff --git a/drivers/net/hns3/hns3_rxtx.h b/drivers/net/hns3/hns3_rxtx.h
index b602b2326b..c046ff21ee 100644
--- a/drivers/net/hns3/hns3_rxtx.h
+++ b/drivers/net/hns3/hns3_rxtx.h
@@ -751,7 +751,7 @@ int hns3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
 int hns3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
 			unsigned int socket_id,
 			const struct rte_eth_txconf *conf);
-uint32_t hns3_rx_queue_count(void *rx_queue);
+int hns3_rx_queue_count(void *rx_queue);
 int hns3_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int hns3_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int hns3_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id);
diff --git a/drivers/net/intel/e1000/e1000_ethdev.h b/drivers/net/intel/e1000/e1000_ethdev.h
index 339ae1f4b6..0907c7c259 100644
--- a/drivers/net/intel/e1000/e1000_ethdev.h
+++ b/drivers/net/intel/e1000/e1000_ethdev.h
@@ -414,7 +414,7 @@ int eth_igb_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
-uint32_t eth_igb_rx_queue_count(void *rx_queue);
+int eth_igb_rx_queue_count(void *rx_queue);
 
 int eth_igb_rx_descriptor_status(void *rx_queue, uint16_t offset);
 int eth_igb_tx_descriptor_status(void *tx_queue, uint16_t offset);
@@ -488,7 +488,7 @@ int eth_em_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
-uint32_t eth_em_rx_queue_count(void *rx_queue);
+int eth_em_rx_queue_count(void *rx_queue);
 
 int eth_em_rx_descriptor_status(void *rx_queue, uint16_t offset);
 int eth_em_tx_descriptor_status(void *tx_queue, uint16_t offset);
diff --git a/drivers/net/intel/e1000/em_rxtx.c b/drivers/net/intel/e1000/em_rxtx.c
index e3d8967a5c..54971fe285 100644
--- a/drivers/net/intel/e1000/em_rxtx.c
+++ b/drivers/net/intel/e1000/em_rxtx.c
@@ -1484,7 +1484,7 @@ eth_em_rx_queue_setup(struct rte_eth_dev *dev,
 	return 0;
 }
 
-uint32_t
+int
 eth_em_rx_queue_count(void *rx_queue)
 {
 #define EM_RXQ_SCAN_INTERVAL 4
diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index b63de2354f..cdd7a3338f 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -1790,7 +1790,7 @@ eth_igb_rx_queue_setup(struct rte_eth_dev *dev,
 	return 0;
 }
 
-uint32_t
+int
 eth_igb_rx_queue_count(void *rx_queue)
 {
 #define IGB_RXQ_SCAN_INTERVAL 4
diff --git a/drivers/net/intel/e1000/igc_txrx.c b/drivers/net/intel/e1000/igc_txrx.c
index 9b2eb343ef..f2a6c34094 100644
--- a/drivers/net/intel/e1000/igc_txrx.c
+++ b/drivers/net/intel/e1000/igc_txrx.c
@@ -667,7 +667,7 @@ void eth_igc_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 		igc_rx_queue_release(dev->data->rx_queues[qid]);
 }
 
-uint32_t eth_igc_rx_queue_count(void *rx_queue)
+int eth_igc_rx_queue_count(void *rx_queue)
 {
 	/**
 	 * Check the DD bit of a rx descriptor of each 4 in a group,
diff --git a/drivers/net/intel/e1000/igc_txrx.h b/drivers/net/intel/e1000/igc_txrx.h
index 1e63ddb5aa..972508dcc0 100644
--- a/drivers/net/intel/e1000/igc_txrx.h
+++ b/drivers/net/intel/e1000/igc_txrx.h
@@ -141,7 +141,7 @@ int eth_igc_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
-uint32_t eth_igc_rx_queue_count(void *rx_queue);
+int eth_igc_rx_queue_count(void *rx_queue);
 
 int eth_igc_rx_descriptor_status(void *rx_queue, uint16_t offset);
 
diff --git a/drivers/net/intel/fm10k/fm10k.h b/drivers/net/intel/fm10k/fm10k.h
index 17a7056c45..0eb32ac0d0 100644
--- a/drivers/net/intel/fm10k/fm10k.h
+++ b/drivers/net/intel/fm10k/fm10k.h
@@ -321,7 +321,7 @@ uint16_t fm10k_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 uint16_t fm10k_recv_scattered_pkts(void *rx_queue,
 		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 
-uint32_t
+int
 fm10k_dev_rx_queue_count(void *rx_queue);
 
 int
diff --git a/drivers/net/intel/fm10k/fm10k_rxtx.c b/drivers/net/intel/fm10k/fm10k_rxtx.c
index 690142b357..d145b8a2cc 100644
--- a/drivers/net/intel/fm10k/fm10k_rxtx.c
+++ b/drivers/net/intel/fm10k/fm10k_rxtx.c
@@ -364,7 +364,7 @@ fm10k_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	return nb_rcv;
 }
 
-uint32_t
+int
 fm10k_dev_rx_queue_count(void *rx_queue)
 {
 #define FM10K_RXQ_SCAN_INTERVAL 4
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index aba3c11ee5..b149a4c127 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2255,7 +2255,7 @@ i40e_rx_queue_release(void *rxq)
 	rte_free(q);
 }
 
-uint32_t
+int
 i40e_dev_rx_queue_count(void *rx_queue)
 {
 #define I40E_RXQ_SCAN_INTERVAL 4
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 984532c507..f4139cb4a3 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -126,7 +126,7 @@ int i40e_tx_done_cleanup(void *txq, uint32_t free_cnt);
 int i40e_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq);
 void i40e_rx_queue_release_mbufs(struct ci_rx_queue *rxq);
 
-uint32_t i40e_dev_rx_queue_count(void *rx_queue);
+int i40e_dev_rx_queue_count(void *rx_queue);
 int i40e_dev_rx_descriptor_status(void *rx_queue, uint16_t offset);
 int i40e_dev_tx_descriptor_status(void *tx_queue, uint16_t offset);
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 7033a74610..249b38d01e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -4391,7 +4391,7 @@ iavf_dev_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 }
 
 /* Get the number of used descriptors of a rx queue */
-uint32_t
+int
 iavf_dev_rxq_count(void *rx_queue)
 {
 #define IAVF_RXQ_SCAN_INTERVAL 4
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 1641bfe59a..fb27be440f 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -516,7 +516,7 @@ void iavf_dev_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			  struct rte_eth_rxq_info *qinfo);
 void iavf_dev_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			  struct rte_eth_txq_info *qinfo);
-uint32_t iavf_dev_rxq_count(void *rx_queue);
+int iavf_dev_rxq_count(void *rx_queue);
 int iavf_dev_rx_desc_status(void *rx_queue, uint16_t offset);
 int iavf_dev_tx_desc_status(void *tx_queue, uint16_t offset);
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index da508592aa..5e72c231f7 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1745,7 +1745,7 @@ ice_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	qinfo->conf.tx_deferred_start = txq->tx_deferred_start;
 }
 
-uint32_t
+int
 ice_rx_queue_count(void *rx_queue)
 {
 #define ICE_RXQ_SCAN_INTERVAL 4
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 0301d05888..53b38da008 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -201,7 +201,7 @@ uint16_t ice_prep_pkts(__rte_unused void *tx_queue, struct rte_mbuf **tx_pkts,
 void ice_set_tx_function_flag(struct rte_eth_dev *dev,
 			      struct ci_tx_queue *txq);
 void ice_set_tx_function(struct rte_eth_dev *dev);
-uint32_t ice_rx_queue_count(void *rx_queue);
+int ice_rx_queue_count(void *rx_queue);
 void ice_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 		      struct rte_eth_rxq_info *qinfo);
 void ice_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 86da9fc89b..5393c81363 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -603,7 +603,7 @@ int  ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		uint16_t nb_tx_desc, unsigned int socket_id,
 		const struct rte_eth_txconf *tx_conf);
 
-uint32_t ixgbe_dev_rx_queue_count(void *rx_queue);
+int ixgbe_dev_rx_queue_count(void *rx_queue);
 
 int ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset);
 int ixgbe_dev_tx_descriptor_status(void *tx_queue, uint16_t offset);
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index bbe665a6ff..c5242c4171 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -3354,7 +3354,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	return 0;
 }
 
-uint32_t
+int
 ixgbe_dev_rx_queue_count(void *rx_queue)
 {
 #define IXGBE_RXQ_SCAN_INTERVAL 4
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 5e8c312d00..271018d6d1 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -73,7 +73,7 @@ mlx5_lro_update_hdr(uint8_t *__rte_restrict padd,
  * @return
  *   The number of used Rx descriptor.
  */
-static uint32_t
+static int
 rx_queue_count(struct mlx5_rxq_data *rxq)
 {
 	struct rxq_zip *zip = &rxq->zip;
@@ -261,7 +261,7 @@ mlx5_rx_burst_mode_get(struct rte_eth_dev *dev,
  *   The number of used rx descriptor.
  *   -EINVAL if the queue is invalid
  */
-uint32_t
+int
 mlx5_rx_queue_count(void *rx_queue)
 {
 	struct mlx5_rxq_data *rxq = rx_queue;
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index 4f3d73e3c4..7be31066a5 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -320,7 +320,7 @@ void mlx5_mprq_buf_free(struct mlx5_mprq_buf *buf);
 uint16_t mlx5_rx_burst_mprq(void *dpdk_rxq, struct rte_mbuf **pkts,
 			    uint16_t pkts_n);
 int mlx5_rx_descriptor_status(void *rx_queue, uint16_t offset);
-uint32_t mlx5_rx_queue_count(void *rx_queue);
+int mlx5_rx_queue_count(void *rx_queue);
 void mlx5_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 		       struct rte_eth_rxq_info *qinfo);
 int mlx5_rx_burst_mode_get(struct rte_eth_dev *dev, uint16_t rx_queue_id,
diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
index c79d971904..769da5b628 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -1056,7 +1056,7 @@ hn_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
  * Get the number of used descriptor in a rx queue
  * For this device that means how many packets are pending in the ring.
  */
-uint32_t
+int
 hn_dev_rx_queue_count(void *rx_queue)
 {
 	struct hn_rx_queue *rxq = rx_queue;
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index f946b3d8ef..3553d84f20 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -220,7 +220,7 @@ int	hn_dev_rx_queue_setup(struct rte_eth_dev *dev,
 void	hn_dev_rx_queue_info(struct rte_eth_dev *dev, uint16_t queue_id,
 			     struct rte_eth_rxq_info *qinfo);
 void	hn_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
-uint32_t hn_dev_rx_queue_count(void *rx_queue);
+int	hn_dev_rx_queue_count(void *rx_queue);
 int	hn_dev_rx_queue_status(void *rxq, uint16_t offset);
 void	hn_dev_free_queues(struct rte_eth_dev *dev);
 
diff --git a/drivers/net/nfp/nfp_rxtx.c b/drivers/net/nfp/nfp_rxtx.c
index c86bba9d87..19c8324549 100644
--- a/drivers/net/nfp/nfp_rxtx.c
+++ b/drivers/net/nfp/nfp_rxtx.c
@@ -202,7 +202,7 @@ nfp_net_rx_freelist_setup(struct rte_eth_dev *dev)
 	return 0;
 }
 
-uint32_t
+int
 nfp_net_rx_queue_count(void *rx_queue)
 {
 	uint32_t idx;
diff --git a/drivers/net/nfp/nfp_rxtx.h b/drivers/net/nfp/nfp_rxtx.h
index cbb6df201f..95c7a85053 100644
--- a/drivers/net/nfp/nfp_rxtx.h
+++ b/drivers/net/nfp/nfp_rxtx.h
@@ -220,7 +220,7 @@ nfp_net_mbuf_alloc_failed(struct nfp_net_rxq *rxq)
 void nfp_net_rx_cksum(struct nfp_net_rxq *rxq, struct nfp_net_rx_desc *rxd,
 		struct rte_mbuf *mb);
 int nfp_net_rx_freelist_setup(struct rte_eth_dev *dev);
-uint32_t nfp_net_rx_queue_count(void *rx_queue);
+int nfp_net_rx_queue_count(void *rx_queue);
 uint16_t nfp_net_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
 void nfp_net_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
diff --git a/drivers/net/ngbe/ngbe_ethdev.h b/drivers/net/ngbe/ngbe_ethdev.h
index faff57ef34..4f8dcff00e 100644
--- a/drivers/net/ngbe/ngbe_ethdev.h
+++ b/drivers/net/ngbe/ngbe_ethdev.h
@@ -206,7 +206,7 @@ int  ngbe_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		uint16_t nb_tx_desc, unsigned int socket_id,
 		const struct rte_eth_txconf *tx_conf);
 
-uint32_t ngbe_dev_rx_queue_count(void *rx_queue);
+int ngbe_dev_rx_queue_count(void *rx_queue);
 
 int ngbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset);
 int ngbe_dev_tx_descriptor_status(void *tx_queue, uint16_t offset);
diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index 3dd268e5bc..95e2172ee4 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -2442,7 +2442,7 @@ ngbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	return 0;
 }
 
-uint32_t
+int
 ngbe_dev_rx_queue_count(void *rx_queue)
 {
 #define NGBE_RXQ_SCAN_INTERVAL 4
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 2122d42847..8b0bf4eeee 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -1505,7 +1505,7 @@ sfc_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t ethdev_qid,
  * The function is used by the secondary process as well. It must not
  * use any process-local pointers from the adapter data.
  */
-static uint32_t
+static int
 sfc_rx_queue_count(void *rx_queue)
 {
 	struct sfc_dp_rxq *dp_rxq = rx_queue;
diff --git a/drivers/net/thunderx/nicvf_rxtx.c b/drivers/net/thunderx/nicvf_rxtx.c
index cab5532417..3992da765a 100644
--- a/drivers/net/thunderx/nicvf_rxtx.c
+++ b/drivers/net/thunderx/nicvf_rxtx.c
@@ -649,7 +649,7 @@ nicvf_recv_pkts_multiseg_cksum_vlan_strip(void *rx_queue,
 			NICVF_RX_OFFLOAD_CKSUM | NICVF_RX_OFFLOAD_VLAN_STRIP);
 }
 
-uint32_t
+int
 nicvf_dev_rx_queue_count(void *rx_queue)
 {
 	struct nicvf_rxq *rxq;
diff --git a/drivers/net/thunderx/nicvf_rxtx.h b/drivers/net/thunderx/nicvf_rxtx.h
index 4b83e33f4d..17e406e6dd 100644
--- a/drivers/net/thunderx/nicvf_rxtx.h
+++ b/drivers/net/thunderx/nicvf_rxtx.h
@@ -83,7 +83,7 @@ nicvf_mbuff_init_mseg_update(struct rte_mbuf *pkt, const uint64_t mbuf_init,
 	*(uint64_t *)(&pkt->rearm_data) = init.value;
 }
 
-uint32_t nicvf_dev_rx_queue_count(void *rx_queue);
+int nicvf_dev_rx_queue_count(void *rx_queue);
 uint32_t nicvf_dev_rbdr_refill(struct rte_eth_dev *dev, uint16_t queue_idx);
 
 uint16_t nicvf_recv_pkts_no_offload(void *rxq, struct rte_mbuf **rx_pkts,
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 9295d8fbd0..23e8348051 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -453,7 +453,7 @@ int  txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		uint16_t nb_tx_desc, unsigned int socket_id,
 		const struct rte_eth_txconf *tx_conf);
 
-uint32_t txgbe_dev_rx_queue_count(void *rx_queue);
+int txgbe_dev_rx_queue_count(void *rx_queue);
 
 int txgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset);
 int txgbe_dev_tx_descriptor_status(void *tx_queue, uint16_t offset);
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index e6f33739c4..ca1e0a38c3 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -2875,7 +2875,7 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	return 0;
 }
 
-uint32_t
+int
 txgbe_dev_rx_queue_count(void *rx_queue)
 {
 #define TXGBE_RXQ_SCAN_INTERVAL 4
diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 44bf2e3241..87c91e2f96 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1407,7 +1407,7 @@ eth_link_update(struct rte_eth_dev *dev __rte_unused,
 	return 0;
 }
 
-static uint32_t
+static int
 eth_rx_queue_count(void *rx_queue)
 {
 	struct vhost_queue *vq;
diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.h b/drivers/net/vmxnet3/vmxnet3_ethdev.h
index fd150d12c5..75dafa664f 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.h
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.h
@@ -212,7 +212,7 @@ int  vmxnet3_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 				const struct rte_eth_rxconf *rx_conf,
 				struct rte_mempool *mb_pool);
 
-uint32_t vmxnet3_dev_rx_queue_count(void *rx_queue);
+int vmxnet3_dev_rx_queue_count(void *rx_queue);
 
 int  vmxnet3_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 				uint16_t nb_tx_desc, unsigned int socket_id,
diff --git a/drivers/net/vmxnet3/vmxnet3_rxtx.c b/drivers/net/vmxnet3/vmxnet3_rxtx.c
index e226641fdf..552b8a9823 100644
--- a/drivers/net/vmxnet3/vmxnet3_rxtx.c
+++ b/drivers/net/vmxnet3/vmxnet3_rxtx.c
@@ -1055,7 +1055,7 @@ vmxnet3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	return nb_rx;
 }
 
-uint32_t
+int
 vmxnet3_dev_rx_queue_count(void *rx_queue)
 {
 	const vmxnet3_rx_queue_t *rxq;
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index f9fb6ae549..4ccb0c62d2 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6404,7 +6404,7 @@ rte_eth_rx_queue_count(uint16_t port_id, uint16_t queue_id)
 
 	if (p->rx_queue_count == NULL)
 		return -ENOTSUP;
-	return (int)p->rx_queue_count(qd);
+	return p->rx_queue_count(qd);
 }
 
 /**@{@name Rx hardware descriptor states
diff --git a/lib/ethdev/rte_ethdev_core.h b/lib/ethdev/rte_ethdev_core.h
index e55fb42996..4ffae4921a 100644
--- a/lib/ethdev/rte_ethdev_core.h
+++ b/lib/ethdev/rte_ethdev_core.h
@@ -45,7 +45,7 @@ typedef uint16_t (*eth_tx_prep_t)(void *txq,
 
 
 /** @internal Get number of used descriptors on a receive queue. */
-typedef uint32_t (*eth_rx_queue_count_t)(void *rxq);
+typedef int (*eth_rx_queue_count_t)(void *rxq);
 
 /** @internal Check the status of a Rx descriptor */
 typedef int (*eth_rx_descriptor_status_t)(void *rxq, uint16_t offset);
-- 
2.43.0

