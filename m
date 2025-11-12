Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB5CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 11:57:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8367B40668;
	Wed, 12 Nov 2025 12:57:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E8B4140281;
 Wed, 12 Nov 2025 12:57:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762948674; x=1794484674;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mh5Hov0F5h7sNkqwni+yNklcAHIxjSJFlk0v2QEPw0E=;
 b=W4re87/9t7KY7XE8vhooYuYwMUfqSj5m/5/JBhhGf+hzxgzEdC65xSnF
 zMaMVogpRsGmYOtu3s/DuWoQRqWNGvCsWIk3H6zYaODAoAvfFqEhdlCIv
 Qf1qz1Cjh5zKpJwYdKz3W/owVCs7a/Smwa0ykZNWfl0M1md8egTUPbgXH
 r7zTM6GxJHWlZAaxwKGQeu9F4wCILyeDW0yhqZPIzZ7LUIcORbWs9ogc7
 Lue5j4FnrXCoBlqFHnBLx4LLEX7KULIk4ZQoTCrspsY67KOpKLTLNrGF6
 UCQT3RwC2DTd+hZKzoI5Yuwp8jJqcKrJh0PQdE4Wolt/K+SI1k7kO1DLT g==;
X-CSE-ConnectionGUID: guxG28t2RH2A97aqFE7Xrg==
X-CSE-MsgGUID: dLztuuiIRYOC0pJneP4wmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64017870"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="64017870"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 03:57:41 -0800
X-CSE-ConnectionGUID: EgNZhCGFQwK/JIznNI8aOw==
X-CSE-MsgGUID: +yn94IY2T/Oz2+sxBEM9Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="189375257"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 12 Nov 2025 03:57:40 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix path selection for QinQ Tx offload
Date: Wed, 12 Nov 2025 11:57:26 +0000
Message-ID: <20251112115726.1286735-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The capabilities flag for the vector offload path include the QinQ
offload capability, but in fact the offload path lacks any ability to
create context descriptors. This means that it cannot insert multiple
vlan tags for QinQ support, so move the offload from the VECTOR_OFFLOAD
list to the NO_VECTOR list. Similarly, remove any check for the QinQ
mbuf flag in any packets being transmitted, since that offload is
invalid to request if the feature is not enabled.

Fixes: 808a17b3c1e6 ("net/ice: add Rx AVX512 offload path")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index a7cc4736cf..62047e9f2f 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -53,6 +53,7 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 
 #define ICE_TX_NO_VECTOR_FLAGS (			\
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		\
+		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
 		RTE_ETH_TX_OFFLOAD_TCP_TSO |	\
 		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |    \
@@ -63,7 +64,6 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 
 #define ICE_TX_VECTOR_OFFLOAD (				\
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |		\
-		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |		\
 		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
 		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
@@ -194,8 +194,8 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
 
 	*txd_hi |= ((uint64_t)td_offset) << ICE_TXD_QW1_OFFSET_S;
 
-	/* Tx VLAN/QINQ insertion Offload */
-	if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
+	/* Tx VLAN insertion Offload */
+	if (ol_flags & RTE_MBUF_F_TX_VLAN) {
 		td_cmd |= ICE_TX_DESC_CMD_IL2TAG1;
 		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
 				ICE_TXD_QW1_L2TAG1_S);
-- 
2.48.1

