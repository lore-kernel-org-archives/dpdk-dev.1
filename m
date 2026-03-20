Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF4108B8F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 11:15:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADFC1402B2;
	Fri, 20 Mar 2026 12:15:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 85ADF40272;
 Fri, 20 Mar 2026 12:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774005329; x=1805541329;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=p4c4yRSHk9MDNgtCwCdmFY3AFqH/Q0c306RFIt6Ey88=;
 b=Vc6J8GA56V0u5EyoRVkqyVEVdyOkgd5o6Ri2NeQ+p1HhSHB/2e0BVTW2
 suRoXshh7Y8+1cH9oDqScYGFukPo9bffWBE40bqtH+bk84H9sTALg2qHi
 5loQNExfBEfYlj/mxTGswvlTzjjp+Xq/XS0YxsHlg5ojq+XchuLIMxAvU
 j2W3nxmcZ6czkyD8iWYzi2cGji9qPGCmB188oVIzZbvoyZgIBu+g3xia7
 nYH3IqyQA+so3SaoSs0xsKUgx3mriEPEiM9CTM7ZpmKCaZT0BZIqIkJYs
 RzDO6ICNjqWaZ2VUeLB3NoA3RZK42rcElUIMLol64iGmkCaGHA9Y2JM1H w==;
X-CSE-ConnectionGUID: JjG0wt/HQcaMIrnVLH67bw==
X-CSE-MsgGUID: NAy1ZldQQnmbRJ5ZJJ/Vag==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="92475042"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="92475042"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 04:15:28 -0700
X-CSE-ConnectionGUID: 6PrMWVa/RK21WJMQc+jsRA==
X-CSE-MsgGUID: 4b4f0SyuRbKOcxw5xzdJvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="218622925"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa006.fm.intel.com with ESMTP; 20 Mar 2026 04:15:26 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/i40e: fix simple Tx prepare rejecting tunnel type flags
Date: Fri, 20 Mar 2026 11:14:59 +0000
Message-ID: <20260320111459.1396374-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

The tunnel type bits in ol_flags (RTE_MBUF_F_TX_TUNNEL_*) identify
the encapsulation protocol used by a packet. An application may set
these to indicate tunnel type without requesting any tunnel offload.
The simple Tx path was incorrectly treating these flags as unsupported
offload requests and rejecting the packet.

Add RTE_MBUF_F_TX_TUNNEL_MASK to the set of permitted flags in the
simple Tx supported offloads mask to permit tunnel flags in the mbuf.

Bugzilla ID: 1342
Fixes: 146ffa81d05e ("net/i40e: add Tx preparation for simple Tx datapath")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index c5ac75e0f0..a2b351e932 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -74,7 +74,8 @@
 #define I40E_TX_OFFLOAD_SIMPLE_SUP_MASK (RTE_MBUF_F_TX_IPV4 | \
 		RTE_MBUF_F_TX_IPV6 | \
 		RTE_MBUF_F_TX_OUTER_IPV4 | \
-		RTE_MBUF_F_TX_OUTER_IPV6)
+		RTE_MBUF_F_TX_OUTER_IPV6 | \
+		RTE_MBUF_F_TX_TUNNEL_MASK)
 
 #define I40E_TX_OFFLOAD_SIMPLE_NOTSUP_MASK \
 		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ I40E_TX_OFFLOAD_SIMPLE_SUP_MASK)
-- 
2.43.0

