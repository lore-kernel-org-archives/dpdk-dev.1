Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC8ECA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 10:00:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05A59402A2;
	Mon,  1 Sep 2025 12:00:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 141FF4028B
 for <dev@dpdk.org>; Mon,  1 Sep 2025 12:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756720809; x=1788256809;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ENGsbrLC0n/bvpXfF7F3H7qqL4jgxt+lBesEb41eZVs=;
 b=kMHF/+I1V7RcYhqmaSXnvzRPZXYk8DpNR3VvENc33ncmMvCKUqn0y12O
 zk0iUN0SJOgwuUMqe3Mt8CR0KKb4tqHXojIbhAAdjvgqh8IMfBgOayEXf
 ODd9kqNyJnKfdJWwQ0bA08CM+zr0WiP9lu2a2LB5xXSaV+44HvDDWZ7u8
 F8y0oPEQGdmXeGFtFrixsvWnN7PfiHv148fFyv0tTTNG3P8GmBUzXA2im
 ZtFvP1iPQTb2gNY8B6ZwTmBueHnQARR7P54+yljVkeSmB1D3dNI9vgbDH
 WvdGV7KXnaqehG2q+qEykqeITHExxsuMiuXOlaim5as9oWMeIGhUzic5b A==;
X-CSE-ConnectionGUID: FF9ZcDVOT+m/yChYw/tl6g==
X-CSE-MsgGUID: iNAb26CoTVmPcXE8uzhMqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="58674091"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="58674091"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 03:00:08 -0700
X-CSE-ConnectionGUID: 9Osx4slDQmyrgSOLbRP7kQ==
X-CSE-MsgGUID: Lo8Hx1nuSwSGPeCDrpFF+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="170528925"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa009.jf.intel.com with ESMTP; 01 Sep 2025 03:00:08 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/i40e: fix supported offloads for Rx vector path
Date: Mon,  1 Sep 2025 09:59:53 +0000
Message-Id: <20250901095953.1858938-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

The set of supported Rx offloads in the vector path had been defined as
those supported by the scalar path. This was incorrect so define a new
list of supported offloads for the vector path. The list is the same
as the scalar path except it excludes vlan extend and qinq strip.

Fixes: 052ae311091c ("net/i40e: use the common Rx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 5d5d4e08b0..1f210dfdff 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -80,7 +80,16 @@ enum i40e_header_split_mode {
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
-#define I40E_RX_VECTOR_OFFLOADS I40E_RX_SCALAR_OFFLOADS
+#define I40E_RX_VECTOR_OFFLOADS (			\
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
+		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+		RTE_ETH_RX_OFFLOAD_KEEP_CRC |		\
+		RTE_ETH_RX_OFFLOAD_SCATTER |		\
+		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
+		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
 /** Offload features */
 union i40e_tx_offload {
-- 
2.34.1

