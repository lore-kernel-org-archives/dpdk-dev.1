Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619A6C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 12:51:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A473F40685;
	Fri, 25 Jul 2025 14:50:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1627740661
 for <dev@dpdk.org>; Fri, 25 Jul 2025 14:50:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753447817; x=1784983817;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HJFR6fg7OnLXWVVCuJURKWaVaT/gSVnEyvKJom5w3TY=;
 b=l4cVZzqIngGT4VGe1E/57kYfNobrgVITHyNvfuDxzsLUArZHZfDlgKQa
 grRJfmLXiU2LCpFAKovPYihP/QWL10hH8Pdopk8nU3QsVcDDz5ici5FiZ
 hyglPFvw5s+UGYl1TrKPJDgoG2bX/xdB1DekhGD2uGtxLJbUGEx9tX/ww
 aS7n/NyrRuM0hJaEfLej2aIOXQd1AjBIRSrTzHZNc8vrWwv0Fh0QFd+5d
 EH9BRBF/UMen/GPis5Z38ICApi3nlWnKQotbZITHE6i9vU5G+U1DbnpM4
 nSCEX3Gb5PwNWgmch2nVVEfdWVX7EVIyMBS6WBOHQSmHTkX12AypEcuFS w==;
X-CSE-ConnectionGUID: NcxXgVRlSgSZb759GDv5sg==
X-CSE-MsgGUID: xOpBPQaiQ/6SrnPSQi53NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66480160"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66480160"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 05:50:16 -0700
X-CSE-ConnectionGUID: ratf1i6FRH6E00sbwT/dqQ==
X-CSE-MsgGUID: Ctb2S/O2TkGDapX5pWYMfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161152338"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa007.jf.intel.com with ESMTP; 25 Jul 2025 05:50:16 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 11/14] net/ice: remove unsupported Rx offload
Date: Fri, 25 Jul 2025 12:49:16 +0000
Message-Id: <20250725124919.3564890-12-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725124919.3564890-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
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

The offload RTE_ETH_RX_OFFLOAD_SCTP_CKSUM is not supported in the ice
driver so remove the one erronous use of it.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 9430a99ba5..5529e06a8d 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -71,7 +71,6 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 
 #define ICE_RX_VECTOR_OFFLOAD (				\
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
-		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
 		RTE_ETH_RX_OFFLOAD_VLAN |			\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
-- 
2.34.1

