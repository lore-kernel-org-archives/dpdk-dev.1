Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C609C02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 11:55:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6215C4064A;
	Wed,  5 Feb 2025 12:55:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 895D2402D0
 for <dev@dpdk.org>; Wed,  5 Feb 2025 12:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738756549; x=1770292549;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NNo+JHpdM7rhrL/ag3GegqYlLk8r/31+sZtowFDSX1Q=;
 b=Z5yp6nH+tZIskvNehogjqAU3DVCRRRqgp755xeRoWl43gxg4UTj00+GR
 udp7Wsj5J/h+j7/GasVRUGolRYWQ8xZmbPRT4UiVnv6IZSJ3OjjMIZCC2
 o1W1lJ02UvD2Lp+MjSCfr0THR5d3A/VzJiqlrJ5XRvaWytKiyBnOHjptW
 qsy5Ha9EziQQu+vtYarmKYX9pZg/AKwWglrLS6NqP/okw71RXbaVDt03K
 aoL5L9f9fC9CNo8WqxcRQehaLLyoCxZcjXe0pNnaQGAxJAg+L6L0W83Og
 /ateBCZOOL/hEUDWPhS85+y4EDYz7IpNcpm2Y1BUVT3aIhBmIKuU1ZYKx Q==;
X-CSE-ConnectionGUID: uoNxpXh1RROwMFFLkd3nOQ==
X-CSE-MsgGUID: ZagHUTqoSOSBdRKE6uzPQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49568727"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="49568727"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 03:55:48 -0800
X-CSE-ConnectionGUID: tmHuo3k2SIW86tiqo8eQSQ==
X-CSE-MsgGUID: 34w8te7NQSC5LedrVIaKNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="141781710"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2025 03:55:46 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v4 2/4] net/idpf: re-enable unused variable warnings
Date: Wed,  5 Feb 2025 11:55:29 +0000
Message-ID: <20250205115533.2746196-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205115533.2746196-1-bruce.richardson@intel.com>
References: <20250128163649.343336-1-bruce.richardson@intel.com>
 <20250205115533.2746196-1-bruce.richardson@intel.com>
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

The idpf driver was being built with warnings disabled for unused
variables. However, while the warning was being disabled in the base
code directory, all suppressed warnings were in the main directory.
Therefore, just remove the unused variables and re-enable the
warnings.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Praveen Shetty <praveen.shetty@intel.com>
---
 drivers/net/intel/idpf/base/meson.build       | 9 ---------
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 2 --
 drivers/net/intel/idpf/idpf_common_virtchnl.c | 4 ++--
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/idpf/base/meson.build b/drivers/net/intel/idpf/base/meson.build
index f30ec7dfc2..7316e0a805 100644
--- a/drivers/net/intel/idpf/base/meson.build
+++ b/drivers/net/intel/idpf/base/meson.build
@@ -5,12 +5,3 @@ sources += files(
         'idpf_controlq.c',
         'idpf_controlq_setup.c',
 )
-
-error_cflags = [
-        '-Wno-unused-variable',
-]
-foreach flag: error_cflags
-    if cc.has_argument(flag)
-        cflags += flag
-    endif
-endforeach
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index a04e54ce26..9b17279181 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1178,7 +1178,6 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
 	struct rte_mbuf *rxm;
 	struct rte_mbuf *nmb;
-	struct rte_eth_dev *dev;
 	const uint32_t *ptype_tbl = rxq->adapter->ptype_tbl;
 	uint16_t rx_id = rxq->rx_tail;
 	uint16_t rx_packet_len;
@@ -1310,7 +1309,6 @@ idpf_xmit_cleanup(struct idpf_tx_queue *txq)
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
-	uint16_t i;
 
 	volatile struct idpf_base_tx_desc *txd = txq->tx_ring;
 
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index de511da788..0ae1d55d79 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -362,7 +362,7 @@ idpf_vc_queue_grps_add(struct idpf_vport *vport,
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_cmd_info args;
-	int size, qg_info_size;
+	int size;
 	int err = -1;
 
 	size = sizeof(*p2p_queue_grps_info) +
@@ -1044,7 +1044,7 @@ int idpf_vc_rxq_config_by_info(struct idpf_vport *vport, struct virtchnl2_rxq_in
 	struct idpf_adapter *adapter = vport->adapter;
 	struct virtchnl2_config_rx_queues *vc_rxqs = NULL;
 	struct idpf_cmd_info args;
-	int size, err, i;
+	int size, err;
 
 	size = sizeof(*vc_rxqs) + (num_qs - 1) *
 		sizeof(struct virtchnl2_rxq_info);
-- 
2.43.0

