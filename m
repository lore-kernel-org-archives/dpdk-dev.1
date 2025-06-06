Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A447DC61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:10:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C69BD40E1C;
	Fri,  6 Jun 2025 19:09:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BF2A140DCB
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749229789; x=1780765789;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tcYxfvcUkFMm4ORn4Jkshprcjf3cZ4n/2rFUpWFB/Oc=;
 b=NFQK1F5Lb7Lt8VhBh5UwzR9wsXFaT1IsHP1BPyofcQEMkpawwkfjHLlz
 iJMLJenXxsADmCFcL7ZE/zpvmn7n/LEs1FAj0TwOEaUQy/q9sU50LMBQV
 SASmep6vD055Hj81BsrS7tJcUMfP+f80vJwMtsmpfENa4teAt47B37R2D
 Dm5UxDuFKWjviWvf0Aw7SD94/lQ6NKYEmZrnqjGEsCLrTP6WcIUnh/LSw
 50JroVT75lc30lMDhU0mpWVITD8/RqnC/+Q6Cvt2p/yVDSD2lBSEINsGm
 nMZXohIWOi88Pl6HlrMg6q8FGlNN8FcGVt/6wM8h9vaeJMAmuqatxu2d8 g==;
X-CSE-ConnectionGUID: 4gWPjF9NSwK/TZMYxM1B+g==
X-CSE-MsgGUID: mmqRFMhSTOOnvf+s0hf8qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68828426"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68828426"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:09:48 -0700
X-CSE-ConnectionGUID: 9LMj0qMUTxueIDxv6CT8VQ==
X-CSE-MsgGUID: DbiVXCbrRAONggAQ5kwGKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="145808178"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 10:09:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 12/34] net/ixgbe: make context desc creation non-static
Date: Fri,  6 Jun 2025 18:08:51 +0100
Message-ID: <a83990ed1b856c34ed546d4ca77f9e8f8c202051.1749229650.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
References: 
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

We will need this function in multiple files, so make it non-static.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v5:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 3 +--
 drivers/net/intel/ixgbe/ixgbe_rxtx.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 77d0555fae..fad4a01a10 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -89,7 +89,6 @@
 
 /* forward-declare some functions */
 static int ixgbe_is_vf(struct rte_eth_dev *dev);
-static int ixgbe_write_default_ctx_desc(struct ci_tx_queue *txq, struct rte_mempool *mp, bool vec);
 
 /*********************************************************************
  *
@@ -2374,7 +2373,7 @@ ixgbe_recv_pkts_lro_bulk_alloc(void *rx_queue, struct rte_mbuf **rx_pkts,
  *
  **********************************************************************/
 
-static inline int
+int
 ixgbe_write_default_ctx_desc(struct ci_tx_queue *txq, struct rte_mempool *mp, bool vec)
 {
 	volatile struct ixgbe_adv_tx_context_desc *ctx_txd;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index bcd5db87e8..102c3c0b6d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -233,6 +233,7 @@ int ixgbe_dev_tx_done_cleanup(void *tx_queue, uint32_t free_cnt);
 extern const uint32_t ptype_table[IXGBE_PACKET_TYPE_MAX];
 extern const uint32_t ptype_table_tn[IXGBE_PACKET_TYPE_TN_MAX];
 
+int ixgbe_write_default_ctx_desc(struct ci_tx_queue *txq, struct rte_mempool *mp, bool vec);
 uint16_t ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
 void ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs);
-- 
2.47.1

