Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4CCCCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 11:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81CF64013F;
	Thu,  6 Nov 2025 12:50:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id C442C4029C
 for <dev@dpdk.org>; Thu,  6 Nov 2025 12:50:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762429822; x=1793965822;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OS8jQKPW77FRRVI0TFYVD+r9ToXedJIZr8CkQzb6XLA=;
 b=Nt3kJqi0OA4qLfpj7yhNqQVlVwe7baAR5Pxy54vFvRTBBvy/fLI7WF68
 Y97j7IQNf0R9QZDbuT31lbip6c/ZYKwhahqRisaMVoNnMr3f7e2netWi6
 Xwg6PcNeVrdQf1QadfYd+zLX3pe+NQzpJ8jt9cSWupe1Y7AY8n9+O3pn/
 5d55CftspOIZRe83Ps7ARlzKQ/gJeTw3lX9O4BpADHRjc9kYB+d2WQXqE
 /v/TBW7DL9+d4DS+pGaTdE8iMks45FaH2QdKl7fO776fpt+UtPFpNeWPe
 RjEa6qg9ne60yDofFQmA3dDsLABQvcQCNNCbyK8A9PVX/5uzM33isuv9H Q==;
X-CSE-ConnectionGUID: /rQ3d2KsQKKzFvzxfPkIXA==
X-CSE-MsgGUID: bgILmWDcRPW2qqjrJ6OoXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="52129783"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="52129783"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 03:50:21 -0800
X-CSE-ConnectionGUID: HRepgcuQSH2W85UVeFpzJw==
X-CSE-MsgGUID: KALw4zfLSX+srYqhEqMTtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187898344"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 06 Nov 2025 03:50:20 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 1/6] net/iavf: fix compilation with VLAN insertion disabled
Date: Thu,  6 Nov 2025 11:50:11 +0000
Message-Id: <20251106115016.3035639-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106115016.3035639-1-ciara.loftus@intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251106115016.3035639-1-ciara.loftus@intel.com>
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

If IAVF_TX_VLAN_QINQ_OFFLOAD is undefined there will be an unused
variable warning. Fix this.

Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index f513777663..7bf9dfd372 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -174,6 +174,8 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 	uint32_t td_offset = 0;
 #endif
 
+	RTE_SET_USED(vlan_flag);
+
 #ifdef IAVF_TX_CSUM_OFFLOAD
 	/* Set MACLEN */
 	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
-- 
2.34.1

