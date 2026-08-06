Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5BAC56203
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 08:27:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC39340647;
	Thu,  6 Aug 2026 10:27:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2204840262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 10:27:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786004866; x=1817540866;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rp8zHbHU6SmQPakPTBnb5bp/xSf+aMsRS2fG5nWlEGI=;
 b=B/RGWFMrYwJuPuXxB5qMq7/x3YHoUxpgK5pV/+3swanFoXYgYFkDT0+H
 vIQuU2sB0cLgtNu4OV/FVAzxwhFsd3ypowj62ng1wnqj/rTcMbnRZnRoE
 vTOPkXbrf58j+mijSg0+ItL1V3GAdSYQpAmfiXgiIC0pWZUTmeu3sjeLv
 tL3dSvpdQhveLNN1y75SUSsDWzdesM6GzoVpMlz0tXh5AcwTBISL9wVmY
 mGRqxOHKzwIBLHC8eNSDyYydvmhlhRVHGBDcCNxoFFHe3j0bxiv0/ggqu
 /iIYwJIwgX+Eb7P2Gqx2YGzgpiGrwkZoFSX0d69yJt1/HFwl71nRuBJNE g==;
X-CSE-ConnectionGUID: sG5Sk0BHTG2w+Iw+eLv/dA==
X-CSE-MsgGUID: uoGZ8YPjSlKEqWSVqRub/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86666973"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86666973"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 01:27:45 -0700
X-CSE-ConnectionGUID: YjlO6Bi3QYWzFCdM6n+9FA==
X-CSE-MsgGUID: Ntqonm2WQeiXcA6qFk5j3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="259420996"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 06 Aug 2026 01:27:43 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 1/5] net/iavf: discard empty AdminQ descriptors on reset
Date: Thu,  6 Aug 2026 08:26:24 +0000
Message-Id: <3953e3a3dc6850268abbac704bbfe0be31020e4a.1786004043.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786004043.git.anurag.mandal@intel.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
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

During PF-initiated resets iavf_clean_arq_element() has been observed
to return success with a fully zeroed descriptor (opcode 0).
These fell through to the default arm of the dispatch switch and
produced a "Request 0 is not supported yet" log flood in the field.

Skip descriptors with opcode 0 so they are silently discarded and do not
flood log.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index f346837bf1..56918ebcc1 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -614,6 +614,19 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 			break;
 		}
 		aq_opc = rte_le_to_cpu_16(info.desc.opcode);
+
+		/*
+		 * During PF-initiated resets, iavf_clean_arq_element() has
+		 * been observed to return IAVF_SUCCESS with a fully zeroed
+		 * descriptor (opcode 0).
+		 * Without this guard, such descriptors would fall through
+		 * to the default case of the dispatch switch below and the
+		 * "Request 0 is not supported yet" log flood reported in
+		 * the field would be produced. These are discarded now.
+		 */
+		if (aq_opc == 0)
+			continue;
+
 		/* For the message sent from pf to vf, opcode is stored in
 		 * cookie_high of struct iavf_aq_desc, while return error code
 		 * are stored in cookie_low, Which is done by PF driver.
-- 
2.34.1

